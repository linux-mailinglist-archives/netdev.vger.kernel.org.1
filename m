Return-Path: <netdev+bounces-270553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMMqNZ5CwWnPRwQAu9opvQ
	(envelope-from <netdev+bounces-270553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 14:39:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 997462F31C2
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 14:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9F1B302299F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971293ACA62;
	Mon, 23 Mar 2026 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EKnTD5XC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239353ACA4C;
	Mon, 23 Mar 2026 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273115; cv=none; b=Hh1G1NHbXhS6z3UWoIwlR2oQ8mO5/zEoaD92ivQtdz37VbEXvFAaeoLN7foG7ssYpZw0NnUcfeLthnctLdGHfCOUm2OPrJZHPTJTY9PQxHBfXBYDXPR7lQPE56HS9RSrS8T1NajCQD0PPVyZLDmwQ8y2Aev/DneQMA6t/ft/P40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273115; c=relaxed/simple;
	bh=EE1BARFzWjcO6wyIQt06l7M7MH4JAkFjS4YaQxNjKZI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFrgxUHmjKlaALWwdBXTCVXMfOu+dY3loS8mXtfTnbwf5iuZfQJzF9Ygh9Ug5RWZa0gHlx0ckmu227Rp186rI8XJfXkVsutReIxgkD75pFLaA+HSysetI9H1QGNuia22MOgImyu2/Ox4YalKfibLQ1RdfCWy8ghyuqY/rfDTdJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EKnTD5XC; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774273114; x=1805809114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EE1BARFzWjcO6wyIQt06l7M7MH4JAkFjS4YaQxNjKZI=;
  b=EKnTD5XCZqgI4L7mTmwfO2NqYE5ZCaKG9e5FJQFUd0/f0xHNqRAbuMnX
   +VV8j8oHjZDIozbG479BExZXOwPgdN4bpkbU+zJpkOBR8y35Lxup+7C8T
   Io6MhjGvUbo87SSlz3IcdUfovP7BQp7vVN6wrzaTjfuHf3gowbEJ8geqI
   CiRxTvxb5+oor/f6x+V8eCHOk1apnTfaKg5WuxKjIusLqSCJ6e8xaoK8/
   Z5IV2rcSkn1MUREG33T18jLDNlivcSFjTt8tpKkwg6soYXo4GuGdDMuKN
   yTllux6e/2IFeYwuAOCczqk9lSmElEPQW9rO+NeBjfbqOcQOQDEtofkvO
   Q==;
X-CSE-ConnectionGUID: NU3MCjPHTT6Ew3YQEdpaLQ==
X-CSE-MsgGUID: fLRfFT78RGuXM6z3aYurDg==
X-IronPort-AV: E=Sophos;i="6.23,137,1770620400"; 
   d="scan'208";a="55474404"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2026 06:38:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 23 Mar 2026 06:38:08 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Mon, 23 Mar 2026 06:38:08 -0700
Date: Mon, 23 Mar 2026 06:38:06 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: document Microchip
 PIC64-HPSC/HX MDIO controller
Message-ID: <acFCPnia+riDwvJJ@bby-cbu-swbuild03.eng.microchip.com>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-2-charles.perry@microchip.com>
 <20260318-suspense-arming-fe118c3f15c6@spud>
 <absXy5Qmd/iHWofD@bby-cbu-swbuild03.eng.microchip.com>
 <20260319-spearfish-styling-9918d2d2e537@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260319-spearfish-styling-9918d2d2e537@spud>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-270553-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:dkim,bby-cbu-swbuild03.eng.microchip.com:mid]
X-Rspamd-Queue-Id: 997462F31C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 01:35:52AM +0000, Conor Dooley wrote:
> On Wed, Mar 18, 2026 at 02:23:23PM -0700, Charles Perry wrote:
> > > > +
> > > > +  clock-frequency: true
> > > 
> > > Does this genuinely have no constraints?
> > 
> > It's going to divide the input frequency by 2 to 512 (the prescaler is 8
> > bit long), so assuming an input clock of 156.25 MHz, the bounds are 305KHz
> > to 78MHz. The standard is 2.5MHz.
> > 
> > I can add a maximum and minimum here since I do have some validation on
> > this in the driver which will bail out if this is out of bound.

Hello Conor,

I have second doubt about this. The minimum and maximum depend on the input
clock frequency which might change if someone uses a different crystal or
clock config. So for that reason, I thinks it's better to not specify the
bounds, because there's no way to know for sure what they when building the
device tree.

I will however add a "default: 2500000" following some discussions with
Andrew Lunn.


Thanks,
Charles

> 
> 
> That sounds like a good idea, thanks.
> 
> pw-bot: changes-requested
> 
> Cheers,
> Conor.



