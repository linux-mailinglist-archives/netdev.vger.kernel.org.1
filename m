Return-Path: <netdev+bounces-96394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B82218C5976
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 18:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588BA1F24D1A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E3D17EBAB;
	Tue, 14 May 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFqV5NV7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B417EBB0;
	Tue, 14 May 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703034; cv=none; b=uLU5lGz2NfnnT6t/lRY3hJvTqRarWC+9ZgjNliZg/mFYSIB5F0EyzbMqu72LKc+sWtNrXQjeOG0zMG3FRSJQ9o1PWlE4vsKBA7LK2ozfuGpc4OLTpzdiB41YauXMByE1q+rTC7gz4ol/K+vC0lpFgEB5LqrM/K7929IE08NvU6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703034; c=relaxed/simple;
	bh=0gMME3/8+0ohidR13h16OaR+db8d1N5/6I9aR24KT0U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uPQ4ZhbhJrCCE2Uv7pPUTb9t2QcPMsMw+/eJY4q72joijU+80KQzCqB8vw5Hhmztu60xIHDoJHKX2Z7uUTvK2o8JTU2Zh26MnJ9kCTC4Hj+SdoRZ1Iz8KKAa+xbZeBqwkaOwcc7zURLJW5oMkl0RvfYgVwsJe3j3HO/mtMPh038=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFqV5NV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41C3DC32782;
	Tue, 14 May 2024 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715703034;
	bh=0gMME3/8+0ohidR13h16OaR+db8d1N5/6I9aR24KT0U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kFqV5NV7DyUaEruVVYUvo5cDM8xrwi1y8qwvjbKp2iAH/2ak/gF48DhTjF0UYlT1E
	 1mv4Me4egf7WYFqfOzlTKACVpowlkFUp6db3AeBFJjChxAt5AWtX5YvRNJT6D5SUDb
	 P2HLZmzEPrs5MmqzBFfsWAaGrru77mye/GFvhT9CwarDY6tXjwF0BAOUiBxKLt83WX
	 43or5lsEjzE+UvTo31isKy8VTkDGorsB7oC2ONgTLXEL1bKEM8Zhwp+nZmprF2d95q
	 3kn1fS0NaU4aPTk7yPKq/W95UcibySzyTkJmhDe+DxWy2utJyyP6E7Tq4whCJdnAXt
	 79G2ZNY6lyV5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 319B6C1614E;
	Tue, 14 May 2024 16:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2024-05-14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171570303419.20518.11804260236735126444.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 16:10:34 +0000
References: <20240514150206.606432-1-luiz.dentz@gmail.com>
In-Reply-To: <20240514150206.606432-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 May 2024 11:02:05 -0400 you wrote:
> The following changes since commit 5c1672705a1a2389f5ad78e0fea6f08ed32d6f18:
> 
>   net: revert partially applied PHY topology series (2024-05-13 18:35:02 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-05-14
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2024-05-14
    https://git.kernel.org/netdev/net-next/c/79982e8f8a01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



