Return-Path: <netdev+bounces-269626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKzHBsVPvGkXwwIAu9opvQ
	(envelope-from <netdev+bounces-269626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:34:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB8F2D1B36
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3E5B300B8DE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DE43AD515;
	Thu, 19 Mar 2026 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A5MtX2Mr"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97839C011;
	Thu, 19 Mar 2026 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948862; cv=none; b=ZzCmwdlwjYnFJnpG/OwXpQspPLlFOY+MdUPqq6ah0v8Z31hOgPwzb9ZqSsiJCGKb6GfDqKwzR4D7IkrdXkyvUT/AlvdGn0T6LXsbKzXfxwsFV4pFfCT4aX/5j4hGwHOAAwshFcB48shPJ3nlsYSkq6YCLrhlvqIcDZKS/Rv2FPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948862; c=relaxed/simple;
	bh=mjxUWXDZK80V25cp2I/yJyEECs4pfxIzuYFdqW1vVFg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ffo4yhgIYmKbWbaQAjZOyZZDJZyiapdN6OCDEh+Y9/5Ng3oO6Acxp40esr/6u9jXHBVWbTA3cnYqEd7UpKCm7JNJMSIU0hkad/lFbQmAOnekxdNjwwxh93/1iopXBN4V2hlYQag4CLlc+tUG8CsfYtN8YNBoCGIkw3Abhz5ciH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A5MtX2Mr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773948859; x=1805484859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mjxUWXDZK80V25cp2I/yJyEECs4pfxIzuYFdqW1vVFg=;
  b=A5MtX2MrrOArXdk4xeR/i6vEzJUspdUUhZ59bXCxrzUBFsrQTkPfmlFw
   SgOH+qoypFu++DeJgkDv0b7m1S708vD4yejuCh9nuiSIOP217uoVW5MSJ
   XhMhlUbsK8dKoqM5p1FRqJEahYRAeZFtCYGfiZMQfQGW1LcyoWvpBwjz2
   D6LOeS1HpRFa653zxCb7LtyYCA9bov6WnELZXK7wjFMG7d3XBPSvp/V7q
   hBpYP3k3/FXJy35efeMHB3duV+DzElOd26C4J+QqehERjf2WY1VBfFwXu
   F2STAojxGFegT8lVwes5ZM5EWk5dG0vyNsuosTVFgOmTojgvx8nf88H+C
   A==;
X-CSE-ConnectionGUID: efHJ93C/Tr6M9PTXKPS65w==
X-CSE-MsgGUID: WeADiobLRyqMaiK7W0DnDA==
X-IronPort-AV: E=Sophos;i="6.23,129,1770620400"; 
   d="scan'208";a="62585084"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 12:34:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 19 Mar 2026 12:33:47 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 19 Mar 2026 12:33:45 -0700
Date: Thu, 19 Mar 2026 12:33:43 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: mdio: add a driver for PIC64-HPSC/HX
 MDIO controller
Message-ID: <abxPl3wg5WCBY+hJ@bby-cbu-swbuild03.eng.microchip.com>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-3-charles.perry@microchip.com>
 <c1e28c56-70b7-45b8-a43d-21aca1942764@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c1e28c56-70b7-45b8-a43d-21aca1942764@lunn.ch>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-269626-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.961];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bby-cbu-swbuild03.eng.microchip.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:dkim]
X-Rspamd-Queue-Id: 1DB8F2D1B36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 06:03:09PM +0100, Andrew Lunn wrote:
> > +	u32 bus_freq;
> 
> > +	of_property_read_u32(np, "clock-frequency", &bus_freq);
> 
> clock-frequency is not required. So this can return an error, and
> leave bus_freq untouched, which is a stack variable with random
> contents.

You're right, I'll check the return value.

Thanks,
Charles

> 
> 	Andrew

