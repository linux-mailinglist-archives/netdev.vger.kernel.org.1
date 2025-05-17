Return-Path: <netdev+bounces-191249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E9DABA753
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C191787D6
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A261976026;
	Sat, 17 May 2025 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E94Q1d3+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9084B1E7F
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440817; cv=none; b=clTSWKJ51jReWoBG0TbVnJ+1RwvMJInHrWgNaSRWJZ94YZQENx4cHlqsrVTRmjJtD7/WvO/sgLs/afEYGeF7N5qns7Vkzx44XA8/8tGvLDa/gAmnntHH+sBIuO0fJswhrGPdBKtt4SmktBCcb8LShbrXhgULRwvaXjJhYQ/uu0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440817; c=relaxed/simple;
	bh=Jpc0MDJD2nuA+CTEkw/7+9HGg5jUTag8yPwVq1VkrU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyfH1XXEbmDvCWop++9ED17ml9OseXrWYA1So6Ggp6WdRXyIJRab6K8HN5VrjxxcRyt7ZkMpaX6kFvNt5iyTW6sru3qQ53m/pM3cRBOxf6BeFLPCw3P/CftFOVwT8YHCXJ6Pog9x0ihYHZ03UfwaR7diFuiTsdYHQiA/gY4VA84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E94Q1d3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94E4C4CEE9;
	Sat, 17 May 2025 00:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747440817;
	bh=Jpc0MDJD2nuA+CTEkw/7+9HGg5jUTag8yPwVq1VkrU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E94Q1d3+cGVwPxdCTlWXv64fqIaDd8ByV4HwwweKaw45cK0u/NMnA9n9tb7RDcNDU
	 poXKtVf08wwDfns/KMIJNZygGFWdBinOAq9veyYxEtgfgVnVtDeIhpP0LNdv+biQRt
	 MMKb4D6wRsorkZJdMacNj7FBulbhIZJaLx7HEvt2tDto6xb9QTVxV8ckhXPfX6KMn3
	 Y5d5v7weGlqnUKUELaS3zSjpZE/D5lJqeNpspgRXbELx5QEYGpWr2g3n/haT/+T5fb
	 KsvXkycPSAkVA6O0jKTaqeqMNk6if+gYtvGMGkR2jRbtsZblHt6ZAoyogXr05w63dm
	 uFPVsl1ox0uCQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 11/11] tools: ynl: add a sample for TC
Date: Fri, 16 May 2025 17:13:18 -0700
Message-ID: <20250517001318.285800-12-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250517001318.285800-1-kuba@kernel.org>
References: <20250517001318.285800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a very simple TC dump sample with decoding of fq_codel attrs:

  # ./tools/net/ynl/samples/tc
        dummy0: fq_codel  limit: 10240p target: 5ms new_flow_cnt: 0

proving that selector passing (for stats) works.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/samples/tc.c       | 80 ++++++++++++++++++++++++++++++++
 tools/net/ynl/samples/.gitignore |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 tools/net/ynl/samples/tc.c

diff --git a/tools/net/ynl/samples/tc.c b/tools/net/ynl/samples/tc.c
new file mode 100644
index 000000000000..0bfff0fdd792
--- /dev/null
+++ b/tools/net/ynl/samples/tc.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+
+#include <ynl.h>
+
+#include <net/if.h>
+
+#include "tc-user.h"
+
+static void tc_qdisc_print(struct tc_getqdisc_rsp *q)
+{
+	char ifname[IF_NAMESIZE];
+	const char *name;
+
+	name = if_indextoname(q->_hdr.tcm_ifindex, ifname);
+	if (name)
+		printf("%16s: ", name);
+
+	if (q->_len.kind) {
+		printf("%s  ", q->kind);
+
+		if (q->options._present.fq_codel) {
+			struct tc_fq_codel_attrs *fq_codel;
+			struct tc_fq_codel_xstats *stats;
+
+			fq_codel = &q->options.fq_codel;
+			stats = q->stats2.app.fq_codel;
+
+			if (fq_codel->_present.limit)
+				printf("limit: %dp ", fq_codel->limit);
+			if (fq_codel->_present.target)
+				printf("target: %dms ",
+				       (fq_codel->target + 500) / 1000);
+			if (q->stats2.app._len.fq_codel)
+				printf("new_flow_cnt: %d ",
+				       stats->qdisc_stats.new_flow_count);
+		}
+	}
+
+	printf("\n");
+}
+
+int main(int argc, char **argv)
+{
+	struct tc_getqdisc_req_dump *req;
+	struct tc_getqdisc_list *rsp;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+
+	ys = ynl_sock_create(&ynl_tc_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return 1;
+	}
+
+	req = tc_getqdisc_req_dump_alloc();
+	if (!req)
+		goto err_destroy;
+
+	rsp = tc_getqdisc_dump(ys, req);
+	tc_getqdisc_req_dump_free(req);
+	if (!rsp)
+		goto err_close;
+
+	if (ynl_dump_empty(rsp))
+		fprintf(stderr, "Error: no addresses reported\n");
+	ynl_dump_foreach(rsp, qdisc)
+		tc_qdisc_print(qdisc);
+	tc_getqdisc_list_free(rsp);
+
+	ynl_sock_destroy(ys);
+	return 0;
+
+err_close:
+	fprintf(stderr, "YNL: %s\n", ys->err.msg);
+err_destroy:
+	ynl_sock_destroy(ys);
+	return 2;
+}
diff --git a/tools/net/ynl/samples/.gitignore b/tools/net/ynl/samples/.gitignore
index b3ec3fb0929f..7f5fca7682d7 100644
--- a/tools/net/ynl/samples/.gitignore
+++ b/tools/net/ynl/samples/.gitignore
@@ -6,3 +6,4 @@ page-pool
 rt-addr
 rt-link
 rt-route
+tc
-- 
2.49.0


