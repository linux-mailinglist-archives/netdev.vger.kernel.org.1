Return-Path: <netdev+bounces-213128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C9EB23D06
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03E27A8859
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 00:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9651E89C;
	Wed, 13 Aug 2025 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfqqxIEL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C51362;
	Wed, 13 Aug 2025 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755044394; cv=none; b=h31DJwL5cWoKB5qV5MFNuPnUdOEGzVwvdEw/o9FrLnlR2y8ubmCjABG5Zr7rb1dyAD+JT7BPgR5lrdU2etRAPgQG/EFgpakzyOMaF6qLB7taCUiOcoP2n/jPehTKXlqQQwGQEg2LHmfhjt6KGtuF9xqFpBjpiJjeDjd02NCgKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755044394; c=relaxed/simple;
	bh=GbretOhKfd8D5jVY2EFHVl4zAH+L8m3u3zpnQYIopOU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rVkHm/+m8jnIlbWvvEFHo7BUKwDyy7UwyPRFBIaC1gM5/NmnG8pxya9bisOpAXQAOoo+buPOxCLrP8vF+fIm7VwKhp25aI3q3x5jiISZ+Qd3EO0pjD1jKooz5wYAR7hveF48ovkyUxEuH6Gmfo65waxApJqiitRmpL3pL3sM2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfqqxIEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D541BC4CEF0;
	Wed, 13 Aug 2025 00:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755044393;
	bh=GbretOhKfd8D5jVY2EFHVl4zAH+L8m3u3zpnQYIopOU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NfqqxIELN+LuVtWzKo4P5pusqp1kRvkoyAgunybwhaBnfnQb3lku13DEAgKgsV9Wl
	 gKF5aMFsZnwbOGJ9qlCLlvSNvIGagKOMAcdxvD2GKoVIkgGpHe6xkQPABVMcfpn0dz
	 zbU+AatInK0yaHUPXddKTdG0j5XnkV7iwT0W2+5CttBTmeQXDuG60+OYhd8hQva6Mv
	 xplDgEyIrLS9sAML6KWA1P30h34pFMQvdOBM6Q6O1qNiK1T23aGfHQjmNegRR+dZR9
	 DwRIMDSs6EzN9GG3oYU9qbEzycjmRUo19h9jeRxK5HYaB5UcPorfpz8KCSLcFsJGgg
	 /gQyddhU86qlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADE339D0C2E;
	Wed, 13 Aug 2025 00:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: Remove redundant memset(0) call in
 reset_policy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175504440575.2899548.5063021999695695145.git-patchwork-notify@kernel.org>
Date: Wed, 13 Aug 2025 00:20:05 +0000
References: <20250811164039.43250-1-thorsten.blum@linux.dev>
In-Reply-To: <20250811164039.43250-1-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Aug 2025 18:40:38 +0200 you wrote:
> The call to nla_strscpy() already zero-pads the tail of the destination
> buffer which makes the additional memset(0) call redundant. Remove it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  net/sched/act_simple.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net/sched: Remove redundant memset(0) call in reset_policy()
    https://git.kernel.org/netdev/net-next/c/b3ba7d929ce1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



