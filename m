Return-Path: <netdev+bounces-159737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA4EA16AC6
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FFA16511D
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D011917F9;
	Mon, 20 Jan 2025 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eCMOUDU/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9242C14387B;
	Mon, 20 Jan 2025 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737369112; cv=none; b=MyVuVxqsQqwuVQYmxehyR1eN7vyo9Nq5fc7HaxpWUkZhUUlnJQ46a4kyfkmHSA5JJXJlIOnUf+44LnZik8BGuuToCw0XELsooxgxpmXFalwY2nDL2XYMmuo93ArU7E73OX2dMkqY5qEe/rvr7AVl72hFJmG6rMes6DI3PomEt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737369112; c=relaxed/simple;
	bh=3OSJh2lbLaRIho8p5Wbo5UPVcMvlIhJbPJPfYpIg7Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8bZSJ+Ntdn+Rw0rmuXSk5qkxDf5FWzcI/oDs2K9FVzJpaqQP89aM+SPMbY/b7a88NdgrcmwM1AhWhAm6OXk+kG2+dtN3MNlCXbb8PPHqt9r800BSfQ101nt5/QDcPcP9oYCUX6xNYNdkRZoWJ7eZxpiUQqC/fxiEjUjFpHkGzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eCMOUDU/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lFHC/CYom5ESj79czaxuMdfHVMXOg7rqSr8aOrueB/o=; b=eCMOUDU/OkuA42/u9CZSS/2AH7
	hOrLs9z0NAH7qOaDq8dcYzUu8IoiHuu8nngb1RoH6veRhjj9ZwSYA+KxOq0Cqh3TZv9+weCF1h0Pa
	sxdE/HknVw0NT1ZrK40GnUGRG1Mj4Zi2+CJ4S8DqyEb6bUOq7gzMK3y0IuTplLoO+r4SRicDvoeDU
	cP2uKXWv/1auCqKdr4ftOo5ZdBiwgJFpuAEzWUO9phTIK5lqsc+1cuR/K5Zh3qxjq7I8R3L40/Egx
	qot82WnLha2RwyRtAsDDJKkumQGJ8XqFsNKEOhyKFqSLGG99+c7WfCslYUE44TJJeu6Z1NyevwMbf
	lqpaarYw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55704)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tZp4L-00062a-2U;
	Mon, 20 Jan 2025 10:31:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tZp4I-0002mx-1w;
	Mon, 20 Jan 2025 10:31:42 +0000
Date: Mon, 20 Jan 2025 10:31:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: phy: Fix suspicious rcu_dereference
 usage
Message-ID: <Z44mDi3NqMONI6Yw@shell.armlinux.org.uk>
References: <20250117173645.1107460-1-kory.maincent@bootlin.com>
 <CANn89i+PM5JLdN1meKH_moPe88F_=Nsb3in+g-ZK5tiH4PH5GA@mail.gmail.com>
 <20250117231659.31a4b7fa@kmaincent-XPS-13-7390>
 <20250117190720.1bb02d71@kernel.org>
 <20250120103722.706b5bc8@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120103722.706b5bc8@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 20, 2025 at 10:37:22AM +0100, Kory Maincent wrote:
> On Fri, 17 Jan 2025 19:07:20 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Fri, 17 Jan 2025 23:16:59 +0100 Kory Maincent wrote:
> > > > If not protected by RTNL, what prevents two threads from calling this
> > > > function at the same time,
> > > > thus attempting to kfree_rcu() the same pointer twice ?    
> > > 
> > > I don't think this function can be called simultaneously from two threads,
> > > if this were the case we would have already seen several issues with the
> > > phydev pointer. But maybe I am wrong.
> > > 
> > > The rcu_lock here is to prevent concurrent dev->hwprov pointer modification
> > > done under rtnl_lock in net/ethtool/tsconfig.c.  
> > 
> > I could also be wrong, but I don't recall being told that suspend path
> > can't race with anything else. So I think ravb should probably take
> > rtnl_lock or some such when its shutting itself down.. ?
> > 
> > If I'm wrong I think we should mention this is from suspend and
> > add Claudiu's stack trace to the commit msg.
> 
> Is it ok if I send the v3 fix in net-next even if it is closed?

In general, fixes are still accepted into net-next if the pull request
hasn't been sent and the code that is being fixed is only in net-next.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

