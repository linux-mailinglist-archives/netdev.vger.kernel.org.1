Return-Path: <netdev+bounces-131820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507DB98FA60
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B6C1C227C4
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428C51CC893;
	Thu,  3 Oct 2024 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOeP1bDZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB41CB330;
	Thu,  3 Oct 2024 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727997635; cv=none; b=aYTpr/tWb/FozZfc4g/K6aAXjb+TYu6Xc9iElMyx+HY+LGLYoC6egB7gS9K/rF/1ZYuFOy+zC5zyVIffP+iWYbfWSpzPRizXVIiGAW4iFj5oWJ+7hLU9e/sWllUjPcWKNLAl/mwbv3/V5o+V6yNSquLWwbqaxjKmIH6dvcQB1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727997635; c=relaxed/simple;
	bh=mNVe5GMU+hVhn42+/lVh+iIunJrts/m+WYDMA/0ec1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bapz1ZB11G+fvUWzAHne9wBK6I7YFT6Y8yAM8SCXg9XTYeNoo6EP7DqyGJ9cx+R1tqyfbB+RWIK+62Myn2CRnZ+NU7+MdInORV1V08Kz2K/HuxgMfhMhyxwO734Ptj5WMNR89CJYItll9rBoS++u78by+/FMmAA5LkvVl21nBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOeP1bDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992D8C4CEC7;
	Thu,  3 Oct 2024 23:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727997633;
	bh=mNVe5GMU+hVhn42+/lVh+iIunJrts/m+WYDMA/0ec1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aOeP1bDZ4nmLbdcDBpcoKAiez1JDleIwbIDi0NUHDpYVc3Kh1PizHsh11U6q4HEVp
	 NA6Sishv58fx6jtJnxR1v5ZQtG1h5oUVs5S4M3RiGLjhNmRDcFam78z398Po1BLd6c
	 2P7U1NW/vK+RY8KEdToQZzQvyAhLph7Ywf7msFSJMT3kCTrG5yCDIQy8zHVDq3b/P/
	 6qnlXlPE4TLPfDWtRrt/ttMeZKwroFJ2qej+s9mWXnZGGosEENLf8brFXVIiQGV8tl
	 Yg14rDD8BcxPVYw1YlKUOY4tWqhtYlpRq+or6bJeBqenQLxo54rAxmFQ0UqybN4PWM
	 rtmrKsLToY6lA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340893803263;
	Thu,  3 Oct 2024 23:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2 0/2] ena: Link IRQs, queues, and NAPI instances
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172799763674.2024724.12393925801122696226.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 23:20:36 +0000
References: <20241002001331.65444-1-jdamato@fastly.com>
In-Reply-To: <20241002001331.65444-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, darinzon@amazon.com, akiyano@amazon.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, kheib@redhat.com,
 linux-kernel@vger.kernel.org, ndagan@amazon.com, pabeni@redhat.com,
 saeedb@amazon.com, shayagr@amazon.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Oct 2024 00:13:26 +0000 you wrote:
> Greetings:
> 
> Welcome to v2. This includes only cosmetic changes, see changelog below
> and in each patch.
> 
> This series uses the netdev-genl API to link IRQs and queues to NAPI IDs
> so that this information is queryable by user apps. This is particularly
> useful for epoll-based busy polling apps which rely on having access to
> the NAPI ID.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] ena: Link IRQs to NAPI instances
    https://git.kernel.org/netdev/net-next/c/989867846f7f
  - [net-next,v2,2/2] ena: Link queues to NAPIs
    https://git.kernel.org/netdev/net-next/c/888634377f8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



