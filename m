Return-Path: <netdev+bounces-178351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2561AA76B2D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69AF16509C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06EE1E5205;
	Mon, 31 Mar 2025 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DgMueHDB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B9E1D86DC;
	Mon, 31 Mar 2025 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436011; cv=none; b=U+B2MRPzO4Pb9OFbUA/Hk9Y2ldSs3C1W0aWDu8cWESYfps9n9zWaWOZAI6PPH5mLbT2gX+CdsmWgn5aAbxQAGlzEZMMmaWNcPjtsd11V94M6XF5yelfngKVk81MYbvf8u7Ctb/dG4f1bwSautD88WXLfwbQE8SlccwgDHjE3eh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436011; c=relaxed/simple;
	bh=emXkUbgE8MVzGLBk2RVKXFHm2NMJr4hUC2wxeOb8Mg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYzUab4bhKiWPhvy/aRNECtjwqcraEphYnCD9/1yQI1gLR/tukMzi01oDJeyZf118i8Mb7IZJ1ECZt7LWKTFq5Dm4sXfmC7V4aEOAend0eTjssvGgL2G07wR+mYVHHWev+R5xLGe75v+FH/a6/1MFZ1kK+AQEMpdVcUq2uHtKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DgMueHDB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/RIn76to7xQh3pV8PsUoXbdo1tiWwXNcnef1bbKAlj8=; b=DgMueHDBI2vx35xZid++Vy7OcT
	UgNy+N+iQw/NilAVGMSubVYgfKVuhW9SgzdofXwqIDuculOtf0G4qoU40Kv59Y5OpB2//fb1eWz3b
	9jjZEdBXHbtgANOpmFikUIqahM0pEWbiLjpfE0z1TI84sOf8SjXnN+Z1kuMxbZsFnRs40WuNbpoxU
	JNhLNVvu7APn10b88lPVmgK5wXsGkOt8v/lzBnx1c0sMZlfjpLQQBk0neWURHQJcWXi1eAT2bHXGv
	PqELTtHH5lu2DD84LsphcP/NZNDAVvsAceEYIocV4aqlrbV1nXV8cku/vM7gQWCq2LfUJVlAne1hP
	DHPwPnRg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47642)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tzHLZ-0004M6-1H;
	Mon, 31 Mar 2025 16:46:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tzHLW-0001nm-1i;
	Mon, 31 Mar 2025 16:46:42 +0100
Date: Mon, 31 Mar 2025 16:46:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: pcs: lynx: fix phylink validation regression
 for phy-mode = "10g-qxgmii"
Message-ID: <Z-q44uKCRUtWmojl@shell.armlinux.org.uk>
References: <20250331153906.642530-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331153906.642530-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 31, 2025 at 06:39:06PM +0300, Vladimir Oltean wrote:
> Added by commit ce312bbc2351 ("net: pcs: lynx: accept phy-mode =
> "10g-qxgmii" and use in felix driver"), this mode broke when the
> lynx_interfaces[] array was introduced to populate
> lynx->pcs.supported_interfaces, because it is absent from there.

This commit is not in net-next:

$ git log -p ce312bbc2351
fatal: ambiguous argument 'ce312bbc2351': unknown revision or path not in the working tree.

Checking Linus' tree, it's the same.

Are you sure lynx in mainline supports this mode?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

