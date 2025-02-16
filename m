Return-Path: <netdev+bounces-166811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EACA375FC
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D9E3A658D
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B42319A288;
	Sun, 16 Feb 2025 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E4mMZ4LT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B35C27735;
	Sun, 16 Feb 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724570; cv=none; b=ES25c22/4b9Fjm4vOYaqHFI9DEZ9mA+4woJnBwIyiqPj4/4HbEIJXnr96s87J2hGqRTVetEqLUDBN14d2fTsZznCUa+mpEFZ17kNdoyez8fL9io0mjQsHWLy+FRyBUq6vKH4QF1peWBwnClKh6UK2adVINHxkz3OzcdLk9h7Jp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724570; c=relaxed/simple;
	bh=m1dKwdDO2q8mLEjpw+cxaly+MNJTeCcOnCeCU7XoTco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2jIJmSpCredx7rd8aiR6HjbkvPpoY02G1vAHIqDSkJuZbW3l5hw5zVd0W/4nXT2zHV5Ktkoh/b9yo57h4em0YwuJ7ywdxE2ay/w65ZHbByScoZndfnuhWp+t2uhDHkJu/kcC855JB3GzVll8deEgG21fSY8jljxF4qtwRiklps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E4mMZ4LT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iZqorBL9NC50sKW8xRpM5vQTORnlBE5flNUJrgysfng=; b=E4mMZ4LTDwAdjflnhCdA8uC2f4
	rkJmaJNQ7qWcJgtQ1rog2qM54zWWe8DM577XKEG7XRhuiMvdvBWNTAThh09Nsh125TkiGb61qecot
	Oy7FpDw2FJVSG2H4qx+F3n70XrAbTYNMztDm/0wn/wf5RbC1aTa7sjg4rNq4t6/K28nM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjhpW-00EhmQ-N6; Sun, 16 Feb 2025 17:49:18 +0100
Date: Sun, 16 Feb 2025 17:49:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v2 4/5] net: phy: mediatek: Add token ring clear
 bit operation support
Message-ID: <082f3095-d83f-47b6-b902-2d99482855b7@lunn.ch>
References: <20250213080553.921434-1-SkyLake.Huang@mediatek.com>
 <20250213080553.921434-5-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213080553.921434-5-SkyLake.Huang@mediatek.com>

On Thu, Feb 13, 2025 at 04:05:52PM +0800, Sky Huang wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> Similar to __mtk_tr_set_bits() support. Previously in mtk-ge-soc.c,
> we clear some register bits via token ring, which were also implemented
> in three __phy_write(). Now we can do the same thing via
> __mtk_tr_clr_bits() helper.
> 
> Signed-off-by: Sky Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

