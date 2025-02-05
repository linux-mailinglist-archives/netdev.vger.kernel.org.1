Return-Path: <netdev+bounces-163162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1651DA29733
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22393A91D8
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E81A1FE46A;
	Wed,  5 Feb 2025 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pgmqVB/Z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FAF1FDE1A;
	Wed,  5 Feb 2025 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738775969; cv=none; b=UugemeMQ8odS2eU7NkTpPw+LyiLgzSGhgQGZKKFEtK97zXgdBvsDdF8QXNpgP2lBXY+fcNG+69NqsQzpX8VwoW7R0nNGhcy2xAqH1PONIGZQDMkKk+XrqWZdc/87L1aWNx/IMMFCUQAG3q7++geRkQBLWHaqywMa0CD77ZPF9MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738775969; c=relaxed/simple;
	bh=X6ZZtEEzGbsZyJHzn8XWujTaW2SL9LiXtco1lmTFlps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdFNwNJjNIFthVXBFAYZB7rIhCKyInGYxoLLmzLB1z1hJKK2qOzrXr0tB8BS5zpAJzIrQZa0rA5dALPD/uhXhUxf/d0Gz4cst6g/p1M4LQvv3hh9EQUT9l5ZcRnbavLxh0BCvQR81cMmCFrbXU8qw502V6Cp0v+JojOb2P/dZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pgmqVB/Z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Xzxj+9Kifo30L/NU1Tdw9PE4UUuu1WfcX58E05d3vJk=; b=pgmqVB/ZuHIMgwVi0jNCFJ/Bc1
	0K3UQ07i4Men1G2g713jF15OrcimNF+d1E3LgJgIF6wNFFhVquZURz1ihjMxHDdkieeHpn3WilX7D
	+JwQGkMMy707USbo4CVYnvzv22d+VUmg/JoBApJwOYVV3VIuguP7TXyj/fXof3OzOi6Y+aiRbQQoq
	dHxEdS1s/nM2j2kxssPLACMR3a+6NLyGX8NwqKD3OvEu/k5dXvvpodRdFueOLmU2vnIyuFwSDDVko
	pKXTSwGVBMJUHvpoR2Uy3T7a8AzYHDlTqBO8dDbk9j1IkD64wdDJiKj1oC5qiUeX+0Tm6gZaQ7O/A
	9D3UFDjQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57364)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tfj3U-0007oq-1H;
	Wed, 05 Feb 2025 17:19:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tfj3R-0002ak-1Y;
	Wed, 05 Feb 2025 17:19:13 +0000
Date: Wed, 5 Feb 2025 17:19:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: kernel test robot <oliver.sang@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [linus:master] [net]  03abf2a7c6: WARNING:suspicious_RCU_usage
Message-ID: <Z6OdkdI2ss19FyVT@shell.armlinux.org.uk>
References: <202502051331.7587ac82-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502051331.7587ac82-lkp@intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 05, 2025 at 02:08:04PM +0800, kernel test robot wrote:
> kernel test robot noticed "WARNING:suspicious_RCU_usage" on:
> 
> commit: 03abf2a7c65451e663b078b0ed1bfa648cd9380f ("net: phylink: add EEE management")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

I think there's multiple issues here that need addressing:

1) calling phy_detach() in a context that phy_attach() is allowed
   causes this warning, which seems absurd (being able to attach but
   not detach on error is a problem.)

This is the root cause of the issue, and others have run into this same
problem. There's already been an effort to address this:
   https://lore.kernel.org/r/20250117141446.1076951-1-kory.maincent@bootlin.com
   https://lore.kernel.org/r/20250117173645.1107460-1-kory.maincent@bootlin.com
   https://lore.kernel.org/r/20250120141926.1290763-1-kory.maincent@bootlin.com
and I think the conclusion is that the RTNL had to be held while calling
phy_detach().

2) phy_modify_mmd() returning -EPERM. Having traced through the code,
   this comes from my swphy.c which returns -1 (eww). However, as this
   code was extracted from fixed_phy.c, and the emulation is provided
   for userspace, this is part of the uAPI of the kernel and can't be
   changed.

3) the blamed commit introduces a call to phy_modify_mmd() to set the
   clock-stop bit, which ought not be done unless phylink managed EEE
   is being used.

(2) and (3) together is what ends up causing:

> [   19.646149][   T22] dsa-loop fixed-0:1f lan1 (uninitialized): failed to connect to PHY: -EPERM
> [   19.647542][   T22] dsa-loop fixed-0:1f lan1 (uninitialized): error -1 setting up PHY for tree 0, switch 0, port 0
> [   19.649283][   T22] dsa-loop fixed-0:1f lan2 (uninitialized): PHY [dsa-0.0:01] driver [Generic PHY] (irq=POLL)
> [   19.650853][   T22] dsa-loop fixed-0:1f lan2 (uninitialized): failed to connect to PHY: -EPERM
> [   19.652238][   T22] dsa-loop fixed-0:1f lan2 (uninitialized): error -1 setting up PHY for tree 0, switch 0, port 1
> [   19.653856][   T22] dsa-loop fixed-0:1f lan3 (uninitialized): PHY [dsa-0.0:02] driver [Generic PHY] (irq=POLL)
> [   19.655392][   T22] dsa-loop fixed-0:1f lan3 (uninitialized): failed to connect to PHY: -EPERM
> [   19.656689][   T22] dsa-loop fixed-0:1f lan3 (uninitialized): error -1 setting up PHY for tree 0, switch 0, port 2
> [   19.658308][   T22] dsa-loop fixed-0:1f lan4 (uninitialized): PHY [dsa-0.0:03] driver [Generic PHY] (irq=POLL)
> [   19.659841][   T22] dsa-loop fixed-0:1f lan4 (uninitialized): failed to connect to PHY: -EPERM
> [   19.661168][   T22] dsa-loop fixed-0:1f lan4 (uninitialized): error -1 setting up PHY for tree 0, switch 0, port 3
> [   19.663018][   T22] DSA: tree 0 setup
> [   19.663591][   T22] dsa-loop fixed-0:1f: DSA mockup driver: 0x1f

which then causes phy_detach() to be called, which then triggers the
"suspicious RCU" warning.

This has merely revealed a problem in the error handling since Kory's
commit on the 12th December, and actually has nothing to do with the
blamed commit, other than it revealing the latent problem.

The "hold RTNL" solution isn't trivial to implement here - phylink's
PHY connection functions can be called with RTNL already held, so it
isn't a simple case of throwing locking at phylink (which will cause
a deadlock) - it needs every phylink user to be audited and individual
patches to take the RTNL in the driver generated as necessary. I'm not
sure when I'll be able to do that. It's also a locking change for this
API - going from not needing the RTNL to requiring it.

This is probably going to result in more kernel warnings being
generated when I throw in ASSERT_RTNL() into phylink paths that could
call phy_detach(). Sounds joyful.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

