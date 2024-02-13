Return-Path: <netdev+bounces-71146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B028F852719
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30711C25B00
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9E46AD6;
	Tue, 13 Feb 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN6Z/BmZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC018BEB
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789031; cv=none; b=OK9J6cDLDMad2BwKeKNoJ1SqQLMHR1EzYS1SdOnEbq9L3PUb7NmRnk7sWGGs4CY7lgZHyUURAZttXbr6WwuFReCi7euV0qkZ3NUaXzXG33eodVwti08jWrmrsA5gw8Fh/mmI+Q7iBWIyEOOt4rLsGVunWAbYOddMHhW4U1SgL/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789031; c=relaxed/simple;
	bh=ADJxMi1qkZlid1lD0Hf2IN7oWJpu2lN7kjfyyBbMPXQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iXentOULE3TvW8pEeWXGjVz7euqlZHwtivqQS1fHYG70LKfgLZ2/vIJn7wQSBSO7CstmhjEP9N/ZHky4utpCu28dS9yOkIivrN5BRPchIpcL59drAXhkWoPJMOVfldGORE1iQklg0mHhdEJnP9VNqPYv89nz5bgfpUfVAiRC58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN6Z/BmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05994C433F1;
	Tue, 13 Feb 2024 01:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707789031;
	bh=ADJxMi1qkZlid1lD0Hf2IN7oWJpu2lN7kjfyyBbMPXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QN6Z/BmZDxDdyo/CpP14pd4aYoYpK1oZD0j+K85wvM+Qw4eKY2Jsvuw5wHOyWMNfx
	 /+3uFTp/k7TtPcsR+x+eABhAt35ujr4ALYQeiQEzuBDrslh1JsmI12I5gbHATxVu7K
	 dHmSkOfdZWA0X3im+X7ST8PMpZW9DlgK4OJ1YMh+c0F1/Wks1MDOszF65TXKcdd9hG
	 h2xfX65qcpQpFNr+wKL+1ZvA6xYl6QS1EqbpHZJcbLHdltOhFWcHlX8Hajh0YRQY72
	 MX8GcYywYL/l3lAbT2AxtGYD6DdYzHwHldrbwVCKj1lDFzvfiE4IVM64OoOm+VL/7B
	 euRD3TEXOrTUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFD62D84BC6;
	Tue, 13 Feb 2024 01:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pds_core: no health-thread in VF path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170778903090.20137.980567667578810208.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 01:50:30 +0000
References: <20240210002002.49483-1-shannon.nelson@amd.com>
In-Reply-To: <20240210002002.49483-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
 drivers@pensando.io

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 9 Feb 2024 16:20:02 -0800 you wrote:
> The VFs don't run the health thread, so don't try to
> stop or restart the non-existent timer or work item.
> 
> Fixes: d9407ff11809 ("pds_core: Prevent health thread from running during reset/remove")
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> [...]

Here is the summary with links:
  - [net] pds_core: no health-thread in VF path
    https://git.kernel.org/netdev/net/c/3e36031cc054

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



