Return-Path: <netdev+bounces-85396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9012B89A946
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 08:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494DB1F223CE
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 06:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CEE2B9B3;
	Sat,  6 Apr 2024 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lktAKcJ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDCE2940F
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712383832; cv=none; b=KwL/0d4x18wvavsq6HJQce2q6z3snJ2PmR0Xz9Rgb3geqs46+BOQSeJHmecA4Dlv/QGvZwATXIUywAOQkMF3HqrUEKynlh0mvpWzBBx/kGISVmno26yWXR3kdMcl2ICqC9sBM9iWFPImA9/9TGY4eu2wEcDsazmqpjnp4MJ6x7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712383832; c=relaxed/simple;
	bh=UM2O4NH4fVpHpVFZO55tdt8rLGAthIULxcC3GT1AIxU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gAvchpoTxSJI515L6S+D+5OlSI9ijEbXo+9POoermbhPXgwUJQBMlLLtCOF8hyDZ2qCpnMOYZYMnZ5QhKGBARIv9vsIN25yEn94FPHIaaMJfGDrw+JigfaAa5ZFs0hMZAT6mu3QNuGemgMJg11h+Zxf1o1CPE0Bv5Mp1dbSxUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lktAKcJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1AB4C43330;
	Sat,  6 Apr 2024 06:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712383831;
	bh=UM2O4NH4fVpHpVFZO55tdt8rLGAthIULxcC3GT1AIxU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lktAKcJ3Fgmb1keTXfvjuCr2PHn6jIQk9GjEojtMCDWC/gNQpXNsW29EWvyqjS5Ii
	 JzgIIVHspw45tuaS/ysob84dOUVYdYWvitR5lczunr8UKOTGMg4b67lB1Q0n4T2lTg
	 o7SHtGNkUBinr8y6vsuXavpzsDxofdAVdOZXVE1yHlYDnA2voR7DqUDa5rKdz6RmQQ
	 lSqa+FxdhwOBPqq2zOUOGveg6lc1PmXmCXRxhYVrq7m0vqDsolvrlOYjZRVg5wO8K7
	 YqJijH3GZSLlifiZLozjsvziijPZYKs1eyvY9q1/1bwwqYhuqoeFfkA68Wnm3vmyrA
	 9Up/Hfbky2qGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7EA7D84BAC;
	Sat,  6 Apr 2024 06:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 net-next 0/2] ynl: rename array-nest to indexed-array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171238383181.24936.14404874871838434308.git-patchwork-notify@kernel.org>
Date: Sat, 06 Apr 2024 06:10:31 +0000
References: <20240404063114.1221532-1-liuhangbin@gmail.com>
In-Reply-To: <20240404063114.1221532-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
 jiri@resnulli.us, jacob.e.keller@intel.com, sdf@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Apr 2024 14:31:11 +0800 you wrote:
> rename array-nest to indexed-array and add un-nest sub-type support
> 
> v4:
> 1. Separate binary and integer handling (Jakub Kicinski)
> 2. Update sub-type example in doc (Jakub Kicinski)
> 
> v3:
> 1. fix doc title underline too short issue (Jakub Kicinski)
> 
> [...]

Here is the summary with links:
  - [PATCHv4,net-next,1/2] ynl: rename array-nest to indexed-array
    https://git.kernel.org/netdev/net-next/c/aa6485d813ad
  - [PATCHv4,net-next,2/2] ynl: support binary and integer sub-type for indexed-array
    https://git.kernel.org/netdev/net-next/c/a7408b56e5f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



