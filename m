Return-Path: <netdev+bounces-19473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FBE75AD0A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65976281D09
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A13217747;
	Thu, 20 Jul 2023 11:34:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4202F3F
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 11:34:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090BA110
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689852871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INVLotxR7rulzehcHDFDyfVuMU2gu/OWtsospBFTyJ4=;
	b=LvV8mmx/RuS0XG/v8fUunPRD4Nm6O9HPMtOj2YvqYDavN/B/P/wG/bdW0NNBEUqr2V+hzi
	sC+Mqg+WTZv1kjkZH+J7JLMdoLtUhAVFCfQD42sV336yhmQ2qvCV3GtK48MlBtVCZLNBdH
	k2ibL53M+JAejf3c+tNZzZeLYAetu74=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-3gqMAGtlM96q_Cez2umYPA-1; Thu, 20 Jul 2023 07:34:30 -0400
X-MC-Unique: 3gqMAGtlM96q_Cez2umYPA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4034b144d3bso2107811cf.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689852869; x=1690457669;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INVLotxR7rulzehcHDFDyfVuMU2gu/OWtsospBFTyJ4=;
        b=ZaccLeDe007UyZ5nq04lSsnaYRyFqjI7jD/2CEAvBulJFmhlugUdo7bImeYXsOB87N
         hNXaVxPZ4qPRhzY5aXJbmjgCXq0ZOIN+xGGbdiZ8fEZHOoBsUWz3rUXtgLgA5YppYhbU
         +zHXGnAWO+6IpiobRU6Ednqex2tkJJPAOZIAy8mZrwJkSpelpIoSH8cRaStznG05W9ER
         R/O0g7Lz7OMYH0n5gmEHgiCMuQZqPV4ikSc1QXUlxiilAJsr7Mx+VOcwPuGsxWddH1xu
         tetvmu9kS4PMS3+66+yqQJv/z68GuyXKJ0TrRCqyPc7pspFKo2ik1fZz1Ypk1a22hGgC
         cHHQ==
X-Gm-Message-State: ABy/qLYg+suFKX1er6GWvvYgEQULNjtTO4oLNOHjbPRuBPv0PYb/ygpD
	cgOMEVdtKLxqut3DN42vWHGG7IujILrtUAteZusVL4M9vn80j3vuqxCes/kh8NcfR+dJEx/7C7e
	txrJYMIJxjdvQatMJ
X-Received: by 2002:ac8:7d89:0:b0:403:b4da:71ff with SMTP id c9-20020ac87d89000000b00403b4da71ffmr18498156qtd.0.1689852869551;
        Thu, 20 Jul 2023 04:34:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHEtNN1/bTL9rfEQ/BzcuEhh95dR8kDaox95dn5k/EFXJotUlw105+Hs1TNhw9ETP0ucJ7l1g==
X-Received: by 2002:ac8:7d89:0:b0:403:b4da:71ff with SMTP id c9-20020ac87d89000000b00403b4da71ffmr18498145qtd.0.1689852869267;
        Thu, 20 Jul 2023 04:34:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id ff20-20020a05622a4d9400b00403f1a7be90sm237135qtb.88.2023.07.20.04.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:34:28 -0700 (PDT)
Message-ID: <5781d16d42ae02742af5ebaaf29875a0779b2d92.camel@redhat.com>
Subject: Re: [PATCH net v2] net: phy: marvell10g: fix 88x3310 power up
From: Paolo Abeni <pabeni@redhat.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, linux@armlinux.org.uk, 
 kabel@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org
Date: Thu, 20 Jul 2023 13:34:25 +0200
In-Reply-To: <20230719092233.137844-1-jiawenwu@trustnetic.com>
References: <20230719092233.137844-1-jiawenwu@trustnetic.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-19 at 17:22 +0800, Jiawen Wu wrote:
> Clear MV_V2_PORT_CTRL_PWRDOWN bit to set power up for 88x3310 PHY,
> it sometimes does not take effect immediately. And a read of this
> register causes the bit not to clear. This will cause mv3310_reset()
> to time out, which will fail the config initialization. So add a delay
> before the next access.
>=20
> Fixes: c9cc1c815d36 ("net: phy: marvell10g: place in powersave mode at pr=
obe")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
> v1 -> v2:
> - change poll-bit-clear to time delay
> ---
>  drivers/net/phy/marvell10g.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
> index 55d9d7acc32e..d4bb90d76881 100644
> --- a/drivers/net/phy/marvell10g.c
> +++ b/drivers/net/phy/marvell10g.c
> @@ -328,6 +328,13 @@ static int mv3310_power_up(struct phy_device *phydev=
)
>  	ret =3D phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, MV_V2_PORT_CTRL,
>  				 MV_V2_PORT_CTRL_PWRDOWN);
> =20
> +	/* Sometimes, the power down bit doesn't clear immediately, and
> +	 * a read of this register causes the bit not to clear. Delay
> +	 * 100us to allow the PHY to come out of power down mode before
> +	 * the next access.
> +	 */
> +	udelay(100);

Out of sheer ignorance, would an usleep_range(...) be more appropriate
here?

Thanks!

Paolo


