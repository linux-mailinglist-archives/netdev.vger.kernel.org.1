Return-Path: <netdev+bounces-135794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF66799F3A0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294BBB2242E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50338200137;
	Tue, 15 Oct 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njZ/w/JX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A71FC7EC
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011631; cv=none; b=fCt3eOCAaFS1kJAygf1fka6Z+xHlcQPm0LKJ2b2bHEVMVVKrKBgaJvIx1DeSqcSGRaKLo2dcpX2eRYlM19hPEyXSGYjzBIqKKYKo+DkHUPqGBVK/sE9TxeyEf2Be/UNQKqH22IGdQSHYePyP/CzsE0aJLufcIYJScE5hfHD6qnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011631; c=relaxed/simple;
	bh=iUFq9Tzl5FnyMAvkbkJx0zE2mKb9lW4Q2TK3L0S6xJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o0wGAoAIel2hYRr8gemWLDFa507tDWzRSHzVLCVv4gkrxpDuJloUKYS+l+H4uq4lFTNj55TgpZBC4bRt2RaIoQqwF5BXyc6znmYlzfRHwVHX0eVNNN4fR60D8mmtOpGGNIXKDbdu7UQLmOpl0u5xbKgFtzfdMi6l9+/hoGGGIXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njZ/w/JX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA023C4CECF;
	Tue, 15 Oct 2024 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729011630;
	bh=iUFq9Tzl5FnyMAvkbkJx0zE2mKb9lW4Q2TK3L0S6xJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=njZ/w/JXX7zHZ5bqJOiX1Xpalvu9/v4x/ww6wPWDPKNkgtqRs7wOvuxF7Frivm+jp
	 kM6HLILeOnRd1Aic3c4a+/r6Qg7f6SZ9bQJnmtH8TiUONN6J/lBpY4083YIyx/biaP
	 /4Aan8NOTJBosWX2oNkwyRWc26rhqMvO7OBVWHYa+lZAVTQr+JwR31SnOCLOgpBVXy
	 HNw8RI/TCwwgqsqJLJkNxm9W9+Phc1Sh7s0p+XPXqCBKQNplWhR32mRlMbPoJcSeON
	 lurvl5j9O8/Gd2kYE3it/trNB+gt0CjPbeuyVBn89ZwN4RcNSb6y2rjlORKv2eAaz/
	 AhtvyQak+46EQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C0E3809A8A;
	Tue, 15 Oct 2024 17:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: implement additional ethtool stats ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901163574.1227877.1381310880911148368.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 17:00:35 +0000
References: <58e0da73-a7dd-4be3-82ae-d5b3f9069bde@gmail.com>
In-Reply-To: <58e0da73-a7dd-4be3-82ae-d5b3f9069bde@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Oct 2024 11:17:39 +0200 you wrote:
> This adds support for ethtool standard statistics, and makes use of the
> extended hardware statistics being available from RTl8125.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 82 +++++++++++++++++++++++
>  1 file changed, 82 insertions(+)

Here is the summary with links:
  - [net-next] r8169: implement additional ethtool stats ops
    https://git.kernel.org/netdev/net-next/c/e3fc5139bd8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



