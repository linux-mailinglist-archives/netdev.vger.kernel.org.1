Return-Path: <netdev+bounces-70645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEB584FDC5
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4B8B2516B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282485681;
	Fri,  9 Feb 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSBCzQS8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04358107B2
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511230; cv=none; b=u1gjGoynVilrHO/bWuW8vJFNWMMwoMFNR9sp7jOoUGrZlOyS8jzh+hCEtVStkollmB29WOLHrUt3NqmoYvQrlIUxYZ1/+cxDWJL8+a6b+1wLJaNeo6HbL/d2aN6P+NeHy1GvAhkF6PqOWLCqgOQiGXXzf5rkakpp2skJXhpOQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511230; c=relaxed/simple;
	bh=w6Yi7naFxZzlW4P3XY99CmbZHRQNEODb0ELBeoB60jg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F4pRg6YvEOodIimTWWp35WInfnONiS9kFglj03O/VSPS0kkrJXnAZyEosJbIDKhYeh3SXgOWI74xXNe1PQIHanTZ9MyPjV/f+CCNB2Hx1J47taRYQT2BHGGvQX4tmitV9WdQBiQgXrjPwlnVtW5ispTNrcjkKHHnDSoxFMWVvXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSBCzQS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C402C43390;
	Fri,  9 Feb 2024 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707511229;
	bh=w6Yi7naFxZzlW4P3XY99CmbZHRQNEODb0ELBeoB60jg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cSBCzQS84qqV+hZ0c7bv6qqAOCfbgSQvpggD2V/s26183jYDdyzY8po02FNxnaf7N
	 XUMdp9kF6sZ8MoB1wy3bh8ZlRNSNNQy61Rm0mXC8r05A0RC6VPGwSFp8PVmTWEHG9f
	 Km203uAX7EUW3ltGspvh1coogHT2uWRHsP211S/1mJ0C+8V/nTaMEDJIsq0CvE6G5p
	 APcOJZfBN7vV6dSu+vQgjDpWXO7oiNXXyHT7+TbxT5n43zcXlb4x/9DPDb2WSQoILL
	 aqB4WaPV8ZHri11xh85P9QzckFWXuPJkn5IoBTq8k12rWv2rppQ/SeldpBYWzitPH/
	 v/+ughJOzbRvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F205C395F1;
	Fri,  9 Feb 2024 20:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: tc-testing: add mirred to block tdc tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170751122937.31586.2434775281557405318.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 20:40:29 +0000
References: <20240202020726.529170-1-victor@mojatatu.com>
In-Reply-To: <20240202020726.529170-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel@mojatatu.com, pctammela@mojatatu.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Feb 2024 23:07:26 -0300 you wrote:
> Add 8 new mirred tdc tests that target mirred to block:
> 
> - Add mirred mirror to egress block action
> - Add mirred mirror to ingress block action
> - Add mirred redirect to egress block action
> - Add mirred redirect to ingress block action
> - Try to add mirred action with both dev and block
> - Try to add mirred action without specifying neither dev nor block
> - Replace mirred redirect to dev action with redirect to block
> - Replace mirred redirect to block action with mirror to dev
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: tc-testing: add mirred to block tdc tests
    https://git.kernel.org/netdev/net-next/c/f51470c5c4a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



