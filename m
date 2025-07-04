Return-Path: <netdev+bounces-204013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D93AF87C2
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E634A80AC
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C83222580;
	Fri,  4 Jul 2025 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGeA4xeD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8291220F5D;
	Fri,  4 Jul 2025 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609526; cv=none; b=fB8ICje4QvjJmQJFJxvCS4oaaaLRONEaYbx+7gvkHt9tjkob3t9I7sDZ2caBKn6L1OaULKXz/QrY9cWHw6putXJOybKZ5FJY/xcUD7+ZHgsrgClCeFAzL9VbQzAIUDvbAPawL8zpZQvQRDhQfH469GPIo6PWHH/lw2pdcqmSsMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609526; c=relaxed/simple;
	bh=UAJhmXSQ2UIg/iM4/R3ACydcIHdhrjV55er8l2sNtVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CxxXx3AHHEQlYBlB3cD5IjPsO7ZOWt3rcj8h9AIrc5WTjskuhQqpmN07cvn5ZTizTpQEchQ1dLzedQzk/t6tYxTU4+Oh9Y9Xq++V792Jea0v4tXziloQmPqL6OyJLGL745IZ/Xj+5rvwiiK/spFLpAN/K3D3K7jLUFSE8Ab98JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGeA4xeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B3CC4CEE3;
	Fri,  4 Jul 2025 06:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751609526;
	bh=UAJhmXSQ2UIg/iM4/R3ACydcIHdhrjV55er8l2sNtVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NGeA4xeDkojGVtZ7n0GvVpoPe359CMwd84e3HpDXn0iNF7XePf/z0nvNRX4Wrb6Lu
	 WEXZRzsHtxXac7EWfQ8HhUt5WZz1VdjOGDb4s2m2f+tUpI0QvqS+Z49pVH0faW8tFo
	 nBhRGASCucjkBMYQSx36EQ5+ZD6papTsL3k+IltV4wmbW/8nEX+Hf9e0PXpFhB2U09
	 y1b981AYNhvMV0EmpXKVyQuoHTGDLFimYMur3h0CBQ/oTv7WyrjzLUSjdrnRimGXaL
	 sJXXnnPrqou9kLWI+GuxAx7uAKMdZY2NIsp3zVYF2RuvkTNjT3f8fvWFWlLJCVDc4t
	 OfXgz8QdpRgmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC84383BA01;
	Fri,  4 Jul 2025 06:12:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.16-rc5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175160955051.1721917.17772942882158762780.git-patchwork-notify@kernel.org>
Date: Fri, 04 Jul 2025 06:12:30 +0000
References: <20250703132158.33888-1-pabeni@redhat.com>
In-Reply-To: <20250703132158.33888-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu,  3 Jul 2025 15:21:58 +0200 you wrote:
> Hi Linus!
> 
> The following changes since commit e34a79b96ab9d49ed8b605fee11099cf3efbb428:
> 
>   Merge tag 'net-6.16-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-26 09:13:27 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.16-rc5
    https://git.kernel.org/netdev/net/c/17bbde2e1716

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



