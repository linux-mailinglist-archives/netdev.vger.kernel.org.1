Return-Path: <netdev+bounces-231865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6833BFE077
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8985F4F0F97
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D634AB11;
	Wed, 22 Oct 2025 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2Dxq4flt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C00A3491D9;
	Wed, 22 Oct 2025 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161290; cv=none; b=rBUGCRj4f6sOnk8Zrtyhl0q4czWUjwh63McFYggxCkwmiSsNheoi1go7TyvXuo0IgPI69mqGtW89ZzmpG9gkuOLtsEeDO+bS7ciwNCxVEQOMDCxj8ZJkT1qvCZypCexmMFqC36Sfjn8wyjR9SXYBbNlrqsvQfYBBiSleeLQgRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161290; c=relaxed/simple;
	bh=LLRkrV+5VKN+OSCZ0K4zEmTDNzrKf4dqalvJC83c9ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJtbyD2OQOws7cv53fuVsdN6CKz56aUU7rvNvUkHkq4KcXp8kvVwUX7kCbX9XBVG/QhaGI7Nzbug6IRrOT8XS3mL+DdsJEWmoNbpPcUHqgonHUF0ozzZL5oZT0U1ufDkunLzXuhM0atYF6pLXqGWPREYO+B14rMYaiExzywZe9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2Dxq4flt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=tKrjwXgbg5Z595y5yK1AbHDQcqvAau3Png2I4E1p9Go=; b=2D
	xq4fltXTKpgZl4tnrlaugiM8fqAgcc71ZiVmLBMSmO0Q0skkTxDjtM2tYk4PLhdQ4S4d9LaecSpY2
	+VGFvpv3SxbMpyMR8Y0zAmCXOTjVnCCrL6VRFtfqYhsvksFzBmtegzO9Vi5H8sFFeA6MfNWcD4Gl3
	RTgWSZNmCX+MnZU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBeV4-00Bo13-Tx; Wed, 22 Oct 2025 21:27:58 +0200
Date: Wed, 22 Oct 2025 21:27:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: Re: [PATCH net-next v2 2/5] net: macb: match skb_reserve(skb,
 NET_IP_ALIGN) with HW alignment
Message-ID: <7950f287-f025-40d9-b182-c1002d955a5b@lunn.ch>
References: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
 <20251022-macb-eyeq5-v2-2-7c140abb0581@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022-macb-eyeq5-v2-2-7c140abb0581@bootlin.com>

On Wed, Oct 22, 2025 at 09:38:11AM +0200, Théo Lebrun wrote:
> If HW is RSC capable, it cannot add dummy bytes at the start of IP
> packets. Alignment (ie number of dummy bytes) is configured using the
> RBOF field inside the NCFGR register.
> 
> On the software side, the skb_reserve(skb, NET_IP_ALIGN) call must only
> be done if those dummy bytes are added by the hardware; notice the
> skb_reserve() is done AFTER writing the address to the device.
> 
> We cannot do the skb_reserve() call BEFORE writing the address because
> the address field ignores the low 2/3 bits. Conclusion: in some cases,
> we risk not being able to respect the NET_IP_ALIGN value (which is
> picked based on unaligned CPU access performance).
> 
> Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")

Is this a real fix? You should not mix new development with
fixes. Either post this patch to net, or drop the Fixes: tag for
net-next.

    Andrew

---
pw-bot: cr

