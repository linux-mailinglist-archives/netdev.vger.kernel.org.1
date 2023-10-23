Return-Path: <netdev+bounces-43682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6233B7D437C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A73B20CF1
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 23:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B62421B;
	Mon, 23 Oct 2023 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSKKh3UP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41722EF7
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 23:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BABB9C433C9;
	Mon, 23 Oct 2023 23:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698105025;
	bh=nsvutdS5YCyheFrtFqpw09N4YsAHpCsZfmPYbWcrKn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uSKKh3UP1TRd7go/lRw01y2lbX9Ad1CsGJGucMYsPiiHIX7LcDYj02QbwNnPIrcwh
	 6NMyzRabVN6x85vTMVNTlqkhO3O/fJv8sYnzORp6hd8Rmb7j1Gi1pIDnay5ZGke88M
	 /NuTkIMYvACMvOEV6FsFR/makZn3zWhEusgZ944shVr4SLeSA2r31sm03bhC3zpWjD
	 UpbJWB7VTgoqkBdxiQevDa5sHm5nI242Dw4KLUhD1Uf8zcHj8aQ82nWwFBPrZiIBBU
	 gJsz0ux/MjU69AsL7IvuKmDeX+IneWyRtEe3aCdVjRK5SeEq6a00xD4xuRXjrJu/PM
	 dJjbBlzhJQa1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E944E4CC11;
	Mon, 23 Oct 2023 23:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v3 00/10] devlink: finish conversion to generated
 split_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169810502563.22561.12072531604904288057.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 23:50:25 +0000
References: <20231021112711.660606-1-jiri@resnulli.us>
In-Reply-To: <20231021112711.660606-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
 johannes@sipsolutions.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 21 Oct 2023 13:27:01 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This patchset converts the remaining genetlink commands to generated
> split_ops and removes the existing small_ops arrays entirely
> alongside with shared netlink attribute policy.
> 
> Patches #1-#6 are just small preparations and small fixes on multiple
>               places. Note that couple of patches contain the "Fixes"
>               tag but no need to put them into -net tree.
> Patch #7 is a simple rename preparation
> Patch #8 is the main one in this set and adds actual definitions of cmds
>          in to yaml file.
> Patches #9-#10 finalize the change removing bits that are no longer in
>                use.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/10] genetlink: don't merge dumpit split op for different cmds into single iter
    https://git.kernel.org/netdev/net-next/c/f862ed2d0bf0
  - [net-next,v3,02/10] tools: ynl-gen: introduce support for bitfield32 attribute type
    https://git.kernel.org/netdev/net-next/c/4e2846fd6684
  - [net-next,v3,03/10] tools: ynl-gen: render rsp_parse() helpers if cmd has only dump op
    https://git.kernel.org/netdev/net-next/c/2260d39cd01a
  - [net-next,v3,04/10] netlink: specs: devlink: remove reload-action from devlink-get cmd reply
    https://git.kernel.org/netdev/net-next/c/c48066b0cc2c
  - [net-next,v3,05/10] netlink: specs: devlink: make dont-validate single line
    https://git.kernel.org/netdev/net-next/c/6cc8ad97c101
  - [net-next,v3,06/10] devlink: make devlink_flash_overwrite enum named one
    https://git.kernel.org/netdev/net-next/c/e3570f040836
  - [net-next,v3,07/10] devlink: rename netlink callback to be aligned with the generated ones
    https://git.kernel.org/netdev/net-next/c/53590934ba95
  - [net-next,v3,08/10] netlink: specs: devlink: add the remaining command to generate complete split_ops
    https://git.kernel.org/netdev/net-next/c/f2f9dd164db0
  - [net-next,v3,09/10] devlink: remove duplicated netlink callback prototypes
    https://git.kernel.org/netdev/net-next/c/15c80e7a53d2
  - [net-next,v3,10/10] devlink: remove netlink small_ops
    https://git.kernel.org/netdev/net-next/c/cebe7306073d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



