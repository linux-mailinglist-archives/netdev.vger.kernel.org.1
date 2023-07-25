Return-Path: <netdev+bounces-20724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB547760C62
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7687B281613
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8702512B92;
	Tue, 25 Jul 2023 07:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575898F74
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB4BEC433C9;
	Tue, 25 Jul 2023 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690271420;
	bh=DLfY0KhdXnBd4btxAeRem8JBH4vQXhENyG+d15fUnAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qjzKhFsRLDQ5ZMVdbLzqdHqBnp2vBNaZJvY5HToo8isT/ddaABG1FmgJCnes3Dk9o
	 BvPTWuTZeltumAZqz8y6iI7wNsJ/ZewU4A5PJ7YePAsRC/JB6ppeq+/go7m/9IngeJ
	 4KXZqdjAFNDWESfp4m4Q8O8Db7wHrVGT8R3Z6w3x24Doj1woWNWJOYJXC/0i4HG+xE
	 JxWkG+6GF+SdN0BQUmxiTlTGWm3Fb/NG/ihcDUJ1NQukY0YcLmhRRz7URmG5YjKYpH
	 C7/+07J/TofRyMf2VrTNPiSp+6jtG527B7cG+lUsVNgWHOFr//t6JW1b5lQ3cmbzCk
	 qrD8V5jDu+OFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A21DDC73FE2;
	Tue, 25 Jul 2023 07:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 net 0/2] Fix up dev flags when add P2P down link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169027142066.10948.2104712163509922940.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 07:50:20 +0000
References: <20230721040356.3591174-1-liuhangbin@gmail.com>
In-Reply-To: <20230721040356.3591174-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, liali@redhat.com,
 jiri@nvidia.com, razor@blackwall.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 21 Jul 2023 12:03:54 +0800 you wrote:
> When adding p2p interfaces to bond/team. The POINTOPOINT, NOARP flags are
> not inherit to up devices. Which will trigger IPv6 DAD. Since there is
> no ethernet MAC address for P2P devices. This will cause unexpected DAD
> failures.
> 
> v4: Just reset the team flag, not call ether_setup, as Paolo pointed.
> v3: add function team_ether_setup to reset team back to ethernet. Thanks Paolo
> v2: Add the missed {} after if checking. Thanks Nikolay.
> 
> [...]

Here is the summary with links:
  - [PATCHv4,net,1/2] bonding: reset bond's flags when down link is P2P device
    https://git.kernel.org/netdev/net/c/da19a2b967cf
  - [PATCHv4,net,2/2] team: reset team's flags when down link is P2P device
    https://git.kernel.org/netdev/net/c/fa532bee17d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



