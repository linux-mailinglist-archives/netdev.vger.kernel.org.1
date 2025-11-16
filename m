Return-Path: <netdev+bounces-238943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B84C6182D
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 17:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5863AEAC2
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A930A30DD30;
	Sun, 16 Nov 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MA+jZG5M"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC36930DD20;
	Sun, 16 Nov 2025 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763309436; cv=none; b=s/IUajZri4IFKw5Euw6KmcMSPV02hSn+m2ErYbUUOlDEJZ15+14xReZyPtmQt8XYoADbt205s8cxX0q3kY423O/Twvt7cH0cAmEbP+HAHAnufzk4ja606YHUMVxayEZf5CgaI2ERnLNRXUbUspW9ZNQLo7+1egwHcHl2VgwYbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763309436; c=relaxed/simple;
	bh=xOC55t+6MpWmNxcTWpUjh4uut/tZW3PssJP4moey2K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLFk2yLSP0YBzv2cl/Hmg07E/+LtPdgXbPRXQTtQZtSWZUN5pZsC4igCjh1P7oKPDrz9yGWuiYnQYPar+TLDS4aoLkrHO94Wn2+xNdwgc7HNZ0WSrhJSbWXUZxh5/D391qom1WN/pCJlWOGdg4R5IaA8/9EKNl9s2YnohkAZxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MA+jZG5M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GJaJD6LBIQS9BQHe5CefSfuluclnDpRXBkqZ7gD+/vc=; b=MA+jZG5MQ1qgHBxW2ReGPcB+de
	eT9ujswckbFM2Z0LqVV/aBb4CSYgfUbKcIyI1hyoMdkIM8QoXI6Pv5+FTRjmesAxMnco/li/u+Cfk
	PtAJWoxf0AwkDe5nbnKKwdy/3hd0LKfQQ4rnExw30mrffxq88ZyhBCCt6KronWaeXJMA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKfKV-00E9p6-Rj; Sun, 16 Nov 2025 17:10:19 +0100
Date: Sun, 16 Nov 2025 17:10:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	eric@nelint.com, maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: phylink: add missing supported link modes for
 the fixed-link
Message-ID: <30e0b7ba-ac60-49e0-8a6d-a830f00f8bbc@lunn.ch>
References: <20251116023823.1445099-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116023823.1445099-1-wei.fang@nxp.com>

On Sun, Nov 16, 2025 at 10:38:23AM +0800, Wei Fang wrote:
> Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
> initialized, so these link modes will not work for the fixed-link. This
> leads to a TCP performance degradation issue observed on the i.MX943
> platform.
> 
> The switch CPU port of i.MX943 is connected to an ENETC MAC, this link
> is a fixed link and the link speed is 2.5Gbps. And one of the switch
> user ports is the RGMII interface, and its link speed is 1Gbps. If the
> flow-control of the fixed link is not enabled, we can easily observe
> the iperf performance of TCP packets is very low. Because the inbound
> rate on the CPU port is greater than the outbound rate on the user port,
> the switch is prone to congestion, leading to the loss of some TCP
> packets and requiring multiple retransmissions.
> 
> Solving this problem should be as simple as setting the Asym_Pause and
> Pause bits. The reason why the Autoneg bit needs to be set is because
> it was already set before the blame commit. Moreover, Russell provides
> a very good explanation of why it needs to be set in the thread [1].
> 
> [1] https://lore.kernel.org/all/aRjqLN8eQDIQfBjS@shell.armlinux.org.uk/

There is no limit on commit message length, but URLs sometimes
die. Please just make use of Russells explanation. You can say: As
explained by Russell King, and just quote it, etc.

This also seems like two fixes: a regression for the AUTONEG bit, and
allowing pause to be set. So maybe this should be two patches?

I'm also surprised TCP is collapsing. This is not an unusual setup,
e.g. a home wireless network feeding a cable modem. A high speed link
feeding a lower speed link. What RTT is there when TCP gets into
trouble? TCP should be backing off as soon as it sees packet loss, so
reducing the bandwidth it tries to consume, and so emptying out the
buffers. But if you have big buffers in the ENETC causing high
latency, that might be an issue?  Does ENETC have BQL? It is worth
implementing, just to avoid bufferbloat problems.

	Andrew

---
pw-bot: cr

