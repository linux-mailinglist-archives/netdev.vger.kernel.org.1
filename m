Return-Path: <netdev+bounces-267775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fDT9I8aRtWmY2AAAu9opvQ
	(envelope-from <netdev+bounces-267775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:50:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E15B928DF79
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 850E4302E907
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF15E30FC39;
	Sat, 14 Mar 2026 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJfrU3wz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F22F83A0
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507011; cv=none; b=a6juoFt+RjweVA4VPVwSx6lZhF3FdMoQeKiSarbHCHtZR+m3sA2pNZ1s+sOPXZKkb8ectevHZf10RGh/XsRrezH39/r8u8JzDkt7H0s8n2kjgLzG5C0oxO4TnD9WXG+q+Ishdr1zbAAgzz0LkDIKMQ7MNo/MiRPcFcRnqwLF/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507011; c=relaxed/simple;
	bh=vfXPWwDhZY3mDv+Pgl8XaWAwTWG3oVTHdh8OMrdRdUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mALme/QfdOx/mWahWQQlguTtaOsNWXDjPdXCsCqDtFIYz/DqLR96b6yMRSX3T2Gf4Y9S8zg1jnLHiOHJSE1x4G17MNQuc82pdZySPKMEINgwp9s9ScNyZpkAGqdYnchybAZxUhV0byu6geUAQOzJju2rtfoCQoW3Efoe7QBW7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJfrU3wz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E72AC116C6;
	Sat, 14 Mar 2026 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773507011;
	bh=vfXPWwDhZY3mDv+Pgl8XaWAwTWG3oVTHdh8OMrdRdUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tJfrU3wzZxsNYknlvf9a66bE4Ow4810x7DiePB19gMw5apBGAdR8YSJI9x9yJQyT/
	 VeKpdgD+FahqzdXzJ1jQEojwcTeA5ZFoV/EE8P0m08USOZf/xoVqCinOIBH9FQNEd5
	 RuOLr6aJXRk0mYFHU8bHlQNMYi9wkmFX2RxeMf8kMmqZzI8dVzuCsju8f6vJrDL6zG
	 TaeEsKzf28yao6rUYSz5kYu19ccqPoc1GJe0ZmNkg4DYYlRpo0GSmU5kM3kD684R2V
	 ZFq3nnloPDqTGcumEEstrNZyRiyzUewQ+vWRilRsRLXY7RmSpCDrRrnIQTRcMrDvXY
	 th2ywgx5iM3oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0523808200;
	Sat, 14 Mar 2026 16:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bcmgenet: increase WoL poll timeout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177350700538.1730865.6600612507507836878.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 16:50:05 +0000
References: <20260312191852.3904571-1-justin.chen@broadcom.com>
In-Reply-To: <20260312191852.3904571-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-267775-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E15B928DF79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Mar 2026 12:18:52 -0700 you wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> Some systems require more than 5ms to get into WoL mode. Increase the
> timeout value to 50ms.
> 
> Fixes: c51de7f3976b ("net: bcmgenet: add Wake-on-LAN support code")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net] net: bcmgenet: increase WoL poll timeout
    https://git.kernel.org/netdev/net/c/6cfc3bc02b97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



