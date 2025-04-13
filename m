Return-Path: <netdev+bounces-181972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71181A87236
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 16:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B9716C75C
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A72F1C7008;
	Sun, 13 Apr 2025 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SdAc5/uV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466C19DF4F;
	Sun, 13 Apr 2025 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744553612; cv=none; b=J8wceMMXnH9O0LtPCwPERN0vZLEyNGUILovISjGiPlo1SGRd0N/W+W1H2tf3h5jGCZnZNzMxnEvg0f9lAhy6GIsaPP0KZnBde0U/y4/bHDkIe9/v1G6cd4z/Mj6RE+z8IFsTuBWv77bNbCx5dTgXN6DkEBjvCvYg+GVDXb0P0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744553612; c=relaxed/simple;
	bh=pdInqqokyxmOxQcOwY5kAGOwm2riSgazc6au3Z35qKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3Du5QitbknWLHCfPolFGk2hEqCMSwj4kkuP4MjFLsX5mN7dAxBuFcRtZmbNjzfYK3XAcbVLLCXz7N8dDG2z83GAwJIBpsGPIDSUTxB6P3OtnwGewweB61OGR1PqgykGJWUxN+LRejzwRlG++MHlkmYvodorZSDSEi0hQat7HfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SdAc5/uV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vODfS2IlHZl889HtjZC2zqZuZ5W8sZRgBhq8v9nP4Vs=; b=SdAc5/uVYBQHPFCOaeaK0VRtJ3
	b9KeF0/yo8LzPpzasc5CVwha/oiN/JPrvfYR1Fwnuvt5bfpDF2ZMGcAuVqYCgDq5O0ZD1yA3BId2n
	KHBgfZL05Kls66erLakoXS0c6UAgN2RWnVNmUUwbBvH605f7DQ5iOCdbaD+uf3kAlHx7BJxql/opa
	PHUrcLUYWrAWMkaeHCUMdtoKM7IWZTEaedu7WYarR4cRZ3rx5C75Lu+f697gsqzVisuGxmR4RzYR2
	6CbjDUaoaJNaNJSzRu6efZ3eFHaDKYPFSLQrLRV8uJIQyie65iaIT65ObkuCjp3Nx0j+zNTcx/Qi3
	aKd2tUgA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51232)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u3y5H-0005Nc-1l;
	Sun, 13 Apr 2025 15:13:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u3y5F-0006ji-0b;
	Sun, 13 Apr 2025 15:13:17 +0100
Date: Sun, 13 Apr 2025 15:13:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: hhtracer@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, huhai <huhai@kylinos.cn>
Subject: Re: [PATCH v2] net: phy: Fix return value when !CONFIG_PHYLIB
Message-ID: <Z_vGfedEZGnkM6H0@shell.armlinux.org.uk>
References: <20250413133709.5784-1-huhai@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413133709.5784-1-huhai@kylinos.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Apr 13, 2025 at 09:37:09PM +0800, hhtracer@gmail.com wrote:
> Many call sites of get_phy_device() and fwnode_get_phy_node(), such as
> sfp_sm_probe_phy(), phylink_fwnode_phy_connect(), etc., rely on IS_ERR()
> to check for errors in the returned pointer.
> 
> Furthermore, the implementations of get_phy_device() and
> fwnode_get_phy_node() themselves use ERR_PTR() to return error codes.
> 
> Therefore, when CONFIG_PHYLIB is disabled, returning NULL is incorrect,
> as this would bypass IS_ERR() checks and may lead to NULL pointer
> dereference.
> 
> Returning ERR_PTR(-ENXIO) is the correct and consistent way to indicate
> that PHY support is not available, and it avoids such issues.

I wonder whether it's crossed one's mind that returning NULL may be
intentional to avoid erroring out at the callsites, and returning
an error may cause runtime failures.

You need to do way more investigation before posting a patch like this:

- Analyse each call site.
- Determine whether that call site can exist if PHYLIB is not built.
- Determine whether returning an error in that case instead of NULL
  may be detrimental, or at the very least list the call sites that
  would be affected by the change.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

