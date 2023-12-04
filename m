Return-Path: <netdev+bounces-53569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D57803BE5
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D25281049
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB36F2E854;
	Mon,  4 Dec 2023 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WsTkbKqn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D2D3
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 09:44:26 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5caf86963ecso66081357b3.3
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 09:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701711865; x=1702316665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AHKIIXtuEH10uYVlAQhsfpVcXlWfnFhDRDhpZgy/nhY=;
        b=WsTkbKqnnm18VmwZL4SMUF9bQWt8oVCkOY+PTLX8EEdNYG6R1w8WO7LZ3/JOlAHjH7
         F9SGJk8UImRnePddi2WXv+Ch8feCIkoNh0pHt2euu7HK4/tDmd5bLIfHL9gedqPez5ku
         OfGJuiaT+aP8Q8vmO1GX3oHiR465A9TPJfR9k1zzHhk1j96bjBYowklfSOWYPlLjth/s
         uAUZ6a805MEysyMhQGx5+J8muqRfD4kNc5mLibSScolW5mbTz71W3Rjp5WMbiBTkljC8
         Idi3UrUMpIfaP0eOvWQTIIFqYWuWp0EGLduKHBsk8FPKO6rasKwBxTNGGq80lBSDEntq
         RKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711865; x=1702316665;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AHKIIXtuEH10uYVlAQhsfpVcXlWfnFhDRDhpZgy/nhY=;
        b=LKgSDWMth55KzacrUJlkZP4sb1X7QLc1jRgg5kDEPFkeGNKuOmnvmSP3TgQ4vhskTR
         np+AYsVv8nv6vZewhJq9XsQpfHGZQZR5SzRq8AqWLBenr4z3E5SkddkZQwIpqL5jfYL9
         jPXQ1ElAWVJY0usoLh1vfNQX71KOIjdrp7oQptMWPO2bfHSbRqgEDMamcf/vJlpv/Ra0
         +pjWJp3nCc0n/E6RmmVoXTekvRFPtbis+byf7zHLilQAGyS4EVIhT3Og8KVNiMtdAWCg
         FaM4sOf3CJLsEl0jPg/uTrWX5EoeX7tV9JrdwYioH+WQXkG9GjfhEWoOQRf8cHD2qGes
         hPJQ==
X-Gm-Message-State: AOJu0YzNOmw0YglvGdm/UVvX4A93fgOYBYK8f6dVhiNzUaGAzUilSK/O
	WJxRNh8d0R9c1oYx58exCWOwfK4=
X-Google-Smtp-Source: AGHT+IGzHvPVqHSiNAIV4uXK+MSBLIQuOoXZ8GITN+xD5sYKyENVupK9kJa9MZt7FjzHxcKweOhsMbI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:c044:0:b0:db5:1f69:56d4 with SMTP id
 c65-20020a25c044000000b00db51f6956d4mr491393ybf.3.1701711865548; Mon, 04 Dec
 2023 09:44:25 -0800 (PST)
Date: Mon,  4 Dec 2023 09:44:23 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204174423.3460052-1-sdf@google.com>
Subject: [PATCH bpf-next] selftests/bpf: Make sure we trigger metadata kfuncs
 for dst 8080
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

xdp_metadata test if flaky sometimes:
verify_xsk_metadata:FAIL:rx_hash_type unexpected rx_hash_type: actual 8 != expected 0

Where 8 means XDP_RSS_TYPE_L4_ANY and is exported from veth driver
only when 'skb->l4_hash' condition is met. This makes me think
that the program is triggering again for some other packet.

Let's have a filter, similar to xdp_hw_metadata, where we trigger
xdp kfuncs only for UDP packets destined to port 8080.

Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/progs/xdp_metadata.c        | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index d151d406a123..5d6c1245c310 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -27,11 +27,40 @@ extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
 SEC("xdp")
 int rx(struct xdp_md *ctx)
 {
-	void *data, *data_meta;
+	void *data, *data_meta, *data_end;
+	struct ipv6hdr *ip6h = NULL;
+	struct ethhdr *eth = NULL;
+	struct udphdr *udp = NULL;
+	struct iphdr *iph = NULL;
 	struct xdp_meta *meta;
 	u64 timestamp = -1;
 	int ret;
 
+	data = (void *)(long)ctx->data;
+	data_end = (void *)(long)ctx->data_end;
+	eth = data;
+	if (eth + 1 < data_end) {
+		if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+			iph = (void *)(eth + 1);
+			if (iph + 1 < data_end && iph->protocol == IPPROTO_UDP)
+				udp = (void *)(iph + 1);
+		}
+		if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
+			ip6h = (void *)(eth + 1);
+			if (ip6h + 1 < data_end && ip6h->nexthdr == IPPROTO_UDP)
+				udp = (void *)(ip6h + 1);
+		}
+		if (udp && udp + 1 > data_end)
+			udp = NULL;
+	}
+
+	if (!udp)
+		return XDP_PASS;
+
+	/* Forwarding UDP:8080 to AF_XDP */
+	if (udp->dest != bpf_htons(8080))
+		return XDP_PASS;
+
 	/* Reserve enough for all custom metadata. */
 
 	ret = bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));
-- 
2.43.0.rc2.451.g8631bc7472-goog


