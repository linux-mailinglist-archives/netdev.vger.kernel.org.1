Return-Path: <netdev+bounces-253750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELMSB0F8eGkFqQEAu9opvQ
	(envelope-from <netdev+bounces-253750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:50:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B6E9146C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71E803014130
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E582D1911;
	Tue, 27 Jan 2026 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jhIzS0FU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CD0149C6F;
	Tue, 27 Jan 2026 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503800; cv=none; b=DxJIjjFzRs4QebY1oQl6CK42jChjDVRPcKvS24HnkUaWw+/cOHgjsukUQKtimE0gA0LQ1p48WzNrm5oJc52x96TxPra7kLG9DPigqIRKe468GGHlorrgjyJ112cuPeeyy+9G30cBkIGo8cx+SG0EopUNWvJo2LhOgGfxZ/v5Tzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503800; c=relaxed/simple;
	bh=GXXhXfx/C4wAZHwzF3Ki6w5xYdo19ZqCCXvh9qHNeYA=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XP0zkrS+WfqP1P6GlfMByxsldYA2zjeYiy4EC04Lc/BIhtTixxCU9JMl7JGAUe7Zfnlm4nqRraCPnkFJfdYISVekgjM++UlW9+l4RsANRfr/wMD59fsADq83uDS+15/wgxtKjBN2RdrVWMSMYrLCdJ3GANzliuGS5zK20hFp5ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jhIzS0FU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1769503796; x=1801039796;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GXXhXfx/C4wAZHwzF3Ki6w5xYdo19ZqCCXvh9qHNeYA=;
  b=jhIzS0FUGpfjnT0kimH6jTUENpMG5HqOSyRpyUGJAmU4CcJ1HHKkaMxo
   PlX/4fSKZc+22R5EulB30x7qTTGbYW6SeENrq0AsobAwHSeDiKxAEOkg0
   7Qn5lMn9+rZEnfmQZbN/d8/wjgucc/GgfwFSeUGR4XFxjcKdApHaNl7+G
   h7ziuaxMCbJ++Uqp44W21sSccLMhfjcU4ATMd/Dbc/ydhK7dRebf5WSHY
   rasE+BI4VClTu+iLbxqJprUFsTLnIF3pKl8O/fLR9A0l+AReiqnWinWAt
   BtlgyJ9XDmBGBKLLLaB4eRctrgl8VAvTdfyy+w8G8/ueKy4wnm8HoWceH
   A==;
X-CSE-ConnectionGUID: 6xo/c9AzRWWLs1Ag/GNCQA==
X-CSE-MsgGUID: wVekcgg1RH2D/rx/ZOo9sA==
X-IronPort-AV: E=Sophos;i="6.21,256,1763449200"; 
   d="scan'208";a="52920604"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 01:49:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 27 Jan 2026 01:49:17 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 27 Jan 2026 01:49:14 -0700
Message-ID: <3540b83dbec35b7d2ffc370e517fe72340625dcf.camel@microchip.com>
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan9645x
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
Date: Tue, 27 Jan 2026 09:49:14 +0100
In-Reply-To: <6f80050b-558c-4be3-89a0-a242ee528ea9@lunn.ch>
References: <20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com>
	 <6f80050b-558c-4be3-89a0-a242ee528ea9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,pengutronix.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253750-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim]
X-Rspamd-Queue-Id: 91B6E9146C
X-Rspamd-Action: no action

Hi Andrew,

On Fri, 2026-01-23 at 17:11 +0100, Andrew Lunn wrote:
> > +static int lan9645x_config_intr(struct phy_device *phydev)
> > +{
> > +     int err;
> > +
> > +     /* enable / disable interrupts */
> > +     if (phydev->interrupts =3D=3D PHY_INTERRUPT_ENABLED) {
> > +             /* This is an internal PHY of lan9645x and is not possibl=
e to
> > +              * change the polarity of irq sources in the OIC (CPU_INT=
R)
> > +              * found in lan9645x. Therefore change the polarity of th=
e
> > +              * interrupt in the PHY from being active low instead of =
active
> > +              * high.
> > +              */
> > +             phy_write(phydev, LAN8804_CONTROL,
> > +                       LAN8804_CONTROL_INTR_POLARITY);
> > +
> > +             /* By default interrupt buffer is open-drain in which cas=
e the
> > +              * interrupt can be active only low. Therefore change the
> > +              * interrupt buffer to be push-pull to be able to change
> > +              * interrupt polarity.
> > +              */
>=20
> It is not stated here, but i assume that there are multiple of these
> PHYs in the switch, and each PHY has its own independent connection to
> the parent interrupt controller? There is no interrupt sharing going
> on, which is common with discreet PHYs.
>=20
>         Andrew

Yes you are right, there are 5 of these PHYs in the chip, each with their
on connection to the interrupt controller. It is similar to lan966x,
which has two internal PHYs of an older generation.

Thanks,
Emil


