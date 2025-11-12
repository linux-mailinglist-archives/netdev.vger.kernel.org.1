Return-Path: <netdev+bounces-237790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 249FEC503CE
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 02:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8403B2F1D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2EB28C037;
	Wed, 12 Nov 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRKdqopH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837C5289E13;
	Wed, 12 Nov 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912242; cv=none; b=niRrdiS0rcUZamxgkmvBVolrXzrVjmAzwWrNSpuhOZ31VWSLwj99+6vw4Xgs4P1cykpP+KPuS7/L4URIoHL+bag0pWQTW7cCWPSyBKHAZkm2yktcysAjV90cnPoq9G96xrGpaKrAKHhrB28rsaBH0W5okdizIIZAO+1Fj1gORxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912242; c=relaxed/simple;
	bh=KkwuvI78EihEIi5RalJzEZsOL4ZxkGqGL3GSyewok8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rqq3Mnc5iglOd0btmVs88R9lBJlk5p279661xKRdn90Y3k4KEreA7FagPuPxYSTT+9iInFnLmGSdqvBwmV5m41BdxZAwdTaaIprLhiA2JrqFDPc/io34gKxScMvBpyQE8nC5RlU4J0ywisvS0UPXT0EGtFEjJAG1Mia41qGdCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRKdqopH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B66C4CEF5;
	Wed, 12 Nov 2025 01:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762912242;
	bh=KkwuvI78EihEIi5RalJzEZsOL4ZxkGqGL3GSyewok8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pRKdqopHLQt7falOid5Kssl5+USFXmO+F9gKG/mutKIwVD9+zi037QHqZRcZPfHZM
	 qDj3vVdWKlvRFW/EGOnyJmAcSddQlAFFKAuntHK/fYtAwtUr+f0xnvrXU2mjuE2ilk
	 PSayfQBp1ZKu0Qci4cLbUb6TvgauWwVJ01yoBE0y7PNPl/xpePbHYOtPta9ADITuzZ
	 75wf/QTaIvQ6XiRu93T4PwscWBVeoJuZ3gjFsq2k/DvMisvLbbzsES6FRmuh/kiUqE
	 AXncU9/YGvwdriCVcqyTpFQIqugo5ig/4rN+aQCNJQ74Qi9Sc+aWMwMgpfg+9e69ae
	 maFgbZCLlwkvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F30380DBCD;
	Wed, 12 Nov 2025 01:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-11-11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176291221201.3630231.13400766152163840519.git-patchwork-notify@kernel.org>
Date: Wed, 12 Nov 2025 01:50:12 +0000
References: <20251111141357.1983153-1-luiz.dentz@gmail.com>
In-Reply-To: <20251111141357.1983153-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Nov 2025 09:13:57 -0500 you wrote:
> The following changes since commit 96a9178a29a6b84bb632ebeb4e84cf61191c73d5:
> 
>   net: phy: micrel: lan8814 fix reset of the QSGMII interface (2025-11-07 19:00:38 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-11-11
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-11-11
    https://git.kernel.org/netdev/net/c/27bcc05b8869

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



