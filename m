Return-Path: <netdev+bounces-152043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01C69F275C
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 00:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9868164EC3
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 23:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2631885A5;
	Sun, 15 Dec 2024 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2SX9HBb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD01DDD1
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304213; cv=none; b=mc/V8XyJGOKk1wPavElaB2Q/OFD5uBVr8BRHgWyLG0rtZUP6Gt5AzYNxKNVx8rf5is9SfMBW74nvBW7orZc0tRWVSb7Lc9Y0Y2H9/sTKjYDUi2diQqXaEn/6amZ9hm5uUxX6ScSRC+uDzyJxxsXsIbg7GhrtWK45CMxMLOiv5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304213; c=relaxed/simple;
	bh=Smoei52C2YUX1kWdmJFGMVeUu8hAmZbN0IFSBaZoWqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jmzNjIG1Z7YVxe0+Tc/1Jem5TjumoHnfcFH2N8d4rMg7MycdEFVx0BGkDc4ecQGLwZ6I8v6J2cGh7D4NWjX4QejGzA9mD35ZRZASr0/4Hy3zOqSuiapWX6TBAlIDuxXEMSJC5hr7veuweWQP3OcMFzAR16HUrJquO2QCUbuYpWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2SX9HBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BA8C4CECE;
	Sun, 15 Dec 2024 23:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734304212;
	bh=Smoei52C2YUX1kWdmJFGMVeUu8hAmZbN0IFSBaZoWqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D2SX9HBbY+ejKZCbzf95St35cAXKoHtWiEfP5CykG3il+/BwyyNYoj38T1sB7cW/f
	 hVau9tn4iGOqrUHdlqPwTnKJ99CtKzIPgxid85Jhr+qYHmxKcjr0khzTDeHO1mxsrr
	 cG6At6vUpCVUwEUX+tteb/S73Xhj28uQwYrRNQ0JQ9pT8iK5/4uhbH8R9b5URbrCVg
	 HuRek7oKwPf5PRRUZz5jh2vzjemPAVB5mOl4PL9kkUD1QuRbmtPPjzlcNp/8LNtbtZ
	 24Mc4pHiv/NjAWOP6XkgtyjsuWkT2gTd0IybKRQHu82UoIxBNrGW/WdL0aoZ4/YYR4
	 XR1D5wpOECdWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0D33806656;
	Sun, 15 Dec 2024 23:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/3] ionic: minor code fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173430422978.3600507.1832286855650030183.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 23:10:29 +0000
References: <20241212213157.12212-1-shannon.nelson@amd.com>
In-Reply-To: <20241212213157.12212-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 jacob.e.keller@intel.com, brett.creeley@amd.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Dec 2024 13:31:54 -0800 you wrote:
> These are a couple of code fixes for the ionic driver.
> 
> Brett Creeley (1):
>   ionic: Fix netdev notifier unregister on failure
> 
> Shannon Nelson (2):
>   ionic: no double destroy workqueue
>   ionic: use ee->offset when returning sprom data
> 
> [...]

Here is the summary with links:
  - [v2,net,1/3] ionic: Fix netdev notifier unregister on failure
    https://git.kernel.org/netdev/net/c/9590d32e090e
  - [v2,net,2/3] ionic: no double destroy workqueue
    https://git.kernel.org/netdev/net/c/746e6ae2e202
  - [v2,net,3/3] ionic: use ee->offset when returning sprom data
    https://git.kernel.org/netdev/net/c/b096d62ba132

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



