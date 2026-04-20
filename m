Return-Path: <netdev+bounces-279910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ByMI9V/5mmjxQEAu9opvQ
	(envelope-from <netdev+bounces-279910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:34:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC84E43359C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 749DB302631F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C9E3C552C;
	Mon, 20 Apr 2026 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llGQI+J5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F25336EC0
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713675; cv=none; b=qz3NHcEQc5W2fDFJL78egMg3tQmdyoY6jE73pZkdM2GetudKXT8LDGqqh0CRcbgN9+YWRS1KF8pAzCO5mXihPTgTWNfBlUXuv49JjC9QchS4lyVXycICLGIkb21IEeNYwDUnuDlATgkKhRrL58vYoGhlwT75JKYhk9VEnxuF/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713675; c=relaxed/simple;
	bh=XGKPoDmpV4MgNLy7Oyucks5h+XmlNtCvsW6dSrH75wQ=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=Lvh1KYUm+TXqXNevM11dXikZ+UrfpAvUScNDhpnGb3I6zYU59vduPA5wO26+4t17pcHATaRIeksZZlao0HcKrkqXtZ9ltiwU1ReDbstUcfcrbJebHK+LZMajBug+/Rm8oy3+e0x476YMh4O3idJsifvKDHCdo1m8ElQ2eFOojGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llGQI+J5; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-479dc6d26e3so410271b6e.0
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776713673; x=1777318473; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nqPhSL9n4a1mVszPHKUpvP/Qwk2uvuWeoKOStpa8Uv8=;
        b=llGQI+J5G5w5lOohwAhTZ0opB4yVzbsZM9edTtsl6KPau1ejStsLql7TFCL2PHgzdR
         3AoGy8mA/3T6JE78CT4PqWNEP4tcwGxkxCCinOZWR3FbwsPB020BbGqGENeVarLQxpXo
         dZ0rcec8dbJOGmvkdPMh9aS2o20fUz/pb5JvBvsFAvGVID/ZRag2ScwEcoAfdpV0i8/I
         BlUwK9SeKSfbg9FrVQ3mOcESqRFETKkSCwznX5cv1A07s+448ZUtYOlPyY+EhpR0PeXw
         f+ilNOu02LzLZdkowMY5nspzd1NTfOhw/0P6aIEDAnfrwHMDb7v0JQjsTBAOYQ7shjm+
         oZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776713673; x=1777318473;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqPhSL9n4a1mVszPHKUpvP/Qwk2uvuWeoKOStpa8Uv8=;
        b=fUrCG43M7Wu8NpU89foTMYLtcWxypWz9nWnqQTjyA105K2CGu5N2Qt98yRWs91vF69
         8kjuInRGnUskFXZZr6rym1Sc/7bzaSvoMnpOkT01FbWEcH1l/knVuK4u/Fkc+CsAWHcb
         R50LyiYBBjs8QcN0ZiHdNGj6PjI4nmvxah3vrc5TmTxmeSzq7VvZf9xpc+UcU26uTcqa
         C6k90iaP+5o9j/4QeuplweCOQ0qvJMPyQrtp+vA4Co69P3ncl3aYzpLe1VdE9UZAY1Hw
         0uVOieUh0Buy70XjHQxf41W9j4XAXTP+deo+1rx74SVAQNLcK0tt10h9+6suPd3GgupO
         V2iw==
X-Forwarded-Encrypted: i=1; AFNElJ9fjioesTmxwb8zPptHgZuiHjn9Vl6xGGF2N/Lhr8GikGEAQZOo49WITBBBp+sEdKORIJpcKmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDV/ysoHrtYUD6fEqWCu2P4MPT3rHscBnTm/64g6YpS+ItFq7+
	H4qIJty/VSvLAe0WYReZbyCfgxZ8Q7NX3Z9DkgxtpK1ooCCPgTCZ5dGbK2oFqxGR
X-Gm-Gg: AeBDietRpdVlRrmfShz9x0s/MmibL9MFUU7g/WCcsogXy9q0yZSB1OY7yuTb27qJN5Q
	3PFDy9dlZXLdkrxlsFTsMQ+cLF4MWA4fUXuk6HIaZzUYD+HI6+H3bzQ0NSST/511i+cSRU9o+4x
	SDB5W0SYwLfrh/2tz+Qh+snYmRx6WEipEGGPmInwlqSnZ0LBvZnlwY4HXrwS2t8j7CTckISIgF9
	gaP9bozdBVrbJGMmQdfpCq9RGwmn8CTNAd1P9AukQnXV8xfKeJHIJoZyFY2tIq0R0O0U0nL2UCe
	mPe1mwqsERPj6IMlNE7f/Q++ztgvYbzhwW828XjDvdjgFbQ5HGcaR3hECXPxZ4ZYwpRe2ZtnvVo
	E0Z+0OqAuxWqxcK6GDOH8EJGlSI9x3vRCm/5RoPttozJs222hlGVu60S8vWd2LXiYkN2iiPhHkR
	z9ZEajjPgy45CiXAbEwFrejWu6TK4=
X-Received: by 2002:a05:6808:2015:10b0:479:af11:5262 with SMTP id 5614622812f47-479af115488mr3864242b6e.33.1776713672820;
        Mon, 20 Apr 2026 12:34:32 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975b057bsm10256033a34.20.2026.04.20.12.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:34:32 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:34:31 -0700
Message-ID: <519af099662f2b79eb95ceaabc7f7069.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260420082805.14844-3-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v2 2/8] xsk: handle NULL dereference of the skb
 without frags issue
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279910-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,tencent.com:email]
X-Rspamd-Queue-Id: DC84E43359C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Jason Xing <kernelxing@tencent.com>
> 
> When a first descriptor (xs->skb == NULL) triggers -EOVERFLOW in
> xsk_build_skb_zerocopy (e.g., MAX_SKB_FRAGS exceeded), the free_err
> EOVERFLOW handler unconditionally dereferences xs->skb via
> xsk_inc_num_desc(xs->skb) and xsk_drop_skb(xs->skb), causing a NULL
> pointer dereference.
> 
> In this series, the skb is already freed by kfree_skb() inside
> xsk_build_skb_zerocopy for the first-descriptor case, so we only need
> to do the bookkeeping: cancel the one reserved CQ slot and account for
> the single invalid descriptor.
> 
> Guard the existing xsk_inc_num_desc/xsk_drop_skb calls with an
> xs->skb check (for the continuation case), and add an else branch
> for the first-descriptor case that manually cancels the CQ slot and
> increments invalid_descs by one.
> 
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 6149f6a79897..6521604f8d42 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -893,9 +893,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  		kfree_skb(skb);
>  
>  	if (err == -EOVERFLOW) {
> -		/* Drop the packet */
> -		xsk_inc_num_desc(xs->skb);
> -		xsk_drop_skb(xs->skb);
> +		if (xs->skb) {
> +			/* Drop the packet */
> +			xsk_inc_num_desc(xs->skb);
> +			xsk_drop_skb(xs->skb);
> +		} else {
> +			xsk_cq_cancel_locked(xs->pool, 1);
> +			xs->tx->invalid_descs++;
> +		}
>  		xskq_cons_release(xs->tx);
>  	} else {
>  		/* Let application retry */
> -- 
> 2.41.3
>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

