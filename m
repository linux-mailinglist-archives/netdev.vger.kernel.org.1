Return-Path: <netdev+bounces-164713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D486A2ECC7
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709D81886FDF
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86596222594;
	Mon, 10 Feb 2025 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FCulMwwT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9917BB6
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191382; cv=none; b=q1yRdRu4CNF1QIaF2piJ6Wf2evjxTOrHZS1UbtTMTBOXsoB91ivIAHqkCi9dUVkPuAhPd4b9JJFVJSDpyGTn+BqKGP+F3xupLuHbifYz3GAEwwq9JVhlmZ552u1Aak++J+PdXqmOKPpdiDf64n0Bsn2BF0SGIXXWfMQNS5DDc3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191382; c=relaxed/simple;
	bh=vOfIRp3fOtCBNpYv9l8JZOUZfpkVIeIKSoj/diNbnDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQCBHJUHZAgTbBqg6arEwjmKdLs+dRQXpkSzmob9ojnQNQgItpmIhayl3F/CHPCM6wPeCmVXciCf18tmc4fXNCYH9uFzPwmVPfb0Om3+pfPA9KtYkMea541Wt8SXKWHaJWpj8ZHBHsAS9YAhIy/ydAUsu8jmW0UcmGlaQyPzAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FCulMwwT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O59KnZLHiovTg73M0ZN85RlgzlPGbqBmEqXvrhttMUc=; b=FCulMwwT/VBV5v3+qBMsFI55J7
	b51moXqXfLmADtv/ptciZ2Gc522ASRi943R6boXmbacSV9agb6T47gbTeWgKQQOmbXgOX3HYUbnuU
	2t/beNHojSmmxlD1jEomoyJx4oofpk2xhbQ5pJsbnfaZJajG4usN/LT8J+I6bBB79+X2UFAOWjBAw
	Uj5CqdeVa2qaqyNw50pRCia3+aKQPRMNcq1tnp6TkCYC66Mlc8Q9hj0VueZNWv4BuN7L4xNXzMMYH
	FXEplvE9d0WMzXoHX1Rq+tDM2CiA/7rEYG8H1LZvteu2XsP0itcGsGClsAxvrGjnPRp7uhu4Re9HB
	CZvSCC3g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50852)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1thT7f-0006rI-2K;
	Mon, 10 Feb 2025 12:42:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1thT7b-0007VZ-2A;
	Mon, 10 Feb 2025 12:42:43 +0000
Date: Mon, 10 Feb 2025 12:42:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 2/3] net: dsa: allow use of phylink managed
 EEE support
Message-ID: <Z6n0Qz788I_igV8M@shell.armlinux.org.uk>
References: <Z6YF4o0ED0KLqYS9@shell.armlinux.org.uk>
 <E1tgO70-003ilF-1x@rmk-PC.armlinux.org.uk>
 <20250207151959.jab2c36oejmdhf3k@skbuf>
 <Z6Yn2jTVmbEmhPf9@shell.armlinux.org.uk>
 <20250207213823.2uofelxulqxpdtka@skbuf>
 <Z6aIGzHWdzF5Rlci@shell.armlinux.org.uk>
 <20250210123701.7gdt56l5m6t5c6ge@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210123701.7gdt56l5m6t5c6ge@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 10, 2025 at 02:37:01PM +0200, Vladimir Oltean wrote:
> On Fri, Feb 07, 2025 at 10:24:27PM +0000, Russell King (Oracle) wrote:
> > You may have noticed that I'm no longer putting as much effort into
> > cover messages - and this is precisely why. I honestly don't see
> > that there's any point in spending much time on cover messages anymore.
> 
> I have things to do and places to be, and I'm sure you do too, so
> I won't drag this out more than I need to. I'll just give you one
> self-contained example of what bothers me, from this very thread.
> I'm not even expecting you to change all of a sudden, I know it's hard
> and takes time and a deeper understanding of what is happening.
> 
> First of all, if "I tend not to read cover messages" isn't sarcastic
> when you've make it pretty obvious so many times that this is important
> to you, then I don't know what sarcasm is.

Sorry, but I disagree with you on this.

I'm getting tired of having to tip-toe around issues like this, I'm not
going to spend anymore time on this thread.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

