Return-Path: <netdev+bounces-263274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL78Jpj7pmk7bgAAu9opvQ
	(envelope-from <netdev+bounces-263274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:17:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DA51F2588
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51A623025E0E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D95481655;
	Tue,  3 Mar 2026 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tm7jhcaD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE595480978;
	Tue,  3 Mar 2026 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550791; cv=none; b=LaG23/3IwsMX/Az6HGXvzzL80aMhY6+0vMmZbrr3XifFkv1HCMGvMarw8G2E3/Qn8dJGpm/fCVY/cvHMz0e5koMAz525jJBoUJywRm88oPdg8AdKPHRw+a4g/UBovNb1t1uAZwomu2sGNI4MJse1IbvMnEQbGIrwNBJhJaw1j74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550791; c=relaxed/simple;
	bh=ZUuBdXlabAKnNnIZ3Gl8Tm4xd9RNOR5maKUH0bsKVbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKJOzd1TVCHXC2nCg8sCEVlu+eXgGEmiLqZuwyRur3jHGEsmb7APaxNfe22WXdtSHEWHlHMrQSqNOdYpblETGk9IcIdaIimx8k45iJcb+/nqHUvXvHy3gRiA+5nINsF4vAVI3YFlCHizuK6Y7vxJAO+Gl5UZo0HikhC6mATMdrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tm7jhcaD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rSM3jEZffCw3A4oMljmCNtPxUoaBFLdJTlI4x5TlvQM=; b=tm7jhcaDdh9zeIBPtz6c+Il+8a
	Zk3vnR9L7eL8Q4f4X7FCo3R0j+x8RqlDKPw1ad6eeV4gaosRV0lB+8NcdhzczrAAushj3oq0VMsl6
	Kj2e0sLArVNSevmBEkE2unbjE/3VOR1f2n4FM0NdYP58ahNiL4VhcwWNGowap1jivHb9rZF4kQV/W
	39/CKoUpv5MgkaJoBPlZfj37JF0X34hYD9zQEEqeQMM0wplbPU3J4dvpW0UxsqQtqWNd2AZgHV/Rn
	iG3qeNxOlbTpN6Wf6tgNqxc9jpdP/GuNbMN8GVeOZuDwOgXh3ui4zpEKxA5xMNUDuSWAvqb9wJMct
	ng3R3eFQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45204)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vxRQf-000000005Fi-2EmF;
	Tue, 03 Mar 2026 15:12:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vxRQe-0000000071z-1F3j;
	Tue, 03 Mar 2026 15:12:56 +0000
Date: Tue, 3 Mar 2026 15:12:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: sfp: manage receiver and transmitter
 regulators
Message-ID: <aab6eAOi9ZT8TjDm@shell.armlinux.org.uk>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <20260303-sfp-regulators-v1-2-7101ae34cb84@bootlin.com>
 <e7a1ab5e-c34d-4ca5-93eb-4f5bcfacdb40@sirena.org.uk>
 <2344035.iZASKD2KPV@fw-rgant>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2344035.iZASKD2KPV@fw-rgant>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: A9DA51F2588
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263274-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.150];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 03:40:54PM +0100, Romain Gantois wrote:
> Hello Mark,
> 
> On Tuesday, 3 March 2026 15:22:40 CET Mark Brown wrote:
> > On Tue, Mar 03, 2026 at 02:54:27PM +0100, Romain Gantois wrote:
> > > If phandles to receiver and/or transmitter regulators for an SFP device
> > > are
> > > found, enable them at probe time.
> > 
> > The driver should unconditionally request whatever power the device
> > needs.
> 
> Ok, I'll use devm_regulator_get_enable() instead then.

What Mark is suggesting will break existing users. So, I'm afraid we
can't proceed with this proposal. Sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

