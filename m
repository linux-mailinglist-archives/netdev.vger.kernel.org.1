Return-Path: <netdev+bounces-47289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119BC7E96BB
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 07:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED41280D27
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 06:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B9FC2C4;
	Mon, 13 Nov 2023 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz+R6Ja4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C69C8E0
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 06:39:32 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C29AD78
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 22:39:28 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso3366883b3a.1
        for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 22:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699857568; x=1700462368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=039weAOB0KPhkyCn1/yH/LONJ+llBZkZF5ylZBE+rUA=;
        b=kz+R6Ja4hEyt1AY6EGFhfABKJyeGcCLYxRVv5FJdRj7iRvo4HJxG7My4umyPI+/+N1
         z6NXvlQ70RvQA1iYI2eq816lnpBPUID055c+eMEL8YoyOb6Bk7FtM6VkJnZvFvwOtZqC
         /Lf5z2wvlr4Ysx1IciD7izkRFmNRpDt3yokK/q/uhvuzUs1M6W5jDzz66x55uwVtjRcY
         tOyGBthODopZGnmKqWa6H0zP4STe9d2RcZhhkyy5XnWu9VYbDFnR6oZwbTYe3Epc/TKx
         RJIgGy2avoJrvRYWTUIldHtaGfXhGKeu4KyD6bM9/URsx7i0OW8RZhXq/p7bw9E7zU8P
         E++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699857568; x=1700462368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=039weAOB0KPhkyCn1/yH/LONJ+llBZkZF5ylZBE+rUA=;
        b=rgVaS5nMmC2x1/iHNCbL7b7pvDUYRl8/MuJr/l8jwBK3nui9E4fjuyk4nQUAHJbvzX
         0sND1gQcPq4ilsb+K3nSB1s+pLENWygY+DiEM3nNXtZdZSDqU4UU/wcIaslM8aL+7NvS
         1jjdqOrvlgKsaQQjMEoPltd3uKMNVrOQfiOdz/jbrXLlZFbkDElrUPY3nvzmnb4f1E2R
         58R0V+hd/d9IWLfPF3Q67kt7TAk3VRwRK3cawIKhlaFKS94KYCUZ/HkxXExxk5J74icQ
         s/lk59zkHbpRs+N1w2DZNU3nJZO5u1bJL7IaaIgDLaD8OYYg7Hb4M7i4e9x4fpOHcbjb
         tOeA==
X-Gm-Message-State: AOJu0YxumL1VlntwqsjfMBnB/U2Qqezvops5mIR325fMu/PbFQKIHMvF
	uvUlzis3i3d7Go0hItHU7wY=
X-Google-Smtp-Source: AGHT+IGaqgNcaVmLq3q9Uf79GDbM5dYTduaXVcw5AKhI2b4oAoq1/SqvPPkUVxiQGv86VB72jtIWKg==
X-Received: by 2002:a05:6a21:7748:b0:180:132:e078 with SMTP id bc8-20020a056a21774800b001800132e078mr4298965pzc.31.1699857567781;
        Sun, 12 Nov 2023 22:39:27 -0800 (PST)
Received: from swarup-virtual-machine.localdomain ([171.76.83.22])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c94500b001cc2f9fd74csm3420551pla.189.2023.11.12.22.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 22:39:27 -0800 (PST)
From: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Subject: [PATCH] netlink: specs: devlink: add missing attributes in devlink.yaml and re-generate the related code
Date: Mon, 13 Nov 2023 12:09:04 +0530
Message-Id: <20231113063904.22179-1-swarupkotikalapudi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing attributes in devlink.yaml.

Re-generate the related devlink-user.[ch] code.

trap-get command prints nested attributes.

Test result with trap-get command:

sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml
--do trap-get --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1",
"trap-name": "ttl_value_is_too_small"}' --process-unknown

{'attr-stats': {'rx-bytes': 30931292, 'rx-dropped': 87,
 'rx-packets': 217826},
 'bus-name': 'netdevsim',
 'dev-name': 'netdevsim1',
 'trap-action': 'trap',
 'trap-generic': True,
 'trap-group-name': 'l3_exceptions',
 'trap-metadata': {'metadata-type-in-port': True},
 'trap-name': 'ttl_value_is_too_small',
 'trap-type': 'exception'}

Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Suggested-by: Jiri Pirko <jiri@resnulli.us>
---
 Documentation/netlink/specs/devlink.yaml | 344 +++++++++++++++++++----
 tools/net/ynl/generated/devlink-user.c   | 260 +++++++++++++++++
 tools/net/ynl/generated/devlink-user.h   | 114 +++++++-
 3 files changed, 656 insertions(+), 62 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index c6ba4889575a..2766288b7c15 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -71,6 +71,14 @@ definitions:
         name: roce-bit
       -
         name: migratable-bit
+  -
+    type: enum
+    name: rate-type
+    entries:
+      -
+        name: leaf
+      -
+        name: node
   -
     type: enum
     name: sb-threshold-type
@@ -107,6 +115,16 @@ definitions:
         name: none
       -
         name: basic
+  -
+    type: enum
+    name: dpipe-header-id
+    entries:
+      -
+        name: ethernet
+      -
+        name: ipv4
+      -
+        name: ipv6
   -
     type: enum
     name: dpipe-match-type
@@ -170,6 +188,16 @@ definitions:
         name: trap
       -
         name: mirror
+  -
+    type: enum
+    name: trap-type
+    entries:
+      -
+        name: drop
+      -
+        name: exception
+      -
+        name: control
 
 attribute-sets:
   -
@@ -190,23 +218,44 @@ attribute-sets:
         name: port-type
         type: u16
         enum: port-type
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: port-desired-type
+        type: u16
+      -
+        name: port-netdev-ifindex
+        type: u32
+      -
+        name: port-netdev-name
+        type: string
+      -
+        name: port-ibdev-name
+        type: string
       -
         name: port-split-count
         type: u32
         value: 9
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: port-split-group
+        type: u32
       -
         name: sb-index
         type: u32
         value: 11
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: sb-size
+        type: u32
+      -
+        name: sb-ingress-pool-count
+        type: u16
+      -
+        name: sb-egress-pool-count
+        type: u16
+      -
+        name: sb-ingress-tc-count
+        type: u16
+      -
+        name: sb-egress-tc-count
+        type: u16
       -
         name: sb-pool-index
         type: u16
@@ -229,15 +278,17 @@ attribute-sets:
         name: sb-tc-index
         type: u16
         value: 22
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: sb-occ-cur
+        type: u32
+      -
+        name: sb-occ-max
+        type: u32
       -
         name: eswitch-mode
         type: u16
         value: 25
         enum: eswitch-mode
-
       -
         name: eswitch-inline-mode
         type: u16
@@ -343,6 +394,7 @@ attribute-sets:
       -
         name: dpipe-header-id
         type: u32
+        enum: dpipe-header-id
       -
         name: dpipe-header-fields
         type: nest
@@ -429,23 +481,38 @@ attribute-sets:
         name: port-flavour
         type: u16
         enum: port-flavour
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: port-number
+        type: u32
+      -
+        name: port-split-support-number
+        type: u32
+      -
+        name: param
+        type: nest
+        nested-attributes: dl-param
       -
         name: param-name
         type: string
         value: 81
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: param-generic
+        type: flag
       -
         name: param-type
         type: u8
         value: 83
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: param-value-list
+        type: nest
+        nested-attributes: dl-param-value-list
+      -
+        name: param-value
+        type: nest
+        nested-attributes: dl-param-value
+      -
+        name: param-value-data
+        type: u64
       -
         name: param-value-cmode
         type: u8
@@ -454,16 +521,32 @@ attribute-sets:
       -
         name: region-name
         type: string
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: region-size
+        type: u64
+      -
+        name: region-snapshots
+        type: nest
+        nested-attributes: dl-region-snapshots
+      -
+        name: region-snapshot
+        type: nest
+        nested-attributes: dl-region-snapshot
       -
         name: region-snapshot-id
         type: u32
         value: 92
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: region-chunks
+        type: nest
+        nested-attributes: dl-region-chunks
+      -
+        name: region-chunk
+        type: nest
+        nested-attributes: dl-region-chunk
+      -
+        name: region-chunk-data
+        type: binary
       -
         name: region-chunk-addr
         type: u64
@@ -498,9 +581,9 @@ attribute-sets:
       -
         name: info-version-value
         type: string
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: sb-pool-cell-size
+        type: u32
       -
         name: fmsg
         type: nest
@@ -521,15 +604,33 @@ attribute-sets:
       -
         name: fmsg-obj-name
         type: string
-
-      # TODO: fill in the attributes in between
+      -
+        name: fms-obj-value-type
+        type: u8
+      -
+        name: fms-obj-value-data
+        type: u64
+      -
+        name: health-reporter
+        type: nest
+        nested-attributes: dl-health-reporter
 
       -
         name: health-reporter-name
         type: string
         value: 115
-
-      # TODO: fill in the attributes in between
+      -
+        name: health-reporter-state
+        type: u8
+      -
+        name: health-reporter-err-count
+        type: u64
+      -
+        name: health-reporter-recover-count
+        type: u64
+      -
+        name: health-reporter-dump-ts
+        type: u64
 
       -
         name: health-reporter-graceful-period
@@ -544,15 +645,27 @@ attribute-sets:
       -
         name: flash-update-component
         type: string
-
-      # TODO: fill in the attributes in between
+      -
+        name: flash-update-status-msg
+        type: string
+      -
+        name: flash-update-status-done
+        type: u64
+      -
+        name: flash-update-status-total
+        type: u64
 
       -
         name: port-pci-pf-number
         type: u16
         value: 127
-
-      # TODO: fill in the attributes in between
+      -
+        name: port-pci-vf-number
+        type: u16
+      -
+        name: attr-stats
+        type: nest
+        nested-attributes: dl-attr-stats
 
       -
         name: trap-name
@@ -562,8 +675,17 @@ attribute-sets:
         name: trap-action
         type: u8
         enum: trap-action
-
-      # TODO: fill in the attributes in between
+      -
+        name: trap-type
+        type: u8
+        enum: trap-type
+      -
+        name: trap-generic
+        type: flag
+      -
+        name: trap-metadata
+        type: nest
+        nested-attributes: dl-trap-metadata
 
       -
         name: trap-group-name
@@ -573,8 +695,9 @@ attribute-sets:
       -
         name: reload-failed
         type: u8
-
-      # TODO: fill in the attributes in between
+      -
+        name: health-reporter-dump-ts-ns
+        type: u64
 
       -
         name: netns-fd
@@ -587,8 +710,6 @@ attribute-sets:
         name: netns-id
         type: u32
 
-      # TODO: fill in the attributes in between
-
       -
         name: health-reporter-auto-dump
         type: u8
@@ -606,15 +727,26 @@ attribute-sets:
         name: port-function
         type: nest
         nested-attributes: dl-port-function
-
-      # TODO: fill in the attributes in between
+      -
+        name: board-serial-number
+        type: string
+      -
+        name: port-lanes
+        type: u32
+      -
+        name: port-splittable
+        type: u8
+      -
+        name: port-external
+        type: u8
 
       -
         name: port-controller-number
         type: u32
         value: 150
-
-      # TODO: fill in the attributes in between
+      -
+        name: flash-update-status-timeout
+        type: u64
 
       -
         name: flash-update-overwrite-mask
@@ -670,14 +802,14 @@ attribute-sets:
         multi-attr: true
         nested-attributes: dl-reload-act-stats
 
-      # TODO: fill in the attributes in between
-
       -
         name: port-pci-sf-number
         type: u32
         value: 164
-
-      # TODO: fill in the attributes in between
+      -
+        name: rate-type
+        type: u16
+        enum: rate-type
 
       -
         name: rate-tx-share
@@ -693,21 +825,31 @@ attribute-sets:
         name: rate-parent-node-name
         type: string
 
-      # TODO: fill in the attributes in between
+      -
+         name: region-max-snpshots
+         type: u32
 
       -
         name: linecard-index
         type: u32
         value: 171
 
-      # TODO: fill in the attributes in between
+      -
+         name: linecard-state
+         type: u8
 
       -
         name: linecard-type
         type: string
         value: 173
-
-      # TODO: fill in the attributes in between
+      -
+        name: linecard_supported-types
+        type: nest
+        nested-attributes: dl-linecard_supported-types
+      -
+        name: nested-devlink
+        type: nest
+        nested-attributes: dl-nested-devlink
 
       -
         name: selftests
@@ -1000,7 +1142,54 @@ attribute-sets:
     attributes:
       -
         name: resource
-
+  -
+    name: dl-param
+    subset-of: devlink
+    attributes:
+      -
+        name: param-name
+      -
+        name: param-type
+  -
+    name: dl-param-value-list
+    subset-of: devlink
+    attributes:
+      -
+        name: param-name
+      -
+        name: param-type
+  -
+    name: dl-param-value
+    subset-of: devlink
+    attributes:
+      -
+        name: param-name
+      -
+        name: param-type
+  -
+    name: dl-region-snapshots
+    subset-of: devlink
+    attributes:
+      -
+        name: region-snapshot-id
+  -
+    name: dl-region-snapshot
+    subset-of: devlink
+    attributes:
+      -
+        name: region-snapshot-id
+  -
+    name: dl-region-chunks
+    subset-of: devlink
+    attributes:
+      -
+        name: region-name
+  -
+    name: dl-region-chunk
+    subset-of: devlink
+    attributes:
+      -
+        name: region-name
   -
     name: dl-fmsg
     subset-of: devlink
@@ -1015,7 +1204,44 @@ attribute-sets:
         name: fmsg-nest-end
       -
         name: fmsg-obj-name
-
+  -
+    name: dl-health-reporter
+    subset-of: devlink
+    attributes:
+      -
+        name: port-index
+  -
+    name: dl-attr-stats
+    attributes:
+        - name: rx-packets
+          type: u64
+          value: 0
+        - name: rx-bytes
+          type: u64
+        - name: rx-dropped
+          type: u64
+  -
+     name: dl-trap-metadata
+     attributes:
+       -
+         name: metadata-type-in-port
+         type: flag
+         value: 0
+       -
+         name: metadata-type-fa-cookie
+         type: flag
+  -
+     name: dl-linecard_supported-types
+     subset-of: devlink
+     attributes:
+       -
+         name: linecard_supported-types
+  -
+     name: dl-nested-devlink
+     subset-of: devlink
+     attributes:
+       -
+         name: nested-devlink
   -
     name: dl-selftest-id
     name-prefix: devlink-attr-selftest-id-
diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
index 75b744b47986..4a23390e4132 100644
--- a/tools/net/ynl/generated/devlink-user.c
+++ b/tools/net/ynl/generated/devlink-user.c
@@ -130,6 +130,18 @@ const char *devlink_port_fn_attr_cap_str(enum devlink_port_fn_attr_cap value)
 	return devlink_port_fn_attr_cap_strmap[value];
 }
 
+static const char * const devlink_rate_type_strmap[] = {
+	[0] = "leaf",
+	[1] = "node",
+};
+
+const char *devlink_rate_type_str(enum devlink_rate_type value)
+{
+	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_rate_type_strmap))
+		return NULL;
+	return devlink_rate_type_strmap[value];
+}
+
 static const char * const devlink_sb_threshold_type_strmap[] = {
 	[0] = "static",
 	[1] = "dynamic",
@@ -182,6 +194,19 @@ devlink_eswitch_encap_mode_str(enum devlink_eswitch_encap_mode value)
 	return devlink_eswitch_encap_mode_strmap[value];
 }
 
+static const char * const devlink_dpipe_header_id_strmap[] = {
+	[0] = "ethernet",
+	[1] = "ipv4",
+	[2] = "ipv6",
+};
+
+const char *devlink_dpipe_header_id_str(enum devlink_dpipe_header_id value)
+{
+	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_dpipe_header_id_strmap))
+		return NULL;
+	return devlink_dpipe_header_id_strmap[value];
+}
+
 static const char * const devlink_dpipe_match_type_strmap[] = {
 	[0] = "field-exact",
 };
@@ -278,6 +303,19 @@ const char *devlink_trap_action_str(enum devlink_trap_action value)
 	return devlink_trap_action_strmap[value];
 }
 
+static const char * const devlink_trap_type_strmap[] = {
+	[0] = "drop",
+	[1] = "exception",
+	[2] = "control",
+};
+
+const char *devlink_trap_type_str(enum devlink_trap_type value)
+{
+	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(devlink_trap_type_strmap))
+		return NULL;
+	return devlink_trap_type_strmap[value];
+}
+
 /* Policies */
 struct ynl_policy_attr devlink_dl_dpipe_match_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_DPIPE_MATCH_TYPE] = { .name = "dpipe-match-type", .type = YNL_PT_U32, },
@@ -359,6 +397,72 @@ struct ynl_policy_nest devlink_dl_resource_nest = {
 	.table = devlink_dl_resource_policy,
 };
 
+struct ynl_policy_attr devlink_dl_param_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_PARAM_NAME] = { .name = "param-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_PARAM_TYPE] = { .name = "param-type", .type = YNL_PT_U8, },
+};
+
+struct ynl_policy_nest devlink_dl_param_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_param_policy,
+};
+
+struct ynl_policy_attr devlink_dl_param_value_list_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_PARAM_NAME] = { .name = "param-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_PARAM_TYPE] = { .name = "param-type", .type = YNL_PT_U8, },
+};
+
+struct ynl_policy_nest devlink_dl_param_value_list_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_param_value_list_policy,
+};
+
+struct ynl_policy_attr devlink_dl_param_value_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_PARAM_NAME] = { .name = "param-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_PARAM_TYPE] = { .name = "param-type", .type = YNL_PT_U8, },
+};
+
+struct ynl_policy_nest devlink_dl_param_value_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_param_value_policy,
+};
+
+struct ynl_policy_attr devlink_dl_region_snapshots_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_REGION_SNAPSHOT_ID] = { .name = "region-snapshot-id", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest devlink_dl_region_snapshots_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_region_snapshots_policy,
+};
+
+struct ynl_policy_attr devlink_dl_region_snapshot_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_REGION_SNAPSHOT_ID] = { .name = "region-snapshot-id", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest devlink_dl_region_snapshot_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_region_snapshot_policy,
+};
+
+struct ynl_policy_attr devlink_dl_region_chunks_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_REGION_NAME] = { .name = "region-name", .type = YNL_PT_NUL_STR, },
+};
+
+struct ynl_policy_nest devlink_dl_region_chunks_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_region_chunks_policy,
+};
+
+struct ynl_policy_attr devlink_dl_region_chunk_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_REGION_NAME] = { .name = "region-name", .type = YNL_PT_NUL_STR, },
+};
+
+struct ynl_policy_nest devlink_dl_region_chunk_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_region_chunk_policy,
+};
+
 struct ynl_policy_attr devlink_dl_info_version_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_INFO_VERSION_NAME] = { .name = "info-version-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_INFO_VERSION_VALUE] = { .name = "info-version-value", .type = YNL_PT_NUL_STR, },
@@ -382,6 +486,36 @@ struct ynl_policy_nest devlink_dl_fmsg_nest = {
 	.table = devlink_dl_fmsg_policy,
 };
 
+struct ynl_policy_attr devlink_dl_health_reporter_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_PORT_INDEX] = { .name = "port-index", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest devlink_dl_health_reporter_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_health_reporter_policy,
+};
+
+struct ynl_policy_attr devlink_dl_attr_stats_policy[DEVLINK_A_DL_ATTR_STATS_MAX + 1] = {
+	[DEVLINK_A_DL_ATTR_STATS_RX_PACKETS] = { .name = "rx-packets", .type = YNL_PT_U64, },
+	[DEVLINK_A_DL_ATTR_STATS_RX_BYTES] = { .name = "rx-bytes", .type = YNL_PT_U64, },
+	[DEVLINK_A_DL_ATTR_STATS_RX_DROPPED] = { .name = "rx-dropped", .type = YNL_PT_U64, },
+};
+
+struct ynl_policy_nest devlink_dl_attr_stats_nest = {
+	.max_attr = DEVLINK_A_DL_ATTR_STATS_MAX,
+	.table = devlink_dl_attr_stats_policy,
+};
+
+struct ynl_policy_attr devlink_dl_trap_metadata_policy[DEVLINK_A_DL_TRAP_METADATA_MAX + 1] = {
+	[DEVLINK_A_DL_TRAP_METADATA_METADATA_TYPE_IN_PORT] = { .name = "metadata-type-in-port", .type = YNL_PT_FLAG, },
+	[DEVLINK_A_DL_TRAP_METADATA_METADATA_TYPE_FA_COOKIE] = { .name = "metadata-type-fa-cookie", .type = YNL_PT_FLAG, },
+};
+
+struct ynl_policy_nest devlink_dl_trap_metadata_nest = {
+	.max_attr = DEVLINK_A_DL_TRAP_METADATA_MAX,
+	.table = devlink_dl_trap_metadata_policy,
+};
+
 struct ynl_policy_attr devlink_dl_port_function_policy[DEVLINK_PORT_FUNCTION_ATTR_MAX + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .name = "hw-addr", .type = YNL_PT_BINARY,},
 	[DEVLINK_PORT_FN_ATTR_STATE] = { .name = "state", .type = YNL_PT_U8, },
@@ -571,19 +705,49 @@ struct ynl_policy_nest devlink_dl_dev_stats_nest = {
 	.table = devlink_dl_dev_stats_policy,
 };
 
+struct ynl_policy_attr devlink_dl_nested_devlink_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_NESTED_DEVLINK] = { .name = "nested-devlink", .type = YNL_PT_NEST, .nest = &devlink_dl_nested_devlink_nest, },
+};
+
+struct ynl_policy_nest devlink_dl_nested_devlink_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_nested_devlink_policy,
+};
+
+struct ynl_policy_attr devlink_dl_linecard_supported_types_policy[DEVLINK_ATTR_MAX + 1] = {
+	[DEVLINK_ATTR_LINECARD_SUPPORTED_TYPES] = { .name = "linecard_supported-types", .type = YNL_PT_NEST, .nest = &devlink_dl_linecard_supported_types_nest, },
+};
+
+struct ynl_policy_nest devlink_dl_linecard_supported_types_nest = {
+	.max_attr = DEVLINK_ATTR_MAX,
+	.table = devlink_dl_linecard_supported_types_policy,
+};
+
 struct ynl_policy_attr devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .name = "bus-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_DEV_NAME] = { .name = "dev-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .name = "port-index", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_PORT_TYPE] = { .name = "port-type", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_PORT_DESIRED_TYPE] = { .name = "port-desired-type", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_PORT_NETDEV_IFINDEX] = { .name = "port-netdev-ifindex", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_PORT_NETDEV_NAME] = { .name = "port-netdev-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_PORT_IBDEV_NAME] = { .name = "port-ibdev-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_PORT_SPLIT_COUNT] = { .name = "port-split-count", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_PORT_SPLIT_GROUP] = { .name = "port-split-group", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_SB_INDEX] = { .name = "sb-index", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_SB_SIZE] = { .name = "sb-size", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_SB_INGRESS_POOL_COUNT] = { .name = "sb-ingress-pool-count", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_SB_EGRESS_POOL_COUNT] = { .name = "sb-egress-pool-count", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_SB_INGRESS_TC_COUNT] = { .name = "sb-ingress-tc-count", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_SB_EGRESS_TC_COUNT] = { .name = "sb-egress-tc-count", .type = YNL_PT_U16, },
 	[DEVLINK_ATTR_SB_POOL_INDEX] = { .name = "sb-pool-index", .type = YNL_PT_U16, },
 	[DEVLINK_ATTR_SB_POOL_TYPE] = { .name = "sb-pool-type", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_SB_POOL_SIZE] = { .name = "sb-pool-size", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE] = { .name = "sb-pool-threshold-type", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_SB_THRESHOLD] = { .name = "sb-threshold", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_SB_TC_INDEX] = { .name = "sb-tc-index", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_SB_OCC_CUR] = { .name = "sb-occ-cur", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_SB_OCC_MAX] = { .name = "sb-occ-max", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_ESWITCH_MODE] = { .name = "eswitch-mode", .type = YNL_PT_U16, },
 	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = { .name = "eswitch-inline-mode", .type = YNL_PT_U16, },
 	[DEVLINK_ATTR_DPIPE_TABLES] = { .name = "dpipe-tables", .type = YNL_PT_NEST, .nest = &devlink_dl_dpipe_tables_nest, },
@@ -637,11 +801,24 @@ struct ynl_policy_attr devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_ID] = { .name = "dpipe-table-resource-id", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_UNITS] = { .name = "dpipe-table-resource-units", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_PORT_FLAVOUR] = { .name = "port-flavour", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_PORT_NUMBER] = { .name = "port-number", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_PORT_SPLIT_SUPPORT_NUMBER] = { .name = "port-split-support-number", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_PARAM] = { .name = "param", .type = YNL_PT_NEST, .nest = &devlink_dl_param_nest, },
 	[DEVLINK_ATTR_PARAM_NAME] = { .name = "param-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_PARAM_GENERIC] = { .name = "param-generic", .type = YNL_PT_FLAG, },
 	[DEVLINK_ATTR_PARAM_TYPE] = { .name = "param-type", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_PARAM_VALUE_LIST] = { .name = "param-value-list", .type = YNL_PT_NEST, .nest = &devlink_dl_param_value_list_nest, },
+	[DEVLINK_ATTR_PARAM_VALUE] = { .name = "param-value", .type = YNL_PT_NEST, .nest = &devlink_dl_param_value_nest, },
+	[DEVLINK_ATTR_PARAM_VALUE_DATA] = { .name = "param-value-data", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_PARAM_VALUE_CMODE] = { .name = "param-value-cmode", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_REGION_NAME] = { .name = "region-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_REGION_SIZE] = { .name = "region-size", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_REGION_SNAPSHOTS] = { .name = "region-snapshots", .type = YNL_PT_NEST, .nest = &devlink_dl_region_snapshots_nest, },
+	[DEVLINK_ATTR_REGION_SNAPSHOT] = { .name = "region-snapshot", .type = YNL_PT_NEST, .nest = &devlink_dl_region_snapshot_nest, },
 	[DEVLINK_ATTR_REGION_SNAPSHOT_ID] = { .name = "region-snapshot-id", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_REGION_CHUNKS] = { .name = "region-chunks", .type = YNL_PT_NEST, .nest = &devlink_dl_region_chunks_nest, },
+	[DEVLINK_ATTR_REGION_CHUNK] = { .name = "region-chunk", .type = YNL_PT_NEST, .nest = &devlink_dl_region_chunk_nest, },
+	[DEVLINK_ATTR_REGION_CHUNK_DATA] = { .name = "region-chunk-data", .type = YNL_PT_BINARY,},
 	[DEVLINK_ATTR_REGION_CHUNK_ADDR] = { .name = "region-chunk-addr", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_REGION_CHUNK_LEN] = { .name = "region-chunk-len", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_INFO_DRIVER_NAME] = { .name = "info-driver-name", .type = YNL_PT_NUL_STR, },
@@ -651,22 +828,39 @@ struct ynl_policy_attr devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_INFO_VERSION_STORED] = { .name = "info-version-stored", .type = YNL_PT_NEST, .nest = &devlink_dl_info_version_nest, },
 	[DEVLINK_ATTR_INFO_VERSION_NAME] = { .name = "info-version-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_INFO_VERSION_VALUE] = { .name = "info-version-value", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_SB_POOL_CELL_SIZE] = { .name = "sb-pool-cell-size", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_FMSG] = { .name = "fmsg", .type = YNL_PT_NEST, .nest = &devlink_dl_fmsg_nest, },
 	[DEVLINK_ATTR_FMSG_OBJ_NEST_START] = { .name = "fmsg-obj-nest-start", .type = YNL_PT_FLAG, },
 	[DEVLINK_ATTR_FMSG_PAIR_NEST_START] = { .name = "fmsg-pair-nest-start", .type = YNL_PT_FLAG, },
 	[DEVLINK_ATTR_FMSG_ARR_NEST_START] = { .name = "fmsg-arr-nest-start", .type = YNL_PT_FLAG, },
 	[DEVLINK_ATTR_FMSG_NEST_END] = { .name = "fmsg-nest-end", .type = YNL_PT_FLAG, },
 	[DEVLINK_ATTR_FMSG_OBJ_NAME] = { .name = "fmsg-obj-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_FMS_OBJ_VALUE_TYPE] = { .name = "fms-obj-value-type", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_FMS_OBJ_VALUE_DATA] = { .name = "fms-obj-value-data", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_HEALTH_REPORTER] = { .name = "health-reporter", .type = YNL_PT_NEST, .nest = &devlink_dl_health_reporter_nest, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .name = "health-reporter-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_STATE] = { .name = "health-reporter-state", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_ERR_COUNT] = { .name = "health-reporter-err-count", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_RECOVER_COUNT] = { .name = "health-reporter-recover-count", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TS] = { .name = "health-reporter-dump-ts", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] = { .name = "health-reporter-graceful-period", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER] = { .name = "health-reporter-auto-recover", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_FLASH_UPDATE_FILE_NAME] = { .name = "flash-update-file-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_FLASH_UPDATE_COMPONENT] = { .name = "flash-update-component", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_FLASH_UPDATE_STATUS_MSG] = { .name = "flash-update-status-msg", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_FLASH_UPDATE_STATUS_DONE] = { .name = "flash-update-status-done", .type = YNL_PT_U64, },
+	[DEVLINK_ATTR_FLASH_UPDATE_STATUS_TOTAL] = { .name = "flash-update-status-total", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_PORT_PCI_PF_NUMBER] = { .name = "port-pci-pf-number", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_PORT_PCI_VF_NUMBER] = { .name = "port-pci-vf-number", .type = YNL_PT_U16, },
+	[DEVLINK_ATTR_ATTR_STATS] = { .name = "attr-stats", .type = YNL_PT_NEST, .nest = &devlink_dl_attr_stats_nest, },
 	[DEVLINK_ATTR_TRAP_NAME] = { .name = "trap-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_TRAP_ACTION] = { .name = "trap-action", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_TRAP_TYPE] = { .name = "trap-type", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_TRAP_GENERIC] = { .name = "trap-generic", .type = YNL_PT_FLAG, },
+	[DEVLINK_ATTR_TRAP_METADATA] = { .name = "trap-metadata", .type = YNL_PT_NEST, .nest = &devlink_dl_trap_metadata_nest, },
 	[DEVLINK_ATTR_TRAP_GROUP_NAME] = { .name = "trap-group-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_RELOAD_FAILED] = { .name = "reload-failed", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TS_NS] = { .name = "health-reporter-dump-ts-ns", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_NETNS_FD] = { .name = "netns-fd", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_NETNS_PID] = { .name = "netns-pid", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_NETNS_ID] = { .name = "netns-id", .type = YNL_PT_U32, },
@@ -675,7 +869,12 @@ struct ynl_policy_attr devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_TRAP_POLICER_RATE] = { .name = "trap-policer-rate", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_TRAP_POLICER_BURST] = { .name = "trap-policer-burst", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_PORT_FUNCTION] = { .name = "port-function", .type = YNL_PT_NEST, .nest = &devlink_dl_port_function_nest, },
+	[DEVLINK_ATTR_BOARD_SERIAL_NUMBER] = { .name = "board-serial-number", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_PORT_LANES] = { .name = "port-lanes", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_PORT_SPLITTABLE] = { .name = "port-splittable", .type = YNL_PT_U8, },
+	[DEVLINK_ATTR_PORT_EXTERNAL] = { .name = "port-external", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_PORT_CONTROLLER_NUMBER] = { .name = "port-controller-number", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_FLASH_UPDATE_STATUS_TIMEOUT] = { .name = "flash-update-status-timeout", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_FLASH_UPDATE_OVERWRITE_MASK] = { .name = "flash-update-overwrite-mask", .type = YNL_PT_BITFIELD32, },
 	[DEVLINK_ATTR_RELOAD_ACTION] = { .name = "reload-action", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_RELOAD_ACTIONS_PERFORMED] = { .name = "reload-actions-performed", .type = YNL_PT_BITFIELD32, },
@@ -689,12 +888,17 @@ struct ynl_policy_attr devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_RELOAD_ACTION_INFO] = { .name = "reload-action-info", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_act_info_nest, },
 	[DEVLINK_ATTR_RELOAD_ACTION_STATS] = { .name = "reload-action-stats", .type = YNL_PT_NEST, .nest = &devlink_dl_reload_act_stats_nest, },
 	[DEVLINK_ATTR_PORT_PCI_SF_NUMBER] = { .name = "port-pci-sf-number", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_RATE_TYPE] = { .name = "rate-type", .type = YNL_PT_U16, },
 	[DEVLINK_ATTR_RATE_TX_SHARE] = { .name = "rate-tx-share", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_RATE_TX_MAX] = { .name = "rate-tx-max", .type = YNL_PT_U64, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .name = "rate-node-name", .type = YNL_PT_NUL_STR, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .name = "rate-parent-node-name", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_REGION_MAX_SNPSHOTS] = { .name = "region-max-snpshots", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_LINECARD_INDEX] = { .name = "linecard-index", .type = YNL_PT_U32, },
+	[DEVLINK_ATTR_LINECARD_STATE] = { .name = "linecard-state", .type = YNL_PT_U8, },
 	[DEVLINK_ATTR_LINECARD_TYPE] = { .name = "linecard-type", .type = YNL_PT_NUL_STR, },
+	[DEVLINK_ATTR_LINECARD_SUPPORTED_TYPES] = { .name = "linecard_supported-types", .type = YNL_PT_NEST, .nest = &devlink_dl_linecard_supported_types_nest, },
+	[DEVLINK_ATTR_NESTED_DEVLINK] = { .name = "nested-devlink", .type = YNL_PT_NEST, .nest = &devlink_dl_nested_devlink_nest, },
 	[DEVLINK_ATTR_SELFTESTS] = { .name = "selftests", .type = YNL_PT_NEST, .nest = &devlink_dl_selftest_id_nest, },
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .name = "rate-tx-priority", .type = YNL_PT_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .name = "rate-tx-weight", .type = YNL_PT_U32, },
@@ -1071,6 +1275,39 @@ int devlink_dl_resource_parse(struct ynl_parse_arg *yarg,
 	return 0;
 }
 
+void devlink_dl_param_free(struct devlink_dl_param *obj)
+{
+	free(obj->param_name);
+}
+
+void devlink_dl_param_value_list_free(struct devlink_dl_param_value_list *obj)
+{
+	free(obj->param_name);
+}
+
+void devlink_dl_param_value_free(struct devlink_dl_param_value *obj)
+{
+	free(obj->param_name);
+}
+
+void devlink_dl_region_snapshots_free(struct devlink_dl_region_snapshots *obj)
+{
+}
+
+void devlink_dl_region_snapshot_free(struct devlink_dl_region_snapshot *obj)
+{
+}
+
+void devlink_dl_region_chunks_free(struct devlink_dl_region_chunks *obj)
+{
+	free(obj->region_name);
+}
+
+void devlink_dl_region_chunk_free(struct devlink_dl_region_chunk *obj)
+{
+	free(obj->region_name);
+}
+
 void devlink_dl_info_version_free(struct devlink_dl_info_version *obj)
 {
 	free(obj->info_version_name);
@@ -1161,6 +1398,18 @@ int devlink_dl_fmsg_parse(struct ynl_parse_arg *yarg,
 	return 0;
 }
 
+void devlink_dl_health_reporter_free(struct devlink_dl_health_reporter *obj)
+{
+}
+
+void devlink_dl_attr_stats_free(struct devlink_dl_attr_stats *obj)
+{
+}
+
+void devlink_dl_trap_metadata_free(struct devlink_dl_trap_metadata *obj)
+{
+}
+
 void devlink_dl_port_function_free(struct devlink_dl_port_function *obj)
 {
 	free(obj->hw_addr);
@@ -2052,6 +2301,17 @@ int devlink_dl_dev_stats_parse(struct ynl_parse_arg *yarg,
 	return 0;
 }
 
+void devlink_dl_nested_devlink_free(struct devlink_dl_nested_devlink *obj)
+{
+	devlink_dl_nested_devlink_free(&obj->nested_devlink);
+}
+
+void
+devlink_dl_linecard_supported_types_free(struct devlink_dl_linecard_supported_types *obj)
+{
+	devlink_dl_linecard_supported_types_free(&obj->linecard_supported_types);
+}
+
 /* ============== DEVLINK_CMD_GET ============== */
 /* DEVLINK_CMD_GET - do */
 void devlink_get_req_free(struct devlink_get_req *req)
diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
index 1db4edc36eaa..e42229fc8724 100644
--- a/tools/net/ynl/generated/devlink-user.h
+++ b/tools/net/ynl/generated/devlink-user.h
@@ -24,6 +24,7 @@ const char *devlink_port_flavour_str(enum devlink_port_flavour value);
 const char *devlink_port_fn_state_str(enum devlink_port_fn_state value);
 const char *devlink_port_fn_opstate_str(enum devlink_port_fn_opstate value);
 const char *devlink_port_fn_attr_cap_str(enum devlink_port_fn_attr_cap value);
+const char *devlink_rate_type_str(enum devlink_rate_type value);
 const char *
 devlink_sb_threshold_type_str(enum devlink_sb_threshold_type value);
 const char *devlink_eswitch_mode_str(enum devlink_eswitch_mode value);
@@ -31,6 +32,7 @@ const char *
 devlink_eswitch_inline_mode_str(enum devlink_eswitch_inline_mode value);
 const char *
 devlink_eswitch_encap_mode_str(enum devlink_eswitch_encap_mode value);
+const char *devlink_dpipe_header_id_str(enum devlink_dpipe_header_id value);
 const char *devlink_dpipe_match_type_str(enum devlink_dpipe_match_type value);
 const char *
 devlink_dpipe_action_type_str(enum devlink_dpipe_action_type value);
@@ -41,6 +43,7 @@ const char *devlink_reload_action_str(enum devlink_reload_action value);
 const char *devlink_param_cmode_str(enum devlink_param_cmode value);
 const char *devlink_flash_overwrite_str(enum devlink_flash_overwrite value);
 const char *devlink_trap_action_str(enum devlink_trap_action value);
+const char *devlink_trap_type_str(enum devlink_trap_type value);
 
 /* Common nested types */
 struct devlink_dl_dpipe_match {
@@ -53,7 +56,7 @@ struct devlink_dl_dpipe_match {
 	} _present;
 
 	enum devlink_dpipe_match_type dpipe_match_type;
-	__u32 dpipe_header_id;
+	enum devlink_dpipe_header_id dpipe_header_id;
 	__u8 dpipe_header_global;
 	__u32 dpipe_header_index;
 	__u32 dpipe_field_id;
@@ -83,7 +86,7 @@ struct devlink_dl_dpipe_action {
 	} _present;
 
 	enum devlink_dpipe_action_type dpipe_action_type;
-	__u32 dpipe_header_id;
+	enum devlink_dpipe_header_id dpipe_header_id;
 	__u8 dpipe_header_global;
 	__u32 dpipe_header_index;
 	__u32 dpipe_field_id;
@@ -143,6 +146,68 @@ struct devlink_dl_resource {
 	__u64 resource_occ;
 };
 
+struct devlink_dl_param {
+	struct {
+		__u32 param_name_len;
+		__u32 param_type:1;
+	} _present;
+
+	char *param_name;
+	__u8 param_type;
+};
+
+struct devlink_dl_param_value_list {
+	struct {
+		__u32 param_name_len;
+		__u32 param_type:1;
+	} _present;
+
+	char *param_name;
+	__u8 param_type;
+};
+
+struct devlink_dl_param_value {
+	struct {
+		__u32 param_name_len;
+		__u32 param_type:1;
+	} _present;
+
+	char *param_name;
+	__u8 param_type;
+};
+
+struct devlink_dl_region_snapshots {
+	struct {
+		__u32 region_snapshot_id:1;
+	} _present;
+
+	__u32 region_snapshot_id;
+};
+
+struct devlink_dl_region_snapshot {
+	struct {
+		__u32 region_snapshot_id:1;
+	} _present;
+
+	__u32 region_snapshot_id;
+};
+
+struct devlink_dl_region_chunks {
+	struct {
+		__u32 region_name_len;
+	} _present;
+
+	char *region_name;
+};
+
+struct devlink_dl_region_chunk {
+	struct {
+		__u32 region_name_len;
+	} _present;
+
+	char *region_name;
+};
+
 struct devlink_dl_info_version {
 	struct {
 		__u32 info_version_name_len;
@@ -165,6 +230,33 @@ struct devlink_dl_fmsg {
 	char *fmsg_obj_name;
 };
 
+struct devlink_dl_health_reporter {
+	struct {
+		__u32 port_index:1;
+	} _present;
+
+	__u32 port_index;
+};
+
+struct devlink_dl_attr_stats {
+	struct {
+		__u32 rx_packets:1;
+		__u32 rx_bytes:1;
+		__u32 rx_dropped:1;
+	} _present;
+
+	__u64 rx_packets;
+	__u64 rx_bytes;
+	__u64 rx_dropped;
+};
+
+struct devlink_dl_trap_metadata {
+	struct {
+		__u32 metadata_type_in_port:1;
+		__u32 metadata_type_fa_cookie:1;
+	} _present;
+};
+
 struct devlink_dl_port_function {
 	struct {
 		__u32 hw_addr_len;
@@ -283,7 +375,7 @@ struct devlink_dl_dpipe_header {
 	} _present;
 
 	char *dpipe_header_name;
-	__u32 dpipe_header_id;
+	enum devlink_dpipe_header_id dpipe_header_id;
 	__u8 dpipe_header_global;
 	struct devlink_dl_dpipe_header_fields dpipe_header_fields;
 };
@@ -318,6 +410,22 @@ struct devlink_dl_dev_stats {
 	struct devlink_dl_reload_stats remote_reload_stats;
 };
 
+struct devlink_dl_nested_devlink {
+	struct {
+		__u32 nested_devlink:1;
+	} _present;
+
+	struct devlink_dl_nested_devlink nested_devlink;
+};
+
+struct devlink_dl_linecard_supported_types {
+	struct {
+		__u32 linecard_supported_types:1;
+	} _present;
+
+	struct devlink_dl_linecard_supported_types linecard_supported_types;
+};
+
 /* ============== DEVLINK_CMD_GET ============== */
 /* DEVLINK_CMD_GET - do */
 struct devlink_get_req {
-- 
2.34.1


