Return-Path: <netdev+bounces-22424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8AF76773A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 22:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152721C2172B
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 20:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24A1C9F5;
	Fri, 28 Jul 2023 20:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DFF1CA0D
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 20:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4B75C433D9;
	Fri, 28 Jul 2023 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690577426;
	bh=HbPUBkSG3JJHYJ6zlE3fW2SYSktLBVUJopKhCsfeaOg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NGMqStBPjzTEqVUnfUySW4qMzXHAfPkvdBL8QY3jgoJlJP96rC+DJIdS3QwFQmrbi
	 yWwAaLwcSgubTxxtvv7Dow/o8qBgKgskWw4hnQM1Afjna94GjfX5E7b1BorXHP9mgk
	 PUgQZRz1G3nQPkTKQqP6mJOEsNAdOQAZ7+Q7y0csk/A7sWdoOLYcYf0EN6xzbhYesA
	 DO54nqekqqQk0R/Wl+Hl/OUpj1Dq30VtIMOn33XjvTKNyJmBdyTs+twgeNOUKbQZ0E
	 vI4qugwuUcFs+IyHkau6ig2vEqINzNaHn3E7dH69cJSJV9HEpR3Y4RF9sS2X8ssTcR
	 p7P9Ts5ohkjGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1B86C64459;
	Fri, 28 Jul 2023 20:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] mlxsw: Avoid non-tracker helpers when holding
 and putting netdevices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169057742578.24995.5339425734617467481.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 20:50:25 +0000
References: <cover.1690471774.git.petrm@nvidia.com>
In-Reply-To: <cover.1690471774.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jul 2023 17:59:18 +0200 you wrote:
> Using the tracking helpers, netdev_hold() and netdev_put(), makes it easier
> to debug netdevice refcount imbalances when CONFIG_NET_DEV_REFCNT_TRACKER
> is enabled. For example, the following traceback shows the callpath to the
> point of an outstanding hold that was never put:
> 
>     unregister_netdevice: waiting for swp3 to become free. Usage count = 6
>     ref_tracker: eth%d@ffff888123c9a580 has 1/5 users at
> 	mlxsw_sp_switchdev_event+0x6bd/0xcc0 [mlxsw_spectrum]
> 	notifier_call_chain+0xbf/0x3b0
> 	atomic_notifier_call_chain+0x78/0x200
> 	br_switchdev_fdb_notify+0x25f/0x2c0 [bridge]
> 	fdb_notify+0x16a/0x1a0 [bridge]
> 	[...]
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] mlxsw: spectrum: Drop unused functions mlxsw_sp_port_lower_dev_hold/_put()
    https://git.kernel.org/netdev/net-next/c/569f98b36b38
  - [net-next,2/7] mlxsw: spectrum_nve: Do not take reference when looking up netdevice
    https://git.kernel.org/netdev/net-next/c/16f8c846cd6f
  - [net-next,3/7] mlxsw: spectrum_switchdev: Use tracker helpers to hold & put netdevices
    https://git.kernel.org/netdev/net-next/c/1ae489ab43e0
  - [net-next,4/7] mlxsw: spectrum_router: FIB: Use tracker helpers to hold & put netdevices
    https://git.kernel.org/netdev/net-next/c/deeaa3716f4f
  - [net-next,5/7] mlxsw: spectrum_router: hw_stats: Use tracker helpers to hold & put netdevices
    https://git.kernel.org/netdev/net-next/c/b17b2d57b7c1
  - [net-next,6/7] mlxsw: spectrum_router: RIF: Use tracker helpers to hold & put netdevices
    https://git.kernel.org/netdev/net-next/c/d0e0e880122f
  - [net-next,7/7] mlxsw: spectrum_router: IPv6 events: Use tracker helpers to hold & put netdevices
    https://git.kernel.org/netdev/net-next/c/cb2116204169

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



