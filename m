Return-Path: <netdev+bounces-174299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EA5A5E32F
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467A71783CE
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D792253359;
	Wed, 12 Mar 2025 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="q8FeuJsN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1C1C1F07;
	Wed, 12 Mar 2025 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802224; cv=none; b=Txg6qZ1QgVqsKZWuMkl82wfc/7rHTWhakgne6UtQW5nfiixfjtEboP7bJivmJsssDuTOcPTy0CdGCeYfdGWFUj2OoPtjxuYxO3CkqpEkwwFFSs+moDs2rLiC1oyF1gANnOkBqHKV1aO1yKNiiQoBiOJ27X55twRupdZuUJe4RQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802224; c=relaxed/simple;
	bh=A53JHJ6i0N6mdiiXXjZ1oUOsWfNiO2uLc8zv4NAzeLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJWF6Ini7YwEgNBDGglqb16ghUhLi5V8ceLv+60rLVaa8eElqyc1HtZLY8qQTuNmPb6Ie679Hb63/l2xkNzHtsN8dy+tIPoBbM1ih4fk+hJ8fcH160HYRI+XdYVyGPtfQq/KU8D67OR5nSpW+0GZBqKcLDG0VRmwURI0EP6rrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=q8FeuJsN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ELtPug0i9sYUL+KNurYXq5o8o8QrKvtedx3uFu2ZYk4=; b=q8FeuJsN7tk0jIYeKrRIbI3M4L
	qdS+KCCiGpBGH6aXAxkRQ0VbZl3VYoBD40R3DRTmbZgmSlol7/PO3rJHy8+lyGQHlmTb+Ty9psR4V
	XlvtlC3f5rPcm8rtkOuSdgZFs7G3VZHgOvgCQbN95hhP2f3NNk31G0o/xvVPc+AcfSX9ax0hpWEZA
	vVa8FZBWONTVb7WoNPki6EaeWQI3EyJRU6ogVKIMhY2m+dRgjOAxkIEDO2W3dwJMoVhFavh/4gLf/
	Hw1PerJFMIqxaxlcwkYjQFMFyLgOXUbpPmutNNpVM4pCkR5kpcE1Q00uBd371DejM7cndyLZiWE6z
	8x8SIfPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56474)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tsQJz-0005yq-08;
	Wed, 12 Mar 2025 17:56:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tsQJt-0004kK-3A;
	Wed, 12 Mar 2025 17:56:42 +0000
Date: Wed, 12 Mar 2025 17:56:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v8 2/2] net: stmmac: dwc-qos: Add FSD EQoS support
Message-ID: <Z9HK2de5Ba_Vbeo7@shell.armlinux.org.uk>
References: <20250305091246.106626-1-swathi.ks@samsung.com>
 <CGME20250305091856epcas5p4228c09989c7acfe45a99541eef01fbcd@epcas5p4.samsung.com>
 <20250305091246.106626-3-swathi.ks@samsung.com>
 <Z8hjKI1ZqU19nrTP@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KgFmUEDr5J23NjRy"
Content-Disposition: inline
In-Reply-To: <Z8hjKI1ZqU19nrTP@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>


--KgFmUEDr5J23NjRy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2025 at 02:43:52PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 05, 2025 at 02:42:46PM +0530, Swathi K S wrote:
> > The FSD SoC contains two instance of the Synopsys DWC ethernet QOS IP core.
> > The binding that it uses is slightly different from existing ones because
> > of the integration (clocks, resets).
> > 
> > Signed-off-by: Swathi K S <swathi.ks@samsung.com>
> 
> This looks much better!
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Thanks!

Hi Swathi,

Please can you test with my TX clock gating series applied
( https://lore.kernel.org/r/Z9FVHEf3uUqtKzyt@shell.armlinux.org.uk )
with STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP set as per the attached diff.
Please let me know whether this passes your testing, so I know whether
this platform supports it - please check that this results in a
message in the kernel log indicating "tx_clk_stop = 1". Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--KgFmUEDr5J23NjRy
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="stmmac-dwc-qos-eth-tx-clk-stop.diff"

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index a94088b32c11..64867a65e875 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -363,6 +363,7 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 
 	plat_dat->stmmac_clk = dwc_eth_find_clk(plat_dat,
 						data->stmmac_clk_name);
+	plat_dat->flags |= STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
 
 	if (data->probe)
 		ret = data->probe(pdev, plat_dat, &stmmac_res);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6f29804148b6..b015240e4121 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1109,6 +1109,8 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 	if (priv->plat->flags & STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP)
 		priv->tx_lpi_clk_stop = tx_clk_stop;
 
+	netdev_info(priv->dev, "tx_clk_stop = %u\n", priv->tx_lpi_clk_stop);
+
 	stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
 			     STMMAC_DEFAULT_TWT_LS);
 

--KgFmUEDr5J23NjRy--

