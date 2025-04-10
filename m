Return-Path: <netdev+bounces-181125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1885FA83BA2
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F768C3F41
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455B0204687;
	Thu, 10 Apr 2025 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ooGCdbGA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08611F1932;
	Thu, 10 Apr 2025 07:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271064; cv=none; b=DzBYRVmJM2UC2aM6kzJELoJnsKk4qjhb5VExbcPToP5g0/fH9r81/HqxS8t1q60am8k9Z6ZbRezQtSTgHpYFPAU1+XvbQcdZWq8FYsU0cO+XA3eGYR8IimnUmKK825OWLBETZuX0+qAPRqYM3WtBu5011PWzRzbso4P2oLtEdvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271064; c=relaxed/simple;
	bh=c3tSedszmM1WRObiVCTtdoG+H36ZRB/JWvXBI6pWIy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpD2wxSY+R6xEEmpAcCwHnqyoVuE9GP1zQWd+r3fFoR1M2Ewq55TvXwdOTgLEPx2C9LI1LtErQJaiOR3ZzL83ow/wsNQeS3RhkkI+wzHSRAQPcZWm9dtNTIDqvDPqGWOsZd7JNh1TQh2JS5L3yKcosjGenDhTQQVd9UlzGLTeV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ooGCdbGA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g7ze1sHwoMMFf5hsA17KXxvHh/sfNEypSsSsinv7WnM=; b=ooGCdbGAuSlV5t67xMBev2+Yw3
	v/xm/DoszcgeMLwzEyWPaYpyx19fn8Io47aWwDAbU389878I3Szj5TsXmFleDIg/CkPFRVO8SGK2g
	zBFxrFz7sCWdpjh1tfWzT4A0l3vbkYXZWdozRt50ZmtphGtdyrqL/JmldBL0xCtWCfc+QqdGkYOyD
	BQLhrmwIjT0pwk+oeji+qfDdq4qb3f6m4rQIyD4qWWkmVOcD6EYwiFvSZB4b7uebzpy7nWS9LZtAa
	Z9I6m8uu99tz2j3hPRs+ZJfB+suxH/sIi3sDdsEmeaG/mlttQFEyMh962ttCjwfXzJSNQpXaUUgKa
	WLzE4TuQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50790)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2ma2-0001Vy-0D;
	Thu, 10 Apr 2025 08:44:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2mZz-0003Pn-07;
	Thu, 10 Apr 2025 08:44:07 +0100
Date: Thu, 10 Apr 2025 08:44:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <Z_d2xntJMPQYGQ6T@shell.armlinux.org.uk>
References: <20250409101808.43d5a17d@kmaincent-XPS-13-7390>
 <Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
 <20250409104858.2758e68e@kmaincent-XPS-13-7390>
 <Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
 <20250409143820.51078d31@kmaincent-XPS-13-7390>
 <Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
 <20250409180414.19e535e5@kmaincent-XPS-13-7390>
 <Z_avqyOX2bi44sO9@shell.armlinux.org.uk>
 <Z/b2yKMXNwjqTKy4@shell.armlinux.org.uk>
 <Z_dGE4ZwjTgLMTju@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_dGE4ZwjTgLMTju@hoboy.vegasvil.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 09, 2025 at 09:16:19PM -0700, Richard Cochran wrote:
> On Wed, Apr 09, 2025 at 11:38:00PM +0100, Russell King (Oracle) wrote:
> 
> > Right, got to the bottom of it at last. I hate linuxptp / ptp4l.
> 
> So don't use it.  Nobody is forcing you.

What else is there to test PTP support that is better?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

