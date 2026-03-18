Return-Path: <netdev+bounces-269185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PCEI/YXu2k+fAIAu9opvQ
	(envelope-from <netdev+bounces-269185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:24:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E39EA2C2F34
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83BD4302EEB0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D7376BDC;
	Wed, 18 Mar 2026 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wf3x76I2"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092FB293B75;
	Wed, 18 Mar 2026 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773869035; cv=none; b=soSQzeoh3vQRFRfiH2+ZQ2fUnh+BXeO2oqT55vDfMv+psSblvihNK3EJhHswnI8AY4IOR3qxIkotsuPoxD3bxlyl+2ELuOyMz0bgEOvs1LDD5I/VzrHi7R1ucAOhTd1GGvXwrJgd9JWX2oyoizKRs3K97VUtWdlladLxbiOO5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773869035; c=relaxed/simple;
	bh=diJ9QPPY6KW09PwuO6V9voRGxd18I3VD+Tg2MitGWWU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vc++L/GMen1W64az9mb0LO0LKUeGvpZk9cva5A0sFZj6p3/iT7pskwjQeZ5zdNkOQyN5I1Sg77+0ynBnXiMS7DKZdiRDCrzxhqoJDLv5ZVvGRWQZgg+GI1a+FyARpCJE6eGUtwXQtj3+D/GcAUK/vQ4pwkBHWVhe0Z0Rp9oxmmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wf3x76I2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773869034; x=1805405034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=diJ9QPPY6KW09PwuO6V9voRGxd18I3VD+Tg2MitGWWU=;
  b=wf3x76I2cZ5jkqsHA221WKYqlZD55zInLdt1ONPAVqVKqlZwufEFpLBZ
   hO7N/UznKRkXZZV1Uh+nCXSQaq87nTjheqB1CqgvDtO86uaeUKQOEr3AL
   hMYm1dCqp8L7Oo5V0m1tHfYp11+teCEacOznmFa2bR1Iuwjp7tNAj88v1
   RTjF7s5hcQ7BvfofVQrQEXAYChT4xvGQGkLO2kAFtN0nt6p3bu5MLv3O7
   nBdD94EQMS1ZOgO+Lf01XmKNGwunNHNL7mmfpdX714B1k81mL3BPKtXSH
   I6pUfj7tT/jZowigaO0WBNfqjo1JRiMnnOr18emXnSsVejSDLIMBb30bX
   Q==;
X-CSE-ConnectionGUID: fmMH9kipSzyI1CxnMFzQBQ==
X-CSE-MsgGUID: pae+xRSJQsmKA7b9gwOPtQ==
X-IronPort-AV: E=Sophos;i="6.23,128,1770620400"; 
   d="scan'208";a="54865784"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2026 14:23:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 18 Mar 2026 14:23:27 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Wed, 18 Mar 2026 14:23:24 -0700
Date: Wed, 18 Mar 2026 14:23:23 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: document Microchip
 PIC64-HPSC/HX MDIO controller
Message-ID: <absXy5Qmd/iHWofD@bby-cbu-swbuild03.eng.microchip.com>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-2-charles.perry@microchip.com>
 <20260318-suspense-arming-fe118c3f15c6@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260318-suspense-arming-fe118c3f15c6@spud>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-269185-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.938];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url,microchip.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: E39EA2C2F34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 05:48:08PM +0000, Conor Dooley wrote:
> On Tue, Mar 17, 2026 at 11:46:09AM -0700, Charles Perry wrote:
> > This MDIO hardware is based on a Microsemi design supported in Linux by
> > mdio-mscc-miim.c. However, The register interface is completely different
> > with pic64hpsc, hence the need for separate documentation.
> > 
> > The hardware supports C22 and C45.
> > 
> > The documentation recommends an input clock of 156.25MHz and a prescaler
> > of 39, which yields an MDIO clock of 1.95MHz.
> > 
> > The hardware supports an interrupt pin to signal transaction completion
> > which is not strictly needed as the software can also poll a "TRIGGER"
> > bit for this.
> > 
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > ---
> >  .../net/microchip,pic64hpsc-mdio.yaml         | 61 +++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
> > new file mode 100644
> > index 000000000000..21c76199c11b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/microchip,pic64hpsc-mdio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microchip PIC64-HPSC/HX MDIO controller
> > +
> > +maintainers:
> > +  - Charles Perry <charles.perry@microchip.com>
> > +
> > +description: |
> > +  Microchip PIC64-HPSC/HX SoCs have two MDIO bus controller. This MDIO bus
> > +  controller supports C22 and C45 register access. It is named "MDIO Initiator"
> > +  in the documentation.
> > +
> > +allOf:
> > +  - $ref: mdio.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: microchip,pic64hpsc-mdio
> > +      - items:
> > +          - const: microchip,pic64hx-mdio
> > +          - const: microchip,pic64hpsc-mdio
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-frequency: true
> 
> Does this genuinely have no constraints?

It's going to divide the input frequency by 2 to 512 (the prescaler is 8
bit long), so assuming an input clock of 156.25 MHz, the bounds are 305KHz
to 78MHz. The standard is 2.5MHz.

I can add a maximum and minimum here since I do have some validation on
this in the driver which will bail out if this is out of bound.

Thanks,
Charles

