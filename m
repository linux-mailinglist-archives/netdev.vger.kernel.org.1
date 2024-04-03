Return-Path: <netdev+bounces-84234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEF4896212
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 03:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EE11F2531D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 01:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BCD13FF5;
	Wed,  3 Apr 2024 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhwyHmlu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F8D29B
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108435; cv=none; b=gHVMzOJaN+PLL3bEWPGLTvVuaTNA9U+8vsk11yLSTu9sWocdwFc9FsiCM3vLUN0tIcB8lWwFyQFuXziOJUgfxW+4Oxnak9qdOr4iSxMiaEC1f1sTY65bcqFakPjLREWsGCs27SSW0c4WnYskWkdU8OgWwsLPZFx56G5xKx4VbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108435; c=relaxed/simple;
	bh=w/QcRU2e5FQjK4uJI2p9rb+4euVi1kfc/re4I18TlX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JxGumfgRfSKrkPerLxDaXmSqFmSYhURrgL0Z9mUZt/QNIIZvAY5Hltkqexg0A3EQe41m+ZC0adAHX0gEJuVbvuOYAT0BWrIucEgB7Sfbh/jpTV8M0FMZNTjNaqsv6fbhWhhTJ8CSOe0mSw0lj8gs08iaLmvrDLvwa/p6gfMysFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhwyHmlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C07E3C433F1;
	Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712108434;
	bh=w/QcRU2e5FQjK4uJI2p9rb+4euVi1kfc/re4I18TlX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RhwyHmluFxbY/sVlGpOOg4Q0Izx2c9nXz5FL5gyHd3VBD2/0mhEQ6nLSsnQ+icLdq
	 9yXmlEELdGm6JZuc0eSg54i9w3N5q6VMZnHe9DNNR9xHVAczj8InfocJavYDHe54dA
	 nxqa9ts+cYAr1+8uWkm00gEEB+y/wewSb0AqWCLS+dgo2FPV5UgsEcJqGXYg1T1dRz
	 /vIP8djK+YyMg/DytrMzH3PpNVD60X/gRakJftFtqzHco3AeDiwYgAnqqKhpW5McXN
	 lQxxA+CqeNt9gb4dCW2Z1HJmuO2HpdyoEVaXE793k/GCY/izH2zCs9WemXwwT4cmbB
	 rHHBdd2tSwPQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEB32D9A14F;
	Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 net-next 0/4] doc/netlink: add a YAML spec for team
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171210843471.14193.9758845608853454018.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 01:40:34 +0000
References: <20240401031004.1159713-1-liuhangbin@gmail.com>
In-Reply-To: <20240401031004.1159713-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
 jiri@resnulli.us, jacob.e.keller@intel.com, sdf@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Apr 2024 11:10:00 +0800 you wrote:
> Add a YAML spec for team. As we need to link two objects together to form
> the team module, rename team to team_core for linking.
> 
> v4:
>   1. fix the wrong squashe changes (Jakub Kicinski)
> v3:
>   1. remove item/list-option from request as they are not attributes (Jakub Kicinski)
> v2:
>   1. adjust the continuation line (Jakub Kicinski)
>   2. adjust the family maxattr (Jakub Kicinski)
> v1:
>   1. remove dump from team options. (Jiri Pirko)
> 
> [...]

Here is the summary with links:
  - [PATCHv4,net-next,1/4] Documentation: netlink: add a YAML spec for team
    https://git.kernel.org/netdev/net-next/c/387724cbf415
  - [PATCHv4,net-next,2/4] net: team: rename team to team_core for linking
    https://git.kernel.org/netdev/net-next/c/a0393e3e3ddb
  - [PATCHv4,net-next,3/4] net: team: use policy generated by YAML spec
    https://git.kernel.org/netdev/net-next/c/948dbafc15da
  - [PATCHv4,net-next,4/4] uapi: team: use header file generated from YAML spec
    https://git.kernel.org/netdev/net-next/c/e57ba7e3d7bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



