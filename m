Return-Path: <netdev+bounces-131850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A798FB78
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 02:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAF5282647
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8F317C9;
	Fri,  4 Oct 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrC0Okmd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5821819;
	Fri,  4 Oct 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728001227; cv=none; b=fkxmZvenSX79Z1F7QKl+W1IuyyEIe1ae/ag3lVbHJqN5XQ2nu8ty/Eno3+0KNZnrxoTTF1g+/9pNzWCBQ68bDDNFqE+nF9o9NlLVdHdXshq0fDY8KcOFmd2JTV/8v4QRg9cZWan1Sujqyx454D95UJM7gObZiim602YBYCn63ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728001227; c=relaxed/simple;
	bh=HrHv/cq2auJkqLhrr5QhZ7TIhsDa3ONViDZyHiYxNJA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KT8qEp7/3u0obqsorOmi34V3h0cA3oj62CkPEkHq2cXmfEe7EAI630EoT3h+FrvreSo6KptcqCH/T+VzhfYz6EYoGkzOGylc+RxY2UejPP0chcCHNSb0ZOGzV965/S3hyrbBfqyIp++XFJrMHBTD4XLiU+7OM+25b0cmOE1iq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrC0Okmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E5AC4CEC5;
	Fri,  4 Oct 2024 00:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728001227;
	bh=HrHv/cq2auJkqLhrr5QhZ7TIhsDa3ONViDZyHiYxNJA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lrC0Okmdrd/xRULwNQQW3ZFKtxJu0XGLevC/+KQIetPAr1nxcVFy28n/frLF4VVsW
	 JoDWfMslvAZ4o6+VG88eoUpA/USMxQ8N9JAYR60Y07CwkNWEW01b7BLBuJphxDPMgL
	 CzaEfYUKKhjl2Q2iUPOsSYw8jdBfFhrkzlScRf7Qx95xIQ6UcpiQ2ki349q7gOBeXV
	 gMYPTShtJtWNbNIWB+oFTgEwLY0bhiLjQb6g7GxQUH73ez3xaibvr4zyrgpmOcWt4L
	 9ewlwoMJo7YcCZdXRgITxMrlXhmJdPhIrYRoG0hMKTo8x05+FxAX/efHfXLStyg/X2
	 Ahd3Z+V+6IKag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB51C3803263;
	Fri,  4 Oct 2024 00:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: marvell: mvmdio: use clk_get_optional
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172800123077.2040819.4386417362818411671.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 00:20:30 +0000
References: <20240930211628.330703-1-rosenp@gmail.com>
In-Reply-To: <20240930211628.330703-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, tobias@waldekranz.com, anna-maria@linutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Sep 2024 14:16:28 -0700 you wrote:
> The code seems to be handling EPROBE_DEFER explicitly and if there's no
> error, enables the clock. clk_get_optional exists for that.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/marvell/mvmdio.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [net-next] net: marvell: mvmdio: use clk_get_optional
    https://git.kernel.org/netdev/net-next/c/4c5107b8f508

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



