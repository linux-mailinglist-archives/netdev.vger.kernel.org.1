Return-Path: <netdev+bounces-119954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F37957AAA
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00DB2845B1
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A405C17BD3;
	Tue, 20 Aug 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9GHCh50"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7BC17BA4
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115636; cv=none; b=oRBxezFEJPtDjjdlUXOHjy7cajc56ljFbQeCycjgpO7KQU0MJ7k3H+T9sJbiv14RmZO/+d/7jFdNm0CKB65CB2EEaOiwsPbxIo5jC6Siq132w/EpxUJSMxnOyYmcaVLqRvyyEzAihsleht4CaZ2MsfbmWNWo9sw/+8NcuRqFcpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115636; c=relaxed/simple;
	bh=3YNkSEFXMEdZJKC63QUoK7Y8uPGKZZsVH2otOcRaveE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=evxsw6XpjIzyRPJWPacdbZEo8MVHcTRtEM2dXmvoWi6mH8kDBSsEwiXZSnvS2GLBw8NrhAwaKvDoQzUVx5hXWfD1XIo9E93zm3jeTaGbiYwGCCyNOmZnJ5qPXTIbqnjwMQz/ZWSiPK2Ew2Hcrp0v7NUbrsCYZ+zCGh1S0pPR4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9GHCh50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB2AC32782;
	Tue, 20 Aug 2024 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724115636;
	bh=3YNkSEFXMEdZJKC63QUoK7Y8uPGKZZsVH2otOcRaveE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u9GHCh50sYyENv9G1cmaYy4gJzl+ICFXuUSqtbEaPoiccsnsb3HLHjcrGV7m7kU4w
	 WdmEJlRYYXRdlUTAYlry4m0OwfNz8rsd4Vnb+mGTb2sue8zUrpk4xoWPO/gu5BK3TR
	 uJPWZVUPx+9pdDu62CYxYCXRv4HEER66wX/GA+39ficdZ87cHDvs06BDRG0U4nl1nM
	 Wi1SMjtksgsfUzttddmKHYYy00q2vAWpf2knw5JO+GIy2/kLkS4t5dgeQ8lF6iWBTo
	 3BYpUgKuxA4fSMW0Bh4zWNEtfcdRm75FUOpUU+KDXO9mF0wwatz1DAJaJqLTEd+jV6
	 WhPG1WRvQCjSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCF33823271;
	Tue, 20 Aug 2024 01:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp_metrics: use netlink policy for IPv6 addr len
 validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172411563525.698489.6202321790480313006.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 01:00:35 +0000
References: <20240816212245.467745-1-kuba@kernel.org>
In-Reply-To: <20240816212245.467745-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Aug 2024 14:22:44 -0700 you wrote:
> Use the netlink policy to validate IPv6 address length.
> Destination address currently has policy for max len set,
> and source has no policy validation. In both cases
> the code does the real check. With correct policy
> check the code can be removed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp_metrics: use netlink policy for IPv6 addr len validation
    https://git.kernel.org/netdev/net-next/c/a2901083b149

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



