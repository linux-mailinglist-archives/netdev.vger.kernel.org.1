Return-Path: <netdev+bounces-254785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M2dClBUe2nRDwIAu9opvQ
	(envelope-from <netdev+bounces-254785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:36:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 758E2B018B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6230A301CCD6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5613876D2;
	Thu, 29 Jan 2026 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Qg0oT4uR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFCA3803CD;
	Thu, 29 Jan 2026 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769690179; cv=none; b=mk+/ptCnpwiRKJWL1UXODoVRBIcTqzn664eUBaW8CyQ7VcAR5cJho9D3iFSN7asIQaYU4tEipTKHlM02y+QEc2nMUaXsqVFFaRouyv8c0O6wRvBq5J1QuRcuba7AIzoFVtuFuIP/BdKLOQsAmDL96Etj2a9LDI81dW0t35Sps6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769690179; c=relaxed/simple;
	bh=Y0Jxoq88PpNlF5UrRxPdlkMqFmuGOuYPU04czbyA3f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFFnJoMEVnWsm/kmRzDyv6dC3cZU+P/mLWQoE4+aK+OSDBmbQUTOBZkuCP1AGYsnIRdHgyTqxBSmf8jMxUQfJF4OyO/TpzJLdhWQmRPHYJkJHAJkfynMjSvPWKfhQHSlzUgK+oIOXYZuYveSGMr7gma/DUURsybm/0cr1/IorgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Qg0oT4uR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Kcs9CE9aIhIZ7Tc+WAZafu3mN0H9ikMUQFBt3Ov3La4=; b=Qg0oT4uR+AzUhHLOpoVDPUwiUF
	rCayhl2TB2274ELNl8kCGPWohMn5RRHXPUAezkvmluqO+7SPvez8201vG7qCdYeWbbn9vQm9UlxsN
	EardAUYn9naa+LrVm79NOHr1zfsaY0yJ6RQzVUrNSPelkdyIsfvUo45JWJs4lw6+GRoQC0MP72w66
	/1XHWUUXvFFe72vFHZ06QgkYPseC6KFDS7a1j4Q1wrxr2+3O9NCFGzJcOn106QvymNdjmkqV7+MF5
	Q5rDLtytOWHRUVI1x8PdT5PRojOiCiZN59vOVY2Xh/2g0UVTeEVqB9fIcIRAmqFLMcbDsGJNPV/FR
	ySqpNWKg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54900)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlRFo-000000008VW-3xXM;
	Thu, 29 Jan 2026 12:36:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlRFn-000000007y2-1Hr9;
	Thu, 29 Jan 2026 12:36:07 +0000
Date: Thu, 29 Jan 2026 12:36:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com,
	p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com,
	Ionut.Vicovan@nxp.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Frank.li@nxp.com
Subject: Re: [PATCH 0/4] Serdes: s32g: Add support for serdes subsystem
Message-ID: <aXtUNxEmxcvuNj6J@shell.armlinux.org.uk>
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126092159.815968-1-vincent.guittot@linaro.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254785-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[n:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url,nxp.com:email,aka.ms:url,outlook.com:url,xp.com:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 758E2B018B
X-Rspamd-Action: no action

Please drop these addresses from future patch series:

  alexandru-catalin.ionita@nxp.com
    host nxp-com.mail.protection.outlook.com [2a01:111:f403:ca09::7]
    SMTP error from remote mail server after RCPT TO:<alexandru-catalin.ionita@n
xp.com>:
    550 5.4.1 Recipient address rejected: Access denied. For more information se
e https://aka.ms/EXOSmtpErrors [AM4PEPF00027A62.eurprd04.prod.outlook.com 2026-0
1-29T12:31:01.197Z 08DE5971FB66165F]
  bogdan-gabriel.roman@nxp.com
    host nxp-com.mail.protection.outlook.com [2a01:111:f403:ca09::6]
    SMTP error from remote mail server after RCPT TO:<bogdan-gabriel.roman@nxp.c
om>:
    550 5.4.1 Recipient address rejected: Access denied. For more information se
e https://aka.ms/EXOSmtpErrors [AM3PEPF0000A798.eurprd04.prod.outlook.com 2026-0
1-29T12:31:00.781Z 08DE596525364766]

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

