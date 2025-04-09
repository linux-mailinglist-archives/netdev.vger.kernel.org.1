Return-Path: <netdev+bounces-180767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631C1A82659
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BCF1B88925
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E525484B;
	Wed,  9 Apr 2025 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="G0W4MyNw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72498433C4;
	Wed,  9 Apr 2025 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744205734; cv=none; b=RVIOlH16qSW+ge9q1gj9eUc5rC7lo3rDUH6nUnfqOsthWW+cVj2qKrKmlAAKD7NbrszKJnbwyNhODeU9Kdm/67DuQIrfhAp+3+1XX7AqCE06+ImlEDZtLO/rPZMX2aBfhv8FRr6rS0J+t043DY7wMHWqJNz+EKEjz1mL6J5e3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744205734; c=relaxed/simple;
	bh=Cr1i7QuEckUmeD+MKDGZjYqbAOuv4cMLcJYoRcPCq44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieCKWEyT/RIF24kCkI5wBVhyaKgyRvm5c4vYq3VM9Wn7zaltmYxpcgA6id2bXT9q+nOW2oPeUPzOavd2aOzLZZG3TXl1W+XKJ25LyFDM4MBV1TdCmuXlytHpmALfWMgeULusXr1kR5VmJrq1y3JQGna3oxHlYR0OOimFxkd2K+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=G0W4MyNw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RwIdYiiW5ktOZ+Nc8/rs0JZc6lh8LeCykoSCmOQ2Nog=; b=G0W4MyNwxaD/LuM37kAc8j7r/p
	ZC7hWOqY5d3s8YVdHMOTzQTfouyv5HVHB6bIm1PcoYVFnGfc2VSJ4rg1dRfjsZzVXZ5d2tiiORHx0
	S1f7aYN5pxnKF40ctg5Z6QPEwXppaatAVTDL4B1mbf6COfabaHVx1Nn2tKhnxrxcs84tgF9ReXbm9
	6eZH8pT2hhRmHQQP4n0Jow0wETS29VkHCVM9NZCFteP+z7vHT/msNKKEoJOQayVapkgYPRlVJEXd/
	Ok/ZdnemX31jvsl4U7Qnw38FNFryOs0tpMxxShFOzq0xYB0nEi3kOIflbVx4jAbGLm3TIFabK3b8B
	bgKYPSkw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50930)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u2VaL-0000Z8-0i;
	Wed, 09 Apr 2025 14:35:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u2VaI-0002be-06;
	Wed, 09 Apr 2025 14:35:18 +0100
Date: Wed, 9 Apr 2025 14:35:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <Z_Z3lchknUpZS1UP@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
 <20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
 <20250408154934.GZ395307@horms.kernel.org>
 <Z_VdlGVJjdtQuIW0@shell.armlinux.org.uk>
 <20250409101808.43d5a17d@kmaincent-XPS-13-7390>
 <Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
 <20250409104858.2758e68e@kmaincent-XPS-13-7390>
 <Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
 <20250409143820.51078d31@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409143820.51078d31@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 09, 2025 at 02:38:20PM +0200, Kory Maincent wrote:
> Ok, thanks for the tests and these information.
> Did you run ptp4l with this patch applied and did you switch to Marvell PHY PTP
> source?

This was using mvpp2, but I have my original patch as part of my kernel
rather than your patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

