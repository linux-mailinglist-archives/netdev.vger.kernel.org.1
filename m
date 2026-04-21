Return-Path: <netdev+bounces-280077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOj3IRBa52l87AEAu9opvQ
	(envelope-from <netdev+bounces-280077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:05:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFC7439E59
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A45DB3051AA4
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5283BD634;
	Tue, 21 Apr 2026 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUo6GVgM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AFD3B19AE
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776769265; cv=none; b=ZFD1mauYIXKIZrcKpiB4Fqh2GavfPDj9X6mnnbtk+AMb4pHklx0wRE/0/u2b4UEQ4zt+nim31txzfUqLjWN1vnhgYseyrIsqg+juGq8szjS6s6VjZ+vvZUjiZzh9FhYAhqCSJI8ySItRZcDfG+i34V6aLpSybnuheJqwZkYmxPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776769265; c=relaxed/simple;
	bh=0YHq2IRUIFJ991UpWKePkfXthpOIncAUNvmGi6w+0Y0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RLe2aXIjxt1a6a/2C+DxHDFdggXG4CJRLuraLDQQfAxUlmzb3NlUqPruC9sQkn1K+82lTdNWuX+0C1Cf10Ted8/nZEtHlHnVw6e/7mOifTCpwcOYC6LEylANUzneK1dkyhPDoLpQbjMmh9qF7UAPUhEMNlLOKRm5KtjikGakCbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUo6GVgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4622AC2BCB0;
	Tue, 21 Apr 2026 11:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776769265;
	bh=0YHq2IRUIFJ991UpWKePkfXthpOIncAUNvmGi6w+0Y0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EUo6GVgMNzGLrCGqXzNZpzKXm9vfNOjsuARSbK3uVDrya1heRfDjJIw5DZzZIADlq
	 YZoriFzijSvB8zqJnPJwJbAZcr7GfBnsEIEHxtnc1lotUXqNABAT8yP3OCv9r6HgpU
	 yIladX+qygdGAIPBLSDLsdUw73WF9WUIUsMdzxofJ2IG+m+Ag7MPyRZNC8D4QTze2q
	 nzDl3vj3+ChLglgA4j/QHlG4ZrhtPAO7M5k8rfoYEmGjp078GvOyJmE10lGeBrK/2o
	 jLCqT0qTb8nZRWKe3cLRFEFSDhF/I6L+VZpUXsQ/HbWs/R9jajyIMwy+1CnONCfCJy
	 XgDBRj+t+DFcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDD63930192;
	Tue, 21 Apr 2026 11:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v8 00/15] net: sleepable ndo_set_rx_mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177676922879.2351021.18340708312396220142.git-patchwork-notify@kernel.org>
Date: Tue, 21 Apr 2026 11:00:28 +0000
References: <20260416185712.2155425-1-sdf@fomichev.me>
In-Reply-To: <20260416185712.2155425-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-280077-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECFC7439E59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 16 Apr 2026 11:56:57 -0700 you wrote:
> This series adds a new ndo_set_rx_mode_async callback that enables
> drivers to handle address list updates in a sleepable context. The
> current ndo_set_rx_mode is called under the netif_addr_lock spinlock
> with BHs disabled, which prevents drivers from sleeping. This is
> problematic for ops-locked drivers that need to sleep.
> 
> The approach:
> 1. Add snapshot/reconcile infrastructure for address lists
> 2. Introduce dev_rx_mode_work that takes snapshots under the lock,
>    drops the lock, calls the driver, then reconciles changes back
> 3. Move promiscuity handling into the scheduled work as well
> 4. Convert existing ops-locked drivers to ndo_set_rx_mode_async
> 5. Add a warning for ops-locked drivers still using ndo_set_rx_mode
> 6. Add a selftest exercising the team+bridge+macvlan topology that
>    triggers the addr_lock -> ops_lock ordering issue
> 
> [...]

Here is the summary with links:
  - [net,v8,01/15] net: add address list snapshot and reconciliation infrastructure
    https://git.kernel.org/netdev/net/c/db9e726525e4
  - [net,v8,02/15] net: introduce ndo_set_rx_mode_async and netdev_rx_mode_work
    https://git.kernel.org/netdev/net/c/3554b4345d85
  - [net,v8,03/15] net: cache snapshot entries for ndo_set_rx_mode_async
    https://git.kernel.org/netdev/net/c/a4c833278144
  - [net,v8,04/15] net: move promiscuity handling into netdev_rx_mode_work
    https://git.kernel.org/netdev/net/c/7ef83bf1712b
  - [net,v8,05/15] fbnic: convert to ndo_set_rx_mode_async
    https://git.kernel.org/netdev/net/c/60dd9781e9b8
  - [net,v8,06/15] mlx5: convert to ndo_set_rx_mode_async
    https://git.kernel.org/netdev/net/c/5cf06fbdaf02
  - [net,v8,07/15] bnxt: convert to ndo_set_rx_mode_async
    https://git.kernel.org/netdev/net/c/f6c53cfa1217
  - [net,v8,08/15] bnxt: use snapshot in bnxt_cfg_rx_mode
    https://git.kernel.org/netdev/net/c/a453b5d9b3ed
  - [net,v8,09/15] iavf: convert to ndo_set_rx_mode_async
    https://git.kernel.org/netdev/net/c/d071c15b43e9
  - [net,v8,10/15] netdevsim: convert to ndo_set_rx_mode_async
    https://git.kernel.org/netdev/net/c/8a5df09e70c2
  - [net,v8,11/15] dummy: convert to ndo_set_rx_mode_async
    https://git.kernel.org/netdev/net/c/4d157e89bde4
  - [net,v8,12/15] netkit: convert to ndo_set_rx_mode_async
    https://git.kernel.org/netdev/net/c/754b7e1169a7
  - [net,v8,13/15] net: warn ops-locked drivers still using ndo_set_rx_mode
    https://git.kernel.org/netdev/net/c/3cbd22938877
  - [net,v8,14/15] selftests: net: add team_bridge_macvlan rx_mode test
    https://git.kernel.org/netdev/net/c/ee514cdb07b3
  - [net,v8,15/15] selftests: net: use ip commands instead of teamd in team rx_mode test
    https://git.kernel.org/netdev/net/c/c4dde411bc36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



