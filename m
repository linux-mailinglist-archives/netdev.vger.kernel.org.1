Return-Path: <netdev+bounces-133298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0152E9957DF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 850C7B22FC2
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAABE213EF0;
	Tue,  8 Oct 2024 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SiCRucH6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A5213EDA;
	Tue,  8 Oct 2024 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417122; cv=none; b=pjerhsdgoQhmEqxCgtjxqFWxDN4iUegTNaPvhIJk65d9rymbhZnrvISX5S/jrIbbZ72g55ev59qzLYIyjnbuxP7IITmhG5EplcopeN8o3aLkCvPdaqu1Hgr3s/Iqamj8P0taWOXvmfpcLAtwG1uo04Yed0cqN/nOa3t/1XtSDUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417122; c=relaxed/simple;
	bh=NdHk3ANhAEQl/5m6gjkQIVlXtyKOXVD1nAmw2csFKQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgdXw4KupsaJdBtw2Tgj+JtUMCdAxRk5OcC502QbOPLHUOlhiuPobjxCgUugHkyLCRtoFLcUluTH0FbAgCpe+Dv+d2zdR86LNbgEi51Zj5G9NAVoLo19sgVLp343+pai+jIz1YA70frH96jkORFkNdafrT+7Pc3RXcLU2s+eXAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SiCRucH6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vosV0UbV9CptMF/mNMauCpgANbudJBFcILvy+5yZnQc=; b=SiCRucH6UI7eHu/r8UaDFewo+/
	+VIekPwGcXckTUKhzwki8KUhS2ebgHUh8CcOR1lM9e96FqqiT+kIQ6ckeCBx0+KeyWze6R1SK0/xx
	XPRa7po/gkc4aNh0rLapDQe44ULIyxR0shGyixpJyVgCGAMOP6Q4UrN+eJcUg2dSoTus=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syGFI-009PMn-Lb; Tue, 08 Oct 2024 21:51:48 +0200
Date: Tue, 8 Oct 2024 21:51:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3] net: phy: Validate PHY LED OPs presence
 before registering
Message-ID: <c8f375e7-782e-4f2f-9a5e-f15a188c6f72@lunn.ch>
References: <20241008194718.9682-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008194718.9682-1-ansuelsmth@gmail.com>

On Tue, Oct 08, 2024 at 09:47:16PM +0200, Christian Marangi wrote:
> Validate PHY LED OPs presence before registering and parsing them.
> Defining LED nodes for a PHY driver that actually doesn't supports them
> is redundant and useless.
> 
> It's also the case with Generic PHY driver used and a DT having LEDs
> node for the specific PHY.
> 
> Skip it and report the error with debug print enabled.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

