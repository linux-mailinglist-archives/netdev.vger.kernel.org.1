Return-Path: <netdev+bounces-260859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLZIH9zInmkuXQQAu9opvQ
	(envelope-from <netdev+bounces-260859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:03:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC40195733
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BFAB30156E6
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6C73624B9;
	Wed, 25 Feb 2026 10:02:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371919B5B1;
	Wed, 25 Feb 2026 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013770; cv=none; b=adO934OpumRdITCGXh4RDdkQ2k1RqtXeqtX3JqJFFYIoP90RFxM0g/O9mWV6hz8xmlSwtj+afzTnTe4HkmiAnejgYoKasMEh0GAxbCV6PfoP1OhBv4LFXWCGB6npC2Xtu+Ls5Mui6cTFRgZtQnnR7817UyKMg9raUO0GKtt2I+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013770; c=relaxed/simple;
	bh=5qu0+i5/S8lFVCwnC3vdFY4BnnruuoF7pmrW57g1tqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNngFNGjmfiZb0YNI8ch604aah6+m8cBgt8YkAf8FL0L/3PaDNs7zykGqCgeeuxmr3ue2FkWLHWbImg1AcM0KBSGtAIOhkWlLJv6JLvf3+gjJS4ObJpb5IF5t8S/k8VrUBtZPe1gECpGhHUfqxatBas67uxg98Pm7Fz/UetIY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2FA77200D05;
	Wed, 25 Feb 2026 11:02:42 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 13AFE200D16;
	Wed, 25 Feb 2026 11:02:42 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CD6852037D;
	Wed, 25 Feb 2026 11:02:41 +0100 (CET)
Date: Wed, 25 Feb 2026 11:02:42 +0100
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
Subject: Re: [v5,4/4] stmmac: s32: enable support for Multi-IRQ mode
Message-ID: <aZ7IwgwP5iy2kej8@lsv051416.swis.nl-cdc01.nxp.com>
References: <20260223-dwmac_multi_irq-v5-4-8fc699a5fac4@oss.nxp.com>
 <20260225092513.174261-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225092513.174261-1-horms@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[foss.st.com,vger.kernel.org,gmail.com,pengutronix.de,lists.infradead.org,davemloft.net,suse.com,lunn.ch,nxp.com,redhat.com,kernel.org,st-md-mailman.stormreply.com,oss.nxp.com,google.com,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260859-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.petrous@oss.nxp.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.940];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lsv051416.swis.nl-cdc01.nxp.com:mid]
X-Rspamd-Queue-Id: 3DC40195733
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:25:13AM +0000, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> stmmac: s32: enable support for Multi-IRQ mode
> 
> This commit enables Multi-IRQ mode for the S32 DWMAC driver, allowing
> per-queue IRQs for improved performance. The driver checks for multiple
> queues and per-queue IRQs, enabling multi-IRQ mode when both are present.
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> > index af594a096676..4aad7077c9d6 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> 
> [ ... ]
> 
> > @@ -165,6 +165,16 @@ static int s32_dwmac_probe(struct platform_device *pdev)
> >  	plat->core_type = DWMAC_CORE_GMAC4;
> >  	plat->pmt = 1;
> >  	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
> > +
> > +	/* Check for multi-IRQ config. Assumption: symmetrical rx/tx queues */
> > +	if (plat->rx_queues_to_use > 1 &&
> > +	    (res.rx_irq[0] > 0 && res.tx_irq[0] > 0)) {
> > +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > +		dev_info(dev, "Multi-IRQ mode (per queue IRQs) selected\n");
> > +	} else {
> > +		dev_info(dev, "MAC IRQ mode selected\n");
> > +	}
> 
> Does this validation check all queues have IRQs? The condition verifies
> only res.rx_irq[0] and res.tx_irq[0] but doesn't confirm that higher
> queues have IRQs when rx_queues_to_use > 1.
> 
> If a device tree specifies multiple queues but only provides IRQs for
> queue 0:
> 
>     snps,rx-queues-to-use = <2>;
>     interrupt-names = "macirq", "rx-queue-0", "tx-queue-0";
>                       /* queue 1 IRQs missing */
> 
> The driver would enable STMMAC_FLAG_MULTI_MSI_EN, but later in
> stmmac_request_irq_multi_msi() (drivers/net/ethernet/stmicro/stmmac/
> stmmac_main.c), queues with rx_irq[i] == 0 are silently skipped:
> 
>     for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
>         if (priv->rx_irq[i] <= 0)
>             continue;  /* queue 1+ skipped, no handler registered */
>         ...
>     }
> 
> This would leave higher-numbered queues with no interrupt handler,
> causing packet loss when traffic arrives on those queues.
> 
> Would it be safer to validate all queue IRQs before enabling multi-IRQ
> mode, or fall back to MAC IRQ mode if any queue IRQ is missing?
> 
> > +
> >  	plat->rx_fifo_size = 20480;
> >  	plat->tx_fifo_size = 20480;

Hi Simon,

I already addressed this in v6 I sent today.

/Jan

