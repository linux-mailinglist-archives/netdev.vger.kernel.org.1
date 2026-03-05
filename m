Return-Path: <netdev+bounces-264389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFq5H3CBqWkd9gAAu9opvQ
	(envelope-from <netdev+bounces-264389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:13:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FA42127C4
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D562C302D5D0
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 13:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E8339EF18;
	Thu,  5 Mar 2026 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fVvxrm1M"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D95248F66;
	Thu,  5 Mar 2026 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716142; cv=none; b=IRbyh2nvffkXCyB6lCmbnRkVelbqDrRQcuzwGDq2GhHLqINb6UbkfLyrk+GVN1lO+zAXWZ9xcDCkd7mpkJclq+5ofW/q9zQJG27l0PKWspFhdjhvUj8vP9Vtvm3sJQBRpdP2PPTt0KedLnrT7YY7ATKPU0qwXW7viFvSj0knwRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716142; c=relaxed/simple;
	bh=LhhZwf9t0k8G63cUsWJ0P1P7EJ98uOM6BnXeuDdOXNc=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/HHhvn1RjYuXQudfIoNsHdTAsoOCm3bu1dOC37TDxSfs4xJ4Gw6K2pLdK/KqJqoTfFRPzqOrYil8S2LbdSgbDsLeARX1XMIaHIKBphTaTaMCNQ6Ldhj5061PDjKrcomGB1aFIMlKCR0EvBfVhbLDY6Rl2wt6U/Ew8A5yYOPGww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fVvxrm1M; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772716141; x=1804252141;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LhhZwf9t0k8G63cUsWJ0P1P7EJ98uOM6BnXeuDdOXNc=;
  b=fVvxrm1MiP/kqQRzFTJGqt7G3YAKSa76jCmUvDe0vt4JFPSqcQAMXg2t
   5EcMfDRXDk/lsN28TjuXrLl2IFLPKEtZlohT3Rqv0brum4pxQRGMAqNuY
   zwH5h/w5IufoUZA1HWNHOZRB5ND2/nXAJrAxxpMqfjEcwONkJ5VvEzhcU
   yzHqKicsSPm76EzoDrcoCq4oasENCqoZdS0KjNbOuNfaaiOJUOsZrYDt2
   XiEg2YK9gkePVGYz5ys4xnHTRETygxcxLkeDSmqoogTwG7gdRWscbE0ns
   oRkUdA4AaMLpgTUgRhgsjc738LlH0RRlCWa1hmnZnHELz0eAQcfwjF45k
   A==;
X-CSE-ConnectionGUID: gXs77xUDTlKJZhU07oQylw==
X-CSE-MsgGUID: u9erEe3fRBmR6w68ScAt2g==
X-IronPort-AV: E=Sophos;i="6.23,103,1770620400"; 
   d="scan'208";a="54262739"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 06:09:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Mar 2026 06:08:19 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Mar 2026 06:08:16 -0700
Message-ID: <f34815255c6d94194e3c0f01990a1fa650d623c2.camel@microchip.com>
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Conor Dooley <conor@kernel.org>, Vladimir Oltean <olteanv@gmail.com>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung Huh
	<woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Thu, 5 Mar 2026 14:08:15 +0100
In-Reply-To: <20260304-capture-kissable-3bdfe389864b@spud>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
	 <20260303-disperser-clone-512efa99f26c@spud>
	 <65fd5f46f1f996dd5f4df2de2efb52c8fa3575b3.camel@microchip.com>
	 <20260304161457.l6tkxix6sgube3qc@skbuf>
	 <20260304-capture-kissable-3bdfe389864b@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: D0FA42127C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264389-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0.61.9.0:email]
X-Rspamd-Action: no action

On Wed, 2026-03-04 at 19:06 +0000, Conor Dooley wrote:
> On Wed, Mar 04, 2026 at 06:14:57PM +0200, Vladimir Oltean wrote:
> > On Wed, Mar 04, 2026 at 05:10:11PM +0100, Jens Emil Schulz Ostergaard w=
rote:
> > > On Tue, 2026-03-03 at 18:56 +0000, Conor Dooley wrote:
> > > > On Tue, Mar 03, 2026 at 01:22:28PM +0100, Jens Emil Schulz =C3=98st=
ergaard wrote:
> > > > > +examples:
> > > > > +  - |
> > > > > +    soc {
> > > > > +        #address-cells =3D <1>;
> > > > > +        #size-cells =3D <0>;
> > > > > +
> > > > > +      ethernet-switch@0 {
> > > > > +        reg =3D <0>;
> > > >=20
> > > > Also, this is an odd example, why are you at address 0 on a "soc" b=
us,
> > > > which usually means that this device on an AXI/AHB bus, and 0 is ve=
ry
> > > > unusual for that. Obviously the example doesn't have to match the r=
eal
> > > > user, but this stands out.
> > > > I may have some follow up questions I think depending on your answe=
r.
> > >=20
> > > The intended way to bind this driver is via a parent MFD driver which=
 sets
> > > up the SPI register protocol, initiates regmaps and distributes them =
to child
> > > devices (like this DSA driver).
> > >=20
> > > Similar to mscc,vsc7512 in drivers/mfd/ocelot-spi.c.
> > >=20
> > > This MFD would be the soc node. All child nodes perform register IO o=
ver
> > > spi, using the regmaps requested from this parent so I think the addr=
esses
> > > on the bus are purely ornamental. Should I write the smallest registe=
r
> > > address in all regions used by the DSA driver instead?
> >=20
> > They are not ornamental, they should be the same addresses you'd put if
> > Linux had direct access to the SoC interconnect for MMIO, rather than t=
o
> > an SPI bridge to the SoC interconnect. Or at least I don't see why it
> > wouldn't be that way.
>=20
> I don't mind if they're made up addresses, but the example should be
> realistic. 0 is likely not realistic, but if it was 0x4000_0000 when the
> real thing is 0x8123_1234 then I don't really care. Since the parent is
> not actually a soc bus, can't you just remove this fake parent entirely,
> like the ocelot switch example does? Or insert something more genuine,
> like:
> spi {
>   #address-cells =3D <1>;
>   #size-cells =3D <0>;
>=20
>   soc@0 {
>     compatible =3D "microchip,lan96455s";
>     reg =3D <0>;
>     #address-cells =3D <1>;
>     #size-cells =3D <1>;
>=20
>     ethernet-switch@4000000 {
>       reg =3D <4000000 44>;
>=20


I will go with the genuine example. I was not sure if it was appropriate=C2=
=A0
to mention the spi node from here. But this is what it would look like with
the mfd driver. I will also fix the addresses.

Thanks,
Emil

