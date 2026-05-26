Return-Path: <netdev+bounces-291765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N1wCsfAFWrRaAcAu9opvQ
	(envelope-from <netdev+bounces-291765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:48:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D27445D904D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA6E6313059A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F49D37881A;
	Tue, 26 May 2026 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHKfb4iQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CED33769F3
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809853; cv=none; b=Ai+eLoDcT5oYyqJrkuvuGXMG5gLK9YwN4jZ08z+xghTScbt3/taRF01bp5EIvIt4SYXePE8u/KqVQlJN3875IAaipk1pz1S6corp7NSJSGlenNjIvskTe/bxIirnQw2Tn4rPK45svtV2SqC1rfPiGwLYFT5vng78n0ryq2JLqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809853; c=relaxed/simple;
	bh=Oh7mtnhCoXsCkk0ahdaDgj1iGSVc/gaexEmg71EdJs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MVMzSw82Ftx4mkB792z0OpP4wclHTPZ4phFW2FC+DJXp0mxkYPYxlL3RuLZix6YmKRj6QevM9vhIe2+MikvcMsAvzxBT/iW8cxGLFL6Me6OOYkHdMK1YaBGQxfCv7uYiEhK8OTaVbWGfIIGU2uJxKqmyR+KQONtnlcZUgWfGpB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHKfb4iQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4905529b933so24013605e9.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779809850; x=1780414650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udHAJvH0Fj5DwjHc8b3FJ1bTNbGBCNfzbQxO72t7qAk=;
        b=LHKfb4iQsAv5yRjmclMiEv7RDAwdhArCoyPCejpk/9xCLT40pbl51doHtsG8XbOVzm
         h7yW/i4sZgt1+mYJZKTk3SsWZBsNhZFMpGrLhz9d6kHhOhG5416sCU1+J8kSFprMrjZi
         tZR3QjjgyjT5BSPak2hEvlf6oF1hbeYm9JK+jWd4aTiJ9UIzExe3m1VjYinCTz1L+AUM
         xDBq9sw35EV+1DtITVsCPIJrQZ0Fa1FIRgFhdw9LV7N4FR3oet0jMlRbrTHpnuG/Gypx
         yJfbIU8XE2ReJfhH/S1WdUxW1nEtemXUjh/zVXDOG5TNlxSlIEiTWyC/qpfsDwEUPK60
         2efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809850; x=1780414650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=udHAJvH0Fj5DwjHc8b3FJ1bTNbGBCNfzbQxO72t7qAk=;
        b=YocxOcfiWgAObB3f5NMJPdCgz6V76wpv8SK5NxRM/Nl7ku8xCBX6yi5GA0vgGpBe/8
         rXK+eyPBUDQdiMLbwJaY+2gZXljTFgsmjGaDcnbg2z2CyW/4kKYtWGoes+50LPb1Y2Tf
         zSo+PljvlCQ2fsM2b9pLBBep4cx77wDt+WsXKlCVssql20XIwwm/yDbTWBmgq9tA6wsb
         AxAs8x3m2uVMyrxrwfNLsya8sI1viS7+2oZaEw3FUG1PJVQl9O/HpB+TmsTTBV5ZHPqA
         Id/YfS6MNngTbAzAEWWllvojrHWbPwO8QtA/X65k7IyYNJGtBvaVIOs7o5RIp3VT45ox
         oKfg==
X-Forwarded-Encrypted: i=1; AFNElJ8oOKNkZEb4cZgHX5h0fT9UyfhqCQYBpfBO7roLDPFB/OFvvPGH0aCw4nWGC8+81Ca8WJ3yTaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+3U6yXYi8Rz5PICDC25IzxWKPmpeIpt6BTZF/Ix/zRrf85ib5
	NdwDeM6+x3zLa5xgFJ1unSrvjw1Vc3a1k9MOi/twIR6hzV0BpJpHEOp7
X-Gm-Gg: Acq92OHvCCMtl45NqsPVW8Pz+IXGJLRaYzyUYzyXgfPhihuL9dqM2n2zRf6kRV9Ky+9
	E89idaxtCuCHDQK6EEd4MNjaOgnwhejavUHaS+OATRCduikFRD3H+YxJL0xPuCdM7942QDbE6vy
	/MKGlZB5XIH7JQuL5FWC0RXU+tsBTLXC9PNjUkWBCb5tHXwz58DemDOnLb17EQg5SnkWtrt8X7R
	JraBRUke4AOBMzqi9e+dyNTVB/ZdFyXrU2UfbeD4Gg247knCJFcqfaahjwMdYP/SWSpTSqmZFls
	EB7Y68r/B6xBETOdS9/uDxl3otGh8grf9ZKaF+8qchkqjDw6GqqZrJL28y00wSFluPzYzA0FKuI
	lfg0svsgov2nFZtRIEv0KGjBe+TXkdGPv+JX+JQX9Bjl+SL+KGdnZkOJAjR1ShYnRvceiqRmKCN
	Fxsi+tx7mhPW8oubSV7zEidHsBP7w=
X-Received: by 2002:a05:600c:5288:b0:490:50e8:45c3 with SMTP id 5b1f17b1804b1-49050e846f9mr254032315e9.0.1779809849808;
        Tue, 26 May 2026 08:37:29 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4907df9edeasm1083655e9.9.2026.05.26.08.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:37:29 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v7 6/7] selftests/bpf: add bpf_icmp_send kfunc tc tests
Date: Tue, 26 May 2026 15:37:07 +0000
Message-Id: <20260526153708.279717-7-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526153708.279717-1-mahe.tardy@gmail.com>
References: <20260526153708.279717-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,vger.kernel.org,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291765-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D27445D904D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This test is similar to the one with cgroup_skb programs but uses tc
egress instead.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 25 ++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c | 60 +++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
index 1d6900d6a8f8..51f809ea6896 100644
--- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -176,3 +176,28 @@ void test_icmp_send_unreach_cgroup(void)
 	icmp_send__destroy(skel);
 	close(cgroup_fd);
 }
+
+void test_icmp_send_unreach_tc(void)
+{
+	LIBBPF_OPTS(bpf_tcx_opts, opts);
+	struct icmp_send *skel;
+	struct bpf_link *link = NULL;
+
+	skel = icmp_send__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	link = bpf_program__attach_tcx(skel->progs.tc_egress, 1, &opts);
+	if (!ASSERT_OK_PTR(link, "prog_attach"))
+		goto cleanup;
+
+	if (test__start_subtest("ipv4"))
+		run_icmp_test(skel, AF_INET, "127.0.0.1", NR_ICMP_UNREACH);
+
+	if (test__start_subtest("ipv6"))
+		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);
+
+cleanup:
+	bpf_link__destroy(link);
+	icmp_send__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
index 6e1ba539eeb0..5fa5467bdb70 100644
--- a/tools/testing/selftests/bpf/progs/icmp_send.c
+++ b/tools/testing/selftests/bpf/progs/icmp_send.c
@@ -2,6 +2,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include "bpf_tracing_net.h"

 /* 127.0.0.1 in host byte order */
 #define SERVER_IP 0x7F000001
@@ -65,4 +66,63 @@ int egress(struct __sk_buff *skb)
 	return SK_DROP;
 }

+SEC("tc/egress")
+int tc_egress(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct ethhdr *eth;
+	struct iphdr *iph;
+	struct ipv6hdr *ip6h;
+	struct tcphdr *tcph;
+
+	eth = data;
+	if ((void *)(eth + 1) > data_end)
+		return TCX_PASS;
+
+	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		iph = (void *)(eth + 1);
+		if ((void *)(iph + 1) > data_end)
+			return TCX_PASS;
+
+		if (iph->protocol != IPPROTO_TCP ||
+		    iph->daddr != bpf_htonl(SERVER_IP))
+			return TCX_PASS;
+
+		tcph = (void *)iph + iph->ihl * 4;
+		if ((void *)(tcph + 1) > data_end)
+			return TCX_PASS;
+
+		if (tcph->dest != bpf_htons(server_port))
+			return TCX_PASS;
+
+	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
+		ip6h = (void *)(eth + 1);
+		if ((void *)(ip6h + 1) > data_end)
+			return TCX_PASS;
+
+		if (ip6h->nexthdr != IPPROTO_TCP)
+			return TCX_PASS;
+
+		if (ip6h->daddr.in6_u.u6_addr32[0] != 0 ||
+		    ip6h->daddr.in6_u.u6_addr32[1] != 0 ||
+		    ip6h->daddr.in6_u.u6_addr32[2] != 0 ||
+		    ip6h->daddr.in6_u.u6_addr32[3] != bpf_htonl(SERVER_IP6_LO))
+			return TCX_PASS;
+
+		tcph = (void *)(ip6h + 1);
+		if ((void *)(tcph + 1) > data_end)
+			return TCX_PASS;
+
+		if (tcph->dest != bpf_htons(server_port))
+			return TCX_PASS;
+	} else {
+		return TCX_PASS;
+	}
+
+	kfunc_ret = bpf_icmp_send(skb, unreach_type, unreach_code);
+
+	return TCX_DROP;
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
--
2.34.1


