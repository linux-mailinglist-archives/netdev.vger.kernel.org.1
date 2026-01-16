Return-Path: <netdev+bounces-250593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC15D383F8
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57ADB3042902
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83369338906;
	Fri, 16 Jan 2026 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="czOKsZ4p"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6983230D0F;
	Fri, 16 Jan 2026 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768586926; cv=none; b=Di0PgdZAjq9LGgmK+0z2b0MEedNyFD3ZqqHGrb1e16Obz2vjXH5POyjil0lbIJx4mXTtxkjeGdM9JB03Bf63sUb4/SP9hFh93+FSZ7tESdIMbjAVl/O7w0UoW100JxJf2FUP3zFoEoXdYEdixWwX/La0iVZLn81x3t5rH+ZUozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768586926; c=relaxed/simple;
	bh=JbpAk7nm96q2ucJt6fQNL6+1nRmms1uHBJJcqphNN/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtckE7oMHaAbygq8iLxNJfaSKeSRV1YysRS1WZ7UmeW+/IEMFo8BxVHYKnNOpFxMSeJPKVHds4TaxWj+784lY41jPB2TscH3RTey0SnrXx8nKUHZX6xWhAE1pXXK4UwmRy84YTq04N4r01KGVVF4EDPQJcHrKWn5gbqQN125MuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=czOKsZ4p; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rMSr8rpE6TXL8VId1UJJIMcjxvz+l9cVkHXKgGNXGQU=; b=czOKsZ4pEL+m12rvJSEQX3ENCY
	WGGDiIxep4Jy+Lux3W704sxZsTLeXQwBD+5bgVX7fXQIzvoR/lflnfA9DBwoSfH3B3+9UflPDxsNM
	GO7aLPgA3tIbC4bJPX5iybc/9DYkoE4ULTcSiXEIhc46LJnK26v3hU48AKiZMyoarTdC2+fGTUFRa
	7woR02y45qo2jB0apChCV1XV4tiiX1uWf32nOEnEL6/egfiOHcMLPhbQZcAlPaEMlD/PUneDoM29i
	9GjasNLKE8q4ela5NIstKa5Jvb8o/QbtUCt2oSayT6iL+qkatn0b0BmyTj+lRHK5Zizca7yLWoZ7b
	Cz9uNmhA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54658)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vgoFF-000000002ZL-3znI;
	Fri, 16 Jan 2026 18:08:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vgoFA-000000003nO-1jaq;
	Fri, 16 Jan 2026 18:08:20 +0000
Date: Fri, 16 Jan 2026 18:08:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Tao Wang <tao03.wang@horizon.auto>, alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out after
 resume
Message-ID: <aWp-lDunV9URYNRL@shell.armlinux.org.uk>
References: <aWd9WUUGhSU5tWcn@shell.armlinux.org.uk>
 <20260115070853.116260-1-tao03.wang@horizon.auto>
 <aWjY7m96e87cBLUZ@shell.armlinux.org.uk>
 <aWlCs5lksxfgL6Gi@shell.armlinux.org.uk>
 <6a946edc-297e-469a-8d91-80430d88f3e5@bootlin.com>
 <51859704-57fd-4913-b09d-9ac58a57f185@bootlin.com>
 <aWmLWxVEBmFSVjvF@shell.armlinux.org.uk>
 <aWo_K0ocxs5kWcZT@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWo_K0ocxs5kWcZT@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 16, 2026 at 01:37:48PM +0000, Russell King (Oracle) wrote:
> On Fri, Jan 16, 2026 at 12:50:35AM +0000, Russell King (Oracle) wrote:
> > However, while this may explain the transmit slowdown because it's
> > on the transmit side, it doesn't explain the receive problem.
> 
> I'm bisecting to find the cause of the receive issue, but it's going to
> take a long time (in the mean time, I can't do any mainline work.)
> 
> So far, the range of good/bad has been narrowed down to 6.14 is good,
> 1b98f357dadd ("Merge tag 'net-next-6.16' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next") is bad.
> 
> 14 more iterations to go. Might be complete by Sunday. (Slowness in
> building the more fully featured net-next I use primarily for build
> testing, the slowness of the platform to reboot, and the need to
> manually test each build.)

Well, that's been a waste of time today. While the next iteration was
building, because it's been suspicious that each and every bisect
point has failed so far, I decided to re-check 6.14, and that fails.
So, it looks like this problem has existed for some considerable
time. I don't have the compute power locally to bisect over a massive
range of kernels, so I'm afraid stmmac receive is going to have to
stay broken unless someone else can bisect (and find a "good" point
in the git history.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

