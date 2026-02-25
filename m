Return-Path: <netdev+bounces-261074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH2SO7din2lRagQAu9opvQ
	(envelope-from <netdev+bounces-261074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:59:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2865419D837
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 676833049CBF
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 20:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE1D30596F;
	Wed, 25 Feb 2026 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q8xQxnpJ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB102949E0;
	Wed, 25 Feb 2026 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053086; cv=none; b=onL6KQjdDpADkXzVGRq+x1Kaiy/oasArc4yJb95xsQ+HAu5dFZNrcYdr6gGrN9dI+HEwaOi6y34C6a3CNqFuzHSUZ+JAyvOCbI5lquIlDIbk4VW8mFOrdsjwh7a7Hwy6x/S2eA2y4RdgU3pq5/9pNXu0G2/qPcMSgsEvOEQtbRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053086; c=relaxed/simple;
	bh=H50urYzbXnap5hLvoseB/+DbEKD96tJ90ypmIwQBEXQ=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bmhk6vVnVCFzd3vvBFRxZX619zFqF63C1tRXeLC64qLCtR7b9nEhiwNcnIG5u9fosaHStr6wnzsIJHNGMenTkuLiRjy3GkTdKvkzTJ/8gkFvdrBmaiQks/SmUKTBIFWePzYYxWkZPdnNyn/bml+1W7GM88hqRYmsiX+p/vBSiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q8xQxnpJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772053084; x=1803589084;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=H50urYzbXnap5hLvoseB/+DbEKD96tJ90ypmIwQBEXQ=;
  b=q8xQxnpJw3S9Ihs2MpUUZ/uI3vhR6vt72L5zECZvvvCR/oRSR5GM+Iaw
   vM5cSKeaMCivNAHza1GTY1Hnjj7ZRRuk1vtRYY37M+cEvVBqmFN/ySqMl
   VfmMH3sF4v4y41fo7yU7jVGvkcmGmZY2UqaSh2ot/s/2D+MvrA0HSpYGJ
   nYdD8sWy6mMacAdv4mqe6JrKw7rrUTym4W9GfhxlpVORumGsiEUq7DrkD
   O+WUjllMWZs4AHaCKtgevILNlc5pPsti/JERMiyVKvODXYjyJDA2WBEdd
   DQVEyyJ/w18rSDS1e4he9UHqvNp6w8sLksKMkNOrsp/SWhajKBdVqHIyJ
   g==;
X-CSE-ConnectionGUID: vWux6Oa1QzeDQFak+SqfeQ==
X-CSE-MsgGUID: 7xWDj/VjTveK2nD/ii29YA==
X-IronPort-AV: E=Sophos;i="6.21,311,1763449200"; 
   d="scan'208";a="61305409"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 13:57:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 25 Feb 2026 13:57:48 -0700
Received: from [10.205.29.19] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 25 Feb 2026 13:57:45 -0700
Message-ID: <eb0f7899f25721bf3b29475aec65018584600321.camel@microchip.com>
Subject: Re: [PATCH net-next v2] net: phy: micrel: Add support for lan9645x
 internal phy
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>,
	<o.rempel@pengutronix.de>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Date: Wed, 25 Feb 2026 21:57:35 +0100
In-Reply-To: <42918203-276e-42a9-a9da-34d43a5e6a98@lunn.ch>
References: <20260130-phy_micrel_add_support_for_lan9645x_internal_phy-v2-1-202ac31cf9c4@microchip.com>
	 <92ba22ee64b2670448295b44d663d8ae7e8fe9c4.camel@microchip.com>
	 <641d92a2-93fb-4ffe-89d8-77bf10edecf8@gmail.com>
	 <1b14f42944d21fff1cb45132fe6dc9e5c18289a1.camel@microchip.com>
	 <00f03a3f-fc12-4875-b4b5-7470e7f0452d@gmail.com>
	 <5876361bab237e2e1c73395d7e65c93279865f63.camel@microchip.com>
	 <42918203-276e-42a9-a9da-34d43a5e6a98@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[microchip.com:server fail,sin.lore.kernel.org:server fail];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261074-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,pengutronix.de,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim]
X-Rspamd-Queue-Id: 2865419D837
X-Rspamd-Action: no action

On Wed, 2026-02-25 at 14:39 +0100, Andrew Lunn wrote:
>=20
> > > > > > > +static int lan9645x_suspend(struct phy_device *phydev)
> > > > > > > +{
> > > > > > > +    int ret, val;
> > > > > > > +
> > > > > > > +    /* Force link down before software power down (SPD), by =
doing software
> > > > > > > +     * soft reset. This resets the PHY, but keeps all regist=
er configuration
> > > > > > > +     * intact. The bit self clears.
> > > > > > > +     *
> > > > > > > +     * This is needed as a workaround for an issue where per=
forming SPD on a
> > > > > > > +     * port can bring adjacent ports down, when there is tra=
ffic flowing
> > > > > > > +     * through the ports.
> > > > > > > +     */
> > > > > > > +    ret =3D phy_modify(phydev, LAN9645X_CONTROL_REGISTER,
> > > > > > > +                     LAN9645X_CONTROL_REGISTER_SOFT_RESET, 1=
);
> > > > >=20
> > > > > Any specific reason why you use a vendor-specific register here i=
nstead of BMCR
> > > > > via genphy_soft_reset()?
> > > > >=20
> > > > >=20
> > > >=20
> > > > Sorry I missed your mail. genphy_soft_reset() will do a software (h=
ard) reset via
> > > > bit 15 (BMCR_RESET). In particular it will reset the registers. We =
want to do
> > > > a software soft reset, which resets the PHY without changing regist=
er values.
> > > >=20
> > > No, BMCR_RESET usually doesn't reset configuration registers. That's =
why the
> > > function is called genphy_*soft*_reset. In case your PHY behaves diff=
erent,
> > > which configuration registers does it change?
> > >=20
> >=20
> > Ok I tought that was the usual behavior. The register spec says BMCR_RE=
SET will reset
> > the PHY and all its registers to their default state.
>=20
> Most PHYs do a soft reset when this bit is set, but some do a much
> harder reset, resetting all state including registers.
>=20
> Does the documentation say anything about
> LAN9645X_CONTROL_REGISTER_SOFT_RESET and self clearing? BMCR_RESET
> should be cleared by the PHY when the reset is
> complete. genphy_soft_reset() uses phy_poll_reset() to wait for the
> bit to clear. If you don't wait, it could be your start writing to
> registers while the reset is still happening, and those writes get
> lost. You might have the same issue here.
>=20
>       Andrew

Yes, it says the bit is self-clearing (R/W1S/SC). In the next version I
am currently setting the bit with phy_set_bits, and then poll for the bit
to clear with phy_read_poll_timeout.

Thanks,
Emil

