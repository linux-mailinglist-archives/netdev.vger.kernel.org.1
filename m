Return-Path: <netdev+bounces-107463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF8991B197
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5CB283D5E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 21:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244221A08A1;
	Thu, 27 Jun 2024 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIDj2jxI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38EE1A0724
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524156; cv=none; b=T8klYao7Mo6xCf4BcsvPwM8g72/GsIgY/YpTs+gisXgjBPQGSgvf3pcWYvZm0B59pjY8Ruztvj7LmUnVFWu3LBeYJo6LZF/lARvEqWElWz9dEeKWlzLK0ErnMNFSlAQe284ITXVfWTt/sMGqU7MS7Mfudw5t6IimwbNJvIEHo0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524156; c=relaxed/simple;
	bh=FmEb1IlmTgKbehtsCxQdhAC+WEPKFbwTEdWKNhnO1vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bErZHOSzuL5rbyEwSIXAJqFvW636ucP66jlt7ekRFgd5iKjKeqs9sKLXmfRyek5RG5n0h2BWOEhCRcMoDaiyDkf1iUU/+5zrMYFfQGe3P4pCse2SlsA6e5DXrSHAclIUVpgCXEsSvZMcWnzadd7zIwA5Rq+FN82/GZBS8ib8DAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIDj2jxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410A1C4AF07;
	Thu, 27 Jun 2024 21:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719524155;
	bh=FmEb1IlmTgKbehtsCxQdhAC+WEPKFbwTEdWKNhnO1vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tIDj2jxIUdm8pOdpEOCbU11Tfig+gk72GzQ9FFhKuFivufKVE4DwnMdzT9mt4Ps03
	 gcfYO/SzCHEwRzfi/7qCHYy9cWrS1Wclxt/ScDwBc2nxvtx1g2hTdcvBep4K+1AL2p
	 3uRaHlS9E4cJYS8ER5Q3BnI8qGn92reUQrL7z6ljI4pDFuP9X6G62DsYJ1VkLn530g
	 m8+CZco1+8KuT5/Lrlx+LJaD+m6vElmlOoIt6QpLR5MrXIEPJR3rf6Z+Im+bR8Xsj7
	 /Z6B/KB0uA3gvKfilOWrsyv75V1fKZxesLArHh6SiU7DTfo4UBKGYYZalxUbRYvjPl
	 BBFQkTMXZUWkg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/2] tcp_metrics: add netlink protocol spec in YAML
Date: Thu, 27 Jun 2024 14:35:51 -0700
Message-ID: <20240627213551.3147327-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627213551.3147327-1-kuba@kernel.org>
References: <20240627213551.3147327-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a protocol spec for tcp_metrics, so that it's accessible via YNL.
Useful at the very least for testing fixes.

In this episode of "10,000 ways to complicate netlink" the metric
nest has defines which are off by 1. iproute2 does:

        struct rtattr *m[TCP_METRIC_MAX + 1 + 1];

        parse_rtattr_nested(m, TCP_METRIC_MAX + 1, a);

        for (i = 0; i < TCP_METRIC_MAX + 1; i++) {
                // ...
                attr = m[i + 1];

This is too weird to support in YNL, add a new set of defines
with _correct_ values to the official kernel header.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com

v2:
 - remove unused unspec op and attr (TCP_METRICS_ATTR_UNSPEC and
   TCP_METRICS_CMD_UNSPEC exist, but we can't generate uAPI, anyway)
 - fix typos
 - s/_/-/ on metric names
 - correct doc on rttvar-us (like rttvar there are 2 fractional bits)
---
 Documentation/netlink/specs/tcp_metrics.yaml | 169 +++++++++++++++++++
 include/uapi/linux/tcp_metrics.h             |  16 ++
 tools/net/ynl/Makefile.deps                  |   1 +
 3 files changed, 186 insertions(+)
 create mode 100644 Documentation/netlink/specs/tcp_metrics.yaml

diff --git a/Documentation/netlink/specs/tcp_metrics.yaml b/Documentation/netlink/specs/tcp_metrics.yaml
new file mode 100644
index 000000000000..1bd94f43e526
--- /dev/null
+++ b/Documentation/netlink/specs/tcp_metrics.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: tcp_metrics
+
+protocol: genetlink-legacy
+
+doc: |
+  Management interface for TCP metrics.
+
+c-family-name: tcp-metrics-genl-name
+c-version-name: tcp-metrics-genl-version
+max-by-define: true
+kernel-policy: global
+
+definitions:
+  -
+    name: tcp-fastopen-cookie-max
+    type: const
+    value: 16
+
+attribute-sets:
+  -
+    name: tcp-metrics
+    name-prefix: tcp-metrics-attr-
+    attributes:
+      -
+        name: addr-ipv4
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: addr-ipv6
+        type: binary
+        checks:
+          min-len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+      -
+        name: age
+        type: u64
+      -
+        name: tw-tsval
+        type: u32
+        doc: unused
+      -
+        name: tw-ts-stamp
+        type: s32
+        doc: unused
+      -
+        name: vals
+        type: nest
+        nested-attributes: metrics
+      -
+        name: fopen-mss
+        type: u16
+      -
+        name: fopen-syn-drops
+        type: u16
+      -
+        name: fopen-syn-drop-ts
+        type: u64
+      -
+        name: fopen-cookie
+        type: binary
+        checks:
+          min-len: tcp-fastopen-cookie-max
+      -
+        name: saddr-ipv4
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: saddr-ipv6
+        type: binary
+        checks:
+          min-len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+      -
+        name: pad
+        type: pad
+
+  -
+    name: metrics
+    # Intentionally don't define the name-prefix, see below.
+    doc: |
+      Attributes with metrics. Note that the values here do not match
+      the TCP_METRIC_* defines in the kernel, because kernel defines
+      are off-by one (e.g. rtt is defined as enum 0, while netlink carries
+      attribute type 1).
+    attributes:
+      -
+        name: rtt
+        type: u32
+        doc: |
+          Round Trip Time (RTT), in msecs with 3 bits fractional
+          (left-shift by 3 to get the msec value).
+      -
+        name: rttvar
+        type: u32
+        doc: |
+          Round Trip Time VARiance (RTT), in msecs with 2 bits fractional
+          (left-shift by 2 to get the msec value).
+      -
+        name: ssthresh
+        type: u32
+        doc: Slow Start THRESHold.
+      -
+        name: cwnd
+        type: u32
+        doc: Congestion Window.
+      -
+        name: reodering
+        type: u32
+        doc: Reodering metric.
+      -
+        name: rtt-us
+        type: u32
+        doc: |
+          Round Trip Time (RTT), in usecs, with 3 bits fractional
+          (left-shift by 3 to get the msec value).
+      -
+        name: rttvar-us
+        type: u32
+        doc: |
+          Round Trip Time (RTT), in usecs, with 2 bits fractional
+          (left-shift by 3 to get the msec value).
+
+operations:
+  list:
+    -
+      name: get
+      doc: Retrieve metrics.
+      attribute-set: tcp-metrics
+
+      dont-validate: [ strict, dump ]
+
+      do:
+        request: &sel_attrs
+          attributes:
+            - addr-ipv4
+            - addr-ipv6
+            - saddr-ipv4
+            - saddr-ipv6
+        reply: &all_attrs
+          attributes:
+            - addr-ipv4
+            - addr-ipv6
+            - saddr-ipv4
+            - saddr-ipv6
+            - age
+            - vals
+            - fopen-mss
+            - fopen-syn-drops
+            - fopen-syn-drop-ts
+            - fopen-cookie
+      dump:
+        reply: *all_attrs
+
+    -
+      name: del
+      doc: Delete metrics.
+      attribute-set: tcp-metrics
+
+      dont-validate: [ strict, dump ]
+      flags: [ admin-perm ]
+
+      do:
+        request: *sel_attrs
diff --git a/include/uapi/linux/tcp_metrics.h b/include/uapi/linux/tcp_metrics.h
index c48841076998..927c735a5b0e 100644
--- a/include/uapi/linux/tcp_metrics.h
+++ b/include/uapi/linux/tcp_metrics.h
@@ -27,6 +27,22 @@ enum tcp_metric_index {
 
 #define TCP_METRIC_MAX	(__TCP_METRIC_MAX - 1)
 
+/* Re-define enum tcp_metric_index, again, using the values carried
+ * as netlink attribute types.
+ */
+enum {
+	TCP_METRICS_A_METRICS_RTT = 1,
+	TCP_METRICS_A_METRICS_RTTVAR,
+	TCP_METRICS_A_METRICS_SSTHRESH,
+	TCP_METRICS_A_METRICS_CWND,
+	TCP_METRICS_A_METRICS_REODERING,
+	TCP_METRICS_A_METRICS_RTT_US,
+	TCP_METRICS_A_METRICS_RTTVAR_US,
+
+	__TCP_METRICS_A_METRICS_MAX
+};
+#define TCP_METRICS_A_METRICS_MAX (__TCP_METRICS_A_METRICS_MAX - 1)
+
 enum {
 	TCP_METRICS_ATTR_UNSPEC,
 	TCP_METRICS_ATTR_ADDR_IPV4,		/* u32 */
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index f4e8eb79c1b8..33399fbe9851 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -25,3 +25,4 @@ CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
 CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
+CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
-- 
2.45.2


