Return-Path: <netdev+bounces-140054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A199B521A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F33AFB22003
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D34201020;
	Tue, 29 Oct 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2/XSisc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F6199951
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227830; cv=none; b=SuJcjS9eqdBJkjjEFxNeTmC4pN4vk+g2uoEAM6Q0bxgNfYOFx549B6HfcpBU86TNcV7qSwML8QNaaUy2Ub5sUStbDpluDw52xCPR9z73T4JolgcKJg5oGMf3EY8RQGTeh0beAN+1Ix8sJtsP88efGSk3GSOmyyW4iOCgRraJ/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227830; c=relaxed/simple;
	bh=3/zRnKNor76whfu8jBMBsKA6ZdO3A6i8RnWl+PkxfEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IN2NPmXX1PDSYLHC3Yw1zFzf/wbawYLvhzAdzFu3fAbG3w1s+ni++sML61SpXy9GZMMmWPVAK9LzKR+mqId2WN5bofVcb7uh9wxibh4aen4Kgf4tobwRKHQm+H0eshRby9Zgbx9P4O6EjjKmCszmSvGHDphfBiBfPU2jKPpCpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2/XSisc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7596C4CECD;
	Tue, 29 Oct 2024 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227830;
	bh=3/zRnKNor76whfu8jBMBsKA6ZdO3A6i8RnWl+PkxfEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S2/XSiscmht5aWbcfJ1DNLTXgMiBbjGi7im7dq9xy7rWUtbPr0drkUIqChhrJkQ2Q
	 UOGlr1w86SAhNcClPT2sjLC6/+ffVj5VqghLJWQpF6+sZA1U+FskzTMQawobMfjsw8
	 esxuC8QNzIVhrQzslV5pA+RzxTcSfmCzWvwBySpbaeodTK6gcyyWO+RsTlb6y8cK1w
	 YWzxrVRzS3BqGBnT6cdwL3FuScv5M8zneAt3oml+zGz1pZvw7YcPb2z87hHRlON1WT
	 BZ0KjIaFyjlOHSu7hO2Vy9DK+uax+0MXfUJPtZj4lxwMAekC3Mm9/7afTEZ57/6hPQ
	 t16MOoM51Kamw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0C0380AC08;
	Tue, 29 Oct 2024 18:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] netdevsim: Add trailing zero to terminate the string in
 nsim_nexthop_bucket_activity_write()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022783724.787364.3963600825899239254.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 18:50:37 +0000
References: <20241022171907.8606-1-zichenxie0106@gmail.com>
In-Reply-To: <20241022171907.8606-1-zichenxie0106@gmail.com>
To: Gax-c <zichenxie0106@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, petrm@nvidia.com, idosch@nvidia.com,
 netdev@vger.kernel.org, zzjas98@gmail.com, chenyuan0y@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 12:19:08 -0500 you wrote:
> From: Zichen Xie <zichenxie0106@gmail.com>
> 
> This was found by a static analyzer.
> We should not forget the trailing zero after copy_from_user()
> if we will further do some string operations, sscanf() in this
> case. Adding a trailing zero will ensure that the function
> performs properly.
> 
> [...]

Here is the summary with links:
  - [v2] netdevsim: Add trailing zero to terminate the string in nsim_nexthop_bucket_activity_write()
    https://git.kernel.org/netdev/net/c/4ce1f56a1eac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



