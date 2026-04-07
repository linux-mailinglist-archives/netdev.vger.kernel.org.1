Return-Path: <netdev+bounces-276126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOuRDnFH1Wk44AcAu9opvQ
	(envelope-from <netdev+bounces-276126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:05:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6B93B2B4E
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38657303C4D8
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A5F387354;
	Tue,  7 Apr 2026 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Q0XnXkT/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468213DBA0;
	Tue,  7 Apr 2026 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584955; cv=none; b=ZYTYIH3vqW1oRJhJ1FLhg6WYYekPALsIVYwPv5IHQh7VJtq9aiUczSP4qCaBmdkP5WuqQHye2d4uqCI80rKMiE6/zQrXJyqTp0YaVtQE7jxcR77pIK82a7vF6DY9HAOL7Jgj1f5jMAzF98bsSwHJgvYgsFrmMF2fDC7RPZCaHK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584955; c=relaxed/simple;
	bh=lKBY1z1uLEHqN9XLznWn9epJHbwWXKp15puN8Z20MwI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diHBsJ7BijKMWYX/bWEHa3Ra+MjOQxAok6n7TvW1HKDuyjrS3SfnXr/SrDQBzF7S/egLL380YgsNpF0GOWKUDdx3qoHgmrNXDB71MLGtjzojsmIHx9K8FMjKN06diWOwsXmHrQ76NBvUByQHp3KQ5D2dGkTu6duOxjmwvm/kSFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Q0XnXkT/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775584954; x=1807120954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lKBY1z1uLEHqN9XLznWn9epJHbwWXKp15puN8Z20MwI=;
  b=Q0XnXkT/6dNPMPoKQkuD6G5JVRWB7baWHJRC59ImilCT+SzP3Yz+2dvE
   qdyuRGpXAR8U6eCcLc2dMlYVc0XC/yJZySKKMgJEx3ARWxHO7nqLluBeA
   Mrm2rY9Enijpy4/ODoc1GzfYGCYqxeXEM/4g7HtydKkfG6VW6dctxhzBd
   JPu5OG+q5yH0K4ahpCVUeJXHWL4UmAlJvh3FbDEXS2+FudORt1nZa9KjP
   pzczXIICC2lzkgqM6C/h3PCiOkYykZLoqpMRc8/i5vTJsqFTdZJ0dF3e0
   vhXwAtc/CLhQvQHZ6IGFyILMFbxgl5oKIl/irdcWZ4QYYxE9rfm2yQN7g
   g==;
X-CSE-ConnectionGUID: TeKTuHSeRxSK4Yqaj2tYAA==
X-CSE-MsgGUID: bU7TBYaLTRuKKurSwVBOVA==
X-IronPort-AV: E=Sophos;i="6.23,166,1770620400"; 
   d="scan'208";a="55031410"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2026 11:02:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 7 Apr 2026 11:02:00 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 7 Apr 2026 11:01:59 -0700
Date: Tue, 7 Apr 2026 11:01:58 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Rob Herring <robh@kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	"Russell King" <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: document Microchip
 PIC64-HPSC/HX MDIO controller
Message-ID: <adVGlhjDmrX0SM08@bby-cbu-swbuild03.eng.microchip.com>
References: <20260323220254.3822444-1-charles.perry@microchip.com>
 <20260323220254.3822444-2-charles.perry@microchip.com>
 <20260407170033.GA2954294-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260407170033.GA2954294-robh@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-276126-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,microchip.com:dkim,microchip.com:email,bby-cbu-swbuild03.eng.microchip.com:mid,4000c21e000:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Queue-Id: 8F6B93B2B4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 12:00:33PM -0500, Rob Herring wrote:
> On Mon, Mar 23, 2026 at 03:02:53PM -0700, Charles Perry wrote:
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
> > 
> > Notes:
> >     Changes in v2:
> >       - Make "clocks" and "interrupts" required (Andrew)
> >       - Add a default value to "clock-frequency" (Andrew)
> > 
> >  .../net/microchip,pic64hpsc-mdio.yaml         | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
> > new file mode 100644
> > index 000000000000..d690afe3d3cf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
> > @@ -0,0 +1,68 @@
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
> 
> Don't need '|' if no formatting to preserve.
> 

Ok

> > +  Microchip PIC64-HPSC/HX SoCs have two MDIO bus controller. This MDIO bus
> 
> s/controller/controllers/
> 
> Though how many instances there are is not really applicable to the 
> binding unless there is some difference.

There are no differences between the two instances. I'll remove the mention
about the SoC containing two instances.

>
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
> > +  clock-frequency:
> > +    default: 2500000
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - interrupts
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    bus {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        mdio@4000C21E000 {
> 
> Unit-addresses are lower case hex.

Ok

> 
> > +            compatible = "microchip,pic64hpsc-mdio";
> > +            reg = <0x400 0x0C21E000 0x0 0x1000>;
> 
> And generally we use lower case here too.

Ok

> 
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            clocks = <&svc_clk>;
> > +            interrupt-parent = <&saplic0>;
> > +            interrupts = <168 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +            phy0: ethernet-phy@0 {
> 
> Drop unused labels.

Ok

Thanks,
Charles

