Return-Path: <netdev+bounces-193084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A073EAC2713
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36524545673
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FF5296D04;
	Fri, 23 May 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OpQcs4dc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84E221557;
	Fri, 23 May 2025 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016138; cv=none; b=prSkG6sfVyopX9GnwsNQNzLma4RA3FFwsII0LZrTqmnMnWIWWm4RniIjH4xnNkJqir/UuiV93FcBtHlb5Yhd7ufFasWzBoJj+azqCIX/slBWr9iqE25DaJMnClX8oh/clgGWSmOe1bM0OG9HzrsXmSXt7rqlwIUagsS0jDumXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016138; c=relaxed/simple;
	bh=HIQHs3IOA8FRkzf8F6Hs5hqxhQBGB/RqpvLvwq5IR+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li+dHypuskECXJ5a58XJJeKq3YfArfDFkIosk6y6RDXWyzuMDWHjfAUgO4rRl1MA3M8Vn9yBFpCfLpP0rKLBIFFUCnfWT/gg0b+cBCDrgdujhOHDMvAVZ7iQZOLAWWkhwNbN0XcVE9/hD3ehw3W7x+f3Yy9rKUTE151Q6HCzJg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OpQcs4dc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0DPKAvfg5f4Y3SBIphoT53zbwhsUwwLhBf0NzO10Cgs=; b=OpQcs4dcB6OWU9mlLf31Gzrhvv
	tb+hAOfomI21FW70GV6ifTR+Zu4IGNBr6FuaOsUdcAh2lpJb3aG44dd2qd/xAFxyqLE88j1yp6wAA
	iYkunMJADxww4SJ57C3dd5q2s5gZEeki2AICqkKOMSGUz7VzXMwFrnzA9FxIE8UOGaDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uIUqQ-00DcxW-JK; Fri, 23 May 2025 18:02:02 +0200
Date: Fri, 23 May 2025 18:02:02 +0200
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
Subject: Re: [PATCH net-next 1/2] net: phy: mtk-2p5ge: Add LED support for
 MT7988
Message-ID: <afb80927-d921-44d7-8a32-f109e5ec5143@lunn.ch>
References: <20250523113601.3627781-1-SkyLake.Huang@mediatek.com>
 <20250523113601.3627781-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523113601.3627781-2-SkyLake.Huang@mediatek.com>

On Fri, May 23, 2025 at 07:36:00PM +0800, Sky Huang wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> Add LED support for MT7988's built-in 2.5Gphy. LED hardware has almost
> the same design with MT7981's/MT7988's built-in GbE. So hook the same
> helper function here.
> 
> Before mtk_phy_leds_state_init(), set correct default values of LED0
> and LED1.
> 
> Signed-off-by: Sky Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

