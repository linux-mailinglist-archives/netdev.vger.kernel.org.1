Return-Path: <netdev+bounces-213538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AC0B2587B
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD311C06B12
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB6219D093;
	Thu, 14 Aug 2025 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6TGb96n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF02019CCFC
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132007; cv=none; b=f6me+J+/8SNXGIcoiSF/w7bu3OAw6mnfvzWiBSRd+J075zKn3Q/9BclRoMI478OPYv6bqhPoaGSr1Y+OhG0VhNX3hZE70GySnjjl+gJlt0cLKz3nRU2yH9hNw57u2Uscxsed1S9080BF8nGzOSwk/YSJB/d8siZ8H2bNM1dW5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132007; c=relaxed/simple;
	bh=qM0n+N8jEXc+nQ1WygjzVeXp/eNRoN+6kzLRrOF6qDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HDgOXqnWWlWuGrD3f5zKbAoinjj/WJIXRwuzAT0nFpsVouSGQykSRUNpiYntdmWfziVNYyxRhCaPCc4kh3qMdCTU6BkrZa5WnOnNgUKV51aVhJI1cV1hYwBPprBbpl7shO4Ec3wxb9gLCmtJVkZmRsza11Dq7k+eiMhMoextCr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6TGb96n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D39C4CEF6;
	Thu, 14 Aug 2025 00:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755132006;
	bh=qM0n+N8jEXc+nQ1WygjzVeXp/eNRoN+6kzLRrOF6qDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b6TGb96nukoJCw6UqbmYniSLM+WcYPd4ucMJY8ET0Aywc+1wb+qN8esFINCwwkAJp
	 dZrTzx/AySgX5tHUp9sReMYkP9oymL4mc3A2xG6Hhic0yNzwl9dpV9pM16wx2dlg4K
	 4m7Fj/y+xtwivwEdTMhGCmIRMKMYnyrhD/+sgZYxINO0IBuYSwa9sF1osIezcoZJ9k
	 mtNHHk0Q4Aj03AM8zyDKKt/c41NW777E/p6sSZGBQriZ8V/NT0knIymETV4SJcQPDK
	 zn9ubig9bQz5o6RYSi2J0JyrOgaqg5xWUSqNZWoaeO2tbJAYayAbK6BQFYYiKmzdLS
	 fFyuSgi4/RXVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AD739D0C37;
	Thu, 14 Aug 2025 00:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: libwx: cleanup VF register macros
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175513201774.3832372.10244056805436030828.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 00:40:17 +0000
References: <778899EE1D862EC2+20250812093725.58821-1-jiawenwu@trustnetic.com>
In-Reply-To: <778899EE1D862EC2+20250812093725.58821-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mengyuanlou@net-swift.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 17:37:25 +0800 you wrote:
> Adjust the order of VF regitser macros, make it elegant.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_vf.h | 72 +++++++++++-----------
>  1 file changed, 35 insertions(+), 37 deletions(-)

Here is the summary with links:
  - net: libwx: cleanup VF register macros
    https://git.kernel.org/netdev/net-next/c/30f7d4099fb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



