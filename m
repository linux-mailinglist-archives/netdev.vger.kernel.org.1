Return-Path: <netdev+bounces-119335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D0E95534E
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 00:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725E5282265
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 22:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8278813C676;
	Fri, 16 Aug 2024 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WZkrdscN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B321AC8B0;
	Fri, 16 Aug 2024 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723847565; cv=none; b=WNjJ6+beVHpkRZsyeMVs1v6Cotw+RYPG5jLEeVQkSEcL3Uk07NPh4DHV/uLzF/IUwjA9qdAKPDeDUGds2w5NE88XHNQ3ZlKvSKdSlQIOyqv0rMsxw0i4GP+dvLr5B74aYiAFRu5fK2TKT/bLlkgoGpF93kLNWGZVy9mjvS5RO6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723847565; c=relaxed/simple;
	bh=mkPHRWJ84G3Up6hWuok4DQj5MekgT4reZRaxqpGk9rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZ+JFznHGZsgb2gQ9J0M2AI23qAl9zWy58fVJ6wtWvSfYuZeEX9wIzR/i8T5yyr4pWxLEpTxGvt+VxJwVZymBRPv8+rILXbxrlfVTD8MtAnp2ajxqQCyW7xjTNjumYe/kCvTJA63NMu3rgntsVPBN4zJ68p5xoKjsvYKFfI4a7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WZkrdscN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nBgutPfckujk1kYcKUYJcVP6lWW9bdE6f1JLhwi7zwY=; b=WZkrdscNia7tgjAJDogwylQ7Du
	tN/IDykVYzSUVsR1QoyrZYrjSlMrWi34Ftr9IyTCA19YbIsMyqNrAa39NqO8HIh6rbQwnW8yyr13R
	Vfox+cC9YLsAK8cNPYkwdSf2nQSjS6G5YbAmBhezVTG4EXdArPS5xmSRorI2KhnfOSAs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sf5Un-004yB1-Ft; Sat, 17 Aug 2024 00:32:33 +0200
Date: Sat, 17 Aug 2024 00:32:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add driver for Motorcomm
 yt8821 2.5G ethernet phy
Message-ID: <b9c42139-e9df-4ddd-865e-3d312236be00@lunn.ch>
References: <20240816060955.47076-1-Frank.Sae@motor-comm.com>
 <20240816060955.47076-3-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816060955.47076-3-Frank.Sae@motor-comm.com>

> +/**
> + * yt8821_get_features - read mmd register to get 2.5G capability
> + * @phydev: target phy_device struct
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8821_get_features(struct phy_device *phydev)
> +{
> +	int val;
> +
> +	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_NG_EXTABLE);
> +	if (val < 0)
> +		return val;
> +
> +	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			 phydev->supported,
> +			 val & MDIO_PMA_NG_EXTABLE_2_5GBT);

genphy_c45_pma_read_ext_abilities() ?

> +static int yt8821_read_status(struct phy_device *phydev)
> +{
> +	int link;
> +	int ret;
> +	int val;
> +
> +	if (phydev->autoneg == AUTONEG_ENABLE) {
> +		int lpadv = phy_read_mmd(phydev,
> +					 MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
> +
> +		if (lpadv < 0)
> +			return lpadv;
> +
> +		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising,
> +						  lpadv);

genphy_c45_read_lpa() ?

	Andrew

