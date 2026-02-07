Return-Path: <netdev+bounces-257721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHkYJfm9hmkzQgQAu9opvQ
	(envelope-from <netdev+bounces-257721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:22:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC2C104E42
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 854CF306464F
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 04:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98422F2604;
	Sat,  7 Feb 2026 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erZ7T1O9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E602EFD86;
	Sat,  7 Feb 2026 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770438030; cv=none; b=YxR6qZ0H2f/eeJNoZC+PgfnKCEz0rQoBsaAu5TAP6UgefvEJx4hhc0KdwhoUDN0K3CeK+dfO4B5D41v9g8AIYSdccjuV7ljl5jicNSUziACyGP90vBU9e7HNUbBriyz5ojAFQ/c1aqpsFNaYd5VmAJVQn80ahdLtZycaritzr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770438030; c=relaxed/simple;
	bh=CgSemdTlaL7gjSrZDPP3imnr4BRVFSp7+vIxGFA119Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DoFiY15a+QZaw9ek/nJs8fl8Nb3+ZxF4TMClm4adwuSAiSt87fcx22ezFQx0pssCKrg5XOxveym0o6KYhqN5TCHlGWhoo+RxW3IEGQDWg0igUQeA1ds6Rx3nUofyUCy20nT/CsBdmwjJx0uUMsAxlD0RqpUEQ+qpRHAaXkbwXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erZ7T1O9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4513BC4AF09;
	Sat,  7 Feb 2026 04:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770438030;
	bh=CgSemdTlaL7gjSrZDPP3imnr4BRVFSp7+vIxGFA119Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=erZ7T1O9B6bXhYoGpvrbG+kSE5ruyKLlCrmXvCVmiCGegcDf+DnbxtCLCLK6UwUGA
	 a8gUjR18Pdl8Fy7O1s0crE9RRjzQH/LZcuss+P0oQy30f1W9aW3078Z0b9DiTTL1lO
	 SIFwB/XiTaejW782RU9U7bD+GRtC3JtqQMUbl02oTIGTy5KKyQa91TpbxE+FpSLkge
	 FJxhPjvCXIyfqyHMMK7Q2X+hf1XC1p5gnTE3fqaXepj9E4EBdIuU4P8bYvo/eCSPsf
	 p2erKE3dPNNKzrLIpBCqDnOLIe44xzeC+z5UtdhYw45sBMwq4E6DU9SXcKjtYoZ2vA
	 9srsW89LFbRyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 851763809A1A;
	Sat,  7 Feb 2026 04:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [net-next] hinic3: select CONFIG_DIMLIB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177043802707.1183264.4135982751469258763.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 04:20:27 +0000
References: <20260205161530.1308504-1-arnd@kernel.org>
In-Reply-To: <20260205161530.1308504-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: gongfan1@huawei.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zhuyikai1@h-partners.com, arnd@arndb.de, guoxin09@huawei.com,
 gur.stavi@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257721-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AC2C104E42
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Feb 2026 17:13:48 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver started using dimlib but fails to select the corresponding
> symbol, which results in a link failure:
> 
> x86_64-linux-ld: drivers/net/ethernet/huawei/hinic3/hinic3_irq.o: in function `hinic3_poll':
> hinic3_irq.c:(.text+0x179): undefined reference to `net_dim'
> x86_64-linux-ld: drivers/net/ethernet/huawei/hinic3/hinic3_irq.o: in function `hinic3_rx_dim_work':
> hinic3_irq.c:(.text+0x1fb): undefined reference to `net_dim_get_rx_moderation'
> 
> [...]

Here is the summary with links:
  - [net-next] hinic3: select CONFIG_DIMLIB
    https://git.kernel.org/netdev/net-next/c/2d593cf14670

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



