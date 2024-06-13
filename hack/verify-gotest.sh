#!/bin/bash

# Copyright 2024 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

cd "$(git rev-parse --show-toplevel)" || exit 1

TMPDIR="$(mktemp -d)"
COVERPROFILEOUT="$TMPDIR/verify-conformance.out"
HTMLOUT="$TMPDIR/verify-conformance.html"
go test -cover -coverprofile="$COVERPROFILEOUT" -v ./...
go tool cover -html "$COVERPROFILEOUT" -o "$HTMLOUT"
echo "wrote: $HTMLOUT ($COVERPROFILEOUT)"