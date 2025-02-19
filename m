Return-Path: <netdev+bounces-167780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7894A3C3BB
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BEC176101
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EDB1F3BA8;
	Wed, 19 Feb 2025 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tpQMT88H"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F127A1C5F1B;
	Wed, 19 Feb 2025 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979386; cv=none; b=u/YccaqJaP1fFp2J0zyy+HJTQl1Bc6Pp1YLoDVqVJxYkdhy+l8qzgRTBmvj9W4r2ulOWI07BMSHH6UoC+Yju+nAkRlMjgsZk4BtgtNFClI57wnqLFMht24QZHp1UfrVY54cXy59wU8Woc7XXpWmE5Zu71q8vmo2nuBnyDhwwq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979386; c=relaxed/simple;
	bh=UQd9t6UsQrfF5wMikVxDB1+W41oQr9vt2xglcSS7NbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smvgqs4z8IacUC42xF5TVSTzadOBKKbyGIzHqd7D4O6vHsYsP4uU5QKQGbvJMFG+LxqJJMjwZincLvijj0gGcy7Iq5rz1tYVivPSWL23myJKtxfKtsVOWC1RZZuRRmKnYmS4MSqYl5e60CX3AHtx5Jfd6EQE5h6E8A8T/sHMI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tpQMT88H; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HSoYtRU58Qk6GUrOu57f7XD5z3CMZTVbbGuHsdBc9/A=; b=tpQMT88HBc9KZjpSc1kETY8tkr
	a26Es9sHMI7yCFiMlInV4tviOCdWxYnC7eKpgzcjEUBZ79x2efvpopcaXGi0JVjN4nc9kcFowqyXa
	ob7Bs73b8AmUHWlmB8g4KoATqAnkSSFWg8quG7ANaqhDhhAquzseUcjrcfJslbpxG43krhhi6lybS
	qLPZVVynYNSNLEZ5K/k0VK1iDEidsLndBH1G9ZuLTWH6CsqEd6mFd+Li2kXNEpLnC5rFJ/YQVDMlK
	uYSjkoc8eQw1krlUTochiHmek+xwPXyamdfPvzbIbr8HnN7qphj5bFs1P/BsetOL4nNd/eWgUVvHQ
	bNDiSdog==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46126)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tkm7P-0006B7-1a;
	Wed, 19 Feb 2025 15:36:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tkm7L-0008TH-23;
	Wed, 19 Feb 2025 15:36:07 +0000
Date: Wed, 19 Feb 2025 15:36:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next 9/9] net: stmmac: convert to phylink managed EEE
 support
Message-ID: <Z7X6Z8yLMsQ1wa2D@shell.armlinux.org.uk>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
 <E1tYAEG-0014QH-9O@rmk-PC.armlinux.org.uk>
 <6ab08068-7d70-4616-8e88-b6915cbf7b1d@nvidia.com>
 <Z63Zbaf_4Rt57sox@shell.armlinux.org.uk>
 <Z63e-aFlvKMfqNBj@shell.armlinux.org.uk>
 <05987b45-94b9-4744-a90d-9812cf3566d9@nvidia.com>
 <Z68nSJqVxcnCc1YB@shell.armlinux.org.uk>
 <86fae995-1700-420b-8d84-33ab1e1f6353@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86fae995-1700-420b-8d84-33ab1e1f6353@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 19, 2025 at 02:01:34PM +0000, Jon Hunter wrote:
> 
> On 14/02/2025 11:21, Russell King (Oracle) wrote:
> > On Fri, Feb 14, 2025 at 10:58:55AM +0000, Jon Hunter wrote:
> > > Thanks for the feedback. So ...
> > > 
> > > 1. I can confirm that suspend works if I disable EEE via ethtool
> > > 2. Prior to this change I do see phy_eee_rx_clock_stop being called
> > >     to enable the clock resuming from suspend, but after this change
> > >     it is not.
> > > 
> > > Prior to this change I see (note the prints around 389-392 are when
> > > we resume from suspend) ...
> > > 
> > > [    4.654454] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 0
> > 
> > This is a bug in phylink - it shouldn't have been calling
> > phy_eee_rx_clock_stop() where a MAC doesn't support phylink managed EEE.
> > 
> > > [    4.723123] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
> > > [    7.629652] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
> > 
> > Presumably, this is when the link comes up before suspend, so the PHY
> > has been configured to allow the RX clock to be stopped prior to suspend
> > 
> > > [  389.086185] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
> > > [  392.863744] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
> > 
> > Presumably, as this is after resume, this is again when the link comes
> > up (that's the only time that stmmac calls phy_eee_rx_clock_stop().)
> > 
> > > After this change I see ...
> > > 
> > > [    4.644614] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
> > > [    4.679224] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
> > > [  191.219828] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
> > 
> > To me, this looks no different - the PHY was configured for clock stop
> > before suspending in both cases.
> > 
> > However, something else to verify with the old code - after boot and the
> > link comes up (so you get the second phy_eee_rx_clock_stop() at 7s),
> > try unplugging the link and re-plugging it. Then try suspending.
> 
> I still need to try this but I am still not back to the office to get to this.
>  > The point of this test is to verify whether the PHY ignores changes to
> > the RX clock stop configuration while the link is up.
> > 
> > 
> > 
> > The next stage is to instrument dwmac4_set_eee_mode(),
> > dwmac4_reset_eee_mode() and dwmac4_set_eee_lpi_entry_timer() to print
> > the final register values in each function vs dwmac4_set_lpi_mode() in
> > the new code. Also, I think instrumenting stmmac_common_interrupt() to
> > print a message when we get either CORE_IRQ_TX_PATH_IN_LPI_MODE or
> > CORE_IRQ_TX_PATH_EXIT_LPI_MODE indicating a change in LPI state would
> > be a good idea.
> > 
> > I'd like to see how this all ties up with suspend, resume, link up
> > and down events, so please don't trim the log so much.
> 
> I have been testing on top of v6.14-rc2 which does not have
> dwmac4_set_lpi_mode(). However, instrumenting the other functions,
> for a bad case I see ...
> 
> [  477.494226] PM: suspend entry (deep)
> [  477.501869] Filesystems sync: 0.006 seconds
> [  477.504518] Freezing user space processes
> [  477.509067] Freezing user space processes completed (elapsed 0.001 seconds)
> [  477.514770] OOM killer disabled.
> [  477.517940] Freezing remaining freezable tasks
> [  477.523449] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [  477.566870] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
> [  477.586423] dwc-eth-dwmac 2490000.ethernet eth0: disable EEE
> [  477.592052] dwmac4_set_eee_lpi_entry_timer: entered
> [  477.596997] dwmac4_set_eee_lpi_entry_timer: GMAC4_LPI_CTRL_STATUS 0x0
> [  477.680193] dwc-eth-dwmac 2490000.ethernet eth0: Link is Down

This tells me WoL is not enabled, and thus phylink_suspend() did a
phylink_stop() which took the link administratively down and disabled
LPI at the MAC. The actual physical link on the media may still be up
at this point, and the remote end may still signal LPI to the local
PHY.

...system suspends and resumes...
> [  477.876778] CPU5: Booted secondary processor 0x0000000103 [0x411fd073]
> [  477.883556] CPU5 is up

stmmac_resume() gets called here, which will call into phylink_resume()
and, because WoL wasn't used at suspend time, will call phylink_start()
which immediately prints:

> [  477.985628] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode

and then it allows the phylink resolver to run in a separate workqueue.
The output from the phylink resolver thread, I'll label as "^WQ".
Messages from the thread that called stmmac_resume() I'll labell with
"^RES".

> [  477.993771] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_mac_enable_tx_lpi: tx_lpi_timer 1000000
	^WQ

At this point, the workqueue has called mac_link_up() and this indicates
that that method has completed and it's now calling mac_enable_tx_lpi().
In other words, the transmitter and receiver have been enabled here!
This is key...

> [  478.171396] dwmac4: Master AXI performs any burst length
	^RES

dwmac4_dma_axi(), which is called from stmmac_init_dma_engine() which
then goes on to call stmmac_reset(). As noted above, however, the
MAC has had its transmitter and receiver enabled at this point, so
hitting the hardware with a reset probably undoes all that.
stmmac_init_dma_engine() is called from stmmac_hw_setup() and
stmmac_resume() _after_ calling phylink_resume().

> [  478.174480] dwc-eth-dwmac 2490000.ethernet eth0: No Safety Features support found
	^RES

Printed by stmmac_safety_feat_configuration() which is called from
stmmac_hw_setup().

> [  478.181934] dwc-eth-dwmac 2490000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
	^RES

Printed by stmmac_init_ptp() called from stmmac_hw_setup().

> [  478.202977] dwmac4_set_eee_lpi_entry_timer: entered
	^WQ
> [  478.207918] dwmac4_set_eee_lpi_entry_timer: GMAC4_LPI_CTRL_STATUS 0xf4240
	^WQ
> [  478.287646] dwc-eth-dwmac 2490000.ethernet eth0: Energy-Efficient Ethernet initialized
	^WQ
> [  478.295538] dwc-eth-dwmac 2490000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
	^WQ

So clearly the phylink resolver is racing with the rest of the stmmac
resume path - which doesn't surprise me in the least. I believe I raised
the fact that calling phylink_resume() before the hardware was ready to
handle link-up is a bad idea precisely because of races like this.

The reason stmmac does this is because of it's quirk that it needs the
receive clock from the PHY in order for stmmac_reset() to work.

> For a good case I see ...
> 
> [   28.548472] PM: suspend entry (deep)
> [   28.560503] Filesystems sync: 0.010 seconds
> [   28.563622] Freezing user space processes
> [   28.567838] Freezing user space processes completed (elapsed 0.001 seconds)
> [   28.573380] OOM killer disabled.
> [   28.576563] Freezing remaining freezable tasks
> [   28.582100] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [   28.627180] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
> [   28.646770] dwc-eth-dwmac 2490000.ethernet eth0: Link is Down

Same as above...

...system suspends and resumes...
> [   29.099556] CPU5: Booted secondary processor 0x0000000103 [0x411fd073]
> [   29.106351] CPU5 is up
> [   29.218549] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
	^RES
> [   29.234190] dwmac4: Master AXI performs any burst length
	^RES
> [   29.237263] dwc-eth-dwmac 2490000.ethernet eth0: No Safety Features support found
	^RES
> [   29.244732] dwc-eth-dwmac 2490000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
	^RES
> [   29.306981] Restarting tasks ... done.
> [   29.311423] VDDIO_SDMMC3_AP: voltage operation not allowed
> [   29.314095] random: crng reseeded on system resumption
> [   29.321404] PM: suspend exit
> [   29.370286] VDDIO_SDMMC3_AP: voltage operation not allowed
> [   29.429655] VDDIO_SDMMC3_AP: voltage operation not allowed
> [   29.496567] VDDIO_SDMMC3_AP: voltage operation not allowed
> [   32.968855] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
	^WQ
> [   32.974779] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_mac_link_up: tx_lpi_timer 1000000
	^WQ
> [   32.988755] dwc-eth-dwmac 2490000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
	^WQ

So here, phylink_resolve() runs later.

I think if you run this same test with an earlier kernel, you'll get
much the same random behaviour, maybe with different weightings on
"success" and "failure" because of course the code has changed - but
only because that's caused a change in timings of the already present
race.

> The more I have been testing, the more I feel that this is timing
> related. In good cases, I see the MAC link coming up well after the
> PHY. Even with your change I did see suspend work on occassion and
> when it does I see ...
> 
> [   79.775977] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
> [   79.784196] dwmac4: Master AXI performs any burst length
> [   79.787280] dwc-eth-dwmac 2490000.ethernet eth0: No Safety Features support found
> [   79.794736] dwc-eth-dwmac 2490000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
> [   79.816642] usb-conn-gpio 3520000.padctl:ports:usb2-0:connector: repeated role: device
> [   79.820437] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
> [   79.854481] OOM killer enabled.
> [   79.855372] Restarting tasks ... done.
> [   79.859460] VDDIO_SDMMC3_AP: voltage operation not allowed
> [   79.861297] random: crng reseeded on system resumption
> [   79.869773] PM: suspend exit
> [   79.914909] VDDIO_SDMMC3_AP: voltage operation not allowed
> [   79.974322] VDDIO_SDMMC3_AP: voltage operation not allowed
> [   80.041236] VDDIO_SDMMC3_AP: voltage operation not allowed
> [   83.547730] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_mac_enable_tx_lpi: tx_lpi_timer 1000000
> [   83.566859] dwmac4_set_eee_lpi_entry_timer: entered
> [   83.571782] dwmac4_set_eee_lpi_entry_timer: GMAC4_LPI_CTRL_STATUS 0xf4240
> [   83.651520] dwc-eth-dwmac 2490000.ethernet eth0: Energy-Efficient Ethernet initialized
> [   83.659425] dwc-eth-dwmac 2490000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
> 
> On a good case, the stmmac_mac_enable_tx_lpi call always happens
> much later. It seems that after this change it is more often
> that the link is coming up sooner and I guess probably too soon.
> May be we were getting lucky before?

I think this is pure lottery.

> Anyway, I made the following change for testing and this is
> working ...
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b34ebb916b89..44187e230a1e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7906,16 +7906,6 @@ int stmmac_resume(struct device *dev)
>                         return ret;
>         }
> -       rtnl_lock();
> -       if (device_may_wakeup(priv->device) && priv->plat->pmt) {
> -               phylink_resume(priv->phylink);
> -       } else {
> -               phylink_resume(priv->phylink);
> -               if (device_may_wakeup(priv->device))
> -                       phylink_speed_up(priv->phylink);
> -       }
> -       rtnl_unlock();
> -
>         rtnl_lock();
>         mutex_lock(&priv->lock);
> @@ -7930,6 +7920,13 @@ int stmmac_resume(struct device *dev)
>         stmmac_restore_hw_vlan_rx_fltr(priv, ndev, priv->hw);
> +       if (device_may_wakeup(priv->device) && priv->plat->pmt) {
> +               phylink_resume(priv->phylink);
> +       } else {
> +               phylink_resume(priv->phylink);
> +               if (device_may_wakeup(priv->device))
> +                       phylink_speed_up(priv->phylink);
> +       }
>         stmmac_enable_all_queues(priv);
>         stmmac_enable_all_dma_irq(priv);
> 
> I noticed that in __stmmac_open() the phylink_start() is
> called after stmmac_hw_setup and stmmac_init_coalesce, where
> as in stmmac_resume, phylink_resume() is called before these.
> I am not saying that this is correct in any way, but seems
> to indicate that the PHY is coming up too soon (at least for
> this device). I have ran 100 suspend iterations with the above
> and I have not seen any failures.
> 
> Let me know if you have any thoughts on this.

With my phylink-maintainer hat on, this is definitely the correct
solution - maybe even moving the phylink_resume() call later.
phylink_resume() should only be called when the driver is prepared
to handle and cope with an immediate call to the mac_link_up()
method, and it's clear that its current placement is such that the
driver isn't prepared for that.

However... see:

36d18b5664ef ("net: stmmac: start phylink instance before stmmac_hw_setup()")

but I also questioned this in:

https://lore.kernel.org/netdev/20210903080147.GS22278@shell.armlinux.org.uk/

see the bottom of that email starting "While reading stmmac_resume(), I
have to question the placement of this code block:". The response was:

"There is a story here, SNPS EQOS IP need PHY provides RXC clock for
MAC's receive logic, so we need phylink_start() to bring PHY link up,
that make PHY resume back, PHY could stop RXC clock when in suspended
state. This is the reason why calling phylink_start() before re-config
MAC."

However, in 21d9ba5bc551 ("net: phylink: add PHY_F_RXC_ALWAYS_ON to PHY
dev flags") and associated patches, I added a way that phylib can be
told that the MAC requires the RXC at all times.

Romain Gantois arranged for this flag to always be set for stmmac in
commit 58329b03a595 ("net: stmmac: Signal to PHY/PCS drivers to keep RX
clock on"), which will pass PHY_F_RXC_ALWAYS_ON to the PHY driver.
Whether the PHY driver honours this flag or not depends on which
driver is used.

So, my preference would be to move phylink_resume() later, removing
the race condition. If there's any regressions, then we need to
_properly_ solve them by ensuring that the PHY keeps the RX clock
running by honouring PHY_F_RXC_ALWAYS_ON. That's going to need
everyone to test their stmmac platforms to find all the cases that
need fixing...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

