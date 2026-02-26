Return-Path: <netdev+bounces-261546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHaUK3OcoGlVlAQAu9opvQ
	(envelope-from <netdev+bounces-261546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:18:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E63571AE42A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8237C3016517
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C366F28726D;
	Thu, 26 Feb 2026 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Uuo9qJeA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3230E820;
	Thu, 26 Feb 2026 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133048; cv=none; b=NPT3SkIX+BwzW0hgEFtD6yKJSBongtUlikX1CL1HmwebJcnDzckEPFMG7/52naige8C8j7Itk8PtOg8GGnDQQgRRs4fGlmxD1UHkzeXsJalyU5PBPdvDDwWz2vQJ78OGWti77ACaAIxYyv6DB3F/+t8gPijlLRzERUaLLYmV7po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133048; c=relaxed/simple;
	bh=1IzP64jz/SkcJX5dvo8R+ulnS8fQwbekOalpkBEHnII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gi9O4ontiPdPbsuNHjeNxnm4agOKEemPOgm955rfcfKG4BGxANlEWavz6qvr95LXA1IdPhSZllUpjysYuXhLeRrLJ/2HAhUik7w5atTLQSC3zaAOyO2Ert5pfR0w146qrl685Emf2heXo+FxA/nExjeDxpNKHHTQeasykqUtqnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Uuo9qJeA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HjiR1TwqXK5Qwrd2T9B+rxf4jSStXBuyud6ZyusRPjc=; b=Uuo9qJeAxZxhSDQvCG2THyfgn6
	goN/SZ5wYmb4g5wzXTMlNaPWkQqKj7uB/6w566SYrPrujxs50sfZYENwPPn3t9yfpjvYbPXUlilqs
	8efDz3idaa358SjlUOzL6LOYivhtxwyWu6qwu3GnzrfJyZW8mWfOAmfqaObgWxP9unvufSwvsMrOf
	edMti+IBUeaF7wa0m+Tt/d92YkneueFcO8a80EDhHf73MxhTIn4vGXNBuZxqaS/gxlDyEiqUPTdNd
	5T+8sKrFrKX+VM2XS0Y+YFMS15vuekaYIfoUBiFJ/j1X7MnCd4/6ap/QOzc5nMk2L1DHkyOZq4WYj
	fIDgys9g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50450)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vvgkl-000000008Lp-1Mml;
	Thu, 26 Feb 2026 19:10:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vvgkg-000000002GM-2Yxa;
	Thu, 26 Feb 2026 19:10:22 +0000
Date: Thu, 26 Feb 2026 19:10:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: jan.petrous@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	vladimir.oltean@nxp.com, boon.khai.ng@altera.com
Subject: Re: [PATCH v7 2/5] net: stmmac: platform: read channels irq
Message-ID: <aaCankErMJZ2XM_s@shell.armlinux.org.uk>
References: <20260226-dwmac_multi_irq-v7-0-f8fe3b945bb4@oss.nxp.com>
 <20260226-dwmac_multi_irq-v7-2-f8fe3b945bb4@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-dwmac_multi_irq-v7-2-f8fe3b945bb4@oss.nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261546-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,altera.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.748];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,shell.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,armlinux.org.uk:url]
X-Rspamd-Queue-Id: E63571AE42A
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 09:54:07AM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> Read IRQ resources for all rx/tx channels, to allow Multi-IRQ mode
> for platform glue drivers.
> 
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 46 +++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 5c9fd91a1db9..93bd915ab6eb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -697,9 +697,40 @@ struct clk *stmmac_pltfr_find_clk(struct plat_stmmacenet_data *plat_dat,
>  }
>  EXPORT_SYMBOL_GPL(stmmac_pltfr_find_clk);
>  
> +static int stmmac_pltfr_get_queue_irqs(struct platform_device *pdev,
> +				       struct stmmac_resources *stmmac_res,
> +				       bool tx)
> +{
> +	int *irqs = tx ? &stmmac_res->tx_irq[0] : &stmmac_res->rx_irq[0];
> +	char name[16];
> +	int i;
> +
> +	/* RX channels irq */
> +	STMMAC_FOREACH_MTL_QUEUE(i, MTL_MAX_RX_QUEUES) {

You've missed that there are two separate definitions for tx and rx
queues - while they are currently the same number, code shouldn't
make that assumption.

> +		scnprintf(name, sizeof(name), "%cx-queue-%d",
> +			  tx ? 't' : 'r', i);

I'm not happy with this method of combining the two loops.

Maybe instead:

static int stmmac_pltfr_get_irq_array(struct platform_device *pdev,
				      const char *fmt, int *irqs,
				      size_t num)
{
	char name[16];
	size_t i;

	for (i = 0; i < num; i++) {
		if (snprintf(name, sizeof(name), fmt, i) >= sizeof(name))
			return -EINVAL;

		irqs[i] = platform_get_irq_byname_optional(pdev, name);
		if (irqs[i] == -EPROBE_DEFER) {
			return irqs[i];
		} else if (irqs[i] <= 0) {
			dev_dbg(&pdev->dev, "IRQ %s not found\n", name);

			irqs[i] = 0;
			break;
		}
	}

	return 0;
}

which has the advantage that it becomes a generic helper for getting an
any array of IRQs.

>  int stmmac_get_platform_resources(struct platform_device *pdev,
>  				  struct stmmac_resources *stmmac_res)
>  {
> +	int ret;
> +
>  	memset(stmmac_res, 0, sizeof(*stmmac_res));
>  
>  	/* Get IRQ information early to have an ability to ask for deferred
> @@ -735,7 +766,20 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>  
>  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
>  
> -	return PTR_ERR_OR_ZERO(stmmac_res->addr);
> +	if (IS_ERR(stmmac_res->addr))
> +		return PTR_ERR(stmmac_res->addr);
> +
> +	/* TX channels irq */
> +	ret = stmmac_pltfr_get_queue_irqs(pdev, stmmac_res, true);
> +	if (ret)
> +		return ret;
> +
> +	/* RX channels irq */
> +	ret = stmmac_pltfr_get_queue_irqs(pdev, stmmac_res, false);
> +	if (ret)
> +		return ret;

These then become:

	ret = stmmac_pltfr_get_irq_array(pdev, "tx-queue-%d", 
					 stmmac_res->tx_irq,
					 MTL_MAX_TX_QUEUES);
	if (ret)
		return ret;

	ret = stmmac_pltfr_get_irq_array(pdev, "rx-queue-%d", 
					 stmmac_res->rx_irq,
					 MTL_MAX_RX_QUEUES);
	if (ret)
		return ret;

This has the advantage that one can grep for rx-queue to find it,
and we also use the correct limit for each queue type.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

