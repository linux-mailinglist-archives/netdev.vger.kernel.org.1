Return-Path: <netdev+bounces-293995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPuUHSVMHmrmiQkAu9opvQ
	(envelope-from <netdev+bounces-293995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:21:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CFB627AED
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9591D302CD94
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 03:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D381F374758;
	Tue,  2 Jun 2026 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WHV8r6eo"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA5373BE9;
	Tue,  2 Jun 2026 03:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780370256; cv=none; b=F747bSH2aKHDr3aXQdRT13r7qLsXo8NJjXwZlB3diF79E1zf0yRuqCcCobxTKc+Pdbh2GjHay9wEHfFsL/igxQ6ilAzkkZ1YZsHgobbSa0pdcVD0NDL/h8tvzm3NzDJnPM0fiwxAjE6nvwJ5vKUvWj2PRrj78VylInPuYOqOmkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780370256; c=relaxed/simple;
	bh=gvgIJo9m/HUHg9gk2qU3NCinlFuIOES/GGZ227Us+6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mc0h1QgGHMYbDQg47WDkKfU3tRL8xBfDM0msJ+m2S/Jn0kgnL/jDoWBPvjIFSOszhfs8h94zWKztqFkwqi+gjU786gkDxhLG7P7gSMx/Ea1m7NXyKXiy4YVaz6dkghAz3rVLHwfVUX80ToSTUiZBigAo2y7AiqewjyBs92agegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WHV8r6eo; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0fecd90a-d218-48dc-86d1-860ab2e7f6d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780370252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q31l8Uyd8/waps4/zvDwbRE+yDFblOOOVBggVCClT4g=;
	b=WHV8r6eoERREXxCCRWjY2eCmtSkAlgARpuzh0h1dndgYom86wLyWawWBQ0ihkvMvPM7O8Y
	5cVT0y3iBdevFuRq4D8aCpnspn3R8dARNJRC1RJ2IlsEfPrjyK1U0LLqP9omm4Gs+xoJYg
	ANKtSjCbOfW8avUq3gZ/XtK1pfIwO+A=
Date: Tue, 2 Jun 2026 11:17:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 1/2] bpf: Update transport_header when
 encapsulating UDP tunnel in lwt
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Guillaume Nault <gnault@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Peter Oskolkov <posk@google.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com, Leon Hwang <leon.huangfu@shopee.com>
References: <20260601150203.20352-1-leon.hwang@linux.dev>
 <20260601150203.20352-2-leon.hwang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260601150203.20352-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293995-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,nvidia.com,suse.de,vger.kernel.org,fb.com,shopee.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 74CFB627AED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 6/1/26 11:02 PM, Leon Hwang wrote:
> Currently, bpf_lwt_push_ip_encap() does not update skb->transport_header.
> When a driver, e.g. ice, reuses the stale skb->transport_header to
> offload checksum computation to NIC hardware, VxLAN packets encapsulated
> by bpf_lwt_push_encap() helper may be dropped due to incorrect checksum.
>
> Update skb->transport_header in bpf_lwt_push_ip_encap() whenever the
> encapsulated packet uses UDP, so checksum offload works correctly.
>
> Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
> Cc: Leon Hwang <leon.huangfu@shopee.com>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>   net/core/lwt_bpf.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index f71ef82a5f3d..65d1dfbf3312 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -599,6 +599,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool ipv4, int encap_len)
>   
>   int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
>   {
> +	bool is_udp_tunnel;
>   	struct iphdr *iph;
>   	bool ipv4;
>   	int err;
> @@ -612,10 +613,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
>   		ipv4 = true;
>   		if (unlikely(len < iph->ihl * 4))
>   			return -EINVAL;
> +		is_udp_tunnel = iph->protocol == IPPROTO_UDP;
> +		if (unlikely(is_udp_tunnel && len < iph->ihl * 4 + sizeof(struct udphdr)))
> +			return -EINVAL;
>   	} else if (iph->version == 6) {
>   		ipv4 = false;
>   		if (unlikely(len < sizeof(struct ipv6hdr)))
>   			return -EINVAL;
> +		is_udp_tunnel = ((struct ipv6hdr *)iph)->nexthdr == NEXTHDR_UDP;
> +		if (unlikely(is_udp_tunnel && len < sizeof(struct ipv6hdr) + sizeof(struct udphdr)))
> +			return -EINVAL;
>   	} else {
>   		return -EINVAL;
>   	}
> @@ -637,6 +644,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
>   	if (ingress)
>   		skb_postpush_rcsum(skb, iph, len);
>   	skb_reset_network_header(skb);
> +	if (ipv4 && is_udp_tunnel)
> +		skb_set_transport_header(skb, skb_network_offset(skb) + iph->ihl * 4);
> +	else if (!ipv4 && is_udp_tunnel)
> +		skb_set_transport_header(skb, skb_network_offset(skb) + sizeof(struct ipv6hdr));


I think GRE is also affected, why not unconditionally set transport 
header to network_offset + outer_ip_ihl regardless of outer protocol??

>   	memcpy(skb_network_header(skb), hdr, len);
>   	bpf_compute_data_pointers(skb);
>   	skb_clear_hash(skb);

