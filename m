Return-Path: <netdev+bounces-254499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGZHMsqUemmC8AEAu9opvQ
	(envelope-from <netdev+bounces-254499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:59:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA2A9CCE
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C825300383F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F886344029;
	Wed, 28 Jan 2026 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pGGMZR3G"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429E33065D;
	Wed, 28 Jan 2026 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769641157; cv=none; b=reU/5Zdd28EYCXmgLRpU/H7HON87rVpeZ0CcdIUmMTh3hOg8Pp6GlxeAVatjcpoGvasx0GvExt1wtw+wbYkZWjLs1FoFWLAcmZl47Va0uCfNufsucPH/0w8Q+5JqeIBmIdANYq5L3SNPYmRI0/qtG5qdWcMEt98XrGRhwO7D7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769641157; c=relaxed/simple;
	bh=G6zdpOrHpYOo+wAmzZPsLM+pB93NgVWdEtodPism9p8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ge14vbEE/TOuh0OJFRmXncsyzp+p6q5kJnW8N+7fLpM7sWROGLp1xAy+T/v/drQdCIsARLDm8SWq6dHK4BeykzagL0tcNQluAoPFpCNadQFwxtzunmGWXC7bBPXMndjxGws4LAww9HpGlOAN2pCjvHdikCbWfOUtDGo6l/n4Ad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pGGMZR3G; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f1d4Z4hc2z9tJr;
	Wed, 28 Jan 2026 23:59:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769641150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfPWU/6INqaXgHJYGH9TyZanu63iz0zh/qr7Kle/x4Q=;
	b=pGGMZR3Gu5EX08zu8GKw7j5PhRMFZlz1vhdUDXvKGBLi5Q9mBICXeeGUZhkCZg6fKlg6NJ
	ENt8PjjDL4EbtvyChWm/qWknBGkZtM1UoyNXTYXOyTAmLEPDTfvo2KtlSHzugAt1SqgZaH
	2DwBSzn5KkSncnm70q0VAKRGI9b0U/auWqa/gStNvhwRh9WAW+5K4Kc2PRqOEzQX/XX4NW
	G4NQy5PZQppvMfI5rorQmp5QF3DNOeHnxLGQo5e4d2eqzMsXek/Uxgi1Y3A9RBz7iDOS1K
	kf/2py0mHabS8U8diWWV/hQy3/xc2rPxGvcCHFhm+wcp2LLXvGcazKB/OR3IEA==
Date: Wed, 28 Jan 2026 23:58:59 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, horms@kernel.org,
 shawnguo@kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, wahrenst@gmx.net,
 pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org,
 richardcochran@gmail.com, edumazet@google.com, andrew+netdev@lunn.ch,
 robh@kernel.org, krzk+dt@kernel.org, andrew@lunn.ch
Subject: Re: [net-next,v20,7/7] net: mtip: Extend the L2 switch driver for
 imx287 with bridge operations
Message-ID: <20260128235859.634422f1@wsk>
In-Reply-To: <20260128022600.4151612-1-kuba@kernel.org>
References: <20260126103400.1683125-8-lukasz.majewski@mailbox.org>
	<20260128022600.4151612-1-kuba@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: 2682124a76cf458dce0
X-MBO-RS-META: u9mik3pdfwu9wda13sbs1rycteokqfio
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254499-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,pengutronix.de,kernel.org,lists.linux.dev,vger.kernel.org,gmx.net,redhat.com,davemloft.net,google.com,lunn.ch];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F1CA2A9CCE
X-Rspamd-Action: no action

Hi Jakub,

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see
> https://netdev-ai.bots.linux.dev/ai-local.html ---
> net: mtip: Extend the L2 switch driver for imx287 with bridge
> operations
>=20
> This patch adds bridge operations support to the MTIP L2 switch
> driver, enabling hardware offloading for packet switching when a
> bridge is created on the switch interfaces.
>=20
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c new file mode
> > 100644 index 000000000000..f961b9cc4e6a
> > --- /dev/null
> > +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c =20
>=20
> [ ... ]
>=20
> > +static int mtip_ndev_port_link(struct net_device *ndev,
> > +			       struct net_device *br_ndev,
> > +			       struct netlink_ext_ack *extack)
> > +{
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(ndev),
> > *other_priv;
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	struct net_device *other_ndev;
> > +	int err;
> > +
> > +	/* Check if one port of MTIP switch is already bridged */
> > +	if (fep->br_members && !fep->br_offload) {
> > +		/* Get the second bridge ndev */
> > +		other_ndev =3D fep->ndev[fep->br_members - 1];
> > +		other_priv =3D netdev_priv(other_ndev);
> > +		if (other_priv->master_dev !=3D br_ndev) {
> > +			NL_SET_ERR_MSG_MOD(extack,
> > +					   "L2 offloading only
> > possible for the same bridge!");
> > +			return notifier_from_errno(-EOPNOTSUPP); =20
>                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> Should this return -EOPNOTSUPP instead of
> notifier_from_errno(-EOPNOTSUPP)? The caller mtip_netdevice_event()
> already wraps the return value with notifier_from_errno(ret), so
> double-wrapping corrupts the return value.
>=20
> Looking at similar drivers like cpsw_new.c (cpsw_netdevice_port_link),
> the pattern is to return raw errno values here and let the event
> handler do the conversion.
>=20

Yes, the call to notifier_from_errno() can be removed.

I will fix it with v21.

> > +		}
> > +
> > +		fep->br_offload =3D 1;
> > +		mtip_switch_dis_port_separation(fep);
> > +		mtip_clear_atable(fep);
> > +	}
> > +
> > +	if (!priv->master_dev)
> > +		priv->master_dev =3D br_ndev;
> > +
> > +	fep->br_members |=3D BIT(priv->portnum - 1);
> > +
> > +	err =3D switchdev_bridge_port_offload(ndev, ndev, NULL,
> > NULL, NULL,
> > +					    false, extack);
> > +	if (err) {
> > +		dev_err(&ndev->dev, "can't offload bridge port %s
> > [err: %d]\n",
> > +			ndev->name, err);
> > +		return err;
> > +	} =20
>=20
> If switchdev_bridge_port_offload() fails, the state changes made
> earlier in the function (br_offload, br_members, master_dev, and the
> hardware configuration via mtip_switch_dis_port_separation and
> mtip_clear_atable) are not rolled back.
>=20
> Looking at cpsw_new.c for reference, it modifies br_members after the
> switchdev call succeeds, avoiding the need for rollback. Could the
> state updates here be reordered to happen after
> switchdev_bridge_port_offload() returns successfully?
>=20

I will add to v21:

fep->br_members &=3D ~BIT(priv->portnum - 1);
priv->master_dev =3D NULL;

before I return err.

(This "rollback" code was missing).

> [ ... ]
>=20
> > +static int mtip_netdevice_event(struct notifier_block *unused,
> > +				unsigned long event, void *ptr)
> > +{ =20
>=20
> [ ... ]
>=20
> > +	return notifier_from_errno(ret);
> > +} =20
>=20
> [ ... ]



--=20
Best regards,

=C5=81ukasz Majewski

