Return-Path: <netdev+bounces-284642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM8CJKCX+mk6QAMAu9opvQ
	(envelope-from <netdev+bounces-284642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:21:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 935334D5382
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D30E9302009B
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649CF277007;
	Wed,  6 May 2026 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8/cRtyu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42850267B89;
	Wed,  6 May 2026 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778030465; cv=none; b=G/1bLZwn1DtkHXaokKMB75BD9uTBbL5C0Dlqgeu8cnxuBwkmmPsVPW14ocATeTKy5iMOcHKafOLY9O0MxLXdlpWM7aNCnWRtq3xDzTkNJR3h8KPLE5TWzNGK4N/ylnsJ9fGjsn2R4YjjvY3aCkf11EbRiZLoSn8mco9UVPtf+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778030465; c=relaxed/simple;
	bh=WG2A+Swh5jbEoHIfgwn/6sVRAWH5O5i0grAZx8kNtlU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uVYMg5KER8fPPnYfsuKsrrNXs5An+fQI4nf8H0A1EbDwia5QK4IrYUJUMpfelTX105OlQTL+XPgoUeGuj5mQBQOj1sT2IKXNuwgigN+T2bU557WlBG/CmJqoFKQ+B58ER0OnxcSQ9RwCAfZAhmD1nJ3cs4whDiZvlQxT+OGPhqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8/cRtyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20700C2BCB4;
	Wed,  6 May 2026 01:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778030465;
	bh=WG2A+Swh5jbEoHIfgwn/6sVRAWH5O5i0grAZx8kNtlU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y8/cRtyu+gKa0YfdMLiNVrqMEw3qxGsN+sKwUcxsxx++Qew3sDn2gZH9I0eG4I6Pp
	 nFoPzMP+AmUukRxHVkwqNqqp3YjlZNuGoEeTpYm+YkxksKM60kSBehgG93M6fxJ8WH
	 4jofRQoct7eSXW3tNfVsaWwSE4MoVFtsrYJ0Stmqi7eY17VHzk2uuRegCiG+oUhIVN
	 oOlw3ClaMJYiMOZXC4c6lSOKVyt1VYU0A0DEgj/x81BoTEvzG4iKbGfwR+2Eb+4Gx4
	 p+aXiHwtq5q4zYfz7jn1Hq+t00YY4qCGc9W/FO8EfLyml74ojqjQG18tbBBt6yxdYv
	 +o2U1DkFzEOUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF333930780;
	Wed,  6 May 2026 01:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/3] selftests: drv-net: convert so_txtime to
 drv-net
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177803041504.2335725.15765124651385983466.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 01:20:15 +0000
References: <20260504174056.565319-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260504174056.565319-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, willemb@google.com
X-Rspamd-Queue-Id: 935334D5382
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284642-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 May 2026 13:38:31 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> In preparation for extending to pacing hardware offload, convert the
> so_txtime.sh test to a drv-net test that can be run against netdevsim
> and real hardware.
> 
> Two preparatory patches
> 1. support negative tests, where tests are expected to fail
> 2. add a tc helper
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/3] selftests: net: py: support cmd verifying expected failure
    https://git.kernel.org/netdev/net-next/c/d9c1e7dc4ada
  - [net-next,v7,2/3] selftests: net: py: add tc utility
    https://git.kernel.org/netdev/net-next/c/49bf9e5e7c7c
  - [net-next,v7,3/3] selftests: drv-net: convert so_txtime to drv-net
    https://git.kernel.org/netdev/net-next/c/5c6baef3885c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



