Return-Path: <netdev+bounces-153809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB939F9BEF
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599097A1D9B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82332225A3C;
	Fri, 20 Dec 2024 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCZDqKWD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860022332F;
	Fri, 20 Dec 2024 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730214; cv=none; b=qsoEvyjWy22B6qKQ2QUOSc2EpMPgRlC4cm+SAHRZyJe4MI6ZFCVhNsKLKcx71C6kkOQIarXPkgTuPnQ62aiixrvDP01p+NmHK4AA9w6jNVFUhHG9Fpc/F+ugx9NLwottpsqrrsuX/q08Y7H//FDK+NfIotYlzirXaRK2U/QQLiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730214; c=relaxed/simple;
	bh=b5Rwh5xVQlrMBTuoagvnkQiq26eDbIKy+GUI57lb9vE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fQp6+FKcv+uCrDxuU4yJzfvsaf6/8Tr5Ua3MrlJHfFuvzFhy83tkJ4X0dxln7tnDqTqX8EW1AqSBDaZdtxLKbtVu+L2kWzaZPMVfOc9i4yeGrsK1mSD359umP65O8Ax+pzUByThkayFOdq+4gKiOa+1ICPtQNnFZIIkdGASqGqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCZDqKWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3882C4CECD;
	Fri, 20 Dec 2024 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734730213;
	bh=b5Rwh5xVQlrMBTuoagvnkQiq26eDbIKy+GUI57lb9vE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NCZDqKWDwnoZrTMYfgB0+yd7GRJq3k/wvQ6F91sIRnYSVk7vapeWsqNKeKHyIgXEw
	 wCRlJ683Ig171PjFMsv0CxKb+l9Uc9bMzauO8boQYSAOVVDs17YTRoQSWvNfvsifWa
	 FxJsfwlrl4+fnJ+4TK0nakZb4q4sFZ5Y7uBObJEdkQtOg3jNpldfeTOZUgJ5kh+bSQ
	 70mUKQHuvu9Uq44m07pYKRNR9GdT0Vx85sy1mmbCYeQs5qopr/zaDSa9VzFOHnA+9E
	 EJ8/tfXvPW20OsL6XPDSGOIiD3q2TgQpQyyvOtgEej0AFMwXS4VXNrDUYCjgQGh9u5
	 wUYJwTa2Sm1yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5D83806656;
	Fri, 20 Dec 2024 21:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] hisilicon hns deadcoding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173473023175.3026071.189894277581677149.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 21:30:31 +0000
References: <20241218163341.40297-1-linux@treblig.org>
In-Reply-To: <20241218163341.40297-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: salil.mehta@huawei.com, shenjian15@huawei.com, shaojijie@huawei.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Dec 2024 16:33:37 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   A small set of deadcoding for functions that are not
> called, and a couple of function pointers that they
> called.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: hisilicon: hns: Remove unused hns_dsaf_roce_reset
    https://git.kernel.org/netdev/net-next/c/a574fe14ed1e
  - [net-next,v2,2/4] net: hisilicon: hns: Remove unused hns_rcb_start
    https://git.kernel.org/netdev/net-next/c/0265e9edf210
  - [net-next,v2,3/4] net: hisilicon: hns: Remove reset helpers
    https://git.kernel.org/netdev/net-next/c/0198b459f54e
  - [net-next,v2,4/4] net: hisilicon: hns: Remove unused enums
    https://git.kernel.org/netdev/net-next/c/8973ce189376

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



