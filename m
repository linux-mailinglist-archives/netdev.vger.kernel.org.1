Return-Path: <netdev+bounces-114928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA192944B25
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE081C2146D
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93A719F460;
	Thu,  1 Aug 2024 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1u5ggvQk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651216D9A8;
	Thu,  1 Aug 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514717; cv=none; b=FIC5e41hlxY+Iim1GpvB2DN7SVcPwFf1iRLUnNtl/lfUtqcPs8QkY7N/UYQtvRjBbliiciSVnWZJ0Qf6Rxl+kxMEmIv/VsvdfmXAfAT6g9nfmhm8i+Mo/WQQmQpbohhoK9cs1ANZmotM0OyATiJpuob2yMiieEeAZ2OyF4gqqyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514717; c=relaxed/simple;
	bh=LDwo6GVqWa/fMrKei3jSRz8/DP92yapme6+4Dyf05Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLZDU9woV2lUAGboatg5R9bEabQTtEha+Y+r5QjURNdEyuCfa9c9ZljaKpXYvZwItQXe2wJZHlQBOOElM/ZMbvmz2MmvK0pMIH2qXzSTAavAfJQFjS3zXnl236XqEDfbNLqRCpBJc4hOCk587lSiVEgqDOjm/aFLOn/XghGdlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1u5ggvQk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=joj3wlE+8kLlOIDEtqDoGzBKrGN3QgIw67ksAUCM460=; b=1u5ggvQkWSApQIv38XoXUlDawO
	RliSRywn3ZKN9sCFJ9j6Y5esrScVkTUiRgJ2XdSaQtbF7JAYtPj4BPjmn9f9a2XiplKtOjfswGcSL
	4M1OhozsZWQKzS4SSdNc50fmEx+S9hdub8V8cchRY8IGB5GY1fYY5R/AO7WuhmyhG0w4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZUlG-003lw1-5J; Thu, 01 Aug 2024 14:18:26 +0200
Date: Thu, 1 Aug 2024 14:18:26 +0200
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
Message-ID: <ffd2d708-60fb-4049-8c1b-fcfe43a78d57@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-6-shaojijie@huawei.com>
 <0e497b6f-7ab0-4a43-afc6-c5ad205aa624@lunn.ch>
 <e8a56b1f-f3f3-4081-8c0d-4b829e659780@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a56b1f-f3f3-4081-8c0d-4b829e659780@huawei.com>

On Thu, Aug 01, 2024 at 05:13:33PM +0800, Jijie Shao wrote:
> 
> on 2024/8/1 8:51, Andrew Lunn wrote:
> > > +static int hbg_net_set_mac_address(struct net_device *dev, void *addr)
> > > +{
> > > +	struct hbg_priv *priv = netdev_priv(dev);
> > > +	u8 *mac_addr;
> > > +
> > > +	mac_addr = ((struct sockaddr *)addr)->sa_data;
> > > +	if (ether_addr_equal(dev->dev_addr, mac_addr))
> > > +		return 0;
> > > +
> > > +	if (!is_valid_ether_addr(mac_addr))
> > > +		return -EADDRNOTAVAIL;
> > How does the core pass you an invalid MAC address?
> 
> According to my test,
> in the 6.4 rc4 kernel version, invalid mac address is allowed to be configured.
> An error is reported only when ifconfig ethx up.

Ah, interesting.

I see a test in __dev_open(), which is what you are saying here. But i
would also expect a test in rtnetlink, or maybe dev_set_mac_address().
We don't want every driver having to repeat this test in their
.ndo_set_mac_address, when it could be done once in the core.

	Andrew

