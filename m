Return-Path: <netdev+bounces-154691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5099FF784
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 10:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771233A2A8D
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 09:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF82194089;
	Thu,  2 Jan 2025 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eOTzSmPA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A71191F89;
	Thu,  2 Jan 2025 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735810672; cv=none; b=LJoHeSHJWFBL8DYoOVRAFB/r5Oxb2GD1ppUsJFd1eS83XWzTRqrDblxRGVi+ogu0IBbeRB3Q86sLQ9/vfz22DIEAOfDl3nt4TfXZ3hNoWwwE/e+FptBdsgwIAqiu2BaEkMvmKJlFokg4sKOSOmnkqAjGDP9iKp4cZjPB7Sx66vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735810672; c=relaxed/simple;
	bh=7QTF50COLjNP6hFB9EvURJ6Vz51KYnSnrE1zBDblM1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C58W50xZA3NTWjb6p/U4oyNM+mqzNiSKGWX/w0bddHyYByF1PDnBiwRj1nR0QUUMWKBw5TDLrjFVHKkw24C5UkXO6+IrMEe/k4crEqDEsj+iVwEDEPVQi+DM8ph3Qx91fbPkVCYyG0+STGm2X3AzElDupbY4PEwbdCXWDWV+E4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eOTzSmPA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xxKWJv+ffT1sOqGI0qRmYKwPB2g47K0/F/JQkScz9Nk=; b=eOTzSmPA27K32Oyd1t8ucPEezk
	MI18xWYPmWjAYwVcawWZM1ujjWN7fE4QDiOYoYT0rWx4tljBYrL5F9jA9lak9uyGkDTT7JkZwvrti
	uHynHpcIUQirSPR0U3awS3NSqZSaTOfycrT5GHEJT/kJtED4MH9w6dqxMbWnGvFi8fFxpLTWe4eHW
	erPx0LA2xZbL+WhpCb8JLwR5N9GKcvl4ZCx7wfqpEUJrDmJgLRzBxeuoqfxpe23NjcyQZGo0Qbse3
	jV8Ya4xDeklc1kQuKb7EpaNTSlAgcwBgyez76a9vdMxYz0qtTdI0uj88KW3kMLG8IPe7EczuNZR6l
	BJRoRzqQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36588)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTHe2-0001p5-2X;
	Thu, 02 Jan 2025 09:37:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTHdz-00009o-2T;
	Thu, 02 Jan 2025 09:37:31 +0000
Date: Thu, 2 Jan 2025 09:37:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	jacob.e.keller@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robert.marko@sartura.hr
Subject: Re: [PATCH net-next v4 0/9] net: lan969x: add RGMII support
Message-ID: <Z3ZeW_N5bZkRAQ_L@shell.armlinux.org.uk>
References: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
 <20241218143354.eh6iinemupxncblj@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218143354.eh6iinemupxncblj@DEN-DL-M70577>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 18, 2024 at 02:33:54PM +0000, Daniel Machon wrote:
> I would like to defer the pontential removal of sparx5_port_verify_speed()
> function to a separate series (see comments on patch 6/9).  Any chance for a
> maintainer to give the OK for that? I would like to give this series another
> spin before net-next closes. No changes in next version - except adding TB and
> RB tags.

There's no need to respin just to pick up tags that have been given -
patchwork will pick those up automatically.

I'd rather not have the current patch 6 merged, because we've had cases
in the past where stuff has been merged with "we'll fix it later" but
later doesn't seem to happen. We especially take this approach with new
kernel internal API functions - we don't merge them without a user,
because we've had too many cases where the user never appears.

We're currently at -rc5, which means -rc6 this Sunday 5th, -rc7 likely
next Sunday 12th, and probably the merge window opening on the 19th.
I think there's enough time for sparx5_port_verify_speed() to be
dropped during that window.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

