Return-Path: <netdev+bounces-209393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3443CB0F7A5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C0F7A22D5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354A8136658;
	Wed, 23 Jul 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZgYYE8e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C63FC13B;
	Wed, 23 Jul 2025 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286348; cv=none; b=epVgHMtWb4C4T47xr22yboeLwPLvbuPMohOdxjsUoiUqz/ev04JLHDzt1falulMIRxsGV0nno3u6u3AcPaTU2cjoVBzylr60pwhbyBUYjfVCEzJS6YxPv/4z1vhD8w2d5O2NBmCG16Gf+Y2kqAt+55F1tYR9E6m7sx/NM7o/En4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286348; c=relaxed/simple;
	bh=zYsfGJPhLWqaMTSOpwiKezsjWX2IK9hiH+Nv2/rkCwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jlkyS1gNEPXpmp2wrLGA4WxIIqrdsYAPJfiVXqvgpSWgVgF3h0AIjVx/sG+iKwtlaR4fpMHs2E5mzXP+nmGfA9QlesGQnU7g81lguhgXK/rOruxCwixOwKMIlmmgAuvcay3ph0am1BNL/KQhvhQyKyCOQe7JIGYV2i+T3vrFQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZgYYE8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B65C4CEE7;
	Wed, 23 Jul 2025 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753286346;
	bh=zYsfGJPhLWqaMTSOpwiKezsjWX2IK9hiH+Nv2/rkCwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UZgYYE8epk5APQOsTIsDBSd3R8JX0PI6WvlyMbJn/xqLmZs7kqXEt3GiViRxj0Uet
	 MlXSEIeGIMKwukb8CBouZXS9Cy9G1oXf1kPLZ0O/xN2VKgUZmGB+ZQQ9dOD7iUQYZs
	 79SSGXQYQRNyP0s7EuBTisHArKABfOrm7FfFXkWqNjrsBFTnl0jn3/xkDmBzuPn6bC
	 jo62vI1vnlDZO74tnFP5ZL1DaSVE7MW3gZgQ+++smSPMbkRqKkjToLRRIIC5Nln071
	 2V0aR4rN+fiaR4Q85tu4XHh8nt1pHam1b+nsYUG1zXDGOLzpzf0v1cy36r6yz77x+w
	 CbgHEfW8yTyYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2BE383BF4E;
	Wed, 23 Jul 2025 15:59:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-07-03
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175328636476.1599213.11414051934354031466.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 15:59:24 +0000
References: <20250703160409.1791514-1-luiz.dentz@gmail.com>
In-Reply-To: <20250703160409.1791514-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Jul 2025 12:04:09 -0400 you wrote:
> The following changes since commit 223e2288f4b8c262a864e2c03964ffac91744cd5:
> 
>   vsock/vmci: Clear the vmci transport packet properly when initializing it (2025-07-03 12:52:52 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-07-03
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-07-03
    https://git.kernel.org/bluetooth/bluetooth-next/c/80852774ba0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



