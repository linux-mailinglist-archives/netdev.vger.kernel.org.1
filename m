Return-Path: <netdev+bounces-270960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPFKNchfwmmecAQAu9opvQ
	(envelope-from <netdev+bounces-270960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:56:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0A1305FF6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41D2E30783B3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32B53DEAC2;
	Tue, 24 Mar 2026 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WdBMv7lO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DCF3DEAF9;
	Tue, 24 Mar 2026 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345745; cv=none; b=QTo4tvmCJ8eS0bguWRf6RFPaqmbb1m0Ixw0C0gY6LPu9hbfad83aNu6QtqvOvQCjKDbw0G/cUZvLLluPIrB2+OKUlSIcO2guDOweOvYm6FRFh4yVKUlQ+dHA6/551FcTnuvlHEpJef/75X3tQmqUMw0mgxjz2/Pcng4QUR3bcyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345745; c=relaxed/simple;
	bh=fSuJNN8Jugp9CK3fRYqZPfUa5q7LcX1UmdnU72npshE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW2C9LuUuFHFF6MgGOyRtar3SJN0RoEFsEhRgBTl2Muzj1BTuk7ECQ8ED1ib9QHLPxByCAMAB3g4mk48gz251KSBqeUkDVDkfyjLlfSVrBzWFeAyNphFXmVnpp+pqAlTq+3DnwP03GZIZwyMoPLT9zOqNBE7I4GMirCGiLnnwQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WdBMv7lO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O3zSGBMOP8SLkvjNah7bxtlePOkK0bAZhrbaj4sgYC0=; b=WdBMv7lOsX71X7cUozgMFqvRlJ
	DHuyWR1HAIB7+KhaI0Yeg5lREb6TcGa0VmTBcumcYtoEufxf/LjCR6dPA1i/sPgh6F+d+58qIPxnP
	0HRnoRDi/9HiBCzYlnUl3Bzi6m9qPbvHPQwKss/btlVQfCnJggD51pS7XJArB+X0AKIBX0HgKCoYW
	eqGgsBn0Nr6lPXHbIpHlgJAPyIWxTxjzwbk3FbckBB4J01cqOPC2/cUtcfZsEYI3z2F2vAbN4aZLx
	wgJlCcpfWUmgBxOp95WyJLgaxY6cc843MuQC6A+c2Mqn+P7aESeRBgHSBg0Vut9nbj/8F57QwuPk7
	wzoeiVAQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56490)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w4yNZ-000000001hO-22Vr;
	Tue, 24 Mar 2026 09:48:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w4yNX-000000004xr-3Knl;
	Tue, 24 Mar 2026 09:48:51 +0000
Date: Tue, 24 Mar 2026 09:48:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	thomas.petazzoni@bootlin.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Rohan G Thomas <rohan.g.thomas@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 2/5] net: stmmac: dwmac-socfpga: Use the
 socfpga_sgmii_config() helper
Message-ID: <acJeA6c2M4eSrxC4@shell.armlinux.org.uk>
References: <20260324092102.687082-1-maxime.chevallier@bootlin.com>
 <20260324092102.687082-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324092102.687082-3-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270960-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,bootlin.com,altera.com,vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:email,armlinux.org.uk:url,bootlin.com:email,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 4F0A1305FF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 10:20:57AM +0100, Maxime Chevallier wrote:
> Use the existing socfpga_sgmii_config() helper in
> socfpga_dwmac_fix_mac_speed(), instead of re-coding the register access.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

