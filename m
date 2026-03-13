Return-Path: <netdev+bounces-267355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKJHGb7Zs2mzbgAAu9opvQ
	(envelope-from <netdev+bounces-267355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:32:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBD02808C0
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3017300E2AB
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AC8336895;
	Fri, 13 Mar 2026 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KXkh2Yw3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D3336EE7;
	Fri, 13 Mar 2026 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394360; cv=none; b=rTDukgrUW/PZ4S/tAP3SLtl2wx2H9JJQdjlZE6um5rxmLiu0NWnN/IXguyF4VdZvRtA4WW3LYYxGw9oK+pKb4FVUKpoTFFol47Ii7DlUOhKrpyIexXca624G2zqfLSf/d6dkVYHc/yDfgYDDqFO++hh8akMM7a08CZO01w2tyGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394360; c=relaxed/simple;
	bh=vL6usZZMjF3Kj4743w1ZZ9CrFn6N8IuNz7N0YyKmijc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYEI0OjOE8OAai9pfcTk4VS+JoEyU/xP6oSmRZ3j7ydqf2+39p+4Mr1uZNf7LRmeeSQ3spIElWu1Clg1AQq8laf2yQpJG+SuRuyrDH8af00+/sAP8vkOjXcTgHSxawJUHYXbkXusbF7vJxyBYv4jZmKYs8HP3QxOicixK08zJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KXkh2Yw3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A6oGlsV387MSkeGlfgdCPnuYQ1UUU9UaeP1u0pOYQpk=; b=KXkh2Yw3uuUce4xfJqcyDT6oXr
	NRROy1CK1FouZHjjYNBKR2TFjMoRAZ2pWKnrY+1cq9s/8a+FY9Nft+WGiMUC8FWoaHV/2x5ubEhYH
	XaU/j2ue9XT2gar4kfcuZzK397RG7LTkvzV+2bkjezPlGbaFkd3pRlXRthrAg2M+A6mi7PAlniBiv
	vVVabrRHlZRVtvPeJY5k7iYghXxYTi0jmWjOEGsP0rW3hbOLvqNmcX+0rnaJ8YdjfBcYIIYGKXGVH
	WB3ZOeLd4KmXSxr7a+/NyvLj12mwLVSr+P4XCVeMiTYKvAYg3/+BwoMe2FI3QdJyQGGBmYt/S/b0o
	I2ghAwcg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54034)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w0ysa-000000000Zx-4BKS;
	Fri, 13 Mar 2026 09:32:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w0ysY-0000000086W-3QeX;
	Fri, 13 Mar 2026 09:32:22 +0000
Date: Fri, 13 Mar 2026 09:32:22 +0000
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
Subject: Re: [PATCH net-next v12 4/4] stmmac: s32: enable support for
 Multi-IRQ mode
Message-ID: <abPZpiCsirNzvqJt@shell.armlinux.org.uk>
References: <20260313-dwmac_multi_irq-v12-0-b5c9d0aa13d6@oss.nxp.com>
 <20260313-dwmac_multi_irq-v12-4-b5c9d0aa13d6@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-dwmac_multi_irq-v12-4-b5c9d0aa13d6@oss.nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267355-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,altera.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[s32g399aevb3:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,shell.armlinux.org.uk:mid,suse.com:email,armlinux.org.uk:email,armlinux.org.uk:url,nxp.com:email,4033c000:email]
X-Rspamd-Queue-Id: 0BBD02808C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 08:13:35AM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> Based on previous changes in platform driver, the vendor
> glue driver can enable Multi-IRQ mode, if needed.
> 
> To get enabled Multi-IRQ mode for dwmac-s32, the driver checks:
> 
>   1) property of 'snps,mtl-xx-config' subnode
>      defines 'snps,xx-queues-to-use' bigger then one, ie:
> 
>      ethernet@4033c000 {
>          compatible = "nxp,s32g2-dwmac";
>          ...
>          snps,mtl-rx-config = <&mtl_rx_setup>;
>          ...
> 
>          mtl_rx_setup: rx-queues-config {
>              snps,rx-queues-to-use = <2>;
>          };
> 
>   2) queue based IRQs are set, ie:
> 
>      ethernet@4033c000 {
>          compatible = "nxp,s32g2-dwmac";
>          ...
>          interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
>                       /* CHN 0: tx, rx */
>                       <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
>                       <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
>                       /* CHN 1: tx, rx */
>                       <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
>                       <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
>          interrupt-names = "macirq",
>                            "tx-queue-0", "rx-queue-0",
>                            "tx-queue-1", "rx-queue-1";
> 
> If those prerequisites are met, the driver switches to Multi-IRQ mode,
> using per-queue IRQs for rx/tx data pathr:
> 
> [    1.387045] s32-dwmac 4033c000.ethernet: Multi-IRQ mode (per queue IRQs) selected
> 
> Now the driver owns all queues IRQs:
> 
> root@s32g399aevb3:~# grep eth /proc/interrupts
>  29:    0    0    0    0    0    0    0    0    GICv3  89 Level   eth0:mac
>  30:    0    0    0    0    0    0    0    0    GICv3  91 Level   eth0:rx-0
>  31:    0    0    0    0    0    0    0    0    GICv3  93 Level   eth0:rx-1
>  32:    0    0    0    0    0    0    0    0    GICv3  95 Level   eth0:rx-2
>  33:    0    0    0    0    0    0    0    0    GICv3  97 Level   eth0:rx-3
>  34:    0    0    0    0    0    0    0    0    GICv3  99 Level   eth0:rx-4
>  35:    0    0    0    0    0    0    0    0    GICv3  90 Level   eth0:tx-0
>  36:    0    0    0    0    0    0    0    0    GICv3  92 Level   eth0:tx-1
>  37:    0    0    0    0    0    0    0    0    GICv3  94 Level   eth0:tx-2
>  38:    0    0    0    0    0    0    0    0    GICv3  96 Level   eth0:tx-3
>  39:    0    0    0    0    0    0    0    0    GICv3  98 Level   eth0:tx-4
> 
> Otherwise, if one of the prerequisite don't met, the driver
> continue with MAC IRQ mode:
> 
> [    1.387045] s32-dwmac 4033c000.ethernet: MAC IRQ mode selected
> 
> And only MAC IRQ will be attached:
> 
> root@s32g399aevb3:~# grep eth /proc/interrupts
>  29:    0    0    0    0    0    0    0    0    GICv3  89 Level   eth0:mac
> 
> What represents the original MAC IRQ mode and is fully backward
> compatible.
> 
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

