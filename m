Return-Path: <netdev+bounces-39414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AD07BF11A
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 04:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD8C1C20B52
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB8620EB;
	Tue, 10 Oct 2023 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THSAipcx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED371367
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77C1EC433CB;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696906225;
	bh=D05HMkr2YKnvode8jkifgf5tpbrSlbvQjOLz+a/GlIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=THSAipcxr2NIpufD6qUyH0gUBT03+Y06NN7veUnUcBr51jbaHv7N0vzT/dsadCjmc
	 oNqHsVREB7tcCJHbw6Hyc8gGcD+zkO5gCSkxQijttEbrzp2nIxQq/izafLvYOlgi/P
	 ShUm8OiKhsEhz+nkU2SY3cra6hvfVlg89gBNojgv3UMcgggSSh8tH+nHfPlSIdETpf
	 jCF3XeirFtuamOMC4pOsjrIwE8D0Uv70eMoZMESlPGZrqiF7Lan62jV0ALVHHJYfQk
	 aqyDdCWt1wosxt9MwKEVHmI9/a7IZLOEpdh63G7WbNGdp6FpQGzlqtzqVbFWSMSJqW
	 dhNWjVO25YdBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63272E0009B;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v3 0/2] tools: ynl-gen: lift type requirement for
 attribute subsets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169690622540.548.9799997208397355098.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 02:50:25 +0000
References: <20231006114436.1725425-1-jiri@resnulli.us>
In-Reply-To: <20231006114436.1725425-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Oct 2023 13:44:34 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Remove the requirement from schema files to specify the "type" for
> attribute subsets and adjust existing schema files.
> 
> Jiri Pirko (2):
>   tools: ynl-gen: lift type requirement for attribute subsets
>   netlink: specs: remove redundant type keys from attributes in subsets
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] tools: ynl-gen: lift type requirement for attribute subsets
    https://git.kernel.org/netdev/net-next/c/e18f3dc2beaa
  - [net-next,v3,2/2] netlink: specs: remove redundant type keys from attributes in subsets
    https://git.kernel.org/netdev/net-next/c/7049fd5df78c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



