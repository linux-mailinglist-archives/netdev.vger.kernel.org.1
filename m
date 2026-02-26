Return-Path: <netdev+bounces-261316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKReI342oGkqgwQAu9opvQ
	(envelope-from <netdev+bounces-261316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:03:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F1D1A5875
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3B163010777
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D49737FF6F;
	Thu, 26 Feb 2026 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLfZrHWE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3237BE6D;
	Thu, 26 Feb 2026 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772107327; cv=none; b=uS0GaZmG2grq81UkWV7Fs690gtSoy6/lJwlsEYqaPGkweX6+xiubhacySIWCy6VHA2hjcdTD+wCH+a33BWZTG1EGbptwH2F7c8HUaYP1Fr1U78bYhwdPFHXcheQ76SSvD4QpxUMdUS6hs/bCpO/0CdN4rowu1QYpZ38iTmQnY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772107327; c=relaxed/simple;
	bh=sGT3zB4PMQOjRhDKzNF3kekJSTQmbRUhYHGyuKAUGNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX6CSvQHiKDwMdgsXUqC/0nSL1pdjbJKnRnGiwZBtjFp3rrmtaRKFgYZGeXm5++8L9Zad2Xmdue0UyVwxxEX0iFY19vtBEeBgmRQbJZ3cSdYV1tlhBQE70kUj1lpVT0ta/+fyF3jQJwgfcWmiXkSUI77p9DvLkquXBi8Pcrjv2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLfZrHWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683BDC116C6;
	Thu, 26 Feb 2026 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772107327;
	bh=sGT3zB4PMQOjRhDKzNF3kekJSTQmbRUhYHGyuKAUGNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TLfZrHWENmWZlBh81ogh6V/eGtLXm0ERJty8FFF8pp7dCJw3dmsqN/quGAJLid+l1
	 MdQb07FXpoVMclP/sCh1opQYGsbNOkjzGHNfFJmF3fMMHoUlmPMKMDhql1WLd92w0S
	 fqdxDfkyCb6k8QsI+Gti5qGykVvLMCtQA95nGUrVQ5pr+lFYHOW3GQeR/r5ty151re
	 2NlRX1iv7osBll+mfheLd3oX+Dk1WhbkmMyW4WmYvMjTCTWWUW/2WkpbkAk17lAVut
	 LtvidLytHdtiwt8Eo/gb0HanXjO3czrTjkAqhDKVmHh8z1lvNSpsJmKZ/Y+RmlqP2t
	 LbPveDPjVPaAA==
Date: Thu, 26 Feb 2026 12:02:00 +0000
From: Simon Horman <horms@kernel.org>
To: Jan Petrous <jan.petrous@oss.nxp.com>
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
Message-ID: <aaA2ODfcRcFDkPPt@horms.kernel.org>
References: <20260223-dwmac_multi_irq-v5-4-8fc699a5fac4@oss.nxp.com>
 <20260225092513.174261-1-horms@kernel.org>
 <aZ7IwgwP5iy2kej8@lsv051416.swis.nl-cdc01.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ7IwgwP5iy2kej8@lsv051416.swis.nl-cdc01.nxp.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261316-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,vger.kernel.org,gmail.com,pengutronix.de,lists.infradead.org,davemloft.net,suse.com,lunn.ch,nxp.com,redhat.com,kernel.org,st-md-mailman.stormreply.com,oss.nxp.com,google.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,linux.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3F1D1A5875
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:02:42AM +0100, Jan Petrous wrote:
> On Wed, Feb 25, 2026 at 09:25:13AM +0000, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > 
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> > ---
> > stmmac: s32: enable support for Multi-IRQ mode
> > 
> > This commit enables Multi-IRQ mode for the S32 DWMAC driver, allowing
> > per-queue IRQs for improved performance. The driver checks for multiple
> > queues and per-queue IRQs, enabling multi-IRQ mode when both are present.
> > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> > > index af594a096676..4aad7077c9d6 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> > 
> > [ ... ]
> > 
> > > @@ -165,6 +165,16 @@ static int s32_dwmac_probe(struct platform_device *pdev)
> > >  	plat->core_type = DWMAC_CORE_GMAC4;
> > >  	plat->pmt = 1;
> > >  	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
> > > +
> > > +	/* Check for multi-IRQ config. Assumption: symmetrical rx/tx queues */
> > > +	if (plat->rx_queues_to_use > 1 &&
> > > +	    (res.rx_irq[0] > 0 && res.tx_irq[0] > 0)) {
> > > +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > > +		dev_info(dev, "Multi-IRQ mode (per queue IRQs) selected\n");
> > > +	} else {
> > > +		dev_info(dev, "MAC IRQ mode selected\n");
> > > +	}
> > 
> > Does this validation check all queues have IRQs? The condition verifies
> > only res.rx_irq[0] and res.tx_irq[0] but doesn't confirm that higher
> > queues have IRQs when rx_queues_to_use > 1.
> > 
> > If a device tree specifies multiple queues but only provides IRQs for
> > queue 0:
> > 
> >     snps,rx-queues-to-use = <2>;
> >     interrupt-names = "macirq", "rx-queue-0", "tx-queue-0";
> >                       /* queue 1 IRQs missing */
> > 
> > The driver would enable STMMAC_FLAG_MULTI_MSI_EN, but later in
> > stmmac_request_irq_multi_msi() (drivers/net/ethernet/stmicro/stmmac/
> > stmmac_main.c), queues with rx_irq[i] == 0 are silently skipped:
> > 
> >     for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
> >         if (priv->rx_irq[i] <= 0)
> >             continue;  /* queue 1+ skipped, no handler registered */
> >         ...
> >     }
> > 
> > This would leave higher-numbered queues with no interrupt handler,
> > causing packet loss when traffic arrives on those queues.
> > 
> > Would it be safer to validate all queue IRQs before enabling multi-IRQ
> > mode, or fall back to MAC IRQ mode if any queue IRQ is missing?
> > 
> > > +
> > >  	plat->rx_fifo_size = 20480;
> > >  	plat->tx_fifo_size = 20480;
> 
> Hi Simon,
> 
> I already addressed this in v6 I sent today.

Thanks!

