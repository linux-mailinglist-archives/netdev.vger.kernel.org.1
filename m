Return-Path: <netdev+bounces-264801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Cw9DcvZqmkZXwEAu9opvQ
	(envelope-from <netdev+bounces-264801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:42:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB20221F68
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D59D13014910
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 13:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34DC29D265;
	Fri,  6 Mar 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="syuwf17O"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786C42D978A
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803942; cv=none; b=dwbQKBfSRl6THlIm9EjNi67Ba1u5UfD7eBigGP7n3caxobCStSdd0w7Oxz5kGY/Kr2YV3jrApktq1caTxRHK5W7xFXCxf/7fpJGvL5kCploLE3vTneIDJCVGhlPeX9svyRfbJhc+4U+myf/mouxkxzfsvN5I69KRCUMvBV+sE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803942; c=relaxed/simple;
	bh=O2EdVReohsVktiZ9IisdOizANkbEVPstJd5vArlYlW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHHIzS+wivitJQlIXxChg/I+gRib6nuk/4C0ZPUbyBoAkEG7ixk0doClujliVnPVInhAnJm7lSc1cyorzYdi/172pNnzv+oAYWJFVl9GRrMeeJXl/r9Fb7z8E3l/sF/eexRvHqzF3/i/bYMJ1cddwlvfUPEgTWLACrDkMy6gSbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=syuwf17O; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3AE001A2D49;
	Fri,  6 Mar 2026 13:32:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 05F5E5FF92;
	Fri,  6 Mar 2026 13:32:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 78C9E1036994E;
	Fri,  6 Mar 2026 14:32:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772803939; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=MtGSXQd1rJ7F7WpffOYtsvHkK2yZmux9XID3eldxZIU=;
	b=syuwf17OBQRSlsgCUAuuSAuSoqGuBwfoHBbK9g4Bh9AQzCvKCyDFKN8bmPdlRnKdOk2aA5
	VB87AhBHBpX2LO5ODAZrlnihKEnT6E4qGUIBbmgJG+GU9TaDwiiVp4DXTEFjl1l3ZNBkmB
	DWbv/EG5B41lrbD3F8ZQpXF9BKZEDeD1S7Kz/AgXstteX1JnGIygade+ftEaVahkmKSFMs
	SjnnmLlvC93omtAOC+oJX7rh0eLn65jRgr8dw5WmzANFwfDlriHcxzeNK4eOdNFrqDYGmR
	VWfJdHlegT6ZvN1nCIzgcsemxAf3jSE5a2s9VVh8cop3kGZpKDlGdzWtPxlSJw==
Message-ID: <065b3dc0-b092-45c5-b7ea-e0a54264558e@bootlin.com>
Date: Fri, 6 Mar 2026 14:32:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/8] net: stmmac: make pcs_mask and phy_mask
 u32
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Samuel Holland <samuel@sholland.org>
References: <aald--qJquWGIvmO@shell.armlinux.org.uk>
 <E1vy6AY-0000000BtxJ-3smT@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vy6AY-0000000BtxJ-3smT@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 2FB20221F68
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264801-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,armlinux.org.uk:email,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action

Hi,

On 05/03/2026 11:43, Russell King (Oracle) wrote:
> The PCS and PHY masks are passed to the mdio bus layer as phy_mask
> to prevent bus addresses between 0 and 31 inclusive being scanned,
> and this is declared as u32. Also declare these as u32 in stmmac
> for type consistency.
> 
> Since this is a u32, use BIT_U32() rather than BIT() to generate
> values for these fields.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

