Return-Path: <netdev+bounces-267177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J1lAuz8smmQRQAAu9opvQ
	(envelope-from <netdev+bounces-267177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:50:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2661276CFA
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE0383032D52
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD673FE64F;
	Thu, 12 Mar 2026 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="G58LR6Jj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9818A3FB7CB;
	Thu, 12 Mar 2026 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337824; cv=none; b=E7wILqRpjF0PNt3Z55BVzWZMu73SxLBt+k9qbd0I7ZPJBJF5yl3vV9TleFjvjai04etWQ/NJ3Xt2IGT07ZF9+2Z9B3azCB+mF9+SRrigYbsSN7M/P3A159uIMD668YyUbvpbrIGhhH3UD8alSK2RhpPg6VSnDEADsTQvPDwb35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337824; c=relaxed/simple;
	bh=IsEThd7GsyhWEeV2/SM0iVWiMYRRDn25JFdkjXlfAAk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYQzazBMYEH6FWaIAa241EhIjQ3xFhaKU4Ux0+JYR63G3/SsPtKjiicSTkgPsTJTb8fb8p7rK5cQgBxX+m/ergVMW5xA7hHH18Ps4TExwOPy8U+Dz4tQ6oEdKm5Wa90QSWN7nicyyV8PJK8c8kXvau0qA3njH6k4FQYz5l2XTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=G58LR6Jj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773337822; x=1804873822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IsEThd7GsyhWEeV2/SM0iVWiMYRRDn25JFdkjXlfAAk=;
  b=G58LR6Jj2CUiy3RcNDPClYYFscPon17H6NVP9XYs4MX+nC4bvomvQFZ8
   9hoL5SCDTtNMiLEdXgYyLFUwtg78XibiCk2cZkBI8ScwkMn5h/+cPz/pq
   ItPo5URZElPmV6YzTJsUI89/lPURTcrBbpU9A+nX/eHk3fjI0LNZnvrVM
   tfM4cyE4d2IXQsOxc3NQShSq62s4tp9a9JYmOhSI5JLfpmEvqVodXjOgE
   hZj1oqOJ91yjy80zAfEZuhgwqy2AEDdR3+DciM7IXXzHtySDDrKu+ne/B
   yjfk8+8RMK+B7FEG8g0raKJQaN6hCtvZQXZYxUcYW+HOxE5Ac+LvusRfC
   A==;
X-CSE-ConnectionGUID: YjJgL2AVTV2CqPhndswM1g==
X-CSE-MsgGUID: RYvYDWjOT7WAb/3OggWH+w==
X-IronPort-AV: E=Sophos;i="6.23,116,1770620400"; 
   d="scan'208";a="221848534"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2026 10:50:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 12 Mar 2026 10:49:45 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 12 Mar 2026 10:49:44 -0700
Date: Thu, 12 Mar 2026 10:49:42 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: macb: set default_an_inband to true for
 SGMII
Message-ID: <abL8tgDp2x4OlGjn@bby-cbu-swbuild03.eng.microchip.com>
References: <20260312133856.2911581-1-charles.perry@microchip.com>
 <20260312-poise-parade-97e9382718da@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260312-poise-parade-97e9382718da@spud>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267177-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:email,bby-cbu-swbuild03.eng.microchip.com:mid]
X-Rspamd-Queue-Id: D2661276CFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 03:01:39PM +0000, Conor Dooley wrote:
> On Thu, Mar 12, 2026 at 06:38:55AM -0700, Charles Perry wrote:
> > Most platforms using GEM in SGMII mode use in-band autonegotiation
> > because it is on by default in GEM's 1G PCS and is always on since
> > commit e276e5e40e92 ("net: macb: Disable PCS auto-negotiation for SGMII
> > fixed-link mode"). Leave it on if possible using the "default_an_inband"
> > flag of "struct phylink_config" so that platforms that lack in-band
> > autonegotiation configurability at the PHY do not break with commit
> > 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled") which
> > will turn off in-band autoneg for non hot pluggable PHYs.
> > 
> > Once the majority of the PHY drivers that support SGMII have the
> > ->config_inband() callback, this commit could be reverted so that non
> > hot pluggable PHY use outband negotiation with macb, like its the case
> > for other MACs.
> > 
> > Fixes: 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")
> > Closes: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2ba1@spud
> 
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> 
> > Tested-by: Conor Dooley <conor@kernel.org>
> 
> Just as an FYI, you shouldn't insert tags that "certify" the quality of
> your patch that you weren't explicitly given. Reported-by/Suggested-by
> you can conjure up yourself where appropriate, but Tested-by/Acked-by/Reviewed-by
> need more care.
> 

Ok, thank you for pointing this out.

> But of course, I did test it, and it restored functionality on both
> boards that I have here, so:
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
> 

Thanks,
Charles


