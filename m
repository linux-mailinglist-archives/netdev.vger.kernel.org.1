Return-Path: <netdev+bounces-57882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E6D81466E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCAE2841C2
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FC81F61E;
	Fri, 15 Dec 2023 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OB5nUvOc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E110E1C2A8
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D8A9C433C9;
	Fri, 15 Dec 2023 11:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702638633;
	bh=uwWZxjzciMiG/CWr8h6enu8Us9pxlvmGkYzop+va1is=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OB5nUvOcp5AGgQuhe9UBZKrkauGyvwKzef3M7u1/ylxtqX+uftUA2YAboiqp0ZWUl
	 Gkta3Ibv7d7QrJIBF7MZ6/Y1sNBXNqxfxj6mp7IP8xJ4w4AVsgxJKQjdYanOs/7KwI
	 pgqGEx3+Iajl6W1N9mx8nz8dCPoFsc+xGWcI7xFsBB5kRUbt1TPiNC9kt/ST652fh4
	 qYhgkc4+hJKLuWr+oaJk1igi94QsV1Z7KxWMNn7yyWDs3q5samiYJw+Tire2pc3cWX
	 mK96XJF/qBMMDGEgRDsHPLQyHP6Q+VSYkyit1A+8lDl4ESigCsHqRzh70bEGYrnO5W
	 U0adhZhn5DiLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53EC3DD4EFD;
	Fri, 15 Dec 2023 11:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: optmem_max changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170263863333.21335.15984199287730287738.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 11:10:33 +0000
References: <20231214104901.1318423-1-edumazet@google.com>
In-Reply-To: <20231214104901.1318423-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, willemb@google.com, almasrymina@google.com,
 wwchao@google.com, asml.silence@gmail.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Dec 2023 10:48:58 +0000 you wrote:
> optmem_max default value is too small for tx zerocopy workloads.
> 
> First patch increases default from 20KB to 128 KB,
> which is the value we have used for seven years.
> 
> Second patch makes optmem_max sysctl per netns.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: increase optmem_max default value
    https://git.kernel.org/netdev/net-next/c/4944566706b2
  - [net-next,2/3] net: Namespace-ify sysctl_optmem_max
    https://git.kernel.org/netdev/net-next/c/f5769faeec36
  - [net-next,3/3] selftests/net: optmem_max became per netns
    https://git.kernel.org/netdev/net-next/c/18872ba8cd24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



