Return-Path: <netdev+bounces-272156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM5RH4RmxWkn+AQAu9opvQ
	(envelope-from <netdev+bounces-272156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:01:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B745338D7C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F3C93036771
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB24B41C2F6;
	Thu, 26 Mar 2026 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="G2WMZZx/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33037755C;
	Thu, 26 Mar 2026 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544256; cv=none; b=iK6Gulff19yJZqkY5GxhJ+DK4qrMGM5myjOrZk8uaXRZ/sVuaa4kEZcOh53E+uu+3l43qxtniyDCWz0kZVTdzg9fEDDuWK/eanhwEKJc9axjaIs50eesIjbzvkfvBzqHciMvBD+ecDVsVrtW8tVNxur3rtYjy+EeZe5Fry4pCnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544256; c=relaxed/simple;
	bh=z5rFa6R8fXUGh3pBmIq7oP+HPfgBAdXXW+cCZfXMdhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpSoQmmeJEnO11fFft1QJBtln6TFKrdar3nXF5wRCuU+PfjdrnUhvG8lkq3UTz/y0fPDaFr+lbGrCEFPEOsUChPMWi3+BWbWuLdJmD5al48zEhjtdkB0dEda/bcvgL6qkm9TE9ZyBtkeOLFKAnC8vcpUAcqGtG1zMhTVChNtizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=G2WMZZx/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KmvK6l6GR25t9qXtIc4Zl0uKnAxLfL7ooqqIuDZI0MQ=; b=G2WMZZx/afVPnbXfQ2N8lyZ9YF
	BhZthNAwe9edPi2vZsUdwTXOZ1kFiGN58RPZ1wnKq3n2+5MrmN4hP/Qm9XaVn8vUa8MraTzIqyq4y
	13f2TuJcCa3lN66QPs2lcFh5NOXFEQXkUn7RyCUAlTfaYHptxA2xDaJTMKf+yD0o7L7n8QrHM5qlv
	Bl67OWxt/qV9NAYAhlMXIabkxsH7bI+W55o8fX1u5p8I27zIOTvJ+PVlHMvfWlWMtwjrSmOccUmmn
	jBUFawXjTRFMR7ilCW4Xuq6I6fXLtc/qFI8qwJswWXbrh/bTByqCv65lp8PGbpwY5D7ty86bPS+7E
	bYoA+TUg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55976)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5o1T-0000000053X-25Pg;
	Thu, 26 Mar 2026 16:57:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w5o1Q-000000007CI-1WTp;
	Thu, 26 Mar 2026 16:57:28 +0000
Date: Thu, 26 Mar 2026 16:57:28 +0000
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
Subject: Re: [PATCH net-next v8 5/6] Fix error handling in probe function.
Message-ID: <acVleH7_kh7kAAZR@shell.armlinux.org.uk>
References: <20260320211921.1202058-1-jitendra.vegiraju@broadcom.com>
 <20260320211921.1202058-6-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320211921.1202058-6-jitendra.vegiraju@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-272156-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 2B745338D7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 02:19:20PM -0700, Jitendra Vegiraju wrote:
> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> 
> Software node created in probe function is not being cleaned up if
> the probe function returns an error.
> The stmmac core provides mechanism to handle this error condition
> with plat->init, plat->exit helper functions.
> Move glue driver's initialization code to plat->init function.
> If the probe function returns an error, plat->exit function is
> called. Handle any glue driver level cleanup in the plat->exit
> handler.
> Use devm_add_action_or_reset() to register a callback to free
> irq vectors automatically, simplifying error handling in probe().
> 
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

Oh, you did fix it. Please merge this into patch 4, there is no need
to have this fix seperate.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

