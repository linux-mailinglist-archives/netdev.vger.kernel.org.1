Return-Path: <netdev+bounces-186089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D40A9D0FA
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4074A5667
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD8021CC48;
	Fri, 25 Apr 2025 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgYkJmcN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9D21ABA3;
	Fri, 25 Apr 2025 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607669; cv=none; b=KfM0LdIOZqi4TY3yHvKkslyP3c4w07NTL5dxIkbUXe9Yb6I4NxKrdQ1KPm5WJQIjMkNK13HUWtsf5o2jzWUIR8ygyHtggWieLSKJeT7LQ9COwJK0j5M5PD9lf4IdtbHNgiSZqXm6LW5vnGVddynPLgCsT6PTVgvKcRSBUsFNCo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607669; c=relaxed/simple;
	bh=sjmhzgsqWETwophXCqtGaKo6D1zvvhXPRVPxckUmT1Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s252QDnnCuHVIQiXi3GK9uWwic9bJVivpOdIeumIl5aSKwSLRmKX0cCSGf9nrscMfxD19RZGq5oWGriCE9xkyrNqd5BIvg1H6wivJqfeo8Iyf1EOP/0INfuxZBnCy5i2dQRxYzgHEnO252l1MGh/ZZ5FueYv0dP/qTDJtL25bTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgYkJmcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82437C4CEE4;
	Fri, 25 Apr 2025 19:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745607668;
	bh=sjmhzgsqWETwophXCqtGaKo6D1zvvhXPRVPxckUmT1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sgYkJmcNcSthBpK+HLDtDU0GcFzWt85RypmK2CF70OPnnf1jW8tyKcNwCCStyAJll
	 g82YHx5JZoiSwFGba07l333iFw0YhC4NQPcyxQRz1rwh0No6RvUs3B0p4JaL53cYJJ
	 9zPhiYDQh2tf389NNbDzrMefFu1IShE/8AfC3oYp9hfQVCyAKho1hIORxsHtyEevZE
	 KKqxE7rRRn8BRRtOAu32EuvCLeP5ZNsUakfatF/jb9YXOC9CMFeZZVvxlwmThHE/0F
	 UfNxc+ik13LM8D84vnEyAlurBVqaJikwLzAGD9pQRIv/wv3VWM95eG+wrLK3mqFGbW
	 yHNLpIVO88pVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71178380CFD7;
	Fri, 25 Apr 2025 19:01:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: ip_gre: Fix spelling mistake "demultiplexor" ->
 "demultiplexer"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174560770704.3803904.4220032486638113159.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 19:01:47 +0000
References: <20250423113719.173539-1-colin.i.king@gmail.com>
In-Reply-To: <20250423113719.173539-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Apr 2025 12:37:19 +0100 you wrote:
> There is a spelling mistake in a pr_info message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  net/ipv4/gre_demux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] net: ip_gre: Fix spelling mistake "demultiplexor" -> "demultiplexer"
    https://git.kernel.org/netdev/net-next/c/4134bb726efd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



