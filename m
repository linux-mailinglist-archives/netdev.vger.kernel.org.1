Return-Path: <netdev+bounces-211225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578F9B173CE
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 17:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EE61C25984
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435A1BE238;
	Thu, 31 Jul 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UCIw30bH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B11ACED9;
	Thu, 31 Jul 2025 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974879; cv=none; b=mrHV0SzsvCXnhocA8Suou1HMKSDKbT5WA+uDVofjctoFtNzHtYJhXUQufc1L9aL2/7WkpYOUbKBXUntXf2zX4TxF3pvCELcq/dRR0reza7X2jOAB06E1gNFxCwS8pAnk/wEGaN1kJWzavpxE/P7E7YbB0VWnPiN6ZiAeVDJkuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974879; c=relaxed/simple;
	bh=cwyePJDaWrhStsh0ea8nmBcfHc+W66qwij+Y8nZkgRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwhyIaRvpvsHImvmKgLht+eStg2LmGeHWHuXtybFhMBvbPfggF3Z0rX7U+4unAkyu69cxkYa92mV9SN0D6diRlq/G0oWhS8A5hYeS2TJcEQ9Gs/qP7nLJaf/F9xzmEelyctR6+7P4TJyJxayYXawHb6ARrAcBJmezMmJAhLiMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UCIw30bH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=p5i/W7ajuFgNW4oIih+M86bB7oiAhB+JQWnYLL23fvY=; b=UC
	Iw30bHH2cTT/jaDJHtzSAc2RzCmfwnLKjenVTF8s8UXJ2VITlI3KyfVL6VFdoN74T+zh8c30ERof+
	9K5/IIw67OhS3bVFUzV5E7UxT+SJ2C7dADWH5RlnBw4bJWqVozlWf3f9F144ajSL5phEaxV+ks8Fg
	g/6h4tijSIZUrHU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uhUzE-003Nkf-CM; Thu, 31 Jul 2025 17:14:28 +0200
Date: Thu, 31 Jul 2025 17:14:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <4acdd002-60f5-49b9-9b4b-9c76e8ce3cda@lunn.ch>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>

On Thu, Jul 31, 2025 at 04:59:09PM +0200, Alexander Wilhelm wrote:
> Hello devs,
> 
> I'm fairly new to Ethernet PHY drivers and would appreciate your help. I'm
> working with the Aquantia AQR115 PHY. The existing driver already supports the
> AQR115C, so I reused that code for the AQR115, assuming minimal differences. My
> goal is to enable 2.5G link speed. The PHY supports OCSGMII mode, which seems to
> be non-standard.
> 
> * Is it possible to use this mode with the current driver?
> * If yes, what would be the correct DTS entry?
> * If not, I’d be willing to implement support. Could you suggest a good starting point?

If the media is using 2500BaseT, the host side generally needs to be
using 2500BaseX. There is code which mangles OCSGMII into
2500BaseX. You will need that for AQC115.

You also need a MAC driver which says it supports 2500BaseX.  There is
signalling between the PHY and the MAC about how the host interface
should be configured, either SGMII for <= 1G and 2500BaseX for
2.5G.

Just watch out for the hardware being broken, e.g:

static int aqr105_get_features(struct phy_device *phydev)
{
        int ret;

        /* Normal feature discovery */
        ret = genphy_c45_pma_read_abilities(phydev);
        if (ret)
                return ret;

        /* The AQR105 PHY misses to indicate the 2.5G and 5G modes, so add them
         * here
         */
        linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
                         phydev->supported);
        linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
                         phydev->supported);

The AQR115 might support 2.5G, but does it actually announce it
supports 2.5G?

	 Andrew

