Return-Path: <netdev+bounces-272177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL6iLAJxxWkU+QQAu9opvQ
	(envelope-from <netdev+bounces-272177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:46:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A96C33966B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8F093018D54
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162BF35DA44;
	Thu, 26 Mar 2026 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pi6DLka2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8D33D51D;
	Thu, 26 Mar 2026 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547062; cv=none; b=bwZ7oz/LSluJVc2GbqPJMVB3R1zzSn+OXFZlYPP2hNz7JkgvTby9Lb6oNMAcwBK0578GjyqfNAzjMx8ZnbF9JdlRxedt19hKs4Jo7TSeMtxa7yIzHJlFGjm8+juXc7reEoj+IND/3TANH+8WLpJrtNbcxk8fWC/t9YV4Mc08d8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547062; c=relaxed/simple;
	bh=/k1OR+GuB2NBGGAdF22Aa+NrR/gPZHefh3IaY2VS4MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nneXmqglPubuwRTaiaTjygCEqPcBJ2MpAEfrGpjtc/dHJG4j3gLCokhkay/uQ7r1t20/XLtop3nmQuIsvPMHRtzrC4G6eXcrjvi9Tfrp/yUdKgXl59JMi7CCJQls8r7e/sh88ArRrCPYa/c+9fSOlgxICi5fw05fkE9r0PjvaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pi6DLka2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1f6J7MFQ+d3Eprch19nvBJN8SwLx9u4Mt/IcSuHYlLw=; b=pi6DLka26kwbyiEEB6f0eCDWa3
	6+fgpsgwMuo2hHTi7NjvwYDaE28XI06phkkv6LoAdpoSVu1wGEcuB/B2b7dpbcYLy2qO3OttXzjME
	q+sWCBOkrWZI5i1fnQy3cpbCjLda4+i3eZ6IiV3X05HIlDpxyUeWguchdj38m/DUEhKv8zxzFow9s
	sp1alZgomfd1xRGP5gl+s3xYElOko2K4JVrtIVmaeaZCC14vQraGxxQJ7JfhW59B3Embg/9SrBZY1
	1eqDdmQtKX/3gTk9kqWNxl9W1o9VgVPvZXphGHKZx6FCpLvYvQEMQGxpgkjVyThlTnKUNR+Dd8q69
	E4vR7l0A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51818)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5okW-00000000574-3f1q;
	Thu, 26 Mar 2026 17:44:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w5okT-000000007ER-3JGz;
	Thu, 26 Mar 2026 17:44:01 +0000
Date: Thu, 26 Mar 2026 17:44:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kevin-kw.huang@airoha.com,
	macpaul.lin@mediatek.com, matthias.bgg@gmail.com,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: phy: Introduce Airoha AN8801/R
 Gigabit Ethernet PHY driver
Message-ID: <acVwYUKxIkKUEUJZ@shell.armlinux.org.uk>
References: <20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
 <20260326-add-airoha-an8801-support-v2-4-1a42d6b6050f@collabora.com>
 <acVND6DdpM9czIwU@shell.armlinux.org.uk>
 <044110c5-da1e-48c0-93fd-35553e86b271@lunn.ch>
 <acVQQQiciPQBkQOG@shell.armlinux.org.uk>
 <425217fd-f74c-455c-9aa7-5b6682d887fa@lunn.ch>
 <385d2137-0d15-4dc0-8994-9cd48e4150b4@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385d2137-0d15-4dc0-8994-9cd48e4150b4@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-272177-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,collabora.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,airoha.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	NEURAL_HAM(-0.00)[-0.963];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A96C33966B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 06:25:20PM +0100, Maxime Chevallier wrote:
> On 26/03/2026 17:56, Andrew Lunn wrote:
> >> What is the timing requirements for a system going into suspend vs a WoL
> >> packet being sent? Should a WoL packet abort entry into suspend? If yes,
> >> then we need to program the MAC before the PHY is suspended, because
> >> suspend could already be in progress.
> > 
> > We would then need to hook into the NETDEV_CHANGEADDR notifier, and
> > call into the PHY driver to let it reprogram the MAC address.
> 
> We would also probably have to re-do that MAC addr programming at phy
> attach time ? If the PHY isn't attached (e.g. link admin-down on some
> boards), we can't use that notifier as we don't know what netdev to
> listen to. Or I'm missing something ?

Another point to consider in this area:

Should a detached PHY remain with WoL enabled?

If e.g. the network driver is unbound from its device, which certainly
disconnects the PHY from the network interface, should that PHY still
be able to wake up the system when there is no way to configure,
check its status, or handle its interrupts?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

