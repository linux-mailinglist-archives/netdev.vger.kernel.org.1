Return-Path: <netdev+bounces-157900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425A6A0C441
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2EB3A6097
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02D71EE7A4;
	Mon, 13 Jan 2025 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3fWmC2Vz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE441D516B
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805318; cv=none; b=JOmT3QHfHIfkSKTIM+29sJ3fy+EBfC7UQT5y2zQzdvQW0DkQq2rgzK3FTJbqVQOysNMmXTxI6ahCDus9ynFg9o9qI+2rKrmZqd9a02/ePV0zonXlS0vhwyNVbuzEajN4qgjvN55Lf1ZN14LEYiGNKIHcka1GYGYVtyneOj5A6os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805318; c=relaxed/simple;
	bh=aioBIw2lz9UNxqwy0AAeKAA4ioCpRgh1gLOu16AbwsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0TJwRRdDWjUQkroHMXC+faNndOETg3nmG18JruQyoc7ljdRedAAlCRhpjExPT/rudg3fjbBxHHLdB9CZKkhCDEt3Ce5qaHRsED06FYYVHtc7+ukvVI/Akl4kunTSR8iB2KaRC6Enwnk/ZUtSGZF2xe+kj+PqMjPwXRzhIM6CVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3fWmC2Vz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=owvIEjbr3lOaoUZhQ/FPVwO5w8OjfmtceaTIahkDBFY=; b=3fWmC2VzWeEFxYRMQK3ssOSBMd
	4462/rwkuEi/3xpGtkSdv1AX8GEGokUreflcEGRsjk6h7lyGjdlB25SDAVVCQ+04lKic8ad5a/jmT
	dGcCKLcKh8jnyjifPsnEEkbW1IwqTMx7X0NhCSTkktohlrCOe8+n/IH9kgjQw5Z+BuVM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXSOm-004EO4-BP; Mon, 13 Jan 2025 22:55:04 +0100
Date: Mon, 13 Jan 2025 22:55:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/5] net: phy: micrel: Add loopback support
Message-ID: <e92b60fa-b3d0-4f45-b9a1-90bc9bb3ec7c@lunn.ch>
References: <20250110144828.4943-1-gerhard@engleder-embedded.com>
 <20250110144828.4943-4-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110144828.4943-4-gerhard@engleder-embedded.com>

> @@ -1030,6 +1030,33 @@ static int ksz9021_config_init(struct phy_device *phydev)
>  #define MII_KSZ9031RN_EDPD		0x23
>  #define MII_KSZ9031RN_EDPD_ENABLE	BIT(0)
>  
> +static int ksz9031_set_loopback(struct phy_device *phydev, bool enable,
> +				int speed)
> +{
> +	u16 ctl = BMCR_LOOPBACK;
> +	int ret, val;
> +
> +	if (!enable)
> +		return genphy_loopback(phydev, enable, 0);
> +
> +	if (speed == SPEED_10 || speed == SPEED_100 || speed == SPEED_1000)
> +		phydev->speed = speed;
> +	else if (speed)
> +		return -EINVAL;
> +	phydev->duplex = DUPLEX_FULL;
> +
> +	ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
> +
> +	phy_modify(phydev, MII_BMCR, ~0, ctl);
> +
> +	ret = phy_read_poll_timeout(phydev, MII_BMSR, val, val & BMSR_LSTATUS,
> +				    5000, 500000, true);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

As far as i can see, the marvell PHY is the only other one you can
specify the speed? I think it would be better if the marvell
set_loopback and this one looked similar. Either clearing the loopback
bit and configuring aneg should be here, or the marvell driver should
be modified to use genphy_loopback to disable loopback.

    Andrew

---
pw-bot: cr

