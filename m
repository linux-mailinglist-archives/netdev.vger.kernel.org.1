Return-Path: <netdev+bounces-269628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N9TAaRQvGkXwwIAu9opvQ
	(envelope-from <netdev+bounces-269628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:38:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F902D1BA7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAF2630B266E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04A23AD515;
	Thu, 19 Mar 2026 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q1+ZLUnf"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A173D36215A;
	Thu, 19 Mar 2026 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948991; cv=none; b=XyuSSwNvBgCWeFyNtsooYVsWuouMek/DWbc+urROe4pXtbJp8quwdYLaOvIYD6xG10k6QtbO6BAwBuXFvtd70QU5BzS1oygwyGEVsVUkHY+imZTqwGAgXCpFbdG8NDUzR3gXnnhOklqAPGYqsPPG3mpM224g/d/dj/5GYLXGL2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948991; c=relaxed/simple;
	bh=uMzgjyr4lRvewX3BgJKQHuVDUC0MB9dePa5pKDuyr4k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKvelhFHR+6zZ58XUbF6G+W52W1rYrAvukOneCuT1fxlmhsVN0DedpVtewsVGBc7kSqeJwuFdfJMo+0osDA+ILlnZfGIIRUep9niZHC8LHDw2QLJdIzX2YtEeImbrvjQ4aT5sbNfblBurhx3+teJzyh0lwO5qdcvR2RXQSyZGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q1+ZLUnf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773948990; x=1805484990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uMzgjyr4lRvewX3BgJKQHuVDUC0MB9dePa5pKDuyr4k=;
  b=q1+ZLUnfedlvNgDROktQzTr4AnzAwkw3e66HH8UZ6/Gjy/XrLBZzvvac
   vqNhgZjwLhV64OyeD2VuQtw0y4Flg6T+9FdIByHgeIn1nX+bCdI0xn0hH
   WeStFsPQ1I44BmtnbTBQsDx47OUiZPW1BukB5quKLVYs/PyMAKU4m9s74
   pAMoP9MitvwVI2g4T/dXO3Ws/1TR3QHbsndbxgnVsnpn75x1vnDsqJvAS
   RZOSlcEXVLYI7KFb+syH+30wezD0Pm9WzT8rRm6m9Mdr8SacsosWEId2U
   3aEJnv3ptVHvGsVvo7N/eU/lg1H7jr5/pxRlCZZSpjNW1Kq+lBvbMFz5D
   w==;
X-CSE-ConnectionGUID: tEdg3PYiQ/y+TKzMp0uzxg==
X-CSE-MsgGUID: Pdk0O8/vQXmaWSXSe8toeA==
X-IronPort-AV: E=Sophos;i="6.23,129,1770620400"; 
   d="scan'208";a="55349439"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 12:36:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 19 Mar 2026 12:36:18 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 19 Mar 2026 12:36:15 -0700
Date: Thu, 19 Mar 2026 12:36:07 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: document Microchip
 PIC64-HPSC/HX MDIO controller
Message-ID: <abxQJ7XvrEVd0QOC@bby-cbu-swbuild03.eng.microchip.com>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-2-charles.perry@microchip.com>
 <1dec7b03-1ad1-4b7b-897a-5dc144dc18ee@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1dec7b03-1ad1-4b7b-897a-5dc144dc18ee@lunn.ch>
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
	TAGGED_FROM(0.00)[bounces-269628-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.952];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bby-cbu-swbuild03.eng.microchip.com:mid,microchip.com:dkim]
X-Rspamd-Queue-Id: 74F902D1BA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 05:59:36PM +0100, Andrew Lunn wrote:
> > The hardware supports an interrupt pin to signal transaction completion
> > which is not strictly needed as the software can also poll a "TRIGGER"
> > bit for this.
> 
> If the interrupt always exists, it is better to have it in DT. I
> assume it will be in the SoC .dtsi file?
> 

Yes, I have that interrupt in my .dtsi.

> Always requiring it makes the code simpler when somebody adds support
> for interrupts. You don't need all the _optional_ and dealing with it
> being missing etc.
> 

Good point, I'll add that to the required properties.

Thanks,
Charles


