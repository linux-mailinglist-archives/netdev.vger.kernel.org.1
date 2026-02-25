Return-Path: <netdev+bounces-260872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFKIE+DQnmnwXQQAu9opvQ
	(envelope-from <netdev+bounces-260872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:37:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 104C9195DA0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03B68301A53B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBD0392C4C;
	Wed, 25 Feb 2026 10:37:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C0737E314;
	Wed, 25 Feb 2026 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772015838; cv=none; b=eX814Z3mUI8B2ks4y7cUxpW5NkZZrPgcCPLMmVDzbhtZMBNq49wPzyVxJFS3tAWhOthKFwPHJc0orgSKu/9bDwTrDn7ajmOEqveI9ew1rqvsnEczRyxawIARNZ7InCYXJqM18FlLm7sYq0PzmXXfqdRHaZdY4X+oOI/LRqT2tZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772015838; c=relaxed/simple;
	bh=XAo0SAoAScEQAg3DJvyqMJcqXCl+GogI+O5M1ePGZ20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dr8jCqv1lvoFS4Q4xSx8qzW8/dLnB0ULzkwSiNEoSX3miynKy2gu+JOS1sLdTMRIzFT20zK/WH+kWp90L/V6dPQJa+IrxGpeofl8mDv+Mt5TnqRzSsnzuIgVNX3iWHRVNgnob51O0QoEAV+cpi4LYE0A5GU5etAqPAluI2uwnfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C1BAC20125B;
	Wed, 25 Feb 2026 11:37:14 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A9551200D18;
	Wed, 25 Feb 2026 11:37:14 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6CCF5203C7;
	Wed, 25 Feb 2026 11:37:14 +0100 (CET)
Date: Wed, 25 Feb 2026 11:37:14 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/5] dt-bindings: net: nxp,s32-dwmac: Declare
 per-queue interrupts
Message-ID: <aZ7Q2saxrPzNXL+x@lsv051416.swis.nl-cdc01.nxp.com>
References: <20260225-dwmac_multi_irq-v6-0-245bf1d7110c@oss.nxp.com>
 <20260225-dwmac_multi_irq-v6-3-245bf1d7110c@oss.nxp.com>
 <aZ7ACLx1yUMWPAsZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ7ACLx1yUMWPAsZ@shell.armlinux.org.uk>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260872-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.petrous@oss.nxp.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.942];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lsv051416.swis.nl-cdc01.nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 104C9195DA0
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:25:28AM +0000, Russell King (Oracle) wrote:
> On Wed, Feb 25, 2026 at 10:20:35AM +0100, Jan Petrous via B4 Relay wrote:
> > From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> > 
> > The DWMAC IP on NXP S32G/R SoCs has connected queue-based IRQ lines,
> > set them to allow using Multi-IRQ mode.
> > 
> > Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> > ---
> >  .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 44 +++++++++++++++++++---
> 
> As you have added support for these IRQs into the generic code,
> shouldn't the generic dwmac binding doc reflect that this is now
> supported?
> 

Hi Russell,

the generic yaml has such interrupt names already declared:
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/net/snps%2Cdwmac.yaml#L142

Here is the current interrupt snippet:

  interrupt-names:
    minItems: 1
    maxItems: 19
    items:
      oneOf:
        - description: Combined signal for various interrupt events
          const: macirq
        - description: The interrupt to manage the remote wake-up packet detection
          const: eth_wake_irq
        - description: The interrupt that occurs when Rx exits the LPI state
          const: eth_lpi
        - description: The interrupt that occurs when HW safety error triggered
          const: sfty
        - description: Per channel receive completion interrupt
          pattern: '^rx-queue-[0-7]$'
        - description: Per channel transmit completion interrupt
          pattern: '^tx-queue-[0-7]$'
        - description: PPS interrupt
          pattern: '^ptp-pps-[0-3]$'


BR.
/Jan


