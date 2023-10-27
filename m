Return-Path: <netdev+bounces-44874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AE17DA303
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27EA21C21105
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969AA405C4;
	Fri, 27 Oct 2023 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzLUaHbq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5E3FE58
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 22:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11067C433C7;
	Fri, 27 Oct 2023 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698444024;
	bh=CD4Oi5pecpGRAw1duBsk61/lmxlSuGcQ9NefG11u39w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LzLUaHbqOt1OkTYOYEFaJv9GIM6/5TwJZd7P2CC808069Nxhd2dfLsuR3ib4e2zZA
	 OYbt/Xz1BblCRLiVN6Su0a90YuYb5A90dMyEvSQu9dVmApnNxJqc/Z1zYqcCGFHVpr
	 uxu3HjgKTaPca1Kk+5XU1YJZumSt5Q+Z+oF5Nu9ZKGk0/f97+fYb+24SRNk9G864w/
	 tqlAxxg7zZYdF2eDWncXbKVoKum1fl09OH8XN75aSSH6Vn+Wevvbu/v5uteaQvuhu+
	 +nsT7VvSViAEwNdemdj09NQjkdu6OsL/nYNhPFvX+pOvuYXTI3zn7SYo8SiUG13TkT
	 1AmqJm2q/N7UQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8ADFC04E32;
	Fri, 27 Oct 2023 22:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netdevsim: Block until all devices are released
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169844402395.23229.11254880610483862231.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 22:00:23 +0000
References: <20231026083343.890689-1-idosch@nvidia.com>
In-Reply-To: <20231026083343.890689-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org, jiri@resnulli.us,
 mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Oct 2023 11:33:43 +0300 you wrote:
> Like other buses, devices on the netdevsim bus have a release callback
> that is invoked when the reference count of the device drops to zero.
> However, unlike other buses such as PCI, the release callback is not
> necessarily built into the kernel, as netdevsim can be built as a
> module.
> 
> The above is problematic as nothing prevents the module from being
> unloaded before the release callback has been invoked, which can happen
> asynchronously. One such example can be found in commit a380687200e0
> ("devlink: take device reference for devlink object") where devlink
> calls put_device() from an RCU callback.
> 
> [...]

Here is the summary with links:
  - [net-next] netdevsim: Block until all devices are released
    https://git.kernel.org/netdev/net-next/c/6aff7cbfe7bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



