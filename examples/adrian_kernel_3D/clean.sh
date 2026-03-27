#!/usr/bin/env bash
# clean.sh — remove simulation output produced by run.sh and compute_kernels.py
#
# Usage:
#   bash clean.sh            # show what would be removed, ask for confirmation
#   bash clean.sh --dry-run  # show what would be removed, then exit
#   bash clean.sh --yes      # skip confirmation prompt and delete immediately

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DRY_RUN=false
YES=false
for arg in "$@"; do
    case "${arg}" in
        --dry-run) DRY_RUN=true ;;
        --yes)     YES=true ;;
        *)
            echo "Usage: bash clean.sh [--dry-run] [--yes]" >&2
            exit 1
            ;;
    esac
done

# Directories produced by run.sh and compute_kernels.py
TARGETS=(
    "${SCRIPT_DIR}/simu_forward"
    "${SCRIPT_DIR}/simu_backward"
    "${SCRIPT_DIR}/backward_simu_forward"
    "${SCRIPT_DIR}/kernel_output"
)

echo "The following will be removed:"
for target in "${TARGETS[@]}"; do
    if [[ -d "$target" ]]; then
        du -sh "$target" 2>/dev/null || echo "  $target (not found or inaccessible)"
    fi
done

if [[ "$DRY_RUN" == true ]]; then
    echo ""
    echo "(--dry-run: exiting without deleting)"
    exit 0
fi

if [[ "$YES" != true ]]; then
    echo ""
    read -p "Remove these directories? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        exit 0
    fi
fi

echo "Removing..."
for target in "${TARGETS[@]}"; do
    if [[ -d "$target" ]]; then
        rm -rf "$target"
        echo "  Removed: $target"
    fi
done

echo "Clean complete."
