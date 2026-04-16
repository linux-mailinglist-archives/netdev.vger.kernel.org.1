Return-Path: <netdev+bounces-279000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCsrDci+4GnQlQAAu9opvQ
	(envelope-from <netdev+bounces-279000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:49:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C0A40D0A5
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 314DA3011168
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6C637BE93;
	Thu, 16 Apr 2026 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hS+zERdx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C937E2FF
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776336582; cv=none; b=Ejg5iJFZ0PTodPHsrsNSZReT9GNwF1Tosd07o/wvEFYg1Dj3x55EWur2WOTiGq6stZmB/fFKgO3S/JiSG/jRD46gMy0VOWDlw+f5J2MG4CXno73qo4+Re0DMuwgHOb4LkW68yDId5LUSKz/Cm1/B5txJdrn8GMJQevvlHQjHUK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776336582; c=relaxed/simple;
	bh=Ym4lYSZIrhwxg5ZbteYROPayQT8vptaheDLqdakxvNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv+/zegRd5dOWLLZXYQFFmRjuASMk88fSWRjXmEFnZajWOhXFx+0XfccFvpPKwqG/jMMVkVNgGgTj2Kb1WhFkrvGFTIYDnH6Wy7GZUbO4HGS6nYObne8INMM2Jnsu8Wkyy6ssrDcb5ZsKQIbk6MmAzBuIf7g+BA+hcFLZKfpRb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hS+zERdx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iTecCTUOjCT2Rh+35c/jBL17rubrlvWXt7j7t5fyE4A=; b=hS+zERdx785E7w8JuVhIqIUjqo
	rfTzzmGwWX/PzAGKN9P/mq5ofpIaokW6Naxsd3Ouod8CcSBoL8YWAadvltn2AtDOzWPioFgM3W23v
	Q5V2vsauwwB7RZ2YexHer3u5vyh7euHUKU2rzvgV9PdVtbEJLLuJicgrkCOfdvGGVSY9FQEmuT38O
	81dAcc0BC83k8bFEmZOvAW7fKXhSVgEb7U0L1T5zR/uJpFRUP321srKZKF/YHgCOLflE8d09edYbj
	fBA/wHJ3iQWgZOYuYhy15KCeJUdJ6s+4ZH/aBdCVzE0WtuP0TEUB7ihUZzfk17611Ex3gsTduFa57
	pydTVpKg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60888)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wDKHp-0000000035z-1EzG;
	Thu, 16 Apr 2026 11:49:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wDKHl-0000000038b-3rco;
	Thu, 16 Apr 2026 11:49:25 +0100
Date: Thu, 16 Apr 2026 11:49:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/6] net: stmmac: move PHY handling out of
 __stmmac_open()/release()
Message-ID: <aeC-tc2CooYDoBok@shell.armlinux.org.uk>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
 <8409022.LvFx2qVVIh@steina-w>
 <ad-LtOBrKREM1tCk@shell.armlinux.org.uk>
 <5987484.DvuYhMxLoT@steina-w>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5987484.DvuYhMxLoT@steina-w>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279000-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,foss.st.com,davemloft.net,google.com,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.140];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: C4C0A40D0A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 08:20:13AM +0200, Alexander Stein wrote:
> Am Mittwoch, 15. April 2026, 14:59:32 CEST schrieb Russell King (Oracle):
> > On Wed, Apr 15, 2026 at 08:08:40AM +0200, Alexander Stein wrote:
> > > Hi,
> > > 
> > > Am Dienstag, 23. September 2025, 13:26:19 CEST schrieb Russell King (Oracle):
> > > > Move the PHY attachment/detachment from the network driver out of
> > > > __stmmac_open() and __stmmac_release() into stmmac_open() and
> > > > stmmac_release() where these actions will only happen when the
> > > > interface is administratively brought up or down. It does not make
> > > > sense to detach and re-attach the PHY during a change of MTU.
> > > 
> > > Sorry for coming up now. But I recently noticed this commit breaks changing
> > > the MTU on i.MX8MP. Once I simply change the MTU I run into some DMA error:
> > > $ ip link set dev end1 mtu 1400
> > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-0
> > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-1
> > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-2
> > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-3
> > > imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-4
> > > imx-dwmac 30bf0000.ethernet end1: Link is Down
> > > imx-dwmac 30bf0000.ethernet end1: Failed to reset the dma
> > > imx-dwmac 30bf0000.ethernet end1: stmmac_hw_setup: DMA engine initialization failed
> > 
> > This basically means that a clock is missing. Please provide more
> > information:
> > 
> > - what kernel version are you using?
> 
> Currently I am using v6.18.22.
> $ ethtool -i end1
> driver: st_gmac
> version: 6.18.22
> firmware-version: 
> expansion-rom-version: 
> bus-info: 30bf0000.ethernet
> supports-statistics: yes
> supports-test: no
> supports-eeprom-access: no
> supports-register-dump: yes
> supports-priv-flags: no
> 
> > - has EEE been negotiated?
> 
> No. It is marked as not supported
> 
> $ ethtool --show-eee end1
> EEE settings for end1:
>         EEE status: not supported
> 
> > - does the problem persist when EEE is disabled?
> 
> As EEE is not supported the problem occurs even with EEE disabled.
> 
> > - which PHY is attached to stmmac?
> 
> It is a TI DP83867.
> 
> imx-dwmac 30bf0000.ethernet eth1: PHY [stmmac-1:03] driver [TI DP83867] (irq=136)
> 
> > - which PHY interface mode is being used to connect the PHY to stmmac?
> 
> For this interface
> > phy-mode = "rgmii-id";
> is set.
> 
> In case it is helpful. My platform is arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
> Thanks for assisting. If there a further questions, don't hesitate to ask.

Thanks.

So, as best I can determine at the moment, we end up with the following
sequence:

stmmac_change_mtu()
 __stmmac_release()
  phylink_stop()
   phy_stop()
    phy->state = PHY_HALTED
    _phy_state_machine() returns PHY_STATE_WORK_SUSPEND
    _phy_state_machine_post_work()
     phy_suspend()
      genphy_suspend()
       phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN)

With the DP83867, this causes most of the PHY to be powered down, thus
stopping the clocks, and this causes the stmmac reset to time out.

Prior to this commit, we would have called phylink_disconnect_phy()
immediately after phylink_stop(), but I can see nothing that would
be affected by this change there (since that also calls
phy_suspend(), but as the PHY is already suspended, this becomes a
no-op.)

However, __stmmac_open() would have called stmmac_init_phy(), which
would reattach the PHY. This would have called phy_init_hw(), 
resetting the PHY, and phy_resume() which would ensure that the
PDOWN bit is clear - thus clocks would be running.

As a hack, please can you try calling phylink_prepare_resume()
between the __stmmac_release() and __stmmac_open() in
stmmac_change_mtu(). This should resume the PHY, thus restoring the
clocks necessary for stmmac to reset.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

