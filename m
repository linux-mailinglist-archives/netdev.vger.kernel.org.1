Return-Path: <netdev+bounces-155576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960B9A02FD1
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 19:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B79FA7A1757
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D751DF725;
	Mon,  6 Jan 2025 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pbx1cTaK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7129F1DF242
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736188637; cv=none; b=M/okYANImTbJjCsZSKiMWNxDgJUffoflr5eSh0Z8HCwuGM+kiKiuCXy26hwOBRMlyg7M/VA3yFjpmsImYvjMqOvuNLgD7z31F44oQPGSfFQAjLDtv0BVkZzujjReEwmvZmx6wD2orYi8LzN7YHcVjswcM62+xVB3UpftOiwkiUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736188637; c=relaxed/simple;
	bh=zYZ/hA/OSVq6CsmhLHTiKS2TNFaVjHwmlA7VybSFMgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaXJnil58VKX8dkyao2hqwalq8+pfP26slvqZhqEF6bGvJH9xsgReVkLOW9lB/g+5Ep5xsdScUfOk5KEZhBdBaf2iaEW+U5pwsPXEeIn9vwVeCv+3jgiW0q+1NQbIO9q0OM3qgAd3vjIk2W7tSrMQSpXGpahrs+4QZNbwn42S+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pbx1cTaK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iXAuwDWCgmE922emM6DQUyR5+KoeQ4T2Bb8TY6s4J7k=; b=pbx1cTaKhLDYnf1x8Sfr5ecD77
	P/EJ5jF/SLD1EYril/5EO4yCXvZduHMkQI3PD3L4D76KgiyeB35q6QW21j205/J6MdV5Wes9mhCNX
	GgbrOjJECpNc50WOWNopf1AHyinyuF9QnsuUlVOeKH0hGzcPhCNnElV4T7IJtU/dszN4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUryD-001xhK-1C; Mon, 06 Jan 2025 19:36:57 +0100
Date: Mon, 6 Jan 2025 19:36:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
	Woojung Huh <Woojung.Huh@microchip.com>,
	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: microchip: remove
 MICREL_NO_EEE workaround
Message-ID: <3fa8e406-6ea9-49a7-a4df-058c485e09ba@lunn.ch>
References: <79f347c6-ac14-475a-8c93-f1a4efc3e15b@gmail.com>
 <329108a3-12d6-4ce4-9b28-b59f107120ba@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <329108a3-12d6-4ce4-9b28-b59f107120ba@gmail.com>

On Mon, Jan 06, 2025 at 02:23:36PM +0100, Heiner Kallweit wrote:
> The integrated PHY's on all these switch types have the same PHY ID.
> So we can assume that the issue is related to the PHY type, not the
> switch type. After having disabled EEE for this PHY type, we can remove
> the workaround code here.
> 
> Note: On the fast ethernet models listed here the integrated PHY has
>       PHY ID 0x00221550, which is handled by PHY driver
>       "Micrel KSZ87XX Switch". This PHY driver doesn't handle flag
>       MICREL_NO_EEE, therefore setting the flag for these models
>       results in a no-op.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

