Return-Path: <netdev+bounces-175398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC6DA65ABE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EE5189698E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A884199E94;
	Mon, 17 Mar 2025 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zWnuJKr0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679C1598F4;
	Mon, 17 Mar 2025 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232381; cv=none; b=aHOFfQTXZC7sP7oK1rjbcvuWVXpufWDlCFcPljUnTKm0JoU8TMJb6KVT46rVnHVdQhMOzn82zOVXmEHrtMOY9GTErgB7WwNo/mypXIVKNJ9T1GSvVmY4okOylErOSKmLO2UZOD4CsndmXJxTHSO/KU4bbV7DFHd8nVDoguw1BBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232381; c=relaxed/simple;
	bh=Zdnk8+u2UNNmWlp1HDJAd4/7g37MB+blyQvMNcfb8qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8Dz0Zeotu2YDr4FGeX7mdv7/mpwROv11N4WXS9HvyF5p4mMAxffrHucH10z+EZZ84Dfcyn37IW88FQJELjBXiXVN2zKRAgRd0fWf7ropvoLqnoGqgs3Qq5BzwMED8zYlzHN6nJqopAj3UtBvMk9einW68Y4Si1x3hKgGMbpm34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zWnuJKr0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Vf/rrfmUh/cN/Ci7m3WrKzNaadewo9ODJy0hAZOm2A4=; b=zWnuJKr0IugatZKsug7ygJbpSO
	NdBk+dQLucfakdOOgM28zZG3u7JeGLu6KxYRxprAMuTgXy/4T4vYbAf9hV+B/FxQudELPTOsXdU/1
	6yoMZhoXLIjPC8YSOJGHNBIzQkisPQflFA/7BR6mq3Jhsjw0iX7ggDkIgzjXDHS70RufjEj/agih1
	w6hvi4MTaaU/YzuQ0kOExwY+jMaOQv35bL6ltsXZwAVfgcbyoZYACeONFZY99buykM+3X82enhyQc
	jRnK4d5m/zfSiXgOhblp82tPjFLczmHwRetTA8NdZ5Q5XG/2r1/GycAazwE/AdRFzPeIKeFQFyIjj
	MKWxrYFg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39368)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuEE2-0003ss-0E;
	Mon, 17 Mar 2025 17:26:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuEDz-0003jn-1O;
	Mon, 17 Mar 2025 17:26:03 +0000
Date: Mon, 17 Mar 2025 17:26:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Michael Klein <michael@fossekall.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next,v3,2/2] net: phy: realtek: Add support for PHY LEDs on
 RTL8211E
Message-ID: <Z9hbKy6SuARPvmXf@shell.armlinux.org.uk>
References: <20250316121424.82511-1-michael@fossekall.de>
 <20250316121424.82511-3-michael@fossekall.de>
 <Z9gEP_w6WvuCC_ge@shell.armlinux.org.uk>
 <Z9haewIdFv4bed3H@a98shuttle.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9haewIdFv4bed3H@a98shuttle.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

On Mon, Mar 17, 2025 at 06:23:07PM +0100, Michael Klein wrote:
> I don't think this needs to be atomic at all, as the phydev lock is held by
> the one and only caller (phy_led_hw_control_get()).
> 
> rtl8211f_led_hw_control_get() also uses set_bit(). Should I change those
> also to __set_bit() in a separate patch while I'm at it?

Yes please.

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

