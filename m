Return-Path: <netdev+bounces-132243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AFA991171
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C85AB2493C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD501AE012;
	Fri,  4 Oct 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bZJyBOUO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32AE1AE00E;
	Fri,  4 Oct 2024 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728077188; cv=none; b=pWJu67nAubhLeg3GPIqj9Rk9A6R4rwIU//r+oofEqrJY9hMhuPc4UmD75fW7Z+OEsxy/VCtVlnYTS7T8GfcjGxJrzx670Z3Yyqwz9VAFaPmyc1BHXkvVFykYor+pyF4/vKBSqMqGDJ7Wuc2ZaCQ5cxwpaxAV3pxmfJrMW6thR9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728077188; c=relaxed/simple;
	bh=i7IKJ5Z++uwc/zj5PeCouwzc/5+BYJMSYcRAJ261usg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrlBYYvyMxb+TwN3sWaCj6gJ1SZLEZx/W8SKNRlfhKqY4Zk8MkhTtpkrDmzC9qomz7WQT1O1ehvdh+5LIQNPtG6CdpxanwJlH/BAso608eBaelyh4cKeK3nHl7J6wwQhxm9vN0kMiV1gNAY4cnhdqwjs7hq+dH61ltclOAuBSKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bZJyBOUO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EdO7wXsRKn/qN7YZ2kPGzXiUIaom7K6LtlH4zBELlDo=; b=bZJyBOUOIb2uZnW0XOozuZUsH6
	3WHwWXWrXMD2q2Hrgt26Z+456Qpw9KpdzCTsojc9yy3E8pO9adhgrKKDvHF2YpNHRpmaDnatZEylm
	wmGdvu9z2W9sL/BF+5sQ1/7JVK2hYT8g5a9f8zRFMwOXih4DpJaUWkMcRmZ1AtMlhDlw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swpoR-0095u6-FA; Fri, 04 Oct 2024 23:26:11 +0200
Date: Fri, 4 Oct 2024 23:26:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: mxl-gpy: add missing support for
 TRIGGER_NETDEV_LINK_10
Message-ID: <5cf6e7d2-2303-4bd8-bfa4-2ea9915ac00d@lunn.ch>
References: <cc5da0a989af8b0d49d823656d88053c4de2ab98.1728057367.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc5da0a989af8b0d49d823656d88053c4de2ab98.1728057367.git.daniel@makrotopia.org>

On Fri, Oct 04, 2024 at 04:56:35PM +0100, Daniel Golle wrote:
> The PHY also support 10MBit/s links as well as the corresponding link
> indication trigger to be offloaded. Add TRIGGER_NETDEV_LINK_10 to the
> supported triggers.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

