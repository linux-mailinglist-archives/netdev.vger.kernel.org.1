Return-Path: <netdev+bounces-36199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599607AE3D1
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 04:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BA10328189E
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 02:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C67F1102;
	Tue, 26 Sep 2023 02:57:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF37F
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 02:57:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9249F
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 19:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695697063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8rCoPOuaYDCIDe0rlK/tHfmdP2Iqj9+uLvJ1lMY8pc=;
	b=Pf7E7FZn2JfcDosl1+6xhlzVOHZjTIMcotJVMtAyqLSdGCF2r1se7Ip8rxSFiDHFxDrglT
	tVdctKMDRLK8Ut5SohELb3MbHJDQ5aweJWHhPEmfZ6l5345kE/O/IjtMOsXaetCzaASTVZ
	0ojo8Nomoj83rNMMyKNyqcFwYf1V0ME=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-oClSNFQhMbSBehYWJqIf_Q-1; Mon, 25 Sep 2023 22:57:41 -0400
X-MC-Unique: oClSNFQhMbSBehYWJqIf_Q-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c135cf13e1so103328161fa.0
        for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 19:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695697060; x=1696301860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8rCoPOuaYDCIDe0rlK/tHfmdP2Iqj9+uLvJ1lMY8pc=;
        b=fFM16+m17Ez5GNgMtKQ87UwdHeg3xUwiOz9zfIIdskIvROmRh9On1KvcLuVyarPvZb
         Tpagad9+GGXIpUOx1CSbHw8YeoUTU3QeNlIN/2mCPSzgYxzWhwZxx5WE6b/HxTApy4sx
         YbAEgW5eoHwmHWZHvbTrhG7LVqzMskKLZrzgxyp5Ee0zR5gEJf+zRgfNp7dnL65ClCUp
         wvtGR2eC0BVHJoBbbCdDmE9zZqyv0EdrCf0/mtMeg+C2rIoLhibSLrQ1igm1S15U2fvV
         9vINj1oNAYQ+VnE9oRlXqBTtih+VbjTIOSm9wbA0ki1bs1zAZvPmDrg9ic3R7fUTptPl
         VJbA==
X-Gm-Message-State: AOJu0YwgLCYi8x+418higS+3CxTSU6+noNVcu/acjbrstWnTHOyIKwet
	drB96ESNPh5xHrBVbHIM8A1LPGhwkvZIVb7BK9OOh1mOgfN9aQuLX//aNT8LjEN0kAWRS0QdE5k
	FqN/Q7BfTfkrvRIxN56yPq7h1CG+jvEcZ
X-Received: by 2002:ac2:48ac:0:b0:503:a76:4eeb with SMTP id u12-20020ac248ac000000b005030a764eebmr5830376lfg.16.1695697060332;
        Mon, 25 Sep 2023 19:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3RwYqaYdD2D197Rxxx50AyfpQufQFfgo1/JwgJGy62/rNkyDXHkQuYdQhZ6f74/Yi67MydQBhjJAzFfg+eVI=
X-Received: by 2002:ac2:48ac:0:b0:503:a76:4eeb with SMTP id
 u12-20020ac248ac000000b005030a764eebmr5830366lfg.16.1695697060053; Mon, 25
 Sep 2023 19:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925103057.104541-1-sgarzare@redhat.com>
In-Reply-To: <20230925103057.104541-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 10:57:29 +0800
Message-ID: <CACGkMEvWKCoB+u2GO2mRroZDmmxcvd8+ytUjpu6wNcBOAu5RYQ@mail.gmail.com>
Subject: Re: [PATCH] vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 6:31=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> In the while loop of vringh_iov_xfer(), `partlen` could be 0 if one of
> the `iov` has 0 lenght.
> In this case, we should skip the iov and go to the next one.
> But calling vringh_kiov_advance() with 0 lenght does not cause the
> advancement, since it returns immediately if asked to advance by 0 bytes.
>
> Let's restore the code that was there before commit b8c06ad4d67d
> ("vringh: implement vringh_kiov_advance()"), avoiding using
> vringh_kiov_advance().
>
> Fixes: b8c06ad4d67d ("vringh: implement vringh_kiov_advance()")
> Cc: stable@vger.kernel.org
> Reported-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vhost/vringh.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 955d938eb663..7b8fd977f71c 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -123,8 +123,18 @@ static inline ssize_t vringh_iov_xfer(struct vringh =
*vrh,
>                 done +=3D partlen;
>                 len -=3D partlen;
>                 ptr +=3D partlen;
> +               iov->consumed +=3D partlen;
> +               iov->iov[iov->i].iov_len -=3D partlen;
> +               iov->iov[iov->i].iov_base +=3D partlen;
>
> -               vringh_kiov_advance(iov, partlen);
> +               if (!iov->iov[iov->i].iov_len) {
> +                       /* Fix up old iov element then increment. */
> +                       iov->iov[iov->i].iov_len =3D iov->consumed;
> +                       iov->iov[iov->i].iov_base -=3D iov->consumed;
> +
> +                       iov->consumed =3D 0;
> +                       iov->i++;
> +               }
>         }
>         return done;
>  }
> --
> 2.41.0
>


