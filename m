Return-Path: <netdev+bounces-177634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8310BA70C3D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73F0179269
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981E8269CE5;
	Tue, 25 Mar 2025 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCgtDAco"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4B269813;
	Tue, 25 Mar 2025 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938802; cv=none; b=cYgSC21DZHdiICOGBv2JhJwy3F3C8yjwbAYmAyj4qie2u4A4BHv0wMMvxWSzIc2lFS0eoZ25SSMlSl2XkuHoMpuUH19pWQln5wPkFnr+rngRxLjJuIHwKB3CMGGY4QnCgCHXaNv8MlPbZCLg0943iGDp+FurO2lhQs4cuERereo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938802; c=relaxed/simple;
	bh=/EdRSnBvY5AE1pbX1KsOAS0fRxwzyV8JWQjx6ib0lt8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RMV7mrK/GPbt/EEz1InFla+DkNfF8xTLilbQyiZ3zqCAf5nX/065gRzh2D4Wm7T0Lslm33yJCYPAhhYZPkDY7m65mbhaL0TZJPism8OkJ0oW65H8uRa5Q5Zb0D002F29vhefIq5cY0Dk9ch5U+BGCrtI9CnawawszFjfBAJE/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCgtDAco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0056C4CEE9;
	Tue, 25 Mar 2025 21:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742938801;
	bh=/EdRSnBvY5AE1pbX1KsOAS0fRxwzyV8JWQjx6ib0lt8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dCgtDAcohUbzyaLNrFkF5IhI4OeSqT1k3cgUcFTH29r8VXGrABj4Ym97ZTtYCRC7j
	 sJfILAPEUCUEBVUFuuUYq+NoIecz8ZKd5AquZJG0UzKrnLnX1mQtQShPUblSfgvB5n
	 G08v6psqqtpZrVIMoj0wHcU8e7gUQYX/dIGFrsh9m7XbkXRTnVGjltIlwaP8rXIDyq
	 C0PmE/X2Ax8ChL3wXMBfaL1QKXNbcyXzX0M+qny/+xTiJEB1bKYxWLBTyqva7tuaSI
	 Lto5JaS8LIikah8kKKYoAwW2nRmkwQ1oiGxT5+j9/LUM1eHky6jWoZDVABQ42iHrA+
	 Xqk0T5Zy5LvHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FDF380DBFC;
	Tue, 25 Mar 2025 21:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth-next 2025-03-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174293883804.738412.14650381382474284681.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 21:40:38 +0000
References: <20250325192925.2497890-1-luiz.dentz@gmail.com>
In-Reply-To: <20250325192925.2497890-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Mar 2025 15:29:25 -0400 you wrote:
> The following changes since commit 8fa649fd7d3009769c7289d0c31c319b72bc42c4:
> 
>   net: phy: dp83822: fix transmit amplitude if CONFIG_OF_MDIO not defined (2025-03-24 09:52:36 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-03-25
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth-next 2025-03-25
    https://git.kernel.org/netdev/net-next/c/4f74a45c6b19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



