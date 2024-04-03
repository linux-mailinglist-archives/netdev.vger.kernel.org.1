Return-Path: <netdev+bounces-84573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B60F89781D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662E1B3685F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698516EC0D;
	Wed,  3 Apr 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9vfLw74"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435D016EC09
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164829; cv=none; b=CVJMuqojSsa8VXEhcf0/n0M1JutiAPniNFcD0/ArGYq6UbsT4yh0aVO6PkFIvOjnj+L9WHhY0EcVYj4Q51CD6PvKCtxIDP8+bGwiL/Me+eKsI2LKdnT7PfCyPUGKa/JfOxl4WdOWnX9teGSUdz56RCy6IGUB82n37W61a0MUgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164829; c=relaxed/simple;
	bh=rkdmpgRa8JG8drr2B7S+0LqEQWa376GQaCUb5ljMCsA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UzSMT+jvYikOh/BhEKVJsRjWXcYy9Xhs4vMV96CLywO7Yzvh8haIJVyFles4EAePkglfqMYAek2bptFLxq+DI2W6AxGt5HWj5Jfppmm6gHcIKDFltw4PzIIW+L03jLTQRSvz5k/XdI1tGxWOJZe8gWq3OFmB9NSB9dBzlKFM6Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9vfLw74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E60E6C433C7;
	Wed,  3 Apr 2024 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164828;
	bh=rkdmpgRa8JG8drr2B7S+0LqEQWa376GQaCUb5ljMCsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N9vfLw74MM0QZMKm4iiH6vdcoK1CnDYdW3YC7vYu3BFYiv0m6Y4G/Q7d8w7yk4Ote
	 HRWYkVElMcb3pbxYzbCS9PjH37z5I40cE4YiIhGy09RUUGw9jnnUfHqTrCup3D+mQg
	 DHexLQBswdMq0HS1oJPAVmtt1rC2Wrt5x1fvxm8f+T85a8UPwbInawcafapKEh1xzi
	 W/6u/vHZFGwj9m82RvK0K19OSsh5q8f6qxS0rFusw/96ZmoYD8KyQ9QBmTPplkfZKf
	 zyxW+y+2uNTPTg1Jdx0Z7tMC09gj+QfyGbhnyalGwSeIhqF5VFNsmKuY18G5a5yOLv
	 mHLnvqd2y8SGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9DFCC43168;
	Wed,  3 Apr 2024 17:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] man: fix brief explanation of `ip netns attach NAME
 PID`
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171216482888.20023.11202781934775693678.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 17:20:28 +0000
References: <20240402020819.28433-3-public@yusuke.pub>
In-Reply-To: <20240402020819.28433-3-public@yusuke.pub>
To: Yusuke Ichiki <public@yusuke.pub>
Cc: netdev@vger.kernel.org, mcroce@redhat.com, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue,  2 Apr 2024 11:08:17 +0900 you wrote:
> Rewrite the explanation as it was duplicated with that of
> `ip netns add NAME`.
> 
> Signed-off-by: Yusuke Ichiki <public@yusuke.pub>
> ---
>  man/man8/ip-netns.8.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2] man: fix brief explanation of `ip netns attach NAME PID`
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=e67c9a73532a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



