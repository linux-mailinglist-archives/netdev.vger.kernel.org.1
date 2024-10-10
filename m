Return-Path: <netdev+bounces-134249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B26399884D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C231C20748
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85721CB503;
	Thu, 10 Oct 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqg5zCLt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2581CB311
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568229; cv=none; b=QyE5P18gtB+nzPthRLFZxvQ3Grio494hT40IDtGB9o0l0i25AeIxZfyzuwcLw8/U6OEp0X2TRWmfAN8DNU4BZw0riGT0h6Xn6kUsrlPtAZm28XKa6pPm/+9/Yk1npKe4K14Mp7NUpZb51GfoqbSYbj3asNvWS3/S3x81xKnByk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568229; c=relaxed/simple;
	bh=XpD9SgGI7cYInuVdLLnVIpI+duJPAFmOL75IO8lxJ60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OxN5wPaP33ifmkzcFQRWli7m99qVQpNFhQOebDuTHMhifOO2g1YJPRdbg8riG/4REVSWLSa6Nn6Pf8fKEGnPmAYOFSmOLZPNIsJtqlOrSmG4Dt8A7E8nx4UBk6ZQQPrS3ZBBDVkYAhbMSmKdDb9vXLrdEO5AC/+l40ufx6O7aSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqg5zCLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B81C4CECC;
	Thu, 10 Oct 2024 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728568229;
	bh=XpD9SgGI7cYInuVdLLnVIpI+duJPAFmOL75IO8lxJ60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pqg5zCLt+f218fKvwgEYfxMSy1EAEIPX4g7yf6ZFs75B/c8gum3nbSawt6NsnwOc/
	 7g9HfAZvwBfKi3EeeI5hN72OpnOsXn03Y2N4yKY9M21k3m5gCOyTiXjLAYEGnHd/sI
	 Qraine308p16lugVhvPtJmKuO97Zlv0XiyDRC4F6mptgzHGJo0LDOi6hZLx1M6rxHF
	 J44G2riuvS+uNQS7YO6E5xgFcSgIO+ipMkk+qFalHrt1CiAqv/05nH3UdWas78lKUM
	 sHW6BiPwMa53mLqPHc2DlmzucsplWxcQxkeeADWpF8xUTZog/Cy7hmeECRWJkFR4eJ
	 7yWCxLGjIHLmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF6783803263;
	Thu, 10 Oct 2024 13:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net 0/6] rtnetlink: Handle error of rtnl_register_module().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172856823335.2029758.7538372853557988918.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 13:50:33 +0000
References: <20241008184737.9619-1-kuniyu@amazon.com>
In-Reply-To: <20241008184737.9619-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 8 Oct 2024 11:47:31 -0700 you wrote:
> While converting phonet to per-netns RTNL, I found a weird comment
> 
>   /* Further rtnl_register_module() cannot fail */
> 
> that was true but no longer true after commit addf9b90de22 ("net:
> rtnetlink: use rcu to free rtnl message handlers").
> 
> [...]

Here is the summary with links:
  - [v4,net,1/6] rtnetlink: Add bulk registration helpers for rtnetlink message handlers.
    https://git.kernel.org/netdev/net/c/07cc7b0b942b
  - [v4,net,2/6] vxlan: Handle error of rtnl_register_module().
    https://git.kernel.org/netdev/net/c/78b7b991838a
  - [v4,net,3/6] bridge: Handle error of rtnl_register_module().
    https://git.kernel.org/netdev/net/c/cba5e43b0b75
  - [v4,net,4/6] mctp: Handle error of rtnl_register_module().
    https://git.kernel.org/netdev/net/c/d51705614f66
  - [v4,net,5/6] mpls: Handle error of rtnl_register_module().
    https://git.kernel.org/netdev/net/c/5be2062e3080
  - [v4,net,6/6] phonet: Handle error of rtnl_register_module().
    https://git.kernel.org/netdev/net/c/b5e837c86041

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



