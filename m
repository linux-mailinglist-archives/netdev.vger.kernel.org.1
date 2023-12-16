Return-Path: <netdev+bounces-58229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A8C815928
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 14:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C887E1F21E70
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 13:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CDD18ED2;
	Sat, 16 Dec 2023 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eXZGywpj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75432C681;
	Sat, 16 Dec 2023 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ixhx6WvH8Syc80mMeRWCVgpohgczXdvY1NV4I9TIvsw=; b=eXZGywpjpZLXl5bSBE8DRYTRG1
	jk40d17DQiH6y4fYt1NiLMcWee1V5K//1R2YQGtkNvuP2a3TxxQq4e1pR0H49t+vET3tbg4cJW1VO
	3ZcKuSsaTLmEjUQ8AUMZeFPLE5IW3BGKLawaVyZZAttBDLR9UDSErelQR/RnQQcUgvvo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEUI9-0036CU-B4; Sat, 16 Dec 2023 14:01:17 +0100
Date: Sat, 16 Dec 2023 14:01:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v6 1/9] net: stmmac: Pass stmmac_priv and chan in some
 callbacks
Message-ID: <759f33f0-e75a-406b-9318-272e50f2ec3b@lunn.ch>
References: <cover.1702458672.git.siyanteng@loongson.cn>
 <361389e731d14e3e2094f6ff5501597e9f762f34.1702458672.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <361389e731d14e3e2094f6ff5501597e9f762f34.1702458672.git.siyanteng@loongson.cn>


> -static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr)
> +static void sun8i_dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)


>  
> -	stmmac_enable_dma_transmission(priv, priv->ioaddr);
> +	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);

As i've said a few times, i don't know this driver.

Is it a queue or is it a chan? Is this change consistent with the
reset of the code base?

      Andrew

