Return-Path: <netdev+bounces-293820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qnKDHBqpHWq+cwkAu9opvQ
	(envelope-from <netdev+bounces-293820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:45:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFB6621FBA
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F08C3301427B
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850503D9048;
	Mon,  1 Jun 2026 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2A2KVos"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4B3D79E9;
	Mon,  1 Jun 2026 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328723; cv=none; b=qxMKU4MZCIYmrT9vOivVojdUKIBasxIXefLhsFbugBLD8EhUWIePI6L3KcAZb/6mM0H2yWTZk03mkTxm+7OZqd4pfU+bs+eDBBgWqryb1toBj8Hd2yakrOlyv06Rki5ChR8tw37TVzNMeGMy4ZqGBJFgl+MnrvX5EbLAVHQlEKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328723; c=relaxed/simple;
	bh=9Hd/f3NDhS9GTcpcignrH/XonRnFYnKeJnhXj1hGR3Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=X/JJB+YmQUUtM1T0ramDVNHIaHpW0oS4fhp/S2UauE1q3ejW2UiYtYHsrIL1yyTLkSvbW8pJYly6jgxIzULLwHWcszz0JGgUcdD8G1RonYuBL9oA+sSmiQrRq9TndSnngqZu/eKmgoBuMdwCvF1Uj23XIDvGJqACq7UhXAhMcNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2A2KVos; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938341F00893;
	Mon,  1 Jun 2026 15:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780328722;
	bh=Lz/16V3dOQhlXcQLZ6Es8Qww3hvkhECsC9jqFOP8fXA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=L2A2KVoshZxF5leOTgNPquL1+cYqI/DCeU1YOvTEJAaojkyPlSAahGxr7deTGhmVF
	 n/Usx8GcnfAXG7Dlzvhy2bXtxzcACBapbGrTo5EmpIiI1qKIrDhYi2TxrRs0UkX5LH
	 a33/zv2blzyBntP91/nhFjG7x8HtxhRCgGoWyvWR2ZIuQ9sJLb3HmC6hDCBLm+iuwa
	 dFgyC6vGQx8ZUb2b2xHc+Cvhd5DLXZyx/TKg6HnTYRzzKNlKcy2Is1j8Dea7ATZg1K
	 /h8G1Ye82OqR41YZonzv1FY7V0nhQV9I9UUQRbrQSVjk7seaJQvKTPpnXzTnOAh1Ia
	 hsUtZRCHZ9L0w==
Content-Type: multipart/mixed; boundary="===============3137123153509642700=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fc2876ad051bb26bc57a39acfa8dc625eb601f389c8db103c8960474816307c5@mail.kernel.org>
In-Reply-To: <20260601150203.20352-2-leon.hwang@linux.dev>
References: <20260601150203.20352-2-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf v3 1/2] bpf: Update transport_header when encapsulating UDP tunnel in lwt
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,gnault@redhat.com,leon.hwang@linux.dev,idosch@nvidia.com,fmancera@suse.de,posk@google.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,leon.huangfu@shopee.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  1 Jun 2026 15:45:21 +0000 (UTC)
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,nvidia.com,suse.de,vger.kernel.org,fb.com,shopee.com,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-293820-lists,netdev=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[35];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2CFB6621FBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============3137123153509642700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index f71ef82a5f3d..65d1dfbf3312 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -612,10 +613,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
>  		ipv4 = true;
>  		if (unlikely(len < iph->ihl * 4))
>  			return -EINVAL;

Since len is a u32, if iph->ihl is 0 then iph->ihl * 4 is 0 and the
"len < iph->ihl * 4" check is never true, so it passes without
returning -EINVAL.

Later ip_fast_csum() is called with iph->ihl, and on some architectures
(PowerPC, MIPS) that implementation assumes ihl >= 5 and decrements the
loop counter, which underflows when ihl is 0.

Should there be an explicit iph->ihl >= 5 check here, for example:

	if (unlikely(iph->ihl < 5 || len < iph->ihl * 4))
		return -EINVAL;

This was raised in review of v1 and v2 added the guard, but v3 appears
to have dropped it again.  The earlier discussion is here:

  https://lore.kernel.org/bpf/20260601151707.C51601F00893@smtp.kernel.org

> +		is_udp_tunnel = iph->protocol == IPPROTO_UDP;
> +		if (unlikely(is_udp_tunnel && len < iph->ihl * 4 + sizeof(struct udphdr)))
> +			return -EINVAL;
>  	} else if (iph->version == 6) {
>  		ipv4 = false;
>  		if (unlikely(len < sizeof(struct ipv6hdr)))
>  			return -EINVAL;
> +		is_udp_tunnel = ((struct ipv6hdr *)iph)->nexthdr == NEXTHDR_UDP;
> +		if (unlikely(is_udp_tunnel && len < sizeof(struct ipv6hdr) + sizeof(struct udphdr)))
> +			return -EINVAL;
>  	} else {
>  		return -EINVAL;
>  	}

[ ... ]

> @@ -637,6 +644,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
>  	if (ingress)
>  		skb_postpush_rcsum(skb, iph, len);
>  	skb_reset_network_header(skb);
> +	if (ipv4 && is_udp_tunnel)
> +		skb_set_transport_header(skb, skb_network_offset(skb) + iph->ihl * 4);
> +	else if (!ipv4 && is_udp_tunnel)
> +		skb_set_transport_header(skb, skb_network_offset(skb) + sizeof(struct ipv6hdr));
>  	memcpy(skb_network_header(skb), hdr, len);

Can iph->ihl change between the initial length validation and this call?

The hdr pointer (and therefore iph) refers to a buffer provided by the
BPF program, which can be concurrently modified by userspace through a
shared BPF map.  Because skb_cow_head() acts as a compiler barrier, the
compiler reloads iph->ihl from that untrusted memory here.

This read also happens before the memcpy() into the skb:

	skb_set_transport_header(skb, skb_network_offset(skb) + iph->ihl * 4);
	memcpy(skb_network_header(skb), hdr, len);

If iph->ihl is concurrently changed to a larger value (such as 15) after
the initial validation, can the transport header offset be set beyond
skb->tail, leading to out-of-bounds writes when drivers later dereference
the transport header for checksum updates?

In the v1 discussion the suggestion was to move
skb_set_transport_header() after the memcpy() so it reads from the
copied-in header, but the current code still reads iph->ihl before the
memcpy().  See:

  https://lore.kernel.org/bpf/20260601151707.C51601F00893@smtp.kernel.org


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26763883406
--===============3137123153509642700==--

