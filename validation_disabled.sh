#!/bin/bash

# script with validation disabled (for exceptional cases)

cd /add/your/path/to/api/directory
# (where gen.go is located)


# Backup original gen.go
cp gen.go gen.go.backup

# Create version with validation disabled
cat > gen.go << 'EOF'
package api

//go:generate protoc -I . -I ../third_party --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative --grpc-gateway_out . --grpc-gateway_opt paths=source_relative --grpc-gateway_opt validate_url_patterns=false --routes_out . --routes_opt paths=source_relative --openapiv2_out ./swagger --openapiv2_opt logtostderr=true --openapiv2_opt allow_merge=true customer.proto myaccount.proto mytenant.proto org-unit.proto org-unit-role.proto org-unit-user.proto register.proto resdef.proto tenant.proto tenant-user.proto user.proto
EOF

echo "Generated modified gen.go with validation disabled"
echo "Now run: cd api/ && go generate or go generate ./..."
echo "To restore: mv gen.go.backup gen.go"