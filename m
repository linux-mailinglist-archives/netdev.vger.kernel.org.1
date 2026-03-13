Return-Path: <netdev+bounces-267637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OjVNH6XtGluqwAAu9opvQ
	(envelope-from <netdev+bounces-267637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:02:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD5F28A92E
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2579131931BC
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902A0387572;
	Fri, 13 Mar 2026 23:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="veeipGsj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847AA38756E;
	Fri, 13 Mar 2026 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773442905; cv=none; b=kNa1L/EKh/qXl4hk/73D05SVzdsM9yXpBOS4CSCbR0lFIzhVWEARsf9QHDS8KqKSo4l3a3qSNjbVYrBHBCExHFTopqHZtHyr98k7nDswqf0mORWdGMjWY0cbfVjQLrlHTCf6RD6sE8gT6jxP2o4yyG9n3V5tHRVnrz2ecUzF5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773442905; c=relaxed/simple;
	bh=Cv25KOBNiALz6d9VfnKlw+KbVur5w0PQtR/sSTyT2vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzHNDtsGNZ8e4bYZqu5VQ+CK+cQ0firyhWJdmZoVdntWonk9ok890xKJk3QMa7lugPEMxG66lNFf6FKiTrNIeLLdZP2zYncWxXo6QDd8usaSLCeAgxgF90hhhaqjGTzzAGAnRja/VtfCkuMOg5pUqntShKibLjYnHpPbGqOV4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=veeipGsj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9olc9FEMIPBTpzCEvFssSp2raytyU4R431IhWwd+KXk=; b=veeipGsjcHjrrKyYCG8wldOYrj
	q1y+pb/krI5uUkJrOb3dQr/Z9cW5CYxF22iriL9I6hQEK5wYsPnZ/GZAs91Ns0hDROPlWzZL010d7
	C28mEDCcmUYekCMXSna37l/Zm1HlSfw81pJ0pk01GGGsQHTVRi4vR63Xtg1TpIzWkOaPjtaYJ6yAW
	MFnkD/tcYTKrpwk8mi/e+pZx9q0fjbXqfbnZRwjV+hlKWAkklQUpI36/EaGx7yFzZq+f2Ww+V2UQ2
	vvS5Bc+yGDoFjdeU1ALdgFL4rD2eW8igCpmMFvgqzJDq1Sq+xvQ39xG0JAZwAMUVGlkb2v7M3jDHs
	uzopc42A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57004)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w1BVb-000000001aJ-24ij;
	Fri, 13 Mar 2026 23:01:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w1BVP-000000000Ar-3IxC;
	Fri, 13 Mar 2026 23:01:19 +0000
Date: Fri, 13 Mar 2026 23:01:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "\\Jitendra Vegiraju" <jitendra.vegiraju@broadcom.com>
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
	matthew.gerlach@altera.com, chenchuangyu@xiaomi.com,
	yangtiezhu@loongson.cn, ovidiu.panait.rb@renesas.com,
	chenhuacai@kernel.org, florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: Re: [PATCH net-next v7 4/5] net: stmmac: Add PCI driver support for
 BCM8958x
Message-ID: <abSXP3gMFQEiC5Lm@shell.armlinux.org.uk>
References: <20260313222206.778760-1-jitendra.vegiraju@broadcom.com>
 <20260313222206.778760-5-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313222206.778760-5-jitendra.vegiraju@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267637-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 3FD5F28A92E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 03:22:05PM -0700, \Jitendra Vegiraju wrote:
> +	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> +	if (!plat)
> +		return -ENOMEM;
> +
> +	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg),
> +				     GFP_KERNEL);
> +	if (!plat->dma_cfg)
> +		return -ENOMEM;

Please use stmmac_plat_dat_alloc() - this will allocate and initialise
struct plat_stmmacenet_data, and as of commit 7a6387dec8ce in net-next,
will also avoid the need to allocate  dma_cfg.

> +
> +	plat->suspend		= stmmac_pci_plat_suspend;
> +	plat->resume		= brcm_pci_resume;
> +	plat->bsp_priv = brcm_priv;

Populating suspend/resume means that plat->init and plat->exit
will only be called on driver probe (former), probe failure (latter)
or remove (latter). Please consider using these to ensure that
all appropriate resources are properly cleaned up in all cases.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

