Return-Path: <netdev+bounces-222756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E61CB55AC9
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 02:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D8516E0C9
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 00:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7070E84A3E;
	Sat, 13 Sep 2025 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltw4ZQrz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3957D098;
	Sat, 13 Sep 2025 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724007; cv=none; b=Pv8wTkdyZMf4yrx3fhBh4F+2kzkJRljYATMVbIgbAqAmVDU0Bn7rEwejSvOWaFQAexvTU6QCQ9Nu2Z9uLJ5ElolHIy86RAad0Xfw+21l+kscjbygdhJ9UqeNbWIdtS8jW8r0iJcR/ynuXPS2FvTJqoFBpv7FOrJwfrvAikRr9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724007; c=relaxed/simple;
	bh=/If1N9NOSlwc8L+sHpjRvx9dOiYK2aUjqQPUwmsuyz8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ha/CVad5LFanBLSG7o6/ASmnxdH8ITLYsWSWuS7geySSHP3MZdsTgkY8DhQQi2EJDSQuLX3dDI6zuXgdOcprqNME0uuvRI5UJWOxcbD+ks4qULHGtT2FLlOGybqcZALZdG7BGbEOn94FSusTWdPmYToIGipy7KEUQrepOlo5xZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltw4ZQrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD67CC4CEF1;
	Sat, 13 Sep 2025 00:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757724006;
	bh=/If1N9NOSlwc8L+sHpjRvx9dOiYK2aUjqQPUwmsuyz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ltw4ZQrzVnZspO9WGo20Ef08O1IUeGnqBhCd3O7+zZby3CFmkGdV6iWHPJ7VKkFkB
	 2GBMhTgThT8okaDuP8gmI/LE/VnrncNgooMc/ivhanKP0s7RsEZQDE4BW4kSykNBMz
	 d/D8wOCW4ib1MaAH6hpVh3L5Vo0Q5ldFyaMTHIXYC6zZiDoylovfOJbViKVOpYIhCe
	 26qWmyp51DarZg5MJ2a7v7Mh/mB23Cy6JNVOOkbn0GBPQyWNMaqHhKntX4oBztK2Pn
	 vLqb0w2kYioncI1aZecYo9zeQaLemCGgGqwH76ukdvrz5FICQ5uEdrHiAV36gQpSnq
	 t2WYbHFLkoiXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E39383BF4E;
	Sat, 13 Sep 2025 00:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: phy: micrel: Update Kconfig help text
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175772400901.3115588.7329713795469072529.git-patchwork-notify@kernel.org>
Date: Sat, 13 Sep 2025 00:40:09 +0000
References: <20250911-micrel-kconfig-v2-1-e8f295059050@pengutronix.de>
In-Reply-To: <20250911-micrel-kconfig-v2-1-e8f295059050@pengutronix.de>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Sep 2025 10:29:03 +0200 you wrote:
> This driver by now supports 17 different Microchip (formerly known as
> Micrel) chips: KSZ9021, KSZ9031, KSZ9131, KSZ8001, KS8737, KSZ8021,
> KSZ8031, KSZ8041, KSZ8051, KSZ8061, KSZ8081, KSZ8873MLL, KSZ886X,
> KSZ9477, LAN8814, LAN8804 and LAN8841.
> 
> Support for the VSC8201 was removed in commit 51f932c4870f ("micrel phy
> driver - updated(1)")
> 
> [...]

Here is the summary with links:
  - [v2] net: phy: micrel: Update Kconfig help text
    https://git.kernel.org/netdev/net-next/c/fc006f5478fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



