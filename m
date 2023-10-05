Return-Path: <netdev+bounces-38245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0017B9D86
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 527DA281FAB
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CADE26296;
	Thu,  5 Oct 2023 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLtz3Nve"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4824205
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:49:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F7B173F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696513744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WUFBDdELdueKekAKn28l3cuGTc8E2A1Wmz1k6PVvTYE=;
	b=GLtz3NveczNXfWJmppSqREfEVh/YQrb1XzrNMH73Eps4XRx5x+GO7C4ThFfE9IMohsGY4u
	pMjOIRML+OLY9+O/ApFFyn7x6AipuxBWV2w+rgzhv1TpiGjHTNOCHNfnrMZ3QlgfbfSTlw
	vQvyLyO1lpeQGzuWw9sMXiBYC5HGfY0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-VLU08dvLOmyRF0YHrb5MOw-1; Thu, 05 Oct 2023 09:48:52 -0400
X-MC-Unique: VLU08dvLOmyRF0YHrb5MOw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7742bd869e4so17527185a.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 06:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696513732; x=1697118532;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUFBDdELdueKekAKn28l3cuGTc8E2A1Wmz1k6PVvTYE=;
        b=XhtVWUZnjd24fjoLrllLvMMiO/VbGjYSAsbV+MYbadlb+ID/wlMpMZwlJrrQFZf12C
         E80N3IVD1NvuN3r7lE6vv0lhGAbssIF//0txnUYphqtJCMfnc6Z4w5fk5piomgZ1FMYq
         kaFzW/wKDfkMIRzcaTbrdMZPnh3/KQcaEcX5l28wHxmBZuh1Omrmd6uYo5q1lnOfVpah
         jr6JJfTTfDKifc94a4yw9F9PGKINklgu27bYmk6wq3hrSwMqqkjCd/7KjUZFGPs/WGE4
         TWd+dSjVb/4Rp5FDuRXZCVKtSwpO3g4hdHjjkifpa1yDVJyNysbQRovJytCi4LZUfTrH
         HH0g==
X-Gm-Message-State: AOJu0YxoTwM4CwhBWzeZCzeAoB7ETkL3toxarBdC/Po0LxUp5x9NcT+1
	nz7ZFQc05r+IzBT19GZBFQW+5pyJgJARe/LPxKfdCyLiBmsXVuG4NOp4gJ49fTY8JZ192tBsEA8
	NlGz9LhW0vcQz2xpm
X-Received: by 2002:a05:620a:2915:b0:775:7520:5214 with SMTP id m21-20020a05620a291500b0077575205214mr5945537qkp.0.1696513732193;
        Thu, 05 Oct 2023 06:48:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2wtaXq1pHzz6hwXZa4E2xm2NacBrWxiRKjpHT50618ghR5jmmr+RqCR72p5u/LAer+oWUdA==
X-Received: by 2002:a05:620a:2915:b0:775:7520:5214 with SMTP id m21-20020a05620a291500b0077575205214mr5945510qkp.0.1696513731890;
        Thu, 05 Oct 2023 06:48:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-9.dyn.eolo.it. [146.241.225.9])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a031100b00767177a5bebsm490081qkm.56.2023.10.05.06.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:48:51 -0700 (PDT)
Message-ID: <97f3ac0d8b49305390ed799c1965fd665b755e77.camel@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 2/2] ice: Refactor finding
 advertised link speed
From: Paolo Abeni <pabeni@redhat.com>
To: Pawel Chmielewski <pawel.chmielewski@intel.com>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, aelior@marvell.com, manishc@marvell.com, 
 vladimir.oltean@nxp.com, jdamato@fastly.com, edumazet@google.com, 
 intel-wired-lan@lists.osuosl.org, Paul Greenwalt
 <paul.greenwalt@intel.com>,  horms@kernel.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 kuba@kernel.org, d-tatianin@yandex-team.ru,  davem@davemloft.net
Date: Thu, 05 Oct 2023 15:48:47 +0200
In-Reply-To: <20231002144412.1755194-3-pawel.chmielewski@intel.com>
References: <20231002144412.1755194-1-pawel.chmielewski@intel.com>
	 <20231002144412.1755194-3-pawel.chmielewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-10-02 at 16:44 +0200, Pawel Chmielewski wrote:
> Refactor ice_get_link_ksettings to using forced speed to link modes mappi=
ng.
>=20
> Suggested-by : Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |   1 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 200 +++++++++++++------
>  drivers/net/ethernet/intel/ice/ice_main.c    |   2 +
>  3 files changed, 138 insertions(+), 65 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/=
intel/ice/ice.h
> index fcaa5c3b8ec0..988b177d9388 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -960,6 +960,7 @@ int ice_stop(struct net_device *netdev);
>  void ice_service_task_schedule(struct ice_pf *pf);
>  int ice_load(struct ice_pf *pf);
>  void ice_unload(struct ice_pf *pf);
> +void ice_adv_lnk_speed_maps_init(void);
> =20
>  /**
>   * ice_set_rdma_cap - enable RDMA support
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/e=
thernet/intel/ice/ice_ethtool.c
> index d3cb08e66dcb..b027788c42f6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -345,6 +345,86 @@ static const struct ice_priv_flag ice_gstrings_priv_=
flags[] =3D {
> =20
>  #define ICE_PRIV_FLAG_ARRAY_SIZE	ARRAY_SIZE(ice_gstrings_priv_flags)
> =20
> +static const u32 ice_adv_lnk_speed_100[] __initconst =3D {
> +	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_1000[] __initconst =3D {
> +	ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
> +	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_2500[] __initconst =3D {
> +	ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_2500baseX_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_5000[] __initconst =3D {
> +	ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_10000[] __initconst =3D {
> +	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
> +	ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
> +	ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_25000[] __initconst =3D {
> +	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
> +	ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
> +	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_40000[] __initconst =3D {
> +	ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_50000[] __initconst =3D {
> +	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
> +	ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
> +	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_100000[] __initconst =3D {
> +	ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT,
> +};
> +
> +#define ICE_ADV_LNK_SPEED_MAP(value)					\
> +{									\
> +	.speed		=3D SPEED_##value,				\
> +	.cap_arr	=3D ice_adv_lnk_speed_##value,			\
> +	.arr_size	=3D ARRAY_SIZE(ice_adv_lnk_speed_##value),	\
> +}

I think it could make sense move even the above macro definition to the
common APIs (adding a 'prefix' argument).

Cheers,

Paolo


