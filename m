Return-Path: <netdev+bounces-201558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87993AE9E28
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D31C27E22
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FD02E4276;
	Thu, 26 Jun 2025 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DWmlsh7J"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E4F2E336E;
	Thu, 26 Jun 2025 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943139; cv=none; b=o7QPTr042ooWqa9Bs8Pq2/A113jc+hZfqjughPd+RYzZx4t7YlgkxeMxaq8mYlrrl1iJpvQugz0Hhm/ydD2My7B9mVNcYGh4SMoj5JWmCMv7G3513AwM1oPg2uwWvYJFg3D1Kepxq0u/+BhOlBYaNNIahddpuOHEbkVlB8NKZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943139; c=relaxed/simple;
	bh=CtzJ5WcdsZlmH2RXR3VO2Lm2ckUhYmCb1bLgc+ZEk5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxoNfR7op4Gn90xLagQlvPBFoAp1mojmi+OaqWv2mSb1kCzwKBzb05tP8Pv/hyx+T3/pdoLV86pY8z8inYH6br5zeX7Y0aHZc2Z/cuUelTsnDajrTg318lnF8OSTqAbUHBh4T6lHnTNLxKDOGoUo4edli65E1N3H1wE1UVOc/yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DWmlsh7J; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ElWZ1fSEwqvTXBCwEfcGjVCwQ3tn4ietRl4UHzKkIUY=; b=DWmlsh7JFrm9JSBLNuQYOMyVob
	vigqfOdGdVlg3MGphpfb8qvZSNg54lGI3gZ1Ip6hbRj3sBXTrhxtYQXoLZg9fQsEu67kj5rjJIhKg
	7qidIvgyB64gJ8hpbPdy4GAQer5T22WkHhyRBH/hrp0+gner3Vkh/+rnewhegD+xDOrEri+qmgVUX
	kewO/dGSxM/cURmChU5nAi506jqRR6s6jxhWKrY99BM7ZCUGKwcWfvC2k79VofykjWTFq2WpQwuWL
	3ne/CoxUI3cbfk/JCNjmn4HvflWn/BpATTxXeAT2veV0lXfGLq0tns4abzIcHALNROdokUiWX6Tc7
	F5lEVb4w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37656)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uUmID-0008V8-2Z;
	Thu, 26 Jun 2025 14:05:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uUmIC-0006X9-19;
	Thu, 26 Jun 2025 14:05:28 +0100
Date: Thu, 26 Jun 2025 14:05:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	f.fainelli@gmail.com, robh@kernel.org, andrew+netdev@lunn.ch
Subject: Re: [PATCH 3/3] net: phy: bcm54811: Fix the PHY initialization
Message-ID: <aF1FmEBzO1_-HOfD@shell.armlinux.org.uk>
References: <20250626115619.3659443-1-kamilh@axis.com>
 <20250626115619.3659443-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626115619.3659443-4-kamilh@axis.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 26, 2025 at 01:56:19PM +0200, Kamil Horák - 2N wrote:
> +		/* BCM54811 is not capable of LDS but the corresponding bit
> +		 * in LRESR is set to 1 and marked "Ignore" in the datasheet.
> +		 * So we must read the bcm54811 as unable to auto-negotiate
> +		 * in BroadR-Reach mode.
> +		 */
> +		aneg = (BRCM_PHY_MODEL(phydev) != PHY_ID_BCM54811) ?
> +			(val & LRESR_LDSABILITY) : 0;

Wouldn't:

		if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM54811)
			aneg = 0;
		else
			aneg = val & LRESR_LDSABILITY;

be more readable?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

