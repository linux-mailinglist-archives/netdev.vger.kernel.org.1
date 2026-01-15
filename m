Return-Path: <netdev+bounces-250301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82546D28294
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0698A300094B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DB931A7EE;
	Thu, 15 Jan 2026 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vBmfavXA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5C312807;
	Thu, 15 Jan 2026 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768506057; cv=none; b=PbTUGJb1vPavr6ajSWpZcv5srPLl6U7CgwNpcfW9XuGAs8TUItMzeORus2Aa0AsFhYKmNEPnum6xHINOeYEc7LYIFkZahj6WHCG+sAtoenc3KMNoCEO4cC7jjjLqM/umDRlkM9qG/Kj5ep/vK2I+8TbYt5T+8uucKHDtQZWTq3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768506057; c=relaxed/simple;
	bh=jkLwMh0+s8F8/4KKUY4lQr01Nkc+QMk9WY4RS6aqE/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enNOlh5zKFo26gNWJoZaSeK9811ah59zOjOcKnGJZFRISX9QYeeu5NVVPvbtF3mPVhgUYXys4w1EDUJBswH1EWcz7DCvePITO9Trd9/XC4sYfWsn5ksNC30/IZAkyz/w/rLWsIHtB09gmwRTBBy5Yz44oiYDk2yc7mIzACmFMn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vBmfavXA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4x0cWJUel0J1tULjHpUGDfg62j6P8cwyjilUsV/2zFQ=; b=vBmfavXAC/f/xKs89DcuqXY013
	JysHxq1ejIiEja9MOTvyBMM1UDi1xx02NiciYucw2eb7wbT48SmdSSq3Bl2xc1svonPDlI54zmKPX
	ClC+q0+6LQet87sbkevf10XTC0hHJS/KH2qFTMvau7vdkiuAVK8+dOp9uD+qxBmtv3yf2v+nTHM3V
	AhiDGjTqeUyDtMk2qUkuHRoTNq/l9/FYATofG6L3f27j2MxiPKESWUublVwhPs+uBT/4NTi1wdMk2
	z93RZbHDXqeYjoMYIQc8XEp+hilstWZipKOob7RodUAaDDWQJVboQ/hlgMNStAK0O9vLv6u5mn+mV
	i5hqxdAA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50804)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vgTCy-000000001di-3wlW;
	Thu, 15 Jan 2026 19:40:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vgTCt-000000002v6-0sek;
	Thu, 15 Jan 2026 19:40:35 +0000
Date: Thu, 15 Jan 2026 19:40:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tao Wang <tao03.wang@horizon.auto>
Cc: alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out
 after resume
Message-ID: <aWlCs5lksxfgL6Gi@shell.armlinux.org.uk>
References: <aWd9WUUGhSU5tWcn@shell.armlinux.org.uk>
 <20260115070853.116260-1-tao03.wang@horizon.auto>
 <aWjY7m96e87cBLUZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWjY7m96e87cBLUZ@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 15, 2026 at 12:09:18PM +0000, Russell King (Oracle) wrote:
> On Thu, Jan 15, 2026 at 03:08:53PM +0800, Tao Wang wrote:
> > > While I agree with the change for stmmac_tso_xmit(), please explain why
> > > the change in stmmac_free_tx_buffer() is necessary.
> > >
> > > It seems to me that if this is missing in stmmac_free_tx_buffer(), the
> > > driver should have more problems than just TSO.
> > 
> > The change in stmmac_free_tx_buffer() is intended to be generic for all
> > users of last_segment, not only for the TSO path.
> 
> However, transmit is a hotpath, so work needs to be minimised for good
> performance. We don't want anything that is unnecessary in these paths.
> 
> If we always explicitly set .last_segment when adding any packet to the
> ring, then there is absolutely no need to also do so when freeing them.
> 
> Also, I think there's a similar issue with .is_jumbo.
> 
> So, I think it would make more sense to have some helpers for setting
> up the tx_skbuff_dma entry. Maybe something like the below? I'll see
> if I can measure the performance impact of this later today, but I
> can't guarantee I'll get to that.
> 
> The idea here is to ensure that all members with the exception of
> xsk_meta are fully initialised when an entry is populated.
> 
> I haven't removed anything in the tx_q->tx_skbuff_dma entry release
> path yet, but with this in place, we should be able to eliminate the
> clearance of these in stmmac_tx_clean() and stmmac_free_tx_buffer().
> 
> Note that the driver assumes setting .buf to zero means the entry is
> cleared. dma_addr_t is a cookie which is device specific, and zero
> may be a valid DMA cookie. Only DMA_MAPPING_ERROR is invalid, and
> can be assumed to hold any meaning in driver code. So that needs
> fixing as well.

I've just run iperf3 in both directions with the kernel I had on the
board (based on 6.18.0-rc7-net-next+), and stmmac really isn't looking
particularly great - by that I mean, iperf3 *failed* spectacularly.

First, running in normal mode (stmmac transmitting, x86 receiving)
it's only capable of 210Mbps, which is nowhere near line rate.

However, when running iperf3 in reverse mode, it filled the stmmac's
receive queue, which then started spewing PAUSE frames at a rate of
knots, flooding the network, and causing the entire network to stop.
It never recovered without rebooting.

Trying again on 6.19.0-rc4-net-next+,

stmmac transmitting shows the same dire performance:

[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  24.2 MBytes   203 Mbits/sec    0    230 KBytes
[  5]   1.00-2.00   sec  25.5 MBytes   214 Mbits/sec    0    230 KBytes
[  5]   2.00-3.00   sec  25.0 MBytes   210 Mbits/sec    0    230 KBytes
[  5]   3.00-4.00   sec  25.5 MBytes   214 Mbits/sec    0    230 KBytes
[  5]   4.00-5.00   sec  25.1 MBytes   211 Mbits/sec    0    230 KBytes
[  5]   5.00-6.00   sec  25.1 MBytes   211 Mbits/sec    0    230 KBytes
[  5]   6.00-7.00   sec  25.7 MBytes   215 Mbits/sec    0    230 KBytes
[  5]   7.00-8.00   sec  25.2 MBytes   212 Mbits/sec    0    230 KBytes
[  5]   8.00-9.00   sec  25.3 MBytes   212 Mbits/sec    0    346 KBytes
[  5]   9.00-10.00  sec  25.4 MBytes   213 Mbits/sec    0    346 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   252 MBytes   211 Mbits/sec    0             sender
[  5]   0.00-10.02  sec   250 MBytes   210 Mbits/sec                  receiver

stmmac receiving shows the same problem:

[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  64.1 MBytes   537 Mbits/sec
[  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec
^C[  5]   9.00-9.43   sec  0.00 Bytes  0.00 bits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-9.43   sec  0.00 Bytes  0.00 bits/sec                  sender
[  5]   0.00-9.43   sec  64.1 MBytes  57.0 Mbits/sec                  receiver
iperf3: interrupt - the client has terminated

and it's now spewing PAUSE frames again.

The RXQ 0 debug register shows:

Value at address 0x02490d38: 0x002b0020

bits 29:16 (PRXQ = 43) is the number of packets in the RX queue
bits 5:4 (RXQSTS = 10) shows that the internal RX queue is above the
  flow control activate threshold.

The RXQ 0 operating mode register shows:

Value at address 0x02490d30: 0x0ff1c4e0

bits 29:20 (RQS = 15) indicates that the receive queue size is
  (255 + 1) * 256 = 65536 bytes (which is what hw feature 1 reports)

bits 16:14 (RFD = 7) indicates the threshold for deactivating flow
  control

bits 10:8 (RFA = 4) indicates the threshold for activing flow control

Disabling EHFC (bit 7, enable hardware flow control) stops the flood.

Looking at the receive descriptor ring, all the entries are marked
with RDES3_OWN | RDES3_BUFFER1_VALID_ADDR - so there are free ring
entries, but the hardware is not transferring the queued packets.

Looking at the channel 0 status register, it's indicating RBU
(receive buffer unavailable.)

This gets more weird.

Channel 0 Rx descriptor tail pointer register:
Value at address 0x02491128: 0xffffee30
Channel 0 current application receive descriptor register:
Value at address 0x0249114c: 0xffffee30

Receive queue descriptor:
227 [0x0000007fffffee30]: 0xfee00040 0x7f 0x0 0x81000000

I've tried writing to the tail pointer register (both the current
value and the next descriptor value), this doesn't seem to change
anything.

I've tried clearing SR in DMA_CHAN_RX_CONTROL() and setting it,
again no change.

So, it looks like the receive hardware has permanently stalled,
needing at minimum a soft reset of the entire stmmac core to
recover it.

I think I'm going to have to declare stmmac receive on dwmac4 to
be buggy at the moment, as I can't get to the bottom of what's
causing this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

