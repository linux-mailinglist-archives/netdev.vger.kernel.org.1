Return-Path: <netdev+bounces-189221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0C4AB12C3
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB021625C6
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C3728EA72;
	Fri,  9 May 2025 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3YtDnK8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B828936C
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791993; cv=none; b=Z0ZKOpAumorUHecksdRmN4dj1dstO1HyacYW8T8hpLyjo0hV9MUvx/EL49+xSGbWI8Zb9XuQa0tAh64vlapDX0S1wehmgWNLj/uoZHpb4qfXCQvVHSFIw5J9pTy9XbTulAfxaW3DqBLH5bv+DZl+cck0FFtc7u391DIqKKYtTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791993; c=relaxed/simple;
	bh=YRT/UvrqtSJEk0b77dI5YZ6zkRh/hRLNqNPLgIBbnYk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YTeP/lYUluNAsauHQqj+fq3VaXPP+oVB6ybCYmhRLvbILa0SY8eT+lAQHUe5iv1VUCmRl6g7rtEz+jQRbNX7Y6cXDcKnM1AUe0UjicLLMQopGvyZLtsMppEHJbOoVjzZc2pfWgXiqd6ed2IGJLt+dpv1wu01y8ts7sEkbL3gtQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3YtDnK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2883C4CEE4;
	Fri,  9 May 2025 11:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746791992;
	bh=YRT/UvrqtSJEk0b77dI5YZ6zkRh/hRLNqNPLgIBbnYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D3YtDnK8OrQp/lS4uNbPydacY6wzAwhwlLTB9f+kokidgE8uB2JV6f9C4G3qJFx+H
	 aIAOee+6i1QpGKr20nGoiwEpZoh46fZ1/5ysHHXur5koeAN4THkV+NwrCxXxtkSZ3U
	 QO+OOOFp9+FvwiHTMedikJAK/BK5OF7VmzsbTeYFbODJ6K4MNV7T54FL+Bu7a+0UCN
	 b/o3Fjq7S3O7jLZkYUnyNO4szK8hsDh68k9QusfHfCoplV8tShlh/iLKBn0BcLOj4p
	 QOGcEUom/05OI+kgfzKCrkpFKCXBmtE7jD1Y3Gsnwq6MqEnp6Ckf97ofi0dd/BONGj
	 gSeZTBcHIf+vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDDC3806651;
	Fri,  9 May 2025 12:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net v2 0/2] net_sched: Fix gso_skb flushing during qdisc
 change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174679203049.3589328.8543916542770155564.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 12:00:30 +0000
References: <20250507043559.130022-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250507043559.130022-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
 willsroot@protonmail.com, savy@syst3mfailure.io

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  6 May 2025 21:35:57 -0700 you wrote:
> This patchset contains a bug fix and its test cases, please check each
> patch description for more details. To keep the bug fix minimum, I
> intentionally limit the code changes to the cases reported here.
> 
> ---
> v2: added a missing qlen--
>     fixed the new boolean parameter for two qdiscs
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net_sched: Flush gso_skb list too during ->change()
    https://git.kernel.org/netdev/net/c/2d3cbfd6d54a
  - [net,v2,2/2] selftests/tc-testing: Add qdisc limit trimming tests
    https://git.kernel.org/netdev/net/c/16ce349b1506

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



