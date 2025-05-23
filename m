Return-Path: <netdev+bounces-193085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0450AC272D
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 18:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75A49E55D9
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E8E225397;
	Fri, 23 May 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jkq3ytWe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AC92045B5;
	Fri, 23 May 2025 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016484; cv=none; b=Tp5DjGJY2aFOZoYZ1bNaZrJ9xnLPrXHictI02hJPMHvmochsBt4v6zJjGTC1ML3x1SnSPaQeG809ay7kZm5O79kCyhEU55jqCVNZiE1h1gNLMg5QM2RSzaZkx/WqlJNs+8lFDCGAhtDc3XxLjKd6kinXb6B56DYAMJ+PcafihNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016484; c=relaxed/simple;
	bh=4ikHnQHH1c+C1GtGvR5xgCWyoWZOd7YFiZTkJF9gAUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1unBrfI+AV4QOw4igtleB9E5Ni+7rPGhhyhc6V7T2waY5SVOifO6Bey8h7ACo7boRIwI1P3T7feTd06cKCayF8eTgRguKw1M98L/9q8Nmb2itV52QL89tz1Nq4By49Iz0g9sSQQ5MEuonwMnGGmyC2fHY80T8VTSUhHAL1fyBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jkq3ytWe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S6Ip/EGBVi6qARnvgxZC7YGNzlBftLG+VPwtRvZjRDs=; b=jkq3ytWedokPjdjZjKAIp5/xdl
	H3VUwiycazQtojv+4ajmUDoFRq6IhH/xb3AvQqGoGsSHQVogjbZcRj53KX9YV3phb4VwuaEmDYyUK
	aykPsQrPLpamYPXtgdrOfjS/Tb+NHzDUpyVOkQDKzY7/QUwZUdLciExd7yZG6CpcmizI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uIUw1-00Dczn-O9; Fri, 23 May 2025 18:07:49 +0200
Date: Fri, 23 May 2025 18:07:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] net: phy: mtk-ge-soc: Fix LED behavior if
 blinking is not set.
Message-ID: <39d5d8af-0bac-4b91-85df-4e04a5835f53@lunn.ch>
References: <20250523113601.3627781-1-SkyLake.Huang@mediatek.com>
 <20250523113601.3627781-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523113601.3627781-3-SkyLake.Huang@mediatek.com>

On Fri, May 23, 2025 at 07:36:01PM +0800, Sky Huang wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> If delay_on==0 and delay_off==0 are passed to
> mt798x_2p5ge_phy_led_blink_set() and mtk_phy_led_num_dly_cfg(),
> blinking is actually not set. So don't clean "LED on" status under
> this circumstance.

Actually, i think mtk_phy_led_num_dly_cfg() is wrong.

https://docs.kernel.org/leds/leds-class.html#hardware-accelerated-blink-of-leds

   The blink_set() function should choose a user friendly blinking
   value if it is called with *delay_on==0 && *delay_off==0
   parameters. In this case the driver should give back the chosen
   value through delay_on and delay_off parameters to the leds
   subsystem.

That is not what mtk_phy_led_num_dly_cfg() does.

    Andrew

---
pw-bot: cr

