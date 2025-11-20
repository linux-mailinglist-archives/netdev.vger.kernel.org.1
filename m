Return-Path: <netdev+bounces-240585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA168C76758
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 23:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 607952FABA
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 22:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB09314A7E;
	Thu, 20 Nov 2025 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pV7GjDVG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC6182B7;
	Thu, 20 Nov 2025 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763676500; cv=none; b=WMdIz4XG9agBCol8RsHmoDUgmVU93qyjDubj5O+ZIOqhqC93nnA/IqOqfkHBa4VeMnXLWCXhq64XUEtTQ3g3M1fzalHMbm4/51kg8UPq+OyxYSNpSyz9467aiTF8Lp2nQO7rz4EhfYb4qa7J/6jRW9VfBTVUULZTB9C6ym5TQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763676500; c=relaxed/simple;
	bh=fZDHV4AuEyrKVaBKNj88FHbs6zy5PYIDKuLnd5/o0eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyzhRfV703K78hgDGOBj2Jp9JitMg2CaeND3EcVoi65is+EGm0RgOBFpyXIx1ovIXQVpx7bP/y4Zbzv5Mgh500VZycCc5Qf5JLxvEA9tooIldaMwNOlE7NVV8vY/JghE4mppgwe4fGWNyWpfPpYYcXt6icteqy/ZKjW1480qFpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pV7GjDVG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JweFYkJNQB23bxN82bE4p4nwcQiB2tl0i88PLv5Xafc=; b=pV7GjDVGPa2+tAaN5SGnganJ2R
	u7NjB8omqenDHOwR2uT4fKfS9qN3KAYA2zhKFV+z5GPY+/j8A0Oujwinp+BO7/VZ4T3BQjQeti4cG
	udYiBwxbkiJSc/AN3oxhIiHr/DYzNHOhzqpWOBWY6mubBz6khXjZkFHRYV3Cj0VcdYGw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vMCov-00EgJL-Q1; Thu, 20 Nov 2025 23:08:05 +0100
Date: Thu, 20 Nov 2025 23:08:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chen Minqiang <ptpt52@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM64: dts: mediatek: fix MT7531 reset GPIO
 polarity on multiple boards
Message-ID: <52d3469e-104e-4950-802a-2b83cea8d726@lunn.ch>
References: <20251120213805.4135-1-ptpt52@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120213805.4135-1-ptpt52@gmail.com>

On Fri, Nov 21, 2025 at 05:38:04AM +0800, Chen Minqiang wrote:
> The MT7531 reset pin is active-low, but several DTS files configured the
> reset-gpios property without GPIO_ACTIVE_LOW. This causes the reset GPIO
> to behave as active-high and prevents the switch from being properly reset.
> 
> Update all affected DTS files to correctly use GPIO_ACTIVE_LOW so that
> the reset polarity matches the hardware design.
> 
> Boards fixed:
>  - mt7622-bananapi-bpi-r64
>  - mt7622-rfb1
>  - mt7986a-bananapi-bpi-r3
>  - mt7986a-rfb
>  - mt7986b-rfb
> 
> Note: the previous DTS description used the wrong polarity but the
> driver also assumed the opposite polarity, resulting in a matched pair
> of bugs that worked together. Updating the DTS requires updating the
> driver at the same time; old kernels will not reset the switch correctly
> when used with this DTS.

Sometimes we need to live with issues like this, because of:

> Compatibility
> -------------
> 
> Correcting the polarity creates intentional incompatibility:
> 
>  * New kernel + old DTS:
>    The driver now expects active-low, but out-of-tree DTS still marks
>    active-high, causing the reset sequence to invert.
> 
>  * Old kernel + new DTS:
>    The old driver toggles reset assuming active-high, which now
>    conflicts with the corrected active-low DTS.
> 
> This was unavoidable because the original DTS was factually wrong.
> Out-of-tree DTS users must update their DTS together with the kernel.

So the real question is, does this actually harm anything? Do we see
any real issues?

	Andrew

