Return-Path: <netdev+bounces-108378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFCB9239F7
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D681C20DE3
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4055155308;
	Tue,  2 Jul 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DSjusU7u"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC615444E;
	Tue,  2 Jul 2024 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912493; cv=none; b=P+msmPuVKiwZR0tIkfXfdj7AtosASyVWHqeKRiaK7Seon4EVA33NbWMIYdcv+U46ADI9FyQg+fmSTrMxJQNGqxHYj1AljqGtmYoRuxRgSqbYbcrC1v6rGlmpZ8xcrtzQZVdZHbkfcXR7PhK1YesmjLcEe6ChqbYDl6p1X/GZPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912493; c=relaxed/simple;
	bh=WMPJSPY00Wh7PMJiDcqctpCqDzLBeoiJpvnvJS9wv0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZ6i8RL/PQ92UxUZn4t+EseYkV4hoCVayBrljxz5Qkh9gDAXPi+I8h5TyqlG9XwZor33AXpB9oOTGhGWmOnKG7t/6ShjT+uSlUFCn+1LXsT6DVs8oaWed6jeBXOKsRqPlAwlXT7jvefq79qndPe1RVIJr+EvYFdM53SD+RaKopk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DSjusU7u; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PahHamLsQ/RiSPoMRbagWEDaWPdmmxniY36WLNddZ5M=; b=DSjusU7u10DfSzmgMKko3V+fL5
	cN/U1k0poc5s+8VR1nJyNnEdyih6tA4ms84cB2FiTuayh5ydonRhwJnnxGiSIxNGl5LNX96PZ8D5w
	U2hGIwWq5mtjWxa5BQiNGerSML0DUkoKPxuXu+k9ElJ3KQeNQm3WRkODPDFPfdmuYSz/IVvCzvvmK
	ZaZYA+gUILqSDLaPviRYitO0JUm01xmiYH6PwERnxiwZSrv9CRv5S3CMhiwSfqAPgIjUZphpQU/WN
	9NbsTTj2YUlxryBkkYL5GjzCtYMuwBwwli2VyFXhAP8Z7fMC9pxe+xaBlI9EFeBxc4eXg7FJOt/1Q
	9Vf4KhSw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50588)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sOZns-000372-0z;
	Tue, 02 Jul 2024 10:28:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sOZnv-0001pj-OF; Tue, 02 Jul 2024 10:28:03 +0100
Date: Tue, 2 Jul 2024 10:28:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] net: phy: dp83869: Fix link up reporting in
 SGMII bridge mode
Message-ID: <ZoPII06HRwBpjVVs@shell.armlinux.org.uk>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <20240701-b4-dp83869-sfp-v1-6-a71d6d0ad5f8@bootlin.com>
 <289c5122-759f-408a-a48a-a3719f0331f9@lunn.ch>
 <8435724.NyiUUSuA9g@fw-rgant>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8435724.NyiUUSuA9g@fw-rgant>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 02, 2024 at 11:04:37AM +0200, Romain Gantois wrote:
> This raises the question of a potential race condition when reading
> mod_phy->{link, speed, duplex}. I haven't seen any kind of locking used in
> other parts of the net subsystem when reading these parameters.

Drivers access these under phydev->lock due to a callback from phylib
which will be made from the state machine which holds that lock.
This includes phylink.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

