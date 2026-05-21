Return-Path: <netdev+bounces-290486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO2QHNggD2qnGAYAu9opvQ
	(envelope-from <netdev+bounces-290486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:12:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1869B5A80D2
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D3FA31F1D44
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AC41A6814;
	Thu, 21 May 2026 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsKg+a+x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A7611E
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372611; cv=none; b=XzqxaOIAGRSPYwBzzMqrUh6RpdeVqoQyfUp/n+Y+eDbYxvIp1w80YeQUiIscQMIMsd5gggH7dnXsONr8h6qgD3Xdu7gxYMPbl5ceGs4oFjZaBHBDb5Y1TaiYHrGBWuiW70Cjw2qMY8A/IQbwaI1PPGhNQ7pWQgvrkJzltMa6vkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372611; c=relaxed/simple;
	bh=LfJEed8FVi8NmPUXZMR6kRoE98S+/KBhKkfvSRpeUCw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JzWt+eer2hurujf6OtHUz/t1ZI5EF/N5N0Rh2XYbuIxJY/BTYpkoYdPSCCW9OJ/NI5nQPA1r0eGVfzWqQ2Rh0FHRXWDVSlx0C/S0Y0/DxjsI+BM7cRUQ7gE13gPkEnMI+ZXgqZFoCEtlodtDYdbUweUGIyyt/bsS6uoQnm1Kr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsKg+a+x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DD81F000E9;
	Thu, 21 May 2026 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372609;
	bh=ALfJb7rTXQ+RL1IByyB+qWVeikkQgS87H8EQ9cZsr4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GsKg+a+xtMFkLOTv9gk5rAV2YNiDd1JwYCvfUQ06co0bMlI5PBcMJ5h3HVl23IdVx
	 2sqDESNsx1vavu/1uQ/YJ4QXgp5qSb3hURNwetG9+yRteE4MovXVBJK8HhH7VrzwVX
	 5ST5Wcw5AtD3ZUr0suDJmr28B7GVYg7kSl0nFK2ZbbyHdl8QpyhKjVcYTWb8VesBHA
	 6ThCx27WsUb7K7Nqc+Ul97zkTs6vsK+ltsCbATsiAVkDguDjHTFR3s3G89yMUncfyr
	 whtcpogu4uGJYy2I1uP8qPRMWZ9cSSw8outrshzJ+Sz8cnyanbfZwTKw23OlVh/5Kg
	 diJsydiCnFH5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B733930DE5;
	Thu, 21 May 2026 14:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/11] batman-adv: fix batadv_skb_is_frag() kernel-doc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937261940.334326.3846070326283907142.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 14:10:19 +0000
References: <20260520115422.53552-2-sw@simonwunderlich.de>
In-Reply-To: <20260520115422.53552-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-290486-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,narfation.org:email]
X-Rspamd-Queue-Id: 1869B5A80D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Wed, 20 May 2026 13:54:12 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The kernel-doc comment for batadv_skb_is_frag() contained two errors:
> 
> * the function description referred to "gain a unicast packet" instead
>   of "contains unicast fragment".
> * the Return section omitted "merged" from "newly skb", leaving the
>   description grammatically incorrect and inconsistent with the
>   function description.
> 
> [...]

Here is the summary with links:
  - [net,01/11] batman-adv: fix batadv_skb_is_frag() kernel-doc
    https://git.kernel.org/netdev/net/c/0039ac830506
  - [net,02/11] batman-adv: v: stop OGMv2 on disabled interface
    https://git.kernel.org/netdev/net/c/f8ce8b8331a1
  - [net,03/11] batman-adv: tvlv: abort OGM send on tvlv append failure
    https://git.kernel.org/netdev/net/c/501368506563
  - [net,04/11] batman-adv: tvlv: reject oversized TVLV packets
    https://git.kernel.org/netdev/net/c/f50487e35663
  - [net,05/11] batman-adv: tp_meter: fix race condition in send error reporting
    https://git.kernel.org/netdev/net/c/71dce47f0758
  - [net,06/11] batman-adv: tp_meter: avoid role confusion in tp_list
    https://git.kernel.org/netdev/net/c/ff24f2ecfd94
  - [net,07/11] batman-adv: mcast: fix use-after-free in orig_node RCU release
    https://git.kernel.org/netdev/net/c/20c2d6a20ca9
  - [net,08/11] batman-adv: iv: recover OGM scheduling after forward packet error
    https://git.kernel.org/netdev/net/c/aa3153bd139a
  - [net,09/11] batman-adv: bla: fix report_work leak on backbone_gw purge
    https://git.kernel.org/netdev/net/c/0459430add32
  - [net,10/11] batman-adv: bla: avoid double decrement of bla.num_requests
    https://git.kernel.org/netdev/net/c/83ab69bd12b8
  - [net,11/11] batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface
    https://git.kernel.org/netdev/net/c/f80d3d98d2ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



