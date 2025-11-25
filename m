Return-Path: <netdev+bounces-241701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55765C87805
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6B62354B5D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E772DC798;
	Tue, 25 Nov 2025 23:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JM4HoprP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789A25CC63;
	Tue, 25 Nov 2025 23:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114386; cv=none; b=TGTaCGVcRCarnk/0Zzo1Jc8+ild7JVmnQfmd0XV8/pB4miATrfgYAupguyUHWdImwDOvgIRQ4bS1ZxvBWCFLcIz89/72dLuITR8waDiHNOb7jjVj5hmhNqUG4/nQdrXd6ZCLsdsxZcAiZ1ZHuHI7MNy4azg4llRsuFKbaAvtUMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114386; c=relaxed/simple;
	bh=tDHiPPgQDE5xWH9oEyQV1NNg+Ujnwp+DjuvV0gjTwFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUd2r6loPPGCctjgsLM21PKlGAmIq50r2vi18AtKJp1rWFJjjZcIeUdWOT0kSzONIqhlV/WUn3s8W9PFbQtdQH8RJVGJp/vmWD38BMyU0BtVFhrtLWv0PtH6eVMLhdGu7j7zr+G9gV2lbmSdWEZOGB12jaquOAq6k4XVR3doe4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JM4HoprP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FesFCToQspFq4tboaTqpc09nhNIi95vNt6BcM6NYbRs=; b=JM4HoprP8viQFMd9g0NmwQ7Z+m
	P6KgwuM1w2Xv6t0AvfTeIFpxQTgS0JCfDlUY/iEDwfBs47gjc4nIgo7+Z5C8OVZOniW9X6uf9vi+O
	Plb3ePl2i25w9iKdUkQD1ts9YtaCNRW+I+Lc3mqvvWXY4zeU3Z8Y8KkhZq/8OVgtDGF54X1Su2Z8P
	3pnWpArvQR0FsAaz6y5ib5oCd1m6DZlSBiz7TDUSo/oY3o9CCvCtk5JGuorLvkF3CsQuE57TM86Zr
	gdMe5sHAGAbp8ittT6Ba+z1ZPE3P0W8lMMIcM4DoILl7fBrgVMAIno3unY3eTN9bt/TEEOAumgnw4
	1wrLg4hg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40256)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vO2jf-000000003Ju-1d1K;
	Tue, 25 Nov 2025 23:46:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vO2jc-000000001BP-2gpy;
	Tue, 25 Nov 2025 23:46:12 +0000
Date: Tue, 25 Nov 2025 23:46:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: rohan.g.thomas@altera.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next] net: stmmac: dwmac: Disable flushing frames on
 Rx Buffer Unavailable
Message-ID: <aSY_xIYWfv9YAv6Q@shell.armlinux.org.uk>
References: <20251126-a10_ext_fix-v1-1-d163507f646f@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126-a10_ext_fix-v1-1-d163507f646f@altera.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 26, 2025 at 12:37:12AM +0800, Rohan G Thomas via B4 Relay wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> In Store and Forward mode, flushing frames when the receive buffer is
> unavailable, can cause the MTL Rx FIFO to go out of sync. This results
> in buffering of a few frames in the FIFO without triggering Rx DMA
> from transferring the data to the system memory until another packet
> is received. Once the issue happens, for a ping request, the packet is
> forwarded to the system memory only after we receive another packet
> and hece we observe a latency equivalent to the ping interval.
> 
> 64 bytes from 192.168.2.100: seq=1 ttl=64 time=1000.344 ms
> 
> Also, we can observe constant gmacgrp_debug register value of
> 0x00000120, which indicates "Reading frame data".
> 
> The issue is not reproducible after disabling frame flushing when Rx
> buffer is unavailable. But in that case, the Rx DMA enters a suspend
> state due to buffer unavailability. To resume operation, software
> must write to the receive_poll_demand register after adding new
> descriptors, which reactivates the Rx DMA.


This seems like a sensible writeup, which all seems to make sense,
even though the databook I have seems vague on the effect of the
DFF bit.

> This issue is observed in the socfpga platforms which has dwmac1000 IP
> like Arria 10, Cyclone V and Agilex 7. Issue is reproducible after
> running iperf3 server at the DUT for UDP lower packet sizes.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>

Given the above, that Maxime has also tested it which shows a net
benefit, and I've looked through this, even though I can't positively
say it's correct due to the databook vagueness:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

