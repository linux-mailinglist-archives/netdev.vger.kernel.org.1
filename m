Return-Path: <netdev+bounces-36320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9227AF0EE
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 18:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 660BE1C20833
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 16:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E67F286B4;
	Tue, 26 Sep 2023 16:41:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F043A1FA1
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 16:41:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71167199
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695746465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YAyRg25y1ds+4WMOQ2HhwyFuV1Nm/hS+8w3y9qqUyQ=;
	b=ZKerJDtjqwgwk7OOFSz2q/lUaiN7G5diUcDWRF6AO8uOFmLyjwkcnx/7lZIv0EBGcnYsoL
	39TFpfJpUZ/d9+KegKhycJqOgeQyCA2f78khQ9aYijgvm+jYFRwksHTub/KsMnHF4r/GVN
	SVF/mzLuQd69yH+M5cuvWDhz5xGcqUM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-NaCzMlRzNu6pK3CMxW0T7A-1; Tue, 26 Sep 2023 12:41:04 -0400
X-MC-Unique: NaCzMlRzNu6pK3CMxW0T7A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae0bf9c0b4so795822566b.0
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 09:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746463; x=1696351263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YAyRg25y1ds+4WMOQ2HhwyFuV1Nm/hS+8w3y9qqUyQ=;
        b=Q+tBYuc94vsStKwMqFOEYn94p5+uQvlY7YdqhGagQ3YkGxFWZsUsk1rarNeqVs5Ayz
         i4cbqll6UgQTxCE3sylBy9Z31lyC1aJlH7lQSl+PsYR2CHILxAMCJkqltT8plZIif0i8
         iLSQ5UeDhPdcLRG2io9aC4rWICDop42Y7XcD5+nS3K6HF39W9QxjWMakqEsVccGvT2hK
         rt+LC3UtpEyQZB7SPgRFzW/UAKcK4vPPFyqsmC55uodsmZM9kAQAOjY90l+AF2AMO/1v
         GxUXTs7vdf1REspsgTb0xeGVMLE0ewedx1eXkUt64uz4sGakO16XaYR9ErQyzXR4PbYK
         P+eQ==
X-Gm-Message-State: AOJu0Ywng1cahX4RdwqKub4kaULE8Lz7yiBSINDC8dahv178zC3vfiqU
	BiYyG+weqmlzKoF34JC7FYYbOZS/WOyYMXS3cjPZ6bdlILYEesi6U/KXbwn3ZdpoYsi4WM2u4VA
	iZLveaUSstiZPoo7cNZm4JiB412nTqoKY
X-Received: by 2002:a17:906:218a:b0:9ad:7d5c:3d4b with SMTP id 10-20020a170906218a00b009ad7d5c3d4bmr9170360eju.35.1695746462968;
        Tue, 26 Sep 2023 09:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyLnGtjl16ZbEydnXM+tv4CysWF7HTsyNruFiTtg08cjTqOpFUagw9oPsSkwzQbGl91B9XtcGprebhtCWXQ+0=
X-Received: by 2002:a17:906:218a:b0:9ad:7d5c:3d4b with SMTP id
 10-20020a170906218a00b009ad7d5c3d4bmr9170343eju.35.1695746462665; Tue, 26 Sep
 2023 09:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926032244.11560-1-dinghao.liu@zju.edu.cn>
 <20230926100202.011ab841@xps-13> <adf9d668-0906-3004-d4e8-a7775844a985@datenfreihafen.org>
In-Reply-To: <adf9d668-0906-3004-d4e8-a7775844a985@datenfreihafen.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 26 Sep 2023 12:40:51 -0400
Message-ID: <CAK-6q+gfN7GtwfpUvOjNsNE9LSMTGrdLE6+-dgUEkVaA6SK1zw@mail.gmail.com>
Subject: Re: [PATCH] [v2] ieee802154: ca8210: Fix a potential UAF in ca8210_probe
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Dinghao Liu <dinghao.liu@zju.edu.cn>, 
	Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Harry Morris <harrymorris12@gmail.com>, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Tue, Sep 26, 2023 at 4:29=E2=80=AFAM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
>
> Hello.
>
> On 26.09.23 10:02, Miquel Raynal wrote:
> > Hi Dinghao,
> >
> > dinghao.liu@zju.edu.cn wrote on Tue, 26 Sep 2023 11:22:44 +0800:
> >
> >> If of_clk_add_provider() fails in ca8210_register_ext_clock(),
> >> it calls clk_unregister() to release priv->clk and returns an
> >> error. However, the caller ca8210_probe() then calls ca8210_remove(),
> >> where priv->clk is freed again in ca8210_unregister_ext_clock(). In
> >> this case, a use-after-free may happen in the second time we call
> >> clk_unregister().
> >>
> >> Fix this by removing the first clk_unregister(). Also, priv->clk could
> >> be an error code on failure of clk_register_fixed_rate(). Use
> >> IS_ERR_OR_NULL to catch this case in ca8210_unregister_ext_clock().
> >>
> >> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driv=
er")
> >
> > Missing Cc stable, this needs to be backported.
> >
> >> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> >> ---
> >>
> >> Changelog:
> >>
> >> v2: -Remove the first clk_unregister() instead of nulling priv->clk.
> >> ---
> >>   drivers/net/ieee802154/ca8210.c | 3 +--
> >>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/=
ca8210.c
> >> index aebb19f1b3a4..b35c6f59bd1a 100644
> >> --- a/drivers/net/ieee802154/ca8210.c
> >> +++ b/drivers/net/ieee802154/ca8210.c
> >> @@ -2759,7 +2759,6 @@ static int ca8210_register_ext_clock(struct spi_=
device *spi)
> >>      }
> >>      ret =3D of_clk_add_provider(np, of_clk_src_simple_get, priv->clk)=
;
> >>      if (ret) {
> >> -            clk_unregister(priv->clk);
> >>              dev_crit(
> >>                      &spi->dev,
> >>                      "Failed to register external clock as clock provi=
der\n"
> >
> > I was hoping you would simplify this function a bit more.
> >
> >> @@ -2780,7 +2779,7 @@ static void ca8210_unregister_ext_clock(struct s=
pi_device *spi)
> >>   {
> >>      struct ca8210_priv *priv =3D spi_get_drvdata(spi);
> >>
> >> -    if (!priv->clk)
> >> +    if (IS_ERR_OR_NULL(priv->clk))
> >>              return
> >>
> >>      of_clk_del_provider(spi->dev.of_node);
> >
> > Alex, Stefan, who handles wpan and wpan/next this release?
>
> IIRC it would be me for wpan and Alex for wpan-next.

That's okay for me.

- Alex


