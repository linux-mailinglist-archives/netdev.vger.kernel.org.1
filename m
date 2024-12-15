Return-Path: <netdev+bounces-152033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF0C9F2668
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 23:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AC9B7A103F
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F18F1C5494;
	Sun, 15 Dec 2024 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mtfu3Gsd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8731C5481
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300014; cv=none; b=ISTCuv8IPba6ZuhP844osdhhkbeQpjCY8nF0SKq/DLoBJIeGxCK033CFwcj258E4ELRBlUyZ1gd088W5JwFkEU6UBYcYgPgf7scnjtYmOXedV7nT5dNon5k6o2cOEkrZ8Lf2aRSaagU4+isJIWkYf4jFScfL239BiagKO1dBMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300014; c=relaxed/simple;
	bh=f6qtSQHkehkof8Yp9AW8ZTZwMkCtKjT7NDg5iVC4eqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VYtorZU4ATpewWycBb/WwoasQorheySj07oAVBkiJzux/bJUhgRqKmjHYaNUUzZ5UL1PPL2wppcscQNU1tMLwnSgcH7B7zc2clqnr599w1f1Lc+iqAvw0NjXu+uLzZGoUcJ6zYtxLha8Z9QxlL7WaXpTXEYTdLUKuuD0qMPm7kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mtfu3Gsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FABC4CEDE;
	Sun, 15 Dec 2024 22:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734300014;
	bh=f6qtSQHkehkof8Yp9AW8ZTZwMkCtKjT7NDg5iVC4eqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mtfu3GsdiGcuCmjMcv/Yx7m+nd3rhB6e6A00NCHqVZBdx+9VGmeo5f5ofIBZsSmvT
	 DN2WByuQ1jZNqlBKMyFhvPWJAUVy/ruSDGjqWZY+xBMiixmCw8WRmEFG6Q+F1wENE6
	 6MOfcAMVs4/dJ/KkXV12y8EKpbQJM3uFFBC4KGjME8yRI4EbseiHfYCb3tL6FNv2sh
	 46sB8UoNoD9QM8AiNMrZAeCkyjMelSjjofMNQ5r+pPBDiQROrbz5WNNH7UVpQ/kI1H
	 +4u1nzimD1bVV0ps+bcO419c+fLilCPmOVcfFnLrWrquju6TvrIBkGIJB2+5G46z0U
	 fCrZT68NHPifA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 367433806656;
	Sun, 15 Dec 2024 22:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] netlink: specs: add uint,
 sint to netlink-raw schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173430003099.3589621.440237780146966190.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 22:00:30 +0000
References: <20241213110827.32250-1-donald.hunter@gmail.com>
In-Reply-To: <20241213110827.32250-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Dec 2024 11:08:27 +0000 you wrote:
> Add uint, sint to the list of attr types in the netlink-raw schema. This
> fixes the rt_link spec which had a uint attr added in commit
> f858cc9eed5b ("net: add IFLA_MAX_PACING_OFFLOAD_HORIZON device attribute")
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/netlink/netlink-raw.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,v1] netlink: specs: add uint, sint to netlink-raw schema
    https://git.kernel.org/netdev/net-next/c/a35d00d5512a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



