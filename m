Return-Path: <netdev+bounces-137516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CF39A6BC8
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A562B2811AE
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A971F940F;
	Mon, 21 Oct 2024 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r4kvZTeQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6451F427B;
	Mon, 21 Oct 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519900; cv=none; b=EsUnpJFl2UkbSJbvVSJnVlLDrVQy34nMwDqqVZFOR0oelBbRsNRqj8tFpLtgkN1jm/TiRBUymLZA4zVwzHu7HIlVnVOnRrLPU+djSzG7VcOmUD28mDy/i0RavxTgX8Kl9eauPqe8HUpU0ZuLJKfGt6PuVnhq+q5N80PnLhegOEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519900; c=relaxed/simple;
	bh=r12XCv7wGjmgJ0EEIi5AyKG2WXF2DeRO+CdRaxJvlks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhgZnEmp4s0J3azxZ9InIUgrIhgmwkOelg4i0ESFnzAyHqHx/CgQrKVTs1N0dMPE2BWxuVfOV6rEQsBqXf5uzH8PRX+xXa6TDhYiqt0O64C+Itdr7hYAfz5G8kA+QaRe8yYWbSNZRD0YKAZtIhrMbLplhU+FzzmhkvBJy/YJeTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=r4kvZTeQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7K5v5ZY4zeUHGzQFv6PebieE5LwgNrwfdhsPGijF2ik=; b=r4kvZTeQKPzFsBGVTHgUYy+0YZ
	ppHjYn/ra/ADYAFKKcXttGtKerJ0yHoFkifnPIDSWcbYyen3gPlZEsb5pfadAclUgpZ1S95wWPp5z
	zj7eCkHk3gGPdtKeWXF8Bjt3ZQlZwk49URuG9iBm0VgI7/SL01YYkxBB9gIBq+elopD0mm1bsY4qn
	U4445THvEsbgpn7Chu5aBzbbLF6/eebtS7EgN1cYHd4nhjss5Ciz02OPw27K9nRAROvjEfhflzDGf
	0/2yiYpzzn7ho0MMzChf6ErEfEy4i8V7vZP44n2tOY5LNEGmufxRddaadDF70Ebglscw59n6xN6pT
	RGK1uTPQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51242)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t2t7w-0003V4-0Z;
	Mon, 21 Oct 2024 15:11:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t2t7p-0001n9-0G;
	Mon, 21 Oct 2024 15:11:13 +0100
Date: Mon, 21 Oct 2024 15:11:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 0/4] net: dsa: Add Airoha AN8855 support
Message-ID: <ZxZhADBe6UtdCTsu@shell.armlinux.org.uk>
References: <20241021130209.15660-1-ansuelsmth@gmail.com>
 <20241021133605.yavvlsgp2yikeep4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021133605.yavvlsgp2yikeep4@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Oct 21, 2024 at 04:36:05PM +0300, Vladimir Oltean wrote:
> On Mon, Oct 21, 2024 at 03:01:55PM +0200, Christian Marangi wrote:
> > It's conceptually similar to mediatek switch but register and bits
> > are different.
> 
> Is it impractical to use struct regmap_field to abstract those
> differences away and reuse the mt7530 driver's control flow? What is the
> relationship between the Airoha and Mediatek IP anyway? The mt7530
> maintainers should also be consulted w.r.t. whether code sharing is in
> the common interest (I copied them).

That thought crossed my mind while reviewing patch 3. I compared the
PMCR and PMSR, a lot of the bits are in completely different places
between the two. I didn't check further, but I got the feeling that
would invite more complexity.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

