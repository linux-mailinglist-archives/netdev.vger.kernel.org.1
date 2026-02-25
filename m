Return-Path: <netdev+bounces-260855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGC9Ey7Jnmm0XQQAu9opvQ
	(envelope-from <netdev+bounces-260855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:04:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A21EA19576F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E454A304FFBD
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870CA2C21DF;
	Wed, 25 Feb 2026 10:01:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA9281356;
	Wed, 25 Feb 2026 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013682; cv=none; b=BrYpGBoMjKxxq88BKYryixB47DptPHQIMavYudpIOniqqItbXPTVvEz438G9EYm6W/ydD40q4Os8NmnX+xqjc1o7icuVV/XoWjDGaZh4dubB3h6JmkH+2ugg3/+qJvBrD86FjFgtSHesCF3QA2Qjz/1A05WCtTfWBcJQcnBWt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013682; c=relaxed/simple;
	bh=yQgA846g9F0VfW6BuzxXhG7ymqpug5mYDB100JdwX9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gncl1LBzCM+EUj4+6HIGlg2eOtYidsm2rwDt8ts57b7W56/TI0B3LfL1wrBvfp3etXR0/Dtt+1Z0mjh3OChB/p+0ttGHxAmIpO2qnCIM7utm0mq6DDiUG8ToOvwAjHe86BD5MDS/yBHWvc2fAQ3WI7XXgl1Chj5lYbZh+K7+qWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 28B381A30BB;
	Wed, 25 Feb 2026 11:01:13 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F001C1A2F90;
	Wed, 25 Feb 2026 11:01:12 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id ADB012037D;
	Wed, 25 Feb 2026 11:01:12 +0100 (CET)
Date: Wed, 25 Feb 2026 11:01:12 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: alexandre.torgue@foss.st.com, devicetree@vger.kernel.org,
	festevam@gmail.com, chester62515@gmail.com, s.hauer@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, davem@davemloft.net,
	mbrugger@suse.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	s32@nxp.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
	robh@kernel.org, kuba@kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	ghennadi.procopciuc@oss.nxp.com, kernel@pengutronix.de,
	shawnguo@kernel.org, edumazet@google.com, mcoquelin.stm32@gmail.com,
	imx@lists.linux.dev
Subject: Re: [v5,1/4] net: stmmac: platform: read channels irq
Message-ID: <aZ7IaP0pFRLYR/iA@lsv051416.swis.nl-cdc01.nxp.com>
References: <20260223-dwmac_multi_irq-v5-1-8fc699a5fac4@oss.nxp.com>
 <20260225092456.174241-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225092456.174241-1-horms@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[foss.st.com,vger.kernel.org,gmail.com,pengutronix.de,lists.infradead.org,davemloft.net,suse.com,lunn.ch,nxp.com,redhat.com,kernel.org,st-md-mailman.stormreply.com,oss.nxp.com,google.com,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260855-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.petrous@oss.nxp.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.939];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,lsv051416.swis.nl-cdc01.nxp.com:mid]
X-Rspamd-Queue-Id: A21EA19576F
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:24:56AM +0000, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: stmmac: platform: read channels irq
> 
> This commit adds support for reading IRQ resources for all rx/tx channels
> in the stmmac platform driver to enable Multi-IRQ mode for platform glue
> drivers.
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index 5c9fd91a1db9..6166a9b0c0bb 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -700,6 +700,9 @@ EXPORT_SYMBOL_GPL(stmmac_pltfr_find_clk);
> >  int stmmac_get_platform_resources(struct platform_device *pdev,
> >  				  struct stmmac_resources *stmmac_res)
> >  {
> > +	char name[16];
> > +	int i;
> > +
> >  	memset(stmmac_res, 0, sizeof(*stmmac_res));
> >
> >  	/* Get IRQ information early to have an ability to ask for deferred
> > @@ -735,7 +738,42 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
> >
> >  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
> >
> > -	return PTR_ERR_OR_ZERO(stmmac_res->addr);
> > +	if (IS_ERR(stmmac_res->addr))
> > +		return PTR_ERR(stmmac_res->addr);
> > +
> > +	/* RX channels irq */
> > +	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
> > +		scnprintf(name, sizeof(name), "rx-queue-%d", i);
> > +		stmmac_res->rx_irq[i] = platform_get_irq_byname_optional(pdev,
> > +									 name);
> > +		if (stmmac_res->rx_irq[i] <= 0) {
> > +			if (stmmac_res->rx_irq[i] == -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> > +			dev_dbg(&pdev->dev, "IRQ rx-queue-%d not found\n", i);
> > +
> > +			/* Stop on first unset rx-queue-%i property member */
> > +			stmmac_res->rx_irq[i] = 0;
> > +			break;
> > +		}
> > +	}
> > +
> > +	/* TX channels irq */
> > +	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
> > +		scnprintf(name, sizeof(name), "tx-queue-%d", i);
> > +		stmmac_res->tx_irq[i] = platform_get_irq_byname_optional(pdev,
> > +									 name);
> > +		if (stmmac_res->tx_irq[i] <= 0) {
> > +			if (stmmac_res->tx_irq[i] == -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> > +			dev_dbg(&pdev->dev, "IRQ tx-queue-%d not found\n", i);
> > +
> > +			/* Stop on first unset tx-queue-%i property member */
> > +			stmmac_res->tx_irq[i] = 0;
> > +			break;
> > +		}
> > +	}
> 
> This isn't a bug, but the RX and TX channel IRQ handling blocks follow an
> identical 14-line pattern that differs only in the queue name format string
> and target array. Both blocks format the IRQ name with scnprintf(), call
> platform_get_irq_byname_optional(), check for -EPROBE_DEFER, log a debug
> message on error, and break on the first missing IRQ.
> 
> Could this duplication be reduced with a helper function? Note that the
> existing code in this function already contains similar non-factored
> patterns for wol_irq and sfty_irq handling, so this level of duplication
> may be acceptable in this file's style.
> 

Hi Simon,
I already addressed this in v6, I sent today.

/Jan

