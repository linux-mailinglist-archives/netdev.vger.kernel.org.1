Return-Path: <netdev+bounces-257956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOZKHTTwiWn4EQAAu9opvQ
	(envelope-from <netdev+bounces-257956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 15:33:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E06EB1106E3
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 15:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60AA4303322F
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C213B37AA6B;
	Mon,  9 Feb 2026 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="havwzuU+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465623B604;
	Mon,  9 Feb 2026 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647499; cv=none; b=jJB8EFlQ92fHB16CZvHNZ+Pv5QKSqR6SELjR7NT5zo4YFu8m9SeqBALC1/p5jxtlx+Aq56dHuj9L9xDK1bgMHBmcL7ZnCOSWqB4mi4zrxQEYrs9YJVnMiqd1dnUyy2Dn+/hP9bex6dMs01iKxdj4aQ1zoxup7+K2vNVdVYznMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647499; c=relaxed/simple;
	bh=KE57ewbW0FR7LSnDlenP3CMFpinYcXvtn8GTV2oScKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOi1bGNoiNlpiPdvOEIEbYQ1G9jhHcTmOYdrS8TVLObFJzmnvl2I69EB103wJGWfdtNUZemxN6ZeOULcTsfPbCrH4TK931Ut0PUJPrQRgPkQ+03sr4lrWU7BS04stKExwJTmU09vt8QrC2/tU6Db2ZhcH1T146ney8OkVAD2DL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=havwzuU+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3FEHIqnlVQGDIeCCVkCWIEHhxVvsQXBX8o/GwIQwb+4=; b=havwzuU+gFRpmOt8zaZ9DARYnV
	qy+xhoaKLehLHlMADlWczRDlSsf7jrhBbO1SPWGhu3+pDdk3741dtNzTThCMY2jcLebZir0mi4QtU
	NF8pVx6ssEXisYtJqflNSrr8x1UO0cER/QR+yIvCQuSLBUQcr8Vc3Fjt9D33zDUHXwL5mqFoC4eE4
	9WtuI3L4g9N0b3yhrlRohc7aURcYMHVz8mdvGN+E0bXxN5U8nOIMuk9V+owKOF7AeUE7dSsitZWiY
	AhGuNdKhSyHUdJUBzR9jLRDN81Vk+HqhMecuWXiDccE5UAY4ZbMlbmZtkskMvQ4MW66qkBzKWY1Wr
	8rN4vv4w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41268)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vpSIX-000000001eG-13e5;
	Mon, 09 Feb 2026 14:31:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vpSIS-000000001qf-1VCk;
	Mon, 09 Feb 2026 14:31:28 +0000
Date: Mon, 9 Feb 2026 14:31:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: lizhi2@eswincomputing.com, Andrew Lunn <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: [PATCH v2 0/2] net: stmmac: eic7700: fix EIC7700 eth1 RX
 sampling timing
Message-ID: <aYnvwAK3gpxBs-EF@shell.armlinux.org.uk>
References: <20260209094628.886-1-lizhi2@eswincomputing.com>
 <64bf6b40-b947-4ffa-8d48-4d6341931327@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64bf6b40-b947-4ffa-8d48-4d6341931327@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257956-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:url,eswincomputing.com:email]
X-Rspamd-Queue-Id: E06EB1106E3
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 02:36:11PM +0100, Andrew Lunn wrote:
> On Mon, Feb 09, 2026 at 05:46:28PM +0800, lizhi2@eswincomputing.com wrote:
> > From: Zhi Li <lizhi2@eswincomputing.com>
> > 
> > v1 -> v2:
> 
> For version 3, please include a patch to the SoC .dtsi file adding the
> Ethernet nodes. We like to see users of code being added.

In addition to Andrew's comments, before posting another series, please
review https://docs.kernel.org/process/maintainer-netdev.html,
particularly sections 1.4 and 1.6.1.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

