Return-Path: <netdev+bounces-253851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI5ZMtC1eGlzsQEAu9opvQ
	(envelope-from <netdev+bounces-253851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:55:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC63948B0
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16F7B303F062
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD86355811;
	Tue, 27 Jan 2026 12:52:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292123559CD;
	Tue, 27 Jan 2026 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518326; cv=none; b=m8tAt5fZtpe3gRF5/gC4dFlLMAgkFAHvtIfKd+dOXTlTEAClCRJ0DuTSx1oyQLMP2kPhKGjepq2PLj5XF0I4MMRV6gHTgmee7wuw2sioB2xzBPP6H7UK55ngCUJ2qk1WXSixJvwOZ1gifGOo3JzKe7lce6o1I/EdSgaSC6bi5q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518326; c=relaxed/simple;
	bh=CPjTTaJBx9OQhXhmS7tOoshwFrxUYmb+rPvV/z7zl10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQBwiCZ4TqmKfS526ysS2Vb0FSGwn7WSJfhzXUwNCQgatFywvz6u+NiMeJdVEp5y+/xw37SkNeP5uyB1t3+AZSXe9neNTlHcaSPbT5awX7C11937LEK9xYo4vRGt8dCBCmdKCBUQHWTM2/D3IwwIynDT26L1nD6yj3ASHVvfGjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 582862015BF;
	Tue, 27 Jan 2026 13:51:58 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 372B72015BB;
	Tue, 27 Jan 2026 13:51:58 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C9FF20383;
	Tue, 27 Jan 2026 13:51:57 +0100 (CET)
Date: Tue, 27 Jan 2026 13:51:58 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Conor Dooley <conor@kernel.org>
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
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: net: nxp,s32-dwmac: Declare
 per-queue interrupts
Message-ID: <aXi07hPBrl7EYezi@lsv051416.swis.nl-cdc01.nxp.com>
References: <20260123-dwmac_multi_irq-v3-0-cc53f2be8961@oss.nxp.com>
 <20260123-dwmac_multi_irq-v3-2-cc53f2be8961@oss.nxp.com>
 <20260123-dinner-aloft-e57deb6c546a@spud>
 <aXdiNb92B4HH+ZFt@lsv051416.swis.nl-cdc01.nxp.com>
 <20260126-blinker-secluding-a745f60caccb@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-blinker-secluding-a745f60caccb@spud>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253851-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.petrous@oss.nxp.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,lsv051416.swis.nl-cdc01.nxp.com:mid]
X-Rspamd-Queue-Id: 4DC63948B0
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 08:00:33PM +0000, Conor Dooley wrote:
> On Mon, Jan 26, 2026 at 01:46:45PM +0100, Jan Petrous wrote:
> > On Fri, Jan 23, 2026 at 05:13:03PM +0000, Conor Dooley wrote:
> > > On Fri, Jan 23, 2026 at 11:09:55AM +0100, Jan Petrous via B4 Relay wrote:
> > > > From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> > > > 
> > > > The DWMAC IP on NXP S32G/R SoCs has connected queue-based IRQ lines,
> > > > set them to allow using Multi-IRQ mode when supported.
> > > 
> > > The binding only supports s32{g,r} devices, why is the existing minimum
> > > retained? What devices are going to not have all 11 interrupts
> > > connected?
> > > 
> > 
> > The original idea was to support backward compatibility, as older DTs
> > didn't contain queue-based interrupt lines described.
> > 
> > But now, when you asked, I started to think it is not needed,
> > the requirement for backward compatibility is managed inside the driver
> > and yaml shall describe the hardware not used configuration.
> 
> Just to be clear, cos the last portion of that "yaml shall..." isn't to
> me, you mean that the driver will support 1 or 11 interrupts but you
> will make the binding only allow 11? That would be fine.
> Just note in the commit message that all of these devices have the 11
> interrupts.
> 

Well, all those supported devices have 11 interrupts connected (1x MAC),
then 5x RX (queue0..queue4) and  5x TX (queue0..queue4).

Until now, the driver was using on MAC IRQ, so the only one shared line.
Now, we are enabling support for per-queue interrupts, what means for
supported SoCs up to 11 IRQs as the DWMAC IP on S32G/R has 5 queues.

The driver can still opearate on this one shared IRQ mode, but
if the DT node configuration describes all IRQs, then the driver switch
to multi-IRQ mode. What allows better distribution of processor core
load.

So the 11 IRQs are the maximum value, in the case when all queues are
used. But I can imagine some other use-cases, when not all queues
are enabled, ie. only queue0 and quque1. In that case, the driver will
use some subset of all IRQs.
That means that DT can contain only lesser interrupt list then maximum.

I feel like having "minItems: 1" shall cover such use-case.

BR.
/Jan


