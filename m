Return-Path: <netdev+bounces-34345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492BD7A35AF
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 15:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0241C20889
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DF44A24;
	Sun, 17 Sep 2023 13:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7746A8
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 13:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66985C433C9;
	Sun, 17 Sep 2023 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694957427;
	bh=RUp5htXTF83Ma9g5k1333FmkT6VuBh0hcpglLYiV8uo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lyutH2AR5YzAyab/NxQOhtKBJQmsZmU4z8EVTZA1qsVATIbZTtGdx8B5Ysx14Pshi
	 ypw/2v6wimj0FltQt7id2JkSzl049CP5zWjvMe2Zp2JpgcRd88gPWan1TS5EF3b8Ko
	 CHXUdZXv06oAqnPmidk/p3axZZct6T4nF05HIx/JBEoOsgDLphp/IulPflucJ6pJI3
	 h8S9YmEaKAvPgJwchK5QT2Gzl3/CcVDZlPprk5Kx6gouovWX4nYEeycrX8lmrIrH7Y
	 q30uTuZBaDkOPKt3ycxwHBOk1pB/+2SyiM0QsUPmyHEFVxWwV2uczT/Ig+9kFge6DQ
	 5cu3mPXO0DhYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49F6BE26887;
	Sun, 17 Sep 2023 13:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v2 00/12] expose devlink instances relationships
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169495742729.23476.3592672683628176390.git-patchwork-notify@kernel.org>
Date: Sun, 17 Sep 2023 13:30:27 +0000
References: <20230913071243.930265-1-jiri@resnulli.us>
In-Reply-To: <20230913071243.930265-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, idosch@nvidia.com,
 petrm@nvidia.com, jacob.e.keller@intel.com, moshe@nvidia.com,
 shayd@nvidia.com, saeedm@nvidia.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Sep 2023 09:12:31 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently, the user can instantiate new SF using "devlink port add"
> command. That creates an E-switch representor devlink port.
> 
> When user activates this SF, there is an auxiliary device created and
> probed for it which leads to SF devlink instance creation.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/12] devlink: move linecard struct into linecard.c
    https://git.kernel.org/netdev/net-next/c/d0b7e990f760
  - [net-next,v2,02/12] net/mlx5: Disable eswitch as the first thing in mlx5_unload()
    https://git.kernel.org/netdev/net-next/c/85b47dc40bbc
  - [net-next,v2,03/12] net/mlx5: Lift reload limitation when SFs are present
    https://git.kernel.org/netdev/net-next/c/602d61e307ac
  - [net-next,v2,04/12] devlink: put netnsid to nested handle
    https://git.kernel.org/netdev/net-next/c/ad99637ac92d
  - [net-next,v2,05/12] devlink: move devlink_nl_put_nested_handle() into netlink.c
    https://git.kernel.org/netdev/net-next/c/af1f1400af02
  - [net-next,v2,06/12] devlink: extend devlink_nl_put_nested_handle() with attrtype arg
    https://git.kernel.org/netdev/net-next/c/1c2197c47a93
  - [net-next,v2,07/12] devlink: introduce object and nested devlink relationship infra
    https://git.kernel.org/netdev/net-next/c/c137743bce02
  - [net-next,v2,08/12] devlink: expose peer SF devlink instance
    https://git.kernel.org/netdev/net-next/c/0b7a2721e36c
  - [net-next,v2,09/12] net/mlx5: SF, Implement peer devlink set for SF representor devlink port
    https://git.kernel.org/netdev/net-next/c/ac5f395685bd
  - [net-next,v2,10/12] devlink: convert linecard nested devlink to new rel infrastructure
    https://git.kernel.org/netdev/net-next/c/9473bc0119e7
  - [net-next,v2,11/12] devlink: introduce possibility to expose info about nested devlinks
    https://git.kernel.org/netdev/net-next/c/c5e1bf8a51cf
  - [net-next,v2,12/12] net/mlx5e: Set en auxiliary devlink instance as nested
    https://git.kernel.org/netdev/net-next/c/6c75258cc220

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



