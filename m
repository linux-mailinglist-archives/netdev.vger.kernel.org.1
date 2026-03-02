Return-Path: <netdev+bounces-262612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Cx3CM9upWlXAgYAu9opvQ
	(envelope-from <netdev+bounces-262612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:04:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A03E1D728F
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3000304A6F8
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA8B35F5F5;
	Mon,  2 Mar 2026 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Z3E8ZKfz"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay107-hz1.antispameurope.com (mx-relay107-hz1.antispameurope.com [94.100.132.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6E015539A
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449386; cv=pass; b=GqHtR2CSKpD+MJaMAALEci5ihIs/FmvuIcUpJX9vpG5k+MsVHtw3O3WPjMiWz/BXA590J5hP4lUl7iqsSUm7fUbYf3T/zC9ZX+w1Y02ov65Xu+HHWY5BcbtNeUBiE+HNS3iP9du+BBQcrkona0lbB6YXVDwUdr69aRNhm+A3xzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449386; c=relaxed/simple;
	bh=MxiV6mapVloNChkU3ii/v4Yd/ZIgovMph1qmaLzZ1bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWQVfZIZcYqn04bndIuQntQmY7nHYfFeESiUdXOPD8xzfbhV5FZ0jea1OlKLSHyu6qe18BchIUcgrloPPd6rxBw4n04PztrwX2lHwAED6dH7sja8FH3CnfEmyX9YJC8ABaIHcJkGGtxqOwRUNTUiXY9C5OULFHzTwn37HUS24AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Z3E8ZKfz; arc=pass smtp.client-ip=94.100.132.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate107-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=9ZxrUskpYeFswvDKCa4H56tpH9cNXMNrZmlNnULEJ4Q=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1772449332;
 b=hM5/a/9nYafKl5b/aZ2B+ek2RlcBzIXThwuVsP48AdedZeZD5DiCauDr7VxtdUqLhnOz/i83
 ko+SrsCfZmXYfDDW/nCXIjRARrIX0wYs+TW8EBXvjUrzHjl1gxE4WrkSups0zJqf6zLaGWEiADa
 /0SFvIghh+ad9+nh1vfskDkn4oEOpqBmLqnin3AcbNGi6QLnsPzGAwdCFHw779F/vzNVj0YtHiu
 4WsolpthXaTJrUPlnegj2kG3g2M1VY9d6l3ISuPnEEEOzl6Cai8smdUDfqmx+2j1UlGp8ko+joX
 AI5KiC/kG9vrlVYU8j6pYHCRh1Mqi6evArYutf42eYcAQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1772449332;
 b=pxRXVlTj8asJVE2BqE8el7zJ6ZFuN/JjInKZw+0vSGae+MdPHnHZcne1wDD//YsQFqvUpApY
 8pe5ujbCDtgTnuPl5RAu3TW90uRllJLifF2evsS7MJUwHKP/zeuGG+vln47EokMJmydLmMp8Fy3
 uhne/6Ps3Zo7NYSnXJOUnGg5PTDyxqy2x3AhY5tkEtrePVaf+306rD4gEcQbny8CsSoEp7fjZ03
 2hDcEdj2ZdgOMt9FIi8MAnUgO8YZYvsIeta72LigdRJazr0qConaVIL/5W/uCNra29lnK44Aal2
 2OYAqK1fkHJQ5JdAzR6SNLwaKh0oeblCodqlUF/tzqnyw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay107-hz1.antispameurope.com;
 Mon, 02 Mar 2026 12:02:12 +0100
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id B5E77A416E0;
	Mon,  2 Mar 2026 12:01:57 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 Wei Fang <wei.fang@nxp.com>
Cc: Aziz Sellami <aziz.sellami@nxp.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH v3 net-next 1/3] net: enetc: set the external PHY address in IERB
 for port MDIO usage
Date: Mon, 02 Mar 2026 12:01:57 +0100
Message-ID: <2256661.irdbgypaU6@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To:
 <PAXPR04MB85104CDE52FE824736E44ACB887EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References:
 <20251119102557.1041881-1-wei.fang@nxp.com> <5972322.DvuYhMxLoT@steina-w>
 <PAXPR04MB85104CDE52FE824736E44ACB887EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay107-hz1.antispameurope.com with 4fPbbp36hWztb6p
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:0b20e9b68fb8ec71c1947e3bd310989b
X-cloud-security:scantime:1.650
DKIM-Signature: a=rsa-sha256;
 bh=9ZxrUskpYeFswvDKCa4H56tpH9cNXMNrZmlNnULEJ4Q=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1772449332; v=1;
 b=Z3E8ZKfzztVcS7oqV7lKIGogNBirr7M68snj1O76ONX3UOSDhAwUpih8NihV3htGeB212UDJ
 zRH2aFD7gCuNS0vyh6Dk481tz2965P5XoeF8NJhARAGenjQnACCTyRXvnNeU2lOs5qCgFaz/PMg
 EHqfjuin9cLE99hAMPdWjVbMvxBM71X3f9iqZZGscRVrGpDMYRvGBc3rGUHeLRL78IX0GN2Ivvn
 UhXwEXv9o5tWgTJP65vJGPV4QLGvkvHMJno0FXOY7amMcIVaLeEzxfeOWdQ0d3g+VkUTcA8f7L/
 JcC8iaWm1Ooce07ClnGtFSDT4Hu3o0Ukm9RhnUTLV4tJA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,reject];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=hse1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262612-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.stein@ew.tq-group.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ew.tq-group.com:dkim,tq-group.com:url]
X-Rspamd-Queue-Id: 6A03E1D728F
X-Rspamd-Action: no action

Am Montag, 2. M=E4rz 2026, 10:24:14 CET schrieb Wei Fang:
> > Am Samstag, 28. Februar 2026, 04:52:01 CET schrieb Wei Fang:
> > > > > +static int imx95_enetc_mdio_phyaddr_config(struct platform_device
> > > > > +*pdev) {
> > > > > +	struct netc_blk_ctrl *priv =3D platform_get_drvdata(pdev);
> > > > > +	struct device_node *np =3D pdev->dev.of_node;
> > > > > +	struct device *dev =3D &pdev->dev;
> > > > > +	int bus_devfn, addr, err;
> > > > > +	u32 phy_mask =3D 0;
> > > > > +
> > > > > +	err =3D netc_get_emdio_phy_mask(np, &phy_mask);
> > > > > +	if (err) {
> > > > > +		dev_err(dev, "Failed to get PHY address mask\n");
> > > > > +		return err;
> > > > > +	}
> > > > > +
> > > > > +	/* Update the port EMDIO PHY address through parsing phy
> > properties.
> > > > > +	 * This is needed when using the port EMDIO but it's harmless w=
hen
> > > > > +	 * using the central EMDIO. So apply it on all cases.
> > > > > +	 */
> > > > > +	for_each_child_of_node_scoped(np, child) {
> > > > > +		for_each_child_of_node_scoped(child, gchild) {
> > > > > +			if (!of_device_is_compatible(gchild, "pci1131,e101"))
> > > > > +				continue;
> > > > > +
> > > > > +			bus_devfn =3D netc_of_pci_get_bus_devfn(gchild);
> > > > > +			if (bus_devfn < 0) {
> > > > > +				dev_err(dev, "Failed to get BDF number\n");
> > > > > +				return bus_devfn;
> > > > > +			}
> > > > > +
> > > > > +			addr =3D netc_get_phy_addr(gchild);
> > > > > +			if (addr < 0) {
> > > > > +				dev_err(dev, "Failed to get PHY address\n");
> > > > > +				return addr;
> > > > > +			}
> > > > > +
> > > > > +			if (phy_mask & BIT(addr)) {
> > > >
> > > > ... which will break here if there is an Ethernet PHY using address=
 0 in
> > > > 'netc_emdio' node.
> > > > See arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi node
> > > > ethernet-phy@0.
> > >
> > > AFAIU, the PHY address 0 is a special address, below is the descripti=
on of
> > > PHYAD from IEEE 802.3 Clause 22.
> > >
> > > A PHY that is connected to the station management entity via the
> > > mechanical interface defined in 22.6 shall always respond to transact=
ions
> > > addressed to PHY Address zero <00000>. A station management entity
> > > that is attached to multiple PHYs must have prior knowledge of the
> > > appropriate PHY Address for each PHY.
> > >
> > > Therefore, for most PHYs, PHY address 0 is typically used as the broa=
dcast
> > > address or default response address. In designs that control multiple=
 PHYs
> > > via EMDIO, it is recommended to avoid setting a specific PHY to addre=
ss 0
> > > to prevent bus conflicts.
> >=20
> > I know about this special meaning, but there are hardware design which =
do not
> > take this into account.
>=20
> This might cause potential issues, as all PHYs attached to the same MDIO =
bus will
> respond to the accesses to PHY address 0.

Is that really the case? So far we didn't have any problems with
PHYAD 0 and 3 on the same bus. I did a bit of research but couldn't find any
information backing that PHYAD 0 is actually a broadcast address. All I cou=
ld
find is the case with just a single PHY on a MDIO bus, defaulting to 0.

> Is this problem unfixable?

Right now our problem is that the software doesn't work any more.

> >=20
> > > If the PHY on your board does not use PHY address 0 as the broadcast =
address
> > > or the default response address, then we should check the PHY address=
 first
> > and
> > > then check the phy_mask in imx95_enetc_mdio_phyaddr_config(), just the
> > same
> > > as imx94_enetc_mdio_phyaddr_config().
> >=20
> > I'm not sure if this is the right fix. What about the case where phy_ma=
sk is
> > supposed to be 0, because there are no PHY subnodes of netc_emdio. Inst=
ead
> > the PHY with address is a subnode of the enet_portX is supposed to have
> > netc_get_phy_addr() return 0 because that's the actual address. But with
> > the current flow from imx94_enetc_mdio_phyaddr_config() and your sugges=
tion
> > for i.MX95 case we erroneously skip that node.
> >=20
>=20
> The hardware default value is 0, so no need to configure it. I can send a
> fix patch this week.

Okay, thanks.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



