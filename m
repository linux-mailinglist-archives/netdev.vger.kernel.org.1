Return-Path: <netdev+bounces-233977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCFBC1B1B3
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92A1E5A8FE7
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD5B3358A4;
	Wed, 29 Oct 2025 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IlvV06IP"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE3335091;
	Wed, 29 Oct 2025 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744855; cv=none; b=O+G699u/yPzi3HMJ74brY+af8nN3V3yYqweQZzu42TOMJM+nC/xFBDbbqI2/I6tXXnufWiDlB9J7xeXRNo2kAqr97fK+P3M8bEb/hXgRk4tcE7HY0WTrQTpMo2ZRsPdsMPGpIG3oSnZ/P83LHF7GB4gq90PuFmAimc1tW8dKhx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744855; c=relaxed/simple;
	bh=yYeetJE7nU39JRPQ2bAqGA8v27+L3KLdnP1omdhZg9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjRBV7v0PsWCKnA6XW8Lrq9h7TS0IOzyrE8mpF2TY9/uJ4fhlyNTGqOyOlQcwEe0sWXgSYnpVH/r5lOjuCNCROQXmUqx76MZIqZBZDq0h1soKSJRgA3s9Ved+hSpOc/DiMsBb5RQpzo2NJC+ndbOanty/EuSRwPQWwys3ynJeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IlvV06IP; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6C7FB1A1747;
	Wed, 29 Oct 2025 13:34:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3C4CB606E8;
	Wed, 29 Oct 2025 13:34:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5403117F80A7;
	Wed, 29 Oct 2025 14:34:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744849; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=wKk+FxFdhXoaDcRKRxsyJt9b/J7SbDXNlJUTNBILMfk=;
	b=IlvV06IPxNV2S5cD3etgy/hG0vlnjV/OCq7pn1FljLu3y+j9LSE8lJ+s37shkWZW0mMdTk
	eMWXv/Ppz0BCT8/zs8UuD+EDdLzvwEnPhHnKlk5bQNO5EsyUOnileffmhKTPKgfHHXd3R/
	WxEHlJKZA8JGmH50riHR7E4iq6+ohacOWUHCtPz5Iam2AquOuVF+6uysOV1+ZW8cLz8c/z
	QIMN1lgRw7C07B+283adVEJrTHS2iQcpxEtErsytiGX5WR0C7O89fvYuR2tyAHMIABCYtP
	K8gHywFCOqvzhRqY3WUxcJsw8jeNI7TOi8tlzCFEYg5pQPBLkO5tIyOTPpuF/Q==
Message-ID: <a871daac-364e-4c2c-8343-d458b373e1fd@bootlin.com>
Date: Wed, 29 Oct 2025 14:34:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: stmmac: socfpga: Agilex5 EMAC platform
 configuration
To: rohan.g.thomas@altera.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251029-agilex5_ext-v1-0-1931132d77d6@altera.com>
 <20251029-agilex5_ext-v1-1-1931132d77d6@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251029-agilex5_ext-v1-1-1931132d77d6@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Rohan,

On 29/10/2025 09:06, Rohan G Thomas via B4 Relay wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> Agilex5 HPS EMAC uses the dwxgmac-3.10a IP, unlike previous socfpga
> platforms which use dwmac1000 IP. Due to differences in platform
> configuration, Agilex5 requires a distinct setup.
> 
> Introduce a setup_plat_dat() callback in socfpga_dwmac_ops to handle
> platform-specific setup. This callback is invoked before
> stmmac_dvr_probe() to ensure the platform data is correctly
> configured. Also, implemented separate setup_plat_dat() callback for
> current socfpga platforms and Agilex5.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 53 ++++++++++++++++++----
>  1 file changed, 43 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 2ff5db6d41ca08a1652d57f3eb73923b9a9558bf..3dae4f3c103802ed1c2cd390634bd5473192d4ee 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -44,6 +44,7 @@
>  struct socfpga_dwmac;
>  struct socfpga_dwmac_ops {
>  	int (*set_phy_mode)(struct socfpga_dwmac *dwmac_priv);
> +	void (*setup_plat_dat)(struct socfpga_dwmac *dwmac_priv);
>  };
>  
>  struct socfpga_dwmac {
> @@ -441,6 +442,39 @@ static int socfpga_dwmac_init(struct platform_device *pdev, void *bsp_priv)
>  	return dwmac->ops->set_phy_mode(dwmac);
>  }
>  
> +static void socfpga_common_plat_dat(struct socfpga_dwmac *dwmac)
> +{
> +	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
> +
> +	plat_dat->bsp_priv = dwmac;
> +	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
> +	plat_dat->init = socfpga_dwmac_init;
> +	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
> +	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
> +	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
> +}
> +
> +static void socfpga_gen5_setup_plat_dat(struct socfpga_dwmac *dwmac)
> +{
> +	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
> +
> +	socfpga_common_plat_dat(dwmac);
> +
> +	plat_dat->core_type = DWMAC_CORE_GMAC;
> +
> +	/* Rx watchdog timer in dwmac is buggy in this hw */
> +	plat_dat->riwt_off = 1;
> +}
> +
> +static void socfpga_agilex5_setup_plat_dat(struct socfpga_dwmac *dwmac)
> +{
> +	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
> +
> +	socfpga_common_plat_dat(dwmac);

I"m not familiar with this device (I only have a Cyclone V on hand), does
it still make sense to try to instantiate a Lynx (i.e. Altera TSE) PCS
for that IP ?

Maxime


