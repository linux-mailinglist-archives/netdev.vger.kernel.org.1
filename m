Return-Path: <netdev+bounces-262577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJIcJxhUpWnR9AUAu9opvQ
	(envelope-from <netdev+bounces-262577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:10:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFF11D552F
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 643283015103
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275D938D009;
	Mon,  2 Mar 2026 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EZWEg5lo"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay49-hz3.antispameurope.com (mx-relay49-hz3.antispameurope.com [94.100.134.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777AB1C84A0
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442646; cv=pass; b=oLaqwHIPQ44r/X4R6Bcac9l2RfELwS8tSvotT3tLH7v3pDeW0311zcSW7QLJbCFYaiwzMCPRxLFOrTp1m97QG/OmHbrpSh+3QU4GOT8S4nme6rjdw6rHDTayvQRNGAZf0bRJJanJDRRvTFZaaRIsbB/FEXVkTGC3Lhzd7qYP8k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442646; c=relaxed/simple;
	bh=fiekTzta8FUtdjWmFwchlMc1/hwvvAsJRm4WsZfyc4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6GkRtTuChQchzGO0gPEAB+lZ2eLRDG5mj7H8kUYw+ltd7k8qbeItGpNA14QXMymCXnJBIySvQdvxRqpGKVe66dMat2A/MCLtJ7xFUKtqju05xOih37ZbRXxwlBG+uhadVyVv6jdcSL+p71VdZUO2nLBItaPX3SE0WgGSu6TUPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=EZWEg5lo; arc=pass smtp.client-ip=94.100.134.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate49-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=QcbWatSyM5oJiH06wT/NbGgAxv1T51q/29A9brK2e6w=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1772442630;
 b=B8brLB6KZFGnWoe1AgSIpI11ofVl53Ux5lkwr5cHkP4E1ktPiTR19ny4MAtHJN4iO2M+JaFX
 be+LKCJo8TaIar8qq0nGP8TkSK+YUfK/xvEv/GTr4cPOkCK9TMvk0MZx5NFAluOnOVFW8HfSQy5
 UhPKLgUajp/Lm9+0isdqnVIhzlg6k8BdYT3UQkyy5BTYEd/lkrRjTRqqQwKcs95euiSgM4bg3m+
 H122T6WecWUbAAfz7+WBQ9oT2hFePYuYBelPjdPJO4NW3opejKsTZQR58gVEielh1AC5I50f8wK
 alut4ZmkPC6Tjkr3kDp4Lnees7hKu6fC7zp6OaHkdDQfw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1772442630;
 b=ooZFvD3FMxg+MsdpcUH4t6Iy0KaAKUuZVrW9tljVbSxaNq+jpALPrpAfaufu7I3y/Qn0QuBl
 QLfyf/sD4q0mFCN2i0kvfp2irTbe1bxprFy0p/Ogb9jPzNbf17goUGcmuD/gjs4cwZRdguBUe46
 9J8Hj/EB4+pkaNU0mHC5OLJZHVY9f4xoKG+6EAwyhOZOVrpZnHDZEsIdvxUX5OrfZk4xGv2hcWr
 Kc36/fxW4n/yM7LFn+GVvdjvL7P4qhdh14eSdcJJv66j7xSzFndlZ8f+8Wwqg11sdvLdA3ALOtZ
 Fsz6mbgv7OmqNgqgHcHyZgbNlE8YF+TBe8bPhD7S/SjyA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay49-hz3.antispameurope.com;
 Mon, 02 Mar 2026 10:10:30 +0100
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 5373D220490;
	Mon,  2 Mar 2026 10:10:16 +0100 (CET)
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
Date: Mon, 02 Mar 2026 10:10:16 +0100
Message-ID: <5972322.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To:
 <PAXPR04MB8510765552BAC289BD5466DB8870A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References:
 <20251119102557.1041881-1-wei.fang@nxp.com> <7825188.GXAFRqVoOG@steina-w>
 <PAXPR04MB8510765552BAC289BD5466DB8870A@PAXPR04MB8510.eurprd04.prod.outlook.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay49-hz3.antispameurope.com with 4fPY6x0V46z3ybLB
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:4664428a919562c3da657dd102324f35
X-cloud-security:scantime:2.540
DKIM-Signature: a=rsa-sha256;
 bh=QcbWatSyM5oJiH06wT/NbGgAxv1T51q/29A9brK2e6w=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1772442630; v=1;
 b=EZWEg5loECgIu6axr30VcRlCLqRW80He/1vBOpdxMPwVr8FaxAavOpbj3SIYw2md8gugiLw3
 Mzp2zbs0Z3GIPP7mm1N/pjVTadOTDrcNkwOqc9NcjkCyRhcS8rn6mpt9WZSBh9SAB0cZJaoSEzz
 fc6RjUeErFVZkJ8cLa3JXhHYaNJGVABcGJwfJ02JMiS0UNMMHD0aSvTSU9fkDKBNVA4KJlbdOj3
 joJrnfOg6yObzcZw37Z7S5mD74ZrdCkP3kb0xozVaouP56KUDleGRVT/rCGddloJr9c0gw1I058
 N+zbW0YVQpf1xyvyviC8iDOSmd/larHdwACuOPlmDpJJw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,reject];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=hse1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262577-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,0.0.0.0:email,ew.tq-group.com:dkim,tq-group.com:url]
X-Rspamd-Queue-Id: 3CFF11D552F
X-Rspamd-Action: no action

Hi,

Am Samstag, 28. Februar 2026, 04:52:01 CET schrieb Wei Fang:
> > > +static int imx95_enetc_mdio_phyaddr_config(struct platform_device
> > > +*pdev) {
> > > +	struct netc_blk_ctrl *priv =3D platform_get_drvdata(pdev);
> > > +	struct device_node *np =3D pdev->dev.of_node;
> > > +	struct device *dev =3D &pdev->dev;
> > > +	int bus_devfn, addr, err;
> > > +	u32 phy_mask =3D 0;
> > > +
> > > +	err =3D netc_get_emdio_phy_mask(np, &phy_mask);
> > > +	if (err) {
> > > +		dev_err(dev, "Failed to get PHY address mask\n");
> > > +		return err;
> > > +	}
> > > +
> > > +	/* Update the port EMDIO PHY address through parsing phy properties.
> > > +	 * This is needed when using the port EMDIO but it's harmless when
> > > +	 * using the central EMDIO. So apply it on all cases.
> > > +	 */
> > > +	for_each_child_of_node_scoped(np, child) {
> > > +		for_each_child_of_node_scoped(child, gchild) {
> > > +			if (!of_device_is_compatible(gchild, "pci1131,e101"))
> > > +				continue;
> > > +
> > > +			bus_devfn =3D netc_of_pci_get_bus_devfn(gchild);
> > > +			if (bus_devfn < 0) {
> > > +				dev_err(dev, "Failed to get BDF number\n");
> > > +				return bus_devfn;
> > > +			}
> > > +
> > > +			addr =3D netc_get_phy_addr(gchild);
> > > +			if (addr < 0) {
> > > +				dev_err(dev, "Failed to get PHY address\n");
> > > +				return addr;
> > > +			}
> > > +
> > > +			if (phy_mask & BIT(addr)) {
> >=20
> > ... which will break here if there is an Ethernet PHY using address 0 in
> > 'netc_emdio' node.
> > See arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi node
> > ethernet-phy@0.
>=20
> AFAIU, the PHY address 0 is a special address, below is the description of
> PHYAD from IEEE 802.3 Clause 22.
>=20
> A PHY that is connected to the station management entity via the
> mechanical interface defined in 22.6 shall always respond to transactions
> addressed to PHY Address zero <00000>. A station management entity
> that is attached to multiple PHYs must have prior knowledge of the=20
> appropriate PHY Address for each PHY.
>=20
> Therefore, for most PHYs, PHY address 0 is typically used as the broadcast
> address or default response address. In designs that control multiple PHYs
> via EMDIO, it is recommended to avoid setting a specific PHY to address 0
> to prevent bus conflicts.

I know about this special meaning, but there are hardware design which do n=
ot
take this into account.

> If the PHY on your board does not use PHY address 0 as the broadcast addr=
ess
> or the default response address, then we should check the PHY address fir=
st and
> then check the phy_mask in imx95_enetc_mdio_phyaddr_config(), just the sa=
me
> as imx94_enetc_mdio_phyaddr_config().

I'm not sure if this is the right fix. What about the case where phy_mask is
supposed to be 0, because there are no PHY subnodes of netc_emdio. Instead
the PHY with address is a subnode of the enet_portX is supposed to have
netc_get_phy_addr() return 0 because that's the actual address. But with
the current flow from imx94_enetc_mdio_phyaddr_config() and your suggestion
for i.MX95 case we erroneously skip that node.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



