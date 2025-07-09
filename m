Return-Path: <netdev+bounces-205495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6EAAFEF4C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 19:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0023B5FDA
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58E1217F29;
	Wed,  9 Jul 2025 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CwVMW57a"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF86BFCE;
	Wed,  9 Jul 2025 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080523; cv=none; b=LTD4vKopO+J2u+qBCrbzsvvqed2jWj5qWlq5IR8L+wV/Uz+hMwTh6cGJ8y9qF6Gaa3Lg/6bFCJe9jHr5cR89pKO6Bq0jwpQ2EV5bjRP0ZPX41zne6jKpe67uuTxXGjPC2hZRwy56vhPxNtuuJHGyhq01sBPyQl7yvblfQIoNehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080523; c=relaxed/simple;
	bh=clG/NIToEMxKbs1ZmMy+5Ij2Vhl17097UxqpeHqElas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDtRKK7CN1dK5eXyhIPHbNjPhM6GMGYgV37PaROSuDUVR5O2NLAE2bMAhFww+5IMK9/jWV43uHjtdQZKDubJUX5KZHghCRP7+e4QNnlZufjFZzf8SJbvmYhtddejJgjp/GDKnaayAFRNyQHuGvfXzNWNmuyJwe1TuzLV9OUU7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CwVMW57a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=xwIuPRfBvgwDUvog670XJikOKlbcAYFNfjUJsTugx6A=; b=Cw
	VMW57aiB17xlq/dLe76GHEPU5J1MEexTvB8lWof2SLJB4Cje7+Cqa3FdsRzEK5ZRVjyNg1whbcbl7
	00tT82y8NBDIr7x8bXUunG89PbkXlPnVl6VclpKalW4d2FBVW6zhNY1tD5IlaiiuSI2yrL/WPxTEo
	60Pe9RLlao8dOWE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZYAo-000y3p-7J; Wed, 09 Jul 2025 19:01:34 +0200
Date: Wed, 9 Jul 2025 19:01:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: lizhe <sensor1010@163.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, vladimir.oltean@nxp.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: Re: [PATCH] net: stmmac: Support gpio high-level
 reset for devices requiring it
Message-ID: <05cd64a0-ec24-4ea0-9f57-8d8542563a51@lunn.ch>
References: <20250708165044.3923-1-sensor1010@163.com>
 <52b71fe7-d10a-4680-9549-ca55fd2e2864@lunn.ch>
 <5c7adfef.1876.197ece74c25.Coremail.sensor1010@163.com>
 <aG3vj1WYn3TjcBZe@shell.armlinux.org.uk>
 <5bb49dc0.6933.197ee28444e.Coremail.sensor1010@163.com>
 <aG5ORmbgMYd08eNR@shell.armlinux.org.uk>
 <4cfb4aab.9588.197eefef55f.Coremail.sensor1010@163.com>
 <aG582lPgpOr8oyyx@shell.armlinux.org.uk>
 <2352b745.a454.197efeef829.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2352b745.a454.197efeef829.Coremail.sensor1010@163.com>

On Thu, Jul 10, 2025 at 12:05:05AM +0800, lizhe wrote:
> Hi，

Please don't top post.

>     snps, reset-gpio = <&gpioX RK_PXX GPIO_ACTIVE_HIGH>;   
>     All of them correctly parse the GPIO pin's state are described in the DTS
> 
> 
> 
> Thx !
> 
> Lizhe
> 
> 
> 
> 
> At 2025-07-09 22:29:46, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >On Wed, Jul 09, 2025 at 07:42:55PM +0800, lizhe wrote:
> >> Hi,
> >>     i have already declared it in the DTS.
> >>
> >>     &gmac {
> >>             snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
> >>     };
> >
> >Active high means that the reset is in effect when the output is at the
> >logic '1' state. So, gpiod_get_value*() will return the same as
> >gpiod_get_raw_value*().
> >
> >Active low means that the reset is in effect when the output is at the
> >logic '0' state, and in that case the return value of
> >gpiod_get_value*() will return true when the reset is active (at logic
> >'0' state) whereas gpiod_get_raw_value*() will return zero.

Did you read what Russell said? If so, why are you using
GPIO_ACTIVE_HIGH?

	Andrew

