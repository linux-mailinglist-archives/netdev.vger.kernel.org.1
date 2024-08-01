Return-Path: <netdev+bounces-114939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD93944B6C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF831C233FA
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB00194AE6;
	Thu,  1 Aug 2024 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sudF5UQ/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F17187FFD;
	Thu,  1 Aug 2024 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515818; cv=none; b=U2HDsQiw++iwfV3rCOLuYkV+ztiOyY+N7LqtTjJMxFT/9Wp7TRqHZqJPEUTNQs4EktGg+2lfqpqz9rRcWPlvVtd7HEObw4/14crdHoEPDME3sT3zje7lnDFO3hKIPPJkWMRMylCWcwA537WC/ksYtWWODEOEldIgyobTvPcPUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515818; c=relaxed/simple;
	bh=8y68VOu62Sd+8tUqQsxtJirVhBoDa7wrm3eIzLEYWdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb8Iw1etTcE6XarQNiuPGV7PYuK/EQVi+aqSx8gcwTmCiD7kNsT6IHjru0Wx0lR0+/QrLRFLFiyDb1uFhlE/DFSozTUsVXPbuxJeiYuiQWfEoT3vCKDOjp6N6d4X240DzZvohsaalMEyJQ1ZNvQPGuifUu5WsnO04LgYYWC6ZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sudF5UQ/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=l6VKD7CEKUflJtsFY+ry8bBY+bZfcfkQ/rtFhvXEGno=; b=sudF5UQ/ATZEqEsORqsB48JYd3
	eEFE6Ab2Ua06XdZhe1Fd7yNtxeHKlcYsRnw4kZjtgzc7rZ7/sjBr0NNk0Y7Whe7Gf0Vx4K3DR7Ngj
	jy/whLW31gj2CuPST1s6wJL5dKzrCI/WG1Bnc7t4XwXdYtbouttKRnjZ7WpczUmh6P30=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZV33-003m4h-Rc; Thu, 01 Aug 2024 14:36:49 +0200
Date: Thu, 1 Aug 2024 14:36:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 05/10] net: hibmcge: Implement some .ndo
 functions
Message-ID: <e57e3748-6ee5-42d5-8715-ec652fc6310f@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-6-shaojijie@huawei.com>
 <0e497b6f-7ab0-4a43-afc6-c5ad205aa624@lunn.ch>
 <e8a56b1f-f3f3-4081-8c0d-4b829e659780@huawei.com>
 <ffd2d708-60fb-4049-8c1b-fcfe43a78d57@lunn.ch>
 <d5e9f50a-c3bd-4071-9de8-cc22cd0f5cfc@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e9f50a-c3bd-4071-9de8-cc22cd0f5cfc@huawei.com>

On Thu, Aug 01, 2024 at 08:33:38PM +0800, Jijie Shao wrote:
> 
> on 2024/8/1 20:18, Andrew Lunn wrote:
> > On Thu, Aug 01, 2024 at 05:13:33PM +0800, Jijie Shao wrote:
> > > on 2024/8/1 8:51, Andrew Lunn wrote:
> > > > > +static int hbg_net_set_mac_address(struct net_device *dev, void *addr)
> > > > > +{
> > > > > +	struct hbg_priv *priv = netdev_priv(dev);
> > > > > +	u8 *mac_addr;
> > > > > +
> > > > > +	mac_addr = ((struct sockaddr *)addr)->sa_data;
> > > > > +	if (ether_addr_equal(dev->dev_addr, mac_addr))
> > > > > +		return 0;
> > > > > +
> > > > > +	if (!is_valid_ether_addr(mac_addr))
> > > > > +		return -EADDRNOTAVAIL;
> > > > How does the core pass you an invalid MAC address?
> > > According to my test,
> > > in the 6.4 rc4 kernel version, invalid mac address is allowed to be configured.
> > > An error is reported only when ifconfig ethx up.
> > Ah, interesting.
> > 
> > I see a test in __dev_open(), which is what you are saying here. But i
> > would also expect a test in rtnetlink, or maybe dev_set_mac_address().
> > We don't want every driver having to repeat this test in their
> > .ndo_set_mac_address, when it could be done once in the core.
> > 
> > 	Andrew
> 
> Hi:
> I did the following test on my device:
> 
> insmod hibmcge.ko
> hibmcge: no symbol version for module_layout
> hibmcge: loading out-of-tree module taints kernel.
> hibmcge: module verification failed: signature and/or required key missing - tainting kernel
> hibmcge 0000:83:00.1: enabling device (0140 -> 0142)
> Generic PHY mii-0000:83:00.1:02: attached PHY driver (mii_bus:phy_addr=mii-0000:83:00.1:02, irq=POLL)
> hibmcge 0000:83:00.1 enp131s0f1: renamed from eth0
> IPv6: ADDRCONF(NETDEV_CHANGE): enp131s0f1: link becomes ready
> hibmcge 0000:83:00.1: link up!
> 
> ifconfig enp131s0f1 hw ether FF:FF:FF:FF:FF:FF
> 
> ip a
> 6: enp131s0f1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
>     link/ether ff:ff:ff:ff:ff:ff brd ff:ff:ff:ff:ff:ff permaddr 08:02:00:00:08:08
> ifconfig enp131s0f1 up
> ifconfig enp131s0f1 down up
> SIOCSIFFLAGS: Cannot assign requested address
> hibmcge 0000:83:00.1: link down!
> 
> uname -a
> Linux localhost.localdomain 6.4.0+ #1 SMP Fri Mar 15 14:44:20 CST 2024 aarch64 aarch64 aarch64 GNU/Linux
> 
> 
> 
> So I'm not sure what's wrong. I also implemented ndo_validate_addr by eth_validate_addr.

I agree. I don't see a test. Please could you include a patch to
dev_set_mac_address() to validate the address there before calling
into the driver. It might also be worth a search to see if anybody
else has tried this before, and failed. There might be a good reason
you cannot validate it.

	Andrew

