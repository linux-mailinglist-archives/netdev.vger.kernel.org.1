Return-Path: <netdev+bounces-175834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE66A67A77
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 18:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E103BED45
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B57211706;
	Tue, 18 Mar 2025 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RWk9Q34y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEDB2116FD;
	Tue, 18 Mar 2025 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317761; cv=none; b=eC4Peuksv2ox9kSuYEzc1y/HW7Rv8+lYYr5HoGYRI1466Enf+YMYH57HpJIRf8I4v0znkGhbRkkgSnSVd4jz2jcjYT0PW19QBIusohICnsZDPIdwIo/2HlmyCdTGT5FxQg11L0ooNEBT/TKwotC1/TOXGmMgkW9wC3Nqu5x69Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317761; c=relaxed/simple;
	bh=O7J55QvWIUOJKSgIC/2YR28bwN1OjhE7qVRraz+g2iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAtJjzaEpHihhho9z3uK8OE/BAfXeNfcrJ9WkTOV9rw9ym/ExtppNz1FY8MX0+rZ2Pii21lfocTcHtPsxCCQi2Mn60Gb/25398CUlA9fS86lSUdcS3c90Ni76L6NQWSM3HJOuZRegFHY5QaCkWrw03fmjVT7g7p74lclhoRuNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RWk9Q34y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OcDBiLaXxa75r09o0s3qg+rJ1ENkIQpT53QCYX5ct5g=; b=RWk9Q34y6JluDIFAtcj+eKrWXD
	YoIGSozS1vFmMtA/qeuXWqg8tVmM72cQwrFrJzJr6trIwbe4+9CBI7+n35oLzYYxcCe0Rd4tK2IsW
	aOZHRd5oGxuJcAPKLHzDFdfW2dO17eCNJ3H91b9cE1wj+nIO2/MNydVY8SwQxZVx6y/8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuaRE-006I0Y-2L; Tue, 18 Mar 2025 18:09:12 +0100
Date: Tue, 18 Mar 2025 18:09:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: Increase phy_name
 size
Message-ID: <f9640312-3641-4f32-9803-a76b2b010d7d@lunn.ch>
References: <20250318161702.2982063-1-andriy.shevchenko@linux.intel.com>
 <481268aa-c8e9-4475-bd5c-8d0f82a6652a@lunn.ch>
 <Z9mlWNdvWXohc6aM@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9mlWNdvWXohc6aM@smile.fi.intel.com>

On Tue, Mar 18, 2025 at 06:54:48PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 18, 2025 at 05:49:05PM +0100, Andrew Lunn wrote:
> 
> ...
> 
> > > -	char phy_name[20];
> > > +	char phy_name[MII_BUS_ID_SIZE + 5];
> > 
> > Could you explain the + 5?
> > 
> > https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/davicom/dm9051.c#L1156
> > https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/freescale/fec_main.c#L2454
> > https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/xilinx/ll_temac.h#L348
> > 
> > The consensus seems to be + 3.
> 
> u16, gcc can't proove the range, it assumes 65536 is the maximum.
> 
> include/linux/phy.h:312:20: note: directive argument in the range [0, 65535]

How about after

        ret = asix_read_phy_addr(dev, priv->use_embdphy);
	if (ret < 0)
		goto free;

add

        if (ret > 31) {
	        netdev_err(dev->net, "Invalid PHY ID %d\n", ret);
	        return -ENODEV;
	}

and see if GCC can follow that?

	Andrew

