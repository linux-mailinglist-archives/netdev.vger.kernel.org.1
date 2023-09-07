Return-Path: <netdev+bounces-32436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A8479792C
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831701C20B94
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C448A134D6;
	Thu,  7 Sep 2023 17:04:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE821079A
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 17:04:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52C01FF5
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 10:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694106200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55eaXlRBQUU9N09Mwpc7awwH+wml0BVgfM2qq1emsMU=;
	b=i48sWhYwaMwOkKQjWh5Zt/N2+7w4exvKH3E5JvGXMVEEfra0hUC7ghbj9qAtE7VnI9vmFN
	TAaNh8UIEnwwDbj51e2FWrXKpPdkx4RIE9RW9XIR+yu2p4S9qptA75kkKTQKEdybXwzQ44
	6f4qYG3dD2gXAvuO7d1aXSrVWvNccUo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-BAkAMxv5MeeDNlQP8rwYWA-1; Thu, 07 Sep 2023 05:33:28 -0400
X-MC-Unique: BAkAMxv5MeeDNlQP8rwYWA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-52c0134dfcdso126714a12.1
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 02:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694079207; x=1694684007;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55eaXlRBQUU9N09Mwpc7awwH+wml0BVgfM2qq1emsMU=;
        b=K9Erxg64U8ehuV7jg9CO/v2Ef/+K2k2/gwZaVOJiNep4wSzcfqE5u3BimoMBMbOoYF
         MmsqM/3XsfewI06pFLfx3w3xu+c1tGQ/cINzKyfmkBpFTuD8NaP4/h1U6+fmE/7FLYM/
         XEtGHu6wFEBK1UwnWc0yCkBZ5tBvraC7iCG9obMY2Q5ZzHIWQvxXrdvrtsQyYRvw/67n
         it5jEaxWBd33OYndWMwSDZMp72E8HMtMRP4p6upe7Furx8nO9mpe2mWw3XzRHV2GjEZt
         o4xsYQvnVjo9RrluzaeVE0Y+lUXyGZ2sE/eOaDTuNNvbFDtWAXz/KfbGxkJf4CRP7pkn
         er8A==
X-Gm-Message-State: AOJu0YwT6KqRn2xxj0KoqTIuwTTj580iKmNgPyFDOxIgNwpBBLQ8USOa
	Ry4Mp9AMJkKzlalbbASElnKrZAh1QaP4aDkZAmntzeOcOs0adY/+b8Cl4rMMnt5apBMpc7N3n5l
	M8OXOf4vs6Yva9/To
X-Received: by 2002:a05:6402:50cf:b0:523:f69:9a0d with SMTP id h15-20020a05640250cf00b005230f699a0dmr14508633edb.4.1694079207002;
        Thu, 07 Sep 2023 02:33:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmARKuVvbeJv/K5MH7+O9TdP72ANin2DJmSer2ZNOOqrgJvqT72yBewQCDz9oi34ZcnnXSiw==
X-Received: by 2002:a05:6402:50cf:b0:523:f69:9a0d with SMTP id h15-20020a05640250cf00b005230f699a0dmr14508619edb.4.1694079206712;
        Thu, 07 Sep 2023 02:33:26 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-112.dyn.eolo.it. [146.241.251.112])
        by smtp.gmail.com with ESMTPSA id k7-20020aa7c387000000b0052a19a75372sm9425264edq.90.2023.09.07.02.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:33:26 -0700 (PDT)
Message-ID: <5c3360711cbfa8503402ed2e3c02b5b24a0f405f.camel@redhat.com>
Subject: Re: [PATCH 3/3] net: ethernet: mtk_eth_soc: fix possible NULL
 pointer dereference in mtk_hwlro_get_fdir_all()
From: Paolo Abeni <pabeni@redhat.com>
To: Hangyu Hua <hbh25y@gmail.com>, justin.chen@broadcom.com, 
	florian.fainelli@broadcom.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, mw@semihalf.com, linux@armlinux.org.uk, nbd@nbd.name, 
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, 
	lorenzo@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, maxime.chevallier@bootlin.com, 
	nelson.chang@mediatek.com
Cc: bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Date: Thu, 07 Sep 2023 11:33:24 +0200
In-Reply-To: <20230906092107.19063-4-hbh25y@gmail.com>
References: <20230906092107.19063-1-hbh25y@gmail.com>
	 <20230906092107.19063-4-hbh25y@gmail.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-09-06 at 17:21 +0800, Hangyu Hua wrote:
> rule_locs is allocated in ethtool_get_rxnfc and the size is determined by
> rule_cnt from user space. So rule_cnt needs to be check before using
> rule_locs to avoid NULL pointer dereference.
>=20
> Fixes: 7aab747e5563 ("net: ethernet: mediatek: add ethtool functions to c=
onfigure RX flows of HW LRO")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/et=
hernet/mediatek/mtk_eth_soc.c
> index 6ad42e3b488f..d91fc0483c50 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -2994,6 +2994,10 @@ static int mtk_hwlro_get_fdir_all(struct net_devic=
e *dev,
>  	int i;
> =20
>  	for (i =3D 0; i < MTK_MAX_LRO_IP_CNT; i++) {
> +		if (cnt =3D=3D cmd->rule_cnt) {
> +			return -EMSGSIZE;
> +		}

Please drop the brackets above, they are not needed.

Thanks!

Paolo


