Return-Path: <netdev+bounces-263376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ5WFEIvp2mbfgAAu9opvQ
	(envelope-from <netdev+bounces-263376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:58:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D1C1F58B0
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9C1F302CB11
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85361372683;
	Tue,  3 Mar 2026 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CruXrtCo"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61B372675;
	Tue,  3 Mar 2026 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564287; cv=none; b=aCW6/ru3Y0EoJZ0hljQ7wdes8zTIKY3yz9rmqY2+mx/hNYelznNzhfJBsq7XW1QDJyJiiVMlePCaTa7Skk90WD5YelJ/NsG80NMuPF6g0UfVCnS8JseNsnMwKPW63LVcpryg75hG+hFj7II5Luu4k6wdz3keBT15s+maLljeTsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564287; c=relaxed/simple;
	bh=EtWg3YLmhHTWZkHEIg3KBpU5XI/TYRzQlO5nZlf3s5k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1KzsPmJE4Sr1brGaKUz8V38MMDBeDrDE+gsxXijpOpJbLQ4yUcMNlsT1fTqn2xaL3e/WYMSAQ1st1tl7KjxbXnYlT60JBQRu9LOAgIYtGi7QFiRSZgXP3Mr1xU65/lEgqIHtoA12ARblnBzhtISnre+LWXGXj+lFvEpzyL3gXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CruXrtCo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772564286; x=1804100286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EtWg3YLmhHTWZkHEIg3KBpU5XI/TYRzQlO5nZlf3s5k=;
  b=CruXrtCoxvlUN59G7n5Ymwb0xoARqoBAVw6xFqPBDZ9sKsVH8FJR0fGN
   MnTUiyrz4v6qRDMgyPPocShACdxTSAq/4q3LJ6cHdGORIKBZLKEjHgIpg
   e7cj/DcSYpEj+2TmHLvYzhzdv146+fzhzX/6u8CArQVG0u/Z5LW0Ony7Y
   zGfDJC8OxO+1NMFfSm9jRDUlcSv2u7aeZhiIn/0J+X2TND1fDHXPI9nAY
   DX3HsKItaCHPYCqZv3vXA/6c2FbaEvtBCmkYnLJz+deYSaySJlTAWdoQP
   +4HGh9+S3+pwXPlThIDhc4cqgepFQsAvMJ4+7UdVswISepFVoo4c7jZ3T
   w==;
X-CSE-ConnectionGUID: aWWa6EwYSd6QIkRSx1rNnQ==
X-CSE-MsgGUID: rR7sdMFvTq+4mgPvp6cXog==
X-IronPort-AV: E=Sophos;i="6.21,322,1763449200"; 
   d="scan'208";a="54163067"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 11:58:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 3 Mar 2026 11:57:44 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 3 Mar 2026 11:57:43 -0700
Date: Tue, 3 Mar 2026 10:57:42 -0800
From: Charles Perry <charles.perry@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <charles.perry@microchip.com>
Subject: Re: [PATCH net-next 2/4] dt-bindings: net: cdns,macb: forbid phy
 nodes for Microchip p64h
Message-ID: <aacvJsma52VAFDrQ@bby-cbu-swbuild03.eng.microchip.com>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
 <20260303180318.1814791-3-charles.perry@microchip.com>
 <20260303-curse-shudder-9bd286fa6cd0@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260303-curse-shudder-9bd286fa6cd0@spud>
X-Rspamd-Queue-Id: 68D1C1F58B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263376-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_PROHIBIT(0.00)[80.111.88.32:email];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,devicetree.org:url,bby-cbu-swbuild03.eng.microchip.com:mid,microchip.com:dkim,microchip.com:email,0.0.0.0:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 06:11:42PM +0000, Conor Dooley wrote:
> On Tue, Mar 03, 2026 at 10:03:16AM -0800, Charles Perry wrote:
> > The GEM IPs within Microchip p64h have their MDIO controllers
> > unconnected from any physical pin.
> > 
> > When compiling a p64h device tree with a phy on a GEM node with
> > CHECK_DTBS=1, this generates an error like:
> > 
> > ```
> > linux/arch/riscv/boot/dts/microchip/p64h-hb130x.dtb:
> > ethernet@40004180000 (microchip,p64h-gem): ethernet-phy@0: False
> > schema does not allow {'reg': [[0]]}
> > 	from schema $id:
> > http://devicetree.org/schemas/net/cdns,macb.yaml#
> > ```
> 
> This should just be part of the patch adding the compatible. Adding it
> incorrectly only to fix it up one patch later doesn't make sense.
> Additionally, remove this information about the error adding this
> produces, all you need here is the justification for it.
> 

Ok

Thanks,
Charles

> pw-bot: changes-requested
> 
> > 
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/net/cdns,macb.yaml | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> > index dff350302098..be66cc9a42fd 100644
> > --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> > +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> > @@ -197,6 +197,17 @@ allOf:
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
> > +
> >  unevaluatedProperties: false
> >  
> >  examples:
> > -- 
> > 2.47.3
> > 



