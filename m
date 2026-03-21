Return-Path: <netdev+bounces-270162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGnCCZ8OvmlQFwMAu9opvQ
	(envelope-from <netdev+bounces-270162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:21:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3432E3184
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B260303465B
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E75630ACEE;
	Sat, 21 Mar 2026 03:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSqbTVjc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116B72FFDDE
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063241; cv=none; b=rub3RUrbWWfH/DvfTV376e15r/4u8LDlx/rFub5LDl7+5gPFy3R+69TlXfRUuYEphXemjt50mmEl57CtKEZ6rwIiqEf2T9rIdh19DIJ/clvr2bIrO1UJ0jutB7tyNMezVloHCgxhFGtBKFP8eJNRx5ZaAKRerbhIMCCQ1vFYRUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063241; c=relaxed/simple;
	bh=OV+E1jP6wlLwMj9T0gpVoGuIrF2Xp35ZMAJzvPmRjYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TJC9HalECeBlH9NdxbbTyobl6exvzjixTysbTNeNkaJ8Y1VABPBUk2yZc0xlxcpO26ff7HrLRcK1ZYpCxl1xGWCvmpj1AKIZmefEeyK2IDiEqZuQEqzAYDh43/Qfgke6oFr5HFricDQSK9XF0OMiGRf70VAuSLkDrTL2BjOC//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSqbTVjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C073AC19425;
	Sat, 21 Mar 2026 03:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774063240;
	bh=OV+E1jP6wlLwMj9T0gpVoGuIrF2Xp35ZMAJzvPmRjYY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sSqbTVjcd1K9UEO7GOJbtxppHPY60laY7xZBOYgORpoc5p1/LRZhQs95GTES5XJZK
	 kLJzXXMDQG6khH/lMKlvxH1Dtr5IKv1Pm4oFpJk3QaeE167vgxk0VL7tUCN7wD+xwi
	 cMUp7Wgro7DmbAgdrsTLGunErElZnJoUn3o93jXrUynEcL2hW6MzFM8CPKt4J3x0Y0
	 9/CmyqpWFVg9WAihj96s7xg4eL+v2lzldC0hLH9ykwfMUJTeqkbAcNuVbPcPn1Edg2
	 u6DcqqCdse2jzu65jnGizgcEaHpmWDX+RP0HaOJPGC9lVkVwOkLHLVCJ6EYwJ0psd0
	 sgDPgBPFg5Prw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E5B3808200;
	Sat, 21 Mar 2026 03:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2] net/mlx5e: Allow set_rx_mode on uplink
 representor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177406323053.2737822.485920694733400438.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 03:20:30 +0000
References: <20260319005456.82745-1-saeed@kernel.org>
In-Reply-To: <20260319005456.82745-1-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com, mbloch@nvidia.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-270162-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C3432E3184
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 17:54:56 -0700 you wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> set_rx_mode handler was skipped on uplink representor, since uplink
> relies on FDB to forward all traffic to it by default, which works
> perfectly on a single PF per physical port configuration, as explicit
> mac request isn't required, but In case of multi-host and DPU
> environments, uplink can only use own mac address, as set_rx_mode
> wasn't honored in uplink rep.
> 
> [...]

Here is the summary with links:
  - [net-next,V2] net/mlx5e: Allow set_rx_mode on uplink representor
    https://git.kernel.org/netdev/net-next/c/609e79253ace

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



