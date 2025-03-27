Return-Path: <netdev+bounces-177991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30461A73E22
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 19:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FD43B934B
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 18:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3653158545;
	Thu, 27 Mar 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwKGCUEW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FAE21A44F;
	Thu, 27 Mar 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743101398; cv=none; b=qATO+LT9q+2RE/bnoaP0dhDlKYK51F5HRsF7dyUGoWuBrmU2x1Y29bhbEomykQMUdUoIC50X7wv5YjuUKiMYKgiVKxZE6xjp7NR2Klz6ieaMH03cH1fTxg7SMa8xX5Kyp4oZoD9DAlMG6mz7Sl4AE/NqkqY032gRgjguoZZTEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743101398; c=relaxed/simple;
	bh=ICBf9tegswN+83NXLJwfLMnUUFgMPcA1eE9kf2wZ9bI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QuyLo9r7kNL9bpryVKJM6Xn6YlV7QMzK2G3OAINwm5+hd5h6covzSdI+o8iHPvv6BUbR0JlZKhAgL9EnA69cdtmuWdUWCVxe0CrmYZk7sUS/QFONf9ShvlfRI8BmHpsfQZm127ZiKGxad3B/RRFU7DzAaU3nImNhzZJHCIMdazI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwKGCUEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB097C4CEDD;
	Thu, 27 Mar 2025 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743101397;
	bh=ICBf9tegswN+83NXLJwfLMnUUFgMPcA1eE9kf2wZ9bI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DwKGCUEWi4TG79EMdHwooRvpcDhMuRI/Csnr2QyGb228epZlUMxhCWhIiPgIc38Gi
	 RcX+xvXsYdUoOpcbVfnh/oL2H06viFLdnECNc9cW/oZBFoFseMYIU2LhLLRUqwIRiO
	 ZRSVuAoRd+kfxce6K1up1n6l7y2jtRT2Nvrw6H0uiXe8+bHWw/Si7Z6s/ulOp0omVd
	 oFlhpqeRgS20cN+m5LPh64ozPhvkcFqK31M9k74kkGXndCwgCUY1my8nrSugESxEEu
	 sbozghD9q8R5qh6B1jCHwMCuFMQW2T79IJYRevDIvLFvrd0puOu3sFBJ9eVgPOBmba
	 LpwUplT1zdhGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE8380AAFD;
	Thu, 27 Mar 2025 18:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] rndis_host: Flag RNDIS modems as WWAN devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174310143429.2165614.15813216047185648771.git-patchwork-notify@kernel.org>
Date: Thu, 27 Mar 2025 18:50:34 +0000
References: <20250325095842.1567999-1-lkundrak@v3.sk>
In-Reply-To: <20250325095842.1567999-1-lkundrak@v3.sk>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-usb@vger.kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Mar 2025 10:58:41 +0100 you wrote:
> Set FLAG_WWAN instead of FLAG_ETHERNET for RNDIS interfaces on Mobile
> Broadband Modems, as opposed to regular Ethernet adapters.
> 
> Otherwise NetworkManager gets confused, misjudges the device type,
> and wouldn't know it should connect a modem to get the device to work.
> What would be the result depends on ModemManager version -- older
> ModemManager would end up disconnecting a device after an unsuccessful
> probe attempt (if it connected without needing to unlock a SIM), while
> a newer one might spawn a separate PPP connection over a tty interface
> instead, resulting in a general confusion and no end of chaos.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] rndis_host: Flag RNDIS modems as WWAN devices
    https://git.kernel.org/netdev/net/c/67d1a8956d2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



