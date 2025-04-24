Return-Path: <netdev+bounces-185475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DC6A9A96D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886EF1B686B6
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAF9223DCC;
	Thu, 24 Apr 2025 10:05:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E2221FAA;
	Thu, 24 Apr 2025 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489121; cv=none; b=XLSk+8350NV6pmAjNirWlX62LZRvJ7SL064kisXXVLM9AZHq7I1sEVxvFhqDCgHSEvyWmznGxFQQROinlxpMpLmtwDj8FSSeTnm54662KyH14we1uYfJV0kMFt/TY3OEsjxCCIMCKvNuCrJeFBq4YMhA16v0wf5tPof0Oq386Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489121; c=relaxed/simple;
	bh=IkAVQLQcbBsqd++RWlxWPNV68rQ02JZMdcpF9vVK4mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbRqZZoeCQK+uYeRVwHsVHvtGEKFRY/Cjx44j/4npEGqdCUtBoDG6E1349crFRJXad7RMQkT7DNG/bBLcXIKoL5u6jhuZAgAsFfVTCXfPXE+7jYDRJnUl+K+kQ1TZ0s8bu4lYKsjDXWd/AcNbLOCbme9yaG+xuxApQbxvHLMi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 9CCA2340DF9;
	Thu, 24 Apr 2025 10:05:18 +0000 (UTC)
Date: Thu, 24 Apr 2025 10:05:14 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Message-ID: <20250424100514-GYA48784@gentoo>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
 <aa38baed-f528-4650-9e06-e7a76c25ec89@lunn.ch>
 <20250424014120.0d66bd85@minigeek.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424014120.0d66bd85@minigeek.lan>

Hi Andrew, Andre,

On 01:42 Thu 24 Apr     , Andre Przywara wrote:
> On Wed, 23 Apr 2025 18:58:37 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> Hi,
> 
> > > +&emac0 {
> > > +	phy-mode = "rgmii";  
> > 
> > Does the PCB have extra long clock lines in order to provide the
> > needed 2ns delay? I guess not, so this should be rgmii-id.
> 
> That's a good point, and it probably true.
> 
> > 
> > > +	phy-handle = <&ext_rgmii_phy>;
> > > +
> > > +	allwinner,tx-delay-ps = <300>;
> > > +	allwinner,rx-delay-ps = <400>;  
> > 
> > These are rather low delays, since the standard requires 2ns. Anyway,
> > once you change phy-mode, you probably don't need these.
> 
As I tested, drop these two properties making ethernet unable to work,
there might be some space to improve, but currently I'd leave it for now

> Those go on top of the main 2ns delay, I guess to accommodate some skew
> between the RX and TX lines, or to account for extra some PCB delay
> between clock and data? The vendor BSP kernels/DTs program those board
> specific values, so we have been following suit for a while, for the
> previous SoCs as well.
> I just tried, it also works with some variations of those values, but
> setting tx-delay to 0 stops communication.
> 
I'd not bother to try other combinations, and just stick to vendor's settings

thanks

-- 
Yixun Lan (dlan)

