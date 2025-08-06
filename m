Return-Path: <netdev+bounces-211877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C0EB1C25D
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 10:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0072517EE01
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 08:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1D128936D;
	Wed,  6 Aug 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FJo4m6/T"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8296728935E;
	Wed,  6 Aug 2025 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469877; cv=none; b=uDLd/z7Qv3D6jJgVBf4n5ARh1IndvRaJ3XvQgK5kHRrfvQAmA0PZaWA5JcuG6f/MLqJfCAxWfsLWAFj7oRo8CCHw9ADtzBCA2S8qEVImAUl7KDZ3GOXT2QqL47a44nSwKFv0Ecr87Rb2zdboSdYL1ifaqoK2K28cG0BowTBI//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469877; c=relaxed/simple;
	bh=CP3h8Lc8njlj7m8rnC8OndIEcQXFhbbaQA9TH2hM0BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS6X1a9zqGe0p1ofk3qvNdEdQZsPtkuxycy2o5ps+KtVVZJo26v+y8p0kpSN3k5Map8CMvpNSqRziwFpXeE0EbR3BFZR+Q9HfHybRaLYGy7PpRlTFO8pks/SMoHh68CNG9rsDC4naa/9cKC++pTLPYJHZHjFmc9OamQ6tdn6mNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FJo4m6/T; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KyDgPEp/vws6x122KKmmj6wfpLYLRnvnvpCBkaQTM90=; b=FJo4m6/ThqNJph/Fcd9X54KLv1
	LgYe6+gq//bPRGKMTWkj+jExA6Jt1kuPxVlkqsuW20kq0hgZ/xyy/SJC5Ivh6e7gF26kKjovKvXK1
	CuJ8fUNeHcFgI6QB0oSwVVTKlykvtzgALDMZkyjYWZiYy4R0AKK10eZAzXgREIZgRjG1uJIfDrTU1
	zBbhHeVjudR+tGbNLBR8aUlSUx78I6rKe+LbeXqY1+a70Y4XxdrjU7OC5ondDXUEuQFeb4N51BE6Y
	10AmNAfTVkh83X4NTu5HchB2XDXrUBfofpBwCPztq3ur5tLDELqc5Cn2wUkm/0ankuAl3C3YYvBzg
	alNKA1AQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33448)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ujZl7-0004HS-0f;
	Wed, 06 Aug 2025 09:44:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ujZl5-0006y2-0X;
	Wed, 06 Aug 2025 09:44:27 +0100
Date: Wed, 6 Aug 2025 09:44:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, o.rempel@pengutronix.de,
	pabeni@redhat.com, netdev@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <aJMV67LWuHXExNLa@shell.armlinux.org.uk>
References: <20250806082512.3288872-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806082512.3288872-1-xu.yang_2@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 06, 2025 at 04:25:12PM +0800, Xu Yang wrote:
> Not all phy devices have phy driver attached, so fix the NULL pointer
> dereference issue in phy_polling_mode() which was observed on USB net
> devices.

When the network device bound to the PHY, either it will be bound to its
PHY driver, or to one of the two genphy drivers. So, this shouldn't
happen. Please explain how to reproduce this.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

