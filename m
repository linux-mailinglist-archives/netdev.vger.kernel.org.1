Return-Path: <netdev+bounces-105683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265DE912486
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5F2B21238
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E618B172BC7;
	Fri, 21 Jun 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc7Ukw11"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24522629D
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718970628; cv=none; b=VHMqUrOjs59NPLgzm7YZlT6BYI0sNMSQeeo6i+TChkVqtXfE5JfFtJzGmDlo+1DZwx0GVnO6V3mGwHd6K/xelX3evZ9lUMgVU7VqB3i3+RvFSaJjh8ySxtFbeyXmzvp1Mj4NWQB4k9jIZ+8u8Pu0EfXmhk2nTd5HNW1JOlM/BI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718970628; c=relaxed/simple;
	bh=mtSkCm3pVNKoaKf0yCxU6DuM3QUWxp0mPY5CqzcHZhk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sTH5WJtLYY7dkvperJkQ9hCVC55rgNcURSz7whSBBrmtX45sNS56E+h9OrgUzZMWqxd8oDKXe4hyRm1ecslddFweR+OpiNrn3uj6sxviX5/OhvAm+DQkz5FW1Eo6AKRB95M82bUwSA7fHKVr8ethmAi4IdsRRs+KntERD3G+zSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc7Ukw11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5078CC4AF08;
	Fri, 21 Jun 2024 11:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718970628;
	bh=mtSkCm3pVNKoaKf0yCxU6DuM3QUWxp0mPY5CqzcHZhk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jc7Ukw11A2X7JuyseN38satiT3Yl5XHLYZu6iQaklrq1c3XY94P32PMjzQMl/7RrU
	 PlXJW9wWF+lqkXS6gL1fxmS/Qz5RcBb8H40HpBdrgM7E2lpezg4hR5dPyxV5meyaUg
	 DoMlKRXQu7GRku7bYbcB3zdz0t5PT8rqyaJyk3wXp4IQvc8E+xGNtcXzvsYF6bF+1D
	 jp3sNoT67vUnFhbJbP49YpYCTsvy3SxTnof+fUByWX3lkB4m1YO1/Orhlto0JwP09p
	 65hVJVVBCyNZndLTlosnR6EzrbGG5UBoPt8OOIjfuEcBMxGTtDTpIt/+/oWofZmlcQ
	 Uf+XYp68FZrbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BA0BE7C4C5;
	Fri, 21 Jun 2024 11:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: remove drivers@pensando.io from MAINTAINERS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171897062824.15244.3361751600433853269.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 11:50:28 +0000
References: <20240620215257.34275-1-shannon.nelson@amd.com>
In-Reply-To: <20240620215257.34275-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
 drivers@pensando.io

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jun 2024 14:52:57 -0700 you wrote:
> Our corporate overlords have been changing the domains around
> again and this mailing list has gone away.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net] net: remove drivers@pensando.io from MAINTAINERS
    https://git.kernel.org/netdev/net/c/2490785ee778

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



