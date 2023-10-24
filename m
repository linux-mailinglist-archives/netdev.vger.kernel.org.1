Return-Path: <netdev+bounces-43890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BDA7D537C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 15:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DAEDB20D7F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785582B75A;
	Tue, 24 Oct 2023 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pOoiU0Xe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62991125DE
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 13:58:30 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80A1110
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:58:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32dc9ff4a8fso3052396f8f.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698155904; x=1698760704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRcPEPDGfeXtmoXL/+wZxksa3bAtumrP4L8/r7SYHUg=;
        b=pOoiU0XeTU25EBTibUEkiI8pq/abTibJuLfyXlTcjXMich5BMxMw8kLRvPblGGTjEm
         8QSNM7wkWsoGDAf6DEqqUuPTTS4fSmfcefKrHkpD/wku51xuS8WzIwI/4DQMd5txzMq9
         tmTR/2mRfBF8fl80GNMJQeaLKSgruRlTahq+p0JQhE3vFJ1JFkldZ5jcugIUzCOG7ie9
         BehJ39dDgX4xAHyPJIAT5F/QDWKdmVT+Ho1raD8YW98vDcexrdCwggR79sp6WHNIisfK
         WcML5/4fgAvQs3CZxNB6SK6BmsD62VAq8mLQJrrZctq6kkKTm/sXPtLneeSH8vTjJsgZ
         Ucrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155904; x=1698760704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRcPEPDGfeXtmoXL/+wZxksa3bAtumrP4L8/r7SYHUg=;
        b=oAu25gNJsUM9uZoWxrakSy1ubjVNR2TOBwZbIU0A5yDjirI7uzLJFAaCkghojrIHJu
         PAvtIHOPXJZxY3qwCADWD0BbNBuuKJGWY36XoM2lSVe4yoRsVhIEbjYdOkXagFjhLNAd
         EzPig1gnMDIK3+0kqvzu0tWj03sdV8fRtq434d1JUeJlNfZP7aIGRUabPlNfagjDbS/5
         WGJH5UvdiIpP8mgIe1Z7QOz+Jrx/s1gKT/IwjybEH3YgjvtBJyVWNfp7OWKnRq2wzI4s
         cuf68xHIqCdM7LhJLP09RVoa4glh9/MInEix1jNGdCKfFoURCqQsOR5ubdfJVMjDGebf
         k9WA==
X-Gm-Message-State: AOJu0Yxc0hkAeUvd6lRWWudGbVveQ9ls//LK9Euuf0jgwSzmXP2dMJ18
	hFC3SAhbagJbCgxmkhzAX2cheQ==
X-Google-Smtp-Source: AGHT+IH5D/0dvUszG2kHeiURhB5oG6x/RkFZ1qXQTHAX2u6c830qeATqtNiCHOV13ZosycfscDwwWg==
X-Received: by 2002:adf:e80e:0:b0:32d:a476:527a with SMTP id o14-20020adfe80e000000b0032da476527amr9515253wrm.50.1698155904006;
        Tue, 24 Oct 2023 06:58:24 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id a3-20020adfe5c3000000b0032da40fd7bdsm10168021wrn.24.2023.10.24.06.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:58:23 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:58:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com,
	pabeni@redhat.com, imagedong@tencent.com
Subject: Re: [PATCH v17 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
Message-ID: <ZTfNfvtZz7F1up6u@nanopsycho>
References: <20231024125445.2632-1-aaptel@nvidia.com>
 <20231024125445.2632-3-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024125445.2632-3-aaptel@nvidia.com>

Tue, Oct 24, 2023 at 02:54:27PM CEST, aaptel@nvidia.com wrote:
>Add a new netlink family to get/set ULP DDP capabilities on a network
>device and to retrieve statistics.
>
>The messages use the genetlink infrastructure and are specified in a
>YAML file which was used to generate some of the files in this commit:
>
>./tools/net/ynl/ynl-gen-c.py --mode kernel \
>    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
>    -o net/core/ulp_ddp_gen_nl.h
>./tools/net/ynl/ynl-gen-c.py --mode kernel \
>    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --source \
>    -o net/core/ulp_ddp_gen_nl.c
>./tools/net/ynl/ynl-gen-c.py --mode uapi \
>    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
>    > include/uapi/linux/ulp_ddp_nl.h
>
>Signed-off-by: Shai Malin <smalin@nvidia.com>
>Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
>---
> Documentation/netlink/specs/ulp_ddp.yaml | 183 +++++++++++
> include/uapi/linux/ulp_ddp_nl.h          |  59 ++++
> net/core/Makefile                        |   2 +-
> net/core/ulp_ddp_gen_nl.c                |  85 +++++
> net/core/ulp_ddp_gen_nl.h                |  32 ++
> net/core/ulp_ddp_nl.c                    | 388 +++++++++++++++++++++++
> 6 files changed, 748 insertions(+), 1 deletion(-)
> create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
> create mode 100644 include/uapi/linux/ulp_ddp_nl.h
> create mode 100644 net/core/ulp_ddp_gen_nl.c
> create mode 100644 net/core/ulp_ddp_gen_nl.h
> create mode 100644 net/core/ulp_ddp_nl.c
>
>diff --git a/Documentation/netlink/specs/ulp_ddp.yaml b/Documentation/netlink/specs/ulp_ddp.yaml
>new file mode 100644
>index 000000000000..882aa4e52992
>--- /dev/null
>+++ b/Documentation/netlink/specs/ulp_ddp.yaml
>@@ -0,0 +1,183 @@
>+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>+#
>+# Author: Aurelien Aptel <aaptel@nvidia.com>
>+#
>+# Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
>+#
>+
>+name: ulp_ddp
>+
>+protocol: genetlink
>+
>+doc: Netlink protocol to manage ULP DPP on network devices.
>+
>+definitions:
>+  -
>+    type: enum
>+    name: cap
>+    entries:
>+      - nvme-tcp
>+      - nvme-tcp-ddgst-rx
>+
>+uapi-header: linux/ulp_ddp_nl.h

Not needed.
Hmm, Jakub, why this is not only allowed in genetlink-legacy?


>+
>+attribute-sets:
>+  -
>+    name: stat

"stats"?


>+    attributes:
>+      -
>+        name: ifindex
>+        doc: interface index of the net device.
>+        type: u32
>+      -
>+        name: pad
>+        type: pad
>+      -
>+        name: rx-nvmeotcp-sk-add
>+        doc: Sockets successfully configured for NVMeTCP offloading.
>+        type: u64
>+      -
>+        name: rx-nvmeotcp-sk-add-fail

"nvmeotcp" should stand for "nvme over tcp"? Why not to name it just
"rx-nvem-tcp-x"?


>+        doc: Sockets failed to be configured for NVMeTCP offloading.
>+        type: u64
>+      -
>+        name: rx-nvmeotcp-sk-del
>+        doc: Sockets with NVMeTCP offloading configuration removed.
>+        type: u64
>+      -
>+        name: rx-nvmeotcp-setup
>+        doc: NVMe-TCP IOs successfully configured for Rx Direct Data Placement.
>+        type: u64
>+      -
>+        name: rx-nvmeotcp-setup-fail
>+        doc: NVMe-TCP IOs failed to be configured for Rx Direct Data Placement.
>+        type: u64
>+      -
>+        name: rx-nvmeotcp-teardown
>+        doc: NVMe-TCP IOs with Rx Direct Data Placement configuration removed.
>+        type: u64
>+      -
>+        name: rx-nvmeotcp-drop
>+        doc: Packets failed the NVMeTCP offload validation.
>+        type: u64
>+      -
>+        name: rx-nvmeotcp-resync
>+        doc: >
>+          NVMe-TCP resync operations were processed due to Rx TCP packets
>+          re-ordering.
>+        type: u64
>+      -
>+        name: rx-nvmeotcp-packets
>+        doc: TCP packets successfully processed by the NVMeTCP offload.
>+        type: u64
>+      -
>+        name: rx-nvmeotcp-bytes
>+        doc: Bytes were successfully processed by the NVMeTCP offload.
>+        type: u64
>+  -
>+    name: dev

If this is attribute set for "caps-get"/"caps-set" only, why it is not
called "caps"?


>+    attributes:
>+      -
>+        name: ifindex
>+        doc: interface index of the net device.
>+        type: u32
>+      -
>+        name: hw
>+        doc: bitmask of the capabilities supported by the device.
>+        type: u64
>+        enum: cap
>+        enum-as-flags: true
>+      -
>+        name: active
>+        doc: bitmask of the capabilities currently enabled on the device.
>+        type: u64
>+        enum: cap
>+        enum-as-flags: true
>+      -
>+        name: wanted

For all caps related attrs, either put "caps" into the name or do that
and put it in a caps nest


>+        doc: >
>+          new active bit values of the capabilities we want to set on the
>+          device.
>+        type: u64
>+        enum: cap
>+        enum-as-flags: true
>+      -
>+        name: wanted_mask
>+        doc: bitmask of the meaningful bits in the wanted field.
>+        type: u64
>+        enum: cap
>+        enum-as-flags: true
>+      -
>+        name: pad
>+        type: pad
>+
>+operations:
>+  list:
>+    -
>+      name: get
>+      doc: Get ULP DDP capabilities.

This is for capabalities only, nothing else?
If yes, why not to name the op "caps-get"/"caps-set"?
If not and this is related to "dev", name it perhaps "dev-get"?
I mean, you should be able to align the op name and attribute set name.


>+      attribute-set: dev
>+      do:
>+        request:
>+          attributes:
>+            - ifindex
>+        reply: &dev-all
>+          attributes:
>+            - ifindex
>+            - hw
>+            - active
>+        pre: ulp_ddp_get_netdev
>+        post: ulp_ddp_put_netdev
>+      dump:
>+        reply: *dev-all
>+    -
>+      name: stats

"stats-get" ?


>+      doc: Get ULP DDP stats.
>+      attribute-set: stat
>+      do:
>+        request:
>+          attributes:
>+            - ifindex
>+        reply: &stats-all
>+          attributes:
>+            - ifindex
>+            - rx-nvmeotcp-sk-add
>+            - rx-nvmeotcp-sk-add-fail
>+            - rx-nvmeotcp-sk-del
>+            - rx-nvmeotcp-setup
>+            - rx-nvmeotcp-setup-fail
>+            - rx-nvmeotcp-teardown
>+            - rx-nvmeotcp-drop
>+            - rx-nvmeotcp-resync
>+            - rx-nvmeotcp-packets
>+            - rx-nvmeotcp-bytes
>+        pre: ulp_ddp_get_netdev
>+        post: ulp_ddp_put_netdev
>+      dump:
>+        reply: *stats-all
>+    -
>+      name: set
>+      doc: Set ULP DDP capabilities.
>+      attribute-set: dev
>+      do:
>+        request:
>+          attributes:
>+            - ifindex
>+            - wanted
>+            - wanted_mask
>+        reply:
>+          attributes:
>+            - ifindex
>+            - hw
>+            - active
>+        pre: ulp_ddp_get_netdev
>+        post: ulp_ddp_put_netdev
>+    -
>+      name: set-ntf
>+      doc: Notification for change in ULP DDP capabilities.
>+      notify: get
>+
>+mcast-groups:
>+  list:
>+    -
>+      name: mgmt
>diff --git a/include/uapi/linux/ulp_ddp_nl.h b/include/uapi/linux/ulp_ddp_nl.h
>new file mode 100644
>index 000000000000..fc63749c9251
>--- /dev/null
>+++ b/include/uapi/linux/ulp_ddp_nl.h
>@@ -0,0 +1,59 @@
>+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
>+/* Do not edit directly, auto-generated from: */
>+/*	Documentation/netlink/specs/ulp_ddp.yaml */
>+/* YNL-GEN uapi header */
>+
>+#ifndef _UAPI_LINUX_ULP_DDP_H
>+#define _UAPI_LINUX_ULP_DDP_H
>+
>+#define ULP_DDP_FAMILY_NAME	"ulp_ddp"
>+#define ULP_DDP_FAMILY_VERSION	1
>+
>+enum ulp_ddp_cap {
>+	ULP_DDP_CAP_NVME_TCP,
>+	ULP_DDP_CAP_NVME_TCP_DDGST_RX,
>+};
>+
>+enum {
>+	ULP_DDP_A_STAT_IFINDEX = 1,
>+	ULP_DDP_A_STAT_PAD,
>+	ULP_DDP_A_STAT_RX_NVMEOTCP_SK_ADD,
>+	ULP_DDP_A_STAT_RX_NVMEOTCP_SK_ADD_FAIL,
>+	ULP_DDP_A_STAT_RX_NVMEOTCP_SK_DEL,
>+	ULP_DDP_A_STAT_RX_NVMEOTCP_SETUP,
>+	ULP_DDP_A_STAT_RX_NVMEOTCP_SETUP_FAIL,
>+	ULP_DDP_A_STAT_RX_NVMEOTCP_TEARDOWN,
>+	ULP_DDP_A_STAT_RX_NVMEOTCP_DROP,
>+	ULP_DDP_A_STAT_RX_NVMEOTCP_RESYNC,
>+	ULP_DDP_A_STAT_RX_NVMEOTCP_PACKETS,
>+	ULP_DDP_A_STAT_RX_NVMEOTCP_BYTES,
>+
>+	__ULP_DDP_A_STAT_MAX,
>+	ULP_DDP_A_STAT_MAX = (__ULP_DDP_A_STAT_MAX - 1)
>+};
>+
>+enum {
>+	ULP_DDP_A_DEV_IFINDEX = 1,
>+	ULP_DDP_A_DEV_HW,
>+	ULP_DDP_A_DEV_ACTIVE,
>+	ULP_DDP_A_DEV_WANTED,
>+	ULP_DDP_A_DEV_WANTED_MASK,
>+	ULP_DDP_A_DEV_PAD,
>+
>+	__ULP_DDP_A_DEV_MAX,
>+	ULP_DDP_A_DEV_MAX = (__ULP_DDP_A_DEV_MAX - 1)
>+};
>+
>+enum {
>+	ULP_DDP_CMD_GET = 1,
>+	ULP_DDP_CMD_STATS,
>+	ULP_DDP_CMD_SET,
>+	ULP_DDP_CMD_SET_NTF,
>+
>+	__ULP_DDP_CMD_MAX,
>+	ULP_DDP_CMD_MAX = (__ULP_DDP_CMD_MAX - 1)
>+};
>+
>+#define ULP_DDP_MCGRP_MGMT	"mgmt"
>+
>+#endif /* _UAPI_LINUX_ULP_DDP_H */
>diff --git a/net/core/Makefile b/net/core/Makefile
>index b6a16e7c955a..1aff91f0fce0 100644
>--- a/net/core/Makefile
>+++ b/net/core/Makefile
>@@ -18,7 +18,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
> obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
> 
> obj-y += net-sysfs.o
>-obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
>+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o ulp_ddp_nl.o ulp_ddp_gen_nl.o
> obj-$(CONFIG_PAGE_POOL) += page_pool.o
> obj-$(CONFIG_PROC_FS) += net-procfs.o
> obj-$(CONFIG_NET_PKTGEN) += pktgen.o
>diff --git a/net/core/ulp_ddp_gen_nl.c b/net/core/ulp_ddp_gen_nl.c
>new file mode 100644
>index 000000000000..505bdc69b215
>--- /dev/null
>+++ b/net/core/ulp_ddp_gen_nl.c
>@@ -0,0 +1,85 @@
>+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>+/* Do not edit directly, auto-generated from: */
>+/*	Documentation/netlink/specs/ulp_ddp.yaml */
>+/* YNL-GEN kernel source */
>+
>+#include <net/netlink.h>
>+#include <net/genetlink.h>
>+
>+#include "ulp_ddp_gen_nl.h"
>+
>+#include <uapi/linux/ulp_ddp_nl.h>
>+
>+/* ULP_DDP_CMD_GET - do */
>+static const struct nla_policy ulp_ddp_get_nl_policy[ULP_DDP_A_DEV_IFINDEX + 1] = {
>+	[ULP_DDP_A_DEV_IFINDEX] = { .type = NLA_U32, },
>+};
>+
>+/* ULP_DDP_CMD_STATS - do */
>+static const struct nla_policy ulp_ddp_stats_nl_policy[ULP_DDP_A_STAT_IFINDEX + 1] = {
>+	[ULP_DDP_A_STAT_IFINDEX] = { .type = NLA_U32, },
>+};
>+
>+/* ULP_DDP_CMD_SET - do */
>+static const struct nla_policy ulp_ddp_set_nl_policy[ULP_DDP_A_DEV_WANTED_MASK + 1] = {
>+	[ULP_DDP_A_DEV_IFINDEX] = { .type = NLA_U32, },
>+	[ULP_DDP_A_DEV_WANTED] = NLA_POLICY_MASK(NLA_U64, 0x3),
>+	[ULP_DDP_A_DEV_WANTED_MASK] = NLA_POLICY_MASK(NLA_U64, 0x3),
>+};
>+
>+/* Ops table for ulp_ddp */
>+static const struct genl_split_ops ulp_ddp_nl_ops[] = {
>+	{
>+		.cmd		= ULP_DDP_CMD_GET,
>+		.pre_doit	= ulp_ddp_get_netdev,
>+		.doit		= ulp_ddp_nl_get_doit,
>+		.post_doit	= ulp_ddp_put_netdev,
>+		.policy		= ulp_ddp_get_nl_policy,
>+		.maxattr	= ULP_DDP_A_DEV_IFINDEX,
>+		.flags		= GENL_CMD_CAP_DO,
>+	},
>+	{
>+		.cmd	= ULP_DDP_CMD_GET,
>+		.dumpit	= ulp_ddp_nl_get_dumpit,
>+		.flags	= GENL_CMD_CAP_DUMP,
>+	},
>+	{
>+		.cmd		= ULP_DDP_CMD_STATS,
>+		.pre_doit	= ulp_ddp_get_netdev,
>+		.doit		= ulp_ddp_nl_stats_doit,
>+		.post_doit	= ulp_ddp_put_netdev,
>+		.policy		= ulp_ddp_stats_nl_policy,
>+		.maxattr	= ULP_DDP_A_STAT_IFINDEX,
>+		.flags		= GENL_CMD_CAP_DO,
>+	},
>+	{
>+		.cmd	= ULP_DDP_CMD_STATS,
>+		.dumpit	= ulp_ddp_nl_stats_dumpit,
>+		.flags	= GENL_CMD_CAP_DUMP,
>+	},
>+	{
>+		.cmd		= ULP_DDP_CMD_SET,
>+		.pre_doit	= ulp_ddp_get_netdev,
>+		.doit		= ulp_ddp_nl_set_doit,
>+		.post_doit	= ulp_ddp_put_netdev,
>+		.policy		= ulp_ddp_set_nl_policy,
>+		.maxattr	= ULP_DDP_A_DEV_WANTED_MASK,
>+		.flags		= GENL_CMD_CAP_DO,
>+	},
>+};
>+
>+static const struct genl_multicast_group ulp_ddp_nl_mcgrps[] = {
>+	[ULP_DDP_NLGRP_MGMT] = { "mgmt", },
>+};
>+
>+struct genl_family ulp_ddp_nl_family __ro_after_init = {
>+	.name		= ULP_DDP_FAMILY_NAME,
>+	.version	= ULP_DDP_FAMILY_VERSION,
>+	.netnsok	= true,
>+	.parallel_ops	= true,
>+	.module		= THIS_MODULE,
>+	.split_ops	= ulp_ddp_nl_ops,
>+	.n_split_ops	= ARRAY_SIZE(ulp_ddp_nl_ops),
>+	.mcgrps		= ulp_ddp_nl_mcgrps,
>+	.n_mcgrps	= ARRAY_SIZE(ulp_ddp_nl_mcgrps),
>+};
>diff --git a/net/core/ulp_ddp_gen_nl.h b/net/core/ulp_ddp_gen_nl.h
>new file mode 100644
>index 000000000000..277fb9dbfdcd
>--- /dev/null
>+++ b/net/core/ulp_ddp_gen_nl.h
>@@ -0,0 +1,32 @@
>+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
>+/* Do not edit directly, auto-generated from: */
>+/*	Documentation/netlink/specs/ulp_ddp.yaml */
>+/* YNL-GEN kernel header */
>+
>+#ifndef _LINUX_ULP_DDP_GEN_H
>+#define _LINUX_ULP_DDP_GEN_H
>+
>+#include <net/netlink.h>
>+#include <net/genetlink.h>
>+
>+#include <uapi/linux/ulp_ddp_nl.h>
>+
>+int ulp_ddp_get_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
>+		       struct genl_info *info);
>+void
>+ulp_ddp_put_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
>+		   struct genl_info *info);
>+
>+int ulp_ddp_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
>+int ulp_ddp_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
>+int ulp_ddp_nl_stats_doit(struct sk_buff *skb, struct genl_info *info);
>+int ulp_ddp_nl_stats_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
>+int ulp_ddp_nl_set_doit(struct sk_buff *skb, struct genl_info *info);
>+
>+enum {
>+	ULP_DDP_NLGRP_MGMT,
>+};
>+
>+extern struct genl_family ulp_ddp_nl_family;
>+
>+#endif /* _LINUX_ULP_DDP_GEN_H */
>diff --git a/net/core/ulp_ddp_nl.c b/net/core/ulp_ddp_nl.c
>new file mode 100644
>index 000000000000..55e5c51b6d88
>--- /dev/null
>+++ b/net/core/ulp_ddp_nl.c
>@@ -0,0 +1,388 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * ulp_ddp.c
>+ *    Author: Aurelien Aptel <aaptel@nvidia.com>
>+ *    Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
>+ */
>+#include <net/ulp_ddp.h>
>+#include "ulp_ddp_gen_nl.h"
>+
>+#define ULP_DDP_STATS_CNT (sizeof(struct netlink_ulp_ddp_stats) / sizeof(u64))
>+
>+struct reply_data {

Some sane prefix for structs and fuctions would be nice. That applies to
the whole code.

What's "data"? Reading the code, this sounds very vague. Try to be more
precise in struct and functions naming.



>+	struct net_device *dev;
>+	netdevice_tracker tracker;
>+	void *hdr;
>+	u32 ifindex;
>+	DECLARE_BITMAP(hw, ULP_DDP_C_COUNT);
>+	DECLARE_BITMAP(active, ULP_DDP_C_COUNT);
>+	struct netlink_ulp_ddp_stats stats;
>+};
>+
>+static size_t reply_size(int cmd)
>+{
>+	size_t len = 0;
>+
>+	BUILD_BUG_ON(ULP_DDP_C_COUNT > 64);
>+
>+	/* ifindex */
>+	len += nla_total_size(sizeof(u32));
>+
>+	switch (cmd) {
>+	case ULP_DDP_CMD_GET:
>+	case ULP_DDP_CMD_SET:
>+	case ULP_DDP_CMD_SET_NTF:
>+		/* hw */
>+		len += nla_total_size_64bit(sizeof(u64));
>+
>+		/* active */
>+		len += nla_total_size_64bit(sizeof(u64));
>+		break;
>+	case ULP_DDP_CMD_STATS:
>+		/* stats */
>+		len += nla_total_size_64bit(sizeof(u64)) * ULP_DDP_STATS_CNT;
>+		break;
>+	}
>+
>+	return len;
>+}
>+
>+/* pre_doit */
>+int ulp_ddp_get_netdev(const struct genl_split_ops *ops,
>+		       struct sk_buff *skb, struct genl_info *info)

Could you perhaps check ulp_ddp_caps here instead of doing it on multiple
places over and over. Of course fill-up a proper extack message in case
the check fails.

Note that after this change you need to check the ops where you iterate
over netdevs (in dumps) too.


>+{
>+	struct reply_data *data;
>+
>+	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_DEV_IFINDEX))
>+		return -EINVAL;
>+
>+	data = kzalloc(sizeof(*data), GFP_KERNEL);
>+	if (!data)
>+		return -ENOMEM;
>+
>+	data->ifindex = nla_get_u32(info->attrs[ULP_DDP_A_DEV_IFINDEX]);
>+	data->dev = netdev_get_by_index(genl_info_net(info),
>+					data->ifindex,
>+					&data->tracker,
>+					GFP_KERNEL);
>+	if (!data->dev) {
>+		kfree(data);
>+		NL_SET_BAD_ATTR(info->extack,
>+				info->attrs[ULP_DDP_A_DEV_IFINDEX]);

Fill-up a meaningful extack message as well please using
NL_SET_ERR_MSG()


>+		return -ENOENT;

		return -ENODEV;
Maybe?


>+	}
>+
>+	info->user_ptr[0] = data;
>+	return 0;
>+}
>+
>+/* post_doit */
>+void ulp_ddp_put_netdev(const struct genl_split_ops *ops, struct sk_buff *skb,
>+			struct genl_info *info)
>+{
>+	struct reply_data *data = info->user_ptr[0];
>+
>+	if (data) {

How "data" could be NULL here?

>+		if (data->dev)

How "data->dev" could be NULL here?


>+			netdev_put(data->dev, &data->tracker);
>+		kfree(data);
>+	}
>+}
>+
>+static int prepare_data(struct reply_data *data, int cmd)
>+{
>+	const struct ulp_ddp_dev_ops *ops = data->dev->netdev_ops->ulp_ddp_ops;
>+	struct ulp_ddp_netdev_caps *caps = &data->dev->ulp_ddp_caps;
>+
>+	if (!ops)
>+		return -EOPNOTSUPP;
>+
>+	switch (cmd) {
>+	case ULP_DDP_CMD_GET:
>+	case ULP_DDP_CMD_SET:
>+	case ULP_DDP_CMD_SET_NTF:
>+		bitmap_copy(data->hw, caps->hw, ULP_DDP_C_COUNT);
>+		bitmap_copy(data->active, caps->active, ULP_DDP_C_COUNT);
>+		break;
>+	case ULP_DDP_CMD_STATS:
>+		ops->get_stats(data->dev, &data->stats);
>+		break;
>+	}
>+
>+	return 0;
>+}
>+
>+static int fill_data(struct sk_buff *rsp, struct reply_data *data, int cmd,
>+		     const struct genl_info *info)
>+{
>+	u64 *val = (u64 *)&data->stats;

Ugh.


>+	int attr, i;
>+
>+	data->hdr = genlmsg_iput(rsp, info);
>+	if (!data->hdr)
>+		return -EMSGSIZE;
>+
>+	switch (cmd) {
>+	case ULP_DDP_CMD_GET:
>+	case ULP_DDP_CMD_SET:
>+	case ULP_DDP_CMD_SET_NTF:
>+		if (nla_put_u32(rsp, ULP_DDP_A_DEV_IFINDEX, data->ifindex) ||
>+		    nla_put_u64_64bit(rsp, ULP_DDP_A_DEV_HW,
>+				      data->hw[0], ULP_DDP_A_DEV_PAD) ||
>+		    nla_put_u64_64bit(rsp, ULP_DDP_A_DEV_ACTIVE,
>+				      data->active[0], ULP_DDP_A_DEV_PAD))
>+			goto err_cancel_msg;
>+		break;
>+	case ULP_DDP_CMD_STATS:
>+		if (nla_put_u32(rsp, ULP_DDP_A_STAT_IFINDEX, data->ifindex))
>+			goto err_cancel_msg;
>+
>+		attr = ULP_DDP_A_STAT_PAD + 1;

Ugh again.


>+		for (i = 0; i < ULP_DDP_STATS_CNT; i++, attr++)
>+			if (nla_put_u64_64bit(rsp, attr, val[i],

This rely on a struct layout is dangerous and may easily lead in future
to put attrs which are not define in enum. Please properly put each stat
by using attr enum value.


>+					      ULP_DDP_A_STAT_PAD))
>+				goto err_cancel_msg;
>+	}
>+	genlmsg_end(rsp, data->hdr);
>+
>+	return 0;
>+
>+err_cancel_msg:
>+	genlmsg_cancel(rsp, data->hdr);
>+
>+	return -EMSGSIZE;
>+}
>+
>+int ulp_ddp_nl_get_doit(struct sk_buff *req, struct genl_info *info)
>+{
>+	struct reply_data *data = info->user_ptr[0];
>+	struct sk_buff *rsp;
>+	int ret = 0;
>+
>+	ret = prepare_data(data, ULP_DDP_CMD_GET);
>+	if (ret)
>+		return ret;
>+
>+	rsp = genlmsg_new(reply_size(ULP_DDP_CMD_GET), GFP_KERNEL);
>+	if (!rsp)
>+		return -EMSGSIZE;
>+
>+	ret = fill_data(rsp, data, ULP_DDP_CMD_GET, info);
>+	if (ret < 0)
>+		goto err_rsp;
>+
>+	return genlmsg_reply(rsp, info);
>+
>+err_rsp:
>+	nlmsg_free(rsp);
>+	return ret;
>+}
>+
>+static void ulp_ddp_nl_notify_dev(struct reply_data *data)
>+{
>+	struct genl_info info;
>+	struct sk_buff *ntf;
>+
>+	if (!genl_has_listeners(&ulp_ddp_nl_family, dev_net(data->dev),
>+				ULP_DDP_NLGRP_MGMT))
>+		return;
>+
>+	genl_info_init_ntf(&info, &ulp_ddp_nl_family, ULP_DDP_CMD_SET_NTF);
>+	ntf = genlmsg_new(reply_size(ULP_DDP_CMD_GET), GFP_KERNEL);
>+	if (!ntf)
>+		return;
>+
>+	if (fill_data(ntf, data, ULP_DDP_CMD_SET_NTF, &info)) {
>+		nlmsg_free(ntf);
>+		return;
>+	}
>+
>+	genlmsg_multicast_netns(&ulp_ddp_nl_family, dev_net(data->dev), ntf,
>+				0, ULP_DDP_NLGRP_MGMT, GFP_KERNEL);
>+}
>+
>+static int apply_bits(struct reply_data *data,
>+		      unsigned long *req_wanted,
>+		      unsigned long *req_mask,
>+		      struct netlink_ext_ack *extack)
>+{
>+	DECLARE_BITMAP(old_active, ULP_DDP_C_COUNT);
>+	DECLARE_BITMAP(new_active, ULP_DDP_C_COUNT);
>+	DECLARE_BITMAP(all_bits, ULP_DDP_C_COUNT);
>+	DECLARE_BITMAP(tmp, ULP_DDP_C_COUNT);
>+	const struct ulp_ddp_dev_ops *ops;
>+	struct ulp_ddp_netdev_caps *caps;
>+	int ret;
>+
>+	caps = &data->dev->ulp_ddp_caps;
>+	ops = data->dev->netdev_ops->ulp_ddp_ops;
>+
>+	if (!ops)
>+		return -EOPNOTSUPP;
>+
>+	/* if (req_mask & ~all_bits) */
>+	bitmap_fill(all_bits, ULP_DDP_C_COUNT);
>+	bitmap_andnot(tmp, req_mask, all_bits, ULP_DDP_C_COUNT);
>+	if (!bitmap_empty(tmp, ULP_DDP_C_COUNT))

Please make sure you always fillup a proper extack message, always.


>+		return -EINVAL;
>+
>+	/* new_active = (old_active & ~req_mask) | (wanted & req_mask)
>+	 * new_active &= caps_hw
>+	 */
>+	bitmap_copy(old_active, caps->active, ULP_DDP_C_COUNT);
>+	bitmap_and(req_wanted, req_wanted, req_mask, ULP_DDP_C_COUNT);
>+	bitmap_andnot(new_active, old_active, req_mask, ULP_DDP_C_COUNT);
>+	bitmap_or(new_active, new_active, req_wanted, ULP_DDP_C_COUNT);
>+	bitmap_and(new_active, new_active, caps->hw, ULP_DDP_C_COUNT);
>+	if (!bitmap_equal(old_active, new_active, ULP_DDP_C_COUNT)) {
>+		ret = ops->set_caps(data->dev, new_active, extack);
>+		if (ret < 0)
>+			return ret;
>+		bitmap_copy(new_active, caps->active, ULP_DDP_C_COUNT);
>+	}
>+
>+	/* return 1 to notify */
>+	return !bitmap_equal(old_active, new_active, ULP_DDP_C_COUNT);
>+}
>+
>+int ulp_ddp_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
>+{
>+	struct reply_data *data = info->user_ptr[0];
>+	unsigned long wanted, wanted_mask;
>+	struct sk_buff *rsp;
>+	bool notify;
>+	int ret;
>+
>+	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_DEV_WANTED) ||
>+	    GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_DEV_WANTED_MASK))
>+		return -EINVAL;
>+
>+	rsp = genlmsg_new(reply_size(ULP_DDP_CMD_STATS), GFP_KERNEL);
>+	if (!rsp)
>+		return -EMSGSIZE;
>+
>+	wanted = nla_get_u64(info->attrs[ULP_DDP_A_DEV_WANTED]);
>+	wanted_mask = nla_get_u64(info->attrs[ULP_DDP_A_DEV_WANTED_MASK]);
>+
>+	ret = apply_bits(data, &wanted, &wanted_mask, info->extack);
>+	if (ret < 0)
>+		goto err_rsp;
>+
>+	notify = !!ret;
>+	ret = prepare_data(data, ULP_DDP_CMD_SET);

Why you send it back for set? (leaving notify aside)


>+	if (ret)
>+		goto err_rsp;
>+
>+	ret = fill_data(rsp, data, ULP_DDP_CMD_SET, info);
>+	if (ret < 0)
>+		goto err_rsp;
>+
>+	ret = genlmsg_reply(rsp, info);
>+	if (notify)
>+		ulp_ddp_nl_notify_dev(data);
>+
>+	return ret;
>+
>+err_rsp:
>+	nlmsg_free(rsp);
>+
>+	return ret;
>+}
>+
>+int ulp_ddp_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>+{
>+	struct net *net = sock_net(skb->sk);
>+	struct net_device *netdev;
>+	struct reply_data data;
>+	int err = 0;
>+
>+	rtnl_lock();
>+	for_each_netdev_dump(net, netdev, cb->args[0]) {

Is this function necessary? I mean, do you have usecase to dump the
the caps for all devices in the netns? If no, remove this dump op.
If yes, could you please do it without holding rtnl? You don't need rtnl
for do ops either.


>+		memset(&data, 0, sizeof(data));
>+		data.dev = netdev;
>+		data.ifindex = netdev->ifindex;
>+
>+		err = prepare_data(&data, ULP_DDP_CMD_GET);
>+		if (err)
>+			continue;
>+
>+		err = fill_data(skb, &data, ULP_DDP_CMD_GET,
>+				genl_info_dump(cb));
>+		if (err < 0)
>+			break;
>+	}
>+	rtnl_unlock();
>+
>+	if (err != -EMSGSIZE)

Doing dump into a single skb means you don't care about scale. That's
wrong.


>+		return err;
>+
>+	return skb->len;
>+}
>+
>+int ulp_ddp_nl_stats_doit(struct sk_buff *skb, struct genl_info *info)
>+{
>+	struct reply_data *data = info->user_ptr[0];
>+	struct sk_buff *rsp;
>+	int ret = 0;
>+
>+	ret = prepare_data(data, ULP_DDP_CMD_STATS);
>+	if (ret)
>+		return ret;
>+
>+	rsp = genlmsg_new(reply_size(ULP_DDP_CMD_STATS), GFP_KERNEL);
>+	if (!rsp)
>+		return -EMSGSIZE;
>+
>+	ret = fill_data(rsp, data, ULP_DDP_CMD_STATS, info);
>+	if (ret < 0)
>+		goto err_rsp;
>+
>+	return genlmsg_reply(rsp, info);
>+
>+err_rsp:
>+	nlmsg_free(rsp);
>+	return ret;
>+}
>+
>+int ulp_ddp_nl_stats_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>+{
>+	struct net *net = sock_net(skb->sk);
>+	struct net_device *netdev;
>+	struct reply_data data;
>+	int err = 0;
>+
>+	rtnl_lock();
>+	for_each_netdev_dump(net, netdev, cb->args[0]) {

Is this function necessary? I mean, do you have usecase to dump the
stats for all devices in the netns? If no, remove this dump op.
If yes, could you please do it without holding rtnl? You don't need rtnl
for do ops either.


>+		memset(&data, 0, sizeof(data));
>+		data.dev = netdev;
>+		data.ifindex = netdev->ifindex;
>+
>+		err = prepare_data(&data, ULP_DDP_CMD_STATS);
>+		if (err)
>+			continue;
>+
>+		err = fill_data(skb, &data, ULP_DDP_CMD_STATS,
>+				genl_info_dump(cb));
>+		if (err < 0)
>+			break;
>+	}
>+	rtnl_unlock();
>+
>+	if (err != -EMSGSIZE)

Doing dump into a single skb means you don't care about scale. That's
wrong.


>+		return err;
>+
>+	return skb->len;
>+}
>+
>+static int __init ulp_ddp_init(void)
>+{
>+	int err;
>+
>+	err = genl_register_family(&ulp_ddp_nl_family);
>+	if (err)
>+		return err;
>+
>+	return 0;

The whole function reduces just to:
	return genl_register_family(&ulp_ddp_nl_family);


>+}
>+
>+subsys_initcall(ulp_ddp_init);
>-- 
>2.34.1
>
>

