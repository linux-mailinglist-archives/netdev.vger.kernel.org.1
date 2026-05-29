Return-Path: <netdev+bounces-293157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAutOXayGWrJyQgAu9opvQ
	(envelope-from <netdev+bounces-293157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 17:36:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EA1604DBF
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 17:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75FD231B5EC4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63873E928B;
	Fri, 29 May 2026 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yf7aKi3K"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B21607A4;
	Fri, 29 May 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067711; cv=none; b=hQ+7NAJBb6wY7aXxHFIcdhesy/BzA3KaUP3aWYKbE1yWdLICREvmtzw6x24Lx25rloqk6ZqLFclXeF2eQtr26DGOa6bNbFQ/1NUbg6pkeBoBk5S+dTXHdj2V82bbBlDwGn0Dw5ZJrZbGbIbGRPWnyLTPbaw9+y9OU4Oj8tu3ZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067711; c=relaxed/simple;
	bh=SKAT7hw/8Orv13PHCSnTgIBz2Ipz4cxEP3jGinHwIm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdELZBN8DO7onfOCcfQLP3M1zH2DdH+T2P1rGvTHH6/YmuImiF5CdVPgmodAbULdDKVnHQPqE4eqw1ORBM90+Vv5X10RGvS6ITyYIkLzJEnwrHoSgwO5wYWzZj02IljBf5VtKYa7u/yb/oA9fe6a7mJI/hAG4k/T1h80KBhVzDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yf7aKi3K; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780067708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNYctVoQYshrW+FHoERDUeT3GUi8gIpDSH2odCxQVMM=;
	b=Yf7aKi3K+7XdNVq/QbZlpU2cDoF8mDqYwrJlXFI2qk54YQPT0RTJ0nWeDP+/wvdTMYTBr6
	PKYmV062GNM1PDVt0YGBTv0VXUvnTpa0UH5j5Os6RIM08zKsNxCm9DGpa2mla4I0ESnT1Y
	kGQmIgto4txNLwJrXUK8jFYOBWTfpsA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Ido Schimmel <idosch@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Peter Oskolkov <posk@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: [PATCH bpf v2 3/4] bpf: Update transport_header when encapsulating UDP tunnel in lwt
Date: Fri, 29 May 2026 23:13:50 +0800
Message-ID: <20260529151351.69911-4-leon.hwang@linux.dev>
In-Reply-To: <20260529151351.69911-1-leon.hwang@linux.dev>
References: <20260529151351.69911-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,nvidia.com,suse.de,vger.kernel.org,fb.com,shopee.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293157-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim,shopee.com:email]
X-Rspamd-Queue-Id: A6EA1604DBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, bpf_lwt_push_ip_encap() does not update skb->transport_header.
When a driver, e.g. ice, reuses the stale skb->transport_header to
offload checksum computation to NIC hardware, VxLAN packets encapsulated
by bpf_lwt_push_encap() helper may be dropped due to incorrect checksum.

Update skb->transport_header in bpf_lwt_push_ip_encap() whenever the
encapsulated packet uses UDP, so checksum offload works correctly.

Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Cc: Leon Hwang <leon.huangfu@shopee.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 net/core/lwt_bpf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index c306120e11d2..1d556dec94b4 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -600,6 +600,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool ipv4, int encap_len)
 int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 {
 	u8 buff[LWT_BPF_MAX_HEADROOM];
+	bool is_udp_tunnel;
 	struct iphdr *iph;
 	bool ipv4;
 	int err;
@@ -615,10 +616,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 		ipv4 = true;
 		if (unlikely(iph->ihl < 5 || len < iph->ihl * 4))
 			return -EINVAL;
+		is_udp_tunnel = iph->protocol == IPPROTO_UDP;
+		if (unlikely(is_udp_tunnel && len < iph->ihl * 4 + sizeof(struct udphdr)))
+			return -EINVAL;
 	} else if (iph->version == 6) {
 		ipv4 = false;
 		if (unlikely(len < sizeof(struct ipv6hdr)))
 			return -EINVAL;
+		is_udp_tunnel = ((struct ipv6hdr *)iph)->nexthdr == NEXTHDR_UDP;
+		if (unlikely(is_udp_tunnel && len < sizeof(struct ipv6hdr) + sizeof(struct udphdr)))
+			return -EINVAL;
 	} else {
 		return -EINVAL;
 	}
@@ -641,6 +648,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 		skb_postpush_rcsum(skb, iph, len);
 	skb_reset_network_header(skb);
 	memcpy(skb_network_header(skb), buff, len);
+	if (ipv4 && is_udp_tunnel)
+		skb_set_transport_header(skb, skb_network_offset(skb) + iph->ihl * 4);
+	else if (!ipv4 && is_udp_tunnel)
+		skb_set_transport_header(skb, skb_network_offset(skb) + sizeof(struct ipv6hdr));
 	bpf_compute_data_pointers(skb);
 	skb_clear_hash(skb);
 
-- 
2.54.0


