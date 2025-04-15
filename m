Return-Path: <netdev+bounces-182863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC68A8A319
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACC61902808
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0651A29DB7D;
	Tue, 15 Apr 2025 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPNcoFFi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A7292911
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731607; cv=none; b=CIj1+Uy3D31taxSWD4cvlBJHLGqtLkZU+N6QvyGTrgGuVQ3+ABKPJ0vdwXb/ZxKd0QW5956RS/virkN5HujY8KPOrZoxNtZmlhhgiFALqJcAA05sWXv+tNFxs/MN4AU0oUySJNnrIENTl9CwsFA4qigWkyQr2eQFBKIT/ImFbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731607; c=relaxed/simple;
	bh=3PBzp3Gj/tJrXMNAsg6j+1B15zZArgDVt6x/slcwt+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QD4W8yjhbd8Ep9eWWYMFX0UNyFFf6DUNwM1hRR5tZgJBjXpH5FQ3twgoDL4cJGPWATPfFs37RVRMluXruNxT90hZTaSBavZwc1mM3zG8CHCeeQDqO/bbq3NVqTATmjuzPbCatBXfSDH0dg4X3+fYU66e8NRHDbgSdwt1NGfQ/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPNcoFFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D65CC4CEEE;
	Tue, 15 Apr 2025 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744731607;
	bh=3PBzp3Gj/tJrXMNAsg6j+1B15zZArgDVt6x/slcwt+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iPNcoFFiURAARrQ1Pso0iIGOuIhsCz6G6Bd1Jwv/Q3Q65FY3V2oM/32gVXFcUqn92
	 Ja6L9FhIz3hTSR1liVCHLLXFUB5cnNY59SLEcrq+1NswLNxO6Ed/iCjy/MNHgpWOpH
	 2E67kqIblVVRmoNF2O+kF9vlveUQl/XRP4mVajTDJoVlE+rL/S6WpnVOtqFE1lBpcQ
	 yiN8uobrtFptLI8+gBkGswue4u0jgNaXvX/YrEvaNwjFCFplQmh/c7TdoWFiBm2Di1
	 Y8+PnIdQAa8gSCnIj/LqSYwpaNQrUDWNge7lV0KZMrBGCoIqu7Ty6qpZ2WN4V23QOR
	 PDlYIOyvMjAOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C313822D55;
	Tue, 15 Apr 2025 15:40:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: remove device_phy_find_device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174473164476.2680773.9253709874568879632.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 15:40:44 +0000
References: <ab7b8094-2eea-4e82-a047-fd60117f220b@gmail.com>
In-Reply-To: <ab7b8094-2eea-4e82-a047-fd60117f220b@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, andrew@lunn.ch, linux@armlinux.org.uk,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Apr 2025 16:09:40 +0200 you wrote:
> AFAICS this function has never had a user.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/phy_device.c | 12 ------------
>  include/linux/phy.h          |  6 ------
>  2 files changed, 18 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: remove device_phy_find_device
    https://git.kernel.org/netdev/net-next/c/f99564688f38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



