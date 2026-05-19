Return-Path: <netdev+bounces-289615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGBlK+PTDGqJnAUAu9opvQ
	(envelope-from <netdev+bounces-289615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:19:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 580A15851F7
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBD9D300C33E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB2635CB7B;
	Tue, 19 May 2026 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXPmENsR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA12848A0
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225569; cv=none; b=KaAu7oMgBx3i28pj0cNy06MF4qSvxY10KieYg6arFAXHXzsSDwdRy9EoHypo9OceBvkVxVBYmx2coE3QesIyb5oeCA6TrTrLBiOLEqqsdXijq5fNwTTZ4P4Hh8xNrOGDhIu5l994sJkVZN7N7jywi73OS/UD5ULqyZhCQN2lSN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225569; c=relaxed/simple;
	bh=UUMVrupYqfa6TrE8rAs70lwrwBL4CkqVSxIZ3LZgMEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAEqv3xOQ+LfDNJg0kGGYyFBLMAeCS868EB6nQkHpy3UEKSNDQF3duR2h8jfBH15/kwZpM4f44wv71UdnELhXPNU8HyjF8cXyzRi8HljrJzigNKFqP7czs2W08LdiXSvu1ON298HlYct+6cfRR6EXBt9W43LNjqtDre59RAfI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXPmENsR; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-367d88b9940so2580660a91.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779225567; x=1779830367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2TTj68F+to+vqHhU98D0/TgvGyPhnpyqr7saUSK8Yk=;
        b=mXPmENsRuHumOvpalgqnY7I1YVN277PTZwc8vloEQtxMiKIEgpIaQVNzVSN360jB8m
         qc+uyLaxRx62FuDe/B1LhMh4Zt1Pc9yi/hGtIaxDKOtOQUuE3o4d9vbW4iIesIZkWcu4
         JyMW9LY5ULbYjEu2rBYMZFETV4kL1k3JS6DIUWDwAKwwsdbOgEbmbAKhu7ThIjdMx0zZ
         yltGtgThz4W9po57yQpiXQfksP1/Fk0lnt/TY1Yw2gVbzfu6r39tjTWYSyGKTdLccMXH
         UZbdnHQqa1IVjEZ3C5CGd8AKdndDX1FImINgzv4gH5ZbpQqbe+5TY3Ajm08z2iiyHkC/
         hcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779225567; x=1779830367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2TTj68F+to+vqHhU98D0/TgvGyPhnpyqr7saUSK8Yk=;
        b=W26QzqLpM10iC3Oknh87JFmUKfaAEyRJ8XtscXrX5uMqqOxMeTB+p6ydQ5bkzN8emf
         eQd0tvBHjbY1WMphHMZ7Gwp23IKsXTvKvs8FmHMT6UGxUo3XxZbNVeSseswJwBcUbsy4
         8+VRD0QYolfbahRMNxcB4n0tBW/oJTsDyUAUWLL2Lh/7ioVUDKZOO/gqSnp6wmwxsO9i
         KHaRhIQb4YnV+r2F7cc2tSNFcpeTvf2/+vxorb6NsdWEBdhzOPCkUEw4FIp4e9w8YLg/
         9n2YE4yYIGoeS4avq1eibcP0LE5B1sUS+KDankzAkpm8J3i2XoDFdE4KwDdo8rOubw2J
         zz1A==
X-Forwarded-Encrypted: i=1; AFNElJ8nwBToNkDVmb3WdiTTnfRVa3Wc939NdgWnAqH4mWpH/icggZdEpx5gez+xhj1N4v9UrnFESeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtuUYnW6Ggmn8OtnuAT74tIHwytvxcOLrgaz3HpLl+x+Os7xf+
	VoP0YGXuAodXNO2sGO2Ly1wd0Ru+SgaxRA0Jf8ZZwqHKYkf6OCgrgPTm
X-Gm-Gg: Acq92OF/xmsAiqzz1y2XstG67NP4kqZL0p7KoyPb2uOzt4bsraTaRazZsAei1U7tYXI
	QRy6IhLVdBWYGY0eejD0ml3Urzi7HJMtX5BzVsDB5a+HtNqCrcW2ZVt/6Qjv+35/O1HZbdpDvml
	axnd6CWZMD/mKJBuNWh34T0Pa8YtsQqHznA2zC63EcWJFAib5JxwYT7M1qX6DMljzEzZi6tEXtW
	mf+RgzqFzFTfdwOBc+vX6Vqt62/PMmLRkloJJFa9oAQtJ36Hge3MBPhjNj7AhC5JARi768U6Hmv
	xPz/24ZKByskGYnDRL7TM+MK8N/r/4N0AX2wMUYTYTn9Jpf/eA++fFwzyRPbG1gpirCAKZD1/Sc
	S0gpps+bv7qhQ5uC2e8Ho2XwWrfg3Fnp9i7WO3HOXD6OHvE+JoKRCvhp2GitmbKOOxhrTdObQHp
	fjES4XCp5FUVFotUHLgDWc6snIkcs=
X-Received: by 2002:a17:90b:3d0a:b0:366:479e:63a5 with SMTP id 98e67ed59e1d1-369518b25cemr20780833a91.2.1779225567475;
        Tue, 19 May 2026 14:19:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517aadb1sm14984388a91.9.2026.05.19.14.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:19:27 -0700 (PDT)
Date: Tue, 19 May 2026 14:19:26 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v3 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
Message-ID: <agzTbgnDCd9DkPOz@devvm7509.cco0.facebook.com>
References: <20260517063311.28921-1-kerneljasonxing@gmail.com>
 <20260517063311.28921-4-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260517063311.28921-4-kerneljasonxing@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289615-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,devvm7509.cco0.facebook.com:mid,tencent.com:email]
X-Rspamd-Queue-Id: 580A15851F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/17, Jason Xing wrote:
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
> budget for normal packets. This behavior roughly follows how xmit path
> treats overflow packets previously: stop sending packets when detecting
> the desc has problems. Here, it is stopped only when this group of descs
> from the same skb are completed.
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
>  net/xdp/xsk.c          | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index ebac60a3d8a1..8b51876efbed 100644
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
> index 0a6203c42576..298194b7335e 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1016,6 +1016,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			xs->tx->invalid_descs++;
>  		}
>  		xskq_cons_release(xs->tx);

[..]

> +		if (xp_mb_desc(desc))
> +			xs->drain_cont = true;

Since you're gonna be addressing sashiko comment, should we also move this
part to __xsk_generic_xmit? Right after err=0? Feels like having
both true/false/check in the same function is a bit cleaner?

