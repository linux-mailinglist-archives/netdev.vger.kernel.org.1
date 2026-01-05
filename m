Return-Path: <netdev+bounces-247143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55377CF4F02
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 753C83009D54
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FE930C359;
	Mon,  5 Jan 2026 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TD43Gf2B"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF281EACD;
	Mon,  5 Jan 2026 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633232; cv=none; b=PmzrjgUQMLqHRIRSk80tzHW+uSvW/53ODm9u1pFTIlWDlKU+uTF5UKeS44tu77Yoc1EmasT/qE+thr+veobgES105ugjfNrM8spqjXqRt8ra/6cxCQU93XRsh5juF24Qh4bJ63ueDArL1f0tUSii8h/naK7aGH55zR6PdtKqofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633232; c=relaxed/simple;
	bh=tyr4cn0jOghbwju0lZCBopNZ7oA6fmticVyw7sTQVEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap7dpEBupzDB3TqSOkwnkt4tJytlZh4WmZlL8uw3yjcVR9sWibUCzmUaVC+cdUJyPtN4zxJ//eKpLMm2BzId7af2PAxCRfeSwbl6cW3o0TRhi9EYkagzQWppIcBaGCotFniJqANDRyrFpL4B9BZIlWAmGMXuNaDnozmip7BpagM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TD43Gf2B; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JVvbf6VOOy5SlB6SsQX22t386bNPBzzZILoui+6wI4U=; b=TD43Gf2BisI77yaOolzQqByA+2
	xB/NRJx2wlR48HnP9b1rtuGb4EXqz+y+2yf1rONl2yTtfQvLv3OV0i4oa9EfRju/rG5glojzVgwBt
	+do0k240zNza+fOvX7ilC1ar9+JhDgihL68YVEm+LAmiOSXLJ63eDdA1L/SvWM9etxXJWSKhx+Pdr
	TNVFQTc9OfWnN6LVQVgOoR5TgF7FR4io74ButH9s05/XQIbaomvPmJZJiXiKsluAnj0B1HMAZcZdF
	SUXWQo9ci+/xjk8NTF5Eo3IY0bQfTnKVSH6TBLf1V7mN+oMhj7JEdd9UeOlmLS/UD4nI/TJZ/x0M+
	gkmSAi4A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42846)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vco9K-000000008Ad-2CXW;
	Mon, 05 Jan 2026 17:13:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vco9J-0000000082C-0xLP;
	Mon, 05 Jan 2026 17:13:45 +0000
Date: Mon, 5 Jan 2026 17:13:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v3] net: sfp: add SMBus I2C block support
Message-ID: <aVvxSa2volDcLPZE@shell.armlinux.org.uk>
References: <20260105161242.578487-1-jelonek.jonas@gmail.com>
 <aVvmu1YtiO9cXUw0@shell.armlinux.org.uk>
 <3c774e4d-b7a6-44e3-99f3-876f5ccb1ca3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c774e4d-b7a6-44e3-99f3-876f5ccb1ca3@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 05, 2026 at 05:53:42PM +0100, Jonas Jelonek wrote:
> Hi Russell,
> 
> On 05.01.26 17:28, Russell King (Oracle) wrote:
> > On Mon, Jan 05, 2026 at 04:12:42PM +0000, Jonas Jelonek wrote:
> >> base-commit: c303e8b86d9dbd6868f5216272973292f7f3b7f1
> >> prerequisite-patch-id: ae039dad1e17867fce9182b6b36ac3b1926b254a
> > This seems to be almost useless information. While base-commit exists
> > in the net-next tree, commit ae039dad1e17867fce9182b6b36ac3b1926b254a
> > doesn't exist in either net-next nor net trees.
> >
> > My guess is you applied Maxime's patch locally, and that is the
> > commit ID of that patch.
> 
> This was supposed to be the stable patch-id obtained with 
> 'git patch-id --stable'.

Hmm, didn't know about that... but in this context, I wonder how
useful it is. As a maintainer, given that patches submitted don't
specify their patch-id, tracking down which patch is the
pre-requisit would be a mammoth task, whereas a lore.kernel.org
link would indicate the pre-requisit immediately.

lore.kernel.org links are easy:

https://lore.kernel.org/r/<message id of the email containing the patch>

I can see patch-ids are useful for automation, but lore.kernel.org
URLs are useful for humans.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

