Return-Path: <netdev+bounces-42971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9022B7D0DEB
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEB7282478
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD32179B9;
	Fri, 20 Oct 2023 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEvIOHhu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC13182A9
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E578FC433CA;
	Fri, 20 Oct 2023 10:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697799026;
	bh=m3OSLLDENvxJWf508ScmEcKXRHhJJAK2Iww6BBoks1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DEvIOHhunE38jYQCEQ1DHQW5ijpwDwNB3lwnBXqDpuVyBNVzdrp8UpAHQg3IPEJQQ
	 l5ckBL6wTjQugUCfQck0m7n9FGY6zSpapwn5CxSftcebD3XdOhlK0uE+GmrEm21uiJ
	 RxDeCMtLK3Q9DXQGHrMkV4fCRcEZ59YJ2Gv9wEf9H+MNpGzXGTfXou+V0bfsSY/Yl2
	 5HMl5zimRAdUwqVkUygM0UGE6NJOg0J4kE4YdH8PIvV1dabw1cFrkTdfglR5RYMjvm
	 Y3ozLNDLqUoQeG7nGT3tQApVcz9NY1/9vlTQ+zfUefLuvh1QXRN5mU4WPZTYaj552S
	 6vqJN2TjXS61Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8BD5C73FE2;
	Fri, 20 Oct 2023 10:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] mlxsw: Move allocation of LAG table to the
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169779902581.4905.8675281223020212534.git-patchwork-notify@kernel.org>
Date: Fri, 20 Oct 2023 10:50:25 +0000
References: <cover.1697710282.git.petrm@nvidia.com>
In-Reply-To: <cover.1697710282.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 19 Oct 2023 12:27:09 +0200 you wrote:
> PGT is an in-HW table that maps addresses to sets of ports. Then when some
> HW process needs a set of ports as an argument, instead of embedding the
> actual set in the dynamic configuration, what gets configured is the
> address referencing the set. The HW then works with the appropriate PGT
> entry.
> 
> Within the PGT is placed a LAG table. That is a contiguous block of PGT
> memory where each entry describes which ports are members of the
> corresponding LAG port.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] mlxsw: reg: Drop SGCR.llb
    https://git.kernel.org/netdev/net-next/c/66eaaa85418b
  - [net-next,02/11] mlxsw: reg: Add SGCR.lag_lookup_pgt_base
    https://git.kernel.org/netdev/net-next/c/cf0a86e8ce60
  - [net-next,03/11] mlxsw: cmd: Fix omissions in CONFIG_PROFILE field names in comments
    https://git.kernel.org/netdev/net-next/c/be9ed47d3fab
  - [net-next,04/11] mlxsw: cmd: Add CONFIG_PROFILE.{set_, }lag_mode
    https://git.kernel.org/netdev/net-next/c/eb26a5923277
  - [net-next,05/11] mlxsw: cmd: Add QUERY_FW.lag_mode_support
    https://git.kernel.org/netdev/net-next/c/8eabd10cdce4
  - [net-next,06/11] mlxsw: core, pci: Add plumbing related to LAG mode
    https://git.kernel.org/netdev/net-next/c/b2e9b1fe8c2e
  - [net-next,07/11] mlxsw: pci: Permit toggling LAG mode
    https://git.kernel.org/netdev/net-next/c/daee7aaba849
  - [net-next,08/11] mlxsw: spectrum_fid: Allocate PGT for the whole FID family in one go
    https://git.kernel.org/netdev/net-next/c/f5e293f9939e
  - [net-next,09/11] mlxsw: spectrum_pgt: Generalize PGT allocation
    https://git.kernel.org/netdev/net-next/c/8c893abd64ae
  - [net-next,10/11] mlxsw: spectrum: Allocate LAG table when in SW LAG mode
    https://git.kernel.org/netdev/net-next/c/c678972580ae
  - [net-next,11/11] mlxsw: spectrum: Set SW LAG mode on Spectrum>1
    https://git.kernel.org/netdev/net-next/c/b46c1f3f5e07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



