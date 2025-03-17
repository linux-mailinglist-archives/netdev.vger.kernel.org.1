Return-Path: <netdev+bounces-175277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 200BEA64BFD
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 12:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497BD1887599
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 11:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2EA229B28;
	Mon, 17 Mar 2025 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kk89cWch"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8710023314E;
	Mon, 17 Mar 2025 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209995; cv=none; b=SK/JZhBOudDHUbJkIZCvlTQNWwRgPrXdACFiTx+iI7bjzflMO+TlcaqxYGdsKbtNpLqs9cOjrW97mropUg81qoeRbS/xTAkw11WnSkYhDSpLFICJ8VxoJWaCMv5yqe64+Z/bOvAr47sVLz6GKJflAIbJpEe0NOdy0E5RnmjKhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209995; c=relaxed/simple;
	bh=8uZXAR1tS9gZ1WIkhNOz3giLSFnP5AIU3jKXmKP+Rcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thFvLwzvNrVpLvdWB7di5PdZo+D+3n1WYwF0JH81oSoc6TlD7kNRmelUKmUCgmTM2X45pD5ox+JmwPUNSACrFsyNvkr/wMMaRP7Vhayt2dKJ53B0n3oTJ9ip8EY29TbiIOsxkmg1OgiKDbl4SNSAPTR7ai6RY2DPnjM8EpcvQ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kk89cWch; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t363R3/YC3BLxxJJdhYMszVV+F1s08ypncv/xkuhIZU=; b=kk89cWchiC6qKMPHhTHquX+flz
	BCbwvVkz4jfUY1GeALtiw4D3TpuQS8C/fmgF8tXDQ3OEvcqUru9Yxo8ZGSLm0JxMwvawKeono4Ozz
	TCf6pti97nx/hjbTUsKrcuT2IWHMRGJ9+VCpy/+TKYHkuKmYCvzOIIjR9lCCCNZBzS5vekQ7RmQ1M
	ONbZxqxT6aoUcDp19sRAKrlufoMlpc7Y9LVwAlDqv+BisJc/33bh/BS5Md3BjwAJicXKDuKZ+GXQS
	RrtgpS1nUXfb0YeoSbQxyBJ5tTq4Nb6ksBb+S4M13eCmJ9mfG1r7Q+Q8rvwZCsN3B43Y3tBTd/gLI
	TSkCZa5w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49238)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tu8P4-0003QF-2g;
	Mon, 17 Mar 2025 11:13:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tu8P2-0003WJ-12;
	Mon, 17 Mar 2025 11:13:04 +0000
Date: Mon, 17 Mar 2025 11:13:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Michael Klein <michael@fossekall.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next,v3,1/2] net: phy: realtek: Clean up RTL8211E ExtPage
 access
Message-ID: <Z9gDwDgpeU2iSZT-@shell.armlinux.org.uk>
References: <20250316121424.82511-1-michael@fossekall.de>
 <20250316121424.82511-2-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316121424.82511-2-michael@fossekall.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 16, 2025 at 01:14:22PM +0100, Michael Klein wrote:
> +static int rtl8211e_modify_ext_page(struct phy_device *phydev, u16 ext_page,
> +				    u32 regnum, u16 mask, u16 set)
> +{
> +	int oldpage, ret = 0;
> +
> +	oldpage = phy_select_page(phydev, RTL8211E_SET_EXT_PAGE);
> +	if (oldpage >= 0) {
> +		ret = __phy_write(phydev, RTL8211E_EXT_PAGE_SELECT, ext_page);
> +		if (!ret)

Only a nit, but !ret "reads" weirdly when you consider what the code is
doing, "ret == 0" seems more natural. It's only a nit so feel free to
ignore.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

