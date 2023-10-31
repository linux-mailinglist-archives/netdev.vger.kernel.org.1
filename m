Return-Path: <netdev+bounces-45416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1E77DCCC7
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 13:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692881C20BC3
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0316C1DA34;
	Tue, 31 Oct 2023 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJ+hMpuU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CFA19BAD
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 12:15:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06D297
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 05:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698754515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SoR9dw6L/vKtUpLEuCDInEx5ZPoBrI/+MTbYlj10org=;
	b=KJ+hMpuUJfT45khSRPr99Lm6M4bdyeYfWmTcig2gssEtyfgMQjBaEgQjjkvLJ94GgeyKMU
	5L3wSh+kFnEh/Jyj2kkmHC6eWruxJxenIQl58rSrDfFy8WIIFE5JIM034IlPbvkRXk0c3R
	j4MSAkYRuaVi0q9/WykwJ3vIaWOVYhQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-oDBMWb3BO6aha0iEjShBGw-1; Tue, 31 Oct 2023 08:15:11 -0400
X-MC-Unique: oDBMWb3BO6aha0iEjShBGw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9bfacbcabb1so40446066b.0
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 05:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698754510; x=1699359310;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SoR9dw6L/vKtUpLEuCDInEx5ZPoBrI/+MTbYlj10org=;
        b=Jr9SCRiWisj3jGcZIuFdwvHqVhTXoMajjtda5NYwY+33jx6OOltyY5gKsMpTDUP/C8
         Xvl5o5sstX4qNNMx2ADRyTRRP/CZZu+ocRb9xKsSOcNDhnkr3fNHgoIA+RoHkyD8g2cI
         Xfu2+S5fFT0eHJf1panODYuPHN4s0eQIbTnJLbSDI4oiz+QhMnKRZ2JJGt86/0Ucqjh0
         /cutt0yOhSr78d/GgP90OXJ3toRt2qz6DPLJQIbQ7eHrJT9XiDIQ/grd1x1w9W1cYim3
         1lWoBJlsbOxclPsG2Y9UKTvwEp1sY/d69bvzRI0rW7amncT97Y0XngS4gy2wnkGQLKq4
         GMAg==
X-Gm-Message-State: AOJu0YxugYSZLf98032hcBshbEGI0NBEemtPRo5gb1f/Iju9y2VF+NQ5
	two7FgJKfLH60ANR6GyqnY5MgpbK5ws48BRxL4HoRRA0bRvTvh9trTVgpfeP668GAik9F6yGnFI
	0m10WbKsidP45hgLK
X-Received: by 2002:a17:907:9405:b0:9be:4cf4:d62e with SMTP id dk5-20020a170907940500b009be4cf4d62emr9516793ejc.5.1698754510601;
        Tue, 31 Oct 2023 05:15:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBvwB67W/f+yVP3Dv0iKy2fv/66/hwvd3EiFBACxC0Tx3iEplTHKVNimG9IJ+puWZAXtyhRA==
X-Received: by 2002:a17:907:9405:b0:9be:4cf4:d62e with SMTP id dk5-20020a170907940500b009be4cf4d62emr9516777ejc.5.1698754510287;
        Tue, 31 Oct 2023 05:15:10 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-179.dyn.eolo.it. [146.241.227.179])
        by smtp.gmail.com with ESMTPSA id ha19-20020a170906a89300b0099c53c44083sm881336ejb.79.2023.10.31.05.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 05:15:09 -0700 (PDT)
Message-ID: <75d2f17bd349e220e8095730ef878c358385ae6f.camel@redhat.com>
Subject: Re: [PATCH net] hsr: Prevent use after free in
 prp_create_tagged_frame()
From: Paolo Abeni <pabeni@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Murali Karicheri
	 <m-karicheri2@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>,  YueHaibing <yuehaibing@huawei.com>,
 Ziyang Xuan <william.xuanziyang@huawei.com>, netdev@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
Date: Tue, 31 Oct 2023 13:15:08 +0100
In-Reply-To: <57af1f28-7f57-4a96-bcd3-b7a0f2340845@moroto.mountain>
References: <57af1f28-7f57-4a96-bcd3-b7a0f2340845@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-27 at 15:19 +0300, Dan Carpenter wrote:
> The prp_fill_rct() function can fail.  In that situation, it frees the
> skb and returns NULL.  Meanwhile on the success path, it returns the
> original skb.  So it's straight forward to fix bug by using the returned
> value.
>=20
> Fixes: 451d8123f897 ("net: prp: add packet handling support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  net/hsr/hsr_forward.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index b71dab630a87..80cdc6f6b34c 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -342,9 +342,7 @@ struct sk_buff *prp_create_tagged_frame(struct hsr_fr=
ame_info *frame,
>  	skb =3D skb_copy_expand(frame->skb_std, 0,
>  			      skb_tailroom(frame->skb_std) + HSR_HLEN,
>  			      GFP_ATOMIC);
> -	prp_fill_rct(skb, frame, port);
> -
> -	return skb;
> +	return prp_fill_rct(skb, frame, port);
>  }
> =20
>  static void hsr_deliver_master(struct sk_buff *skb, struct net_device *d=
ev,

Acked-by: Paolo Abeni <pabeni@redhat.com>

(note both trees are currently locked now due to the pending PR; this
tag is intended to speed-up the merge after the PR itself)


