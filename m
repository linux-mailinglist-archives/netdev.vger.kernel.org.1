Return-Path: <netdev+bounces-39497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5A77BF86B
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE9B281B83
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FE718036;
	Tue, 10 Oct 2023 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHEpSVZG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DC118027
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D306FC433CB;
	Tue, 10 Oct 2023 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696933225;
	bh=AhitMLjn2quhJte7pfHmStCBHkG1ujzOJxEPqpE7s98=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FHEpSVZGbsfOqQ+X7MQ4FqDyemnV27LjFktEAiXrk7pGHoQGcpCY4nGSdpMpnueWF
	 /rxA5CeKr8KqF3Gd/DAzMsOyterNpgNksFzhPl2kEfsJ49w6rpZRjiI713gCgcSP2/
	 inLIpv0eDYwf6kcIVksRK+ukqVHHA5SpRIGyDRC46eCmtZ3hLyt1dMjtDMlCbgjcrw
	 S26IuFGZhLwh+cUEBFViaC8wD5R53OrIxegr+gu9/LmFvHztFSmNqV9S0dUb/c+VGS
	 /pBl57mm5WG4Yq7tgegHoJk0+NKC/4xvh1f2jk/E/+mimiSlBXwUB2MJeRYqJF/1k2
	 IvnLZ8vb7DoqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C098AC595C5;
	Tue, 10 Oct 2023 10:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] mlxsw: Fix -Wformat-truncation warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169693322578.26630.2632330656608204931.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 10:20:25 +0000
References: <cover.1696600763.git.petrm@nvidia.com>
In-Reply-To: <cover.1696600763.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 6 Oct 2023 16:43:15 +0200 you wrote:
> Ido Schimmel writes:
> 
> Commit 6d4ab2e97dcf ("extrawarn: enable format and stringop overflow
> warnings in W=1") enabled format warnings as part of W=1 builds,
> resulting in two new warnings in mlxsw. Fix both and target at net-next
> as the warnings are not indicative of actual bugs.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] mlxsw: core_thermal: Fix -Wformat-truncation warning
    https://git.kernel.org/netdev/net-next/c/83b2d81b691c
  - [net-next,2/2] mlxsw: spectrum_ethtool: Fix -Wformat-truncation warning
    https://git.kernel.org/netdev/net-next/c/392ce2abb0ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



