Return-Path: <netdev+bounces-263411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNCBB2pIp2lOgQAAu9opvQ
	(envelope-from <netdev+bounces-263411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:45:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA071F6EBB
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE9D53096599
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 20:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FA1358380;
	Tue,  3 Mar 2026 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CkOjcmdE"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49426E6F3;
	Tue,  3 Mar 2026 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570727; cv=none; b=qL+ZTYYzrVWXhZJPGfwIVgth07rE2WnhkWBKULzwT95F8lx2WxenyFNbLTHoigRjuba8B03CcxxCAzJhZgtYOu+GdmWfUw1vy5dikx/HqffRy2zv0uCJs3BuVIGF8WRG3AREi0brayIthl9iITaqLvaqXPxevktT1JDybV6BI5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570727; c=relaxed/simple;
	bh=Ua4V1PXhLnJ8TKpbe1jjOprEwoDqkbQCsQKhKbfp+m4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkHTYuInGAK43/nsVF1A4KT2m1/goSp1PlS0EdfCjkoZ6lKINe39n6WTUTFyReqTK7oprPl6fYwaWApnV2i8/Gc3sRCL10RegsLcd91X2JXkOV7DPC1mtoR07kKi3ONPXXTSjlhmgApS6VEgBLBw0N2pj49lhJS94i2jyDvbzY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CkOjcmdE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772570725; x=1804106725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ua4V1PXhLnJ8TKpbe1jjOprEwoDqkbQCsQKhKbfp+m4=;
  b=CkOjcmdExjatNefWt7xo3Rpox207Y0jSsKaXIhvtPLXCyVYvCNToSQle
   9zYzSa5WS6LQvsenOEAjS/LPrruOsrfCnquGj33+uJrtPsszjz6TIpm+Z
   ME2yr7oFHu+xxI8DffZQH6Q4I+ylklgzKwrKag7fgvUAktZrFMTw/qFe3
   6IFkLPOJYVymwl8oeNMixL3UQ9HG8NbFXIomHeTMq6B6JV0RbfmeSe54v
   FTSqCMr8tpMu/2gsfHNCn/QRtt6iLXhAELAxX8f5T/xyWaAg2xnx94Adb
   DR4NrYDlzNwtxT5UMPPx00gmqHwNRM9VR+iEKjzSGaJ31WsgK0FaVoaWj
   A==;
X-CSE-ConnectionGUID: WbW/3edCSFOfGuo6LdDdBw==
X-CSE-MsgGUID: COi6B65CTNe+5a6E4gfmEw==
X-IronPort-AV: E=Sophos;i="6.21,322,1763449200"; 
   d="scan'208";a="53430819"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 13:45:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 3 Mar 2026 13:45:23 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 3 Mar 2026 13:45:22 -0700
Date: Tue, 3 Mar 2026 12:45:21 -0800
From: Charles Perry <charles.perry@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <charles.perry@microchip.com>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: cdns,macb: add a
 compatible for Microchip p64h
Message-ID: <aadIYcFrlYmrV3RW@bby-cbu-swbuild03.eng.microchip.com>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
 <20260303180318.1814791-2-charles.perry@microchip.com>
 <20260303-primal-cradling-f600faca8504@spud>
 <aacuSRxLktvCBaNK@bby-cbu-swbuild03.eng.microchip.com>
 <20260303-emperor-childlike-6c43d8a91753@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260303-emperor-childlike-6c43d8a91753@spud>
X-Rspamd-Queue-Id: 7AA071F6EBB
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
	TAGGED_FROM(0.00)[bounces-263411-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 07:32:25PM +0000, Conor Dooley wrote:
> On Tue, Mar 03, 2026 at 10:54:01AM -0800, Charles Perry wrote:
> > On Tue, Mar 03, 2026 at 06:18:48PM +0000, Conor Dooley wrote:
> > > On Tue, Mar 03, 2026 at 10:03:15AM -0800, Charles Perry wrote:
> > > > "p64h" is shorthand for "PIC64-HPSC" and "PIC64HX"
> > > 
> > > No, sorry. If these are different SoCs they need to have SoC-specific
> > > compatibles, particularly since PIC64HY could be something that is not
> > > compatible with these devices. It'd be fine to add
> > > "microchip,pic64hpsc-gem" with "microchip,pic64hx-gem" as a fallback
> > > though, since they do appear to be very very very similar devices and
> > 
> > Yes, "very very very similar" is the right term.
> 
> FWIW, if the only difference was binning or fusing, having the same
> compatible for more than one device could be okay. But these are
> actually like polarfire-soc and rt-polarfire-soc, where they look very
> similar to software but the rt process means that they're physically
> different, right?
> 

I know they are functionally equivalent but some blocks are fused. I don't
know about manufacturing processes, sorry.

> > > can clearly share the same match data in the driver. That's what pic64gx
> > > and mpfs do.
> > 
> > Ok, no problem. Like this? :
> > 
> > ```
> >       - items:
> >           - enum:
> >               - microchip,pic64hpsc-gem
> >               - microchip,pic64hx-gem
> >           - const: microchip,pic64h-gem
> >           - const: cdns,gem
> 
> I was thinking
> - items:
>     - const: microchip,pic64hx-gem
>     - const: cdns,gem
> - items:
>     - const: microchip,pic64hpsc-gem
>     - const: microchip,pic64hx-gem
>     - const: cdns,gem
> 
> And getting rid of the "pic64h" that may end up not being sufficiently
> common in the future.
> 

Ok sounds good but I'll make "pic64hpsc" the favorite child and let
"pic64hx" fallback to "pic64hpsc".

> > Also, how important is it to use "pic64h" vs "p64h"?
> 
> Oh I didn't even notice that tbh, I just have "pic64" muscle memory from
> the pic64gx, and the pic32mzda also spells it out. My OCD says says "pic",
> and the fact that all the marketing stuff uses "pic" kinda votes in that
> favour too.
> 

Ok, lets use "pic".

> > Much of the downstream development uses "p64h" in compatibles, file names,
> > function names, etc. and it would create some overhead to rename
> > everything.
> 
> This is probably one of the easiest things to absorb from a
> up/down stream perspective, you could (and probably will on other
> submissions) get far more disruptive feedback than something that's
> effectively cosmetic and can be solved by adding a single line to a
> driver. To be honest, I don't care if you rename functions or filenames,
> it's only devicetree related things that I personally care about.
> 

Understood.

Thank you,
Charles

> > Although, as I think of it, it might not be a bad thing since it would
> > allow to quickly identify the mainstream from the downstream code.



