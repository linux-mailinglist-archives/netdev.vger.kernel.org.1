Return-Path: <netdev+bounces-243918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19423CAAC23
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 19:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9D8E30671CA
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 18:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509112D6639;
	Sat,  6 Dec 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g2JY95hL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8052D5C74;
	Sat,  6 Dec 2025 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765045862; cv=none; b=SUYGDxRKp2ppXGWeCDneA+iHMdItdCaRDulzsL+0e/ccvBg681jiHGMqNFLzlILRyj93dYgXeuVkIDFgR6NCBcqg9KNw2AQwcJb1rsK35P66QCx8f1EOP7tPkYtw3NNG/nOrk24OvXEGMdKiHwsDto4VnVIYW/ds+FAgLGEM9Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765045862; c=relaxed/simple;
	bh=6YFYBV5YPI3mKplLNxOUUXNwPPdTOdMInwKJddK0OaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB/u2X/FsYKc3PSgMy9eAENddpsqUrS7cBrfP02/R2dOo4prp1pk12X0ru0sYYiAYAgCbLRtHOHVJBMSKhyNLwrPxdFB+RITPHrVgEbmSN1OmKJREOZeFJiGPMbDNDk3YAPMqZQeX0fsxG4DfbB0eOlLz9tNt+E3Ddq77qmcl8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g2JY95hL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eR0JCfMa1hihJEB4R5UGxkldICyGNBsZvCir+nP242w=; b=g2JY95hL/fpCt3IAxbHjjZze1g
	NYe+DQdbIM+LqdtZJ6bhsSOOj1t9LK4k1orHdP9yjpElpPx0++/6dMKom7LZLW9UNbw4Rzh3NP6b7
	A/QYdrmOsE3D0ZhKtsm1AoL0nyT+rWiR/cQDSMVRTBLQIz07X3f4Py/fvW6jYnGbtEHw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vRx38-00GDwx-L4; Sat, 06 Dec 2025 19:30:30 +0100
Date: Sat, 6 Dec 2025 19:30:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v5 3/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <8a991b33-f653-4f0c-bbea-b5b3404cdfe6@lunn.ch>
References: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
 <20251205-rgmii_delay_2600-v5-3-bd2820ad3da7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205-rgmii_delay_2600-v5-3-bd2820ad3da7@aspeedtech.com>

> @@ -1907,6 +2179,10 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  		priv->rxdes0_edorr_mask = BIT(30);
>  		priv->txdes0_edotr_mask = BIT(30);
>  		priv->is_aspeed = true;
> +		/* Configure RGMII delay if there are the corresponding compatibles */
> +		err = ftgmac100_set_internal_delay(priv, &phy_intf);
> +		if (err)
> +			goto err_phy_connect;

Thinking forward to when you add 2700 support, i really think you need
to break the probe up into helpers for 2500 and before, 2600 and in
the future 2700. You currently have a couple of tests on the
compatible which you can reduce to one.

In fact, this driver has 10 calls to of_device_is_compatible(). I
think you should first refactor the code to list each compatible in
ftgmac100_of_match[], and add a data structure which contains an enum
of the MAC type. You can then transfer this to priv, and replace all
the of_device_is_compatible() tests to just look at the enum value.

	Andrew

