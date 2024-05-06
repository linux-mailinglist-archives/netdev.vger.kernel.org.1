Return-Path: <netdev+bounces-93581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0D48BC565
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64175B20C48
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF853C064;
	Mon,  6 May 2024 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ukxOGBLF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D638F91;
	Mon,  6 May 2024 01:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958503; cv=none; b=iGP4/hvDTyo+zQpHJvExhPvr76hAIDphBEa9vFS4QkP0EW0KeuGTxY7IEivEDBYKOnPlCfh/kLtsNVnTkIwNtmj+hYb5fRIc79F+s9Q+o8Od4DlYC6z3lw14GMuF9JShLZ7QXn2T0WE2jEzmaD7jV3aGHMZC66a0yiLcw85/UZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958503; c=relaxed/simple;
	bh=tcmaZci8s2SbyJUHrYITwrkr8FP51PKjAGTRDAgHu6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvhFsqMvCPULP4XxxbZ0a6Xl7HNBi/D0lhtIyt7sE2wKmc2IiVmGgoWYzxNBvWDyt8dAQWAMLxqGFg83cJTyWsWn4T/+fZ0R7ItQ2gazDPbSkoGD+LnntcUOC0St9QkDFjMoivQXjQ3sRDabp6cDbqp+cn2JCx9buhT0aIhz1xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ukxOGBLF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=khJBnJGPC0Bwe9eiBGBBnF2OTwHW4sDwaW9VH58A8V4=; b=uk
	xOGBLFCjVDrlt4Eq3SZGfQKp7QAvvCm7RSkCQGBkoae0DqlHW7TvrA7l657UiB6uAU7DAztJuehRq
	nuT8gRybHcwjqkaKjitmt/1YKdShzcqGV4CDRybC3HY8yYHmSkgyR97oFCk07MPdO63ke0zBCzNeC
	nzdPOZLdvcSzOKg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s3n2b-00EixG-8J; Mon, 06 May 2024 03:21:17 +0200
Date: Mon, 6 May 2024 03:21:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: ramon.nordin.rodriguez@ferroamp.se, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <fd5d0d2a-7562-4fb1-b552-6a11d024da2f@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
 <Zi1Xbz7ARLm3HkqW@builder>
 <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
 <Zi4czGX8jlqSdNrr@builder>
 <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>
 <ZjKJ93uPjSgoMOM7@builder>
 <b7c7aad7-3e93-4c57-82e9-cb3f9e7adf64@microchip.com>
 <ZjNorUP-sEyMCTG0@builder>
 <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae801fb9-09e0-49a3-a928-8975fe25a893@microchip.com>


> [  285.482275] LAN865X Rev.B0 Internal Phy spi0.0:00: attached PHY 
> driver (mii_bus:phy_addr=spi0.0:00, irq=POLL)
> [  285.534760] lan865x spi0.0 eth1: Link is Up - 10Mbps/Half - flow 
> control off
> [  341.466221] eth1: Receive buffer overflow error
> [  345.730222] eth1: Receive buffer overflow error
> [  345.891126] eth1: Receive buffer overflow error
> [  346.074220] eth1: Receive buffer overflow error

Generally we only log real errors. Is a receive buffer overflow a real
error? I would say not. But it would be good to count it.

There was also the open question, what exactly does a receive buffer
overflow mean?

The spec says:

  9.2.8.11 RXBOE

  Receive Buffer Overflow Error. When set, this bit indicates that the
  receive buffer (from the network) has overflowed and receive frame
  data was lost.

Which is a bit ambiguous. I would hope it means the receiver has
dropped the packet. It will not be passed to the host. But other than
maybe count it, i don't think there is anything to do. But Ramón was
suggesting you actually drop the frame currently be transferred over
the SPI bus?

	Andrew

