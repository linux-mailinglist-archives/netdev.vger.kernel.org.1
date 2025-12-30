Return-Path: <netdev+bounces-246387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1F5CEAB88
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 22:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E08300E02F
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 21:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B6417A300;
	Tue, 30 Dec 2025 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QIm3Ojxf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65688B67A
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767130357; cv=none; b=pbAtb3pLk4h57omTyI0Vr5dCVNK3HPhFzVv91sZ9E9Qt0QGFGbA9WiL+SmNfF97VORTVqddId19C38R7UAxiF160DSlxo7TvYN8W/TODou8J4MXVEcA024GAstvJNl5K3cTsz9etKXVr9HDITXsEydz4EClnzJ8nZ3W4q4LZxdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767130357; c=relaxed/simple;
	bh=LMT9Jyiy4vv5NU3wSzYm3bllk24aUfp+Jtz17CtDuyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIxKfkp0xtc8GSJvJWuQ662NYoEtdHLgC9Px0WjvBqGaHLCLFaOTKg8bXXvtWZPNMsn6Wc+0udwMZPcAR08Jw7nRyBICk86tpRJR1bnU/pMv4MdZF/nn7GiTxe48YprEnPl1TDz46XrCsigzjaI/WFwRVPOrTAPl+MdeBoUCGnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QIm3Ojxf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0c20ee83dso131600125ad.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 13:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1767130354; x=1767735154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fogvJd7M6/3tAIpQswcL6Bh1r+vFqYoyUCG2xTi3sL4=;
        b=QIm3OjxfRgqFoC6rnslNm1gqp2fvMkrE2fDTzrXr0PUqyfoAPB/0unxfVjPMKSeZIY
         qqOQB++VQybng94hqrA2wZa4a6/p6eM3wnkMW4HUyFLtbUB6IatC4ToKaose95ZxU52S
         ne//yphTOtlYNd4qTllEMaFkhB08EVGv9Md0MtKCyQ4FI53jZMQsrRpalFJuUXQZ3Pvm
         CwqMa7AtL7WKYa1VSvno/allo6AWthEqwTPbj/x24qJJ1Pj/w/odl2tZGmfm1DJmou8M
         ROgeYUXu5zmL4pEO6t26q5qW2vOynd+LnXQwqQRLIPK2XilOG3ZJBxG22DDc6polL0Ys
         He/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767130354; x=1767735154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fogvJd7M6/3tAIpQswcL6Bh1r+vFqYoyUCG2xTi3sL4=;
        b=Bt6iBnXgJdqMy8M+Jo5GvRyqeOZugqUlfKFOKRnN0pfxsLmyN8JsrQ85bndFu/RG+a
         Ec2W5ML28MJoHX6R4yLNZVvTGyw/jVbgYGGQ2b3KcJcf5gjTlPPcJZEBqk5N3DZbVRZv
         XiE9tr5jOpgfGtGoaybmwuMBhiNfYhrR7QZbH4vLIkGodvRAlj0s9q441E/W1dajhWxr
         BZHwQTewEheoyvkNo1CHWj8ErMowjeEnVcFNZjuiw9YbJaF9iFXuq4KaU1g/1FGQE5PA
         4cKBrnffDYfH+PVqyVDbOt1qyAkAIvcjgT8NWmEH1lueH8exvm6L1nzpQAWElj8WTv6H
         4whQ==
X-Gm-Message-State: AOJu0Ywaw6xXWya+4PiKBNlsyjbybzaU2zbXLhraSQSu9mbE/9osLMNZ
	UOzLFWuDZOjFMXR7vEVEYlKfQFBAxg/UwfJ31O9CVtNg3XP5qzpEZ+g8Dm0ROU4P3dhI078zLjX
	OfEiD1cGQpCzNhlerjrqKB9mxdAKJsNxOiVeUHBTZ
X-Gm-Gg: AY/fxX5pGUp0TF3UFYfMyeaG/Up/1K/4CAIOUx9H57qzcJp6wPv5yyPWsUOjHRRTSEG
	8moNNlq9wQhXIiofOoxMyL8a+l24fs9w9P7r65diG21alGly065CY016VIYyawWn+kMpFmopAeQ
	1r81pBR5GL9/CNcroJvqbDSYbX4OdOjyM3B2fCMPh05mhX8giJG6yu3veWbPhAarqlsT/fYXgxe
	PoWhu/ur+7Q5SlkG2Zo6ptLbIyxdL6bq9QRiVXO8YSOYJsKmHRBs1ZY1WsG6O+Z4YArSvFh6Kmh
	idY=
X-Google-Smtp-Source: AGHT+IGyGlmzTAaqM9W565PMF5auSkaF2mhId1J+Bp+ymXbnvxWOW9ForqZWNORcQQiia3tNeVXDdbKiGBVNE19Q6KY=
X-Received: by 2002:a17:903:249:b0:2a0:de4f:c9b with SMTP id
 d9443c01a7336-2a2f222b700mr359098975ad.4.1767130354566; Tue, 30 Dec 2025
 13:32:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230191814.213789-1-jhs@mojatatu.com>
In-Reply-To: <20251230191814.213789-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 30 Dec 2025 16:32:23 -0500
X-Gm-Features: AQt7F2pEjLPjspsKCAlsX8Gx6PEseFqXYj7y9bNphRqI85JJf3g8bvmQhi5mc6Y
Message-ID: <CAM0EoMmDfrgH7wbguUf+T+mos2ehnm4cnwCGxY4+tZ79_7zB8A@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: act_mirred: Fix leak when redirecting
 to self on egress
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 2:18=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Whenever a mirred redirect to self on egress happens, mirred allocates a
> new skb (skb_to_send). The loop to self check was done after that
> allocation, but was not freeing the newly allocated skb, causing a leak.
>
> Fix this by moving the if-statement to before the allocation of the new
> skb.
>
> The issue was found by running the accompanying tdc test in 2/2
> with config kmemleak enabled.
> After a few minutes the kmemleak thread ran and reported the leak coming =
from
> mirred.
>

Grr. There is a bug in the print - i will send a new version tomorrow.

cheers,
jamal

> Fixes: 1d856251a009 ("net/sched: act_mirred: fix loop detection")
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/act_mirred.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 91c96cc625bd..c9653b76a4cf 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -266,6 +266,17 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, st=
ruct tcf_mirred *m,
>                 goto err_cant_do;
>         }
>
> +       want_ingress =3D tcf_mirred_act_wants_ingress(m_eaction);
> +
> +       if (dev =3D=3D skb->dev && want_ingress =3D=3D at_ingress) {
> +               pr_notice_once("tc mirred: Loop (%s:%s --> %s:%s)\n",
> +                              netdev_name(skb->dev),
> +                              at_ingress ? "ingress" : "egress",
> +                              netdev_name(dev),
> +                              want_ingress ? "ingress" : "egress");
> +               goto err_cant_do;
> +       }
> +
>         /* we could easily avoid the clone only if called by ingress and =
clsact;
>          * since we can't easily detect the clsact caller, skip clone onl=
y for
>          * ingress - that covers the TC S/W datapath.
> @@ -279,17 +290,6 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, st=
ruct tcf_mirred *m,
>                         goto err_cant_do;
>         }
>
> -       want_ingress =3D tcf_mirred_act_wants_ingress(m_eaction);
> -
> -       if (dev =3D=3D skb->dev && want_ingress =3D=3D at_ingress) {
> -               pr_notice_once("tc mirred: Loop (%s:%s --> %s:%s)\n",
> -                              netdev_name(skb->dev),
> -                              at_ingress ? "ingress" : "egress",
> -                              netdev_name(dev),
> -                              want_ingress ? "ingress" : "egress");
> -               goto err_cant_do;
> -       }
> -
>         /* All mirred/redirected skbs should clear previous ct info */
>         nf_reset_ct(skb_to_send);
>         if (want_ingress && !at_ingress) /* drop dst for egress -> ingres=
s */
> --
> 2.52.0
>

