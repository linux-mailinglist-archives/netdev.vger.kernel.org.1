Return-Path: <netdev+bounces-244525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86901CB95A9
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B96AF3013447
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692442FFDF8;
	Fri, 12 Dec 2025 16:50:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9819A26E715;
	Fri, 12 Dec 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765558209; cv=none; b=Hf9FpBTWA96Xxoxrug0pxIzVefF3neRHWzK1dC7pVICnC0T0VyEBZ0U3aUfRRjn6AF8W+Yfxn7emMhyHjokOvXYq9O3KHEVQyBAnSGV11rA+xseD38Tv8wcPv6lqyo62A2lskhNfyF+KT9u225GDiO6ftCmP0WdMZRUN2GIX68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765558209; c=relaxed/simple;
	bh=uoKoD2ATk0+/eBaR59U2Jf4JIe9a82syCTGli0vQ3IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZDJRzQ9Vd6SOVAwMLjXR2vfdY4QtSpP0zmP0ZYM7Ali7OZywWnxnhd+VOVwHHYuh7GEcQBRsu3Frh0GTc2vdKHRoNOp5UTK1VurGMhjp8Aut4KogXVTPUITj0a/fb5KeNffN3ioL723/A5laXwTgh/0dz45O6wDqm6Ftgq5HM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vU6L1-000000000JK-0kpu;
	Fri, 12 Dec 2025 16:49:51 +0000
Date: Fri, 12 Dec 2025 16:49:47 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <aTxHq8PGNPCzZngk@makrotopia.org>
References: <cover.1764717476.git.daniel@makrotopia.org>
 <d92766bc84e409e6fafdc5e3505573662dc19d08.1764717476.git.daniel@makrotopia.org>
 <c6525467-2229-4941-803d-1be5efb431c3@lunn.ch>
 <aTmPjw83jFQXgWQt@makrotopia.org>
 <d5ea5bee-40c5-43f5-9238-ced5ca1904b7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5ea5bee-40c5-43f5-9238-ced5ca1904b7@lunn.ch>

Hi Andrew,

On Wed, Dec 10, 2025 at 07:56:13PM +0100, Andrew Lunn wrote:
> > > > +	if (result < 0) {
> > > > +		ret = result;
> > > > +		goto out;
> > > > +	}
> > > 
> > > If i'm reading mxl862xx_send_cmd() correct, result is the value of a
> > > register. It seems unlikely this is a Linux error code?
> > 
> > Only someone with insights into the use of error codes by the uC
> > firmware can really answer that. However, as also Russell pointed out,
> > the whole use of s16 here with negative values being interpreted as
> > errors is fishy here, because in the end this is also used to read
> > registers from external MDIO connected PHYs which may return arbitrary
> > 16-bit values...
> > Someone in MaxLinear will need to clarify here.
> 
> It looks wrong, and since different architectures use different error
> code values, it is hard to get right. I would suggest you just return
> EPROTO or EIO and add a netdev_err() to print the value of result.

MaxLinear folks got back to me. So the error codes returned by the firmware
are basically based on Zephyr's errno.h which seems to be a copy of a BSD
header, see

https://github.com/zephyrproject-rtos/zephyr/blob/main/lib/libc/minimal/include/errno.h

So the best would probably be to modify and include that header with the
driver, together with a function translating the error codes to what ever
is defined in uapi/asm/errno.h for the architecture we are building for.

They also told me that (obviously) not all error codes are currently
used by the firmware, but the best would be to just catch all the possible
error codes and translate Zephyr libc -> Linux kernel.

