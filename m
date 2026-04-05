Return-Path: <netdev+bounces-275483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Es8GUzG0mk0awcAu9opvQ
	(envelope-from <netdev+bounces-275483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 22:30:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D8A39FC2E
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 22:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B4C53005153
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C10D381AE1;
	Sun,  5 Apr 2026 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="Ikbgq9H8"
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE612D1F1
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775421001; cv=none; b=aMyCKSfgPZ0kSMSLT96pnb5DpRt3xoqqihdJ0rYs8k5MTe5x494QcCKfn0hzB3eq2vXhJ1d0G8mTJN90k5A3pAW3kJqPgO+JiRymM4eXbiKSLZkv4iemDNhX5v9MJxpXbEzeRKNX1hYPOFIgNOheVRTUHrkR5PWpxYUdL9PrBmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775421001; c=relaxed/simple;
	bh=/m7tE5uiT45jEOKZO5eeKfcC54lUdcsO9fL8hru15Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/BPdWhQwQq2e8WyiVTnQ+a/RdZklXI5EnufcI7xKhjoCXY/+RSXb0xWC8ELtTZPaRJj0su21HE3IGj9+F6mARJcRmwTOvrtMeDXHg9Wimdtpb4UPsUCUy93bWSg7YVCNcM5hMBLnrbcb8KgaFuvjoCviu9nd9U8nzUfVcZFTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=Ikbgq9H8; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 38157 invoked from network); 5 Apr 2026 22:23:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1775420595; bh=aO2KdAX3fgjXWdbPQIyTmMPK+gb2J2QgZZc4f899UKg=;
          h=Subject:To:Cc:From;
          b=Ikbgq9H8buAjLgEA5+Ro5pLC20kRZiygilgpWfyrSk4XzxklNbew58M0swKvz9MkW
           ggNH3ncW0vhiBUMRd6zpikFVPAJ6/YxDhFZe6b4T8wgKWuKgiSdIbUY1UlJKJqRELo
           C3n88l7CC2r9PMmfyFL466jzanTOptONNGKZ9H/3qVCSU+YYbQj/qiT/5dbLXZOf0o
           /XK8Xao30VDkHoRtNW5iHjsIErriKq2I4DCkVATcgMQR1RL0gcQO3LP7zuYGT1yu8J
           F2OhsvJLG+fVfiPSaCCi3j/XvqWv624NpmV7ojb44ieahENiEn9Q/8sYyH004/Ztdj
           2OgvpN3vaaBbw==
Received: from 83.5.32.228.ipv4.supernova.orange.pl (HELO [192.168.2.103]) (olek2@wp.pl@[83.5.32.228])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <marek.vasut@mailbox.org>; 5 Apr 2026 22:23:15 +0200
Message-ID: <a03960a2-f313-4c12-98f2-d032ce4a45ad@wp.pl>
Date: Sun, 5 Apr 2026 22:23:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v5 3/3] net: phy: realtek: Add property to enable
 SSC
To: Marek Vasut <marek.vasut@mailbox.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Ivan Galkin <ivan.galkin@axis.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, devicetree@vger.kernel.org
References: <20260326210704.58912-1-marek.vasut@mailbox.org>
 <20260326210704.58912-3-marek.vasut@mailbox.org>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <20260326210704.58912-3-marek.vasut@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: f3dfcffd731df945edb37eebaa8bc550
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YdNs]                               
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275483-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[wp.pl];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wp.pl:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,gmail.com,axis.com,fossekall.de,redhat.com,armlinux.org.uk,nxp.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7D8A39FC2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Marek,


On 26/03/2026 22:06, Marek Vasut wrote:
> Add support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
> RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. The implementation
> follows EMI improvement application note Rev. 1.2 for these PHYs.
>
> The current implementation enables SSC for both RXC and SYSCLK clock
> signals. Introduce DT properties 'realtek,clkout-ssc-enable',
> 'realtek,rxc-ssc-enable' and 'realtek,sysclk-ssc-enable' which control
> CLKOUT, RXC and SYSCLK SSC spread spectrum clocking enablement on these
> signals.
>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Ivan Galkin <ivan.galkin@axis.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Michael Klein <michael@fossekall.de>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: devicetree@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
> V2: Split SSC clock control for each CLKOUT, RXC, SYSCLK signal
> V3: Update RTL8211FVD PHYCR2 comment to state this PHY has PHYCR2 register,
>      but SSC configuration is not supported due to different layout.
> V4: - Perform all SSC configuration before disabling CLKOUT
>      - Perform all SSC configuration in the same order as in the SSC appnote
>      - Rebase on current next, retest using spectrum analyzer again
> V5: s@SCC@SSC@ typo
> ---
>   drivers/net/phy/realtek/realtek_main.c | 131 +++++++++++++++++++++++++
>   1 file changed, 131 insertions(+)
>
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 023e47ad605bd..0b5d35841fdd4 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -75,10 +75,18 @@
>   
>   #define RTL8211F_PHYCR2				0x19
>   #define RTL8211F_CLKOUT_EN			BIT(0)
> +#define RTL8211F_SYSCLK_SSC_EN			BIT(3)
>   #define RTL8211F_PHYCR2_PHY_EEE_ENABLE		BIT(5)
> +#define RTL8211F_CLKOUT_SSC_EN			BIT(7)
>   
>   #define RTL8211F_INSR				0x1d
>   
> +/* RTL8211F SSC settings */
> +#define RTL8211F_SSC_PAGE			0xc44
> +#define RTL8211F_SSC_RXC			0x13
> +#define RTL8211F_SSC_SYSCLK			0x17
> +#define RTL8211F_SSC_CLKOUT			0x19
> +
>   /* RTL8211F LED configuration */
>   #define RTL8211F_LEDCR_PAGE			0xd04
>   #define RTL8211F_LEDCR				0x10
> @@ -215,6 +223,9 @@ MODULE_LICENSE("GPL");
>   struct rtl821x_priv {
>   	bool enable_aldps;
>   	bool disable_clk_out;
> +	bool enable_clkout_ssc;
> +	bool enable_rxc_ssc;
> +	bool enable_sysclk_ssc;
>   	struct clk *clk;
>   	/* rtl8211f */
>   	u16 iner;
> @@ -278,6 +289,12 @@ static int rtl821x_probe(struct phy_device *phydev)
>   						   "realtek,aldps-enable");
>   	priv->disable_clk_out = of_property_read_bool(dev->of_node,
>   						      "realtek,clkout-disable");
> +	priv->enable_clkout_ssc = of_property_read_bool(dev->of_node,
> +							"realtek,clkout-ssc-enable");
> +	priv->enable_rxc_ssc = of_property_read_bool(dev->of_node,
> +						     "realtek,rxc-ssc-enable");
> +	priv->enable_sysclk_ssc = of_property_read_bool(dev->of_node,
> +							"realtek,sysclk-ssc-enable");
>   
>   	phydev->priv = priv;
>   
> @@ -707,6 +724,108 @@ static int rtl8211f_config_phy_eee(struct phy_device *phydev)
>   			  RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
>   }
>   
> +static int rtl8211f_config_clkout_ssc(struct phy_device *phydev)
> +{
> +	struct rtl821x_priv *priv = phydev->priv;
> +	struct device *dev = &phydev->mdio.dev;
> +	int ret;
> +
> +	/* The value is preserved if the device tree property is absent */
> +	if (!priv->enable_clkout_ssc)
> +		return 0;
> +
> +	/* RTL8211FVD has PHYCR2 register, but configuration of CLKOUT SSC
> +	 * is not currently supported by this driver due to different bit
> +	 * layout.
> +	 */
> +	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
> +		return 0;
> +
> +	/* Unnamed registers from EMI improvement parameters application note 1.2 */
> +	ret = phy_write_paged(phydev, 0xd09, 0x10, 0xcf00);
> +	if (ret < 0) {
> +		dev_err(dev, "CLKOUT SSC initialization failed: %pe\n", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	ret = phy_write(phydev, RTL8211F_SSC_CLKOUT, 0x38c3);

Only registers 0x10–0x17 require paged operations. The remaining registers
are mapped directly into the PHY address space. This is mentioned in commit
650e55f224a575cdb18c984b95036109519502d1. Paged and direct access return
the same results. With this in mind, I believe that RTL8211F_SSC_CLKOUT is
an alias for RTL8211F_PHYCR2 and is described on page 45 of the 
datasheet[1].

1. RTL8211F(I)-CG/RTL8211FD(I)-CG Datasheet

Best Regards,
Aleksander


