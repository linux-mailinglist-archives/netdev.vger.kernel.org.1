Return-Path: <netdev+bounces-241748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CE6C87EEB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14213B3F73
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6430C629;
	Wed, 26 Nov 2025 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOChsFRy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2DD2FDC30
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 03:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127247; cv=none; b=HNHdU/uGr1yrjGLiTNeoqjsyTu61WyBXbGoFnlnxwzioduFENkelrFhQe1aw1XrgXtaQIEyLQRbC4F9Q+eazKcO8RlyaYq/2JLS9fW2QCz2FeyUE1E/lkc1qTMrZf5WppRdAWiiTdnwzNwm0s4z/NWpdSLb+WymX1yxXnuf8Flk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127247; c=relaxed/simple;
	bh=nsk8kcNgzUKGTmUqOgnUXNTQ9h7qlnVMPUVQMxncnng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iuriQ1fs9P/6RbnGdYr7LRb2OnWK8CIDBgrLtfqYxPCi+Br3zZXDxNjKVD+aUyodR/10whBq6a8aBgWO/TrVZaOZtHWrBM9mlY5wR55dfnuxLaFCG/ovwNPTRVRx+soL3yvd0eTXFROGaiVBPtRFizsosLRMsDtS+4xaPh6kvfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOChsFRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1859C113D0;
	Wed, 26 Nov 2025 03:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764127246;
	bh=nsk8kcNgzUKGTmUqOgnUXNTQ9h7qlnVMPUVQMxncnng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XOChsFRyCOcA8um2B3SNayq6HXOvQJJ7SVTl4GxT3s3LaxDpvR4iD9UVm2PIzg5lU
	 EYG7SGe1Ygv1x58FHEGyNL5FBKFtzh/B9bnMewuHZHffxpekeIrwlPGn4eqyA9cnQ7
	 IdeHmBQfaSMNuSP8w3hY1wjCBP2V0uzfaaulJyltVgPo9wxRCdvLRqfcjChpSNlWuY
	 mKhMCbmz3M9v8QyUfLASNlhkT9N7LB9ZdOX9A5OlIw8DrXf3etLsKyj14VG7Ho2D8+
	 BJ3KxHoMY6hyMyXy0Ib/FWsmQmxL4Lwkh3pRjDGIBqja5Jctjpo0bTTpr73lrPL2bZ
	 i/t8O2Yecgirg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CD3380AAE9;
	Wed, 26 Nov 2025 03:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESUBMIT net] r8169: fix RTL8127 hang on suspend/shutdown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412720901.1502845.17888923249556811327.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 03:20:09 +0000
References: <d7faae7e-66bc-404a-a432-3a496600575f@gmail.com>
In-Reply-To: <d7faae7e-66bc-404a-a432-3a496600575f@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net, hau@realtek.com,
 netdev@vger.kernel.org, fabio.baltieri@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Nov 2025 15:23:02 +0100 you wrote:
> There have been reports that RTL8127 hangs on suspend and shutdown,
> partially disappearing from lspci until power-cycling.
> According to Realtek disabling PLL's when switching to D3 should be
> avoided on that chip version. Fix this by aligning disabling PLL's
> with the vendor drivers, what in addition results in PLL's not being
> disabled when switching to D3hot on other chip versions.
> 
> [...]

Here is the summary with links:
  - [RESUBMIT,net] r8169: fix RTL8127 hang on suspend/shutdown
    https://git.kernel.org/netdev/net/c/ae1737e7339b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



