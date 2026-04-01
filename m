Return-Path: <netdev+bounces-273979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOFgFjHWzGnnWwYAu9opvQ
	(envelope-from <netdev+bounces-273979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:24:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FF1376B86
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73F7D3063016
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 08:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1413AE1BE;
	Wed,  1 Apr 2026 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NR81kuGT"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765F3AE6F2;
	Wed,  1 Apr 2026 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031447; cv=none; b=MJM1mK6Rs4/0ckLIKpwaZ2mGxv/pry+OBwj2IbT+8b0H5KC64hWpOwkRUIouIvNJaayIt5Nbh4o1ilDlCDpTGNW8dh/aNOvC9JA5HzO3ILqPisA9gk8A97zxTFRtOpbbDrF9j9zWIQQ6hgt4DJDhcjp97hWpriVYGoJQFr84640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031447; c=relaxed/simple;
	bh=Ni04/9G4SIsoNZG/RxPat+gme/lPsnTjF/lZIzHivpc=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XFP1PFD5/AbsJ8i95DPjd7haEoE6WKGDdFiAzUNS/BxpW51nNJnqfjelthFH2voVKtccL/QyX7uXJ7Uq71cEdtxJWtcp1b860h9p10kBawEB8d0Fm1Ld4apzb3J8pIs/Wva56ikWmUUEMAJzJS3PeqQ++XFYZKnpsxsty8iLlIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NR81kuGT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775031444; x=1806567444;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Ni04/9G4SIsoNZG/RxPat+gme/lPsnTjF/lZIzHivpc=;
  b=NR81kuGTf6rAW8DivIT97WKNlZNbiO0G2cYqxjAPdhRqN/KLAgKhZKsw
   YaXS+KyPG1Khx2QPoRXwY3pVDelQoPXaSp8HAw2G/mwzVlj1BnH9n369J
   eiU1sPO9LZpfv4ZMkCDW9LzrBS48feBVO0duFJhbuDAL1f/Ew9qXKbiVS
   mFfgXwPPzF445O5ERoImCkV3v0OAcxBts9gbytWWIsAY49YpRE999tscE
   BYZeqqRzmpQn+IJc187eiJavWqvP3KxB4wn1GaUMzcklA/crQRY98eQlP
   raIfuRmBXPObELy9Coyirck4FJP+c9DG+K9XEs0S2CHgjqSXPNSXdGfT6
   g==;
X-CSE-ConnectionGUID: ZqHib0C6R5S5HUDka/KWCQ==
X-CSE-MsgGUID: Sn8Fp7uiSuyFNME6zMPA2g==
X-IronPort-AV: E=Sophos;i="6.23,153,1770620400"; 
   d="scan'208";a="55944410"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:17:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 1 Apr 2026 01:17:00 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 1 Apr 2026 01:16:57 -0700
Message-ID: <2a2de46c493fe7d9fcae5c02406d374c40c997eb.camel@microchip.com>
Subject: Re: [PATCH net-next v2 2/9] dt-bindings: net: lan9645x: add
 LAN9645X switch bindings
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Wed, 1 Apr 2026 10:16:57 +0200
In-Reply-To: <20260329195625.2789069-1-kuba@kernel.org>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-2-f7504e3b0681@microchip.com>
	 <20260329195625.2789069-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273979-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.9:email]
X-Rspamd-Queue-Id: C7FF1376B86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-03-29 at 12:56 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> dt-bindings: net: lan9645x: add LAN9645X switch bindings
>=20
> Add bindings for LAN9645X switch. We use a fallback compatible for the
> smallest SKU microchip,lan96455s-switch.
>=20
> > diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan964=
55s-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan96=
455s-switch.yaml
> > new file mode 100644
> > index 000000000000..0282e25c05d4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-swi=
tch.yaml
>=20
> [ ... ]
>=20
> > +patternProperties:
> > +  "^(ethernet-)?ports$":
> > +    type: object
> > +    additionalProperties: true
> > +    patternProperties:
> > +      "^(ethernet-)?port@[0-8]$":
>=20
> Does having additionalProperties set to true bypass the port number
> restriction?
>=20
> Since dsa.yaml allows port@[0-9a-f]+, it seems port@9 would silently pass
> validation as an additional property. Should this be unevaluatedPropertie=
s
> set to false instead?
>=20

Yes it is true the port regex has no effect, but I do not think

unevaluatedProperties: false

is what I want here. That rejects other properties from the parent. I can
remove the explicit additionalProperties: true. This is similar to

Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml

and the port number restriction still serves as documentation, even if it i=
s
not applied during validation.


> > +        type: object
> > +        description: Ethernet switch ports
> > +
> > +        $ref: dsa-port.yaml#
> > +
> > +        properties:
> > +          rx-internal-delay-ps:
> > +            const: 2000
> > +
> > +          tx-internal-delay-ps:
> > +            const: 2000
>=20
> Does enforcing a 2000ps delay conflict with standard rgmii bindings?
>=20
> As documented in net/ethernet-controller.yaml, a full 2ns delay is
> typically modeled using phy-mode set to rgmii-id rather than hardcoding t=
he
> delay properties with a base rgmii mode.
>=20

No this was explicitly requested on v1 to enable adding a delay with mac2ma=
c links.
I enforce 2000ps because that is the only supported value.

> [ ... ]
>=20
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
>=20
> How are the five integrated 10/100/1000Base-T phys mentioned in the
> description modeled?
>=20
> Since unevaluatedProperties is false at the top level and there is no
> definition or reference for an mdio node, wouldn't adding an mdio subnode
> to configure these phys fail schema validation?
>=20
> Should there be a reference to /schemas/net/mdio.yaml#?

No, the MDIO busses will be part of a parent MFD device node, not the switc=
h node.


