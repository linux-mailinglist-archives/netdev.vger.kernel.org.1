Return-Path: <netdev+bounces-47190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709C67E8BE5
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 18:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E392FB20A7C
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED201BDE0;
	Sat, 11 Nov 2023 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSdOCO6+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A8D1BDD1
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 17:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 891A2C433C7;
	Sat, 11 Nov 2023 17:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699724208;
	bh=+Vz53DeCV5Vse+Bo7UeORdfbctoXg66BvH2ZgI1/BeU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jSdOCO6+DO3PwQvgepWVAqnGLFYE/4yFhmqf1445wRGnovs7Xm8I+dQFC3/k9cvM/
	 KqPgvIuhJupS4GLqiqGjd+pnOvWBhgCHiqvLIFc42/ofoB3LprINu8t52kejjSafr3
	 +00ySVYB2tOgGhwTB3+xwP25irwkW/5toKYYym4jqHxrTjxHrbGTvLtvlpKO4eNjuQ
	 HdJWgQIEe9w4hyIK7xkcohPEEMmRshEqgzdwGUvgUVahxITURQ48L6HqWWIlQx6Dcb
	 WUHO1dkefX3lbSuuATxvibhHiFR4Zn18vg9n9JoztzyQ96/oLiUzX25irUDSgUJZy4
	 dv4Z6Ni25nQcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72F69E00083;
	Sat, 11 Nov 2023 17:36:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch iproute2-next v5 0/7] expose devlink instances relationships
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169972420846.7909.13965137063864264701.git-patchwork-notify@kernel.org>
Date: Sat, 11 Nov 2023 17:36:48 +0000
References: <20231107080607.190414-1-jiri@resnulli.us>
In-Reply-To: <20231107080607.190414-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
 daniel.machon@microchip.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue,  7 Nov 2023 09:06:00 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Print out recently added attributes that expose relationships between
> devlink instances. This patchset extends the outputs by
> "nested_devlink" attributes.
> 
> Examples:
> $ devlink dev
> pci/0000:08:00.0:
>   nested_devlink:
>     auxiliary/mlx5_core.eth.0
> auxiliary/mlx5_core.eth.0
> pci/0000:08:00.1:
>   nested_devlink:
>     auxiliary/mlx5_core.eth.1
> auxiliary/mlx5_core.eth.1
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v5,1/7] ip/ipnetns: move internals of get_netnsid_from_name() into namespace.c
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=a59b83f73d45
  - [iproute2-next,v5,2/7] devlink: use snprintf instead of sprintf
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=8265b39f0c25
  - [iproute2-next,v5,3/7] devlink: do conditional new line print in pr_out_port_handle_end()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=fb47796cd606
  - [iproute2-next,v5,4/7] devlink: extend pr_out_nested_handle() to print object
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e98d5084f7cd
  - [iproute2-next,v5,5/7] devlink: introduce support for netns id for nested handle
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=2ded9c18a37b
  - [iproute2-next,v5,6/7] devlink: print nested handle for port function
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=3e90f377f49b
  - [iproute2-next,v5,7/7] devlink: print nested devlink handle for devlink dev
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=1ac0c4450f61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



