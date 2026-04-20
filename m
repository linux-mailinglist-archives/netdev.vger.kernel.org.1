Return-Path: <netdev+bounces-279715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JkvJ8UL5mluqwEAu9opvQ
	(envelope-from <netdev+bounces-279715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:19:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0780429DDD
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B3D3301BF5C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 11:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E28388E60;
	Mon, 20 Apr 2026 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSxpCTrY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DD730E827;
	Mon, 20 Apr 2026 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683970; cv=none; b=RK/YnGCKgnx74QAIuB9QQ1VioeUbJvVdrfKYHMj5vAnxW6vKlk7304eEl1oatbD8kT947c5tQB3yNNEFNr/ZoNmeZL5Bf9AAs05UGXKCrpCaCLNi96NiKk94tes84SqXW7GFdK15j/Cv8TMOkHuV/F5aMQEHqZQUV/loCeLxN/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683970; c=relaxed/simple;
	bh=e2+2H+DxKMM2YOsIIOgZMRKbtkP1exDNoUQVB1eETG8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NQwIIElBptalf8iKp/zSbOJvg9UePJa0TME70fD1IkbsE0d+FU1uyHjR60uPNEnfHklvF1XHoKGtGE319VYoUZv7w+1xvvZUb+wxY4TgkKf49B/vCJfGdRC/mg5pN6H8OCT6rM0muG+HBNbnc3FbRbAHPQ4jiSHa1FBY/kOwrZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSxpCTrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271F2C19425;
	Mon, 20 Apr 2026 11:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776683970;
	bh=e2+2H+DxKMM2YOsIIOgZMRKbtkP1exDNoUQVB1eETG8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=CSxpCTrYRJweDH1OZGHvvH78OWBhNP8kmFV5zBt4Sy1bqORj6q7YNOwvPbBuKvG/w
	 Rkxb8LYx0yg4PKpDr9ATHAbUhUrk7ZHBuX9LvmdocLahWfhMSD+9Psl0uBmj+O5aam
	 DdYKVY91rsx/paTKkbh3q+eS1N2kWz+DR9XW9/Sk6wmDkwvwv7F4KndiYeOCmgX1oq
	 I/3ztZRVeY2MSg4vRUKhXahhTa/KJuFOF9BguFZADQYwEHUlRflxMr/E2t2P2o58H2
	 K7JcwzMLrXpdxJNJm2iFRmNpaauSBkJfLFElG1kG57WRCeuhXvwiVG2HJmw6P7RDSM
	 TmUv6itaDTWZQ==
Content-Type: multipart/mixed; boundary="===============7838943085603499213=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2ea5cc41fd138e94dc34b1d4073833118b93ae48d802aabe480e355e27417b62@mail.kernel.org>
In-Reply-To: <20260420104051.1528843-7-nhudson@akamai.com>
References: <20260420104051.1528843-7-nhudson@akamai.com>
Subject: Re: [PATCH v5 6/6] selftests/bpf: tc_tunnel validate decap GSO state
From: bot+bpf-ci@kernel.org
To: nhudson@akamai.com,bpf@vger.kernel.org,netdev@vger.kernel.org,willemb@google.com,martin.lau@linux.dev
Cc: nhudson@akamai.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 20 Apr 2026 11:19:30 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-279715-lists,netdev=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: F0780429DDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============7838943085603499213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> index 7376df405a6b..511022630bb1 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c

[ ... ]

> @@ -621,6 +640,11 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
>  		break;
>  	case IPPROTO_GRE:
>  		olen += sizeof(struct gre_hdr);
> +		if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
> +						BPF_F_ADJ_ROOM_DECAP_L4_GRE))
> +			return TC_ACT_SHOT;
> +		flags |= BPF_F_ADJ_ROOM_DECAP_L4_GRE;
> +

[ ... ]

> @@ -634,6 +658,10 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
>  		break;
>  	case IPPROTO_UDP:
>  		olen += sizeof(struct udphdr);
> +		if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
> +						BPF_F_ADJ_ROOM_DECAP_L4_UDP))
> +			return TC_ACT_SHOT;
> +		flags |= BPF_F_ADJ_ROOM_DECAP_L4_UDP;

[ ... ]

> @@ -655,6 +683,35 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
>  	if (bpf_skb_adjust_room(skb, -olen, BPF_ADJ_ROOM_MAC, flags))
>  		return TC_ACT_SHOT;
>
> +	kskb = bpf_cast_to_kern_ctx(skb);
> +	shinfo = bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info);

Could the pointer arithmetic here cause compilation issues on 32-bit
architectures?

On 32-bit architectures without NET_SKBUFF_DATA_USES_OFFSET, sk_buff::end
is defined as a pointer (unsigned char *) rather than an offset. Adding
two pointers is invalid in C and would fail to compile.

Martin KaFai Lau noted that other tests use this pattern and suggested it
could be addressed with bpf_core_field_size(kskb->end) if 32-bit support
becomes necessary in the future.

Ref: https://lore.kernel.org/bpf/20260416124324.B0CE6C2BCAF@smtp.kernel.org/

> +	if (!shinfo->gso_size)
> +		return TC_ACT_OK;
> +
> +	if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> +	    (shinfo->gso_type & SKB_GSO_UDP_TUNNEL_MASK))
> +		return TC_ACT_SHOT;
> +
> +	if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
> +	    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
> +		return TC_ACT_SHOT;
> +
> +	if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
> +	    (shinfo->gso_type & SKB_GSO_IPXIP4))
> +		return TC_ACT_SHOT;
> +
> +	if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
> +	    (shinfo->gso_type & SKB_GSO_IPXIP6))
> +		return TC_ACT_SHOT;

Are these IPXIP4 and IPXIP6 checks reachable?

Looking earlier in decap_internal(), for IPPROTO_IPIP and IPPROTO_IPV6
cases, the function only sets BPF_F_ADJ_ROOM_DECAP_L3_IPV4 and
BPF_F_ADJ_ROOM_DECAP_L3_IPV6 on the flags variable (around the protocol
switch statement).

Because BPF_F_ADJ_ROOM_DECAP_IPXIP4 and BPF_F_ADJ_ROOM_DECAP_IPXIP6 are
never added to flags, wouldn't these validation checks always be skipped?

Ref: https://lore.kernel.org/bpf/20260416124324.B0CE6C2BCAF@smtp.kernel.org/

> +
> +	if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +		     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
> +		if ((shinfo->gso_type & SKB_GSO_TUNNEL_MASK) && !kskb->encapsulation)
> +			return TC_ACT_SHOT;
> +		if (!(shinfo->gso_type & SKB_GSO_TUNNEL_MASK) && kskb->encapsulation)
> +			return TC_ACT_SHOT;
> +	}
> +
>  	return TC_ACT_OK;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24662733093
--===============7838943085603499213==--

