Return-Path: <netdev+bounces-256394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDJXFUI1gmmVQgMAu9opvQ
	(envelope-from <netdev+bounces-256394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:49:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC742DD17A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46038300D25B
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FFB32693E;
	Tue,  3 Feb 2026 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="I2WFZhgW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED819326923;
	Tue,  3 Feb 2026 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140398; cv=none; b=H19+CtAUrkzHyCTSxnJ5XSr1u51cwh+9XUVAGwq3t3SZ+o6giee/4A5qKh2eJwbJJBHBE8/gpPMoFMdCTCbGeRWyCIrytdunMrB/PYv7ETufQOiY8J56SPcQNOJNg9p5QCPvK4o66BNQo2z+RF9ypeDUNA8zVMj2Qf5xtu506/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140398; c=relaxed/simple;
	bh=OGJrJo34Rcx70qgQDcJK+nre4kcK82kcTSaZzbKZBWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLytWONP4FVn8k4XVB8O2UUFN3K3L0+1PgZtsMmPqcxf3uIRyZs5qJkwQ5JurmIryC7RW0nXWRRgkj6Bs8NeYvi8zUhhqLRCMJ7qSvhGI4BXX6RDfOz9Y+XbHo/I3BaNv5wPqQ6iLDYpszja1jV2ZOsczbFLJJSCa7azp1WQj7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=I2WFZhgW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jITDbePUoWQSXJd93nDwRBiMM6E0IjTPypgzoLf0eeQ=; b=I2WFZhgWSO19lx31F/vaHdToWH
	N8HRXm0pzL3dqbMZKx5sRMO8YybZknWnCsaS7uWb+yMsiCYdYOhjv1Jobd2m6b6Qe48PiNLIcc3bJ
	C80tqN8h2R33waZfb758zC51RzDVILv2Ch11fKKOd3JuUneUO+vaIJkydbRsjlwvwbnjwubMcG05K
	M34ytIXFvU3e1S7cfo+Si+ziKdVz4uvS1jcVUHc2ZxDmmGC1hEhTkV6zmSWX22A++Krzh8IZc8k4V
	UG4AY4tGrk2/THDhUwnG/c0UqsbLsrQ2fS8JGiZGB3OqTaUxO78bilAQEFl/t/XUfPLwjy0Ryb844
	pFCDOPcQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42234)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vnKMw-000000005OS-08zy;
	Tue, 03 Feb 2026 17:39:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vnKMk-000000004Z7-3mB6;
	Tue, 03 Feb 2026 17:39:07 +0000
Date: Tue, 3 Feb 2026 17:39:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Yao Zi <ziyao@disroot.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>, Zhi Li <lizhi2@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: Add support for
 Spacemit K3 dwmac
Message-ID: <aYIyuulFADU_j3V0@shell.armlinux.org.uk>
References: <20260130022705.1059214-1-inochiama@gmail.com>
 <20260130022705.1059214-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130022705.1059214-2-inochiama@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256394-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,cqsoftware.com.cn,disroot.org,bp.renesas.com,eswincomputing.com,bootlin.com,altera.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,shell.armlinux.org.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC742DD17A
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 10:27:02AM +0800, Inochi Amaoto wrote:
> +  clocks:
> +    items:
> +      - description: GMAC main clock

If you know what this is in terms of dwmac databook clock terms, it
would be helpful to use it here. I suspect "application clock" would
probably summarise it, that being the clock for the bus interfaces
that dwmac provides to the host.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

