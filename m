Return-Path: <netdev+bounces-57480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BC3813285
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CC91C20F60
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFC758ACE;
	Thu, 14 Dec 2023 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYq9lQJB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AAA9C
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:08:25 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so13279a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702562904; x=1703167704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra14q5pybHSmbvPfnpmt+p89N5XW/mI9tpXAvd+fYEQ=;
        b=gYq9lQJBmB2InrCdN8jyTgMvbq7qxQInzjEuna+Nxti5QyuYHTm+dB7+5e47YEoZ1N
         d7IC+9LP9I8NzGR8rdZmlFb4xRAsXeaW/R8pvqoIyFt82tpKbzJFTXwL9S+r5gZOubre
         GpIQ/kIBKh5FEMbnEbqVvRPqLDcxk1CDe9auy/VlDu1aCJsDWm/GYGNJ1zefdaKYTSZR
         2qvwzOALgxhb3Ysctqy7vqFsPtr2kn0CTLo9F+sOdtQFl6IFLu0ewPx6Vtw0eBtGS1/t
         EQ+DNu2iMTWTECAb9CZwPs7znSXVREVZaZ/DZLCo9PshcNn4wMpbG2/soC93BF25Dpdb
         lTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562904; x=1703167704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ra14q5pybHSmbvPfnpmt+p89N5XW/mI9tpXAvd+fYEQ=;
        b=EJMHrudTXAFCAO8sCA9F13K5L2paFC6S9FR7GQiLs3jyMrxDS3dIRR+VW73l9vU/I/
         Zb3NaeV2mAHMj5hzFCfZC6yPdhz4oJSbjpvhecPgUR1ZcADRj4MPbRa/dEvlZBUd8xdf
         +EX7qneLsAYvL6Mj0KaLtQqnsvLiLCTgQBUDvpfnioKvTMo3iZNhVSGj9ounSWIpt1i6
         +I4xYLmJhd//8NQJFtHSY9vcJU4Ih0vbl07isB6s8FeVvF4m/BIaf9fDwmCiYmob2m6T
         y8WYVIDHWoXPkeiwmPsczQ+w5LchN591mBPoPO3cGnAtGILiscn8lizl/0zBsNtcjA2u
         mEsQ==
X-Gm-Message-State: AOJu0Yy5UkQnBWRqwNbaNoVAx1MaS5smx5erXdxsVprrpGu/FMf5RKNf
	yN5lHkzZY6oAmyaoQa+uxoSsTaIvQFEGqMfgYr8dUA==
X-Google-Smtp-Source: AGHT+IEcr3i9kTjaZUHijiY68v1i8iAMcVxvwrCVHbGAR8rQ/c+fFDvJi5UzyAuDgA5W85dhxTJvyff8VXFirWf5k28=
X-Received: by 2002:a05:6402:35c5:b0:551:9870:472 with SMTP id
 z5-20020a05640235c500b0055198700472mr385479edc.1.1702562903991; Thu, 14 Dec
 2023 06:08:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+98ifRj9SJQbK+QJrCde2UJvWr1h31gAZSuxt4i_U=iw@mail.gmail.com>
 <20231213213006.89142-1-dipiets@amazon.com>
In-Reply-To: <20231213213006.89142-1-dipiets@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Dec 2023 15:08:12 +0100
Message-ID: <CANn89i+xtQe9d6YJH7useqY+v31kpHkeg-MxCqtWD90nLrYNXQ@mail.gmail.com>
Subject: Re: [PATCH] tcp: disable tcp_autocorking for socket when TCP_NODELAY
 flag is set
To: Salvatore Dipietro <dipiets@amazon.com>
Cc: alisaidi@amazon.com, benh@amazon.com, blakgeof@amazon.com, 
	davem@davemloft.net, dipietro.salvatore@gmail.com, dsahern@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:30=E2=80=AFPM Salvatore Dipietro <dipiets@amazon=
.com> wrote:
>
> > It looks like the above disables autocorking even after the userspace
> > sets TCP_CORK. Am I reading it correctly? Is that expected?
>
> I have tested a new version of the patch which can target only TCP_NODELA=
Y.
> Results using previous benchmark are identical. I will submit it in a new
> patch version.
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -716,7 +716,8 @@
>
>         tcp_mark_urg(tp, flags);
>
> -       if (tcp_should_autocork(sk, skb, size_goal)) {
> +       if (!(nonagle & TCP_NAGLE_OFF) &&
> +           tcp_should_autocork(sk, skb, size_goal)) {
>
>                 /* avoid atomic op if TSQ_THROTTLED bit is already set */
>                 if (!test_bit(TSQ_THROTTLED, &sk->sk_tsq_flags)) {
>
>
>
> > Also I wonder about these 40ms delays, TCP small queue handler should
> > kick when the prior skb is TX completed.
> >
> > It seems the issue is on the driver side ?
> >
> > Salvatore, which driver are you using ?
>
> I am using ENA driver.
>
> Eric can you please clarify where do you think the problem is?
>

Following bpftrace program could double check if ena driver is
possibly holding TCP skbs too long:

bpftrace -e 'k:dev_hard_start_xmit {
 $skb =3D (struct sk_buff *)arg0;
 if ($skb->fclone =3D=3D 2) {
  @start[$skb] =3D nsecs;
 }
}
k:__kfree_skb {
 $skb =3D (struct sk_buff *)arg0;
 if ($skb->fclone =3D=3D 2 && @start[$skb]) {
  @tx_compl_usecs =3D hist((nsecs - @start[$skb])/1000);
  delete(@start[$skb]);
}
} END { clear(@start); }'

iroa21:/home/edumazet# ./trace-tx-completion.sh
Attaching 3 probes...
^C


@tx_compl_usecs:
[2, 4)                13 |                                                 =
   |
[4, 8)               182 |                                                 =
   |
[8, 16)          2379007 |@@@@@@@@@@@@@@@                                  =
   |
[16, 32)         7865369 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[32, 64)         6040939 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@          =
   |
[64, 128)         199255 |@                                                =
   |
[128, 256)          9235 |                                                 =
   |
[256, 512)            89 |                                                 =
   |
[512, 1K)             37 |                                                 =
   |
[1K, 2K)              19 |                                                 =
   |
[2K, 4K)              56 |                                                 =
   |

