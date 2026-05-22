Return-Path: <netdev+bounces-290889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF5dF4mQEGqIZgYAu9opvQ
	(envelope-from <netdev+bounces-290889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:21:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B619A5B8186
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ECAA300F111
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D088D3C3BF4;
	Fri, 22 May 2026 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQLgQ0Cg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84C43E9F95;
	Fri, 22 May 2026 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470112; cv=none; b=a/BIRrJv5RaWbxjpx+DtFihgDbjRX4eSJiuXXP6FafM5mg65Aki8FWUdD5j75wNyXw7bO3N15xnLXWA7h6HOTAa2gCTZHpnvS71naq8z9jXJzzRLPl7orX9+Fscls2fN0TXQHybITrpt7jrG3cO7HbGpfRlOnKjDO+9oi1BJZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470112; c=relaxed/simple;
	bh=Yi8C41VGIzdyMgjZbpboMCI+lM5lM3wsQGVIjjmxGjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9+/+It4BBi6pWle86eTp/V3nXP7wW7M5dxgjOb/JjH0pcC4n0fLuL98KR3Z3e+v2wxt4xhegIajkOQpnzdFJH14OkPXY8kO3fEsjWfQg+OQboaMfZafz+uZul5J0OHhjO262k3bSxw2TebXNc3jrQ9rackLr18wVLtWCLJEYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQLgQ0Cg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBF01F000E9;
	Fri, 22 May 2026 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470111;
	bh=Dy6gRNw42PA2lEo0ZqXUP3bHsN/ECYp6NFsykWD4f1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aQLgQ0Cg5x2qgzOGApAqU0EPDCzVdmPUKFbHq7jYVGP4jlyWKCucc+3YbKuVPo8Ok
	 pC+nnJlQipXxYvgyz8jvWXFaTzqsCxMrMxGrq7u95ToAdnUZ0a+fKPcn1KX4v8pPsF
	 QXbzGVgcqAmmZAIa8VcRDiwu/C54Hy2V3RksDMYDDp/DYQvbMbcjn2Jh9iiu/A2fiO
	 MA8Bv5wQY0Q9+YHeXTfDcL7kQR874NHPfo8wXemLrMsh7PE6WXDWT/uiQD4SfMg9y5
	 wDyalIvdIur5vAXVBQzB0wBOYsNlhQSvEQoCXxzdAtkCqEf703E+MubjMi50Rbvloc
	 PNcz+f3vLDiNg==
Date: Fri, 22 May 2026 10:15:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fidelio Lawson <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Marek Vasut <marex@denx.de>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Simon Horman <horms@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Tristram Ha <Tristram.Ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: Re: [PATCH v6 0/3] ksz87xx: add support for low-loss cable
 equalizer errata
Message-ID: <20260522101510.4cdf3c4d@kernel.org>
In-Reply-To: <20260520-ksz87xx_errata_low_loss_connections-v6-0-43f33d4aaf0f@exotec.com>
References: <20260520-ksz87xx_errata_low_loss_connections-v6-0-43f33d4aaf0f@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290889-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,denx.de,bootlin.com,kernel.org,armlinux.org.uk,vger.kernel.org,exotec.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[17];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B619A5B8186
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 10:48:55 +0200 Fidelio Lawson wrote:
> This series is based on Linux v7.0-rc1.

That's an old kernel, the series does not apply.
Please rebase on net-next/main and put "PATCH net-next v7" as the
subject tag.
-- 
pw-bot: cr

