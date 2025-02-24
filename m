Return-Path: <netdev+bounces-169022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA91A421C9
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCDE188D2D1
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F47158870;
	Mon, 24 Feb 2025 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g7JUOe4q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B859157A48;
	Mon, 24 Feb 2025 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404911; cv=none; b=qu1DRRK4FZhyas5v/EP2jYC2c2ngibdOqxPoL1p1D+uMsW3rr96titrEKk6Yc+x9lC5cTCvAMXz6x6lpcpEQpsQrt+B7+zEOrsg6/59UyHSDx0FjahOARlpfR9kT29ZRzYC3brWUNWNGTLa6O2MCJxNWaBckplkBt4rtfha4li8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404911; c=relaxed/simple;
	bh=JRkq7wjYrgvh+yhnqspJzZKgEwp94XGB8+ID6BQtyYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiLR07Ln4gFj3S+4PQ3YwT/0myvp3ac0DWtxxZJsWSwtaAl9/dQKlZr4m4q5InIiRUC4kc0bJPBfmcI1XgaqxR3F+tobGjTQ7kqswqgyjwbB2WJS+7dJnTPKe30ck/V+ZmDG3PsWUHc7N7gPK3GCkVHmX378AMvnN6hI+/kTwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=g7JUOe4q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EQ1Y9woIJ04CcEe49xqkqna1RhXAAY88omG8TRUbg6k=; b=g7JUOe4q43m4jzeSptGOHh9Fxt
	baNOGbGELH05179VyqTjo+0LLnp9uJ2Ym+FP3yRGxy59ecyCXwfcU0g3f33+ZMXxvk/g5k98J2mCe
	BHdJFQqj6KOW9+D3U3FFqx6NyWmM2sHBZHfd2DpfsILsGmfxD3byxV+8T5+ZIZ4iNKhCl8/+hwdpD
	rMrXqBmH8Qh8zzfpyeXF7Lswr4IYul+b+WqV/lTDQgd/+DhgShbpuNuRvUM0uEMDLb+yGcctI1Tpj
	Qe0xwB5f8L7PErdbzebV7WktTc/Pc24wpsOiGP4Aj+FzcLoeA4WQ//CAmJ5VMPOLo859AzNAj+XQM
	70CSx78w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40326)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmYon-0006S9-2z;
	Mon, 24 Feb 2025 13:48:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmYol-00052k-1c;
	Mon, 24 Feb 2025 13:48:19 +0000
Date: Mon, 24 Feb 2025 13:48:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <Z7x4oxR5_KtyvSYg@shell.armlinux.org.uk>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
 <87r03otsmm.fsf@miraculix.mork.no>
 <Z7uFhc1EiPpWHGfa@shell.armlinux.org.uk>
 <3c6b7b3f-04a2-48ce-b3a9-2ea71041c6d2@lunn.ch>
 <87ikozu86l.fsf@miraculix.mork.no>
 <7c456101-6643-44d1-812a-2eae3bce9068@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c456101-6643-44d1-812a-2eae3bce9068@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 24, 2025 at 02:31:42PM +0100, Andrew Lunn wrote:
> > What do you think will be the effect of such a warning?  Who is the
> > target audience?
> 
> It will act as a disclaimer. The kernel is doing its best with broken
> hardware, but don't blame the kernel when it does not work
> correctly....

Indeed.

> > You can obviously add it, and I don't really care.  But I believe the
> > result will be an endless stream of end users worrying about this scary
> > warning and wanting to know what they can do about it.  What will be
> > your answer?
> 
> I agree that the wording needs to be though about. Maybe something
> like:
> 
> This hardware is broken by design, and there is nothing the kernel, or
> the community can do about it. The kernel will try its best, but some
> standard SFP features are disabled, and the features which are
> implemented may not work correctly because of the design errors. Use
> with caution, and don't blame the kernel when it all goes horribly
> wrong.

I was hoping for something shorter, but I think it needs to be expansive
so that users can fully understand. Another idea based on your
suggestion above:

"Please note:
This hardware is broken by design. There is nothing that the kernel or
community can do to fix it. The kernel will try best efforts, but some
features are disabled, other features may be unreliable or sporadically
fail. Use with caution. Please verify any problems on hardware that
supports multi-byte I2C transactions."

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

