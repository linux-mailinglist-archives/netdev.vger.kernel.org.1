Return-Path: <netdev+bounces-37322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAD17B4C48
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 09:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C6717281B57
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5227B17C3;
	Mon,  2 Oct 2023 07:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437661C2F
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 07:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1B7CC433C9;
	Mon,  2 Oct 2023 07:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696230624;
	bh=aAZBbU0QD3fVA/BMeZqbMWtrWpfLMmYokUlaisZqIf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pioyQXIgteWC1pEkEW2o40QtqWcJmSDN6AMcxF0LbDUMqQVSm9C0yE44uyOx3Z9RU
	 Azb2xeCG7Cbg9k+7QVxlYJ4BZmxudJ4HQiXaVLCbJ0mjgQDcS+iQ59Hz+pJ7ovI9Ci
	 atZlV4EPM5sA2w/yby+3qN/wvjeJyShW+b6eiOqs33916hmIkNdGkIO6Ye18TAAOTf
	 +Xc9ecnZpq8o8LPg3cKvF0Djczah9/2ipV+I97xLGSUM17YZhepQCiz4OAnUHeNbnI
	 lXOBRrkES+Z0FU13AeX5AFYEKrvwo/38K7vpoQc7zngISNFcA2hniBPrbgb8F/oE9o
	 eKkLYpQJz+LEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BEF7E632D2;
	Mon,  2 Oct 2023 07:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] mlxsw: Provide enhancements and new feature
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169623062463.24181.13936099338416148793.git-patchwork-notify@kernel.org>
Date: Mon, 02 Oct 2023 07:10:24 +0000
References: <cover.1695396848.git.petrm@nvidia.com>
In-Reply-To: <cover.1695396848.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 vadimp@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Sep 2023 19:18:35 +0200 you wrote:
> Vadim Pasternak writes:
> 
> Patch #1 - Optimize transaction size for efficient retrieval of module
>            data.
> Patch #3 - Enable thermal zone binding with new cooling device.
> Patch #4 - Employ standard macros for dividing buffer into the chunks.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] mlxsw: reg: Limit MTBR register payload to a single data record
    https://git.kernel.org/netdev/net-next/c/c755655c3d8b
  - [net-next,2/3] mlxsw: core: Extend allowed list of external cooling devices for thermal zone binding
    https://git.kernel.org/netdev/net-next/c/7afc79e20e22
  - [net-next,3/3] mlxsw: i2c: Utilize standard macros for dividing buffer into chunks
    https://git.kernel.org/netdev/net-next/c/1f73286371c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



