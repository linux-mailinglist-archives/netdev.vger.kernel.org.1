Return-Path: <netdev+bounces-177469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B5EA7046F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4F8164CE5
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91525B67E;
	Tue, 25 Mar 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWo9jBM/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C98F9E6
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914806; cv=none; b=hW1u4BmPJntZ3tYc9Og4ZyxDvr7fs44ARskHSGijYIpMhJ5ZnJOO3FAjSot8BM9pOYpjntJZA6Tc5JO1pumYrbABEN6o3SHZwUaNgcTfJGqMj3wrKGfiyiczIeqPfQ374nR4ePj2JUmPERlEwzvJlp3RHI7SQlKSagc94CQ2NP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914806; c=relaxed/simple;
	bh=jsoExR2W307fXfWxXWFw5WJsV6WjK+gYE20u6UFXm5M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iS1sqmZmk6jr2jxrCTP06yMPeLVrERpYw70oTFlYRq8pH8CrKCWUi66pKfBUBe2ckqA1psslMmvpKelHUsB+JgsHh+wp3yXbyjNQmGI38wlWfnKBgS93E21IM2WRaAn22XxKCJUlZb7YXlf0GWPPNpJq5+YVMpd10Sd9+Cc+9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWo9jBM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EABEC4CEEA;
	Tue, 25 Mar 2025 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742914805;
	bh=jsoExR2W307fXfWxXWFw5WJsV6WjK+gYE20u6UFXm5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BWo9jBM/xsThxTKnn9470MKBCvnDWy7fck463yzDhvlkZY2YrIbiJooamGIaXTqlW
	 hjPmplKJc4g5xTVEV7oXcXW5/6NOCgVl3oqgOMjErRrnVDHWEr9umjNjJCzPaMoj9W
	 opMbzd7FER3nfV+M1p26I2zaVxqdozYYx8oyhEB7W2j5GzwMScxk4o30yuOmC6w8/l
	 KzkmOxKZPzr3k2FaWv3t1nGFsLTs8zVLxihfrzxgJfuDNbCeSUnwTXaNc+VMXpPfbM
	 Ztz8+OFdU/Ay4qFtTjAF3ZPktr8Q8Fj/zb/Fb5kFnE3ydDXm3W1raLrQN/fiQBfm05
	 PX0RKs+2F1PTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE06B380CFE7;
	Tue, 25 Mar 2025 15:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/7] nexthop: Convert RTM_{NEW,DEL}NEXTHOP to
 per-netns RTNL.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291484149.606159.6236001825907425018.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:00:41 +0000
References: <20250319230743.65267-1-kuniyu@amazon.com>
In-Reply-To: <20250319230743.65267-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Mar 2025 16:06:45 -0700 you wrote:
> Patch 1 - 5 move some validation for RTM_NEWNEXTHOP so that it can be
> called without RTNL.
> 
> Patch 6 & 7 converts RTM_NEWNEXTHOP and RTM_DELNEXTHOP to per-netns RTNL.
> 
> Note that RTM_GETNEXTHOP and RTM_GETNEXTHOPBUCKET are not touched in
> this series.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/7] nexthop: Move nlmsg_parse() in rtm_to_nh_config() to rtm_new_nexthop().
    https://git.kernel.org/netdev/net-next/c/ec8de7544778
  - [v2,net-next,2/7] nexthop: Split nh_check_attr_group().
    https://git.kernel.org/netdev/net-next/c/9b9674f3e73a
  - [v2,net-next,3/7] nexthop: Move NHA_OIF validation to rtm_to_nh_config_rtnl().
    https://git.kernel.org/netdev/net-next/c/caa074573ca0
  - [v2,net-next,4/7] nexthop: Check NLM_F_REPLACE and NHA_ID in rtm_new_nexthop().
    https://git.kernel.org/netdev/net-next/c/53b18aa998b7
  - [v2,net-next,5/7] nexthop: Remove redundant group len check in nexthop_create_group().
    https://git.kernel.org/netdev/net-next/c/b6af3890574a
  - [v2,net-next,6/7] nexthop: Convert RTM_NEWNEXTHOP to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/f5fabaff86cb
  - [v2,net-next,7/7] nexthop: Convert RTM_DELNEXTHOP to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/29c8e323320f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



