Return-Path: <netdev+bounces-275879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLlDFWix1GnvwQcAu9opvQ
	(envelope-from <netdev+bounces-275879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:25:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1F93AABDE
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C2B73008D2E
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 07:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B958392819;
	Tue,  7 Apr 2026 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Vmn9Ozo5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B28175A83;
	Tue,  7 Apr 2026 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546725; cv=none; b=gmlN3yzBwvz34GUhCeXEpQBP78CdRiRoQ/nz2e30lEMBsyeLCN7OqcWUnbTTOMTaK4I2gkOsF92vWyR1jYRuwpS03s6FdpgHAiusBo2Zb3EC2MhKHX0AGhvtxphT0J7AbZc1Mqsm9Qvcice/pPzOA/Z74M5vP6iOv+kFnRwQz3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546725; c=relaxed/simple;
	bh=3opjvFYBgL1qeuyF5RExKJkNtN6TTTnSXpwSLVcsDV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnX9ohghpQfOFMOAAcLScqb52IfTzHz1Ggqv+1oXdF8lZktf++bjPw7DUEcv8A8Daq28M77kAW6n3kt9WYLcliYsSeL9Upc6u6zqQBeqx1oc6nD/9w09wz+f8dEmi9KzbXlUx4CtIGIS0QPamK8BaJluFZJxsNooJ94F/XwLlcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Vmn9Ozo5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Xfd4Ai8X1jiYT9iJrd3H7okMbF4OcPxA5a49UaGG3Bw=; b=Vmn9Ozo5QiEKRbYD/7LSGVZBeD
	SEgRx4FA/5P7govPIx4DVNioi2ragtO1PZ4zk2yS4RthLlcFsuOtAyDzr/nXA+7JQBZKyfyt9Mxuh
	AeyGAyJVF9sKFpPiPTkqn8oNBU4itqHyK55vu/Utlm3JdnjcepTre+4P/DWZTOzSQC82s1jiZrTtt
	xeItoEZYjRqlBCad0STVVtMkoIV3KOyoX74RVbuWf/uqPIgFpwv3/vqCUHWhe4u/XLRfffY5VsI8c
	kVO1BAgZyWBfS4tPO/s3rd2gjuuRJWH0jltg+g3LP/zM5U2dt2xEf5sNob+TKDN/JOppHYtp3qOYO
	sLLNgKNQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51304)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wA0o4-000000000YZ-2Nm1;
	Tue, 07 Apr 2026 08:25:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wA0nr-0000000024m-08Up;
	Tue, 07 Apr 2026 08:24:51 +0100
Date: Tue, 7 Apr 2026 08:24:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	me@ziyao.cc, siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com, wens@kernel.org,
	vladimir.oltean@nxp.com, lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com, maxime.chevallier@bootlin.com,
	chenchuangyu@xiaomi.com, yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com, chenhuacai@kernel.org,
	florian.fainelli@broadcom.com, quic_abchauha@quicinc.com
Subject: Re: [PATCH net-next v9 0/4] net: stmmac: Add PCI driver support for
 BCM8958x
Message-ID: <adSxQpAE0nY0ulfU@shell.armlinux.org.uk>
References: <20260402213629.1996133-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402213629.1996133-1-jitendra.vegiraju@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275879-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.462];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 9D1F93AABDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 02:36:25PM -0700, Jitendra Vegiraju wrote:
> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> 
> This patchset adds basic PCI ethernet device driver support for Broadcom
> BCM8958x Automotive Ethernet switch SoC devices.
> 
> This SoC device has PCIe ethernet MAC attached to an integrated ethernet
> switch using XGMII interface. The PCIe ethernet controller is presented to
> the Linux host as PCI network device.
> Management of integrated ethernet switch on this SoC is not handled via
> the PCIe interface.
> 
> The following block diagram gives an overview of the application.
>              +=================================+
>              |       Host CPU/Linux            |
>              +=================================+
>                         || PCIe
>                         ||
>         +==========================================+
>         |           +--------------+               |
>         |           | PCIE Endpoint|               |
>         |           | Ethernet     |               |
>         |           | Controller   |               |
>         |           |   DMA        |               |
>         |           +--------------+               |
>         |           |   MAC        |   BCM8958X    |
>         |           +--------------+   SoC         |
>         |               || XGMII                   |
>         |               ||                         |
>         |           +--------------+               |
>         |           | Ethernet     |               |
>         |           | switch       |               |
>         |           +--------------+               |
>         |             || || || ||                  |
>         +==========================================+
>                       || || || || More external interfaces
> 
> The MAC block on BCM8958x is based on Synopsis XGMAC 4.00a core. This
> MAC IP introduces new DMA architecture called Hyper-DMA for virtualization
> scalability.
> 
> Driver functionality specific to new MAC (DW25GMAC) is implemented in
> new file dw25gmac.c.

Sorry for suggesting this rather late, but I recently came across
another stmmac driver in the kernel - drivers/net/ethernet/synopsys.
This is for XLGMAC, but I wonder whether it may be a better bet for
this core. Have you looked at it?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

