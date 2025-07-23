Return-Path: <netdev+bounces-209394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8404B0F7A6
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E131D567602
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624241E8324;
	Wed, 23 Jul 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJNIinni"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE181E3DFE;
	Wed, 23 Jul 2025 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286348; cv=none; b=uGlpfYZ2UBxyR0XS1tZNgjhnETxhgazBcBuwUrkNMLsB5QKKGWs1YUVUwMW4MlQ9/StjrTkrRUCDZZtnIRuC3Uo+rV8b7Iv7KJgCrHoOoRXtlOsvY/XJzFQPe8DwaLmEUTq4Xr2Y15tFCV3HT2SOisEdwMprKn8oJdfA9RSAlqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286348; c=relaxed/simple;
	bh=1JsI/0FEOYayMluokFNJWVsvN2ss8l/m4x/+Xrxr7pA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iGPiQ7MyTmyT38/KYt011XsRmBecsqSqXHyZPC/VZa+1ymLw7ATC38omUXQz6YGOLDMEzFy5HwqJsXm71xesYY8E0krzr5z9mhkNOu88/+LdswUm4J9MAOIWX2MeX7MMwJGVS4vSWPHC6TwdW1LC9Y7sLd/hx22B4aOg9Xdb+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJNIinni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8E5C4CEEF;
	Wed, 23 Jul 2025 15:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753286347;
	bh=1JsI/0FEOYayMluokFNJWVsvN2ss8l/m4x/+Xrxr7pA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QJNIinnijSbgT94/uMyAHUYSmGqAfkIFtGvLwRgsrW1Gq3CVFUsJsSLlU2gem2vsC
	 qC9htFXbsDkAwZejLVo9TgPnYMwIO4PCIadcPLO0SXfiGaN01Kmy03N1cAW95VWjPs
	 WPCiDlX7z5BYBJcil7ZL+oQQQaG1J/3K/gA/3iAsGDYarzJLnlUDb+qVXm0RKtVbRd
	 NX7DWLJ6Quot/DLw2Ttqz6Ei0izR1szptUPu7/LvCGDziaNGjHrhW0fIgMwUDp8x5u
	 3YoyIwocASDT5YEzGqlhvFrDWSq0ZFLSbGe/jRidYtl3gEVJ0mKRJeTqHggv6Zk6dS
	 oDUrr92fjMw+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F11383BF4E;
	Wed, 23 Jul 2025 15:59:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-06-27
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175328636599.1599213.1596761975256406882.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 15:59:25 +0000
References: <20250627181601.520435-1-luiz.dentz@gmail.com>
In-Reply-To: <20250627181601.520435-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Jun 2025 14:16:01 -0400 you wrote:
> The following changes since commit e34a79b96ab9d49ed8b605fee11099cf3efbb428:
> 
>   Merge tag 'net-6.16-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-26 09:13:27 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-06-27
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-06-27
    https://git.kernel.org/bluetooth/bluetooth-next/c/72fb83735c71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



