Return-Path: <netdev+bounces-222384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3272DB5402E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2ECA7C3132
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C71E1DE2D8;
	Fri, 12 Sep 2025 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICvP7LUe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237A21DD889;
	Fri, 12 Sep 2025 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757643023; cv=none; b=pBCPNcVGoiniRKD0ocJAnuxKFI8evbGVkE+OFyv5hwz0ZwY9gykKv8lh+1C1suySEgtcTsKs+pQSG3KJYXjgDO3gXccbtsGIPy18mAxmn48v8k9A4isPP3HGC0MRG8SR+sS7clZLX3RZfSxY1eFtx+3/Cx2wDPQA/25qPg9O8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757643023; c=relaxed/simple;
	bh=992StHu86YNqMKrNCNJriunylnaOI1axD6WSY0XvHjA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eRET/jiys9MIC63TLXUtu/8+nL1w/3CethXBu2tiP4d3XWZ6g3oSot6g+rOrAKYd3BpNOK/XEK1nUWUAp3Zb0A8FHvWkBQ1W+f3Y52zmyhcxkVT2uJjy7YCZ8CbMEXBN3+dFjbpaHxWWJPi8JrH9t3NrjGfWSX0pKXXPIk5o+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICvP7LUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4897C4CEF0;
	Fri, 12 Sep 2025 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757643021;
	bh=992StHu86YNqMKrNCNJriunylnaOI1axD6WSY0XvHjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ICvP7LUeawD3Hzsg8qxZmJRPtehLG2gqxA4dTZoZiFfIZhoO3L+prX3cTPN8T4nkk
	 LYc+1s+8/garBpRge83qN8CAknyk1Yy3ZmHUdjSrDGCwhgbeo1VEHXOb40qEI1tfcR
	 4GyJIbvb8zUHik4XxYCG9cOFDx+kHvXE7Zcn3iTc/iRdx9RIDlHv3GQZj1+0kiAvMZ
	 oqw6NQ7n/TkKiamLxSkBEeCRz+Bh+bkJ34NsF2XTjKE7W//u3gsfShRBVg4PtrdPIG
	 S9Dd2NwKyLkixMPd3umMxbaBdG9TpFRvoXn7PwsmYZtQHblRsEuOpPi6hd5tudRc5c
	 4nWXfIOuhsnHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CF3383BF69;
	Fri, 12 Sep 2025 02:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: devmem: expose tcp_recvmsg_locked errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764302424.2375845.7451787013007501397.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 02:10:24 +0000
References: <20250910162429.4127997-1-sdf@fomichev.me>
In-Reply-To: <20250910162429.4127997-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com, kuniyu@google.com,
 dsahern@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org,
 almasrymina@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Sep 2025 09:24:29 -0700 you wrote:
> tcp_recvmsg_dmabuf can export the following errors:
> - EFAULT when linear copy fails
> - ETOOSMALL when cmsg put fails
> - ENODEV if one of the frags is readable
> - ENOMEM on xarray failures
> 
> But they are all ignored and replaced by EFAULT in the caller
> (tcp_recvmsg_locked). Expose real error to the userspace to
> add more transparency on what specifically fails.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: devmem: expose tcp_recvmsg_locked errors
    https://git.kernel.org/netdev/net-next/c/18282100d704

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



