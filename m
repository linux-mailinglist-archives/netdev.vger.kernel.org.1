Return-Path: <netdev+bounces-84092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7739895858
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 17:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403762839BB
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E42131744;
	Tue,  2 Apr 2024 15:41:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844084FCD
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072512; cv=none; b=ZrlsbH6k/VYrZsoP4EmqIW8pXfNf1SDCsXuyed4s9NOlsrRFgWWWg6MoHD5oz9bui+Ch4YL27RL8seHGdT84uSok3pObIKCmZLENhlr3jtc93ThuVVzgmrDGdajBfV8G5xnDzSsK3Y6lKrjDAr8SaGy+cCviK+Po+wdXkgPVv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072512; c=relaxed/simple;
	bh=leqnQRCNelQO8YhplwhtEfi3tP+mIXGawxoJoY9c4yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhchSRhIItImROhmKAFhvM0j32Nesh8VBoy3hHG4h7ppl0gJ2JclHZg5GxDPiL5ts0zYUccFiHWLnGkF85IpgANYggdiuFYyJdLsmIxyq0i2/cXJOHIwQlpKNhM/VX157NiuZdSv2ypN5dob3ieUlDUbeHLg4lmLH8nUezVBI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rrgGH-0000Mf-30;
	Tue, 02 Apr 2024 15:41:22 +0000
Date: Tue, 2 Apr 2024 16:41:18 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 5/6] net: phy: realtek: add
 rtl822x_c45_get_features() to set supported ports
Message-ID: <ZgwnHhUnWXC0buuT@makrotopia.org>
References: <20240402055848.177580-1-ericwouds@gmail.com>
 <20240402055848.177580-6-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402055848.177580-6-ericwouds@gmail.com>

On Tue, Apr 02, 2024 at 07:58:47AM +0200, Eric Woudstra wrote:
> Sets ETHTOOL_LINK_MODE_TP_BIT and ETHTOOL_LINK_MODE_MII_BIT in
> phydev->supported.

Why ETHTOOL_LINK_MODE_MII_BIT? None of those phys got MII as external
interface. Or am I getting something wrong here?

> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  drivers/net/phy/realtek.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index af5e77fd6576..b483aa3800e2 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -844,6 +844,16 @@ static int rtl822xb_read_status(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int rtl822x_c45_get_features(struct phy_device *phydev)
> +{
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT,
> +			 phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_MII_BIT,
> +			 phydev->supported);
> +
> +	return genphy_c45_pma_read_abilities(phydev);
> +}
> +
>  static int rtl822x_c45_config_aneg(struct phy_device *phydev)
>  {
>  	bool changed = false;
> @@ -1273,6 +1283,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C45)",
>  		.config_init    = rtl822xb_config_init,
>  		.get_rate_matching = rtl822xb_get_rate_matching,
> +		.get_features   = rtl822x_c45_get_features,
>  		.config_aneg    = rtl822x_c45_config_aneg,
>  		.read_status    = rtl822xb_c45_read_status,
>  		.suspend        = genphy_c45_pma_suspend,
> @@ -1294,6 +1305,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.name           = "RTL8221B-VN-CG 2.5Gbps PHY (C45)",
>  		.config_init    = rtl822xb_config_init,
>  		.get_rate_matching = rtl822xb_get_rate_matching,
> +		.get_features   = rtl822x_c45_get_features,
>  		.config_aneg    = rtl822x_c45_config_aneg,
>  		.read_status    = rtl822xb_c45_read_status,
>  		.suspend        = genphy_c45_pma_suspend,
> -- 
> 2.42.1
> 

