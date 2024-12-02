Return-Path: <netdev+bounces-148263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B309E0F6C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 00:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780FB16540F
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 23:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA591DF991;
	Mon,  2 Dec 2024 23:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0310zmzO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A0D61FD7;
	Mon,  2 Dec 2024 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733183579; cv=none; b=sgrZvgyldXs0YRcuNqVfN5yRhzfAmCaWihEkdN2hPSZ1Yjz+X+X8980GIZm8PU10QLOKR9/vCPuW2KxKEInOpYHPH1NeDHzRkVbF/97RdFmS3lQOHGfsmakV+L7KTNafitfof+C8WDQkRmY3nLpL4TzihNlSmx1EhS1Sk9K1bjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733183579; c=relaxed/simple;
	bh=xgFEQUmKXFmGUM1ahXnuTGHMGngiivX+kmcshsAXygU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Df6UjLbXVNtM8c9W98VPhkzAUueCOiyV9u4e5p0WXuLHtjMYYvIYuSgYdrUtmmT+sTkBiXpZfdlWDVRW2PtaKn240+b1hASrN0qDzPA6vYAp4sWOar5L/Kn9Bcw4+4gn88AmpMbmd4lHJMkfCNOfwiXGH6uyDYp42eGdW7YD0AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0310zmzO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i9hsELvHD2z5XWxhJW/OJyBNqoqTfdLs30fG0+5CDZg=; b=0310zmzOiZuEy4jzhgjjrZqhUo
	uIqNoPYr5dZ47xNermYchKG+PyKyoYmq8WtH6irDeio3Oq+2w8UJuvgcASeYqm8EELuLYBexVb3zf
	WT05IjkaoN/6ChopcRX9kFQr5So99ir7RRNDDw0zyLA9LZ6tjXk4yIkmKtVN15sQys9E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIGDl-00F0ke-Kw; Tue, 03 Dec 2024 00:52:53 +0100
Date: Tue, 3 Dec 2024 00:52:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Zhiyuan Wan <kmlinuxm@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy.liu@realtek.com, Yuki Lee <febrieac@outlook.com>
Subject: Re: [PATCH 1/2] net: phy: realtek: add combo mode support for
 RTL8211FS
Message-ID: <690e556f-a486-41e3-99ef-c29cb0a26d83@lunn.ch>
References: <20241202195029.2045633-1-kmlinuxm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202195029.2045633-1-kmlinuxm@gmail.com>

> +static int rtl8211f_config_aneg(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	struct rtl821x_priv *priv = phydev->priv;
> +
> +	ret = genphy_read_abilities(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	linkmode_copy(phydev->advertising, phydev->supported);

This is all very unusual for config_aneg(). genphy_read_abilities()
will have been done very early on during phy_probe(). So why do it
now? And why overwrite how the user might of configured what is to be
advertised?

> +static int rtl8211f_read_status(struct phy_device *phydev)
> +{
> +	int ret;
> +	struct rtl821x_priv *priv = phydev->priv;
> +	bool changed = false;
> +
> +	if (rtl8211f_mode(phydev) != priv->lastmode) {
> +		changed = true;
> +		ret = rtl8211f_config_aneg(phydev);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = genphy_restart_aneg(phydev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return genphy_c37_read_status(phydev, &changed);
> +}

So you are assuming read_status() is called once per second? But what
about when interrupts are used?

You might want to look at how the marvell driver does this. It is not
great, but better than this.

    Andrew

---
pw-bot: cr

