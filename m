Return-Path: <netdev+bounces-20918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 666C5761E59
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2B01C20821
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4424189;
	Tue, 25 Jul 2023 16:22:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA321F173
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:22:26 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DE4E51
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:22:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b700e85950so82793961fa.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690302141; x=1690906941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iycxGCfypLSJPawQ+3euYMrR5WxT7u2zao7sTVMHBo0=;
        b=sHNjyCo38zKPRiNUMcm9uUAt5ikVNMo35AH9pm9vNg3OYzBDEjj+u01Dh9JWTrHpHe
         IopyWWAEZDXfZg5v7L1H6TYtvrBgHnuMJDp7NMyyDkHOj1wd9cXkIy71LT9dHfFfAdNJ
         7O/TNrPGhsdMTEEXfqIbtByXY/oiMlxOK0xMKQuzwPjLrZGcRmmKvyd4cl9OwNqOASVc
         clkh7DK8OLikADGDvkqx8h7TwA0xlyYhryyASGHNjHXYE7BVEW3rL4qWS8pSgfutsP8m
         z26erMw2ILXn/tC7qontO9jSupkmyTFSVhtBkCPzFbjunIGXgsXghnEEMid0z7GQCJzO
         l4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690302141; x=1690906941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iycxGCfypLSJPawQ+3euYMrR5WxT7u2zao7sTVMHBo0=;
        b=ATzucD4dcGGNlHNVPIDg4GN/dEV+S2g3xh5AjNTzNce5tAyvqPm5zNkLZKGmEJzJSn
         VST1EvTcQMrrHDsN2p7y/7JwQy4GSEU0VPgY3gfjpGTJCT/mNe33LJOE1Bwuf0RSLeF9
         cRJpSfynVHSpgM2XgEhBBtge0roc2zhVpXffnpL0FoeDnLbsQE2AklPSzcrT1F1UALuM
         8GkCA4hnNOsNS5mhSVO8cB173mvHGpP5VbC4129gneU1k/cIgZq9QJJwQVtTI9l8mWAL
         hcvJ1LfM8iVc+SNrfTWbYmB9YV+8FBBjL36pijoD3xczB8ghjYRytujmy91xbtvNdPxT
         T8Xw==
X-Gm-Message-State: ABy/qLZmBVpnQN/hfXKpQKx/xX6afD/gAEEgsXAXKQAThwVeLQ0v9w23
	h1Y/Jnv+8ZC7qQlMcR9g1/vF3Vws4gzqG+sB
X-Google-Smtp-Source: APBJJlG7D8xuwMBCUaxV/t+GSQ72FqX7hNTOJF0jIiDeo1xAcEcOyo3BOjwx119jvNxUQfeeZEbyyw==
X-Received: by 2002:a05:651c:20b:b0:2b6:efc7:2aee with SMTP id y11-20020a05651c020b00b002b6efc72aeemr9107836ljn.51.1690302141157;
        Tue, 25 Jul 2023 09:22:21 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:255e:7dc3:bcb1:e213])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c294300b003fc01f7a42dsm13661303wmd.8.2023.07.25.09.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:22:20 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 1/3] doc/netlink: Add a schema for netlink-raw families
Date: Tue, 25 Jul 2023 17:22:03 +0100
Message-ID: <20230725162205.27526-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725162205.27526-1-donald.hunter@gmail.com>
References: <20230725162205.27526-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This schema is largely a copy of the genetlink-legacy schema with the
following additions:

 - a top-level protonum property, e.g. 0 (for NETLINK_ROUTE)
 - add netlink-raw to the list of protocols supported by the schema
 - add an id property to mcast-group definitions

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/netlink-raw.yaml | 414 +++++++++++++++++++++++++
 1 file changed, 414 insertions(+)
 create mode 100644 Documentation/netlink/netlink-raw.yaml

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
new file mode 100644
index 000000000000..34af9c7f94a8
--- /dev/null
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -0,0 +1,414 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+%YAML 1.2
+---
+$id: http://kernel.org/schemas/netlink/genetlink-legacy.yaml#
+$schema: https://json-schema.org/draft-07/schema
+
+# Common defines
+$defs:
+  uint:
+    type: integer
+    minimum: 0
+  len-or-define:
+    type: [ string, integer ]
+    pattern: ^[0-9A-Za-z_]+( - 1)?$
+    minimum: 0
+
+# Schema for specs
+title: Protocol
+description: Specification of a genetlink protocol
+type: object
+required: [ name, doc, attribute-sets, operations ]
+additionalProperties: False
+properties:
+  name:
+    description: Name of the genetlink family.
+    type: string
+  doc:
+    type: string
+  version:
+    description: Generic Netlink family version. Default is 1.
+    type: integer
+    minimum: 1
+  protocol:
+    description: Schema compatibility level. Default is "genetlink".
+    enum: [ genetlink, genetlink-c, genetlink-legacy, netlink-raw ] # Trim
+  # Start netlink-raw
+  protonum:
+    description: Protocol number to use for netlink-raw
+    type: integer
+  # End netlink-raw
+  uapi-header:
+    description: Path to the uAPI header, default is linux/${family-name}.h
+    type: string
+  # Start genetlink-c
+  c-family-name:
+    description: Name of the define for the family name.
+    type: string
+  c-version-name:
+    description: Name of the define for the verion of the family.
+    type: string
+  max-by-define:
+    description: Makes the number of attributes and commands be specified by a define, not an enum value.
+    type: boolean
+  # End genetlink-c
+  # Start genetlink-legacy
+  kernel-policy:
+    description: |
+      Defines if the input policy in the kernel is global, per-operation, or split per operation type.
+      Default is split.
+    enum: [ split, per-op, global ]
+  # End genetlink-legacy
+
+  definitions:
+    description: List of type and constant definitions (enums, flags, defines).
+    type: array
+    items:
+      type: object
+      required: [ type, name ]
+      additionalProperties: False
+      properties:
+        name:
+          type: string
+        header:
+          description: For C-compatible languages, header which already defines this value.
+          type: string
+        type:
+          enum: [ const, enum, flags, struct ] # Trim
+        doc:
+          type: string
+        # For const
+        value:
+          description: For const - the value.
+          type: [ string, integer ]
+        # For enum and flags
+        value-start:
+          description: For enum or flags the literal initializer for the first value.
+          type: [ string, integer ]
+        entries:
+          description: For enum or flags array of values.
+          type: array
+          items:
+            oneOf:
+              - type: string
+              - type: object
+                required: [ name ]
+                additionalProperties: False
+                properties:
+                  name:
+                    type: string
+                  value:
+                    type: integer
+                  doc:
+                    type: string
+        render-max:
+          description: Render the max members for this enum.
+          type: boolean
+        # Start genetlink-c
+        enum-name:
+          description: Name for enum, if empty no name will be used.
+          type: [ string, "null" ]
+        name-prefix:
+          description: For enum the prefix of the values, optional.
+          type: string
+        # End genetlink-c
+        # Start genetlink-legacy
+        members:
+          description: List of struct members. Only scalars and strings members allowed.
+          type: array
+          items:
+            type: object
+            required: [ name, type ]
+            additionalProperties: False
+            properties:
+              name:
+                type: string
+              type:
+                description: The netlink attribute type
+                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary ]
+              len:
+                $ref: '#/$defs/len-or-define'
+              byte-order:
+                enum: [ little-endian, big-endian ]
+              doc:
+                description: Documentation for the struct member attribute.
+                type: string
+              enum:
+                description: Name of the enum type used for the attribute.
+                type: string
+              enum-as-flags:
+                description: |
+                  Treat the enum as flags. In most cases enum is either used as flags or as values.
+                  Sometimes, however, both forms are necessary, in which case header contains the enum
+                  form while specific attributes may request to convert the values into a bitfield.
+                type: boolean
+              display-hint: &display-hint
+                description: |
+                  Optional format indicator that is intended only for choosing
+                  the right formatting mechanism when displaying values of this
+                  type.
+                enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
+        # End genetlink-legacy
+
+  attribute-sets:
+    description: Definition of attribute spaces for this family.
+    type: array
+    items:
+      description: Definition of a single attribute space.
+      type: object
+      required: [ name, attributes ]
+      additionalProperties: False
+      properties:
+        name:
+          description: |
+            Name used when referring to this space in other definitions, not used outside of the spec.
+          type: string
+        name-prefix:
+          description: |
+            Prefix for the C enum name of the attributes. Default family[name]-set[name]-a-
+          type: string
+        enum-name:
+          description: Name for the enum type of the attribute.
+          type: string
+        doc:
+          description: Documentation of the space.
+          type: string
+        subset-of:
+          description: |
+            Name of another space which this is a logical part of. Sub-spaces can be used to define
+            a limited group of attributes which are used in a nest.
+          type: string
+        # Start genetlink-c
+        attr-cnt-name:
+          description: The explicit name for constant holding the count of attributes (last attr + 1).
+          type: string
+        attr-max-name:
+          description: The explicit name for last member of attribute enum.
+          type: string
+        # End genetlink-c
+        attributes:
+          description: List of attributes in the space.
+          type: array
+          items:
+            type: object
+            required: [ name, type ]
+            additionalProperties: False
+            properties:
+              name:
+                type: string
+              type: &attr-type
+                description: The netlink attribute type
+                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
+                        string, nest, array-nest, nest-type-value ]
+              doc:
+                description: Documentation of the attribute.
+                type: string
+              value:
+                description: Value for the enum item representing this attribute in the uAPI.
+                $ref: '#/$defs/uint'
+              type-value:
+                description: Name of the value extracted from the type of a nest-type-value attribute.
+                type: array
+                items:
+                  type: string
+              byte-order:
+                enum: [ little-endian, big-endian ]
+              multi-attr:
+                type: boolean
+              nested-attributes:
+                description: Name of the space (sub-space) used inside the attribute.
+                type: string
+              enum:
+                description: Name of the enum type used for the attribute.
+                type: string
+              enum-as-flags:
+                description: |
+                  Treat the enum as flags. In most cases enum is either used as flags or as values.
+                  Sometimes, however, both forms are necessary, in which case header contains the enum
+                  form while specific attributes may request to convert the values into a bitfield.
+                type: boolean
+              checks:
+                description: Kernel input validation.
+                type: object
+                additionalProperties: False
+                properties:
+                  flags-mask:
+                    description: Name of the flags constant on which to base mask (unsigned scalar types only).
+                    type: string
+                  min:
+                    description: Min value for an integer attribute.
+                    type: integer
+                  min-len:
+                    description: Min length for a binary attribute.
+                    $ref: '#/$defs/len-or-define'
+                  max-len:
+                    description: Max length for a string or a binary attribute.
+                    $ref: '#/$defs/len-or-define'
+              sub-type: *attr-type
+              display-hint: *display-hint
+              # Start genetlink-c
+              name-prefix:
+                type: string
+              # End genetlink-c
+              # Start genetlink-legacy
+              struct:
+                description: Name of the struct type used for the attribute.
+                type: string
+              # End genetlink-legacy
+
+      # Make sure name-prefix does not appear in subsets (subsets inherit naming)
+      dependencies:
+        name-prefix:
+          not:
+            required: [ subset-of ]
+        subset-of:
+          not:
+            required: [ name-prefix ]
+
+  operations:
+    description: Operations supported by the protocol.
+    type: object
+    required: [ list ]
+    additionalProperties: False
+    properties:
+      enum-model:
+        description: |
+          The model of assigning values to the operations.
+          "unified" is the recommended model where all message types belong
+          to a single enum.
+          "directional" has the messages sent to the kernel and from the kernel
+          enumerated separately.
+        enum: [ unified, directional ] # Trim
+      name-prefix:
+        description: |
+          Prefix for the C enum name of the command. The name is formed by concatenating
+          the prefix with the upper case name of the command, with dashes replaced by underscores.
+        type: string
+      enum-name:
+        description: Name for the enum type with commands.
+        type: string
+      async-prefix:
+        description: Same as name-prefix but used to render notifications and events to separate enum.
+        type: string
+      async-enum:
+        description: Name for the enum type with notifications/events.
+        type: string
+      # Start genetlink-legacy
+      fixed-header: &fixed-header
+        description: |
+          Name of the structure defining the optional fixed-length protocol
+          header. This header is placed in a message after the netlink and
+          genetlink headers and before any attributes.
+        type: string
+      # End genetlink-legacy
+      list:
+        description: List of commands
+        type: array
+        items:
+          type: object
+          additionalProperties: False
+          required: [ name, doc ]
+          properties:
+            name:
+              description: Name of the operation, also defining its C enum value in uAPI.
+              type: string
+            doc:
+              description: Documentation for the command.
+              type: string
+            value:
+              description: Value for the enum in the uAPI.
+              $ref: '#/$defs/uint'
+            attribute-set:
+              description: |
+                Attribute space from which attributes directly in the requests and replies
+                to this command are defined.
+              type: string
+            flags: &cmd_flags
+              description: Command flags.
+              type: array
+              items:
+                enum: [ admin-perm ]
+            dont-validate:
+              description: Kernel attribute validation flags.
+              type: array
+              items:
+                enum: [ strict, dump ]
+            # Start genetlink-legacy
+            fixed-header: *fixed-header
+            # End genetlink-legacy
+            do: &subop-type
+              description: Main command handler.
+              type: object
+              additionalProperties: False
+              properties:
+                request: &subop-attr-list
+                  description: Definition of the request message for a given command.
+                  type: object
+                  additionalProperties: False
+                  properties:
+                    attributes:
+                      description: |
+                        Names of attributes from the attribute-set (not full attribute
+                        definitions, just names).
+                      type: array
+                      items:
+                        type: string
+                    # Start genetlink-legacy
+                    value:
+                      description: |
+                        ID of this message if value for request and response differ,
+                        i.e. requests and responses have different message enums.
+                      $ref: '#/$defs/uint'
+                    # End genetlink-legacy
+                reply: *subop-attr-list
+                pre:
+                  description: Hook for a function to run before the main callback (pre_doit or start).
+                  type: string
+                post:
+                  description: Hook for a function to run after the main callback (post_doit or done).
+                  type: string
+            dump: *subop-type
+            notify:
+              description: Name of the command sharing the reply type with this notification.
+              type: string
+            event:
+              type: object
+              additionalProperties: False
+              properties:
+                attributes:
+                  description: Explicit list of the attributes for the notification.
+                  type: array
+                  items:
+                    type: string
+            mcgrp:
+              description: Name of the multicast group generating given notification.
+              type: string
+  mcast-groups:
+    description: List of multicast groups.
+    type: object
+    required: [ list ]
+    additionalProperties: False
+    properties:
+      list:
+        description: List of groups.
+        type: array
+        items:
+          type: object
+          required: [ name ]
+          additionalProperties: False
+          properties:
+            name:
+              description: |
+                The name for the group, used to form the define and the value of the define.
+              type: string
+            # Start genetlink-c
+            c-define-name:
+              description: Override for the name of the define in C uAPI.
+              type: string
+            # End genetlink-c
+            flags: *cmd_flags
+            # Start netlink-raw
+            id:
+              description: Id of the netlink multicast group
+              type: integer
+            # End netlink-raw
-- 
2.41.0


