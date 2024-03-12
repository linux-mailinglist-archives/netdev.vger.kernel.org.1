Return-Path: <netdev+bounces-79372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C8D878DA7
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 04:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66D2281A0F
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 03:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E0B651;
	Tue, 12 Mar 2024 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1jA03X+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62793AD58
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214830; cv=none; b=sJUFHWb8vRb/rhY0iFj9Xaacvm43nRCkKJ4b5xKBSyO8+SyUqOigizFhiBwjCULeVuyGjB06yAfLRbnWg0sKLQflOwXl85w/KI8cVeI7zyrDeCcEl1pjnTe+Tqc8AXgfEVIRK269WJxRO3kLrxbeAIAEa3hAGucapevE4Du3oEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214830; c=relaxed/simple;
	bh=N9w5sH0ctblHemrfMfTT12hjculgaFHT7o1KAXdfIS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CA/b8v0FzyJz6F3lbs3SGgo6oNNIyIe6a73RF6MUH5h+DtHZLHw+LZKZHCFSj1vRvKEr2q9yUo93VFGQHBKNvLP44GkkPa4Qjgo8Zm5bULh0WcmaXSWFeZHKQo44MqtT8yLTbDobbgvpdxulAdKXftELpb+rbjsX2lrUfIjv4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1jA03X+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3573DC43390;
	Tue, 12 Mar 2024 03:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710214830;
	bh=N9w5sH0ctblHemrfMfTT12hjculgaFHT7o1KAXdfIS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i1jA03X+7Fpm4pnvu92vTWoKd6MyPBSWRl5n56O1t6tkT0MH9NUIHDcuW+/hG84fn
	 qOsOkIuXENHTxWTs34Wo7x4ENkwblmiVnM5u6U1JWGkb14tdE2ARqSmgnVFeX1aq5b
	 2ZGKTphVbPhc/lVt7xcK4jhsFXSdFKhnHMVat0GzhLk8ErLgiN7RO6wmLL0428MWiN
	 rgx6sjRO8C20cvYYjpf+CdCL+suighZ03j6Gdk1v1tZxw4GnY4if5qGjMuGpPr0NH3
	 u04E/82NJ6UpwdsCnXYRiScJevDVzN6jQDHD3fhShvKLU9I+QgJlghQZ7BG1jHTYXp
	 SzYXMpc6Hyhaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1670DC395F1;
	Tue, 12 Mar 2024 03:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] nexthop: Fix two nexthop group statistics
 issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171021483008.13560.10002878328772043549.git-patchwork-notify@kernel.org>
Date: Tue, 12 Mar 2024 03:40:30 +0000
References: <20240311162307.545385-1-idosch@nvidia.com>
In-Reply-To: <20240311162307.545385-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com, dsahern@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Mar 2024 18:23:03 +0200 you wrote:
> Fix two issues that were introduced as part of the recent nexthop group
> statistics submission. See the commit messages for more details.
> 
> v2:
> * Only parse NHA_OP_FLAGS for messages that require it (patches #1-#2
>   are new)
> * Resize 'tb' using ARRAY_SIZE (new change in patch #3)
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] nexthop: Only parse NHA_OP_FLAGS for get messages that require it
    https://git.kernel.org/netdev/net-next/c/dc5e0141ff19
  - [net-next,v2,2/4] nexthop: Only parse NHA_OP_FLAGS for dump messages that require it
    https://git.kernel.org/netdev/net-next/c/262a68aa46f8
  - [net-next,v2,3/4] nexthop: Fix out-of-bounds access during attribute validation
    https://git.kernel.org/netdev/net-next/c/d8a21070b6e1
  - [net-next,v2,4/4] nexthop: Fix splat with CONFIG_DEBUG_PREEMPT=y
    https://git.kernel.org/netdev/net-next/c/e006858f1a1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



