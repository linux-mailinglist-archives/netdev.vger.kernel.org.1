Return-Path: <netdev+bounces-188520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D062DAAD2D2
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7E79847F5
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 01:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B22F14A4C7;
	Wed,  7 May 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTXlVwOF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1650213D8A4
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581397; cv=none; b=YNslwPIMkfawnBC6/H67ZUb4JRxZFOGyZHra8xOt1E7hLT5rWWA6t3rs23vl9VsPLHyuogLHD5UyqyKTgFaQzPVhSZB2exsLFNvpFvVj2qNQ6601XlVLRUTqM7pjRVZ9IXY+9sIP2EeT4oe29VmO5KCNzx+gYUhhW/ovdBqpZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581397; c=relaxed/simple;
	bh=8C65zvYMy4llaIbv1x903rQigtKudOB1bsRHEeDYNdE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QbB2FKpJ1LwSrPKktQf0Hn3/UqAmIAnnJYQ0plUgITtaKzq/Nj8oHA9sFULrWZsYJz3YStx5nDjKwCPZdohJhXCrIZFkxA0eMBz26TrzxQQUX718zWPawTOTjihI0UpVV2q7r3F9bZPe7WE+81pZabGvGRscJxCDWI8LagLFf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTXlVwOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643CCC4CEE4;
	Wed,  7 May 2025 01:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746581396;
	bh=8C65zvYMy4llaIbv1x903rQigtKudOB1bsRHEeDYNdE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XTXlVwOFnsEr0KHgKSHiwLKbnWYECCJR0iZYKtQ+7SHBbE+9hXvLINNiC1G/XTMcZ
	 Bm8RaJI/KWIjCoRIK6hsfVbH479O11aQ0NOtO9PocNJgpZoRmbGo3VMAyZ6HmnJLNC
	 G/CLbYyz/I2BFoU2gO+936fHDIisZ1anzYluk6+35B77ed38tRl5TfbxzSo/vHI4Zb
	 6mMqnREBgvIDttkiLjFx9kb331Cn6VfVS//l0e44kEovaIcFSLHfPp2GbgDn2ZWvmy
	 L5RC8oZtdUWUekO2C4kpqCC9bKzfMW9LdtGEFWDfprm/qgCnPz/gRf3Xn2qnLCOqdE
	 W5yDTdqPOjjtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBF0380664B;
	Wed,  7 May 2025 01:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] io_uring/zcrx: selftests: fix setting ntuple rule
 into rss
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174658143526.1703446.12972488000184730386.git-patchwork-notify@kernel.org>
Date: Wed, 07 May 2025 01:30:35 +0000
References: <20250503043007.857215-1-dw@davidwei.uk>
In-Reply-To: <20250503043007.857215-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 May 2025 21:30:07 -0700 you wrote:
> Fix ethtool syntax for setting ntuple rule into rss. It should be
> `context' instead of `action'.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  tools/testing/selftests/drivers/net/hw/iou-zcrx.py | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next,v1] io_uring/zcrx: selftests: fix setting ntuple rule into rss
    https://git.kernel.org/netdev/net-next/c/df6a69bc8f31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



