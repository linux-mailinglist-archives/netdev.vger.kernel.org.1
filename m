Return-Path: <netdev+bounces-63079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB9282B1FA
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 16:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8552B1F22F04
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2B94CB5E;
	Thu, 11 Jan 2024 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ctgq38ti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A51D4F8A9
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbed85ec5b5so4222170276.3
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 07:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704987686; x=1705592486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8n+c5+HaqoTUQWw0ne60S6+hbNv8V2JRQGhKX31H9I=;
        b=ctgq38til8se3rXQG1c1tTQyoAJhHqT9oAYLN6Jum3B/Kbx9wZYfUnQj+20QFJSCr/
         SNRYz1HGITgTa6asuMHAq4GzABhCYQ8t20JQbSFmvo7BjKwGmf1eV/XFcOPTksdK24ME
         wrwlRFt2ctW1hoYx4ByPuoEu0SB/uyfbojfmOteXiyCZGUSJ7oNNrjr1QK7zOfvheRSl
         B4HKkxLAYd4vHpUkiaVIvrRfSJ4FMUX16sNOQP+qJ0QG3pSgUOaarDoP5UGkUuuNdSi5
         NIhzJv34btUpc0vg/Oy/Q2qz1lvV8xmNofESSH4Ju3KSn/QkVNTSslUrs0xsPqsNXkeA
         c41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704987686; x=1705592486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8n+c5+HaqoTUQWw0ne60S6+hbNv8V2JRQGhKX31H9I=;
        b=AAOGiDGl31aPks6iJOjdJt9kp7NUo2fwMsmVAlNF9ynHBguC9DOSdwqZSbfN/0jVjE
         p0ZqQUOtKviZndShB3Cb4k/SAW0EFcnSjydLeMYM+1E+bK7WGdz8pIOJkqCFr/eIpvNR
         C19PZ9sm9+rKXEHFnVXV53X8XMjmTNvKBO++8Ao41wm5iselZsxmyv4x1F1Cy58opogn
         0MJG7Kn8F87ceV65M9FA3G1gKtwC+/F0+fr/p+6aDc67Wwko+jPCXumxfW8BBOqISqfY
         W2Z8AzgUnqeqLgwDVn1QbQsY0v9NNX84ojebFSnob1xYo2dH/AYI6L8KerT3BM1D6JJt
         OOTg==
X-Gm-Message-State: AOJu0YzohYHR0RgDOJw0OgG5HQ2g/hEzzSpGO5RPEplFv0eMZWlqiw+o
	AtAkcFFgL2Wg/SMwv8cDLr9Q3z1+8ioUKNk2zPlekDuNIU4X
X-Google-Smtp-Source: AGHT+IFv8yrrWHwJQClVUEnh98sUkfiSgaipbiVhPLDzQpA0H9PpcrnSDeYIOcab05ymzcBLghcBsyW9c7+NaDP4VIA=
X-Received: by 2002:a25:ad05:0:b0:dbe:a706:a244 with SMTP id
 y5-20020a25ad05000000b00dbea706a244mr1048618ybi.66.1704987685908; Thu, 11 Jan
 2024 07:41:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240107144241.4169520-1-ap420073@gmail.com>
In-Reply-To: <20240107144241.4169520-1-ap420073@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 11 Jan 2024 10:41:14 -0500
Message-ID: <CAM0EoMncuSGfU3u_x+15X66PSXMmGPDzpBP0F5_RtMLPY+iu5Q@mail.gmail.com>
Subject: Re: [PATCH net] amt: do not use overwrapped cb area
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, paulb@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 7, 2024 at 9:44=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> amt driver uses skb->cb for storing tunnel information.
> This job is worked before TC layer and then amt driver load tunnel info
> from skb->cb after TC layer.
> So, its cb area should not be overwrapped with CB area used by TC.
> In order to not use cb area used by TC, it skips the biggest cb
> structure used by TC, which was qdisc_skb_cb.
> But it's not anymore.
> Currently, biggest structure of TC's CB is tc_skb_cb.
> So, it should skip size of tc_skb_cb instead of qdisc_skb_cb.
>
> Fixes: ec624fe740b4 ("net/sched: Extend qdisc control block with tc contr=
ol block")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>


Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  drivers/net/amt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 53415e83821c..68e79b1272f6 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -11,7 +11,7 @@
>  #include <linux/net.h>
>  #include <linux/igmp.h>
>  #include <linux/workqueue.h>
> -#include <net/sch_generic.h>
> +#include <net/pkt_sched.h>
>  #include <net/net_namespace.h>
>  #include <net/ip.h>
>  #include <net/udp.h>
> @@ -80,11 +80,11 @@ static struct mld2_grec mldv2_zero_grec;
>
>  static struct amt_skb_cb *amt_skb_cb(struct sk_buff *skb)
>  {
> -       BUILD_BUG_ON(sizeof(struct amt_skb_cb) + sizeof(struct qdisc_skb_=
cb) >
> +       BUILD_BUG_ON(sizeof(struct amt_skb_cb) + sizeof(struct tc_skb_cb)=
 >
>                      sizeof_field(struct sk_buff, cb));
>
>         return (struct amt_skb_cb *)((void *)skb->cb +
> -               sizeof(struct qdisc_skb_cb));
> +               sizeof(struct tc_skb_cb));
>  }
>
>  static void __amt_source_gc_work(void)
> --
> 2.34.1
>

