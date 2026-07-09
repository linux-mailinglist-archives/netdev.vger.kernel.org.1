Return-Path: <netdev+bounces-306312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N1jsCe/LT2r3oQIAu9opvQ
	(envelope-from <netdev+bounces-306312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 18:27:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA3973372B
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 18:27:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="GX/PFe17";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306312-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306312-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED7CB3004C68
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA3842A14E;
	Thu,  9 Jul 2026 16:23:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E04343FA
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 16:23:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614192; cv=none; b=bNoMOPp7BRksI8YmamednCOHGybCHUWjQUh2HkWjbE537ACoZZFNHrBzWH4e50npR5zvzWGxOaAIaMAZPIGtCoo4ANGBdzdMkAilsq6zRyd6rzk7e/R2fO1BOhI6y1gxvKIP4efiwDUqVC5gGoPnw1LFA32rlvYE1a5uowXdoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614192; c=relaxed/simple;
	bh=AO1uuYrOhsHTQYNgP/lQBuUFWvrW5PwbhmtC6sGMJbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+c/II8k4PzYrBWTcA17AZPsMQI4b1e1PSoGVpm7TagD2vdjx+c4m150u+Qur1Le578Y4z2Kr7eAAl4rjcyRH3xZa66cu9e5yS2KcKxIoYb8anxCze+pYRcIFSvuj884DCeV1ygMYd7k7Fqa20L+JYpPt9izi+bT7O1pwXN5F/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX/PFe17; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED6B1F000E9;
	Thu,  9 Jul 2026 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783614185;
	bh=xY8F16dOVGVz/HPOHeaPOgh5zFeAeHxadmKlUSBpORM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GX/PFe17eJ6JOxK0t8hkX4Wtk2KqMkbigvXkRxAvvQa7oBFnwfaOYZM9WrZ8AmhoU
	 kZN+TkFYtBBWUthuwN2qBxxtjcW8VGeDyUYDp3p+lgnHE/Jf6U5sAuZPwHazq+YqIA
	 r296KRh9Nk9ac519CtcIUq/AaKjaJuAsmuCQixkSJJh806f6C3sHf8NPsBLx0E9vtg
	 ooCZr2W1q07Z7UJEC+VP4h5XKYx1ilPVVh5KeUcD43m2VAa1Jxxc09g0neLzRrtbgN
	 Az1eATCam5wSD5cbc+TaYI/hCkUuLromifKM2tjMdgvymguc2LPm77B8wMlubbLM88
	 JkdwlSNn2FLLQ==
Date: Thu, 9 Jul 2026 17:23:01 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: add preliminary support to
 configure tx hw QoS queue during flowtable offloading
Message-ID: <20260709162301.GS1364329@horms.kernel.org>
References: <20260703-airoha-hw-qos-queue-stub-v1-1-ef253ffdd093@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-airoha-hw-qos-queue-stub-v1-1-ef253ffdd093@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306312-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CA3973372B

On Fri, Jul 03, 2026 at 01:02:17PM +0200, Lorenzo Bianconi wrote:
> Add the plumbing to program the AIROHA_FOE_QID field in the PPE FOE
> entry with a per-flow priority value during flowtable offload. This
> allows the hardware to steer offloaded flows to a specific QoS queue
> on the egress QDMA block for traffic forwarded between two interfaces
> via hardware acceleration, bypassing the kernel forwarding path.
> The priority parameter is currently always zero because netfilter does
> not yet provide a mechanism to pass the skb priority field to the
> flowtable offload driver. Once that support is added in the netfilter
> subsystem, the driver will be able to extract the priority from the
> flow rule and map it to the appropriate hardware queue.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


