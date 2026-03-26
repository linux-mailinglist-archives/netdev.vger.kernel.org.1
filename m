Return-Path: <netdev+bounces-272188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P6QIwF5xWnw+QQAu9opvQ
	(envelope-from <netdev+bounces-272188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:20:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE376339FB3
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D93E310DD93
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FA134F275;
	Thu, 26 Mar 2026 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qgJYzpCR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7741351C04
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548613; cv=none; b=s00nFdJ7Nx72fdaGISnGQm7/PVRntXhpGD39Xd1U+E9norq1UfKXxOpDYPFnaogD/8dF32u/DlFAp6//VEuVrnzQfDkVDfnug8LWWYZAimSlC0m98G60xvogmbdwQHxJ5MDqUMrrw0AwSlKpcFBGFqoCiZlO/O3oQl5aJ72hcd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548613; c=relaxed/simple;
	bh=C31T0iB05TcG8+dBb0BQwUARXXYeyW/ypNNov2Ya5G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQmwQH470k1FKt5aEEuXZrZm/4zj9v9hUte0lW1w7VilmEGFnt9kVQpEnptcPRZXgGNGE9jeibPtJQ1QQ3FMpYPaRJCOIn6zneaHuZk1xPzKqZUySUjpsKoX+eKVyBYozCK7fYg/wmJMI+XSbc8a6BJVXdMDeHkiRvwtLZvdKlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qgJYzpCR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D7UKezHTYAPqledPGUEh2DO5MGs9hcwA+U9WoF1npkM=; b=qgJYzpCR7jCviujwEpZ0vv2vUF
	oxcFOACz5qSYZY/QQRwAwide7RZINgtbvEdKCebe7OUAUAo+e2poBx9eYb19KuV8uLhnUiVaLVELH
	QUAjK+E21l9asVws7NVaNBm75aKcthHu99WY9el+y++etD0SHfhZm3HN0+vQnPPTd8uB0LO9LZAUH
	giNrseuQbFoDjabUnZAiZNcYsep3qxXzKekLjeMLao49bqNPY7EDx65pAdw3u4Mv4SyHimrz4nbRa
	4bT1eDcMFca1gLonlXQEhCKThWwxDzGzxX5U8ptEQWHvMqDQh2/lZW/6cLK8VAevQJhXaXWjVPXDX
	7XvO9bhg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56258)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5p9h-0000000058m-3Fmw;
	Thu, 26 Mar 2026 18:10:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w5p9d-000000007Fh-3HE2;
	Thu, 26 Mar 2026 18:10:01 +0000
Date: Thu, 26 Mar 2026 18:10:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>, Jakub Kicinski <kuba@kernel.org>,
	Joy Zou <joy.zou@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v4 1/2] net: stmmac: provide flag to disable EEE
Message-ID: <acV2edMExFP0i8TK@shell.armlinux.org.uk>
References: <20260325210003.2752013-1-laurent.pinchart@ideasonboard.com>
 <20260325210003.2752013-2-laurent.pinchart@ideasonboard.com>
 <177454628933.1078312.13488207016388509694@ping.linuxembedded.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177454628933.1078312.13488207016388509694@ping.linuxembedded.co.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272188-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ideasonboard.com,lists.linux.dev,vger.kernel.org,lunn.ch,davemloft.net,google.com,gmail.com,toradex.com,nxp.com,kernel.org,pengutronix.de,redhat.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,shell.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE376339FB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 05:31:29PM +0000, Kieran Bingham wrote:
> This one has been a roller coaster, but I'm glad we got to the bottom of
> it.
> 
> I hope someone from synopsis takes note and and documents this for
> future silicon integrations.

I would say that it _is_ clearly documented in the databook. v3.74a
4.3.4. LPI Interrupt already states that this signal is generated in
the receive clock domain, and is not cleared immediately after the LPI
control and status register is read.

It goes on to state that this is because the signal to clear it has to
cross from the CSR clock domain to the receive clock domain to clear
the signal - and states that it is at least _four_ receive clock
cycles.


So, if the dwmac core is operating at 10Mbps, that means its receive
clock is running at 2.5MHz which has a period of 400ns. In this case,
the four receive clock cycles to clear this interrupt is 1.6us,
assuming that the receive clock is running.

However, if EEE is enabled, the receive clock comes from the PHY,
which may gate off when the link re-enters LPI - and this event is
under the control of the remote end, not the local end. So, what this
means is that even though it states four receive clocks to clear the
lpi_intr_o signal, that doesn't necessarily mean it will clear in
1.6us as the receive clock may be stopped.

So, I think it is clearly stated in the databook already, but as it's
just two paragraphs buried in around 1500 pages, that may explain why
it has been missed on iMX.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

