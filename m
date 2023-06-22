Return-Path: <netdev+bounces-13000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0D9739A35
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBD61C21150
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46933AAAC;
	Thu, 22 Jun 2023 08:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485103AAA4
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDECCC433C0;
	Thu, 22 Jun 2023 08:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687423220;
	bh=mHsfH1YWMYkA8WbtKOS2o31G1h9+Y07sYPDLLUVEuUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uvHDVWMZq9G7tCMWeTiehspYxEEAIUlqiwivVqsUVZxMUG58NefALXpHp7hh42KSB
	 a21VK7wMvnzbLzP7tRtjyRx++6dY5Fi5eqvwq/3huwVi7Zk+NMJgahQN4u5MB0nOuO
	 jFuPQqmAOPdwG1B6QjyZG8wWW7z+EARBIa5k33knzizmluzkHRzYxsfX8SBFjgZQJ0
	 xwqpIGcI4ApQdXfWhQghMGGT6HbJPcSpX87qjQHei+24weELRBvQpnr4Tc3qy/FlzL
	 LjyOAMYJyytQIma8iywAtOeW0bw8VmYzmyaw1+lloR42gXvidSsL0QideZ7hTx5EyG
	 rurfpOKXSRJ7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BA57C691EF;
	Thu, 22 Jun 2023 08:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: forwarding: Fix race condition in mirror
 installation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168742322063.10780.9759813024046689173.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 08:40:20 +0000
References: <268816ac729cb6028c7a34d4dda6f4ec7af55333.1687264607.git.petrm@nvidia.com>
In-Reply-To: <268816ac729cb6028c7a34d4dda6f4ec7af55333.1687264607.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, danieller@nvidia.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 Jun 2023 14:45:15 +0200 you wrote:
> From: Danielle Ratson <danieller@nvidia.com>
> 
> When mirroring to a gretap in hardware the device expects to be
> programmed with the egress port and all the encapsulating headers. This
> requires the driver to resolve the path the packet will take in the
> software data path and program the device accordingly.
> 
> [...]

Here is the summary with links:
  - [net] selftests: forwarding: Fix race condition in mirror installation
    https://git.kernel.org/netdev/net/c/c7c059fba6fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



