Return-Path: <netdev+bounces-262379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EyHF/P5o2nSTQUAu9opvQ
	(envelope-from <netdev+bounces-262379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 09:33:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B712F1CED22
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 09:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7DAE3016910
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB3931B101;
	Sun,  1 Mar 2026 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kft5vjrb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B9C19644B
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772354011; cv=pass; b=DpWawrUd58ydBy2+o7rGqzB+pdy3qbnbUt5quQTIiWrw2adoILJy+B/EvovrtwZCL7e69pNjH9PLRhwtmhwTwbNo3Dz7NdFBtXxXXm2U4X4NJ0BeBmah0g5T3mPeHqu7YlCfmiTler5q4KtndIyVmirTAQPdFcMi8DOz48+OHa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772354011; c=relaxed/simple;
	bh=siTj8Zejatvr1oMGEXvL4xY1uJcCQbFpMV34oh8LNag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfJ7mIi9xvO2M40F9IB+haOUHiXAdOnx/7drSemZonY9evHCzangg/NSL+sb8OjQpk3bYDZBpuyVU8RhSVFrqDL/SxI2qQaDNT1Mr4+5tOfQ2+hzS/8EFzDU8EDeYa4K7dMgb/H2gY5XCiBCsZqbQ/LE2zITH45V3XK64YTIA74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kft5vjrb; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3870acaf78eso22664601fa.2
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 00:33:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772354008; cv=none;
        d=google.com; s=arc-20240605;
        b=Ui7JLev3epkmk0edh9l+U8RWfXg8NLjr7PykmWo64m/QI0vomD1lNe081gAgbi5w6h
         gCb4rXoZxy/9RznLJOOwZh9b3MckUpbVaiU7mFIVyZG/kbslbbbPsuMzOHyVJVME9mHJ
         it+hmlPFOw++nsepttn9DLsw5J8ShdevksQxm2IB+UNmDcnwSH9bTSxm0f5Ia5kkoRQW
         ZgWzqUkaWtlKeKtqCTyd9xr8VjDJREgxph5398arEszGUW73156FQKA8m6vmdpaiS48Z
         bkrpBGHe9BS1FbetsvC00wwvyk1+8g4ZBIYBNtTv0Ln6Obv35nGQ3oahNOxJHEWIJpI1
         77lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HW/JHBpwVCOUvm9sz6yTfVw4HBljmr3MM1ZM5hF6MlI=;
        fh=9fI03sPP6nHqBgdLycCg8iv2YgxNrj3sG48vhIXEdJ0=;
        b=ZKSiJ3icBfznOROfxt5YnBVJveV5Ok2j6SRdpVQclk/1lZxqlU2fjE3DTreguk6aoR
         HOtyrQh6onVJDfS+sZZmNGBHluSkA5U9QmC0o2l28B2GTfFgTAKnflC+QN96oSXXu/XL
         7V0YjfW1Zx3tuCrv7L+ZXtw97b7jW/k9VH94h8PFE+pTB3NL5dF60tL3MrRqs6WrxNmC
         enuuV6HVBDZpvRnLDJAwDJSicRsVUHbd85+xQCXQZ7zNjOv1cBpiuPSakw1dKgeBL4up
         9kFfaV/RzKFHZ+w11kpgMufFQ5cuIl+qpjrUwIS7mX0GLZezdwuNb4H4XutRku6HOFiO
         0Odg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772354008; x=1772958808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HW/JHBpwVCOUvm9sz6yTfVw4HBljmr3MM1ZM5hF6MlI=;
        b=kft5vjrbZfi5kF3qDjiBhXD/TMF+NvkTGhZluZxE2chT5tUY4bzmCAwdQPcyaAmA5t
         wqhKoaIST/K9xec0smUiR3zCWiu3gMTPM8Kdk5w3CvdALT85ahbSHeRhCb+s9PY0KwRb
         JYVkQBq1tCeazZJ8g2LRuyJFVtuu9kjzYJQpnafYAAnpEybBINYN6bRtsNZtuPC/A/hU
         lnxcb2sFc5cGVoiRd1i+fW3d8IYGyaHPXVrJs3KmonCe3PXaLnerbwsLFMnpGFPiqe8F
         +lRUCiI734CNvanw+mJmVVYO3MvRm0YVzicAiWVBcwF89omzZZArPXzNmBSFCjEQji22
         pFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772354008; x=1772958808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HW/JHBpwVCOUvm9sz6yTfVw4HBljmr3MM1ZM5hF6MlI=;
        b=CmObwBDUlj17PmeIciOocztTt1JG7iZTt6fCe8sW6xAaguaSnfXqHfEZfAqs5R28S0
         ZPjSJXTp9vJnr6UU9a9OU6j108dStAAq4ianc/5yAONHPDZp3vO0X3yTRLv/PLd8JXyo
         cEF98CEUWhf1dEJTSfAGdRdWXoC1nkLpadXiqRtkg7+zl7uvgUROEC6HqGLHtNr4/QPz
         gsysrAVO4mTBQEglQCVZkyYLxwS/qYNA5qk9a6yBel+tQE5bgQGuJXjY1be8MN2fkZzx
         pqi/Rch+GeF8gMQJYuo4sOdg2JicmoR4IHeregGl15DnY/uWgskKIjHmJZaeA+jc4Ne7
         PSlA==
X-Forwarded-Encrypted: i=1; AJvYcCUfq20kj4KDTVZWd1SqLnj3mIJdYUSTvksoSsLRdWrd8+DTcxJY7TFKlk1ajzJO3cPV4Ysupfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSvQNyc3iCc5Aw+auag4Oe/8hAqueceQNE3NBnfiNCJdLJOmkC
	iWSQEN4NhUb0aYSPqHeB66ech9fCl8+K205UdE82ZaAIyTEPreIoT7PXDxgc7aSntz+cGRP4uvA
	qai+Qu151lZ8eaTrxOLKpB189pHG8qws=
X-Gm-Gg: ATEYQzwmUwX1yD/tZkqtkr6JnksZT7h/vMHIk23PBnCvPqO/vI2FH7amJC+MCiTWQaJ
	dOYuKz2TDiutiOCsWl7LxCu+AWNG8xPjej5QNntC4L9aXxyygHTsEMdZI6dyQhsn2XfhwOusaxY
	cJ0N8UVyzIr2ORbAOhxzPH8X4YLTGcx7bF3GxfaOXGrUZavJ8kSip4fKNpKOnu+gXIeKJKws4nW
	McjpMliaxNXCQFiguzQfUnLJzY0sLmx4gRONR62thm4RMcOegB9b1INxWrNLQiLYWdCIMnTwU1H
	8mYKaiarSzLBHM55JQ==
X-Received: by 2002:a05:651c:2101:b0:389:f95d:cd7e with SMTP id
 38308e7fff4ca-389ff08fc29mr52138481fa.0.1772354008164; Sun, 01 Mar 2026
 00:33:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228141252.435509-1-edumazet@google.com>
In-Reply-To: <20260228141252.435509-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 1 Mar 2026 16:32:51 +0800
X-Gm-Features: AaiRm50z-LObO3fylMOpjZN6J51dkFFL-BSBdVS_8j3tWlg3bng7NP3sua55pvM
Message-ID: <CAL+tcoB8TMZQ94U79FNr9Ag2sq+0vhNZNd5DV1jYsGmB=03ETg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: adopt SLUB sheaves for skbuff_small_head
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262379-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,suse.cz,linux.dev];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: B712F1CED22
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 10:13=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> skbuff_small_head is used both on receive and send paths,
> serving potentially 80 million allocations and frees per second.
>
> Tuning it on large servers has been problematic, especially
> on AMD Turins platforms, where "lock cmpxch16b" latency can
> be over 30,000 cycles.
>
> Switching to SLUB sheaves fixes the issue nicely.
>
> tcp_rr benchmark with 10,000 flows goes from 25 Mpps to 40 Mpps
> on AMD Turin.
>
> Other platforms show benefits with tcp_rr with more than 30,000
> flows.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  net/core/skbuff.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 513cbfed19bc34bbb6767cdd7a50dad68be430fb..79eb7eb6eea9aa4a76c555e6d=
dd33bf0bc84c921 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5174,6 +5174,19 @@ static void skb_extensions_init(void) {}
>
>  void __init skb_init(void)
>  {
> +       struct kmem_cache_args kmem_args_small_head =3D {
> +               .align          =3D 0,
> +               .ctor           =3D NULL,
> +               /* usercopy should only access first SKB_SMALL_HEAD_HEADR=
OOM
> +                * bytes.
> +                * struct skb_shared_info is located at the end of skb->h=
ead,
> +                * and should not be copied to/from user.
> +                */
> +               .useroffset     =3D 0,
> +               .usersize       =3D SKB_SMALL_HEAD_HEADROOM,
> +               .sheaf_capacity =3D 32,
> +       };
> +
>         net_hotdata.skbuff_cache =3D kmem_cache_create_usercopy("skbuff_h=
ead_cache",

Looking at the comment of kmem_cache_create_usercopy[1], I realize
that skbuff_head_cache() can also be switched to kmem_cache_create()
as well?

[1]
"This is a legacy wrapper, new code should use either
KMEM_CACHE_USERCOPY()...kmem_cache_create()..."

Thanks,
Jason

