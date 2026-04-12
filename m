Return-Path: <netdev+bounces-277866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCs7AYXi22lOIQkAu9opvQ
	(envelope-from <netdev+bounces-277866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:20:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 041EB3E55F3
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 270593002B43
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B1D362136;
	Sun, 12 Apr 2026 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrE6dDrn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD332BF4B;
	Sun, 12 Apr 2026 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776018046; cv=none; b=huZvlrGLWsnSSaxDxS0Wu1ApOjTzVY+T/k8izomJsnOSeE1cOn7FdEyaQJjNboPj/ptT3x/akbb2z2Q6lVWwQYoBwHOOAYOTUdGPlV5RIxWqiLJ/ZHnxYAkH9tQi7+jYaQorVFOxr49IrgsE4YD0b5Gz9qRNHQRCKrN5OcBCFpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776018046; c=relaxed/simple;
	bh=UeVaPRXCSZIavR1FYMQN4/WslCJujj9nW3EU7Xtd000=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bY3rhiOVtk1VwCv+gbZHG+vDSxu3Isp/yfSps5eNDHy3aKEnDgZtx/T58zklg59rtED21CiqZPSD/80HDB/Gbl649OAJ0Nk1rnXOaQBGY0VwCWD2nb+lCt+/Aptu1iyVeLSLVXgBPpFYvJW+Nz/pHZFBOzKL+AWK6YmlrIwEhKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrE6dDrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C8EC2BCB0;
	Sun, 12 Apr 2026 18:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776018045;
	bh=UeVaPRXCSZIavR1FYMQN4/WslCJujj9nW3EU7Xtd000=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jrE6dDrnsdOGKBCqRGPun6NyIfQCG9OyqGWSLuh+cpt/n4+HGKbEB7UJ6OoCfhLKr
	 cg5ekWDp25n1BxLxCND3p7yagoWdfzmYVpSUWzcsrJomu6gCi2OBVS7rqzhfULpACl
	 +BgRexypvR97uC4F2YM/3kZ5YsUN/9Uf4Q0S31Bk2H9I0PzVmKOyST3R7ij+ZAYQPB
	 sHiNdcf8pC8wISF9ku8xf1UzRXBIlxhEHdLrzUff7nQQCq0LOzhCyDwGNR7S8yaFFa
	 N+ENwWcv6Kfoen8kdSuR8NxGbFeN1thqq3qLp0QflBb5QkEHUMcRp1Yi5RgpJg+sya
	 qOQl7B3RTZYXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400683809A8C;
	Sun, 12 Apr 2026 18:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 00/10] bng_en: add link management and
 statistics
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601801805.3365061.17112474139655986481.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:20:18 +0000
References: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
In-Reply-To: <20260406180420.279470-1-bhargava.marreddy@broadcom.com>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277866-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 041EB3E55F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Apr 2026 23:34:10 +0530 you wrote:
> Hi,
> 
> This series enhances the bng_en driver by adding:
> 1. Link/PHY support
>    a. Link query
>    b. Async Link events
>    c. Ethtool link set/get functionality
> 2. Hardware statistics reporting via ethtool -S
> 
> [...]

Here is the summary with links:
  - [net-next,v12,01/10] bng_en: add per-PF workqueue, timer, and slow-path task
    https://git.kernel.org/netdev/net-next/c/2095da234017
  - [net-next,v12,02/10] bng_en: query PHY capabilities and report link status
    https://git.kernel.org/netdev/net-next/c/7626cd3d53be
  - [net-next,v12,03/10] bng_en: add ethtool link settings, get_link, and nway_reset
    https://git.kernel.org/netdev/net-next/c/169f6e8dd149
  - [net-next,v12,04/10] bng_en: implement ethtool pauseparam operations
    https://git.kernel.org/netdev/net-next/c/dc85e8a51f5a
  - [net-next,v12,05/10] bng_en: add support for link async events
    https://git.kernel.org/netdev/net-next/c/4a75900989c9
  - [net-next,v12,06/10] bng_en: add HW stats infra and structured ethtool ops
    https://git.kernel.org/netdev/net-next/c/8438239bd2b2
  - [net-next,v12,07/10] bng_en: periodically fetch and accumulate hardware statistics
    https://git.kernel.org/netdev/net-next/c/50c885cb2ebe
  - [net-next,v12,08/10] bng_en: implement ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/d4f802eb4e7d
  - [net-next,v12,09/10] bng_en: implement netdev_stat_ops
    https://git.kernel.org/netdev/net-next/c/c1da271f0d35
  - [net-next,v12,10/10] bng_en: add support for ethtool -S stats display
    https://git.kernel.org/netdev/net-next/c/bcc0f4c0f257

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



