Return-Path: <netdev+bounces-263525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCU1LsKLp2nliAAAu9opvQ
	(envelope-from <netdev+bounces-263525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:32:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED241F9767
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33E4530A00B9
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318FA3126B4;
	Wed,  4 Mar 2026 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slUaNuCy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C23101A0;
	Wed,  4 Mar 2026 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587813; cv=none; b=oST9drKjBCm5pGqdQEftQWJ+KH2gQKkLdpVZfXXt5DL04bbUkjoYlWFsWXGxsWjLjUdfww2ZQT632EtjbaCgz37GaMrwknnsOZqXilwDxpnq/fkEn1xIra5pyNX/5sApDnVeQwZno7WpLwMIQfZh5Th3TbDQ1UVXLLZPa85W9Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587813; c=relaxed/simple;
	bh=LX6jxVGkWCFd048/z4x34zxuTcDcGZ/MLPusWZv7SiQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K26CCkozbVeDsedT0agftOpyRJVWJEyLKvtNU/kvgZ8xXUYhx2HijyvmpiJDvjrXOF/ntIyKln0wP/hNfOmCLKItXZb6XVv/hldEAViT2NvqxeHddzAvzM2EJdbMT8+jn+CGZ5jb4gyVIbE8+mwQIMXaUd0JEc6CZ5OEI6C6JaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slUaNuCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1F5C116C6;
	Wed,  4 Mar 2026 01:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772587812;
	bh=LX6jxVGkWCFd048/z4x34zxuTcDcGZ/MLPusWZv7SiQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=slUaNuCyJjN8/CYruHW8Dx0RuU6uL9Gfy5xj0mMcuUhhRAp2ckmiDVphgEd4g56k5
	 XiPnrsU9fZHwICgxiz4qZx2eDDjdjgZ+D0nNS1FRQwv2QRvfhRZkBcPFHOkcftGozi
	 qefn6OPRKlLPtpNlwtC8LxQN6IwJ6lSBQwAiwf4TB1sDByayqbKYWlFXO/uM4DO2gL
	 rpTGK8MRSw6ikFu/Qx0HUaenO/eKTypk4Vf4CJYUvwfgN1QObGqkyn8CAu7a1p9pZD
	 jaIsk0C+ejQDfntbHTISRfXDhosFpdQ1zYa1iNlyyGQybl3adV5wzoU3S7dq81Cr6h
	 se/PKRFv7aS+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DBE3808200;
	Wed,  4 Mar 2026 01:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: ipv4: fix ARM64 alignment fault in multipath hash
 seed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177258781354.1546050.15273963927175937480.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 01:30:13 +0000
References: <20260302060247.7066-1-yuuchihsu@gmail.com>
In-Reply-To: <20260302060247.7066-1-yuuchihsu@gmail.com>
To: Sam Su <yuuchihsu@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
X-Rspamd-Queue-Id: 3ED241F9767
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263525-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,lkml];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Mar 2026 14:02:47 +0800 you wrote:
> `struct sysctl_fib_multipath_hash_seed` contains two u32 fields
> (user_seed and mp_seed), making it an 8-byte structure with a 4-byte
> alignment requirement.
> 
> In `fib_multipath_hash_from_keys()`, the code evaluates the entire
> struct atomically via `READ_ONCE()`:
> 
> [...]

Here is the summary with links:
  - [v2] net: ipv4: fix ARM64 alignment fault in multipath hash seed
    https://git.kernel.org/netdev/net/c/4ee7fa6cf78f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



