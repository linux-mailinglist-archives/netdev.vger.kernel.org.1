Return-Path: <netdev+bounces-250371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E31D9D29757
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DACB930ACE4C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6617D3093DB;
	Fri, 16 Jan 2026 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jXaMz/WH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0ED30DD24;
	Fri, 16 Jan 2026 00:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524664; cv=none; b=QWJba1mOrIItiEpxnMnxqCK8lnYF5BYbpMNc5zP4Zu6PKxA8zs8++YpEJ9g0/KymsiDVuytmg7eoU2WuugPJ5snH40AMePjgtSgSmCc3UEXcijpBsiOz7t14ivFpNlyY+TEvWetDc4kxKtilKEAj/ZPhYRzASpPA/JQeNtL1R6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524664; c=relaxed/simple;
	bh=QbyhLsls3nlhnuRW/mDW0pGBKiyS7I0v8Nzq9vaYBE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrWN857kawl6Ak0huPHGRXG77aJJyYIJAK2EG8PqZcQ9XbiSWTww+jEpYsssyeh6SSfOlxu9IYdM9GHNf80TeLNye7QnNmQbmr4uxJz3P+Q+BjfqkedJMr0AbAQn00GkiVX6/TCLxUaooLSoqG8RcZn5qDB9PaomX+2Bacl1gpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jXaMz/WH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Epl5JNNsyOzzTO/l/0nsP04mMOHrR9SHTj1QJq8FS+4=; b=jXaMz/WHD8am70A2hLxr07gInt
	HrCU+7GUGqhD2xowWXBJcnWJRmEsAfNvNdNjxiRVoKeijqKpq/LTjBYZS3CiFhjbsamhEY1zxahPA
	JyuThUqQloco+cntBJ2mwqEFszLE2wXDSyp1R9j675vsEMDH9IyHeqxFwH0nMQDJiXBZ+lfMu91R4
	ROZohKtHhpndXyDsyG2McDCSimsLbcNg62LpJVrBn7Bxp/7qbKJHgQbhHQCgP1EFK5el9iIFDIPse
	18YgiEbz/6FJMjrtMWY+DsGw3nZ8h9glvh6uoHuaMZxAW2CT4KcnXIVqsihFivCYKlaH5M9y1xanZ
	ow3Fy1tA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49026)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vgY2y-000000001mr-1ChY;
	Fri, 16 Jan 2026 00:50:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vgY2t-00000000382-1MBD;
	Fri, 16 Jan 2026 00:50:35 +0000
Date: Fri, 16 Jan 2026 00:50:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Tao Wang <tao03.wang@horizon.auto>, alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out after
 resume
Message-ID: <aWmLWxVEBmFSVjvF@shell.armlinux.org.uk>
References: <aWd9WUUGhSU5tWcn@shell.armlinux.org.uk>
 <20260115070853.116260-1-tao03.wang@horizon.auto>
 <aWjY7m96e87cBLUZ@shell.armlinux.org.uk>
 <aWlCs5lksxfgL6Gi@shell.armlinux.org.uk>
 <6a946edc-297e-469a-8d91-80430d88f3e5@bootlin.com>
 <51859704-57fd-4913-b09d-9ac58a57f185@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51859704-57fd-4913-b09d-9ac58a57f185@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 15, 2026 at 10:35:26PM +0100, Maxime Chevallier wrote:
> Hi again,
> 
> On 15/01/2026 22:04, Maxime Chevallier wrote:
> > Hi,
> > 
> >>
> >> I've just run iperf3 in both directions with the kernel I had on the
> >> board (based on 6.18.0-rc7-net-next+), and stmmac really isn't looking
> >> particularly great - by that I mean, iperf3 *failed* spectacularly.
> >>
> >> First, running in normal mode (stmmac transmitting, x86 receiving)
> >> it's only capable of 210Mbps, which is nowhere near line rate.
> >>
> >> However, when running iperf3 in reverse mode, it filled the stmmac's
> >> receive queue, which then started spewing PAUSE frames at a rate of
> >> knots, flooding the network, and causing the entire network to stop.
> >> It never recovered without rebooting.
> 
>  [...]
> 
> > Heh, I was able to reproduce something similar on imx8mp, that has an
> > imx-dwmac (dwmac 4/5 according to dmesg) :
> > 
> > DUT to x86
> > 
> > Connecting to host 192.168.2.1, port 5201
> > [  5] local 192.168.2.13 port 54744 connected to 192.168.2.1 port 5201
> > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > [  5]   0.00-1.00   sec  0.00 Bytes  0.00 bits/sec    2   1.41 KBytes
> > [  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
> > 
> > x86 to DUT :
> > 
> > Reverse mode, remote host 192.168.2.1 is sending
> > [  5] local 192.168.2.13 port 47050 connected to 192.168.2.1 port 5201
> > [ ID] Interval           Transfer     Bitrate
> > [  5]   0.00-1.00   sec   112 MBytes   935 Mbits/sec
> > [  5]   1.00-2.00   sec   112 MBytes   936 Mbits/sec
> > [  5]   2.00-3.00   sec   112 MBytes   936 Mbits/sec
> > 
> > Nothing as bas as what you face, but there's defintely something going
> > on there. "good" news is that it worked in v6.19-rc1, I have a bisect
> > ongoing.
> > 
> > I'll update once I have homed-in on something.
> > 
> > Maxime
> 
> So the bisect results are in, at least for the problem I noticed. It's
> not certain yet this is the same problem as Russell, and maybe not the
> same as Tao Wang as well...
> 
> The culprit commit is :
> 
> commit 8409495bf6c907a5bc9632464dbdd8fb619f9ceb (HEAD)
> Author: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Date:   Thu Jan 8 17:36:40 2026 +0000
> 
>     net: stmmac: cores: remove many xxx_SHIFT definitions
>     
>     We have many xxx_SHIFT definitions along side their corresponding
>     xxx_MASK definitions for the various cores. Manually using the
>     shift and mask can be error prone, as shown with the dwmac4 RXFSTS
>     fix patch.
>     
>     Convert sites that use xxx_SHIFT and xxx_MASK directly to use
>     FIELD_GET(), FIELD_PREP(), and u32_replace_bits() as appropriate.
>     
>     Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>     Link: https://patch.msgid.link/E1vdtw8-00000002Gtu-0Hyu@rmk-PC.armlinux.org.uk
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Lore link :
> 
> https://lore.kernel.org/netdev/E1vdtw8-00000002Gtu-0Hyu@rmk-PC.armlinux.org.uk/
> 
> I confirm that iperf3 works perfectly in both directions before this commit,
> and I get 0 bits/s when running "iperf3 -c my_host" on the DUT that has stmmac.
> 
> Looks like something happened while cleaning-up the macros for the various
> definitions.

Thanks for finding the blame.

A few other interesting things... I have an old 6.14 kernel on the
platform, and that gives what I deem to be good transmit performance.
Receive performance is low, but it doesn't fail.

I wrote a shell script to use devmem2 to dump all the stmmac registers.
These seem more significant on the face of it... but I'm working it out
as I write this email:

-Value at address 0x02490010: 0x00010008
+Value at address 0x02490010: 0x00080008
-Value at address 0x02490014: 0x20020008
+Value at address 0x02490014: 0x20000008
-Value at address 0x02490018: 0x00000001
+Value at address 0x02490018: 0x04000001

These are GMAC_HASH_TAB()

-Value at address 0x02490060: 0x001a0000
+Value at address 0x02490060: 0x00120000

VLAN_ONCL, bit is VLAN_CSVL, changed in commit:
c657f86106c8 net: stmmac: vlan: Disable 802.1AD tag insertion offload.

-Value at address 0x024900c0: 0x01000000
+Value at address 0x024900c0: 0x05000000

GMAC_PMT - bit 26, part of the RWKPTR[4:0] bitfield, read-only.

-Value at address 0x02490d30: 0x0ff1c4a0
+Value at address 0x02490d30: 0x0ff1c4e0

MTL_CHAN_RX_OP_MODE(0) - bit 6 is different, MTL_OP_MODE_DIS_TCP_EF.

This is a change from:
fe4042797651 net: stmmac: dwmac4: stop hardware from dropping checksum-error packets

-Value at address 0x02491104: 0x00101011
+Value at address 0x02491104: 0x00001011

DMA_CHAN_TX_CONTROL(0) - but this is significant.
In dwmac4_dma_init_tx_chan(), we have:

-       value = value | (txpbl << DMA_BUS_MODE_PBL_SHIFT);
+       value = value | FIELD_PREP(DMA_BUS_MODE_PBL, txpbl);

and the corresponding change in the header file:

 /* DMA SYS Bus Mode bitmap */
 #define DMA_BUS_MODE_SPH               BIT(24)
 #define DMA_BUS_MODE_PBL               BIT(16)
-#define DMA_BUS_MODE_PBL_SHIFT         16
-#define DMA_BUS_MODE_RPBL_SHIFT                16
+#define DMA_BUS_MODE_RPBL_MASK         GENMASK(21, 16)
 #define DMA_BUS_MODE_MB                        BIT(14)
 #define DMA_BUS_MODE_FB                        BIT(0)

The combination of DMA_BUS_MODE_PBL and DMA_BUS_MODE_PBL_SHIFT leads
one to believe that this is a single bit field, whereas there
is another overlapping field called RPBL that is wider. RPBL gets
used for DMA_CHAN_RX_CONTROL, whereas PBL gets used for
DMA_CHAN_TX_CONTROL.

txpbl for the Jetson Xavier NX board (tegra194) is 16:

arch/arm64/boot/dts/nvidia/tegra194.dtsi:                       snps,txpbl = <16>;

which is txpbl. 16 doesn't fit into a single bit. The header file
was wrong.

According to non-Tegra documentation (the closest I have for
dwmac4 is stm32mp151), this field is called TXPBL[5:0] covering
bits 21:16 of this register, and is the transmit burst length.

However, while this may explain the transmit slowdown because it's
on the transmit side, it doesn't explain the receive problem.

-Value at address 0x0249113c: 0x000d07c0
+Value at address 0x0249113c: 0x000507c0

DMA_CHAN_SLOT_CTRL_STATUS(0) - bit 19 RSN[3:0] bit 3, readonly.

With the TXPBL thing fixed, for transmit I now get:

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1003 MBytes   841 Mbits/sec    0             sender
[  5]   0.00-10.01  sec  1002 MBytes   839 Mbits/sec                  receiver

which is way better, but receive still fails, with a storm of
PAUSE, with RBU set.

Transmit fix (eventually):
https://lore.kernel.org/r/E1vgY1k-00000003vOC-0Z1H@rmk-PC.armlinux.org.uk

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

