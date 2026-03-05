Return-Path: <netdev+bounces-264401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKr9Mp+LqWl3/AAAu9opvQ
	(envelope-from <netdev+bounces-264401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:56:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C3E212DDB
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E415B30200DB
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 13:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBB33A5E7D;
	Thu,  5 Mar 2026 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dQ0rhJnC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B21396B6E;
	Thu,  5 Mar 2026 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719002; cv=none; b=fqS/AXMtWYKIuuIifqfYKe98qSGlD1H/I6jCay3WFwbDoFCz3GyajK7dxHBxDolViGFVUj+HJP3hafIrKd8C6VBI6fd+0uTs4J1bwEnxjdL834GhFhnfg0+YLzO4niiFTWy84sRlF9yjytcd66ZfCE7I8Qmm3MmzIaKSRX7dCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719002; c=relaxed/simple;
	bh=4UwnXqz+hYh+BC00sFH7WQ8UZ8eB34WeTo3IcRW6h0I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvmag9ZKucTyo0pS/9IyRvl2kyDj8Ev4tDY3VawkUjcj2xUfTigzUotGoq/F45zEGtrDbsjiSZ5HlPBdIEDLTvfRfO00W4eQagaeC8dBY9BYmqC8EQzhkRiIZjqbcOGb5Op0wobTao2i/sH/lAPrqmzOECB8mxxw4jYz+bDrSqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dQ0rhJnC; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772719001; x=1804255001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4UwnXqz+hYh+BC00sFH7WQ8UZ8eB34WeTo3IcRW6h0I=;
  b=dQ0rhJnC1SotISorLlS3Mt5vQXRFMsn2dU+OQbWZ6gfqnBnOJqKQaFZO
   JrB6JyC26Vx1gDiyepnoF8PLS9aYD8b5An1Tfb06IL2ZKwdHqhN5KSwaT
   fL0/065bzDcF4VYoulgvFbzsduPCh4Gp3ifLsSi2FroSVje3arrdbYrGJ
   Yprhv0FAoFyJmu2iewydtHyKomtzhYI8gvAeXkMqOB7+3Kx/MnWTtcdtm
   TVGBMpjutE3fPXrxmbnf8Azq0fj/d1L1h9iydWEcsUM4M3HQpupcrLRzO
   eX7fEKdsRHBKVBeMHnRRZmA1sxjrQ/CFQFW+QruOVPlRCjTVoCTz0MP5k
   w==;
X-CSE-ConnectionGUID: o2R6k7DETgy+YK0hkUQ4eg==
X-CSE-MsgGUID: 7Pt58m7bQOyqO/xFDF+kbQ==
X-IronPort-AV: E=Sophos;i="6.23,103,1770620400"; 
   d="scan'208";a="221537042"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 06:56:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Mar 2026 06:56:17 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 5 Mar 2026 06:56:17 -0700
Date: Thu, 5 Mar 2026 05:56:15 -0800
From: Charles Perry <charles.perry@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: <netdev@vger.kernel.org>, Sean Anderson <sean.anderson@linux.dev>,
	"Nicolas Ferre" <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>,
	<charles.perry@microchip.com>
Subject: Re: [PATCH net-next v2 1/3] net: macb: fix SGMII with inband aneg
 disabled
Message-ID: <aamLf63OfJ5RH69v@bby-cbu-swbuild03.eng.microchip.com>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
 <20260304-unvented-crinkle-37f0bfd03541@spud>
 <aaht0/XpUCz+58bz@bby-cbu-swbuild03.eng.microchip.com>
 <20260305-backlit-epilogue-62139ae694a6@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260305-backlit-epilogue-62139ae694a6@spud>
X-Rspamd-Queue-Id: D2C3E212DDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264401-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,microchip.com:dkim,bby-cbu-swbuild03.eng.microchip.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:42:19AM +0000, Conor Dooley wrote:
> On Wed, Mar 04, 2026 at 09:37:23AM -0800, Charles Perry wrote:
> > On Wed, Mar 04, 2026 at 04:23:30PM +0000, Conor Dooley wrote:
> > 
> > Are you able to check register 23, bit 13 of your PHY by any chance? Maybe
> > with the mdio/mii commands in U-Boot if you have that.
> 
> "mii read addr 23" returns 0660 for both PHYs in U-Boot.

Oh, I think you fell into a trap of U-Boot's mii command.

The arguments are always in hex even if you dont prepend "0x".

What "mii read 8 23" did is most likely read register 0x23, masked with
0x1f because clause 22 has only 32 registers. So it read register 0x3 which
is the device identifier 2 register: 0x0660.

The exact command should be "mii read 8 0x17", "mii read 9 0x17".

Sorry for that.

Thanks,
Charles


