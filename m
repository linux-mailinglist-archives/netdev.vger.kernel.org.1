Return-Path: <netdev+bounces-300929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +eHHHwVmOGqjbwcAu9opvQ
	(envelope-from <netdev+bounces-300929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:30:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 102FF6ABC09
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:30:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fjWNB0uA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300929-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300929-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 475A03001FDE
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504EC1E5B63;
	Sun, 21 Jun 2026 22:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED023E342
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 22:30:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782081027; cv=none; b=OI5oIvcnnhe3ZNNygaZGKhoeSprfcPdIB80M7Gt3S5Dj5W5I5jPBPlErMzeBErVmJ+rGcJOdUS8x5uKiZQ/VygmaTmxRUs373X406WUA+FvO1tppVrvP/xC1Dasru7rEqbej4ppQl+pfGBFFgOjsaLVB79zy29noE3wL5lTS93I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782081027; c=relaxed/simple;
	bh=qCDGKIoqzLScUVpuyIoLxRdIIFh0UbX4cxDtbnM2Kr4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QkcBanUbpapIlRUBK5ao7w0KcAffM353X7uX5vChUAXxxQmS2vXDT24t5VdJVDGnSkFvxR0bB49zqpVFaU56OHmipBfjKgD2LWB/2dgCB7HqgXetdDXjUpihC/SrV4pOOVzM7K2jWlz7Znx6FpcIJp0XS+4SlYXJaFju0NlmJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjWNB0uA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1CE1F000E9;
	Sun, 21 Jun 2026 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782081025;
	bh=ZLQOieHTnD0bFMjSEJR58HBcYMocmNdGYbI0EkujA6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fjWNB0uAYQU1qHJCMxuR1Lg7ObAtmw0k+h+k7cHLoBy14qPPb3mzQvnIAvk7MZlFk
	 RGDfp2G5pzaWuL7UhHgKS0f0mvgIB6wYNNyNewiGB2B25MsuYtMcS/K9AgIRq161/e
	 o9K+kYeKBT/fCEIkeThfQe5OVl6VbjPHYrjq1sLUVEQBEQtu6TaBtuzdX35V537Mfr
	 s9/E9rJNs25IVG2MC89BlPHaWsZDg2/m+ibLGjOuuk0iogGALu0diOLjMt+2i2gLxf
	 ktSksBkiA9baCJHt4NQJE3z0zZYWSbgU5P08gxVgSUG7ivB6d0tJaQNEV1FeQmcgBl
	 4J0R+bbR+6enw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A943AAA6ED;
	Sun, 21 Jun 2026 22:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] ipv4/ipv6: account for fraggap on paged
 allocation paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178208101700.524849.5372754030819859653.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:30:17 +0000
References: <ajFQn6yh43eDeQm9@DESKTOP-19IMU7U.localdomain>
In-Reply-To: <ajFQn6yh43eDeQm9@DESKTOP-19IMU7U.localdomain>
To: Wongi Lee <qw3rtyp0@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, asml.silence@gmail.com, dhowells@redhat.com,
 willemb@google.com, jwlee2217@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300929-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:qw3rtyp0@gmail.com,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:asml.silence@gmail.com,m:dhowells@redhat.com,m:willemb@google.com,m:jwlee2217@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 102FF6ABC09

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 22:33:19 +0900 you wrote:
> Fix fraggap accounting in the paged-allocation paths of IPv4 and IPv6.
> 
> The IPv6 patch is the v4 update of the previously posted patch. The IPv4
> patch handles the same code pattern (by Ido).
> 
> v3->v4
> - Remove the MSG_SPLICE_PAGES exception from the IPv6 negative copy check.
> - Clarify where the fraggap bytes are copied in the commit messages.
> - Add Reviewed-by tags.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] ipv4: account for fraggap on the paged allocation path
    https://git.kernel.org/netdev/net/c/eca856950f7c
  - [net,v4,2/2] ipv6: account for fraggap on the paged allocation path
    https://git.kernel.org/netdev/net/c/736b380e28d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



