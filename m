Return-Path: <netdev+bounces-18505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490B9757673
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017BD281201
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 08:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364D1AD27;
	Tue, 18 Jul 2023 08:23:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244AD10EA
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 08:23:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6955FE7
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 01:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689668580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FSBtCXs/7shwlYmh01oM6RZ0wBWlZJwV+GjTL0rKho=;
	b=i2i8sMbumLJsy0RalV1Xua74PQRBPndtbQbJnbwiwgFHu7dqCj6KSa9iLGKDotdjYLxrzY
	pJNFpmg8ErPXQT9vrvkgQXSHSbyY+9MyNpxAxpdiZOtaHZ9f3dv2pS+ef1eBC3Mv3gvJBg
	KoNY+DCGSSPjY1OH2J8f6dMeYDdSa/Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-lrhxMdKfNTummM8MaQTy4A-1; Tue, 18 Jul 2023 04:22:59 -0400
X-MC-Unique: lrhxMdKfNTummM8MaQTy4A-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63c9463c116so5127246d6.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 01:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689668579; x=1690273379;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FSBtCXs/7shwlYmh01oM6RZ0wBWlZJwV+GjTL0rKho=;
        b=gzQIlw9ItWuecYyisMG/mnRlg9GgEaaGeRUF61fwWRDeYfDL8C70rwwnVrbWERnREj
         56EMI3CdhonDm/2hrIKpk4N2URoDouD+s/rNrUxoqeLfRe8R1lh/PKp23SF/gX1yvjAZ
         u1HCu2ds9TyWLufTkUVlL6pL9A+YGYscf5Bdl+yXYLiX3QXwKA4+MW4iaOHuwgsDUorT
         j+LGL+capz7Df2B85iNGD7sr7ZDt2P3q9+hEHDbSIqOjXZrZLh3PNQiHWOBTjgomaJss
         2ORe3Zee2APfaRXJhqEQpwqt4xQdyfsxmOJwemFpOztXa/W/fIJg6iOT0h/Yh53jkopr
         OP2w==
X-Gm-Message-State: ABy/qLYGwK/REFn1Pdrrj26bCh4t7tubFus04ytv/iEkIJk40OZZ7hK1
	lhwBiFfzKO8TJTpgtKhhTcoPWdD0KelBd+t8b5vlIy5N8BuP3nd14p7horHoC44CFtVrgRLGGQM
	/Eb91YoVJZ5SVq8RB
X-Received: by 2002:a05:6214:519b:b0:635:d9d0:cccf with SMTP id kl27-20020a056214519b00b00635d9d0cccfmr15771454qvb.4.1689668579033;
        Tue, 18 Jul 2023 01:22:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEZij7j3C1mhYDyzb94baDSpKg9nU5+nrmzvpoo4McgxABPHMJTyxPFbG7HBtl7+7PIim3Hxg==
X-Received: by 2002:a05:6214:519b:b0:635:d9d0:cccf with SMTP id kl27-20020a056214519b00b00635d9d0cccfmr15771439qvb.4.1689668578718;
        Tue, 18 Jul 2023 01:22:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id om32-20020a0562143da000b0063631be090csm551258qvb.125.2023.07.18.01.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 01:22:58 -0700 (PDT)
Message-ID: <78b82c086c91be61d6a15582a7dc6f52b92f1b3e.camel@redhat.com>
Subject: Re: [PATCH v9 2/2] net: ti: icssg-prueth: Add ICSSG ethernet driver
From: Paolo Abeni <pabeni@redhat.com>
To: MD Danish Anwar <danishanwar@ti.com>, Randy Dunlap
 <rdunlap@infradead.org>,  Roger Quadros <rogerq@kernel.org>, Simon Horman
 <simon.horman@corigine.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew
 Lunn <andrew@lunn.ch>, Richard Cochran <richardcochran@gmail.com>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-omap@vger.kernel.org,  linux-arm-kernel@lists.infradead.org
Date: Tue, 18 Jul 2023 10:22:53 +0200
In-Reply-To: <20230714094432.1834489-3-danishanwar@ti.com>
References: <20230714094432.1834489-1-danishanwar@ti.com>
	 <20230714094432.1834489-3-danishanwar@ti.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-07-14 at 15:14 +0530, MD Danish Anwar wrote:
> +static int prueth_netdev_init(struct prueth *prueth,
> +			      struct device_node *eth_node)
> +{
> +	int ret, num_tx_chn =3D PRUETH_MAX_TX_QUEUES;
> +	struct prueth_emac *emac;
> +	struct net_device *ndev;
> +	enum prueth_port port;
> +	enum prueth_mac mac;
> +
> +	port =3D prueth_node_port(eth_node);
> +	if (port =3D=3D PRUETH_PORT_INVALID)
> +		return -EINVAL;
> +
> +	mac =3D prueth_node_mac(eth_node);
> +	if (mac =3D=3D PRUETH_MAC_INVALID)
> +		return -EINVAL;
> +
> +	ndev =3D alloc_etherdev_mq(sizeof(*emac), num_tx_chn);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	emac =3D netdev_priv(ndev);
> +	prueth->emac[mac] =3D emac;
> +	emac->prueth =3D prueth;
> +	emac->ndev =3D ndev;
> +	emac->port_id =3D port;
> +	emac->cmd_wq =3D create_singlethread_workqueue("icssg_cmd_wq");
> +	if (!emac->cmd_wq) {
> +		ret =3D -ENOMEM;
> +		goto free_ndev;
> +	}
> +	INIT_WORK(&emac->rx_mode_work, emac_ndo_set_rx_mode_work);
> +
> +	ret =3D pruss_request_mem_region(prueth->pruss,
> +				       port =3D=3D PRUETH_PORT_MII0 ?
> +				       PRUSS_MEM_DRAM0 : PRUSS_MEM_DRAM1,
> +				       &emac->dram);
> +	if (ret) {
> +		dev_err(prueth->dev, "unable to get DRAM: %d\n", ret);
> +		ret =3D -ENOMEM;
> +		goto free_wq;
> +	}
> +
> +	emac->tx_ch_num =3D 1;
> +
> +	SET_NETDEV_DEV(ndev, prueth->dev);
> +	spin_lock_init(&emac->lock);
> +	mutex_init(&emac->cmd_lock);
> +
> +	emac->phy_node =3D of_parse_phandle(eth_node, "phy-handle", 0);
> +	if (!emac->phy_node && !of_phy_is_fixed_link(eth_node)) {
> +		dev_err(prueth->dev, "couldn't find phy-handle\n");
> +		ret =3D -ENODEV;
> +		goto free;
> +	} else if (of_phy_is_fixed_link(eth_node)) {
> +		ret =3D of_phy_register_fixed_link(eth_node);
> +		if (ret) {
> +			ret =3D dev_err_probe(prueth->dev, ret,
> +					    "failed to register fixed-link phy\n");
> +			goto free;
> +		}
> +
> +		emac->phy_node =3D eth_node;
> +	}
> +
> +	ret =3D of_get_phy_mode(eth_node, &emac->phy_if);
> +	if (ret) {
> +		dev_err(prueth->dev, "could not get phy-mode property\n");
> +		goto free;
> +	}
> +
> +	if (emac->phy_if !=3D PHY_INTERFACE_MODE_MII &&
> +	    !phy_interface_mode_is_rgmii(emac->phy_if)) {
> +		dev_err(prueth->dev, "PHY mode unsupported %s\n", phy_modes(emac->phy_=
if));
> +		ret =3D -EINVAL;
> +		goto free;
> +	}
> +
> +	/* AM65 SR2.0 has TX Internal delay always enabled by hardware
> +	 * and it is not possible to disable TX Internal delay. The below
> +	 * switch case block describes how we handle different phy modes
> +	 * based on hardware restriction.
> +	 */
> +	switch (emac->phy_if) {
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +		emac->phy_if =3D PHY_INTERFACE_MODE_RGMII_RXID;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		emac->phy_if =3D PHY_INTERFACE_MODE_RGMII;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		dev_err(prueth->dev, "RGMII mode without TX delay is not supported");
> +		return -EINVAL;

At this point ndev prueth->emac[mac] =3D=3D emac, so the caller will try to
clean it up via prueth_netdev_exit(), which in turn expects the device
being fully initialized, while this is not. Notably the napi instance
has not being registered yet.

You should 'goto free;' above and possibly move the 'ndev prueth-
>emac[mac] =3D emac' assignment at the end of this function.

Thanks!

Paolo


