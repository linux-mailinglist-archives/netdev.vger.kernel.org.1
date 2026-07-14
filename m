Return-Path: <netdev+bounces-307397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7o7oFvH7VWqYxQAAu9opvQ
	(envelope-from <netdev+bounces-307397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:05:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96923752AA7
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:05:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=KSK9X1XL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307397-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307397-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11B12302590F
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A07A426ED3;
	Tue, 14 Jul 2026 09:04:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE943B487;
	Tue, 14 Jul 2026 09:04:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019892; cv=none; b=FJ8nzhTOgExQ7VxuGqMuxJ4StFdHPCY0dVTADnyEi2mny4BmmccPwJcDGRENKhrAvj7rYrF6EdA4Z/LorBJ7vlcy+7NkAHrir7QlZgudllaXXZxISyag2j8PWdJAHj8W+xKP2IRmkT0Vf+wcvu7Ew1raydv9B4U71/QZ1SO6WcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019892; c=relaxed/simple;
	bh=oRByiWfGruDdSgJtOt0rL3FUefdta81krT/kXEtgg/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SY7EWaC5K8YQhlOpBzkmwaPkMH/j1sQj9NwW5ASJypG17UYwHBoc2evxmpculgvbj7XuFllrkShhbW8X8+v/hW9v2raT19a+kr7QD/qudueYfqVIzqGcQWQpmEyygpNwq01pi+C1bRn7rgWlVxo8kfQv7ZGO1gxXrhV1z7rgndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KSK9X1XL; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EC5E81A0FC7;
	Tue, 14 Jul 2026 09:04:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A949C60346;
	Tue, 14 Jul 2026 09:04:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EA7811BD3B3D;
	Tue, 14 Jul 2026 11:04:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784019886; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cQlJfUIF2xj1GC2K3C4deNAjDGGPV5piEIHcT4ELsas=;
	b=KSK9X1XLWbs7gZKLmsCEdM20CoQn5wIxTDfWsCSPYgg+ywR2z3odgD9QJVIhv0IbuQDoWz
	eJGhbpZQUe0ySgmcqwi4TjwARa8LH5UYN0QJ5znP6Fm/gYWuh16SU9C0eCKlECL/x8J0d/
	n34wEyprkXAZ+DB000vxRqDb+2sA53yyhasF2h1lxZerQBChsa+RMHw4RfuSlr44dBCeLX
	p+7e6OB889D82LH5S53fQPZEpnV4MH4YLpiPCJ8KjyLUfu8ozKLPO5jjTIJp33wwLwyzIt
	WeYwRAtvOe2f4w9aIdjIS5lp6ng0FdSOJVfbMGxRf/LOCyXl1VM9VGKB+ftgBg==
Message-ID: <d6101afa-ca8f-468b-9dd6-f64eb94669e3@bootlin.com>
Date: Tue, 14 Jul 2026 11:04:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net: stmmac: xgmac: fix l4 filter port
 overwrite on register update
To: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org
References: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260714023716.29865-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260714023716.29865-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307397-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96923752AA7

Hello,

On 7/14/26 04:37, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> The XGMAC_L4_ADDR register holds both source and destination port
> match values. The current implementation overwrites the entire register
> when configuring either port, so setting one silently erases the other.
> 
> Fix this by reading the register first, then masking and updating only
> the relevant field before writing back.
> 
> Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


