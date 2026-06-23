Return-Path: <netdev+bounces-301449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QawUFjbJOmq0GwgAu9opvQ
	(envelope-from <netdev+bounces-301449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:58:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B61506B94D6
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:58:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Hr/2YKJY";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301449-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301449-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1009316246E
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A438D41F;
	Tue, 23 Jun 2026 17:50:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8B3911C5
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:50:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237033; cv=none; b=T1WsXFh81wkJJtjqeqUoeCzY7zP8pL91Cd1oUwnnDqm1y4SbcFm/ZKATPhpuB5dVOvYbNGdXaYvg34uQPVnKcjrL7RCiKEIDBXIPcJWDoZDxEn2jM7eVilGWjaxOpBygGx+F5Kd9pmtOYNNR0jkHRfiwkSGjI5FDV/jmJt4lPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237033; c=relaxed/simple;
	bh=d9TPsnvXypKnPRphhqkUPKWcpDA4IJWN45fonzkL5Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhUDkhDuB/v6ukJL2GAHZlTCpPNe+QpsiJUUGZtqwxqf8SuaMZkwwUsSGs99dDFs2ijNR1EG+JYDtjIfGPu0Yj2Df81XHzhoxCByHkVYkFyFRD6ROdcjXAMWTIGA8D1UlaaoWl8XBKPZgMh8tvdl36EffAYaIFcujbELdnnz5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hr/2YKJY; arc=none smtp.client-ip=209.85.161.52
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69d7aa0ac14so115370eaf.3
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237029; x=1782841829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYCss9r/dMhNKSAxZK/JPmCUJLjqEzp9b6ZlVS1pUZU=;
        b=Hr/2YKJYW7uOoC1Wx0eJS9X/v8507ggxgIz7RBTNH7WkcVLUQ/N/sQlS0OgjbrkkXj
         TNdiPjcteMJezT8lrRnGTpSl2cEXVKQuZrJ9/H5LK4XWmoLakyaWX0pFZ6UDaILCs1Tb
         KcmwNN5DGjgxbJqUy5YM9vsldSoYR6CtS6EgcKw66DcgeR345L0K+VCKo/rnEhgkKrtQ
         UdYbKG7LNOztODybB1gcHSwlPIxGd4NcBpG1Lmply3c9euJmfCBVH3pCALaNLYfObLUv
         K5dslX3tq1gYOFIMgXSFN/CBvYIqyrt0JHoKdnMpwgMdZQaOnEFCpb8BXmGpY+ewyg6G
         tLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237029; x=1782841829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kYCss9r/dMhNKSAxZK/JPmCUJLjqEzp9b6ZlVS1pUZU=;
        b=LCb1nXxnjhmxQ2VVgqCxu4bV+YloNOjEvpuAJ5GCS4djpsKkPbaA3Vo16zmkXbYgAE
         0sdLFABXKgJgeDh93Xf/kkRMcxgVgv2dmp+T6oH/e4lCy/Jj5pkHMTLI36JZF2Gzvvxc
         k4jZHIUtCiot6wsG4iN5TmemcMTUWzEc9xrEiB3RlcnklcYyeaPUkXzX9ftzCRvcTCZP
         n12R5nfXwjR1JoWJmXeDN1ttqvNRa95+VvYob11A302/B680H5sdFdZrtpivtR69k1rp
         TpkQwys3tZK4wporS8n6Q8OegTDG67AfsrwLJzp48h8868Y8UoMLScbeyrrvxZXxAj5Q
         Y0ZA==
X-Gm-Message-State: AOJu0Yy7w42XmFelj7CBtnnJeMWjLlS8BnUTXE6Nmw6NxLLNxOv4h99s
	YczsqIkBkiI7qhLcYIQyjiHUZE9jT/JVnDg9tmAc4ZUhJUa9XkOTJ+OM
X-Gm-Gg: AfdE7ckO+sj6TafhfPCzcoZF//w4Vjf6v8+nAFknyo9yh2g87z0IBzzkh+s9WGyyM80
	KkKvb8Qltly7zKH+F5VFOXqUhOSKFa23f7PeQRk7RmDYzXQR8m4B75pf/iuXcTGla3+xuK//iZg
	2rPmkYSdc19k/bIzO/K+yiiMe7VmyKPoaftnPwedkRZe2tSPHXmJ3dYIexqSuM4DKqWVS4vbUmP
	FECrCF588q/cBw3zSyo/zi0bYNId3l35YaIY/uGIRqccUh3uEMxI1KGkInMSCFcfOVermVSdLn0
	STY0MAjVMrW/L9OEnATFC10JO+zeX/U8gEPd5zL0UsvjzPDMMY8FYvfNbokX5RfoKpLtyiAZfuK
	DJ5MHdb2qUpqTG3WFYY2i08dnlFn+OepqyeWLYeF6omvuSI67qcrNy1ZZgROgX5jVcLgTLrRGem
	PFcA==
X-Received: by 2002:a05:6820:4b01:b0:69d:8700:c925 with SMTP id 006d021491bc7-6a0eb2bb79bmr11067808eaf.8.1782237029351;
        Tue, 23 Jun 2026 10:50:29 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472ecd3b51sm8879588fac.7.2026.06.23.10.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:28 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 14/15] selftests/bpf: Test attaching struct_ops to a cgroup
Date: Tue, 23 Jun 2026 10:50:02 -0700
Message-ID: <20260623175006.3136053-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-301449-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B61506B94D6

From: Martin KaFai Lau <martin.lau@kernel.org>

Exercise attaching the bpf_tcp_ops struct_ops to cgroups via the generic
cgroup link infrastructure. The struct_ops instances record their
execution order and the previous return value to validate correctness.

Subtests:
- query:        BPF_F_QUERY_EFFECTIVE and attached query return the maps
- order:        BPF_F_PREORDER vs attach order within a cgroup
- before_after: BPF_F_BEFORE/BPF_F_AFTER relative positioning
- update:       bpf_link__update_map swaps a link's map, keeping its slot
- retval:       int return value chained across timeout_init progs of
                multiple bpf_tcp_ops attached to a cgroup
- hierarchy:    parent and child attachments merge in the child's
                effective array (descendant before ancestor)
- inherit:      a child created after the attach inherits the parent's
                prog

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ops.c    | 554 ++++++++++++++++++
 .../testing/selftests/bpf/progs/bpf_tcp_ops.c | 141 +++++
 2 files changed, 695 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
new file mode 100644
index 000000000000..4d087bdc4613
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <bpf/btf.h>
+#include "cgroup_helpers.h"
+#include "bpf_tcp_ops.skel.h"
+
+#define CGROUP_PATH	"/bpf_tcp_ops"
+#define TEST_NETNS	"bpf_tcp_ops"
+
+static __s32 get_bpf_tcp_ops_type_id(void)
+{
+	struct btf *vmlinux_btf;
+	__s32 type_id;
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "load_vmlinux_btf"))
+		return -1;
+
+	type_id = btf__find_by_name_kind(vmlinux_btf, "bpf_tcp_ops", BTF_KIND_STRUCT);
+	btf__free(vmlinux_btf);
+
+	ASSERT_GT(type_id, 0, "find_bpf_tcp_ops");
+	return type_id;
+}
+
+static void reset_order(struct bpf_tcp_ops *skel)
+{
+	memset(skel->bss->listen_order, 0, sizeof(skel->bss->listen_order));
+	memset(skel->bss->connect_order, 0, sizeof(skel->bss->connect_order));
+	skel->bss->listen_cnt = 0;
+	skel->bss->connect_cnt = 0;
+}
+
+static void do_listen_connect(int family)
+{
+	const char *addr = family == AF_INET ? "127.0.0.1" : "::1";
+	int server_fd, client_fd;
+
+	server_fd = start_server(family, SOCK_STREAM, addr, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (ASSERT_OK_FD(client_fd, "connect_to_fd"))
+		close(client_fd);
+
+	close(server_fd);
+}
+
+/*
+ * Attach ops1 and ops2 normally (in that order), then ops3 with
+ * BPF_F_PREORDER. Expected execution order: [3, 1, 2] — ops3 runs
+ * first despite being attached last, ops1 before ops2 by attach order.
+ */
+static void test_order(int cgroup_fd, struct bpf_tcp_ops *skel, int family)
+{
+	LIBBPF_OPTS(bpf_cgroup_opts, preorder_opts, .flags = BPF_F_PREORDER);
+	struct bpf_link *link1 = NULL, *link2 = NULL, *link3 = NULL;
+
+	link1 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops1, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link1, "attach_ops1"))
+		goto done;
+
+	link2 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops2, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link2, "attach_ops2"))
+		goto done;
+
+	link3 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops3, cgroup_fd,
+					    &preorder_opts);
+	if (!ASSERT_OK_PTR(link3, "attach_ops3_preorder"))
+		goto done;
+
+	reset_order(skel);
+	do_listen_connect(family);
+
+	ASSERT_EQ(skel->bss->listen_cnt, 3, "listen_cnt");
+	ASSERT_EQ(skel->bss->listen_order[0], 3, "listen_order[0]");
+	ASSERT_EQ(skel->bss->listen_order[1], 1, "listen_order[1]");
+	ASSERT_EQ(skel->bss->listen_order[2], 2, "listen_order[2]");
+
+	ASSERT_EQ(skel->bss->connect_cnt, 3, "connect_cnt");
+	ASSERT_EQ(skel->bss->connect_order[0], 3, "connect_order[0]");
+	ASSERT_EQ(skel->bss->connect_order[1], 1, "connect_order[1]");
+	ASSERT_EQ(skel->bss->connect_order[2], 2, "connect_order[2]");
+
+done:
+	bpf_link__destroy(link3);
+	bpf_link__destroy(link2);
+	bpf_link__destroy(link1);
+}
+
+static void run_order_subtest(void)
+{
+	struct bpf_tcp_ops *skel = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	ns = netns_new(TEST_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto done;
+
+	skel = bpf_tcp_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	test_order(cgroup_fd, skel, AF_INET);
+	test_order(cgroup_fd, skel, AF_INET6);
+
+done:
+	bpf_tcp_ops__destroy(skel);
+	netns_free(ns);
+	close(cgroup_fd);
+}
+
+/*
+ * Position a new attachment relative to an existing one. Attach ops1, then
+ * ops2 with BPF_F_BEFORE ops1, then ops3 with BPF_F_AFTER ops2. Expected
+ * execution order: [2, 3, 1]. For struct_ops, relative_fd refers to a link
+ * fd, so BPF_F_LINK must be set.
+ */
+static void test_before_after(int cgroup_fd, struct bpf_tcp_ops *skel)
+{
+	struct bpf_link *link1 = NULL, *link2 = NULL, *link3 = NULL;
+	LIBBPF_OPTS(bpf_cgroup_opts, opts);
+
+	link1 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops1, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link1, "attach_ops1"))
+		goto done;
+
+	opts.flags = BPF_F_BEFORE | BPF_F_LINK;
+	opts.relative_fd = bpf_link__fd(link1);
+	link2 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops2, cgroup_fd, &opts);
+	if (!ASSERT_OK_PTR(link2, "attach_ops2_before"))
+		goto done;
+
+	opts.flags = BPF_F_AFTER | BPF_F_LINK;
+	opts.relative_fd = bpf_link__fd(link2);
+	link3 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops3, cgroup_fd, &opts);
+	if (!ASSERT_OK_PTR(link3, "attach_ops3_after"))
+		goto done;
+
+	reset_order(skel);
+	do_listen_connect(AF_INET6);
+
+	ASSERT_EQ(skel->bss->listen_cnt, 3, "listen_cnt");
+	ASSERT_EQ(skel->bss->listen_order[0], 2, "listen_order[0]");
+	ASSERT_EQ(skel->bss->listen_order[1], 3, "listen_order[1]");
+	ASSERT_EQ(skel->bss->listen_order[2], 1, "listen_order[2]");
+
+done:
+	bpf_link__destroy(link3);
+	bpf_link__destroy(link2);
+	bpf_link__destroy(link1);
+}
+
+static void run_before_after_subtest(void)
+{
+	struct bpf_tcp_ops *skel = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	ns = netns_new(TEST_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto done;
+
+	skel = bpf_tcp_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	test_before_after(cgroup_fd, skel);
+
+done:
+	bpf_tcp_ops__destroy(skel);
+	netns_free(ns);
+	close(cgroup_fd);
+}
+
+static void test_query(int cgroup_fd, struct bpf_tcp_ops *skel)
+{
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	LIBBPF_OPTS(bpf_prog_query_opts, query_opts);
+	struct bpf_link *link1 = NULL, *link2 = NULL;
+	__u32 map1_id, map2_id, map_ids[2] = {};
+	__s32 type_id;
+
+	type_id = get_bpf_tcp_ops_type_id();
+	if (type_id <= 0)
+		return;
+
+	bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.tcp_ops1), &info, &info_len);
+	map1_id = info.id;
+
+	bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.tcp_ops2), &info, &info_len);
+	map2_id = info.id;
+
+	link1 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops1, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link1, "attach_ops1"))
+		goto done;
+
+	link2 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops2, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link2, "attach_ops2"))
+		goto done;
+
+	/* query effective: expect 2 entries in attachment order */
+	query_opts.type_id = type_id;
+	query_opts.prog_ids = map_ids;
+	query_opts.count = ARRAY_SIZE(map_ids);
+	query_opts.query_flags = BPF_F_QUERY_EFFECTIVE;
+	ASSERT_OK(bpf_prog_query_opts(cgroup_fd, BPF_STRUCT_OPS, &query_opts),
+		  "query_effective");
+	ASSERT_EQ(query_opts.count, 2, "query_effective_count");
+	ASSERT_EQ(map_ids[0], map1_id, "map_ids[0]");
+	ASSERT_EQ(map_ids[1], map2_id, "map_ids[1]");
+
+	/* query attached (non-effective): expect 2 entries */
+	memset(map_ids, 0, sizeof(map_ids));
+	query_opts.query_flags = 0;
+	query_opts.count = ARRAY_SIZE(map_ids);
+	ASSERT_OK(bpf_prog_query_opts(cgroup_fd, BPF_STRUCT_OPS, &query_opts),
+		  "query_attached");
+	ASSERT_EQ(query_opts.count, 2, "query_attached_count");
+	ASSERT_EQ(map_ids[0], map1_id, "attached_map_ids[0]");
+	ASSERT_EQ(map_ids[1], map2_id, "attached_map_ids[1]");
+
+done:
+	bpf_link__destroy(link2);
+	bpf_link__destroy(link1);
+}
+
+static void run_query_subtest(void)
+{
+	struct bpf_tcp_ops *skel = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	ns = netns_new(TEST_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto done;
+
+	skel = bpf_tcp_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	test_query(cgroup_fd, skel);
+
+done:
+	bpf_tcp_ops__destroy(skel);
+	netns_free(ns);
+	close(cgroup_fd);
+}
+
+/* Must match progs/bpf_tcp_ops.c */
+#define OPS_RETVAL1	11
+#define OPS_RETVAL2	22
+
+/*
+ * Attach three struct_ops implementing timeout_init to the same cgroup; they
+ * run in attach order [retval1, retval2, retval3]. timeout_init's return value
+ * is chained: the first prog reads the kernel seed via bpf_get_retval() (0,
+ * since no legacy sockops prog is attached) and returns OPS_RETVAL1; each
+ * subsequent prog must then observe the previous prog's return value. This
+ * proves the trampoline inherits the retval across an array of struct_ops.
+ */
+static void test_retval(int cgroup_fd, struct bpf_tcp_ops *skel)
+{
+	struct bpf_link *link1 = NULL, *link2 = NULL, *link3 = NULL;
+
+	skel->bss->retval_saw1 = -1;
+	skel->bss->retval_saw2 = -1;
+	skel->bss->retval_saw3 = -1;
+
+	link1 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops_retval1, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link1, "attach_retval1"))
+		goto done;
+
+	link2 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops_retval2, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link2, "attach_retval2"))
+		goto done;
+
+	link3 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops_retval3, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link3, "attach_retval3"))
+		goto done;
+
+	do_listen_connect(AF_INET6);
+
+	/* First prog inherits the kernel seed (no legacy sockops -> 0). */
+	ASSERT_EQ(skel->bss->retval_saw1, 0, "retval_saw1");
+	/* Each subsequent prog inherits the previous prog's return value. */
+	ASSERT_EQ(skel->bss->retval_saw2, OPS_RETVAL1, "retval_saw2");
+	ASSERT_EQ(skel->bss->retval_saw3, OPS_RETVAL2, "retval_saw3");
+
+done:
+	bpf_link__destroy(link3);
+	bpf_link__destroy(link2);
+	bpf_link__destroy(link1);
+}
+
+static void run_retval_subtest(void)
+{
+	struct bpf_tcp_ops *skel = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	ns = netns_new(TEST_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto done;
+
+	skel = bpf_tcp_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	test_retval(cgroup_fd, skel);
+
+done:
+	bpf_tcp_ops__destroy(skel);
+	netns_free(ns);
+	close(cgroup_fd);
+}
+
+/*
+ * bpf_link__update_map() swaps the struct_ops map backing an attached link.
+ * The link keeps its position, including BPF_F_PREORDER, across the update.
+ * Attach ops1 (normal) and ops2 (preorder): order [2, 1]. Update the normal
+ * link to ops3 -> [2, 3]; update the preorder link to ops1 -> [1, 3].
+ */
+static void test_update(int cgroup_fd, struct bpf_tcp_ops *skel)
+{
+	LIBBPF_OPTS(bpf_cgroup_opts, preorder_opts, .flags = BPF_F_PREORDER);
+	struct bpf_link *link = NULL, *link_pre = NULL;
+
+	link = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops1, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link, "attach_ops1"))
+		goto done;
+
+	link_pre = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops2, cgroup_fd,
+					       &preorder_opts);
+	if (!ASSERT_OK_PTR(link_pre, "attach_ops2_preorder"))
+		goto done;
+
+	reset_order(skel);
+	do_listen_connect(AF_INET6);
+	ASSERT_EQ(skel->bss->listen_cnt, 2, "cnt_initial");
+	ASSERT_EQ(skel->bss->listen_order[0], 2, "order0_initial");
+	ASSERT_EQ(skel->bss->listen_order[1], 1, "order1_initial");
+
+	/* Update the normal link's map (ops1 -> ops3); position is unchanged. */
+	if (!ASSERT_OK(bpf_link__update_map(link, skel->maps.tcp_ops3), "update_normal"))
+		goto done;
+
+	reset_order(skel);
+	do_listen_connect(AF_INET6);
+	ASSERT_EQ(skel->bss->listen_order[0], 2, "order0_after_normal");
+	ASSERT_EQ(skel->bss->listen_order[1], 3, "order1_after_normal");
+
+	/* Update the preorder link's map (ops2 -> ops1); it stays first. */
+	if (!ASSERT_OK(bpf_link__update_map(link_pre, skel->maps.tcp_ops1), "update_preorder"))
+		goto done;
+
+	reset_order(skel);
+	do_listen_connect(AF_INET6);
+	ASSERT_EQ(skel->bss->listen_order[0], 1, "order0_after_preorder");
+	ASSERT_EQ(skel->bss->listen_order[1], 3, "order1_after_preorder");
+
+done:
+	bpf_link__destroy(link_pre);
+	bpf_link__destroy(link);
+}
+
+static void run_update_subtest(void)
+{
+	struct bpf_tcp_ops *skel = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	ns = netns_new(TEST_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto done;
+
+	skel = bpf_tcp_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	test_update(cgroup_fd, skel);
+
+done:
+	bpf_tcp_ops__destroy(skel);
+	netns_free(ns);
+	close(cgroup_fd);
+}
+
+/*
+ * Two-level hierarchy. Attach ops1 to the parent and ops2 to the child, then
+ * trigger from a socket in the child. Descendant progs run before ancestor
+ * progs, so the order is [2 (child), 1 (parent)].
+ */
+static void test_hierarchy(int parent_fd, int child_fd, struct bpf_tcp_ops *skel)
+{
+	struct bpf_link *plink = NULL, *clink = NULL;
+
+	plink = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops1, parent_fd, NULL);
+	if (!ASSERT_OK_PTR(plink, "attach_parent"))
+		goto done;
+
+	clink = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops2, child_fd, NULL);
+	if (!ASSERT_OK_PTR(clink, "attach_child"))
+		goto done;
+
+	reset_order(skel);
+	do_listen_connect(AF_INET6);
+
+	ASSERT_EQ(skel->bss->listen_cnt, 2, "listen_cnt");
+	ASSERT_EQ(skel->bss->listen_order[0], 2, "listen_order[0]");
+	ASSERT_EQ(skel->bss->listen_order[1], 1, "listen_order[1]");
+
+done:
+	bpf_link__destroy(clink);
+	bpf_link__destroy(plink);
+}
+
+static void run_hierarchy_subtest(void)
+{
+	struct bpf_tcp_ops *skel = NULL;
+	struct netns_obj *ns = NULL;
+	int parent_fd, child_fd = -1;
+
+	parent_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(parent_fd, 0, "join_parent_cgroup"))
+		return;
+
+	child_fd = create_and_get_cgroup(CGROUP_PATH "/child");
+	if (!ASSERT_GE(child_fd, 0, "create_child_cgroup"))
+		goto done;
+
+	if (!ASSERT_OK(join_cgroup(CGROUP_PATH "/child"), "join_child_cgroup"))
+		goto done;
+
+	ns = netns_new(TEST_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto done;
+
+	skel = bpf_tcp_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	test_hierarchy(parent_fd, child_fd, skel);
+
+done:
+	bpf_tcp_ops__destroy(skel);
+	netns_free(ns);
+	if (child_fd >= 0)
+		close(child_fd);
+	close(parent_fd);
+}
+
+/*
+ * Attach ops1 to the parent, then create and join the child cgroup. The child
+ * is created after the attach, so it must inherit the parent's effective progs
+ * via cgroup_bpf_inherit(). A socket in the child runs the parent's prog.
+ */
+static void test_inherit(int parent_fd, struct bpf_tcp_ops *skel)
+{
+	struct bpf_link *plink = NULL;
+	int child_fd = -1;
+
+	plink = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops1, parent_fd, NULL);
+	if (!ASSERT_OK_PTR(plink, "attach_parent"))
+		goto done;
+
+	child_fd = create_and_get_cgroup(CGROUP_PATH "/child");
+	if (!ASSERT_GE(child_fd, 0, "create_child_cgroup"))
+		goto done;
+
+	if (!ASSERT_OK(join_cgroup(CGROUP_PATH "/child"), "join_child_cgroup"))
+		goto done;
+
+	reset_order(skel);
+	do_listen_connect(AF_INET6);
+
+	ASSERT_EQ(skel->bss->listen_cnt, 1, "listen_cnt");
+	ASSERT_EQ(skel->bss->listen_order[0], 1, "listen_order[0]");
+
+done:
+	if (child_fd >= 0)
+		close(child_fd);
+	bpf_link__destroy(plink);
+}
+
+static void run_inherit_subtest(void)
+{
+	struct bpf_tcp_ops *skel = NULL;
+	struct netns_obj *ns = NULL;
+	int parent_fd;
+
+	parent_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(parent_fd, 0, "join_parent_cgroup"))
+		return;
+
+	ns = netns_new(TEST_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto done;
+
+	skel = bpf_tcp_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	test_inherit(parent_fd, skel);
+
+done:
+	bpf_tcp_ops__destroy(skel);
+	netns_free(ns);
+	close(parent_fd);
+}
+
+void test_bpf_tcp_ops(void)
+{
+	if (test__start_subtest("order"))
+		run_order_subtest();
+	if (test__start_subtest("before_after"))
+		run_before_after_subtest();
+	if (test__start_subtest("query"))
+		run_query_subtest();
+	if (test__start_subtest("retval"))
+		run_retval_subtest();
+	if (test__start_subtest("update"))
+		run_update_subtest();
+	if (test__start_subtest("hierarchy"))
+		run_hierarchy_subtest();
+	if (test__start_subtest("inherit"))
+		run_inherit_subtest();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops.c b/tools/testing/selftests/bpf/progs/bpf_tcp_ops.c
new file mode 100644
index 000000000000..94a7f52573d5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define MAX_CGROUP_OPS 8
+
+/* Call order for listen and connect, indexed by call sequence */
+u32 listen_order[MAX_CGROUP_OPS];
+u32 listen_cnt;
+
+u32 connect_order[MAX_CGROUP_OPS];
+u32 connect_cnt;
+
+static void record_listen(int id)
+{
+	u32 idx = listen_cnt;
+
+	if (idx < MAX_CGROUP_OPS) {
+		listen_order[idx] = id;
+		listen_cnt = idx + 1;
+	}
+}
+
+static void record_connect(int id)
+{
+	u32 idx = connect_cnt;
+
+	if (idx < MAX_CGROUP_OPS) {
+		connect_order[idx] = id;
+		connect_cnt = idx + 1;
+	}
+}
+
+/* struct_ops instance 1 */
+
+SEC("struct_ops")
+void BPF_PROG(tcp_ops1_listen, struct sock *sk)
+{
+	record_listen(1);
+}
+
+SEC("struct_ops")
+void BPF_PROG(tcp_ops1_connect, struct sock *sk)
+{
+	record_connect(1);
+}
+
+SEC(".struct_ops.link")
+struct bpf_tcp_ops tcp_ops1 = {
+	.listen  = (void *)tcp_ops1_listen,
+	.connect = (void *)tcp_ops1_connect,
+};
+
+/* struct_ops instance 2 */
+
+SEC("struct_ops")
+void BPF_PROG(tcp_ops2_listen, struct sock *sk)
+{
+	record_listen(2);
+}
+
+SEC("struct_ops")
+void BPF_PROG(tcp_ops2_connect, struct sock *sk)
+{
+	record_connect(2);
+}
+
+SEC(".struct_ops.link")
+struct bpf_tcp_ops tcp_ops2 = {
+	.listen  = (void *)tcp_ops2_listen,
+	.connect = (void *)tcp_ops2_connect,
+};
+
+/* struct_ops instance 3 */
+
+SEC("struct_ops")
+void BPF_PROG(tcp_ops3_listen, struct sock *sk)
+{
+	record_listen(3);
+}
+
+SEC("struct_ops")
+void BPF_PROG(tcp_ops3_connect, struct sock *sk)
+{
+	record_connect(3);
+}
+
+SEC(".struct_ops.link")
+struct bpf_tcp_ops tcp_ops3 = {
+	.listen  = (void *)tcp_ops3_listen,
+	.connect = (void *)tcp_ops3_connect,
+};
+
+#define OPS_RETVAL1	11
+#define OPS_RETVAL2	22
+#define OPS_RETVAL3	33
+
+int retval_saw1;
+int retval_saw2;
+int retval_saw3;
+
+SEC("struct_ops")
+int BPF_PROG(tcp_ops_retval1_timeout_init, struct sock *sk, struct request_sock *req)
+{
+	retval_saw1 = bpf_get_retval();
+	return OPS_RETVAL1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_tcp_ops tcp_ops_retval1 = {
+	.timeout_init = (void *)tcp_ops_retval1_timeout_init,
+};
+
+SEC("struct_ops")
+int BPF_PROG(tcp_ops_retval2_timeout_init, struct sock *sk, struct request_sock *req)
+{
+	retval_saw2 = bpf_get_retval();
+	return OPS_RETVAL2;
+}
+
+SEC(".struct_ops.link")
+struct bpf_tcp_ops tcp_ops_retval2 = {
+	.timeout_init = (void *)tcp_ops_retval2_timeout_init,
+};
+
+SEC("struct_ops")
+int BPF_PROG(tcp_ops_retval3_timeout_init, struct sock *sk, struct request_sock *req)
+{
+	retval_saw3 = bpf_get_retval();
+	return OPS_RETVAL3;
+}
+
+SEC(".struct_ops.link")
+struct bpf_tcp_ops tcp_ops_retval3 = {
+	.timeout_init = (void *)tcp_ops_retval3_timeout_init,
+};
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0-Meta


