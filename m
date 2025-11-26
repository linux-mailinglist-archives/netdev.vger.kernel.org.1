Return-Path: <netdev+bounces-241768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187FFC88047
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B5E3B2A84
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9C730EF72;
	Wed, 26 Nov 2025 04:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKQg+rv3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC030EF69
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 04:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764130250; cv=none; b=Jgb4oyKku0hVXBTcuMEiDfNXuDltALYRW1X2CkCAukVx1B60snB8GnncX0wXc9e0LyOhXGXlZGNJNe0VdvKZWu8Dg4B9zaUGOJl21a8HZtdKKpKEHV5nc9OC+IF8tBkxMU/JD3+KIDYfip+PfcgTUpvDsV/huzzbUUuIIbz44XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764130250; c=relaxed/simple;
	bh=4eG6Lqi4LDD/d5FTgEs5iO42fNmWVGIZRJZQjeCdBzU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uhVaxMbFoWkwmx1E5lDtfRH8+rZSp7TS7yAPyf6vSeAx1UJXQrLcjpMrTWRCw/4gKkI4AcpNEY1XcOhUrcnANp7nxizxSJ4rNblp59DsEblfB8NzZWXbT1nUGUte5i3XNrh5M/V4yJsn6dyYGKxD2f7aPUAuoFzAxtQhGyRdpMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKQg+rv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43493C113D0;
	Wed, 26 Nov 2025 04:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764130250;
	bh=4eG6Lqi4LDD/d5FTgEs5iO42fNmWVGIZRJZQjeCdBzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mKQg+rv3fCHXMxzed9BtTiZULCbAyLGCd/i3L8IPIVURZVZO4d4K12HNVQz80usPX
	 HKVYZFOowN9SiWK37aRtp5HzTmghJ0C/8rlo0kOrxd9Kk/eaHYhBE5xL+0e4PMqGaF
	 Oe1Udcb0I0qEuHqyjylrUG2k00Qw2BZx52Ger+OleJbfEQ7F0RXVGIDhh2tUfoFNiB
	 zCptfFrXHU4KoA5/3DXV54EnKegidvsLp2mQi7WeFebB7xiKaet4bdPee+7HfufGdx
	 XZb1cOp5EdD/l9jRltvrAO0UYcKF+vdJovTgqfrSH/4yubxTwnq0C0Rz+doTv0kHGT
	 4zX1myfPcuM1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEBE380AA73;
	Wed, 26 Nov 2025 04:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] drivers: net: fbnic: Return the true error in
 fbnic_alloc_napi_vectors.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176413021233.1516345.1543355168305878875.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 04:10:12 +0000
References: <20251124200518.1848029-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20251124200518.1848029-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, alexanderduyck@fb.com,
 andrew+netdev@lunn.ch, mohsin.bashr@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Nov 2025 12:05:18 -0800 you wrote:
> The error case in fbnic_alloc_napi_vectors defaulted to returning
> ENOMEM. This can mask the true error case, causing confusion.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] drivers: net: fbnic: Return the true error in fbnic_alloc_napi_vectors.
    https://git.kernel.org/netdev/net-next/c/ab084f0b8d6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



