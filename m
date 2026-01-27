Return-Path: <netdev+bounces-253862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCgBCsu4eGlzsQEAu9opvQ
	(envelope-from <netdev+bounces-253862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:08:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 802CA94AAC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 226DB300FEE3
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA1D35581A;
	Tue, 27 Jan 2026 13:08:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE75B2C0F90;
	Tue, 27 Jan 2026 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519296; cv=none; b=juB/27xJkn7M8jEzbp5Mx81+KJOo32UfgXdjv3fK1fKysbrNPzSj9Syd8GKV3HMTQd8H1XwHKOtZAbw/vq2YoZq8WWF3P82k5AIpR6XceX2aKFX2AMI0TDrDJ4xovC7OqwjDQDuJHR2s0+E0+WgWeTlr/NU9WNzcFCloz6NIh8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519296; c=relaxed/simple;
	bh=N1l7Xcdsy/WX2cxiwgs6A67+VXpNHf9W2RVpoBOfJeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAFYf1hcJSSCHnQB/zf+zc3FSA6w5g9aBzNCjk0aC7vnGQO6LqLHDqNp06Y1l+d1hFzXc00k9DTvQThAMaA84+RmbdxuUs0Uri5xF8HPFY/O/PUWyBf1nclWKarNZ8qZKLKsZArgDBnQIup//luODPpw7nMv5+VogcvTYv24byw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 76A9020295F;
	Tue, 27 Jan 2026 14:08:13 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C3EA20295E;
	Tue, 27 Jan 2026 14:08:13 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A168D20405;
	Tue, 27 Jan 2026 14:08:12 +0100 (CET)
Date: Tue, 27 Jan 2026 14:08:13 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: robh@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de,
	mcoquelin.stm32@gmail.com, kernel@pengutronix.de, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, chester62515@gmail.com,
	s32@nxp.com, linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com, festevam@gmail.com,
	alexandre.torgue@foss.st.com, davem@davemloft.net,
	krzk+dt@kernel.org, mbrugger@suse.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [v3,4/4] stmmac: s32: enable support for Multi-IRQ mode
Message-ID: <aXi4vRvcCa+8LSKt@lsv051416.swis.nl-cdc01.nxp.com>
References: <20260123-dwmac_multi_irq-v3-4-cc53f2be8961@oss.nxp.com>
 <20260125221405.3395497-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125221405.3395497-1-kuba@kernel.org>
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
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[kernel.org,st-md-mailman.stormreply.com,vger.kernel.org,pengutronix.de,gmail.com,redhat.com,google.com,lunn.ch,nxp.com,oss.nxp.com,foss.st.com,davemloft.net,suse.com,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253862-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.petrous@oss.nxp.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lsv051416.swis.nl-cdc01.nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 802CA94AAC
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 02:14:05PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> stmmac: s32: enable support for Multi-IRQ mode
> 
> This patch enables Multi-IRQ mode for the S32 DWMAC driver when both
> multi-queue and per-queue IRQs are configured. The driver now selects
> between Multi-IRQ and MAC IRQ modes based on device tree configuration.
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> > index 5a485ee98fa7..342091045714 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> 
> [ ... ]
> 
> > @@ -149,6 +149,16 @@ static int s32_dwmac_probe(struct platform_device *pdev)
> >  	plat->core_type = DWMAC_CORE_GMAC4;
> >  	plat->pmt = 1;
> >  	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
> > +
> > +	/* Check for multi-IRQ config. Assumption: symetrical rx/tx queues */
> > +	if (plat->rx_queues_to_use > 1 &&
> > +	    (res.rx_irq[0] >= 0 || res.tx_irq[0] >= 0)) {
>                         ^^^^            ^^^^
> 
> Should these checks be "> 0" instead of ">= 0"?
> 
> stmmac_get_platform_resources() initializes the res structure with
> memset(0), then only writes positive IRQ values when per-queue IRQs are
> found in the device tree. If no "rx-queue-0" or "tx-queue-0" interrupt
> names are defined, rx_irq[0] and tx_irq[0] remain 0 from the memset.

The AI is wrong on this statesment. The loop reading IRQs from DT
in stmmac_get_platform_resources() returns also negative value
for missed queue IRQ line. And this is used as flag if multi-IRQ
can be enabled or not.

But I must agree that the comparition shall not include 0 as valid
value for IRQ, so I will fix it in v4.

Thanks.
/Jan

