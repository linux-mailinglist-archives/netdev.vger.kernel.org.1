Return-Path: <netdev+bounces-32443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF7B797958
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795011C20B12
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1696F13AC6;
	Thu,  7 Sep 2023 17:11:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C7013AC4
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 17:11:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F18F1FD0
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694106613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7iV8N0Zs9ekoCmuMeKBQuzMuRWS57eO3gP7qT4sD/5o=;
	b=OTYOtJn/q14UjqBJxagBO0xE/NGAXeeuI6UT4AvyEFVW/nLlXPUgnwpIT6fcWEZe/j9J8a
	fvXuPangMyG2QsMLDaPYbzrJnkmwMKMG3RzqODoqN5St//BY/PtQ5HQMwBPPuFqGyGwz8Z
	OUCNMaHLO+iy+IFwktcngAQcDFjWimw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-hCNMtxjJNIuvp00sD6tg7w-1; Thu, 07 Sep 2023 05:44:50 -0400
X-MC-Unique: hCNMtxjJNIuvp00sD6tg7w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a5c5f0364dso16946366b.0
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 02:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694079889; x=1694684689;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iV8N0Zs9ekoCmuMeKBQuzMuRWS57eO3gP7qT4sD/5o=;
        b=PnL33BiHo/yrDL4O//L4KD/qMOL72PqcPGEUDJR88knh1dyV6rSKx6nssNGbmwmD5b
         PYzR8/0hFyj70cpBhUrcbRh58TsSjaf+LSrg6hM6n54j5X/4ZvAdsK53ALFtJf6b4r0b
         YVOPhKLiXUCQ/QcBcgX0rZFWc5hAvxKUFPAHUISo4VxnpL+puPZhU3rTDDi9YV31CDM0
         LcUq75rb0azq1wgmb1wD7+lUkJZfl2ReJokh7lU/YlIGCM1Nh+hKvf/2RjbxyElGUZb8
         QC+y1LL6fQVE2tN+iv+BgKr/mdb6ZgD8UtZPKSvd0pzEorYllpUX9JS9+diabd/POU3a
         L/eQ==
X-Gm-Message-State: AOJu0YwwB3GXm6RJ1aERUH3xVN8Yj5fugZEJUf2UjKqjHZC1Efk5nU+w
	CFvghMGDp8IGjikW6Fn3CYauPICKgdBFOyioXlgPADyR3YfoijSY2u6aNJVuwFq45x7twlcFdxF
	ddXo0MS4F/Qf3ZUys
X-Received: by 2002:a17:907:cca1:b0:9a6:ae76:d6ae with SMTP id up33-20020a170907cca100b009a6ae76d6aemr3715602ejc.3.1694079889068;
        Thu, 07 Sep 2023 02:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnPN4syHJKZykCDJc7KbCt9GyZHbum1qYTeTY8d2HUtrQ1128rOz00zDgwcLVUTwKZzjDO1g==
X-Received: by 2002:a17:907:cca1:b0:9a6:ae76:d6ae with SMTP id up33-20020a170907cca100b009a6ae76d6aemr3715589ejc.3.1694079888723;
        Thu, 07 Sep 2023 02:44:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-112.dyn.eolo.it. [146.241.251.112])
        by smtp.gmail.com with ESMTPSA id ja8-20020a170907988800b0099290e2c163sm10063541ejc.204.2023.09.07.02.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:44:48 -0700 (PDT)
Message-ID: <7b42e1ca549f8d7d18a4df9d74a93cf527071a4d.camel@redhat.com>
Subject: Re: [PATCH 1/3] net: ethernet: bcmasp: fix possible OOB write in
 bcmasp_netfilt_get_all_active()
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
Date: Thu, 07 Sep 2023 11:44:46 +0200
In-Reply-To: <20230906092107.19063-2-hbh25y@gmail.com>
References: <20230906092107.19063-1-hbh25y@gmail.com>
	 <20230906092107.19063-2-hbh25y@gmail.com>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-09-06 at 17:21 +0800, Hangyu Hua wrote:
> rule_locs is allocated in ethtool_get_rxnfc and the size is determined by
> rule_cnt from user space. So rule_cnt needs to be check before using
> rule_locs to avoid OOB writing or NULL pointer dereference.
>=20
> Fixes: c5d511c49587 ("net: bcmasp: Add support for wake on net filters")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/et=
hernet/broadcom/asp2/bcmasp.c
> index d63d321f3e7b..4df2ca871af8 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> @@ -535,6 +535,9 @@ void bcmasp_netfilt_get_all_active(struct bcmasp_intf=
 *intf, u32 *rule_locs,
>  	int j =3D 0, i;
> =20
>  	for (i =3D 0; i < NUM_NET_FILTERS; i++) {
> +		if (j =3D=3D *rule_cnt)
> +			break;

Side note: it's a bit unfortunate/confusing that the drivers can
arbitrary return  -EMSGSIZE or silently truncate the list. I think it
would be clearer if we could stick to single behavior - and I'll vote
for -EMSGSIZE.

Cheers,

Paolo


