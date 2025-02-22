Return-Path: <netdev+bounces-168704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0286CA403DF
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 01:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4763BBE26
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75392EC4;
	Sat, 22 Feb 2025 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDb+QXvZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8992F44;
	Sat, 22 Feb 2025 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183000; cv=none; b=HGqTrAapVvGS2M8m2Z7VN/QrJCJAGAu7P5xCnK2SJgIlOKe5iKOvwEm8d/P1UoaeA3gB1AaNedII+WsycdOhTHPWQlL0wLapSFkfG96Dr1PLaWNd+IzjFxCWf+S4KEY/GjzIMQ9O3P799hHTMgBi/p/Ei7LVGCXIk4irt/qc4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183000; c=relaxed/simple;
	bh=xvnjybrNFVdK3LyrbwxvJpLGDQlm5bpWMAEAMJfuZqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OT81ua/YLg2/GfXHXlXlJU7jWSdCZ8/s3HW5ZcHg4HPmWc8gGh8aGDc1P3qMrT/MdIyXp1152XmyL6GFoWzTU2sALKw1RJm2P7ZeG4Mw2XuGViGhFlbqdatdldtB5jDolSAU6Sqsp8o81kMXBzzQfKBJrW7rAd8ZxUqsqRkrcuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDb+QXvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9689C4CED6;
	Sat, 22 Feb 2025 00:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740182999;
	bh=xvnjybrNFVdK3LyrbwxvJpLGDQlm5bpWMAEAMJfuZqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qDb+QXvZ/cjjVT0J3g8iQtrDQPBg2SzKnn8kbXZaeZQ4k1wFd7ETcvyq4zj3fqHmt
	 vQk10kWNN+G13o6luKhtODNhUeVxf7LgcTj6qLhuh0ChQ3lR5gMlzxL8Q5/VHofcaN
	 5QFHO+boWHEdkvwR90zQaZUuUHt6/PUEaLAhCUk+3BnM4wilagpuBetedIZLaS8Ii9
	 W6EmQsETFpcXwq78hMQI79oELacxrHX4d+4qpM7+KOpTqpGxoiGofzj4K0wJ01ow8m
	 Zyt8KknrRyvX4ZSxvLEVJq5trlT7B8Y091dJZcintEgfSemjXgfM6tCcFT6qh28DVz
	 y2AzvXFegoAtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF24380CEEC;
	Sat, 22 Feb 2025 00:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-02-21
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018303077.2244175.3324115097731024430.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 00:10:30 +0000
References: <20250221154941.2139043-1-luiz.dentz@gmail.com>
In-Reply-To: <20250221154941.2139043-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Feb 2025 10:49:41 -0500 you wrote:
> The following changes since commit dd3188ddc4c49cb234b82439693121d2c1c69c38:
> 
>   Merge branch 'net-remove-the-single-page-frag-cache-for-good' (2025-02-20 10:53:32 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-02-21
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-02-21
    https://git.kernel.org/netdev/net/c/fde9836c40d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



