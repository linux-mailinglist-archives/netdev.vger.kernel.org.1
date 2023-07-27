Return-Path: <netdev+bounces-21804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5136E764C9C
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B761C21599
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B211D2F7;
	Thu, 27 Jul 2023 08:22:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F02BD2F0
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:22:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C6F26AFE
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690446075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGeV47pO7s8gps9ksu/4+lDYD8FHRHT3YEWZYPUU9kM=;
	b=RldPOVqEBRKf09bvgrDbo2Pcno1jKMFtP2Nl/f7D1hVWOg6TM0C634KIh6ff7RI/R2s1Lq
	uJi6dyZKQzOpgRU/0zZY2JnaMUQFwDd1kb0TwbBXJx4PoXDBL2iLteY288AaNetl6NDBkp
	V0SdcBXgt2FDcDWWlIv0yOhmDuK7J3s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-BnJlvnDON3OwQ6B8JJDlAA-1; Thu, 27 Jul 2023 04:21:13 -0400
X-MC-Unique: BnJlvnDON3OwQ6B8JJDlAA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-767ca6391aeso16195785a.1
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690446073; x=1691050873;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGeV47pO7s8gps9ksu/4+lDYD8FHRHT3YEWZYPUU9kM=;
        b=YCysjojncibU+ehoG2Cxb87uDI4CMSLim7jRrHDK7N2ZKAb1aMNfdw2tTBk+AuUj/V
         I25aTZ8WsSQxxO9yumcdmAw4d6cscTSY5pxiNFYKtF3clwUR8qymTOdglW52r7G5R2aX
         U/1W8XgIX0I54zNpCYx1I7GU+x4eor/VxTl2fI8asuOD8udzdhLzCdKU7Yh0UZVQU7JD
         O+aJsbwDeJbwUgTqH56NMfa4lLwD3e++D/3XVzgJ+RgHZKFiL2TsnO7pQWeMhE8iXUzF
         N6iz1pxisEDoT8rV83T//oB4kI9sxfTP/2KGHw27ZreK25jj355eGyzkNwEbTAzeUKlx
         KY+Q==
X-Gm-Message-State: ABy/qLZBfQ2VyVSqecSBXLzq2OmRieOSMVBTnFbBQzU1d9xZNz1r+CLF
	C2R7DmlPoD85xA+d4mn7EoQUrGdBzHdARRz3k4MGOMvNNMjKAYClHSE5iLm3OtHbSZcP9Psorej
	NEIpPQryybFizffdq
X-Received: by 2002:a05:620a:31a1:b0:75b:23a1:69ee with SMTP id bi33-20020a05620a31a100b0075b23a169eemr4576173qkb.5.1690446073022;
        Thu, 27 Jul 2023 01:21:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHs3zPOBeUj9ojGrgUE/X3gQH8r73DGALfDrJ+7Y3EtRQm+q4OZUXkV2TRkziNvYTa7JtMfZA==
X-Received: by 2002:a05:620a:31a1:b0:75b:23a1:69ee with SMTP id bi33-20020a05620a31a100b0075b23a169eemr4576160qkb.5.1690446072769;
        Thu, 27 Jul 2023 01:21:12 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-238-55.dyn.eolo.it. [146.241.238.55])
        by smtp.gmail.com with ESMTPSA id j4-20020a05620a000400b00767d8663b3asm253886qki.53.2023.07.27.01.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:21:12 -0700 (PDT)
Message-ID: <9cfa70cca3cb1dd20bb2cab70a213e5a4dd28f89.camel@redhat.com>
Subject: Re: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Zheng Wang <zyytlz.wz@163.com>
Cc: s.shtylyov@omp.ru, lee@kernel.org, linyunsheng@huawei.com, 
	davem@davemloft.net, edumazet@google.com, richardcochran@gmail.com, 
	p.zabel@pengutronix.de, geert+renesas@glider.be, magnus.damm@gmail.com, 
	yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com, 
	wsa+renesas@sang-engineering.com, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hackerzheng666@gmail.com, 1395428693sheep@gmail.com, alex000young@gmail.com
Date: Thu, 27 Jul 2023 10:21:07 +0200
In-Reply-To: <20230725201952.2f23bb3b@kernel.org>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
	 <20230725201952.2f23bb3b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 20:19 -0700, Jakub Kicinski wrote:
> On Tue, 25 Jul 2023 11:00:26 +0800 Zheng Wang wrote:
> > diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/eth=
ernet/renesas/ravb_main.c
> > index 4d6b3b7d6abb..ce2da5101e51 100644
> > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -2885,6 +2885,9 @@ static int ravb_remove(struct platform_device *pd=
ev)
> >  	struct ravb_private *priv =3D netdev_priv(ndev);
> >  	const struct ravb_hw_info *info =3D priv->info;
> > =20
> > +	netif_carrier_off(ndev);
> > +	netif_tx_disable(ndev);
> > +	cancel_work_sync(&priv->work);
>=20
> Still racy, the carrier can come back up after canceling the work.

I must admit I don't see how/when this driver sets the carrier on ?!?

> But whatever, this is a non-issue in the first place.

Do you mean the UaF can't happen? I think that is real.=20

> The fact that ravb_tx_timeout_work doesn't take any locks seems much
> more suspicious.

Indeed! But that should be a different patch, right?

Waiting a little more for feedback from renesas.

/P


