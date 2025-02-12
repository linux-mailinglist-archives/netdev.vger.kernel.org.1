Return-Path: <netdev+bounces-165518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6FDA326D9
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CFB1882484
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D22D209681;
	Wed, 12 Feb 2025 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZdtUsX4n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92673134A8;
	Wed, 12 Feb 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366311; cv=none; b=cxezbm2VW4w5oUEqTOprTQAXw8/16FEPsq1DhNtbS38RCF/qJeJG2xQt4E35GIUZ/z2y+c3klmTxsh3Rw0pi0MuAzoxz30039zqltyar0SdRApC6yiQNhnhQkwh+0t2fawC9W1FJUt61lbqxKENuQascHPOLdURtRgLCboyFdvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366311; c=relaxed/simple;
	bh=0AYpcltqec6u1p0gyS++tFAR2YVtjSupqee/DsRmCkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKZtvMr/0HNcU3fxojjzZTnbzUVQiQg8idT8adwMASHQwI8Erq4I8w2Yyx0Npn7M1cNUDL5UVdh4FeVPBb9Dy6Lu6lgFKzJvjhuZWq/epBk6ZlmJvK6BIN/+zP4cAJzjgxKKtAYcwD+XgLeewryeYNPfTfM1N004oOxOXUztPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZdtUsX4n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3HekB3x4ewBgrycoUmahaMTe1OuakWg2M5alpZ2tkms=; b=ZdtUsX4nApgHpGRyh9rkaCaxZS
	Et+jDBkPBq/nKoFP5ippcss/lTrgrtf8GYDcKfo7ohxIKo6Q3BnA9A40glYU1lJEESLmoKY5LXBAc
	8GrQsb0TbLyVUlmviQS33F73VDPoI/cp4jH/aOPZl+nqNjMT1rlPNIwoDivOUAEH9P4s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiCd9-00DOqE-C3; Wed, 12 Feb 2025 14:18:19 +0100
Date: Wed, 12 Feb 2025 14:18:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v4 3/3] net: phy: dp83822: Add support for
 changing the transmit amplitude voltage
Message-ID: <0ab7e964-3e0a-487c-885a-6d20f4482762@lunn.ch>
References: <20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com>
 <20250211-dp83822-tx-swing-v4-3-1e8ebd71ad54@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-dp83822-tx-swing-v4-3-1e8ebd71ad54@liebherr.com>

> +	if (dp83822->tx_amplitude_100base_tx_index >= 0)
> +		phy_modify_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_LDCTRL,
> +			       DP83822_100BASE_TX_LINE_DRIVER_SWING,
> +			       FIELD_PREP(DP83822_100BASE_TX_LINE_DRIVER_SWING,
> +					  dp83822->tx_amplitude_100base_tx_index));

So the driver leaves the value unchanged by default. Please make the
code and the binding match.

	Andrew

