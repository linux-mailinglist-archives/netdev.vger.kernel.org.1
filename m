Return-Path: <netdev+bounces-279911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GzkIN5/5mmkxQEAu9opvQ
	(envelope-from <netdev+bounces-279911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:34:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3384335C2
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0F06302A2D6
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB5C3C5550;
	Mon, 20 Apr 2026 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBTHD7MA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F13BFE3F
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713675; cv=none; b=D01qAqQ1x6lKRklDQ3hUqNqnpzy3k1CuktQycGPdUMeK6V25tvFUt+rhGxBNCtmBtz8Ib8VSgXcb5yfyzKr71WCsyxZMCbliLmtiBTF5YyAFhlmJBLHtZRqqf2FB5HtsZZ6HJWCtSZtORTZKYdbVdJyaFSo+goTW8HFuZznEdtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713675; c=relaxed/simple;
	bh=FZUjnqDk1Xh40RuylXfAZfHlK8yCo4IiGfr9Vlt94N8=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=h47vMfJT46YGJi2F9UOtHWX9ldHZKGkiv57smo7YwQBdbjDqKVI1x2nrNwZKzQy8x+1MkAopUVIZwTDDI2DX4JhZ/5ilkVPvc5rg8hvuhg3bSMzeLKEwOoOVbqBd7fBs88GMFaTYEXjbKig6sv7uZHMEmzKgkVJMzN7vq8EiMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBTHD7MA; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7dcd689829eso142370a34.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776713672; x=1777318472; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qy1Z22ONGxA0iuWXSuM/LMweV9FlzSCH30fXWwBGCAs=;
        b=TBTHD7MAqxK5baqEiSNZ+q1sD7Qp7KpwjwG7RYVOctscs8t+UFKnnVsxBWNRporkph
         g6StTDvBiSTjJ4Q3ZoeDDBld6vMQoKoBsCwAgeKa1uikjerLrf75tdaoJsKhK13bgb4L
         62jKsOnLnJZofdA2hBeZxXC3y9r++7/Dn2jmWnPUf0zAa5aVOUA3pmQ0ZusQTOigwcvc
         kv+FezrSnga0gchAeSFhTL2XJTT/D4ev47lLPG8p6eHRkx3Nnnep6qQwBfpscHF6d6lZ
         //EShAcYw69vhxVH4LgTwFuAXnuDezEmUF8OtzM3MiI7c0BTYYW7B8fYmqlihbYfB2AZ
         tpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776713672; x=1777318472;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qy1Z22ONGxA0iuWXSuM/LMweV9FlzSCH30fXWwBGCAs=;
        b=NEOAL7W4avV468/AuHIO+4vhj94H7fA0jPb4sSZpc/IJG/EM7i4GL6Bg0/i5BrTTnI
         kSTnKFr8xL5ys7WgkUS8Ux8TpSwEAruykR+WnhTR81ij3Tb86fdA4OYOs1e68h77EY9s
         ZWXss0FqAMZ6wr++3T0Sh2USRhsKkb/J42l+XFTZz1yh3zkOuAXNU91R6BIE57cARbuk
         Uadk0Q147O9oprEzszjw388wVri19Bx63spt3sygggCNY9nL5ofDk7umMQr8nbUWaDg4
         /UI1d/gsK0XxQoPdD3q1Lx1b8Z0ePItyxmtAS87Y4Sk1eX0JJ4JfYSkENJN5dksHyncK
         fu5A==
X-Forwarded-Encrypted: i=1; AFNElJ9UR7kVVBZSFRdPvT/lrb2k76htL9dbAwCNGn7xhQ6BBJNp2FtaTf2YwJIRENSs3W+cN1bUbfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0H5tvmggvBJkb5rNLngtdYHdtcUpzSHii67HsqgIo4Iyeqqzh
	Nv/q/2PiAxeIjpPW0Afpbr8V6OLe04JsaVCouUJrWxedt1XIwc4UE47gUMySBfKd
X-Gm-Gg: AeBDietJHd5OL8thmL5yQ1XZZWTp7iYaqjxXvkRJ1oXDGmYTbkmqq8gx43WwE1NglAs
	KPrX9UijDGOpPiNIAjHKRRxMXIXNRPB8fBqKuqfPmygTrNKsHGOgWcbJiQ3t2YFHPZoX7AD+3e4
	gjV1wIGHcgcMlBQLvhn5CkQt8oN8QY+02UeyPMuvQ1VRrtNPK3nbcFfWg70ubkxJ/fxSAH+7Vqo
	dYGo2hM3aEGg9pvQabdThbgD05g6qyanZeLKNEjIxTV8bOK8lqOEDonuaA9BYFFjqW7ytRLnbH6
	T/LIXfcT5xhNanACaHiGLf7xyQY7WIMyh4GSrwrcgwq8JAdHfcAuTtSZ3y0jAr0pPcQRAD5LyCf
	VeObqU11hugfSKTR8SyRp8W80pf/nLmypjr2EmQEpWEqi4MmxOWhRckIFJJsn7j74YXpmoUUp3D
	h1bIq9D32kBVAs0DbnpNfEtrZp
X-Received: by 2002:a9d:5cc6:0:b0:7dc:a256:5e2e with SMTP id 46e09a7af769-7dca25660f5mr5106460a34.1.1776713671739;
        Mon, 20 Apr 2026 12:34:31 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9f062a71sm7927093a34.10.2026.04.20.12.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:34:31 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:34:30 -0700
Message-ID: <e4a22d20c77e94657d63243af39a0667.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260420082805.14844-2-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v2 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279911-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email,fomichev.me:email]
X-Rspamd-Queue-Id: DB3384335C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Jason Xing <kernelxing@tencent.com>
> 
> skb_checksum_help() is a common helper that writes the folded
> 16-bit checksum back via skb->data + csum_start + csum_offset,
> i.e. it relies on the skb's linear head and fails (with WARN_ONCE
> and -EINVAL) when skb_headlen() is 0.
> 
> AF_XDP generic xmit takes two very different paths depending on the
> netdev. Drivers that advertise IFF_TX_SKB_NO_LINEAR (e.g. virtio_net)
> skip the "copy payload into a linear head" step on purpose as a
> performance optimisation: xsk_build_skb_zerocopy() only attaches UMEM
> pages as frags and never calls skb_put(), so skb_headlen() stays 0
> for the whole skb. For these skbs there is simply no linear area for
> skb_checksum_help() to write the csum into - the sw-csum fallback is
> structurally inapplicable.
> 
> The patch tries to catch this and reject the combination with error at
> setup time. Rejecting at bind() converts this silent per-packet failure
> into a synchronous, actionable -EOPNOTSUPP at setup time. HW csum and
> launch_time metadata on IFF_TX_SKB_NO_LINEAR drivers are unaffected
> because they do not call skb_checksum_help().
> 
> Without the patch, every descriptor carrying 'XDP_TX_METADATA |
> XDP_TXMD_FLAGS_CHECKSUM' produces:
> 1) a WARN_ONCE "offset (N) >= skb_headlen() (0)" from skb_checksum_help(),
> 2) sendmsg() returning -EINVAL without consuming the descriptor
>    (invalid_descs is not incremented),
> 3) a wedged TX ring: __xsk_generic_xmit() does not advance the
>     consumer on non-EOVERFLOW errors, so the next sendmsg() re-reads
>     the same descriptor and re-hits the same WARN until the socket
>     is closed.
> 
> Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/#t
> Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk_buff_pool.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 37b7a68b89b3..c2521b6547e3 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -169,6 +169,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	if (force_zc && force_copy)
>  		return -EINVAL;
>  
> +	if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEAR))
> +		return -EOPNOTSUPP;
> +
>  	if (xsk_get_pool_from_qid(netdev, queue_id))
>  		return -EBUSY;
>  
> -- 
> 2.41.3
>

Wondering whether a better fixes tag is commit 11614723af26 ("xsk: Add option
to calculate TX checksum in SW")?

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

