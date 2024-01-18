Return-Path: <netdev+bounces-64256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BC4831EDB
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBFB1F217FD
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49D62D60F;
	Thu, 18 Jan 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9xLIz6i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F78E2D609
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600828; cv=none; b=fET0d+IrEwMf7nCwOfosUx8y7C4D2+SM3e2nY96Bv8pAiwQJoahW1XJHelcGxRhn+TmU7PizpwKNO3XjVvxry7XGYO89qY6VJDhPQMu2bi/qj4Jyf6pVZG/Fnp39NA45eRJNiGuJ1LODc1QcpKJcRnpvUIN3xbma1m8cFbvPewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600828; c=relaxed/simple;
	bh=+oLt0gxwfodE4nSYk0/2cQsoAvlwFfiyBnGATSbnTB4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FOvtx9tLfokyDqPpxwxl6kRNHKWp2zwlQEFKEaEnxPb6ZaDPwwlChh384CIwTg95YoX6VqXds0cE8hg0aRMEEoP2u2A31mPBMss3d94EWAdKa7xNyVH19xvBPG6vhT1/VlDnXV1yIxYXcHP4JsMM+IjkOfPPPM2h0cCROyETr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9xLIz6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E280C43390;
	Thu, 18 Jan 2024 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705600828;
	bh=+oLt0gxwfodE4nSYk0/2cQsoAvlwFfiyBnGATSbnTB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M9xLIz6iWgU/abjkvLgSkNJUezyakIV2q11aYFrkFA9FolP7FrOFFUs+xML8O2OAz
	 UwSm6xHdzQOljWllHksKJT4FGht5NcJYlkKdZ/fTGgR7LxWRroT039FaMfcFIB9Qn6
	 o9tExcQDW7qSo4JLMaNQ81peBJP1A3cMrvaD2Iy5Rl9P2akARtwdUBmiLfpSh1Tlx0
	 I3E8uqNkdzrTnhrDgwuapTW0n3wJnBNRRz97SyeUoymFz9TspUqtoPLAgOQxwm+Gqy
	 yDZdyfbqpgVOa2p4/22uq8hHHYnEMjipSy0uqYQpi0vAeEZoKeCx1ObfJ+htdzw9eU
	 ZpI0B39J4qKcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 086ECDFC697;
	Thu, 18 Jan 2024 18:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6] mlxsw: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170560082803.5819.17603252019346279398.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jan 2024 18:00:28 +0000
References: <cover.1705502064.git.petrm@nvidia.com>
In-Reply-To: <cover.1705502064.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 danieller@nvidia.com, amcohen@nvidia.com, jiri@resnulli.us, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jan 2024 16:04:15 +0100 you wrote:
> This patchset is a bric-a-brac of fixes for bugs impacting mlxsw.
> 
> - Patches #1 and #2 fix issues in ACL handling error paths.
> - Patch #3 fixes stack corruption in ACL code that a recent FW update
>   has uncovered.
> 
> - Patch #4 fixes an issue in handling of IPIP next hops.
> 
> [...]

Here is the summary with links:
  - [net,1/6] mlxsw: spectrum_acl_erp: Fix error flow of pool allocation failure
    https://git.kernel.org/netdev/net/c/6d6eeabcfaba
  - [net,2/6] mlxsw: spectrum_acl_tcam: Fix NULL pointer dereference in error path
    https://git.kernel.org/netdev/net/c/efeb7dfea8ee
  - [net,3/6] mlxsw: spectrum_acl_tcam: Fix stack corruption
    https://git.kernel.org/netdev/net/c/483ae90d8f97
  - [net,4/6] mlxsw: spectrum_router: Register netdevice notifier before nexthop
    https://git.kernel.org/netdev/net/c/62bef63646c1
  - [net,5/6] selftests: mlxsw: qos_pfc: Remove wrong description
    https://git.kernel.org/netdev/net/c/40cc674bafd5
  - [net,6/6] selftests: mlxsw: qos_pfc: Adjust the test to support 8 lanes
    https://git.kernel.org/netdev/net/c/b34f4de6d30c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



