Return-Path: <netdev+bounces-280907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGz1LnjH6mlhDgAAu9opvQ
	(envelope-from <netdev+bounces-280907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:29:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F953458BB2
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 132F3300C5BB
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29D5243956;
	Fri, 24 Apr 2026 01:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b="iZE1Y5+7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E5191;
	Fri, 24 Apr 2026 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994158; cv=none; b=PqRT330CgnM1EwrBsVnj8Qj4fxM0L36N9ERk6Vv/19glFkME8CuQpW8QHngUrRG6JV/UapUGRdjVZzMtS7zjSj12YPOLOXwgI9GKycslOpZg6OfO6pgTzO9kiOSXzpfrcvVwHr/4RlBPqXJQ26nqZH/dnFpLt9ShdEaUrQIQNkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994158; c=relaxed/simple;
	bh=bnJguPtwmXOuffyM1PpjdiFxgRQ142HPq/SPox5OEZY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9zokDQntzwB6EmzOuVh+ijq1pddFXuv2hqvzMl1K99M/90nNDqaTCw8PcU+qXJMDNKmrKR/cRq7b2CvD4HfyNBEr3P2sMDJ79XgfOGK1Vdd0lnFsENUPheyTvmKcW1lkinY80bySn9ZO+rXOj5z/ic+wFWYfw6DNAOZLRK3joo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info; spf=pass smtp.mailfrom=leavitt.info; dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b=iZE1Y5+7; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leavitt.info
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leavitt.info;
	s=protonmail2; t=1776994150; x=1777253350;
	bh=bnJguPtwmXOuffyM1PpjdiFxgRQ142HPq/SPox5OEZY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iZE1Y5+7Nh1WMn23xX5ccicJdsRDssOxliNiid1LZJk2nihgp1D3FcRA5B3IcrU/2
	 FLekvWukbo6wXe+n0E6efwFwTg9+pWljbtZt2mcD7+qmRfhPoUPMUAqqfwpEX/1JgH
	 nt0buz+z0jPO8F2z4nGowy6HHBMddQi+1raCrJWNDl/JLqpbR0f5gVeUiA8j+Sn3bO
	 H08ZqlBHrElPmc9rnqIWdncX3js8Kn2Mu3uaTikCTgLGJtk5eGLeikk57zB2wD2Cw2
	 h7auSqpS3k/KLBIOLwbhzQPVA0C1LgJoIf2SxNNzMTm2FYZkPhmmZ/DpI+6FmaJhnB
	 ubIlZtuJgzYUw==
Date: Fri, 24 Apr 2026 01:28:58 +0000
To: Jonas Gorski <jonas.gorski@gmail.com>
From: Corey Leavitt <corey@leavitt.info>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller lookup from MDIO probe
Message-ID: <177699413027.883911.15023948003450400155@leavitt.info>
In-Reply-To: <c346ac78-3e33-4062-a459-b83d845dc2eb@gmail.com>
References: <20260423-pse-notifier-decouple-v1-0-7d4856f686f6@leavitt.info> <177693362253.84762.6848519898058872632@leavitt.info> <c346ac78-3e33-4062-a459-b83d845dc2eb@gmail.com>
Feedback-ID: 22087991:user:proton
X-Pm-Message-ID: 937c3192439e169ec053f26b48210c50b93281eb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0F953458BB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[leavitt.info,quarantine];
	R_DKIM_ALLOW(-0.20)[leavitt.info:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280907-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@leavitt.info,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[leavitt.info:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Apologies, bad wording in that quick apology. v2 will be a fresh
thread with a Link: trailer to v1, per the docs you linked. Thanks
for flagging it.

Best regards,
Corey


