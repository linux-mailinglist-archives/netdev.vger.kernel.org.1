Return-Path: <netdev+bounces-207298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCD4B069F6
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03374A310A
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 23:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637402DAFB9;
	Tue, 15 Jul 2025 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/61GWtx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0242DAFB0;
	Tue, 15 Jul 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622794; cv=none; b=M4d3MwIIL8VPmJC6B2RRu63IQ/C6D0jjBzswH8/AQ6ujtCtIVWWAdzUxop6oScn87GeE0OCPVyOISHxb/kPSbc0LEOEwAwIUcV9PP+WTpKy941C3VY7BSN6UEYqnPKJ8HoOQ/e3f6v1idX5WhGcZ3Mf4pQXVS3RVbQdAtR9/kZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622794; c=relaxed/simple;
	bh=RKoLZjYjMewwzYDaxldtjmdIVQTQjGHg+KTdm9LFeUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jBs8MTr2nOq4L7aBXBdI1vwCKxvUEy5KzIitCskfVqPZniE/tAzuYc8cS9YrOn9CgcKE5Mmqr3DlEPjqKo8Rua1459ahz8eD2UxbHZAnYYV4LFDYt/ONK++LzzydG7eOf3dizUSEg4iSJtF9s7nrMUZHBAE+1RjJoBlM3ML1jK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/61GWtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1584C4CEF6;
	Tue, 15 Jul 2025 23:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752622793;
	bh=RKoLZjYjMewwzYDaxldtjmdIVQTQjGHg+KTdm9LFeUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z/61GWtxD/bbdTIRxSM6181aRcpKXGNTEC6goSDq17ouabluS1LdfQ61ibiCq0Q9L
	 75G8T7GJDLZRUVnxViFNP0H/LcVf7z8cesJS9D6wJrdSf1FI/OSNRbPDDrR16dT67V
	 FWCrciIv6ad84TYMqUr92bSzyrAP7oPBEzrG1A1658/TuUQi15KkPfuF75gPUhhD4a
	 hNAb3g24MjhLIRDoCE9hRvxbSTSZbsZDPSRN6xu9vq42b4H5HxL1M2MBeOyMWm97Yd
	 40iqtFkYRUz+SbEtaQAhJg+MgLfk9fj+qOf/mCAs/kpwCaSk1i5+Nqco1r26R2uXsB
	 tma7TRm+CSb1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D76383BA30;
	Tue, 15 Jul 2025 23:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: mcast: Remove unnecessary null check in
 ip6_mc_find_dev()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175262281425.617203.12056812500600130761.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 23:40:14 +0000
References: <20250714081732.3109764-1-yuehaibing@huawei.com>
In-Reply-To: <20250714081732.3109764-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Jul 2025 16:17:32 +0800 you wrote:
> These is no need to check null for idev before return NULL.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ipv6/mcast.c | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] ipv6: mcast: Remove unnecessary null check in ip6_mc_find_dev()
    https://git.kernel.org/netdev/net-next/c/ce6030afe459

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



