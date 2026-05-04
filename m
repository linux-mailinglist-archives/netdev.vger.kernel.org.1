Return-Path: <netdev+bounces-283795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIQ1MhR9+GkowAIAu9opvQ
	(envelope-from <netdev+bounces-283795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 13:03:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D05974BC1CC
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 13:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D02EF30080A5
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAAF3A6407;
	Mon,  4 May 2026 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5pIEjzW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05F345724;
	Mon,  4 May 2026 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892583; cv=none; b=i9Wk4Iy9HKCkuvVzTlbhdez/gKiWa+Zvl+hrwBtC0f57c6QyJ5+5Uqh+yIhCtdKQRMgPx/vzsfRZbLvoUebLnTFszkv5OX35KOvOF6e18KPXRslf64+g9TSzgNy1FV3m7/BP3mSzvu+0weRXedj2VpYvRKLE/Vo0gMMTlVVReGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892583; c=relaxed/simple;
	bh=Wb/d6S/2mzWOGqM4EZhviXMHCgqp/1GcbQpyy4tUiwc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ehDIbSCup6l/bBz8jkHkvVjStWg7fSV84yVfUm/tkqJPaj7QF92eAWojctWQdEdVFJDUHYdJGs64kpK0VypHSGHA9PrbtWGK6ihCOTtpSyd/4eBH7hnLnueC9MyLxoGm4BcsXN7thrELKANRWmI+HjOUBL3Bu7aKWZxc/wxCd+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5pIEjzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335E2C2BCB9;
	Mon,  4 May 2026 11:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777892583;
	bh=Wb/d6S/2mzWOGqM4EZhviXMHCgqp/1GcbQpyy4tUiwc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=B5pIEjzW5h5Y+mDuplIe2nEXf7CkXJw3rOGHBvInZOfBZBkjKWwyEGciL2x/4ud80
	 tXfSakkYSSxyJDSg1sLiPD2MBxmFXdEfxlaAMUCY8sUbMAp0nKc3Th5GeOmIefxPAe
	 BbpSOrMNvGZvak4e10BBJyVgiBb31LB2y/GxthnLyM9blTy2ez7Y4r3Vywb47YV5zW
	 xkGqTG9DPYryWacyWAiklfOuizhLaUYrFEPxPmcL/POkZ0JenW85RzLVzO/Q6wsgJR
	 ryyvZceMFeurcFyA7PUsKj2TJFtZdaPHuH5PKixulZtZYFKVgR6v2ejRPR2iK/Wt1p
	 Z60a3siK0C1Sg==
Content-Type: multipart/mixed; boundary="===============8283254778776529300=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2f7f312ca0ffaa0a9bf0ca5e33b83dc035a9df051f557edf68378f23921c087d@mail.kernel.org>
In-Reply-To: <20260504101759.3319427-3-nhudson@akamai.com>
References: <20260504101759.3319427-3-nhudson@akamai.com>
Subject: Re: [PATCH v6 2/6] bpf: refactor masks for ADJ_ROOM flags and encap validation
From: bot+bpf-ci@kernel.org
To: nhudson@akamai.com,bpf@vger.kernel.org,netdev@vger.kernel.org,willemb@google.com,martin.lau@linux.dev
Cc: nhudson@akamai.com,mtottenh@akamai.com,aglasgal@akamai.com,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  4 May 2026 11:03:01 +0000 (UTC)
X-Rspamd-Queue-Id: D05974BC1CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[akamai.com,iogearbox.net,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-283795-lists,netdev=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

--===============8283254778776529300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3484,15 +3484,20 @@ #define BPF_F_ADJ_ROOM_ENCAP_L3_MASK	(BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 | \
>  #define BPF_F_ADJ_ROOM_DECAP_L3_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
>  					 BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>
> -#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
> -					 BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
> +#define BPF_F_ADJ_ROOM_ENCAP_MASK	(BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
>  					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
>  					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
>  					 BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
>  					 BPF_F_ADJ_ROOM_ENCAP_L2( \
> -					  BPF_ADJ_ROOM_ENCAP_L2_MASK) | \
> -					 BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> +					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
> +
> +#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
>
> +#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
> +					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
> +					 BPF_F_ADJ_ROOM_DECAP_MASK | \
> +					 BPF_F_ADJ_ROOM_NO_CSUM_RESET)
> +
>  static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
>  			    u64 flags)
>  {

[ ... ]

> @@ -3614,8 +3619,8 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  	bool decap = flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK;
>  	int ret;
>
> -	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
> -			       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
> +	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_DECAP_MASK |
> +			       BPF_F_ADJ_ROOM_FIXED_GSO |
>  			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
>  		return -EINVAL;
>
> @@ -3627,6 +3632,9 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  	if (decap) {
>  		/* Match skb->protocol to new outer l3 protocol */
>  		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)

Martin KaFai Lau raised a concern in v5 about whether non-GSO packets
properly handle decapsulation state clearing when bpf_skb_adjust_room()
is used to decapsulate them. He noted this has been asked multiple
times by AI review bots but has been ignored.

The concern is that BPF programs can call bpf_skb_adjust_room() to
decapsulate non-GSO packets, but if skb->encapsulation remains set after
tunnel headers are stripped, downstream network stack components could
misinterpret the packet as still being encapsulated.

Martin noted that bpf_skb_net_grow() sets encapsulation regardless of
skb_is_gso. Looking at the v6 patch series, the code that handles
decapsulation state still only operates inside the skb_is_gso() block.

Should the decapsulation state clearing logic handle non-GSO packets as
well?

Lore reference: https://lore.kernel.org/bpf/2026427201356.-eYM.martin.lau@linux.dev/
Reviewer: Martin KaFai Lau
Date: Mon, 27 Apr 2026 15:19:53 -0700

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25314425016
--===============8283254778776529300==--

