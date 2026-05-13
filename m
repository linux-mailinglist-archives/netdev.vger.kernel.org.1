Return-Path: <netdev+bounces-287681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOUUEOutBGoSNAIAu9opvQ
	(envelope-from <netdev+bounces-287681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:59:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CF8537924
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB7423309C71
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2489C4C77A6;
	Wed, 13 May 2026 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0JDUJgr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9438E5DC
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689670; cv=none; b=Ble8hNI6E6/BrzpBH0frqa4CIP+wyT5slQaP1mfRGamTj4/yz5TMvMolEPgbvmcI8MDvDT9pNsbjepuavwkyCjuPNYlEvnMndPTBlbhBC2+it+PNHTSi0tMu1be7aDio/KQ++TtgO6mfDbg54PylSWvFbl1ANNVjcYhhnQAIXtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689670; c=relaxed/simple;
	bh=TX0kYo3IPD/QDmZb26RHDvq8OAtrVLD5KqLuIxcLHo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExAOKyU2g+cOMH4lFS6sNxJpdvxpZ6T+VuU4TRayRRa3Dh7dPROWpf2JFhFYPq7J7ZImpVL7G2C5TZdYsb/aonohi2oe8/stLYCy2dNMZIaJK+9w3Rh7FY5kwi8Ys2uwOIdu5qEEi2JXRJi8BIdPZQ3oPe3kMV6PbGQJRMCFGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0JDUJgr; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-366087480d8so6320873a91.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689668; x=1779294468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNDcBPQNCRGE0nvZJMYBPFPscAWzaS2iHrcSd/IVAZo=;
        b=Q0JDUJgr1IiwmXruAxZjqKQecXrgaramfbdYb6TyCRSnX35rhM1hEXBpza3ln3YcQu
         bNkAbvjL3sFUMBimC5JSWwETr7kpHHYGzpUOrJRDhVYQSQyNprrd6I9lRdKoxP+Uil5s
         jnx3CNa2lQhnbxPWHz72WA802Wbrhjb0jjSwUyEyIKKRCM7o5xRkrz7DovAB1JWnb9IB
         GWjlf/OItP3rfeFHiHoA/9peJON23piw+1NNC6A5kWYeSG6CdCubXdQq0KCKqwPd746D
         7cOEGhtppV/sJEVvkcKMVlE/z7gaA/8zxiPNoEdQq73vjaNpuxqJsBHZoSlWaDexRZts
         MpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689668; x=1779294468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNDcBPQNCRGE0nvZJMYBPFPscAWzaS2iHrcSd/IVAZo=;
        b=ZPii7k4scIpTHExAwxJFUcs+OL0ms6uvV5506qx8R2YFdv9p2d8YyyRM6wf7nsYJqE
         Yy8TuCxjCLlQP1uwcDnwXx1+USbCj6MDAhDkRCVobgwdd1KcSNsuGSSiFJb8l0cMGpo0
         xPrIEAfWVmb9nHYsaD2vHsU6+zysUIUsKfcm44mwTWxt95BtH4VmJAI+pQ1fpZaE88y5
         txDPQnFBITfTR9IvRWeYWANDg9S9kD+jPWKyHYMSgUHKGkmI/ubj1bVJV8l++uNLMiyu
         gM7KTwxz/xUa3dwZmScuhhk7Z4eMQGU5eaJ3aEN098PfAVQxHtfifsj/xhF33NWUZIHQ
         rduw==
X-Forwarded-Encrypted: i=1; AFNElJ/YttMUF2L+S119yAFPvhma9bSteIBlW72uoqluG7sxwLG4Ul8RutQwY5zAtRqfGBsC+d9xKWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHjl+Mi6E0V6cUpL6m388Az7RbjGVUPQCAwvz1p/l+exSN5c1w
	3QNQ8uTW2btzu5EJcT1h+yyij9rnGl2+tkPwm6Jb54qX0q714w38/yWG
X-Gm-Gg: Acq92OEM6dXk95YHRFvowbgomHl5S6Imjzbm698tGFBAeLbFUCPRjBUvfVIWLVPconl
	LkhOAKf4pdDf+TlRITOTMZtA5N4JezPdeJg6xOdChgct3SPpCTkYhcDpcJtXewEIahbSxvu57Zg
	nnKNlYj/27dszcu9W7/k7DyZ9oOzIcOVu5+S0MPa+xeykJDmh9PXkNcxJlrvZK7HB8hcRbgJ5Iq
	+sea8VuT7OlTt85CAnDikmKlQe2p/ezrB9enVuc8GPFgt1otP2mDuF+0cOJwE+29BWqhHrtk6Ep
	qfiL4MCqyQZW4JyFcOTZS28YDI4PcLULTIXfTtyDg/DFmQOvtTFEwY11BFCGtl+tx6f//VYatsY
	7t9UxBI2KAnEL4xxZHDYYQBPaix8ZfrJlb8TT5kB4OhhGpjUe3BqY9Z9jGQ6gNCVusvJfDWfjyw
	WRSK7ekNAnQkuixSFkeCU4Ur0f9aM=
X-Received: by 2002:a17:90b:3c8f:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-368f2dcf4d8mr4396218a91.0.1778689667716;
        Wed, 13 May 2026 09:27:47 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368eddf4d84sm4342127a91.3.2026.05.13.09.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:27:47 -0700 (PDT)
Date: Wed, 13 May 2026 09:27:46 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 3/4] xsk: drain continuation descs after overflow in
 xsk_build_skb()
Message-ID: <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-4-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260510012310.88570-4-kerneljasonxing@gmail.com>
X-Rspamd-Queue-Id: 94CF8537924
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287681-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Action: no action

On 05/10, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
> only the current descriptor is released from the TX ring. The remaining
> continuation descriptors of the same packet stay in the ring. Since
> xs->skb is set to NULL after the drop, the TX loop picks up these
> leftover frags and misinterprets each one as the beginning of a new
> packet, corrupting the packet stream.
> 
> Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
> and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised.
> The main TX loop in __xsk_generic_xmit() then handles continuation
> descriptors one at a time: each gets a normal CQ reservation (with
> backpressure), its address is submitted to the completion queue, and
> the descriptor is released from the TX ring. When the last fragment
> (without XDP_PKT_CONTD) is processed, the flag is cleared and the
> function returns -EOVERFLOW so the next call starts with a fresh
> budget for normal packets.
> 
> This reuses the existing CQ backpressure and budget mechanisms, so if
> the CQ is full the function returns -EAGAIN and userspace drains the
> CQ before retrying. Zero buffer leakage, zero packet stream corruption.
> 
> Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/xdp_sock.h |  1 +
>  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 23e8861e8b25..1958d19d9925 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -80,6 +80,7 @@ struct xdp_sock {
>  	 * call of __xsk_generic_xmit().
>  	 */
>  	struct sk_buff *skb;
> +	bool drain_cont;
>  
>  	struct list_head map_list;
>  	/* Protects map_list */
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 3f1e590c855d..232dd7126905 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			xs->tx->invalid_descs++;
>  		}
>  		xskq_cons_release(xs->tx);
> +		if (xp_mb_desc(desc))
> +			xs->drain_cont = true;
>  	} else {
>  		/* Let application retry */
>  		xsk_cq_cancel_locked(xs->pool, 1);
> @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
>  			goto out;
>  		}
>  
> +		if (unlikely(xs->drain_cont)) {
> +			unsigned long flags;
> +			u32 idx;
> +

[..]

> +			spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
> +			idx = xskq_get_prod(xs->pool->cq);
> +			xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
> +			xskq_prod_submit_n(xs->pool->cq, 1);
> +			spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);

Not sure I understand why you want this if you're still marking the desc
invalid.

> +
> +			xs->tx->invalid_descs++;
> +			xskq_cons_release(xs->tx);
> +			if (!xp_mb_desc(&desc)) {
> +				xs->drain_cont = false;
> +				err = -EOVERFLOW;
> +				goto out;
> +			}

I also don't understand why you want to return -EOVERFLOW again? Why not
(quietly) swallow these invalid xp_mb_desc from the previous packet and move
on?

Also, have you considered doing this drain in xsk_build_skb error path?
Is it more messy? Carrying this drain_cont across the calls seems a bit
too complicated (but idk, maybe the alternative drain in xsk_build_skb
is even messier).

