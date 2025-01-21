Return-Path: <netdev+bounces-159999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1472EA17AEE
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 11:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437A616466F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624F01B3920;
	Tue, 21 Jan 2025 10:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N33ZDkvv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870645979;
	Tue, 21 Jan 2025 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453758; cv=none; b=ll94qip6fR2gDj4zaFUKav2gokuhyw6sQCL1Y6QN80YLZ0jPc5PPbBIDYlRc7b0uvwinlzFgM+5Ef2pJbl60KGGTAcEKb0bwvT5lM8KQepBt0fC7bIBVEKV98Gt5bM0u2c4iSqa8D0YI8bna01ZN8FaOR2TMmQsEoGQTymXMB2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453758; c=relaxed/simple;
	bh=KXSPEkUIF0JzVtdBjndel3ro9adPxzNR8DNm/ag8xvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qI054vML6xECxXon0V4REeUoL9ajxHmxWPvVCravGHoVmtgJ6tN71i4r+seg2x0MNFQVYbL13jx0h2f+KFgWvTQ+59bOMgMHXHTUvhCG5PrMMp9nh+kOxdRlRHIKfBEiXn5pmm9r6o0z/QU6tqMtvYdYNUhBEkRcbHcGwFR/A2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N33ZDkvv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nXijuf6z20+j5FjanvTi+20Qon2gmNQyAEVAl4cnE/0=; b=N33ZDkvv5UdKeCAe2f8lPwxcKC
	TGTibZ3nbfWsiyjjxUkdLrUOHCfs7DUK7uHcgZYeHoDSH/upVGZNIvFUmWjIW0ABTsOn/+cXmSo8O
	x2dz55e2AOsQ73Kw02neVAqZB6xG7FgiB4Yqli3pTt5kqaIul3+xuWjGGkdh0nnIeEVgHKqpC3rrE
	tIIdEvRORumWvuuLRQPg1EzofCBHkuC8BpXrq3JyEoy8CYM0AcTQ0HnVy01Yafv54pdtTmnw4qZmJ
	2R0GovUjPXfcVc24ifVy+WOycZ5Wexz+cJmi5VzPK1kSLBeluP0Zo1jo/pSiprAUEzUjAe03jyISH
	5V6F/YUw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40054)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1taB5Y-00074A-3D;
	Tue, 21 Jan 2025 10:02:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1taB5U-0003o0-2I;
	Tue, 21 Jan 2025 10:02:24 +0000
Date: Tue, 21 Jan 2025 10:02:24 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3] net: phy: Fix suspicious rcu_dereference
 usage
Message-ID: <Z49wsE4A94PGVes1@shell.armlinux.org.uk>
References: <20250120141926.1290763-1-kory.maincent@bootlin.com>
 <20250120111228.6bd61673@kernel.org>
 <20250121103845.6e135477@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121103845.6e135477@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 21, 2025 at 10:38:45AM +0100, Kory Maincent wrote:
> On Mon, 20 Jan 2025 11:12:28 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Mon, 20 Jan 2025 15:19:25 +0100 Kory Maincent wrote:
> > > The path reported to not having RTNL lock acquired is the suspend path of
> > > the ravb MAC driver. Without this fix we got this warning:  
> > 
> > I maintain that ravb is buggy, plenty of drivers take rtnl_lock 
> > from the .suspend callback. We need _some_ write protection here,
> > the patch as is only silences a legitimate warning.
> 
> Indeed if the suspend path is buggy we should fix it. Still there is lots of
> ethernet drivers calling phy_disconnect without rtnl (IIUC) if probe return an
> error or in the remove path. What should we do about it?

They could trigger the same warning, although I think they would be
relatively safe because register_netdev() hasn't been called, and thus
nothing that the netdev provides should be used. (If it can be used, as
the driver has not completed initialisation, then it's probably racy
anyway.)

I don't think throwing ASSERT_RTNL() into phy_detach() will do anything
to solve this. If the RCU warning doesn't trigger (because phy_detach()
only gets called on error which practically never happens) then
ASSERT_RTNL() isn't going to trigger either. Warnings in functions will
only work when they're called in a context that will trigger the
warning!

So, I think it's something that can only be addressed by reviewing
drivers and patching.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

