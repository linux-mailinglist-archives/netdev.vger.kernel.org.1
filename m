Return-Path: <netdev+bounces-193227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 382CCAC3009
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 16:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49D907A5704
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDC21DE2A5;
	Sat, 24 May 2025 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xm+Fntir"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7249444;
	Sat, 24 May 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748098140; cv=none; b=u9CiaVyehrq2+j7tuEbi/ESBnBA1W3rr3tpjH5jF4vx7i4Vu4QSVzqGbpjR8MLIHJmB+VoowjVfLCMkE04d0R5KkG6v2cfpG25WSsS3IkArIcNhEXCIbUA7hJ7+ibu/lf9xoB094PTuVZDPT5IelXZiXOk4P+Ds+eBUJKBuLLMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748098140; c=relaxed/simple;
	bh=hi0FhnivKthEbtDL/pIRmuxZrvxkLdiF0ueMxA2JKu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMbyd0uGWeJonxEVl54V8L9KtoiTfcgSZFki21f0rr86DuPLKjuS0/uR+P/pw4OE8xK8EjdL4kULTrztRsw6z4ddWB50FA/sX/6tQ3r5D9FD8hrhx29hu1BGFZNk+Dv2dk8TUPpt4ekCMB6dE0fGl1llOiD6stWh3FlO231x5+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xm+Fntir; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=6j+A/wcAjjzOXucCcPrPqRyyoTRY9hnx7kS73VHwOW0=; b=Xm
	+Fntir9xBjM2MNWbSndaFmwEXhYF9USaPzzlIBnIdtYCNjV4ZIq9s5XoD2o1OaBJXNVmTu9z5TRMd
	DNKc6sxBSylhkLtYUeHzjykapObNfBt7gPISSXSgjjNCK2lIOsy/V1psSSVvUhRSOwIEWMD8OVuTi
	VWCCVcoaxKAAdTY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uIqAZ-00DglV-8h; Sat, 24 May 2025 16:48:15 +0200
Date: Sat, 24 May 2025 16:48:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: lizhe <sensor1010@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, jonas@kwiboo.se,
	rmk+kernel@armlinux.org.uk, david.wu@rock-chips.com, wens@csie.org,
	u.kleine-koenig@baylibre.com, an.petrous@oss.nxp.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] net: dwmac-rk: MAC clock should be truned off
Message-ID: <112fa3c4-908d-4e31-9288-b3a2949555b0@lunn.ch>
References: <20250523151521.3503-1-sensor1010@163.com>
 <d5325aba-507e-47b6-83fb-b9156c1f351e@lunn.ch>
 <2525c791.3415.197029d3705.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2525c791.3415.197029d3705.Coremail.sensor1010@163.com>

On Sat, May 24, 2025 at 10:05:47PM +0800, lizhe wrote:
> Hi， Anerdw
> The following is the logic for calling this function： 
> 
> 
> rk_gmac_powerup() {
> 
> ret = phy_power_on(bsp_priv, true);      // here.
> 
> if (ret) {
> 
> gmac_clk_enable(bsp_priv, false);
> 
> return ret;
> 
> }
> 
> }

Ah, there is something funny with your patch. Look at the diff:

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 700858ff6f7c..036e45be5828 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1648,7 +1648,7 @@  static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)

This line tells you where in the file you are patching, and the
function to be patched. This is what i looked at,
gmac_clk_enable(). And gmac_clk_enable() has a similar structure, ret
declared at the beginning, return 0 at the end. But the only way to
that return 0 is without error.

But patch is actually for:

 static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
 {
 	struct regulator *ldo = bsp_priv->regulator;
-	int ret;
+	int ret = 0;
 	struct device *dev = &bsp_priv->pdev->dev;
 
 	if (enable) {
@@ -1661,7 +1661,7 @@  static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
 			dev_err(dev, "fail to disable phy-supply\n");
 	}
 
-	return 0;
+	return ret;
 }

And agree, the error codes are ignored in phy_power_on().

But i have a few questions:

How did you generate this diff? This is the first time i've made this
mistake, as far as i know. I trust the context information when
reviewing patches. Yet here it is wrong. Why? Is this actually normal?
I know diff gets it wrong for python, i don't trust it at all with
that language, but i've not noticed such problems with C.

Did you look at the history of phy_power_on()? It looks pretty
deliberate ignoring errors. Maybe there is a reason why this happens?
git blame and git log might explain why it is like this.

	Andrew

