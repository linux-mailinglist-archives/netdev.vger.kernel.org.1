Return-Path: <netdev+bounces-286069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCrUOnOO/mkiswAAu9opvQ
	(envelope-from <netdev+bounces-286069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:31:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5384FD4C2
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4780430297B3
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 01:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5A227F017;
	Sat,  9 May 2026 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeX+V58i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A753627AC31;
	Sat,  9 May 2026 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290259; cv=none; b=q9jvuvMKnPCNRZRcFUssOHD5FG1QbXz9hR3CZueAeZSkBJbJfk90e7usfitPAjJoY5wb255veVtIWPIwleHFXcUwb3/YB4B+kNCLwG3kwBlWVqErfwPGaYz9EmkKagpYce00AJq87zJ1DnGKNA3mj4Jv421NCckUAP8PJoXeMcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290259; c=relaxed/simple;
	bh=8VtEfOq4+3Bu5H/tOFNf85i6LoitYdZqgbNIwepkvBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u7yaJK1CkRrqSBMi8PZ5t0qsuKEAYHgw2xceINxXMqWmV3NZhGQ3Da9E0avHCrY39Wwe4O4TmE6teRL+9OB7iNs75FwjYQzbtm7NEzKmUbC2BVF9Fj2ctK8vRe5ku04NL7U+XD7/MmHftNir9jxea2Ufe/1zs4XRW8kysAlWQeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeX+V58i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FDBC2BCB0;
	Sat,  9 May 2026 01:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778290259;
	bh=8VtEfOq4+3Bu5H/tOFNf85i6LoitYdZqgbNIwepkvBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SeX+V58iSa605oQODWnG2AYPykzxP+8Y9Uf07NJ/ZBhUzOVlZHrb1myLf+eJnejsx
	 vPdqpCaVyp4FCx0ZDh364iYWq4iRUxY/SrgOgzX9cIc353lRVWIaPWRY8NcM6vv9yg
	 KouyY1eTEVaFKiJp5rYdjB++KLMZk13N2q5tx/ed4QTbkBoYeKXPBpdD/WzD1GBuVS
	 IWZXPgX745cte4XQNnott+XnuhlWfiskp/dLI2Pntj4PMT5uS2wU0AvHNjwqzmJcRa
	 8pFuNZFRMZp51HeLzJUVBwf6315Z4Ls+xVSkfHhNL8t51PN3sLj/E76C5zD85oukBS
	 oMn7uTq2uFdew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC238119E4;
	Sat,  9 May 2026 01:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ti: icssm-prueth: fix eth_ports_node leak in
 probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177829020754.925974.10822695616677362142.git-patchwork-notify@kernel.org>
Date: Sat, 09 May 2026 01:30:07 +0000
References: <20260506195813.641610-1-shitalkumar.gandhi@cambiumnetworks.com>
In-Reply-To: <20260506195813.641610-1-shitalkumar.gandhi@cambiumnetworks.com>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: danishanwar@ti.com, parvathi@couthit.com, rogerq@kernel.org,
 pmohan@couthit.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew@lunn.ch, horms@kernel.org,
 dan.carpenter@linaro.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 shitalkumar.gandhi@cambiumnetworks.com
X-Rspamd-Queue-Id: 6A5384FD4C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286069-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cambiumnetworks.com:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 May 2026 01:28:13 +0530 you wrote:
> The error path on of_property_read_u32() failure inside
> icssm_prueth_probe() returns without putting eth_ports_node,
> which was acquired before the for_each_child_of_node() loop.
> 
> Drop it before returning.
> 
> Fixes: 511f6c1ae093 ("net: ti: icssm-prueth: Adds ICSSM Ethernet driver")
> Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
> 
> [...]

Here is the summary with links:
  - [net] net: ti: icssm-prueth: fix eth_ports_node leak in probe
    https://git.kernel.org/netdev/net/c/6635fa84403c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



