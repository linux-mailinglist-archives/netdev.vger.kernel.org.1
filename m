Return-Path: <netdev+bounces-225741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E63E7B97DAC
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B2319C25B6
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92D92BCFB;
	Wed, 24 Sep 2025 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY5GFlxM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B13EAF9
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673217; cv=none; b=f1Gl1SQrOsAIF1BCGEb8lkooR9PZYGkIAOw7Hx0/5sIknMeNE8meA8X1Qb2vVqSVz2sbarEWUBKjPUOOnr3hipzU77U7LVHmxX1fPNf6wAVRPhknyPCdE9Lr5QAy1ssG7rAPPPbNC/l3ybEYdVyen2lQazmTEfqcmkZI76wcgiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673217; c=relaxed/simple;
	bh=/8TFmn5JASPN5SQosAoS/+k5IU+K7iupKKjCO7tI82E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j3n9TtwV0e6IL3A8o0tTM6xbaJ1l7OkLXPHMHFUiVFWOyiPLv/GGtkt/D7Ca7WWpi5dEQQu1sos8T9Z7/ajg1CFK3QbMoespVDoDSFKrc13GAcCllMKFQINlrpxBflrAYLTiVogs5hVbWgqc5A1iyHRh9gN/wQJeQsTaI/py49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY5GFlxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A84DC4CEF5;
	Wed, 24 Sep 2025 00:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758673217;
	bh=/8TFmn5JASPN5SQosAoS/+k5IU+K7iupKKjCO7tI82E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jY5GFlxMcCNd+WPDIlSl+WN7xqxd7NDQ3xcJDT4oxbNIwrAtZgS3Y6eoW7vxixHxr
	 mEUsUO8b3EKP6Gc0hHN0xZNK8SMUFgQ4j288zJnp6zaW8wjnriAXGiyFKH1YsGct/z
	 S8ANL87DCE7VOfKNZAg5bItFfCCatJnqTItKZpLIgwudk59QVhFeKhkxIgUiy+ZDWv
	 Z1q7ZHvOFPryeCsplHXcFognaFtTGqtQDNKlxbixCRqI9hMGDDdCpNAPqTfuRU/fLl
	 bh9ha5V78pC/8+yOsEHtdxD3il+R4lt7wVhnXfGnxoz1AGreods69UgISlw4Xn53CN
	 ff/m4f5NveMCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F5439D0C20;
	Wed, 24 Sep 2025 00:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] nexthop: Various fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175867321400.1971872.761507568788399462.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 00:20:14 +0000
References: <20250921150824.149157-1-idosch@nvidia.com>
In-Reply-To: <20250921150824.149157-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 petrm@nvidia.com, aroulin@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 21 Sep 2025 18:08:21 +0300 you wrote:
> Patch #1 fixes a NPD that was recently reported by syzbot.
> 
> Patch #2 fixes an issue in the existing FIB nexthop selftest.
> 
> Patch #3 extends the selftest with test cases for the bug that was fixed
> in the first patch.
> 
> [...]

Here is the summary with links:
  - [net,1/3] nexthop: Forbid FDB status change while nexthop is in a group
    https://git.kernel.org/netdev/net/c/390b3a300d78
  - [net,2/3] selftests: fib_nexthops: Fix creation of non-FDB nexthops
    https://git.kernel.org/netdev/net/c/c29913109c70
  - [net,3/3] selftests: fib_nexthops: Add test cases for FDB status change
    https://git.kernel.org/netdev/net/c/00af023d90f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



