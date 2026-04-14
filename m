Return-Path: <netdev+bounces-278521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPUNIb9i3mlqDgAAu9opvQ
	(envelope-from <netdev+bounces-278521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:52:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3CE3FC2A0
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FFA7300B062
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED673E8C55;
	Tue, 14 Apr 2026 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IcqO+l7J"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD703EAC77;
	Tue, 14 Apr 2026 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181742; cv=none; b=UTJn9ljNSiDNGgmEmW+25dENoMEDd25poc4xEJbbwCEXbv1WOvom7cMj3F0+SpUEK9Nl/s7CFp/pCYO5d7BD3X2TqkF4i3koKuEdhcxJ2U91clBDXQ9epC+4dhXWVHu6RFu9Bl2pTurEPztJJXwDGAQPHC/dyjp0IwojaaEkkbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181742; c=relaxed/simple;
	bh=MyOEAHk13j2Vli/fr4lMwMn/wak442eSkps0lVwOgfc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/VmP1GCsDP5GoNyHNP11N7rQTagrhXYEg2+AQKnDCbLvPzHmWDEBJlAU8x3ZomGH0KV76pp1hMYkn4oo/z9VyZdYJSJ7RQo4RB6ZdFQhC2p2n++5ifXkUQ5Msbu7Vz2xIvVojdg2Swu6QoBqTjcymXB+zdkFEaef81MOsqgMJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IcqO+l7J; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1776181739; x=1807717739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MyOEAHk13j2Vli/fr4lMwMn/wak442eSkps0lVwOgfc=;
  b=IcqO+l7JQzL9eIoFGZ/Wa01DCKiVPibmOAfBJPGdWpl+DcGuIpcMafU0
   h3tQuLsbq+bKHErBwePZKKEYkeXrPg0A9qOVwvLae78h42CWDlSEqLCqU
   3ZKBUkK4SjHcMC6Jw+g1OKpD7zOWjjU4qJTby013YZW7bN3BZ6ovgLIqs
   zIxkysUPPn9QugTuGuziXUKVXLKzSTFqBYrQSmSAda/FMyu7xf0ZyH8xQ
   pv7QJ3c9SfDT2HXVm01da7v3I3Dyx0PpS67yAlNjvdyA/NJlXUyiDSnUD
   Mt44TUwPdiB2o7RC9q/nxPqYS8Qez59xUEmuXpUqw1RmEQzRX0+jpezeG
   A==;
X-CSE-ConnectionGUID: MwNeHAjATNaMqKWLeqM2Vw==
X-CSE-MsgGUID: Nj7+nOnMR5i78T0Jzh0sAA==
X-IronPort-AV: E=Sophos;i="6.23,179,1770620400"; 
   d="scan'208";a="287458014"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 08:48:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 14 Apr 2026 08:48:34 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 14 Apr 2026 08:48:32 -0700
Date: Tue, 14 Apr 2026 08:48:31 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
CC: Charles Perry <charles.perry@microchip.com>, Conor Dooley
	<conor@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mdio: MDIO_PIC64HPSC should depend on ARCH_MICROCHIP
Message-ID: <ad5hzwdci3q3MXIJ@bby-cbu-swbuild03.eng.microchip.com>
References: <980c57efa5843733ef95459c3283aebade56f142.1776162544.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <980c57efa5843733ef95459c3283aebade56f142.1776162544.git.geert+renesas@glider.be>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,kernel.org,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278521-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,renesas];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,glider.be:email,bby-cbu-swbuild03.eng.microchip.com:mid]
X-Rspamd-Queue-Id: DF3CE3FC2A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 12:30:47PM +0200, Geert Uytterhoeven wrote:
> The PIC64-HPSC/HX MDIO interface is only present on Microchip
> PIC64-HPSC/HX SoCs.  Hence add a dependency on ARCH_MICROCHIP, to
> prevent asking the user about this driver when configuring a kernel
> without Microchip SoC support.
> 
> Fixes: f76aef980206e7c6 ("net: mdio: add a driver for PIC64-HPSC/HX MDIO controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Charles Perry <charles.perry@microchip.com>

Thanks!
Charles


