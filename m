Return-Path: <netdev+bounces-255308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGcWEdJdfWnKRgIAu9opvQ
	(envelope-from <netdev+bounces-255308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:41:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9446DC00EA
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19A1230490ED
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1C332A3E1;
	Sat, 31 Jan 2026 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMZjV7MQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18823329C79
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823626; cv=none; b=LQzFpT4QUabA3/0udh2y5zgn5Ck4nZIEhXg0GesDSoIuFBjebSKJr1A+I84pdFZakSUc9eXSvyX7sp2lDNvIBWe2yK8ltODPNsY3HGPXdRnnyWaAsveaGZaS4sowambkFT1+a1WUeNPyk/OZJLADWXbz19nQQljmysHQ/Sorp20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823626; c=relaxed/simple;
	bh=WHqnnttw31r1+0wtHzMFRqw7NjiRbKPYneALZD8B4ls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ny0jGfrIeT4BaMw42veJE5FcKjZXFxnVipT5oHf7qGlVREiDvFsnM59nTLADV8OrBVb0jTE3tVWLmdXTpU0/JsZSI2izE0Um0x/fvOQVlUEfGFAeJ9eKbVwncbiEVwvJVeaZm0ICQE40mH5jGCIZ6Qx4iRxn9PZ88g7a+BuIBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMZjV7MQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C15C116C6;
	Sat, 31 Jan 2026 01:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769823625;
	bh=WHqnnttw31r1+0wtHzMFRqw7NjiRbKPYneALZD8B4ls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uMZjV7MQkKx/ELXFk+rdrZeo264XixNdqLSIQAvZL8gCosGElsEe/mve3Dp4aGmLP
	 7NCumRayjGfZGcr2hGlCX6d8rvSZXZbfbmVDKiLvxmARHgkBJCSmqOKnMDMltz6kuk
	 MKwZuFn5Hp7VeNUDQF2ax3CBIZvZCQXiuc5fqIJcliOW7ZOXPx+DRQx3S3hnTZygJr
	 HQ9/hdnOyi5PH/CB0NFN8lSbeI4zWHd45Z6CEx5FUpvoHptoiaxURVu1nfrR1+JcaW
	 WQRXs3gRzrvaDPZjaVhmwP/S2B18xfc/DanMPakMzTiVuYXXSAe/+DuyxQyAKgJwwD
	 6aDpXTTw2iYHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11964380CFFB;
	Sat, 31 Jan 2026 01:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: reduce tcp sockets size by one cache line
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176982361785.3959411.148911131468285979.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 01:40:17 +0000
References: <20260129153458.4163797-1-edumazet@google.com>
In-Reply-To: <20260129153458.4163797-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-255308-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9446DC00EA
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Jan 2026 15:34:58 +0000 you wrote:
> By default, when a kmem_cache is created with SLAB_TYPESAFE_BY_RCU,
> slub has to use extra storage for the freelist pointer after each
> object, because slub assumes that any bit in the object
> can be used by RCU readers.
> 
> Because proto_register() is also using SLAB_HWCACHE_ALIGN,
> this forces slub to use one extra cache line per object.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: reduce tcp sockets size by one cache line
    https://git.kernel.org/netdev/net-next/c/ed9b70040d7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



