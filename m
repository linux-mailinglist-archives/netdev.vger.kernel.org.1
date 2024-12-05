Return-Path: <netdev+bounces-149418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 442629E58F1
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271111885E9D
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAB821C9E0;
	Thu,  5 Dec 2024 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lFL8Uliy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E05521A44B
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410396; cv=none; b=in4r4iaBdFJmMU0AuaCFx2AZ5/vZ0rYrtPRsbeDyKCceQAFhsuTQ/kYJFadZJrYQKNyXc5AzBeJCJJrjETs5Z6vGnelZwT+b2UgPteh43fPEXpnJQFDcBJit0HAhaxp4UV/JQgW7aIBJ4rBeWFxPLoOrxUC9/86AS67Vjfdv2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410396; c=relaxed/simple;
	bh=QwhQ7ht/8hNyn5aEt2CV4n6ZMhDkt+nLVS8b+2EFdcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCr+dohLkly2cWol2mPGSHECcGIlE4M66cqXFWUlXv72InRYMpZ8P/FSxPnhCo989z2vdCEhbC35h6pIrgB2RZa/J+O7o+E1bzCCQnJCptCYGNUHg89cSm8QLvfEXtZsG69VkiJviWuYZglHoZaxz8Zpp7gjTUmwkRB7s1vyKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lFL8Uliy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=anlx0iNSR5oPbXJAX03GiwPI83WVvkFyjj3jMEe19e4=; b=lFL8UliyE2VeFcHY6pxoO9o4bR
	9EmiD/VYNs6lrYu1EfPsLnP3WYKUKYp/6EpdPsEIIjBMr3yEcEs9i2Y/r3wVeoOwo+z9USnT6+t3z
	VB3BBGwkj+uAkVQ4QlmkyqM2tlIlEnHzjew/tdCw8vnU9llJLNAZuhk+93S32TYOldmA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tJDE4-00FKO7-Bs; Thu, 05 Dec 2024 15:53:08 +0100
Date: Thu, 5 Dec 2024 15:53:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: phy: update phy_ethtool_get_eee()
 documentation
Message-ID: <d4345763-9a8c-49dd-bb3b-2be2a01be6f6@lunn.ch>
References: <Z1GDZlFyF2fsFa3S@shell.armlinux.org.uk>
 <E1tJ9JH-006LIz-SO@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tJ9JH-006LIz-SO@rmk-PC.armlinux.org.uk>

On Thu, Dec 05, 2024 at 10:42:15AM +0000, Russell King (Oracle) wrote:
> Update the phy_ethtool_get_eee() documentation to make it clear that
> all members of struct ethtool_keee are written by this function.
> 
> keee.supported, keee.advertised, keee.lp_advertised and keee.eee_active
> are all written by genphy_c45_ethtool_get_eee().
> 
> keee.tx_lpi_timer, keee.tx_lpi_enabled and keee.eee_enabled are all
> written by eeecfg_to_eee().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

