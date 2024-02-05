Return-Path: <netdev+bounces-69084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBA7849881
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2CB1F21160
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D2B18030;
	Mon,  5 Feb 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6kaFsMz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE75218635
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131430; cv=none; b=OAQcAwCBUQJks/AnzNS4QA7BsLZinUz56TcUgMzpWKa5Jt8NkZYYid+7+JN9o1MKg37zJ1RLwV3tUiXiXO03LQS3ZYT+06SmiGQrlXKHFJWcl5QsxDIf1BNo4k158dhsTwMu5N/tENyjO4xDDF7g9jFBg4mj7fnL/tSRU3t9e0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131430; c=relaxed/simple;
	bh=WnIyalDoTspfBRU5J0MqUOOBMrs8b02bQHSv2VKj24o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=efXvwOjRmto9nW4i+gzP860lFAhA0Adb4m2WAZYg7hvFs17Dftb4lr+zyEJw7Uz6bblCILa3qZVrwavgc0SIeHe2QiLMuzXYiyLg0VsWXnqRWqaeTWGyDJxJR7BI3GTFaXqa9Eg3UZI71UegQBuzAp1dKs5hndZ7DFt7OAl5T2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6kaFsMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F767C433F1;
	Mon,  5 Feb 2024 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707131430;
	bh=WnIyalDoTspfBRU5J0MqUOOBMrs8b02bQHSv2VKj24o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k6kaFsMz5GTltr3YBxjSY5Z9hdftX+JRxgFTKKAg0PWp27xu+q0FY1/3QYcMDGXUP
	 eFdi+1zez6dRsV+7uLCULGWRC2k5F78isEH2TbvzrmrhCcv4E98//giJr0uKOgSGB0
	 BgBPc2XtIpnEzkw5VQw0PzdsdLtTJtcyha/JpbUgn/D3N4Jkls4mar391GWy6GLYpa
	 YcgzohYJus24JOBKjdW3puqgV9JWjRpSZgksulb0Iun+q+xAMd+ORglVS26FL5PZ3O
	 fioW+cVYyzHgzNiIPE6kA3nMh9z5rHH+jmsBZAdoxEUPrMTTx2PlM33oojeKgrdeBO
	 zm3/OQEYwIgWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 285DAE2F2ED;
	Mon,  5 Feb 2024 11:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: preserve const qualifier in sctp_sk()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170713142916.18522.6986184331232190402.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 11:10:29 +0000
References: <20240202101403.344408-1-edumazet@google.com>
In-Reply-To: <20240202101403.344408-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, marcelo.leitner@gmail.com,
 lucien.xin@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Feb 2024 10:14:03 +0000 you wrote:
> We can change sctp_sk() to propagate its argument const qualifier,
> thanks to container_of_const().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Cc: Xin Long <lucien.xin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] sctp: preserve const qualifier in sctp_sk()
    https://git.kernel.org/netdev/net-next/c/89304f91bf8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



