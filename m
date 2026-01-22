Return-Path: <netdev+bounces-252369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FbWHNkscmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:57:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD223679C1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACD915CA9E5
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223E32FB0BA;
	Thu, 22 Jan 2026 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jd9ggf1Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7643F2C2ABF
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089244; cv=none; b=ay3UUw6AC6cXBXI41KxgfKZKBW5mv7ejFXfisdc6WLDq6ur9sj79/M1maZ/56V901yX12ZXydJLeuG4Go3ag9C/DiODH2NB0hyoxtKx0oRuWvPCftKPFgXq5ndnDxWM89r9SUfJ8QqTb+5frlUfHu5WWm7zZ8d4v9CPPkqwWhx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089244; c=relaxed/simple;
	bh=+N8vlVz7gCuuwaHD555r9aNtIiSNzV9UoHiW5v7HWJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqByrYTO6aI1GDBx+1MPdB1fprSOPslBSnV6wMUjg7wlNDFiXpryRzTE9CbdK8f0nJFHMOEGYsJl0+7Uv3btCIJwfsR95DnP4+6LWhlQzd8fvtwyil5tY7nwm+ze4gtSH+fUlDypQUKYWLH11vUk/fRyN2FXpg0f2cA2IUA0iRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jd9ggf1Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OnMj5HNqoTADQizVwe8s0WY4aTvQ1xfAEqyvRSU+VyA=; b=jd9ggf1QQ97+yv6M30mhepGoUF
	RN1rN+CN6hGRWZpnsu8yzbIft5UOItoD3b+Y2aMba2+mqxP772tHRl3U88tG5SdgTRViw539hr4DK
	ySdRYeUyjNLuezXPN+QgQ6cU+OWDQyk0fhlzLkmJfQvCwzIE3cVaTwYsxx1950EMz1R4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viuvJ-003yey-Rv; Thu, 22 Jan 2026 14:40:33 +0100
Date: Thu, 22 Jan 2026 14:40:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Simon Horman <horms@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [net-next,v2,09/15] net: ftgmac100: Always register the MDIO bus
 when it exists
Message-ID: <a441d449-7130-4543-bb43-84e3ae6ab2a5@lunn.ch>
References: <20260116-ftgmac-cleanup-v2-9-81f41f01f2a8@aspeedtech.com>
 <20260120121407.795529-1-horms@kernel.org>
 <8ab0e121-5ffb-4dd8-afc8-11b6ce3898bb@lunn.ch>
 <SEYPR06MB513455F4FBCB9AF4F6E4CB199D97A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB513455F4FBCB9AF4F6E4CB199D97A@SEYPR06MB5134.apcprd06.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[lunn.ch,none];
	TAGGED_FROM(0.00)[bounces-252369-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: CD223679C1
X-Rspamd-Action: no action

> I've been thinking about this part. One possible approach is to switch to
> devm_mdiobus_alloc() and devm_of_mdiobus_register() instead of
> mdiobus_alloc() and of_mdiobus_register().

If i remember correctly, a later patch does that. Which is why this AI
bot points out the problem goes away later in the series.

I was trying to keep the patches simple, do one thing, be obviously
correct. Moving the code and changing to devm_* at the same time is
not "do one thing".

If it is possible to fix the issue by just moving the call to destroy
earlier in the error path, i would do that. That is the logical fix to
this patch. We then have the setup and the cleanup in symmetry.

   Andrew

