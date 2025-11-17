Return-Path: <netdev+bounces-239166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83212C64C49
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 888F7241DA
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BA3246793;
	Mon, 17 Nov 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2PdKD+Jp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8029D1FA272;
	Mon, 17 Nov 2025 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763391680; cv=none; b=iLgin7VcuSAARrGwE1U2toiWBs3hSrZ1CiD3xrDyN7pSqUR0qIs6pALqBV34I3U8LDhWb+D1J+r3GgmVrpFVynf5aVqVhLnWHZg8PPhleXUa6PsZ34Z3wUZIaKpxS8Fq48jR234z4kXv4zhp8paXKJag8z7U9/I28jG8YYIsXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763391680; c=relaxed/simple;
	bh=oFOJO1GyFZlMuqC0ktZY+DppGZ5JUYf1B9IWZppeLa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFufVHqXw8U7gXyJzpkSp4GdgxS1q8au3bpuXQvhJ6all7GPxYah36gS6NjnLCr3RdbHmLvUqDqU51vb2s9jtz53jD0gLEx2YcWaaBsNn1y3qS4VKOMdjAWktjGyq5QhdC56r+MXKDxrFg9e0QbSercPKnZj8fXsHIT4T5bZf5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2PdKD+Jp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=I8Qibn9z0+hnfsoUujz9XHvfnzb7ts/AzJXWKnTf/J4=; b=2PdKD+JprUcfEfy0JkVepWwooA
	2zRbObiQzWJbPzfRjcrxJidDhEdxMQp+Np4CscDffUr7+x3myaK3Gd+miOTQQyioC9R80thmocEsr
	6wvA57mu1zb9hGASFu6pGCtpLTsmjYa+AzF/2ClSe2axcU3IBuspQySuY+iDqqkILeLA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vL0j1-00EFj8-8i; Mon, 17 Nov 2025 16:01:03 +0100
Date: Mon, 17 Nov 2025 16:01:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: phylink: add missing supported link modes for
 the fixed-link
Message-ID: <f6324260-f019-4e1b-87c0-b57e862e28b4@lunn.ch>
References: <20251116023823.1445099-1-wei.fang@nxp.com>
 <30e0b7ba-ac60-49e0-8a6d-a830f00f8bbc@lunn.ch>
 <PAXPR04MB8510785AF26E765088D1631788C9A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <9f9df3b3-ea08-43d7-8075-68b4fe19e6a0@lunn.ch>
 <PAXPR04MB851071D8B6E7F1FBCBA656CA88C9A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB851071D8B6E7F1FBCBA656CA88C9A@PAXPR04MB8510.eurprd04.prod.outlook.com>

> The default TCP block size sent by iperf is 128KB. ENETC then fragments
> the packet via TSO and sends the fragments to the switch. Because the
> link speed between ENETC and the switch CPU port is 2.5Gbps, it takes
> approximately 420 us for the TCP block to be sent to the switch. However,
> the link speed of the switch's user port is only 1Gbps, and the switch takes
> approximately 1050 us to send the packets out. Therefore, packets
> accumulate within the switch. Without flow control enabled, this can
> exhaust the switch's buffer, eventually leading to congestion.
> 
> Debugging results from the switch show that many packets are being
> dropped on the CPU port, and the reason of packet loss is precisely
> due to congestion.

BQL might help you. It could break the 128KB burst up into a number of
smaller bursts, helping avoid the congestion.

Are there any parameters you can change with TSO? This is one
stream. Sending it out at 2.5G line rate makes no sense when you know
it is going to hit a 1G egress. You might as well limit TSO to
1G. That will help single stream traffic. If you have multiple streams
it will not help, you will still hit congestion, assuming you can do
multiple TSOs in parallel.

	Andrew

