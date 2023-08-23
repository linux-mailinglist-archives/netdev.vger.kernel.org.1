Return-Path: <netdev+bounces-29838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6914784E4F
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 03:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C96B28110F
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9121381;
	Wed, 23 Aug 2023 01:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ABC1380;
	Wed, 23 Aug 2023 01:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE3D2C433C9;
	Wed, 23 Aug 2023 01:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692754825;
	bh=pAXq51Pv5rx97eeOazHPERneKzEPK0bqVk63gRfVb8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZgGtHpEq5zzIG0lyChaM9CnxXENu2ZEIyqp4CFazPlgg3dCI2tlVksPAvzlD+L79j
	 E44tTEWu5xqyNROPMKIC36rk/8B5WH8czKB1RfakuWNn0iqzTTwpyzaaivHRExpDdM
	 Y/xAt48Xh4Rbxq/NK3F4w1ePAmr79kOr7/V6hilirlx4xe/JGm4FVtotRVcniKx0UU
	 A9v9oSh7vYSVqWTFhGq+A2SEtbbgSkSaqhVyhBj5rvuu0UILEGlk+3qBnKjW4x+XNK
	 lnJwNEbVYN71H2dZM5SIELbCF24oRdHJeXVVZ1m7D4efiGuh3Wb4QrwO62uiOk6A1z
	 lD97J89A6G+BQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0DF7E4EAF6;
	Wed, 23 Aug 2023 01:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] mptcp: Prepare MPTCP packet scheduler for
 BPF extension
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169275482578.27929.1775415054097183843.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 01:40:25 +0000
References: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
In-Reply-To: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: matthieu.baerts@tessares.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, geliang.tang@suse.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 15:25:11 -0700 you wrote:
> The kernel's MPTCP packet scheduler has, to date, been a one-size-fits
> all algorithm that is hard-coded. It attempts to balance latency and
> throughput when transmitting data across multiple TCP subflows, and has
> some limited tunability through sysctls. It has been a long-term goal of
> the Linux MPTCP community to support customizable packet schedulers for
> use cases that need to make different trade-offs regarding latency,
> throughput, redundancy, and other metrics. BPF is well-suited for
> configuring customized, per-packet scheduling decisions without having
> to modify the kernel or manage out-of-tree kernel modules.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] mptcp: refactor push_pending logic
    https://git.kernel.org/netdev/net-next/c/c5b4297dee91
  - [net-next,02/10] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
    https://git.kernel.org/netdev/net-next/c/ebc1e08f01eb
  - [net-next,03/10] mptcp: add struct mptcp_sched_ops
    https://git.kernel.org/netdev/net-next/c/740ebe35bd3f
  - [net-next,04/10] mptcp: add a new sysctl scheduler
    https://git.kernel.org/netdev/net-next/c/e3b2870b6d22
  - [net-next,05/10] mptcp: add sched in mptcp_sock
    https://git.kernel.org/netdev/net-next/c/1730b2b2c5a5
  - [net-next,06/10] mptcp: add scheduled in mptcp_subflow_context
    https://git.kernel.org/netdev/net-next/c/fce68b03086f
  - [net-next,07/10] mptcp: add scheduler wrappers
    https://git.kernel.org/netdev/net-next/c/07336a87fe87
  - [net-next,08/10] mptcp: use get_send wrapper
    https://git.kernel.org/netdev/net-next/c/0fa1b3783a17
  - [net-next,09/10] mptcp: use get_retrans wrapper
    https://git.kernel.org/netdev/net-next/c/ee2708aedad0
  - [net-next,10/10] mptcp: register default scheduler
    https://git.kernel.org/netdev/net-next/c/ed1ad86b8527

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



