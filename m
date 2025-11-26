Return-Path: <netdev+bounces-241742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE5BC87E51
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 24A9A354697
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDE030C631;
	Wed, 26 Nov 2025 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txUnLAWM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE0230C62C
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 03:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764126060; cv=none; b=Z023z9hgb5JmtlWsQaVWNygVdeRkB4qQVPhKJPkP1wutMXu7ekcP58isAYAEpXdUKpw5N4fT+tEZ9MF2FDpYi2sDkKFFxUNHGprdlVxRIH+rQBurhLSLonfuMGuLnbBsUHjR48aGq4ZVljcJP+1fLWqVmhXdFB7/4fVwzjBlb9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764126060; c=relaxed/simple;
	bh=jH30DAUzk0AZBpBj6tlZlKojh/FVS6LuYX3COy6z2v8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kyBvQO8raRA67/Ck9aTEWoAUDVI+5LwyEc41255ODlkN8v6wwvx9D45IO7v8vh6Uv3WTwuPNnDUtousay7bkKV+tTrGy1VYM8sbFT8poZAYSwHRzeBNzj+GqQYb30PByAyeeaUUsw5a9mYjE4Jy6dKENtc5GfJOxBgpcV/gKEpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txUnLAWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95CFC4CEF1;
	Wed, 26 Nov 2025 03:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764126060;
	bh=jH30DAUzk0AZBpBj6tlZlKojh/FVS6LuYX3COy6z2v8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=txUnLAWMdjixNgfFZOqRH4IpCLY1l67wMNWoU23i8gvZM4AXWoTik/6vXr8ETv+VP
	 /Nrrn2ncpsuFukroifFJjdgRH1jJVpXvhU03RuYOA22e6Kg/EZP+bAvVHOPsbe27q4
	 GwFoe+tddv4TSWyTSpiJWe8dk+aZQ2iLcTOwP99kL5wzO64x8ftFcB/CgHdrLfH293
	 /LlT1qtkoMbIOdnfxTQ7Arc+J/0+YyxRsAU6S4jiBEG82lCCOS62qU/9O6SR8SlOv3
	 AHoxPj6YGhkkKIh3iHsCZtnHoZXgnp3jpjqFBxSn0VcwPLRJzE5C3Rr/zYnaPwPU5e
	 6rmI+XZXdOrqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E6B380AAE9;
	Wed, 26 Nov 2025 03:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] cxgb4: Rename sched_class to avoid type clash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412602275.975105.6119638653530547209.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 03:00:22 +0000
References: <20251121181231.64337-1-alan.maguire@oracle.com>
In-Reply-To: <20251121181231.64337-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bharat@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kees@kernel.org,
 gustavoars@kernel.org, hariprasad@chelsio.com, rahul.lakkireddy@chelsio.com,
 netdev@vger.kernel.org, bvanassche@acm.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Nov 2025 18:12:31 +0000 you wrote:
> drivers/net/ethernet/chelsio/cxgb4/sched.h declares a sched_class
> struct which has a type name clash with struct sched_class
> in kernel/sched/sched.h (a type used in a field in task_struct).
> 
> When cxgb4 is a builtin we end up with both sched_class types,
> and as a result of this we wind up with DWARF (and derived from
> that BTF) with a duplicate incorrect task_struct representation.
> When cxgb4 is built-in this type clash can cause kernel builds to
> fail as resolve_btfids will fail when confused which task_struct
> to use. See [1] for more details.
> 
> [...]

Here is the summary with links:
  - [net] cxgb4: Rename sched_class to avoid type clash
    https://git.kernel.org/netdev/net-next/c/380d19db6e6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



