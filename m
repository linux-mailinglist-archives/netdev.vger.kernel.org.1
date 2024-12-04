Return-Path: <netdev+bounces-148782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED79E31D9
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323432847E0
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01C414375C;
	Wed,  4 Dec 2024 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgN8xkE1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49B142E86
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281819; cv=none; b=YsebdaA2ULI7YeA3oH8wSrncG1HgHv7MhBnCWE05nQrZ27wycE+hBpTgIpMhze/tTeXvIjQGFkNXYVw+nxdx3YQImwZSRSTiQs4SFJcmSZ06Jfv5RIs/u0ssddqvwXaFA+rloBYSbOCmxQWgYk0P6YR2B6BQUEtyuq/BF7SW1Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281819; c=relaxed/simple;
	bh=QwHJ0E2MW4iBG7ozwH4feU6cnq3p6arykrfBCD6klJc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PCGkX2HMLpH3Ys4Fv5F3mBXpewExQb9knZnqaCbP4uq3mF25hJ2WcgtXMlENFdpEdQjOs6OWh65u720ueUUKUigxP4kFsPo+q9tDeUYPTYTqJ4WlM/ic5wARLCG/UdRHnNXE/MueT2WZwAjjqJ+d4sdIRi5AjC4DUILAXHzGfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgN8xkE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56710C4CEDE;
	Wed,  4 Dec 2024 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733281819;
	bh=QwHJ0E2MW4iBG7ozwH4feU6cnq3p6arykrfBCD6klJc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EgN8xkE1X9J4iGxabnmsJde1bY8s+KLyFagb79u2Y5lUb0MRK7TgyZoZ+qmVow5uC
	 Cy6duPX8tURRySLoP/5Qhb0rmKq8CGTdlKv0zLEDLf4Q1EKT56ss8mATH6VIENt8MP
	 e7Y814LpDqUrClFr4Jlo+MvJsJIW1a0iKbtTmthtLQeE+Pwn7BMudILp639EW0jMS5
	 EcihshHPKWRVEjMCDlD58Emqs6TNj0d2+s3gFbUHP3xjqkLQ5ph67SeGQ6bcYoQvMx
	 vborCbds8IxucwUWIkQfdWIVYd1VTav1B1vNj/GGNEsvPL75ol4Xf00K6Adl+XzZpz
	 2SCQ1K9pE1Vdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1F13806656;
	Wed,  4 Dec 2024 03:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "udp: avoid calling sock_def_readable() if
 possible"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173328183350.718738.2937148917661346597.git-patchwork-notify@kernel.org>
Date: Wed, 04 Dec 2024 03:10:33 +0000
References: <20241202155620.1719-1-ffmancera@riseup.net>
In-Reply-To: <20241202155620.1719-1-ffmancera@riseup.net>
To: Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Dec 2024 15:56:08 +0000 you wrote:
> This reverts commit 612b1c0dec5bc7367f90fc508448b8d0d7c05414. On a
> scenario with multiple threads blocking on a recvfrom(), we need to call
> sock_def_readable() on every __udp_enqueue_schedule_skb() otherwise the
> threads won't be woken up as __skb_wait_for_more_packets() is using
> prepare_to_wait_exclusive().
> 
> Link: https://bugzilla.redhat.com/2308477
> Fixes: 612b1c0dec5b ("udp: avoid calling sock_def_readable() if possible")
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> 
> [...]

Here is the summary with links:
  - [net] Revert "udp: avoid calling sock_def_readable() if possible"
    https://git.kernel.org/netdev/net/c/3d501f562f63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



