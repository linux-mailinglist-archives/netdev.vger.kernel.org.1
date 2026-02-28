Return-Path: <netdev+bounces-262174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMeTDzUfo2mC9wQAu9opvQ
	(envelope-from <netdev+bounces-262174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 18:00:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1F41C496F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 18:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B73FD3068DA0
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40766314A65;
	Sat, 28 Feb 2026 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdgUAaYY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC8430C37E
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772298006; cv=none; b=tmLudx2rTMU7Uyuy/EK/sy6TtyXIp9JKaBd2poxxOMHRjLelbzZ9A91JFHPuX5VvVFdS+RhJIJEnX16PEZiEOcRyi2PwCXwo7L4lPttj7jNdB8AJofh4XQr29JuODOF+H/qpF7M+/ssgJs1C+vdSZg0bbXbssbA1KwAYyGGklLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772298006; c=relaxed/simple;
	bh=tXIfe3dlf6K/NHNd0eaqUrhIrT6OjA0/UMXfRPKoF1Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZQ4O4petVzQ2FGmgJPM7iXbuVCC2GLK+aVQBxU8GKL7XWWQxRYqy//pd0biX71HWIDwcZrb0beBsVcdT3Izd2ZiU0CEXFlpj/IeZFhFG7ETI38OunIIWcTbWnakm0kli3ZUjqNDSk8PGyQpoZamUX76EX2r/GoGH0jh4hpFxRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdgUAaYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22D7C116D0;
	Sat, 28 Feb 2026 17:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772298006;
	bh=tXIfe3dlf6K/NHNd0eaqUrhIrT6OjA0/UMXfRPKoF1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AdgUAaYYfhrDPXWARHJxHvPBJclmBHUhNwPJtaCyNfRjulUBFELz3GIg/SIQrFjHf
	 X7wFFzV5aLU8kx0HLp6VshXYWl7/ELp3jl+dBLXOL/mAn0keUs8taQN20+9FW7tysI
	 ftfCiY3jKJ1ntyQM9w+7IlJv/2iI/rKDT+gaJ5+zM8dnu9R/b4N/BBH6/pG/i5D/Hf
	 FBkgndxVAp8hutvnZPmb44XIpzlNvIf0xy/6DA/t01rDdCSsLu7VfXxcVsikJmSPBE
	 wpjl84KgW986NBUGKeX14hV2OZCgFHEZJFLLKo9BqwKX+LjxyLWPGmTvKscHFR7j3q
	 00j+BKKc6zmIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CD239F2022;
	Sat, 28 Feb 2026 17:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/2] xsk: Fixes for AF_XDP fragment handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177229800880.3015444.1592823665460891413.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 17:00:08 +0000
References: <20260225000456.107806-1-nikhil.rao@amd.com>
In-Reply-To: <20260225000456.107806-1-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kerneljasonxing@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262174-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E1F41C496F
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 00:00:25 +0000 you wrote:
> This series fixes two issues in AF_XDP zero-copy fragment handling:
> 
> Patch 1 fixes a buffer leak caused by incorrect list node handling after
> commit b692bf9a7543. The list_node field is now reused for both the xskb
> pool list and the buffer free list. Using list_del() instead of
> list_del_init() causes list_empty() checks in xp_free() to fail, preventing
> buffers from being added to the free list.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] xsk: Fix fragment node deletion to prevent buffer leak
    https://git.kernel.org/netdev/net/c/60abb0ac11dc
  - [net,v5,2/2] xsk: Fix zero-copy AF_XDP fragment drop
    https://git.kernel.org/netdev/net/c/f7387d6579d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



