Return-Path: <netdev+bounces-157151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A048FA0910C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F40A3AD0B2
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AC320FAA5;
	Fri, 10 Jan 2025 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PJJ+ihaw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650320FAA7
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512826; cv=none; b=B0afnG14yeiXlkFIad9XZHrwxTEGOKgJ7o4Xve9+0+AcXitDipIAZzwe4kprA7HX1mYQT0ZUmHTevvY2s7LiGNhh+Yo7AzqMrYtebc9Y4JHgqsd3aDKYHqJ3sHBmtRZN9/OpnmCo3z8gfbhUOj/Lar3qll8F41wbelX98ZgOiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512826; c=relaxed/simple;
	bh=rTLD328JM8epnu2quhjQdObuLoehUNWBof3oDuWPBbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVqz8N58NJN0e8+lbUo01+6jVyAgAuXH6gt9VUg9PRMYWcBOgaifQ0/k6f1VME5Xn2lYr+mmbB1UbEfl/pOTXuu0tW1L9+14FCMV4YYl4ot0SVLNNpRHHa42e8BeDER0/6c9m/c5cVmlcydfmOuMe+Fjf6OJZFt0AO7YJDJyZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PJJ+ihaw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mEP/fhVZX88mKH/QqHR/PLyCQMAgY6aUjmlCSZUN2mc=; b=PJJ+ihaw9dNOlW1E061qjTFRAQ
	pRBZgNFaykyo0/wgYxWr70Laj7HBydXfY06USpWlJRKjaWN/XMuM+io8k2l7SY6dg4dSlJPVNNqhe
	bksGeiWsDU4lt/ytDMyLEpszvBzZlcEzHTozXdrjJfn23J8qUnehdpyNLJiYJTDKOElN0yF1Xe+A4
	yyERmmTJWR/GJOsL7WA4ZCA0yeoJNR7EOjc/oMkACDylT6zgDJUf+HFuvf4LZ9VnVe14sxzUGSEPJ
	SgNGugPaF3FPKAt72miJ51wKIa8mYJv0qMaqaCL1DY3Vm5qeUZhvYWyUN1ZE7nOARV3rdbiK/hPrb
	tI2LpLlg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37066)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tWEJF-0003Pp-0s;
	Fri, 10 Jan 2025 12:40:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tWEJC-0008LI-2j;
	Fri, 10 Jan 2025 12:40:14 +0000
Date: Fri, 10 Jan 2025 12:40:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: phy: realtek: rename realtek.c to
 realtek_main.c
Message-ID: <Z4EVLteK6aU10PSr@shell.armlinux.org.uk>
References: <3e2784e3-4670-4d54-932f-b25440747b65@gmail.com>
 <b67681db-76f2-46fa-9e87-48603b7ee081@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b67681db-76f2-46fa-9e87-48603b7ee081@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 10, 2025 at 12:47:39PM +0100, Heiner Kallweit wrote:
> In preparation of adding a source file with hwmon support, rename
> realtek.c to realtek_main.c.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/Makefile                      | 1 +
>  drivers/net/phy/{realtek.c => realtek_main.c} | 0
>  2 files changed, 1 insertion(+)
>  rename drivers/net/phy/{realtek.c => realtek_main.c} (100%)

Is it worth considering a vendor subdirectory when PHYs end up with
multiple source files?

We already have aquantia, mediatek, mscc, and qcom. Should we be
considering it for this as well?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

