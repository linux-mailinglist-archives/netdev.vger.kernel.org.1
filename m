Return-Path: <netdev+bounces-56399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE1480EBA2
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8BE1F21376
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593435E0D6;
	Tue, 12 Dec 2023 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D03caCzt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22A8D5
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 04:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702383847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh2o7nJ9hgKkmCeHJkuQsBrVEDksQ7HxWmE9ZY7lewY=;
	b=D03caCztrNvsjdkT5yNCafq6MA+bz6wEAgumFd1Dt3NGZjIO4CuirSLtofOVrvQkxAcz5W
	44jrXHNFz2dQu3WfhPedH4+2wXOjfHsuBHZ3XvD4Cf8k0sUz8Bppi8DtgOIzu+qW61Nl/y
	j5821qcoNEZcr+6nfFz+KflxUHOHIPI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-1aiUjnflPJOnHf7H6kd3yg-1; Tue, 12 Dec 2023 07:24:05 -0500
X-MC-Unique: 1aiUjnflPJOnHf7H6kd3yg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1ef5c7f80cso52922666b.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 04:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702383844; x=1702988644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bh2o7nJ9hgKkmCeHJkuQsBrVEDksQ7HxWmE9ZY7lewY=;
        b=rvbNvvsIR2Yr2cRINDNbWYbUObp+VKv/5wLMO7fvSTepNC09XUDeeDUNKFkBSfCWdU
         2M+N6V//Nz7DGIQHuskdHFY92H5SZjzAYXzxBYoQ/6xL909uZ4dLM9doXk7xTlxHi42i
         qNA5SZze0tOAMapKcDNHHGDTc4r5RdebpGq49/SA3tE1ryBKmV1xMF9DJaPt/wL0zmhT
         XbnBQLldg8vKdVzYsKkQXmTi7sQqkJsc9NU4ZmnO9NNFC2go14QTZoig5owfEiztmCCc
         WEFFOWGxEdJXK3qwrOyeS+xxeROYtib9Fan59GcudbZMiLOCCdfkEaPNFb/Pr5gMI+wv
         QxIA==
X-Gm-Message-State: AOJu0YwhizOK+MLvOPUflWtiHLO2IgOvBcpobPVyS3ugV9zn/yaIa0gg
	VLK7lp191QCL9u49JklcquMBkvFYChbUikLmiKYTflT1RVXbLVBAiSaonXnlB7myQ37WlQihv0j
	4BO4qZJIbigBhjW0q
X-Received: by 2002:a17:907:a092:b0:a1d:8a15:3bdf with SMTP id hu18-20020a170907a09200b00a1d8a153bdfmr5508041ejc.7.1702383844692;
        Tue, 12 Dec 2023 04:24:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM34tQQalGqfRlEWyG0HbkfQcGm6DhC2IvKcaP46nJVicJuHCGcr2GvBTXH31TIx9aXzhUDg==
X-Received: by 2002:a17:907:a092:b0:a1d:8a15:3bdf with SMTP id hu18-20020a170907a09200b00a1d8a153bdfmr5508034ejc.7.1702383844394;
        Tue, 12 Dec 2023 04:24:04 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id tq24-20020a170907c51800b00a1f9543a540sm3529708ejc.160.2023.12.12.04.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:24:03 -0800 (PST)
Message-ID: <25d2081c0dd277976ff2133614bde290e3003b61.camel@redhat.com>
Subject: Re: [PATCH v2] appletalk: Fix Use-After-Free in atalk_ioctl
From: Paolo Abeni <pabeni@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>, kuniyu@amazon.com, davem@davemloft.net, 
	edumazet@google.com
Cc: imv4bel@gmail.com, kuba@kernel.org, horms@kernel.org,
 dhowells@redhat.com,  lukas.bulwahn@gmail.com, mkl@pengutronix.de,
 netdev@vger.kernel.org
Date: Tue, 12 Dec 2023 13:24:01 +0100
In-Reply-To: <20231209095552.GA406496@v4bel-B760M-AORUS-ELITE-AX>
References: <20231209095552.GA406496@v4bel-B760M-AORUS-ELITE-AX>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-12-09 at 04:55 -0500, Hyunwoo Kim wrote:
> Because atalk_ioctl() accesses sk->sk_receive_queue
> without holding a sk->sk_receive_queue.lock, it can
> cause a race with atalk_recvmsg().
> A use-after-free for skb occurs with the following flow.
> ```
> atalk_ioctl() -> skb_peek()
> atalk_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
> ```
> Add sk->sk_receive_queue.lock to atalk_ioctl() to fix this issue.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> ---
> v1 -> v2: Change the code style
> ---
>  net/appletalk/ddp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 9ba04a69ec2a..016b8fb7f096 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -1775,15 +1775,17 @@ static int atalk_ioctl(struct socket *sock, unsig=
ned int cmd, unsigned long arg)
>  		break;
>  	}
>  	case TIOCINQ: {
> +		long amount =3D 0;
> +		struct sk_buff *skb;

Please, respect the reverse xmas tree order: no one-off exceptions even
in this period of the year (pun intended ;)


>  		/*
>  		 * These two are safe on a single CPU system as only
>  		 * user tasks fiddle here
>  		 */

Please remove the now obsoleted comment above.

Cheers,

Paolo


