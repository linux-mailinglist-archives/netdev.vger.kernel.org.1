Return-Path: <netdev+bounces-244528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6582BCB966D
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 18:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EA5A307B0A9
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B322D5930;
	Fri, 12 Dec 2025 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yAwlgqhA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35E20E005;
	Fri, 12 Dec 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765558966; cv=none; b=f/INaAwHcZQs9apRAYxtjJkir7mRkOaEO7lQHVqb8EdiQgiFb/+xmWojykS2TeWPe149KGtN37kEGO+A3gExy3K5ZA1lSN9CncUoicXh72WrDhqa9WU5b6Q8Fn01sMviCvyYryvBBQPvXrRFy+JCwwmrxCZASTB3M3nVyPTFs5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765558966; c=relaxed/simple;
	bh=4jwcUsFKsfuuWXlTypFzWcLKnYZAIVqSoXXqqnQAXog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLvaMs3CV268swYTJUlBgjGHDTvzS7cueZdVXXExL7QMLGoClu8Wted2nnD51ZYwdcfZQsXYfZV3vHynMegg0WltLT5Z6d3k2uZj3/wCqd2k/7prZn9UvGq3x7U9+SwKMWV9prkQb17Aznc/09zWlYbwQMi3TQ6TPvWbemxgYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yAwlgqhA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OxDAj0WJw7n42iSz1VgIvGe+3TZ3z5y6U/4TSqX2ovA=; b=yAwlgqhA51fiOwVd64CpHI9k2o
	7NzOfrkQsMBF0nLnBkKvLQ7cucH4dHX32/lyHPPu+SllYOlIlSCQMBN6lX1wMPjhaEFIYW6FyI5PN
	p6Tnrx5Q9YrMVPse8viuJg6UazUGr3ODSNr5j30QzZAUfZOQkt28vAF2YTuTCnDDIBls=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vU6XF-00GmpX-1P; Fri, 12 Dec 2025 18:02:29 +0100
Date: Fri, 12 Dec 2025 18:02:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <7526cccd-4a5a-48fc-b3e3-fa8159e69401@lunn.ch>
References: <cover.1764717476.git.daniel@makrotopia.org>
 <d92766bc84e409e6fafdc5e3505573662dc19d08.1764717476.git.daniel@makrotopia.org>
 <c6525467-2229-4941-803d-1be5efb431c3@lunn.ch>
 <aTmPjw83jFQXgWQt@makrotopia.org>
 <d5ea5bee-40c5-43f5-9238-ced5ca1904b7@lunn.ch>
 <aTxHq8PGNPCzZngk@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTxHq8PGNPCzZngk@makrotopia.org>

On Fri, Dec 12, 2025 at 04:49:47PM +0000, Daniel Golle wrote:
> Hi Andrew,
> 
> On Wed, Dec 10, 2025 at 07:56:13PM +0100, Andrew Lunn wrote:
> > > > > +	if (result < 0) {
> > > > > +		ret = result;
> > > > > +		goto out;
> > > > > +	}
> > > > 
> > > > If i'm reading mxl862xx_send_cmd() correct, result is the value of a
> > > > register. It seems unlikely this is a Linux error code?
> > > 
> > > Only someone with insights into the use of error codes by the uC
> > > firmware can really answer that. However, as also Russell pointed out,
> > > the whole use of s16 here with negative values being interpreted as
> > > errors is fishy here, because in the end this is also used to read
> > > registers from external MDIO connected PHYs which may return arbitrary
> > > 16-bit values...
> > > Someone in MaxLinear will need to clarify here.
> > 
> > It looks wrong, and since different architectures use different error
> > code values, it is hard to get right. I would suggest you just return
> > EPROTO or EIO and add a netdev_err() to print the value of result.
> 
> MaxLinear folks got back to me. So the error codes returned by the firmware
> are basically based on Zephyr's errno.h which seems to be a copy of a BSD
> header, see
> 
> https://github.com/zephyrproject-rtos/zephyr/blob/main/lib/libc/minimal/include/errno.h
> 
> So the best would probably be to modify and include that header with the
> driver, together with a function translating the error codes to what ever
> is defined in uapi/asm/errno.h for the architecture we are building for.
> 
> They also told me that (obviously) not all error codes are currently
> used by the firmware, but the best would be to just catch all the possible
> error codes and translate Zephyr libc -> Linux kernel.

That all sounds way too complex. We don't expect errors do we? So
print the raw value, add a comment about how to manually translate the
number to something potentially meaningful, and return -EIO.

	  Andrew

