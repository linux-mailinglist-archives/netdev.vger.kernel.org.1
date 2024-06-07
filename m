Return-Path: <netdev+bounces-101806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E1E900228
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9D41F263E8
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BECA188CC0;
	Fri,  7 Jun 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nd2x7JA5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3549B13FD7D;
	Fri,  7 Jun 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759834; cv=none; b=lbItVauEy3cSWS3pGf/Tm62SV/ZVKWsXcLQwoQiTGdk+ekCxkVbrK40y1BNvQoDokGbZvOgDhOkLfulNJQBdxi+uWwK7eUadrI30r0Wi63V1IeJjaggxIZ33xpHkLOjBa/wgo7c9E8F7Jx9muOEqpMMlsjUYmkhMrwUGJoyuRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759834; c=relaxed/simple;
	bh=enrwhfG18wfm5gqaqtyOjWSrtHc3M17cSZkl014723U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VN+fRJC7++ANivlwXQuPqX35YSm0DVv7GU+c1sw7p+RVgUBYpygGjTUZKQQiy2M6ZZrbEqF0gCkKF1qbQQHmMafK5WAg5nrgWBYaNPWKtzYbJc3tKrzvtD6NP5LHfsS1ARG/5NzHJWR2koQZs6gBISda2dOcwTfSzXz3K0l5ZVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nd2x7JA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABEACC4AF08;
	Fri,  7 Jun 2024 11:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759833;
	bh=enrwhfG18wfm5gqaqtyOjWSrtHc3M17cSZkl014723U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nd2x7JA5lOY//2wdXfGxstCw4W3sv1SkcQlZJ31ZeOh7+LPenN/EmWo1UDnP0hDau
	 9TtFHET8KYdf3IDHaZpJU7pdTo85nVXnrRvJzFyNTLJ8Av4zpKQTknPzj8pFDYbbnJ
	 mZA5Z2I3m5jD03Co9aE0qeMaRCp9o/3di0CaqH2vX/nDvWcEBfo3CrrPzVq/g6X6KO
	 2u9Tfr3CTY40pM+m4mXglzX/tz9suNMj2cYQp1MbesvFtTckvqwTIEtd9hyA7jp1a/
	 HGYTGVWcxII2P6RQMxYeYuTR7H0lw7MyI5cdtuz0uFZxc4yTYiv6aPTp640WYYnY6K
	 vx27qCSqk2a6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A100CC43168;
	Fri,  7 Jun 2024 11:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] There are some bugfix for the HNS3 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171775983365.24248.8058677044176070765.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jun 2024 11:30:33 +0000
References: <20240605072058.2027992-1-shaojijie@huawei.com>
In-Reply-To: <20240605072058.2027992-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 5 Jun 2024 15:20:56 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> Jie Wang (1):
>   net: hns3: add cond_resched() to hns3 ring buffer init process
> 
> Yonglong Liu (1):
>   net: hns3: fix kernel crash problem in concurrent scenario
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: hns3: fix kernel crash problem in concurrent scenario
    https://git.kernel.org/netdev/net/c/12cda920212a
  - [net,2/2] net: hns3: add cond_resched() to hns3 ring buffer init process
    https://git.kernel.org/netdev/net/c/968fde83841a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



