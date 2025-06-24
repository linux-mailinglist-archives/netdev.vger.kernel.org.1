Return-Path: <netdev+bounces-200443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8FCAE5849
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0FA4C0406
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE042A1A4;
	Tue, 24 Jun 2025 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvznSZBP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418E27738;
	Tue, 24 Jun 2025 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750723797; cv=none; b=QYmADYyDiaT5us/0dVMPDob9c8tZUhBfz47tNWhE33vPUEwxcpycWDZ6Hz7LKm/WeBtWZb6eSNM3+Trl6MU1lxG+DYjo1GhysvmXhKjNeabuC7jOelhkT7iUnCE6YKKCoZWeNrATzX4IBwBuv4iSAyaJ0qzusnRb8dkz9teCKw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750723797; c=relaxed/simple;
	bh=LeSBLAI5UXOVYW8qtsIPlF85pWA0/neetvasTOKF92A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PR9bd9hZ0w9i6YR8xns5FA6moYTpp7VgxkLNnD+/I88j8+22Txh9wnafkr33CfXDmhKUUSb08G7r4SddKl4oO9Klq3/wGdRbu4G7n9D5r0kNTjWQghJbH2PaXa5pXmWddL37Yrb2l5HIV4QcCrNnQvaK0E/TnJknLHtESnCxc4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvznSZBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A642EC4CEEA;
	Tue, 24 Jun 2025 00:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750723796;
	bh=LeSBLAI5UXOVYW8qtsIPlF85pWA0/neetvasTOKF92A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UvznSZBPIM5+cfR+45ITLy7JUSSVUaSNBE5NWP3BCKgPf0vBo3t08GSVKYkK6Fz62
	 vwZrZObNFBWJ5ssQrguailKSobc7PalPSVBC97RHM/y7/RNPhpESKM8ccvb/jCBMJR
	 MW9yrBk0+plJjM/kqCi9KYjynuCvUXQNOg1eRfQOgm06kgko8AuGTTsOS0locrFexb
	 pegO+MH1ajJrrOctjZk9aMVYFBB41PmOYkQg9a2rZhYwegyS8qbO1Zv1b5PBC3Seac
	 ayIxYY/u8YzPOD+pTeLnGqCX3ic+4sE/m/t8IgUkYaGlDxe1zc1c1GuekW70gfRK54
	 tKWoEJEh2/XkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD2839FEB7D;
	Tue, 24 Jun 2025 00:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net/sched: replace strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175072382350.3339593.12642301782581151819.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 00:10:23 +0000
References: <20250620103653.6957-1-pranav.tyagi03@gmail.com>
In-Reply-To: <20250620103653.6957-1-pranav.tyagi03@gmail.com>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Jun 2025 16:06:53 +0530 you wrote:
> Replace the deprecated strncpy() with the two-argument version of
> strscpy() as the destination is an array
> and buffer should be NUL-terminated.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>  net/sched/em_text.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v2,net-next] net/sched: replace strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/b04202d6065c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



