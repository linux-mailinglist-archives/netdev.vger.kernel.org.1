Return-Path: <netdev+bounces-254471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB21GZuCemnx7AEAu9opvQ
	(envelope-from <netdev+bounces-254471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:41:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03117A92B3
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4468530065F5
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0768337689;
	Wed, 28 Jan 2026 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JLCusINL"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FFF32FA37;
	Wed, 28 Jan 2026 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636504; cv=none; b=gKxmsZn2eyNWPo66jhXtCfkrBGmhg/T162IJ0C5TvXfn5tbF2y2a57a1+kLkEq70QKDqd6kSoCfDHMU7/H3SwVOmH6eNpwsXGh1R8wnVcoblVheVGv1eqbo0nSExJ17BrZquPUVc4KTJ95mPMkdRiDE7Zwj3iRTIwFnW2BObR9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636504; c=relaxed/simple;
	bh=hoImD/dtQZQ1KTNyWAO0c7LqLNeONtsEuNoErTU7X+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/WXel754ydH423ZWIMvRYVwMqEwMp8TJLFiDUUfkO6DcWfgDqJWa6BzgGeEoj6S5OKT/ft38tqPXGefGBcbsm4jNjZbymweFfMUGiys5KOMGOswISyuEa0vyN75WeRNKnqJbINsOryxk2lw6HH+yoJ7YDvciJDQ3+lyyKbCscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JLCusINL; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f1bM53WPdz9tcL;
	Wed, 28 Jan 2026 22:41:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769636497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDIB0vB7AhOs2BLhO1BR5gGspK/qucCwKMUy1zrKhRM=;
	b=JLCusINLF0xMJU0r42tPdKk3vsQCkFdrzletJCjCw88aVglZm7fCelyDbJNyWwSXm0xmiU
	N7vtrt+wh7EV1bAGip9RrOtpBdUNXHmya3efrhFTZnGAPq92HUOOD4mM4m+J+LdF3WaYb+
	NwlNoYrsTArjSvA9IqjoETarX9+XIixExQsxfJ9UMrCHckrs1h4i/8BhSvUxyvu/7C/b7v
	734N5c4nm6ZexUE0JXKjKzPwL7TS4TwMGk7XTZ8BTTmf3RETmpf027xO+Jm8aR6J2KcOJr
	7OnXoa+72psSiZ2mEroGSjuCxAI/eJDooclLpOehAj5jIqYfmmQeD6UGeZ6u0g==
Date: Wed, 28 Jan 2026 22:41:25 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, horms@kernel.org,
 shawnguo@kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, wahrenst@gmx.net,
 pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org,
 richardcochran@gmail.com, edumazet@google.com, andrew+netdev@lunn.ch,
 robh@kernel.org, krzk+dt@kernel.org, andrew@lunn.ch
Subject: Re: [net-next,v20,2/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20260128224125.246bcf41@wsk>
In-Reply-To: <20260128022549.4151341-1-kuba@kernel.org>
References: <20260126103400.1683125-3-lukasz.majewski@mailbox.org>
	<20260128022549.4151341-1-kuba@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: aaf4d6ce372ae19696f
X-MBO-RS-META: obpg57tttc6kknksryg9wmtuwgikhh91
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254471-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,pengutronix.de,kernel.org,lists.linux.dev,vger.kernel.org,gmx.net,redhat.com,davemloft.net,google.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03117A92B3
X-Rspamd-Action: no action

Hi Jakub,

> This is an AI-generated review

AI is going to take the "Maintainer's" job :D

> of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see
> https://netdev-ai.bots.linux.dev/ai-local.html ---
> net: mtip: The L2 switch driver for imx287
>=20
> This patch adds support for the More Than IP L2 switch embedded in the
> imx287 SoC. It creates a two-port switch driver that can be used
> interchangeably with the FEC driver.
>=20
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c new file mode
> > 100644 index 000000000000..03c5163d6508
> > --- /dev/null
> > +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c =20
>=20
> [ ... ]
>=20
> > +static void mtip_netif_stop_queues(struct switch_enet_private *fep)
> > +{
> > +	for (int i =3D 0; i < SWITCH_EPORT_NUMBER; i++)
> > +		netif_stop_queue(fep->ndev[0]); =20
>                                       ^^^
>=20
> Should this be fep->ndev[i] instead of fep->ndev[0]? The loop iterates
> with variable i but always uses index 0, so port 1's queue is never
> stopped.

Ech.... I will fix it.

>=20
> > +}
> > +
> > +static void mtip_netif_wake_queues(struct switch_enet_private *fep)
> > +{
> > +	for (int i =3D 0; i < SWITCH_EPORT_NUMBER; i++)
> > +		netif_wake_queue(fep->ndev[0]); =20
>                                       ^^^
>=20
> Same here - should this be fep->ndev[i]?
>=20

The same here.

> > +} =20
>=20
> [ ... ]
>=20
> > +static int mtip_mii_probe(struct net_device *dev)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct phy_device *phy_dev =3D NULL;
> > +	int port_idx =3D priv->portnum - 1;
> > +
> > +	if (fep->phy_np[port_idx]) {
> > +		phy_dev =3D of_phy_connect(dev,
> > fep->phy_np[port_idx],
> > +					 &mtip_adjust_link, 0,
> > +
> > fep->phy_interface[port_idx]);
> > +		if (!phy_dev) {
> > +			netdev_err(dev, "Unable to connect to
> > phy\n");
> > +			return -ENODEV;
> > +		}
> > +	}
> > +
> > +	phy_set_max_speed(phy_dev, 100); =20
>                           ^^^^^^^
>=20
> If fep->phy_np[port_idx] is NULL (no phy-handle in DT for this port),
> the if block is skipped and phy_dev remains NULL. Can this cause a
> NULL pointer dereference in phy_set_max_speed()?

No. The mtip_mii_probe() is only called in mtip_open(), which is called
only when netdevice's DT node is correctly parsed in the
mtip_sw_probe().

>=20
> > +	fep->phy_dev[port_idx] =3D phy_dev; =20
>=20
> [ ... ]
>=20
> > +static int mtip_parse_of(struct switch_enet_private *fep,
> > +			 struct device_node *np)
> > +{
> > +	struct device_node *p;
> > +	unsigned int port_num;
> > +	int ret =3D 0;
> > +
> > +	p =3D of_get_child_by_name(np, "ethernet-ports");
> > +
> > +	for_each_available_child_of_node_scoped(p, port) {
> > +		if (of_property_read_u32(port, "reg", &port_num))
> > +			continue;
> > +
> > +		if (port_num > SWITCH_EPORT_NUMBER) { =20
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> This only validates the upper bound. If the device tree contains
> reg =3D <0>, would fep->mac[port_num - 1] access fep->mac[-1]? Perhaps
> the check should also verify port_num is at least 1?
>=20

In the:
./Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml

one can have only ethernet-ports set to [12].

In the current tree - some switches start numbering from 0, other from
1.

I would opt for keeping things as they are now...

> > +			dev_err(&fep->pdev->dev,
> > +				"%s: The switch supports up to %d
> > ports!\n",
> > +				__func__, SWITCH_EPORT_NUMBER);
> > +			goto of_get_err;
> > +		}
> > +
> > +		fep->n_ports =3D port_num;
> > +		ret =3D of_get_mac_address(port, &fep->mac[port_num
> > - 1][0]); =20
>=20
> [ ... ]
>=20
> > +	ret =3D mtip_mii_init(fep, pdev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "%s: Cannot init phy bus
> > (%d)!\n", __func__,
> > +			ret);
> > +		goto dma_free_coherent_memory;
> > +	}
> > +
> > +	ret =3D mtip_ndev_init(fep, pdev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "%s: Failed to create virtual
> > ndev (%d)\n",
> > +			__func__, ret);
> > +		goto mdiobus_free_memory;
> > +	} =20
>=20
> [ ... ]
>=20
> > + mdiobus_free_memory:
> > +	mdiobus_free(fep->mii_bus); =20
>=20
> mtip_mii_init() calls of_mdiobus_register() which registers the bus.
> Should mdiobus_unregister() be called here before mdiobus_free()?
> Compare with mtip_mii_remove() which does call mdiobus_unregister().
>=20

+1

The mdiobus_unregister() is missing.

I will add it.

> > + dma_free_coherent_memory:
> > +	dma_free_coherent(&fep->pdev->dev, PAGE_SIZE,
> > fep->rx_bd_base,
> > +			  fep->bd_dma);
> > +	fep->rx_bd_base =3D NULL;
> > +	fep->tx_bd_base =3D NULL;
> > +
> > +	return ret;
> > +}
> > +
> > +static void mtip_sw_remove(struct platform_device *pdev)
> > +{
> > +	struct switch_enet_private *fep =3D
> > platform_get_drvdata(pdev); +
> > +	mtip_ndev_cleanup(fep);
> > +
> > +	mtip_mii_remove(fep);
> > +
> > +	timer_delete_sync(&fep->timer_mgnt);
> > +	platform_set_drvdata(pdev, NULL);
> > +} =20
>=20
> mtip_sw_probe() allocates DMA memory with dma_alloc_coherent() in
> mtip_switch_dma_init(), but mtip_sw_remove() does not appear to free
> it. Is this a memory leak on driver removal?

Yes. The dma_free_coherent() is missing.

I will add it for v21.

--=20
Best regards,

=C5=81ukasz Majewski

