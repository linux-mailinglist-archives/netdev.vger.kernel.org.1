Return-Path: <netdev+bounces-30258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA07869DF
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 10:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BA31C20DE0
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556ECAD4A;
	Thu, 24 Aug 2023 08:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B15696
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 787C2C433C9;
	Thu, 24 Aug 2023 08:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692865223;
	bh=SgeGitZAeoqW1XWPw4cFq2CrnQFcxKuYCYLOXfLHGgw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EG41xguoLvvEJPsy+z5tphWua+oVUh7oQM4ebmHhViw2N0ei5fNhYeUf8xt50ufZ+
	 o1w//L7lzjftKvzSNs1JZsQjMfE14b6ZAGcxSooL8axvsz8JpGSgouFWVXZMuNENpV
	 UEAK3XSO2kDZGQeOLvE3OaQ/QxF7ZObFUVzDPue/HVV56F/OeUJpFhbDSme+KSvUu6
	 N5v/4BnUn9v4XsiL4s+hd8EqZzThzl3o/sTi0TXWVZIcbGWd2j59E2q+j2XupaFROf
	 9XIwJ56+G2CdopyezqYXYC8WzRfsYySTCmojNtIcg+Czsla9QPwAhABX+fYCZV9DYv
	 7+O7Vy/rOhmHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59C57E33094;
	Thu, 24 Aug 2023 08:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net 0/3] fix macvlan over alb bond support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169286522336.14292.14364639578541758706.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 08:20:23 +0000
References: <20230823071907.3027782-1-liuhangbin@gmail.com>
In-Reply-To: <20230823071907.3027782-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, liali@redhat.com,
 jiri@nvidia.com, razor@blackwall.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 23 Aug 2023 15:19:03 +0800 you wrote:
> Currently, the macvlan over alb bond is broken after commit
> 14af9963ba1e ("bonding: Support macvlans on top of tlb/rlb mode bonds").
> Fix this and add relate tests.
> 
> Hangbin Liu (3):
>   bonding: fix macvlan over alb bond support
>   selftest: bond: add new topo bond_topo_2d1c.sh
>   selftests: bonding: add macvlan over bond testing
> 
> [...]

Here is the summary with links:
  - [PATCHv3,net,1/3] bonding: fix macvlan over alb bond support
    https://git.kernel.org/netdev/net/c/e74216b8def3
  - [PATCHv3,net,2/3] selftest: bond: add new topo bond_topo_2d1c.sh
    https://git.kernel.org/netdev/net/c/27aa43f83c83
  - [PATCHv3,net,3/3] selftests: bonding: add macvlan over bond testing
    https://git.kernel.org/netdev/net/c/246af950b940

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



