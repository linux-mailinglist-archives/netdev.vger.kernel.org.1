Return-Path: <netdev+bounces-76930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2710886F77B
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 23:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC68FB20B98
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 22:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100877A704;
	Sun,  3 Mar 2024 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H89NjcF0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E033E79DC9
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709505629; cv=none; b=VZtfnbfiXIXkz4Gy+1x8b3JwQJXwHcvl/bhvMfE4YP/PbozcgR1MqKktYCeIPKV+fKqKu6IYT1S6+hVPKJ1fzp5YGeMfNLekUF+o6Fta4n0WNMsdyzD0EFJ6JdZaCxY2gIJZeh4cyxdUqGqsPTvcPAnjKxyf1FUL72qMusXYjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709505629; c=relaxed/simple;
	bh=8ON+nzy2W5Af/3NlHxUo7bpbuuWfqpl9zoQSH0q/Z8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jTpXsHhU6d94tT9bkI/oQWVnhsOysrExMkJZ8E1VsT5wr4ezqvcQecu5M1YvPnW7x/L9ZMyCzy6poDy+r9/J0m+FlR9qrZjX92+G2eHyOheluAaGuZefkm4QemT++wOX5jgqRzwQ8gIM2miQTQhckNOLfQAywb8I8MWw+j11qVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H89NjcF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ED59C433F1;
	Sun,  3 Mar 2024 22:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709505628;
	bh=8ON+nzy2W5Af/3NlHxUo7bpbuuWfqpl9zoQSH0q/Z8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H89NjcF0cHLUFaUQ1Ziy6kn+JxFBJf6HhBT/CeuJBk1CF3b2SCAxomAqGCXh5U6rk
	 UcWs0m7KVqh6v81viQjG6pBuc+AgwHI1+ie3jvXwu1ScZcyoZcw2K8IfGmF4uOss2D
	 ErjMsbQdYjqcvdg/Q/kGsRFsWdd/rqyFV39TmdV3lQO5cVV/O0aLq0Yy4DBHrYOw9j
	 7/wvxIWfgtphJgnHpUqBoHPDhFCB84Vtn1Cj1rP2cjrzk/Xv9QnoMtG8U4chGN5inm
	 1Z9KdDCjtmnl0PKHX5868sJC3A2q9FgnTF25Zk6L00E9J8bSbAqs83F9tbLf2tkQjW
	 FkcD3G+P0hvVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 506E5D9A4B9;
	Sun,  3 Mar 2024 22:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 1/3] nstat: constify name argument in
 generic_proc_open
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170950562832.16991.13915871942079195357.git-patchwork-notify@kernel.org>
Date: Sun, 03 Mar 2024 22:40:28 +0000
References: <20240228135858.3258-1-dkirjanov@suse.de>
In-Reply-To: <20240228135858.3258-1-dkirjanov@suse.de>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, dkirjanov@suse.de

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 28 Feb 2024 08:58:56 -0500 you wrote:
> the argument passed to the function
> is always a constant value
> 
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  misc/nstat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2,1/3] nstat: constify name argument in generic_proc_open
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=4ce906c3d515
  - [iproute2,2/3] nstat: use stack space for history file name
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=2f8b36e146a5
  - [iproute2,3/3] nstat: convert sprintf to snprintf
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=b69e1e0445ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



