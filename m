Return-Path: <netdev+bounces-141370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA75D9BA98B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 00:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993AC281B6B
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49C618BB9A;
	Sun,  3 Nov 2024 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swrurCoW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D5433AB
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730676021; cv=none; b=g46zRPkW4itWgde//I5QDZ1TemnlHx/1/hWNBFPiDMCqEOFZpilvD5fjf4f043FDC9+HbaI3Kdjrz8orvpf5THpVs91SpsopPDOsz3es0PWbaCm/T+Dv3C7gKbm8Vy6VqutvM+A3drKdy3hFLghWXInufa/TsbDfE7MfMpDR2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730676021; c=relaxed/simple;
	bh=e4OO3DHoA57fiktVTmQFADmLBZDp5FOZi3TQCq/HNn0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rt9PQ/UGiEMGhiWIkX9lDw8Ash8Dv+XyaQ925X3W+rEQX2mRlI1msjeOzCvirqEm0FN6ac1UIE8VWyBuPMzcFVuPria7p6x3bq4tjApA9weM8bKEx4q1PBsbZBJRKKkw/yGcUqOaR80LIgJZRdO/yOrvvKemasRd+PynwDsDj0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swrurCoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4122C4CECD;
	Sun,  3 Nov 2024 23:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730676021;
	bh=e4OO3DHoA57fiktVTmQFADmLBZDp5FOZi3TQCq/HNn0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=swrurCoWesJuIVh3g81a9aQC+YMW5JY9y55OBk50g4LXGsBtc5M5hmyrrTOxrLzIL
	 fsgJZUnMPv85JipTtPM9UO1Lwwt8+WyA2514U3YRApNjTpg9oDBaMYQWgq36DkJY5j
	 dQOIBERGaajxVKjJV273nrBMfq6qFd/392ktDXquI4VlZipB0kV+Ztln86/k7WEFv4
	 rJaLGsEa/GYivauTRxg6P1UYn1iw67B1eXCkYXl4fIofXwcpUWOBC3szPQDzbJrUpz
	 zl8DN2KYwoDhTueKM6vjr7/gHr3a8yWQ8O4Hovx1LNyBzW6FYKmZTQxd+Swy9WSwxa
	 W0eqhOxQYTYDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0CE38363C3;
	Sun,  3 Nov 2024 23:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] r8169: align RTL8125/RTL8126 PHY config with
 vendor driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173067602950.3276260.3092726631495627964.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 23:20:29 +0000
References: <7a849c7c-50ff-4a9b-9a1c-a963b0561c79@gmail.com>
In-Reply-To: <7a849c7c-50ff-4a9b-9a1c-a963b0561c79@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 31 Oct 2024 22:42:08 +0100 you wrote:
> This series aligns the RTL8125/RTL8126 PHY config with vendor drivers
> r8125 and r8126 respectively.
> 
> Heiner Kallweit (3):
>   r8169: align RTL8125 EEE config with vendor driver
>   r8169: align RTL8125/RTL8126 phy config with vendor driver
>   r8169: align RTL8126 EEE config with vendor driver
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] r8169: align RTL8125 EEE config with vendor driver
    https://git.kernel.org/netdev/net-next/c/eb90f876b796
  - [net-next,2/3] r8169: align RTL8125/RTL8126 PHY config with vendor driver
    https://git.kernel.org/netdev/net-next/c/4af2f60bf737
  - [net-next,3/3] r8169: align RTL8126 EEE config with vendor driver
    https://git.kernel.org/netdev/net-next/c/a3d8520e6a19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



