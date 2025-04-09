Return-Path: <netdev+bounces-180663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD448A82103
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F92D1B6028D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6F425A338;
	Wed,  9 Apr 2025 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LH27FwtY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA912CDAE;
	Wed,  9 Apr 2025 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190919; cv=none; b=adQzWQmhnzZ5msEmzPGfNE6JXy+R2csndwcahbgiEzB45RmvqD1rqOuX0StpFGWNgGzMq85WtBGCyUlYsIWkrNBvg5rkkBJyFe3D/6rNjF7o4LS5m8c/IvzYe4VZ0Onn59L1XK6jh/mZH+O1d/EwaOj9gsOZ2Xu5BpBqGf1u9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190919; c=relaxed/simple;
	bh=9V07LzGaas5AZ+oux1lgxy/80UvkgLFtP9F6ZYTTbws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiMEz+gMIdc7qO5dYGoXLz7SI9MdCWXHq5wbVaSfAYXB9R8uoHR+cz8I9XJvQp01jxF5EGxvT/STfNuS55VAn8O5qBub+5+LaXWb57LcSayJJdS6giG/rZ3uXwEMKzPz/ECEjsLnXkImJjOAYt7Z/bl7j3qwbSPgtO7XNIz0zNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LH27FwtY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nXxv0ft02xQmL5xjLiDXgZUpWE6PV4IMsxVkdLC+K5Y=; b=LH27FwtYmQeaz34BpW6bsmsbC1
	GT2UqhP3QQWnqSP6HcQ/JnPWW4E7KNXCpKstwRjMazUfCQREHzgX657mcPNM6kwCCO2RNpODg3I+p
	iN61GByQ5lreandT+U6icXzKkIBvToGleFbZljJSAJXBgm3EyoFqcJH7AxBuEt17S2uVDt7Bo0YrX
	3XHMlgTYKdNV39o2QaQQz10wGmHk/VbNx7F2lNF8ISfusmlAaQZAahnRzBPzUlYinBcFfbI0Of1rn
	3Le4AZ5DnQ/iTO/D3W9JquCvJu0K3D1CLERc9/zoP6Znt8isBVKQmPDa/kA+/FKJJ18cCeAKOX8Uu
	jYViuU4A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49584)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2RjN-0000JX-2y;
	Wed, 09 Apr 2025 10:28:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2RjK-0002SD-1Q;
	Wed, 09 Apr 2025 10:28:22 +0100
Date: Wed, 9 Apr 2025 10:28:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?utf-8?B?QmVo4oia4oirbg==?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Message-ID: <Z_Y9tvN7rk9YJTPN@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
 <Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
 <20250407182028.75531758@kmaincent-XPS-13-7390>
 <Z_P-K7mEEH6ProlC@shell.armlinux.org.uk>
 <20250407183914.4ec135c8@kmaincent-XPS-13-7390>
 <Z_WJO9g5Al1Yr_LX@shell.armlinux.org.uk>
 <20250409103130.43ab4179@kmaincent-XPS-13-7390>
 <Z_Yxb6-qclDSWk01@shell.armlinux.org.uk>
 <20250409083835.pwtqkwalqkwgfeol@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409083835.pwtqkwalqkwgfeol@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 09, 2025 at 11:38:35AM +0300, Vladimir Oltean wrote:
> On Wed, Apr 09, 2025 at 09:35:59AM +0100, Russell King (Oracle) wrote:
> > On Wed, Apr 09, 2025 at 10:31:30AM +0200, Kory Maincent wrote:
> > > On Tue, 8 Apr 2025 21:38:19 +0100
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > > 
> > > > On Mon, Apr 07, 2025 at 06:39:14PM +0200, Kory Maincent wrote:
> > > > > On Mon, 7 Apr 2025 17:32:43 +0100
> > > > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > > > > > I'm preferring to my emails in connection with:
> > > > > > 
> > > > > > https://lore.kernel.org/r/ZzTMhGDoi3WcY6MR@shell.armlinux.org.uk
> > > > > > 
> > > > > > when I tested your work last time, it seemed that what was merged hadn't
> > > > > > even been tested. In the last email, you said you'd look into it, but I
> > > > > > didn't hear anything further. Have the problems I reported been
> > > > > > addressed?  
> > > > > 
> > > > > It wasn't merged it was 19th version and it worked and was tested, but not
> > > > > with the best development design. I have replied to you that I will do some
> > > > > change in v20 to address this.
> > > > > https://lore.kernel.org/all/20241113171443.697ac278@kmaincent-XPS-13-7390/
> > > > > 
> > > > > It gets finally merged in v21.  
> > > > 
> > > > Okay, so I'm pleased to report that this now works on the Macchiatobin:
> > > > 
> > > > where phc 2 is the mvpp2 clock, and phc 0 is the PHY.
> > > 
> > > Great, thank you for the testing!
> > > 
> > > > 
> > > > # ethtool -T eth2
> > > > Time stamping parameters for eth2:
> > > > Capabilities:
> > > >         hardware-transmit
> > > >         software-transmit
> > > >         hardware-receive
> > > >         software-receive
> > > >         software-system-clock
> > > >         hardware-raw-clock
> > > > PTP Hardware Clock: 2
> > > > Hardware Transmit Timestamp Modes:
> > > >         off
> > > >         on
> > > >         onestep-sync
> > > >         onestep-p2p
> > > > Hardware Receive Filter Modes:
> > > >         none
> > > >         all
> > > > 
> > > > So I guess that means that by default it's using PHC 2, and thus using
> > > > the MVPP2 PTP implementation - which is good, it means that when we add
> > > > Marvell PHY support, this won't switch to the PHY implementation.
> > > 
> > > Yes.
> > > 
> > > > 
> > > > Now, testing ethtool:
> > > > 
> > > > $ ./ethtool --get-hwtimestamp-cfg eth2
> > > > netlink error: Operation not supported
> > > > 
> > > > Using ynl:
> > > > 
> > > > # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --dump
> > > > tsconfig-get --json '{"header":{"dev-name":"eth2"}}' []
> > > > 
> > > > So, It's better, something still isn't correct as there's no
> > > > configuration. Maybe mvpp2 needs updating first? If that's the case,
> > > > then we're not yet in a position to merge PHY PTP support.
> > > 
> > > Indeed mvpp2 has not been update to support the ndo_hwtstamp_get/set NDOs.
> > > Vlad had made some work to update all net drivers to these NDOs but he never
> > > send it mainline:
> > > https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v9
> > > 
> > > I have already try to ping him on this but without success.
> > > Vlad any idea on when you could send your series upstream?
> > 
> > Right, and that means that the kernel is not yet ready to support
> > Marvell PHY PTP, because all the pre-requisits to avoid breaking
> > mvpp2 have not yet been merged.
> > 
> > So that's a NAK on this series from me.
> > 
> > I'd have thought this would be obvious given my well known stance
> > on why I haven't merged Marvell PHY PTP support before.
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 
> I will try to update and submit that patch set over the course of this
> weekend.

Thanks. Friday is really the last day for me for an uncertain period
thereafter where I won't be able to do any further testing.

I don't run PTP on my network as it's IMHO not as good as NTP with the
hardware I have. It's also been five years since I last had something
setup, which was when I was working on Marvell PHY support, All the
knowledge I had back then for PTP support has been "swapped out" into
/dev/null. I don't even remember which machines I was using, and thus
have no idea if they're even still connected to the network.

As this has already been blocked on this for five years, I don't think
it's unreasonable that it takes longer, so please don't feel that you
need to get them done by Friday.

Just be aware that I won't be able to test again for an uncertain
period thereafter.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

