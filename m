Return-Path: <netdev+bounces-263298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGWuBL8Gp2k7bgAAu9opvQ
	(envelope-from <netdev+bounces-263298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:05:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6951E1F338F
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A0B73046063
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48952494A00;
	Tue,  3 Mar 2026 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Fz72B2ES"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4344949F7;
	Tue,  3 Mar 2026 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553674; cv=none; b=UC67rK5ZY74jYaStkEzPlQR9ZTYVr4H8f6SliTQoU2pRTfuS0SvShYGRLj+vgcvXlNdjwamqqYTDJAhHU6eLy+tLSF/rW8/XGYcNDPk4JxWkOYPW5rDHeUaeVWYcV0jnueU4UWOaJi4KM756DDmOFHCkIBXCbSHf/UBLj3IAteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553674; c=relaxed/simple;
	bh=8yCuPNtz/lobINON3e4aCuPyNSz1Q74SWKUzvQN6ZiQ=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GJTNLNNlfA85tEVBCAFzcPOUvbXpflgsTPpqOSVoWYLe7kyDcqRce+uq4pybD2Lcw3piInBMuL5IVksMoafS9ZhDkYPKZB8QFobN7YoPP1+Zg83JoAh1gXJwthqWFa1MU7s/kkFN2U+0vEbMHT/SMhN1ryl3HUezNuuFyeNsOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Fz72B2ES; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772553672; x=1804089672;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=8yCuPNtz/lobINON3e4aCuPyNSz1Q74SWKUzvQN6ZiQ=;
  b=Fz72B2ES9s8H0Z+ui/5aQukOtbPYsjn2kIqAF+UDrBBFVRdWPIJ90v6t
   rNDwLW7I5xSIqANM+pFsc0A9kSR1F0WGgH0/COXo7nXhgX8N9YHBU4eTh
   9dKYeEUK+O7FbQy01OajLRhMbgQPi6+7KqKIz1+kGZY9Us9jEzgbpuaUY
   kFxAKFg3PPCKnOu15DZmzVGppGW3fxHEPdyXAA1k2Vwqqd7K+aRDyRDtq
   fmP565QWEHhAwFc3Vgg58TPUUn3340oUBbPQRDq3YsuwD3a+IAksZK69B
   5KnjzagKQ37rCv+MRAtMDTUTSzmkHDL5rPrluJTisFPCAAxZi3SdFeHzn
   A==;
X-CSE-ConnectionGUID: iWTYXrUhRFePhBGVr5GA+A==
X-CSE-MsgGUID: bBNBg1hfQfWHSktGkuAN1w==
X-IronPort-AV: E=Sophos;i="6.21,322,1763449200"; 
   d="scan'208";a="221419278"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2026 09:01:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Mar 2026 09:00:09 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 3 Mar 2026 09:00:06 -0700
Message-ID: <99d068de7a781eef4f67b8fbe3dafb2fffbf752c.camel@microchip.com>
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung Huh
	<woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Tue, 3 Mar 2026 17:00:05 +0100
In-Reply-To: <20260303132226.6de5boh5pl6hi3hh@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
	 <20260303132226.6de5boh5pl6hi3hh@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6951E1F338F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263298-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,microchip.com:dkim,microchip.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 15:22 +0200, Vladimir Oltean wrote:
>=20
> On Tue, Mar 03, 2026 at 01:22:28PM +0100, Jens Emil Schulz =C3=98stergaar=
d wrote:
> > +examples:
> > +  - |
> > +    soc {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +      ethernet-switch@0 {
> > +        reg =3D <0>;
> > +        compatible =3D "microchip,lan96459f-switch", "microchip,lan964=
55s-switch";
> > +        pinctrl-0 =3D <&lan9645x_leds>;
> > +        pinctrl-names =3D "default";
> > +
> > +        ethernet-ports {
> > +          #address-cells =3D <1>;
> > +          #size-cells =3D <0>;
> > +
> > +          port@0 {
> > +            reg =3D <0>;
> > +            label =3D "lan0";
>=20
> Please remove labels from DSA examples. They do not constitute best
> practice, and it is preferable they don't leak into device trees by
> promoting them through binding examples.
>=20
> It is currently recommended to name DSA (like other) network interfaces
> using udev rules set up by user space. Using labels is perhaps only
> tolerated for cases where the udev implementation is sub-par, like
> OpenWrt.

I will remove the labels in the next version.

Thanks,
Emil

