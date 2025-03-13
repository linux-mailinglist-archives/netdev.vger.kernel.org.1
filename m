Return-Path: <netdev+bounces-174466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C3CA5EDBC
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F020C3BA39D
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 08:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FE825F998;
	Thu, 13 Mar 2025 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Y8K6rmu/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042BB19ADB0
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853605; cv=none; b=hMSvyyy4lVM4krVDZ7XyTvKubcnp6vKU8tnfmuG9B/7oBFIu7eAjJCmCEcNmN4YgIFH/9xSsSaHADJYqmLfkrWj596p1iv7zzZ5vujquhlOO0YA8+lTlVKFgdFCxojY0vrhpkBLCSS8xhaUT+Zdi9YazU7o3oRrV0h85T6Cu8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853605; c=relaxed/simple;
	bh=s8ApOPtTYU42vM8XoeO+oeWY78ozR9TZyZDlZ9iMGEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSB0S8WZNzbAhDkzsiBteI0WFk/ZvRRRQKMsNISvcTunsyE5uEWP2vcaaNpiorxnaaHvbbFjlG8SgBrEtIfFBCu7DbkgSfDKMLlwjPAfjrLWq38YffI4kCw2FR9IyWqG1+CX4VeCgBmrdfzzgTtCdD+QDewYPG3lFAtSUJ4gX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Y8K6rmu/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KNWRjxoA9JsYQRCUVG8bkf0reIJyoWkhEVKiEfrJEN4=; b=Y8K6rmu/SDHkEIdnY6m360zt81
	8kzPwsNJQ4rc5IACAg6B5ZDIV5DFMtvgcp7InuiR5xaNzbzQiiXN7ZGThD8agyyGt35Rg7S7bl3ZI
	jvkMah64c+1BwKawt0hM12P7VXqqjbSgvWRzOTygixRoM/83PLiORN5nYX15gO0gROoDaNH9GMcUr
	oEk4oT0grTn5KIxWUEQVn3SDrCEXbCU0sK8a7BOBD7VWB6PKcsz7JSXW8gA6Xva1qsUzaZ6GqdpmM
	/7e1ry+fVNsDUGSRYMVzkgqNYl97VhCmWX9AR1xZihatto/Vd+hhFSSxJxUS2DQvYKTcpx52dr9TG
	6QyXQYGQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56136)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tsdge-0006fC-1T;
	Thu, 13 Mar 2025 08:13:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tsdgZ-0005QW-1c;
	Thu, 13 Mar 2025 08:12:59 +0000
Date: Thu, 13 Mar 2025 08:12:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/2] net: stmmac: avoid unnecessary work in
 stmmac_release()/stmmac_dvr_remove()
Message-ID: <Z9KTixM7_vc_GFe-@shell.armlinux.org.uk>
References: <Z87bpDd7QYYVU0ML@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z87bpDd7QYYVU0ML@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 10, 2025 at 12:31:32PM +0000, Russell King (Oracle) wrote:
> Hi,
> 
> This small series is a subset of a RFC I sent earlier. These two
> patches remove code that is unnecessary and/or wrong in these paths.
> Details in each commit.
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 -----
>  1 file changed, 5 deletions(-)

Hi Jakub,

Why is this series showing in patchwork, but not being subjected to
any nipabot tests?

There's also "net: phylink: expand on .pcs_config() method
documentation" which isn't being subjected to nipabot tests.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

