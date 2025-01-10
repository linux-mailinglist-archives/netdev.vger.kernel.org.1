Return-Path: <netdev+bounces-157014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 425CEA08B7C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0AE16A6F7
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1579620CCED;
	Fri, 10 Jan 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtjP39C/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D5620CCD3;
	Fri, 10 Jan 2025 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500819; cv=none; b=rCSnSo/Tf2+nVgwdkNsfs/5K7rMHi6le0YVykvIazfUq9+/KU2qsFR1zusOav/eByrascX43p8C/thwP+7BwFAmR1QA/WofHIiY3qQAVZTr+uMvJ8ozTpF/r6TKj+t8vlpkuHpK5vvh/7iyjxFO7I9bfBbv+b25JX+D7l8C5hDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500819; c=relaxed/simple;
	bh=VeDI49zvlacQ5E06cLCPVV5Jdc1rsHBFnDgFSM37kmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WASQ2EvleAVskpervFjdRBS4IZafWhffSztOSF0fUNB5PHdE3N20S92ezzHUZDP4PIOZ/fWjX8Pf2zq7tG9giSCh9Ey/BqXGQ8HTYflepQnwAjUkeHEKaJLAdgUCM+WuYGAxosaPUaojhVJuF3iTT+UT3/N1skIU4xPWIROsUQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtjP39C/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD7FC4CED6;
	Fri, 10 Jan 2025 09:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736500817;
	bh=VeDI49zvlacQ5E06cLCPVV5Jdc1rsHBFnDgFSM37kmI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VtjP39C/+I4+d+PT4hMzLQF8G+T+dpv8w+PKJjc3D5jkhQZ2o+r0nspF0+W6pcIr7
	 mYf3eOn4kpEbRo4Ml3B/Y9qka8yuuxYWa7gZ8GR1G8tRbMs8sUNq/15XWYZidUJvH1
	 Pn//hc/hQKt3LGDkS3EwFtPjzmelUQ3Sk4ki3agbV/z0P67f0jMeXcxNTPX51ONFnK
	 QiRv8sfYF2ACy3z2m8T4vDik3DXYDlXJh/IX9Dh2DL18kw+7gqD4yTbF4S0+sUA6kp
	 F+csWjfJfasSRt9/qUohgR/V16y6Vrbwhmqqu3YoWX8AEfqteQHYUBkw64X9iMrgcF
	 6lGyJayJvx5tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C0B380AA4A;
	Fri, 10 Jan 2025 09:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] net: dsa: qca8k: Use of_property_present() for
 non-boolean properties
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173650083924.1984486.13405379114067348863.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jan 2025 09:20:39 +0000
References: <20250109182117.3971075-2-robh@kernel.org>
In-Reply-To: <20250109182117.3971075-2-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  9 Jan 2025 12:21:17 -0600 you wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: dsa: qca8k: Use of_property_present() for non-boolean properties
    https://git.kernel.org/netdev/net-next/c/9007d911f6d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



