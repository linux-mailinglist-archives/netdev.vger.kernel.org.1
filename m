Return-Path: <netdev+bounces-222115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E8B532C6
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4081C8234C
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93526321442;
	Thu, 11 Sep 2025 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="j5jyOipc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA31C27EFE1;
	Thu, 11 Sep 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595101; cv=none; b=UTDre0k286igcgbL4zuFIKpRoaSgpuJKztLi3jD4528Sk5/wAMHQhQScxbZWBrkhaBu7L41C7s44OeSnpa0FTh1gdHovKU6zKoYCr2hUTLVylObThTc5vDczgh0iuUF38Bxh6KvciScyfhZ1YpjVqD7ceWjsAYSNXV/zgWlVb14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595101; c=relaxed/simple;
	bh=/CZchbUJJx5iuYCB9vz7gVfz/c1LrOO8szmAw5gDyDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQRde7EkPbD99jLM971Z60qMfsQrzbKRqUsaPTlXQ2wgtDWpYACqssZP1lpS/sPXRnGc76L18mqzQRFtkEMuHpnxNpcLC1BgDdhQKRs6WgZkN09+0DF5Kxp4VR+CE5N8m2ew8nSugkxtKWIZ+pSr8kpwlk+Ij0INxaKyY6iTOMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=j5jyOipc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v+5rP8nGZfUE7JovJkiq3wIxYuLAUJaHuDcq9FK6N2o=; b=j5jyOipc7CF+6IrtAD8U6rzM+N
	VTg3B4CS4xefU8x9b56O+oumZqqhJmMFMn8HWy5FCrix6LQr53E1wrfwJTwUpIUmqymE2YohLIxPS
	gGyhFS4UJq4MZKJbb2zL550hMOTzkwsUupEOFC7cu3uYP2+W9pN13nrPYDUv70mJAZafsfIj5gWlW
	pjyGeqxb7eNyjrmiPdXnc6kEGwQt3GfP/8mc6kEMg4yzBNOvjWYti9tdhcpM7AES2/U1fPDlicDVP
	fhm2341mm88VopLKqpBw1gPHdv8RnHXiI+NnARfvJ9GGomDSp4TPJid8PxYrvLOdzDa9TTiDXWUrn
	Ihz5WVRg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44464)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwglt-0000000032i-2qAs;
	Thu, 11 Sep 2025 13:51:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwglp-000000002Mx-3vtO;
	Thu, 11 Sep 2025 13:51:25 +0100
Date: Thu, 11 Sep 2025 13:51:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: rohan.g.thomas@altera.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next] net: stmmac: est: Drop frames causing HLBS error
Message-ID: <aMLFzSLBHxsk9YI8@shell.armlinux.org.uk>
References: <20250911-hlbs_2-v1-1-cb655e8995b7@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-hlbs_2-v1-1-cb655e8995b7@altera.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 11, 2025 at 04:38:16PM +0800, Rohan G Thomas via B4 Relay wrote:
> @@ -109,6 +109,11 @@ static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
>  
>  		x->mtl_est_hlbs++;
>  
> +		for (i = 0; i < txqcnt; i++) {
> +			if (value & BIT(i))
> +				x->mtl_est_txq_hlbs[i]++;
> +		}

There's no need for the parens around the for loop.

I'm afraid I can't provide much more of a review as I don't have the
documentation for GMAC4 or XGMAC.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

