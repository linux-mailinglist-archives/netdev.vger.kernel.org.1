Return-Path: <netdev+bounces-286705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMM0LzvyAWqymgEAu9opvQ
	(envelope-from <netdev+bounces-286705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:14:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 403CD510F6A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BA32310FED3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1612273816;
	Mon, 11 May 2026 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eODpyZXB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618F26FC5
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511811; cv=none; b=cfZ9bGXlA+10IMdfSke7EA9JjLmo6SFnS3+f6JYRNEMvF691XuJiiCSl2pFpjc6J4/FLFt+3TWu1QzmWHuBwNi2F4qK1JYgho8FhYY7E+gGAL2SBSNnOanq2MM/Hg7Bibd3ZfifYyFJ1C3YkMTOYbTDE6hQ+DVR2ZOmoGYmK3uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511811; c=relaxed/simple;
	bh=FcCFzrHu4yPb9ChdGb3IYZ67Iw+sGK/r/8NLA62dU8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCdwY8+yioGfrw6SHgNhYHH7nsHPzv0Jh40ibX+iMgVqbzkAtH6MEMqQmPhhrH5jml6i48zC+kItDXJUT+axFXhqCW9jgdlu3c16gr/FEUk/7rulhv0mtfn+BnVMK/6pMh0RC6QJYBBsxRJg0uoFv+urCmg9AJr2MQHk5ckyS2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eODpyZXB; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so3296067b3a.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778511810; x=1779116610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXqTBRULBy1BYm3Ife8V4Q/X4vLGr/NnZVXSc/9oY2E=;
        b=eODpyZXB+piAdEsaL164XWOwf/5wl7HT4x42iT5dRtlpnJL4hQ2AuMC2E8ODxxmXbT
         VNuGTbCNngVmowss5J40i8UgBF2cFZGOa1aIJCVzLSS47YPjDa5kQTBJ2HqM+qI/RrT+
         3SiPFspCMpJbWKpnpAnR/syFsirVYEi0h5paF5SB9NnPBxPP/1FVxIVORpNrY9FXjzNN
         S6p4rkS/zATokSQqpNBHTmE7fUqMGW5VLt36A0rtTFSAO96c64FBWd58R456ImN+AIBS
         CYIYfVfGXCwEpmjW9fNuQj9LwXoSDRnD6trBMN3dPcjr9T5syOF5UApyZ98CdqcBpEhb
         jfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511810; x=1779116610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXqTBRULBy1BYm3Ife8V4Q/X4vLGr/NnZVXSc/9oY2E=;
        b=eNoN+BZBitPgtoS+6ZBP9N+rg6hiYdbjvaiyyU8ehaPajeWP5vkTXn+stOls3ZxZcE
         0Q1t+a3yBD0p1bagQoEFv7w0UqppxR7llVuKbzX6j4GA0wlSBP31Gadff4UkUXIeq1oi
         alCiIaxEaysIj01BADjsuiaL7/ORLKVq5Ou4GSzifqOjlFyT1adDenF8U54ACAGW+fE/
         yv1olUpHGl93QKj/WxfY3/ztgfRQD7NMRZPRcgcPF8sMXX4QsQf/aFjHYxOMAaCuvv90
         4SjAUvnFZ9bgBBklt2eMiqWfIQGEdqT4FwvOoV29eI3m9oSbrmkYqYhWc8lIARAXkSLu
         fyBA==
X-Forwarded-Encrypted: i=1; AFNElJ8cFi7gGEn/boXKAwTlMlHe3CuL4dzK/ihCSRYmrAzY+KdXYDMJ1JdJt1DaX4Ywtr7pN5IvIBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/rpX9v7w1N29t4Af73tvjhWN4M4woPEMtiioRRPEl7lyyt+8
	knk78wzpp3Qu5G8E4+Zcp79oU6XAOKc0qN4pn6NXvqmTyOM7FbpPtslw
X-Gm-Gg: Acq92OFreMu4EzhdvJflXU34x9O7RNBEUYwQie6h7fPhzFSrivuyjNzMD1Rx+03vwPf
	FLfdZA9KGZsvorQDgxKJUjaikpexJiwiKW+sjiRo1JgRBozClCPODiTTRpvXyLB2H3HW90xb4v/
	CU6QNBwuW7FHbzbjmwRHOVTd/Bi2ufDcEeJT3sRIM/HWBnqN87P+B2+ZJ93nQBJXgpl2B2GTDn8
	0XmSAQlrxzLCpGaqqgKthBVZrGuLbJMuybv24EWuQRWXRaXrPSK1ReFIBZv9xfwgRBhzZCOVeqJ
	vS3Jf2wNvNqzBP300p4mucDfIrAz10hfNeg3h6ELqmt7ARBMYqfelB7IlRg80PrcgpWDOcDrX3v
	KYPvf0smJKYUf58cFULso1YUmelkfpTAxYvTTLyFvBGNF2rShuVWBS1MSLwF0D8t4taWllipvPQ
	5tWFcrHqEJFeTY5Ibx
X-Received: by 2002:a05:6a00:4c81:b0:81f:5037:a317 with SMTP id d2e1a72fcca58-83e3974c22bmr9701574b3a.11.1778511809130;
        Mon, 11 May 2026 08:03:29 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839685a8125sm20717422b3a.61.2026.05.11.08.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:03:28 -0700 (PDT)
Date: Mon, 11 May 2026 08:03:27 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 1/4] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
Message-ID: <agHurBlnAgjVNq-u@devvm7509.cco0.facebook.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260510012310.88570-2-kerneljasonxing@gmail.com>
X-Rspamd-Queue-Id: 403CD510F6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286705-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,devvm7509.cco0.facebook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 05/10, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The TX metadata area resides in the UMEM buffer which is memory-mapped
> and concurrently writable by userspace. In xsk_skb_metadata(),
> csum_start and csum_offset are read from shared memory for bounds
> validation, then read again for skb assignment. A malicious userspace
> application can race to overwrite these values between the two reads,
> bypassing the bounds check and causing out-of-bounds memory access
> during checksum computation in the transmit path.
> 
> Fix this by reading csum_start and csum_offset into local variables
> once, then using the local copies for both validation and assignment.
> 
> Note that other metadata fields (flags, launch_time) and the cached
> csum fields may be mutually inconsistent due to concurrent userspace
> writes, but this is benign: the only security-critical invariant is
> that each field's validated value is the same one used, which local
> caching guarantees.
> 
> Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
> Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 6bcd77068e52..cd039e397018 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  			    u32 hr)
>  {
>  	struct xsk_tx_metadata *meta = NULL;
> +	u16 csum_start, csum_offset;
>  
>  	if (unlikely(pool->tx_metadata_len == 0))
>  		return -EINVAL;
> @@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  		return -EINVAL;
>  
>  	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> -		if (unlikely(meta->request.csum_start +
> -			     meta->request.csum_offset +
> +		csum_start = meta->request.csum_start;
> +		csum_offset = meta->request.csum_offset;

Wondering if it's better to READ_ONCE(x) these?

