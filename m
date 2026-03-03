Return-Path: <netdev+bounces-263371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMB4Ankup2mbfgAAu9opvQ
	(envelope-from <netdev+bounces-263371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:54:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE541F5838
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F825301545C
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1798D377ECC;
	Tue,  3 Mar 2026 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tp+jwrbP"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DCA2153D8;
	Tue,  3 Mar 2026 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564086; cv=none; b=PAGSSx5QSYuILuvw5zPgqNlzUD3nkjoYM2H40E9BBaJqFNlSFKGNTedrk7800z/WstzhoeYbFmSlIdkuG04Vv4LrQvVufNSHb+BcGFjPm0vuBlN8uOwnfhhP4RLoS8OOaXi3E4c3arVw/cj2jOVfVcSdQFpuepG3V4WtfCvDtGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564086; c=relaxed/simple;
	bh=/idX8QivQo2BDr3Mxzwukch259tw+JdI2SitHpRhJcQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjvbvACYY+YMCSxkmGbODbrzZMlos+LjC7hSGb218Sa3o6V/knbuC/jZZzsDmezRdFeaRZcmt+hyaZETEmc93+1OFXsIY+urt3LIYBKwfFzFOkU7OStiXEuJFIwYFM2xe3ZCeMQ8r5l2w0rr2qvMIdNPArS9lB3IyoeO79DTYDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tp+jwrbP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772564085; x=1804100085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/idX8QivQo2BDr3Mxzwukch259tw+JdI2SitHpRhJcQ=;
  b=tp+jwrbPEmJjcwHOpiYgwVZKTNINWR3R9zTwBk6u3YK31fG7AcbkXwRc
   xJ0fpNWzlrrLada+EieLHtGeU++6QMGhZJcTf8OS2UABfsMA+ebM6s1GD
   L3VnPVLUCvyBbqJPaR1XoLfL5LBl7W0KweuM81XlzpfFEFGyNi0JT9d/2
   o8FqvuXCgyARwtJS1f87CWr6Ld/GsbC2Qo57tyv+Omcs6uWFbClAjhBl0
   DA2cuj1W++YeDLim8zw4EdEao/7Anqqd+/i0GcJu5BWMxqOr/sAvFpLMZ
   vt3taanysGkP/uJ7bka4TVVnlJ5y3AvBRnobT76Ek/Ih/2aHB66OhicHH
   Q==;
X-CSE-ConnectionGUID: vCCADSueTRSDNnUFr7evcQ==
X-CSE-MsgGUID: CEhNlibjT6iB2YW6dMy4ww==
X-IronPort-AV: E=Sophos;i="6.21,322,1763449200"; 
   d="scan'208";a="54162938"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2026 11:54:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Mar 2026 11:54:03 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 3 Mar 2026 11:54:02 -0700
Date: Tue, 3 Mar 2026 10:54:01 -0800
From: Charles Perry <charles.perry@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: cdns,macb: add a
 compatible for Microchip p64h
Message-ID: <aacuSRxLktvCBaNK@bby-cbu-swbuild03.eng.microchip.com>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
 <20260303180318.1814791-2-charles.perry@microchip.com>
 <20260303-primal-cradling-f600faca8504@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260303-primal-cradling-f600faca8504@spud>
X-Rspamd-Queue-Id: BFE541F5838
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
	TAGGED_FROM(0.00)[bounces-263371-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bby-cbu-swbuild03.eng.microchip.com:mid,microchip.com:dkim,microchip.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 06:18:48PM +0000, Conor Dooley wrote:
> On Tue, Mar 03, 2026 at 10:03:15AM -0800, Charles Perry wrote:
> > "p64h" is shorthand for "PIC64-HPSC" and "PIC64HX"
> 
> No, sorry. If these are different SoCs they need to have SoC-specific
> compatibles, particularly since PIC64HY could be something that is not
> compatible with these devices. It'd be fine to add
> "microchip,pic64hpsc-gem" with "microchip,pic64hx-gem" as a fallback
> though, since they do appear to be very very very similar devices and

Yes, "very very very similar" is the right term.

> can clearly share the same match data in the driver. That's what pic64gx
> and mpfs do.

Ok, no problem. Like this? :

```
      - items:
          - enum:
              - microchip,pic64hpsc-gem
              - microchip,pic64hx-gem
          - const: microchip,pic64h-gem
          - const: cdns,gem
```

Also, how important is it to use "pic64h" vs "p64h"?

Much of the downstream development uses "p64h" in compatibles, file names,
function names, etc. and it would create some overhead to rename
everything.

Although, as I think of it, it might not be a bad thing since it would
allow to quickly identify the mainstream from the downstream code.

Thank you,
Charles

> 
> pw-bot: changes-requested
> 
> Cheers,
> Conor.
> 
> > 
> > The generic compatible "cdns,gem" works but offers limited features.
> > Keep it as a fallback.
> > 
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> > index cb14c35ba996..dff350302098 100644
> > --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> > +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> > @@ -27,6 +27,7 @@ properties:
> >  
> >        - items:
> >            - enum:
> > +              - microchip,p64h-gem    # Microchip P64H SoC
> >                - xlnx,versal-gem       # Xilinx Versal
> >                - xlnx,zynq-gem         # Xilinx Zynq-7xxx SoC
> >                - xlnx,zynqmp-gem       # Xilinx Zynq Ultrascale+ MPSoC
> > -- 
> > 2.47.3
> > 



