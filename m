Return-Path: <netdev+bounces-139881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB18A9B4823
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCBE280941
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8F203715;
	Tue, 29 Oct 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNaE+Mra"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF97464
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200828; cv=none; b=opaCQXW3GAxVPePNjwLvTQp+RWgtc2A4S8h+tHAruim7Xs8V2NbJdl9KPDa37QLd0tMzloRqz7d8tQN+eFhzK+Ysz7UU+wbUVZjxSb5L2wYlYLVgR3lnXgTMzKpzJD9tmSEdAJFv0jXSiJi0q5vRdhODe+xM1MkI17iWXaUuXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200828; c=relaxed/simple;
	bh=Im8d6okEgcvW/t6Nfr6tHISJed3Iu4uvNjS80CPa9A8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N8EzorTRFM4zq2w8a4SnomgUkpUVUZpipu/UlGej8dRaz14jaSpWUs4bmmaQ1JjK0u7p/iNWsX0FOVkQtf9RLRrkmWryS/oc+4VMG/vLChjVjY2qcJuyLaWeEHnI69SCA6mLObCydGQ4k9EgY9tcuYt02+Pn1dIhIZPPDuNh8TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNaE+Mra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B007EC4CEE3;
	Tue, 29 Oct 2024 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730200827;
	bh=Im8d6okEgcvW/t6Nfr6tHISJed3Iu4uvNjS80CPa9A8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TNaE+MraNvS4czczsYB54XrsvBjF7XTL/Z1UlYbIzS+0hB4wBeRmDv55LFbTYo7Jc
	 7j/gRRPrR6eudo7whkCt84H2f3QrKR1wHdX+aPRLZ8wSpOI5cI8zgBOHn+AK4wNrP6
	 BH3MWFYyVatuekogFy+7jFOkv2KL661rbnUbryQHINvGnbMrPAsMfjjtEjwwIeZOGw
	 jPVNqWWhH3KGXRcD+npEVD9OOs69WRJkJY6RxAoc5+1og7oYNcPATGb23PkE8Zhw8R
	 apHcDhGgAx0JSVz9AiCiktCnt1BqDf3Z8AlUGGgfVlPUtgDA3tWYzJB9A+fsgG90s+
	 tI+7Azj1leatQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7201B380AC00;
	Tue, 29 Oct 2024 11:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 00/12] ipv4: Convert RTM_{NEW,DEL}ADDR and more to
 per-netns RTNL.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173020083526.660943.8648689683935289296.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 11:20:35 +0000
References: <20241021183239.79741-1-kuniyu@amazon.com>
In-Reply-To: <20241021183239.79741-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Oct 2024 11:32:27 -0700 you wrote:
> The IPv4 address hash table and GC are already namespacified.
> 
> This series converts RTM_NEWADDR/RTM_DELADDR and some more
> RTNL users to per-netns RTNL.
> 
> 
> Changes:
>   v2:
>     * Add patch 1 to address sparse warning for CONFIG_DEBUG_NET_SMALL_RTNL=n
>     * Add Eric's tags to patch 2-12
> 
> [...]

Here is the summary with links:
  - [v1,net-next,01/12] rtnetlink: Make per-netns RTNL dereference helpers to macro.
    https://git.kernel.org/netdev/net-next/c/9cb7e40d388d
  - [v1,net-next,02/12] rtnetlink: Define RTNL_FLAG_DOIT_PERNET for per-netns RTNL doit().
    https://git.kernel.org/netdev/net-next/c/26d8db55eeac
  - [v1,net-next,03/12] ipv4: Factorise RTM_NEWADDR validation to inet_validate_rtm().
    https://git.kernel.org/netdev/net-next/c/2d34429d14f9
  - [v1,net-next,04/12] ipv4: Don't allocate ifa for 0.0.0.0 in inet_rtm_newaddr().
    https://git.kernel.org/netdev/net-next/c/abd0deff03d8
  - [v1,net-next,05/12] ipv4: Convert RTM_NEWADDR to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/487257786b71
  - [v1,net-next,06/12] ipv4: Use per-netns RTNL helpers in inet_rtm_newaddr().
    https://git.kernel.org/netdev/net-next/c/d4b483208b26
  - [v1,net-next,07/12] ipv4: Convert RTM_DELADDR to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/4df5066f079c
  - [v1,net-next,08/12] ipv4: Convert check_lifetime() to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/c350c4761e7f
  - [v1,net-next,09/12] rtnetlink: Define rtnl_net_trylock().
    https://git.kernel.org/netdev/net-next/c/d1c81818aa22
  - [v1,net-next,10/12] ipv4: Convert devinet_sysctl_forward() to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/77453d428d4c
  - [v1,net-next,11/12] ipv4: Convert devinet_ioctl() to per-netns RTNL except for SIOCSIFFLAGS.
    https://git.kernel.org/netdev/net-next/c/88d1f8770690
  - [v1,net-next,12/12] ipv4: Convert devinet_ioctl to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/7ed8da17bfb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



