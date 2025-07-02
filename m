Return-Path: <netdev+bounces-203075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E4BAF0776
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368747A8D40
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36107260C;
	Wed,  2 Jul 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv3urIYp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9027172601
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751417391; cv=none; b=MEtwMPqOPpVk3z7Wz1llzbH+IayksIfl4GRYsHu4FwIP/hkKuR4AM49UGMZxeKBOn89tBBxUEnKdxvsJ2QJPdiZJtw8u+ZLFOKkqWptxvl9PjgU/l5rVx1MNAaq7QGHjMNZpni6N+hrebIVc0ixkYxayeIfFJH4O3Y+UiJH7Oxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751417391; c=relaxed/simple;
	bh=OuFszaUxmd6wOtsLXvbLez2Zt1dFucHr8Rb2i9rUm/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RY4W27svHU2g4nfeURjQUN5P8wgsH5dc3JCBxBVh02jBJlzXrzHalcdVCL+gAegH98WZXEPdN6YX5jbUr/5MfebJ12FX13ddZZ0SPR8SE4C4ZveyiWCEaBkMdx+iXB7yhQz8tRvpKlPPuqQuI3v/kcMSgpFn5mx9LxcbfnxwpOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv3urIYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302F9C4CEEB;
	Wed,  2 Jul 2025 00:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751417391;
	bh=OuFszaUxmd6wOtsLXvbLez2Zt1dFucHr8Rb2i9rUm/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hv3urIYpDpL3RoC0dZLPh1Nz6UiKB8sbrL3xTHcviekafyA4MyLZ249BZ/IE3bvUz
	 BTNFP3Wq3BuuwuP2l5td0zSDmRQTONVs16ajOKe45OjL/C3SsHkqkf1DD/fMP5WeyJ
	 9T14T8gIDVF5HTmwS2ySvkKN46+Nsmz6e1T0RW7zX8Pj1OK9u6cTIAPwZnsfAM8upZ
	 s/dEhn03Qa7LpCb04SabwCN1KVeNzbq6tu/hmxZfuz54fVVWHmljdHNzEKIh9zoXZf
	 BMDe5w14/fMaCb2iEX9ynJkxQvnYp+3yBBLdZsHetoL3NE6Rvldgc2/77HJYhAVzRz
	 pj0G4xEVPuR/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C42383BA06;
	Wed,  2 Jul 2025 00:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] ip6_tunnel: enable to change proto of fb
 tunnels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175141741599.160580.2766598146044019008.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 00:50:15 +0000
References: <20250630145602.1027220-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20250630145602.1027220-1-nicolas.dichtel@6wind.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Jun 2025 16:54:54 +0200 you wrote:
> This is possible via the ioctl API:
> > ip -6 tunnel change ip6tnl0 mode any
> 
> Let's align the netlink API:
> > ip link set ip6tnl0 type ip6tnl mode any
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] ip6_tunnel: enable to change proto of fb tunnels
    https://git.kernel.org/netdev/net-next/c/0341e3472736

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



