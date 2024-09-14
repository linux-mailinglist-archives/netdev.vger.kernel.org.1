Return-Path: <netdev+bounces-128273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB37978D03
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 05:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D150D1C2226E
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 03:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865C0182B2;
	Sat, 14 Sep 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dhe8WpQd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB2182A0
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726283433; cv=none; b=ZawORMj4wkXE71iS2mw+PU3skmm7/RSt6BrqtZjjWEFVQ1jdlCu4ci+6U3Qg/eM7OyAtYNQnAdsIDI91d4mXye7+2+TCcD/xWDONoWzIn0NFTyaaLJJ/5YwYTB6xdDK8/LTSYDAmF5o0AvD3OrL85TywkidZh4h0CQDrghj4a40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726283433; c=relaxed/simple;
	bh=L8Hf/8A9uW6qgwhFeX8Ri2gi6gzFKHOG3qurgFwCTyM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wx4n0AUpWNt6ds9ZxAzm4NuoRq+chdYePhq7PdfyjfT65pKSEfoiOLskoO6UUCNw9FO/x8EE93gIGkGvSOtZFYF+ObS6VaPU+BwGd/RQ8NzRGVBcn+DalfPjuah5RfVt/2gCbmQkUNIhWWYv+Ajk0cJ4hXwsAYvc1Nvs/IyxG5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dhe8WpQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36401C4CEC0;
	Sat, 14 Sep 2024 03:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726283433;
	bh=L8Hf/8A9uW6qgwhFeX8Ri2gi6gzFKHOG3qurgFwCTyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dhe8WpQdbOk2Jgeb7f+dJP18gI4og2c9WOstF0qcM/DU6IJCV1EVNwSTN0pptGCN2
	 t1bH29NEEeOtOyfiCUYiOh65bkkS7yvpUCZ8x1Fmxd3deCXMHwLYUt/sJUKci41AuB
	 E2/FEzIT8nTaYUzWqg/LA8lBpwGGQYB29R/TnLMSQVUt3zgvk4jg3eQkrtQtoAnBuM
	 eqFf/0ulIvCrWYWeL/+U76slST7Fj1HKl58Y7+8McSjaJ2ZfENYv5bbahLbpXw8gli
	 ArGc1U/+Ggp30jWtGIc9PXxxy3ixEY9IUuxe35qUwVOMOycAbyDiGdfN3SpPI2q/R2
	 3/Nn2Uttv+OuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE243806655;
	Sat, 14 Sep 2024 03:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8169: disable ALDPS per default for RTL8125
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628343425.2438539.15879963507903205206.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 03:10:34 +0000
References: <778b9d86-05c4-4856-be59-cde4487b9e52@gmail.com>
In-Reply-To: <778b9d86-05c4-4856-be59-cde4487b9e52@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, nic_swsd@realtek.com, en-wei.wu@canonical.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Sep 2024 15:51:11 +0200 you wrote:
> En-Wei reported that traffic breaks if cable is unplugged for more
> than 3s and then re-plugged. This was supposed to be fixed by
> 621735f59064 ("r8169: fix rare issue with broken rx after link-down on
> RTL8125"). But apparently this didn't fix the issue for everybody.
> The 3s threshold rang a bell, as this is the delay after which ALDPS
> kicks in. And indeed disabling ALDPS fixes the issue for this user.
> Maybe this fixes the issue in general. In a follow-up step we could
> remove the first fix attempt and see whether anybody complains.
> 
> [...]

Here is the summary with links:
  - [net] r8169: disable ALDPS per default for RTL8125
    https://git.kernel.org/netdev/net/c/b9c7ac4fe22c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



