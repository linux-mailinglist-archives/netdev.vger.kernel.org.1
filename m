Return-Path: <netdev+bounces-173147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC87A5781E
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CC8189A722
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC9C19CCF5;
	Sat,  8 Mar 2025 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSU5paSE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A460219C57C;
	Sat,  8 Mar 2025 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405813; cv=none; b=HwKb+IaLdyRgsmTAUdh4zi4W1YjKXCS77H7aIZmgXQQbXm/YopHSgHfDbBXCEkyzZbH1rJAqqoDExJipG7lesBFSeW71qtvp5eH68jl9b/T/ULIiBioDw8T55r2TzQ1f06ROrcqCBRMK++mSUHVYrXETJ4Dec+5ncUkmSDJizhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405813; c=relaxed/simple;
	bh=LTLedz0rUoQkGzGjg3GVcO+gfls7McrashGAtoxZecA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QTBCXYTH6v/PpCi1ch37Itpk8i2ZLQ9aqVRYNXIwiVosTr7GLpGuj6OVnycrAcxs+tEOACfnB1tGoaKrEKvOK4RUi+wrNk0dOiult9St+Te10O1UkRORqZoRSquaPAFdECg/JzqXQBDahqqniGVOlP8LAh9cCH3FxoQH9ze9jEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSU5paSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBF5C4CEE0;
	Sat,  8 Mar 2025 03:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405813;
	bh=LTLedz0rUoQkGzGjg3GVcO+gfls7McrashGAtoxZecA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pSU5paSE92B3jTwOz/fXrX07Nf3QSv5YM/FsXMAIT36kM4heja6H/JCyJVtAGn5PA
	 XPEpnb3jy0w1KVFx5veJUa5Bp2CrC0SwNQzmsBHFPASsnjzE5L0AmIlwWKa638pHeY
	 sxPJWlbRK3010aPzpWA7i/g6s2ZVcW1/4BEtJweUY4YI16TsMtpVLh7sMNDJumx8ws
	 aPO1wmoYUSypBhaGS1gz4LY8Dr/W4iFaOZsgkYJpRf+wRfYzordXoo6oHGCBOU2Wse
	 NhF6sxWvUTNB6RylxHUBfuS7lTjWDW4qjcPJuoiPNUx0WBdI9905ieeOxXuNbQqSQx
	 wwMyZ5FG8Y0gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD96380CFFB;
	Sat,  8 Mar 2025 03:50:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tcp: ulp: diag: expose more to non net admin
 users
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140584648.2568613.10671440631322496348.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:50:46 +0000
References: <20250306-net-next-tcp-ulp-diag-net-admin-v1-0-06afdd860fc9@kernel.org>
In-Reply-To: <20250306-net-next-tcp-ulp-diag-net-admin-v1-0-06afdd860fc9@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, edumazet@google.com, ncardwell@google.com,
 kuniyu@amazon.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, martineau@kernel.org,
 geliang@kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 dcaratti@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 06 Mar 2025 12:29:26 +0100 you wrote:
> Since its introduction in commit 61723b393292 ("tcp: ulp: add functions
> to dump ulp-specific information"), the ULP diag info have been exported
> only to users with CAP_NET_ADMIN capability.
> 
> Not everything is sensitive, and some info can be exported to all users
> in order to ease the debugging from the userspace side without requiring
> additional capabilities.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] tcp: ulp: diag: always print the name if any
    https://git.kernel.org/netdev/net-next/c/f5afcb9fbb39
  - [net-next,2/2] tcp: ulp: diag: more info without CAP_NET_ADMIN
    https://git.kernel.org/netdev/net-next/c/0d7336f8f06d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



