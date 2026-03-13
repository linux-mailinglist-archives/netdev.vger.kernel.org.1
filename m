Return-Path: <netdev+bounces-267444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBwsGOYItGlvfwAAu9opvQ
	(envelope-from <netdev+bounces-267444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:53:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAAA28346F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A27B3004699
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751BE37FF72;
	Fri, 13 Mar 2026 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EmAzD+6Y"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF60379EFD;
	Fri, 13 Mar 2026 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773406417; cv=none; b=oV8Xo+C6H1QuvQ3/e8wZHCulgs/mr7ZP+jf02QS8cuVxubYZp9FAj6wOaaxOsxpFcgc0sxEoUR/xmno44f/AM18BxPr6Dik9JgXXAHdXefkFRz/o54Le/sEOSquK1Bmr+Q0OQQ6gVT5IiZ5A+MzVe7ORF6teKFADxowerUW9fG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773406417; c=relaxed/simple;
	bh=fVNG8XU8qrw3CqQjoIAdVbE7UZTFosXAF1TdDCwFDTw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXFFaz83hJGssdXnX16itOySsy7pi1mbhoP4GA4uK5YY9zKQfVcOas7mseZRhWZca0UMLRe8Z6Jo2chUnlmUZ5Hv0r9eitSPAjN7A0F+848Vwlnq06wNJ1w+4N1TkoZU+jD13l118chARFYDwIN8tVxakbuK2fzOK9UlGcH7BgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EmAzD+6Y; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773406415; x=1804942415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fVNG8XU8qrw3CqQjoIAdVbE7UZTFosXAF1TdDCwFDTw=;
  b=EmAzD+6YHvP4RsClACtw8wErxnzDSnmVytN0hXhBfoyjI0Uzzft2F7Q5
   evgzuxqRWkHgEAvufWfPf3uQxKm3CSulkYx6KDx0wNZuDJ4kX2H9TPaPS
   8YO1XrmulmP3o3kC+L8I+FytfcsjS1lJ9/UMmaeJSwMyHKuk7r5q01X/w
   PmrkTnNpiyctLw2LsNIdmuUP2c1BnCWEL6vA7uqNBqvMNiDq6RVraVQ1n
   9n1bhQ1gUu62a/QasXnzacH4S0MpetkkeYKcO8wNV84VSxpH5I0nOBZy2
   xTbaLo38iDLPrV4ZUAVG2Bx8W4J+J0mLIRzo77TVSH2IJ81+/V6+z3ljE
   w==;
X-CSE-ConnectionGUID: 9ff1ETxjS+mW1ReyoyIBew==
X-CSE-MsgGUID: A8XVWbAdTUWuAn2xe5oUOw==
X-IronPort-AV: E=Sophos;i="6.23,118,1770620400"; 
   d="scan'208";a="221880347"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 05:53:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 13 Mar 2026 05:52:54 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 13 Mar 2026 05:52:53 -0700
Date: Fri, 13 Mar 2026 05:52:52 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<horms@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<nicolas.ferre@microchip.com>
Subject: Re: [net-next,v2,1/3] dt-bindings: net: cdns,macb: add a compatible
 for Microchip pic64hpsc
Message-ID: <abQIpGEGi7m3LqWy@bby-cbu-swbuild03.eng.microchip.com>
References: <20260310212202.3991199-2-charles.perry@microchip.com>
 <20260313014943.1513621-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260313014943.1513621-1-kuba@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267444-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:dkim,linux.dev:url,bby-cbu-swbuild03.eng.microchip.com:mid]
X-Rspamd-Queue-Id: 5CAAA28346F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 06:49:43PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "Not sure about the first one but the second one looks
> legit"
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> dt-bindings: net: cdns,macb: add a compatible for Microchip pic64hpsc
> 
> This commit adds "microchip,pic64hpsc-gem" for "PIC64-HPSC" and
> "microchip,pic64hx-gem" for "PIC64HX" compatible strings. It also adds a
> conditional schema check to prevent adding PHYs under the GEM node for
> hardware where MDIO controllers are unconnected from physical pins.
> 
> > diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> > --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> > +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> > @@ -70,6 +70,14 @@
> >                - microchip,sama7d65-gem   # Microchip SAMA7D65 gigabit ethernet interface
> >            - const: microchip,sama7g5-gem # Microchip SAMA7G5 gigabit ethernet interface
> >
> > +      - items:
> > +          - const: microchip,pic64hpsc-gem # Microchip PIC64-HPSC
> > +          - const: cdns,gem
> > +      - items:
> > +          - const: microchip,pic64hx-gem   # Microchip PIC64HX
> > +          - const: microchip,pic64hpsc-gem # Microchip PIC64-HPSC
> > +          - const: cdns,gem
> 
> The fallback structure appears reversed from what was recommended in v1
> review. Conor Dooley suggested that pic64hpsc should fallback to pic64hx:
> 
>   - items:
>       - const: microchip,pic64hx-gem
>       - const: cdns,gem
>   - items:
>       - const: microchip,pic64hpsc-gem
>       - const: microchip,pic64hx-gem
>       - const: cdns,gem
> 
> However, the current implementation has pic64hx falling back to pic64hpsc
> instead. Was this reversal intentional, or should the order match the
> reviewer's recommendation?
> 

Yes, this is intentional.

> https://lore.kernel.org/netdev/20260303-emperor-childlike-6c43d8a91753@spud/
> 
> >
> >    reg:
> >      minItems: 1
> 
> [ ... ]
> 
> > @@ -196,6 +204,17 @@
> >        required:
> >          - phys
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: microchip,p64h-gem
> > +    then:
> > +      patternProperties:
> > +        "^ethernet-phy@[0-9a-f]$": false
> > +      properties:
> > +        mdio: false
> 
> The conditional check references 'microchip,p64h-gem', but the compatible
> strings actually added above are 'microchip,pic64hpsc-gem' and
> 'microchip,pic64hx-gem'. This causes the validation rule to never trigger
> for the new hardware variants.
> 
> According to the commit message, the GEM IPs within pic64hpsc have their
> MDIO controllers unconnected from physical pins, and this check should
> prevent adding PHYs under the GEM node. However, device trees using
> 'microchip,pic64hpsc-gem' or 'microchip,pic64hx-gem' with invalid
> MDIO/ethernet-phy configurations will silently pass schema validation.
> 
> Should this check use 'microchip,pic64hpsc-gem' instead?
> 

Oops! Good catch! I'll send a v3.

Thanks,
Charles 


