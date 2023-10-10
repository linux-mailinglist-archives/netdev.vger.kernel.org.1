Return-Path: <netdev+bounces-39473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4737BF684
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC2C1C209DD
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B190515AC0;
	Tue, 10 Oct 2023 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdC/ZjDj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC873EAFF
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 08:52:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C48CB6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 01:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696927965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zPj0g6Vaate3jqlI96SL0ywn8QU5YzWaOmRAVL6wEU=;
	b=cdC/ZjDj12JlWMxcIlZXT+k62My1GUpEi2X/wxGXjF0UmJmIeABFeZOTXtrmUhGkYC25qK
	zs5rxnrecjvwrF/XZh4ebJo8rfiat/iAk9Aa1TqtsKlrHsgvNT5TClkb4FpR64K0DuW8Wo
	XqFUoOrkwDL5+h8OYPyOgttY/X2Vjfo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-1KRS0Dm3NMeXASRz_V9SkQ-1; Tue, 10 Oct 2023 04:52:44 -0400
X-MC-Unique: 1KRS0Dm3NMeXASRz_V9SkQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b295d163fdso120377766b.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 01:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696927962; x=1697532762;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9zPj0g6Vaate3jqlI96SL0ywn8QU5YzWaOmRAVL6wEU=;
        b=Q1okywNs5kqJlSi/BodCGholO5TMSxrYCCSO/+B9FQtQIc4XPkDDVz/7LMpOmcAUJp
         e4uTFwpiO1RVnjZYgHWoNNO1F3bi5yNtOIvkZWuJ+EeJc9qdp8tbj/v8L/ThlByWPV17
         y66JS/KPqrPuohyMFnhLTxtUzzudxAaQb30jgqgpphZk/Ttkqa1tf9PtV1mNWFN0OXsy
         /ubD1WrXg6rHEpv2Ve3YEgPIQh9gtg9w1rkeD4T8HZNi7MVOdrm6NFHkWVXixI2eZ/fy
         5+cwcqKHgWK1Zx3aim1BfVylDrQZ2N13vifcoYy8EjMX9xrLTH6i5VauOCxDFN0A6Flj
         0ESg==
X-Gm-Message-State: AOJu0YwhGPsQzs501ecCNN6xqgnEQmFK1CvD+6ZOOt5Nj1TT8j1/hqbN
	2rei3zANmmkO1ZKqfT/3KfOBE5LpF/UPIHJ0kEF5U416yZU7ewJkS3sIrH6t3qXBjzTUGMLlTXM
	mI9RjYXq/qtyIeurLZfCzHVc4
X-Received: by 2002:a17:906:2254:b0:9b2:bf2d:6b65 with SMTP id 20-20020a170906225400b009b2bf2d6b65mr15782138ejr.4.1696927962661;
        Tue, 10 Oct 2023 01:52:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuTY/u+N1RHYFKhL4QfFQTtV+1ZTqkceTQY6tRz4tuiuETw8zkuOWK7bpSUJ7/D1yYFz98+g==
X-Received: by 2002:a17:906:2254:b0:9b2:bf2d:6b65 with SMTP id 20-20020a170906225400b009b2bf2d6b65mr15782127ejr.4.1696927962280;
        Tue, 10 Oct 2023 01:52:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id c12-20020a170906694c00b009b8a4f9f20esm8080833ejs.102.2023.10.10.01.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 01:52:41 -0700 (PDT)
Message-ID: <c1ef9288a88a6354292fa04dc713a5d5cd2d6936.camel@redhat.com>
Subject: Re: [PATCH] net/mlx5e: Again mutually exclude RX-FCS and
 RX-port-timestamp
From: Paolo Abeni <pabeni@redhat.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>, Will Mortensen
 <will@extrahop.com>,  netdev@vger.kernel.org
Cc: Charlotte Tan <charlotte@extrahop.com>, Adham Faris <afaris@nvidia.com>,
  Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Moshe
 Shemesh <moshe@nvidia.com>,  Saeed Mahameed <saeedm@nvidia.com>
Date: Tue, 10 Oct 2023 10:52:40 +0200
In-Reply-To: <59bdf96f-0ff4-40da-a2ac-7d12aedeb98a@gmail.com>
References: <20231006053706.514618-1-will@extrahop.com>
	 <59bdf96f-0ff4-40da-a2ac-7d12aedeb98a@gmail.com>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-10-10 at 09:31 +0300, Tariq Toukan wrote:
>=20
> On 06/10/2023 8:37, Will Mortensen wrote:
> > Commit 1e66220948df8 ("net/mlx5e: Update rx ring hw mtu upon each rx-fc=
s
> > flag change") seems to have accidentally inverted the logic added in
> > commit 0bc73ad46a76 ("net/mlx5e: Mutually exclude RX-FCS and
> > RX-port-timestamp").
> >=20
> > The impact of this is a little unclear since it seems the FCS scattered
> > with RX-FCS is (usually?) correct regardless.
> >=20
>=20
> Thanks for your patch.
>=20
> > Fixes: 1e66220948df8 ("net/mlx5e: Update rx ring hw mtu upon each rx-fc=
s flag change")
> > Tested-by: Charlotte Tan <charlotte@extrahop.com>
> > Reviewed-by: Charlotte Tan <charlotte@extrahop.com>
> > Cc: Adham Faris <afaris@nvidia.com>
> > Cc: Aya Levin <ayal@nvidia.com>
> > Cc: Tariq Toukan <tariqt@nvidia.com>
> > Cc: Moshe Shemesh <moshe@nvidia.com>
> > Cc: Saeed Mahameed <saeedm@nvidia.com>
> > Signed-off-by: Will Mortensen <will@extrahop.com>
> > ---
> > For what it's worth, regardless of this change the PCMR register behave=
s
> > unexpectedly in our testing on NICs where rx_ts_over_crc_cap is 1 (i.e.
> > where rx_ts_over_crc is supported), such as ConnectX-7 running firmware
> > 28.37.1014. For example, fcs_chk is always 0, and rx_ts_over_crc can
> > never be set to 1 after being set to 0. On ConnectX-5, where
> > rx_ts_over_crc_cap is 0, fcs_chk behaves as expected.
> >=20
> > We'll probably be opening a support case about that after we test more,
> > but I mention it here because it makes FCS-related testing confusing.
> >=20
>=20
> Please open the case and we'll analyze.
>=20
> >   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/driver=
s/net/ethernet/mellanox/mlx5/core/en_main.c
> > index a2ae791538ed..acb40770cf0c 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > @@ -3952,13 +3952,14 @@ static int set_feature_rx_fcs(struct net_device=
 *netdev, bool enable)
> >   	struct mlx5e_channels *chs =3D &priv->channels;
> >   	struct mlx5e_params new_params;
> >   	int err;
> > +	bool rx_ts_over_crc =3D !enable;
>=20
> nit:  Please maintain the reserved Christmas tree.
>=20
> >  =20
> >   	mutex_lock(&priv->state_lock);
> >  =20
> >   	new_params =3D chs->params;
> >   	new_params.scatter_fcs_en =3D enable;
> >   	err =3D mlx5e_safe_switch_params(priv, &new_params, mlx5e_set_rx_por=
t_ts_wrap,
> > -				       &new_params.scatter_fcs_en, true);
> > +				       &rx_ts_over_crc, true);
> >   	mutex_unlock(&priv->state_lock);
> >   	return err;
> >   }
>=20
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

@Tariq: do you prefer we will take this patch directly, or do you
prefer send it with a later PR?

Thanks,

Paolo


