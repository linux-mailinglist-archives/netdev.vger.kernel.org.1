Return-Path: <netdev+bounces-304031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LMT5GUciRmoQKgsAu9opvQ
	(envelope-from <netdev+bounces-304031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:33:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4CA6F4CFC
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:33:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jLHzQyWq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304031-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304031-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92323303DC92
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C158426421;
	Thu,  2 Jul 2026 08:20:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984D92C21E8;
	Thu,  2 Jul 2026 08:20:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980448; cv=none; b=mra1ZCNEWFUlhqxlFUmqCfBAg8azvSvHa6Al8qvU8v5TSyCmWPe0s9w7F8nnwny3RzH/mzpjmPQm8T0evfXhVx1+8BW54TqsUoD7NwOAttTXnUOGnhK3BBhG9z4lxGEHhKJUTs1r/SkvZYcp71TerSw4TVV7aGXmkBjEzAiuO1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980448; c=relaxed/simple;
	bh=yDvw98/8GopwCa56MQDQl3AokEFX4GmszEqJtDBNyGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BydZhczKcL9s5U8R6UAJHeymPtQph+F8cn01Bau3lxtN+lO7byXV0CYa39ExN9KjCTFFEKluL+UljyFUuQZImO5CtN/aeecEsv49SQdP/4IK0nId2lnoRnopfqnKN4nDCadQGnaRk6G32sQJTHP4BMuOxCoPLTXU4uzcHLMswSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLHzQyWq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588F51F000E9;
	Thu,  2 Jul 2026 08:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782980447;
	bh=Tr9cXC0OCwfJzYHZUk1OPi/rA+dVy0Z7JJiTxU+68ok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jLHzQyWqKPybHSvUztisKZbEsvRDJp6AEZPGC0Rr5TvNANY+LRsWTfrSoDye31QYN
	 v8eF9GtOa9YX+qmyrn/IUJFcNngdfs5sZZjG/CDSvtHLfE/fkZvsvmzeVtYlE4csUK
	 PRxIOd0M9e3IxbeyZlkwab7LjLeBvsavnVOD4dUWnqEhkCGE2dwyUSgxBkthGClH3O
	 rLkhyQYMVLAwZ7WzWjYd6aKRICr1Ce+cbk8ZokYg7NdfZhNGPKbncPu7XUGGCEudTM
	 RWy3+uZaObeepovRLNMPc5gVA57byEJ8L80jRfvzzmYYmpDtelFGAR1fz8JuZEG0yu
	 bioo2HmcfyFRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B283926655;
	Thu,  2 Jul 2026 08:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phylink: Drop references to the .validate()
 method in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298043013.1512795.2607486084440200164.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 08:20:30 +0000
References: <20260630083700.2041915-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260630083700.2041915-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com];
	TAGGED_FROM(0.00)[bounces-304031-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE4CA6F4CFC

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 10:37:00 +0200 you wrote:
> The phylink_mac_ops '.validate()' has been removed in:
> 
> commit da5f6b80ad64 ("net: phylink: remove .validate() method")
> 
> There are still a few comments around in phylink that references that,
> related to the ports fields as well as the Pause configuration. Let's
> drop these references and update the comments related to Pause handling.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phylink: Drop references to the .validate() method in comments
    https://git.kernel.org/netdev/net-next/c/7693eadcbb8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



