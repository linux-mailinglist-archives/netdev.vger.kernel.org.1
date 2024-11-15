Return-Path: <netdev+bounces-145514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929BC9CFB44
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA6E1F2438A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92891ABEBA;
	Fri, 15 Nov 2024 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMNdaGS6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DAC1AAE1E;
	Fri, 15 Nov 2024 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731714021; cv=none; b=hUIX6UNDER4RTdcJq16Ab8pj38UuWEyGtiPlUaEMtqV4NnWs2m51QfROlaiQ96Upijm9qQrVxcjzXH9RMH1YLgGqBTjRWe0slR8i2RO6bKppHP/IEt14r3YuPEk7QFeqXl3Ovq9AfwsUKJYlIqMUAEFZiwQjLO9eSxnHk8eQI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731714021; c=relaxed/simple;
	bh=7aZ+QLZkMJD7SSoh7nu8VDLzts57ruPUVHaX0ERm+vc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LJEfD3pYeWBCnVxDlJDkDRxoLjJjd3DlU7X4majGsfXwEIOGYk5DEITeXnmpbxUh79MBPSXMt1NTbcZkII9scrtV2dLU+zCl2jgLLAyjuT6n3PiOAlTrAon8impvKgbj+liHQQ1/A+a7SaR1BqKe79wH9c3OsCC8jqkrfP7/0kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMNdaGS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B8DC4CECF;
	Fri, 15 Nov 2024 23:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731714021;
	bh=7aZ+QLZkMJD7SSoh7nu8VDLzts57ruPUVHaX0ERm+vc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LMNdaGS6AZUuqq6wqUrQ5/wWZslOwaQMhuzzJsnh8UhYPjPp0HaF8Wzi3IGNLGpsJ
	 UhVn7vEHgjJ9VbXwv62WFXFRg7Ey79wZBWL3S/5Iufd0osb5J0isQ8H7v/+UiB/qMV
	 fxXlNM8ngQkG6zYh1P6+Pmie2PDGSk88iXxdHtdG8WGiBOg89Iag6RRiDnH7CXEnI7
	 5cFayrMSns5Clam43dbxVh7R88uoftJLutRkAwUWoviJZcfEXyOVgSBkcQWsrjQ3of
	 FL/XcUySybRXeVd+RluGJAfSFcM4/+ymfU146Nbe5YJy/UJDYam2wIWDss1NuYutJG
	 fwvypXvvz+5fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E6F3809A80;
	Fri, 15 Nov 2024 23:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: microchip_t1: Clause-45 PHY loopback
 support for LAN887x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173171403198.2770408.408499941921229541.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 23:40:31 +0000
References: <20241114101951.382996-1-Tarun.Alle@microchip.com>
In-Reply-To: <20241114101951.382996-1-Tarun.Alle@microchip.com>
To: Tarun Alle <tarun.alle@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 15:49:51 +0530 you wrote:
> Adds support for clause-45 PHY loopback for the Microchip LAN887x driver.
> 
> Signed-off-by: Tarun Alle <Tarun.Alle@microchip.com>
> ---
>  drivers/net/phy/microchip_t1.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] net: phy: microchip_t1: Clause-45 PHY loopback support for LAN887x
    https://git.kernel.org/netdev/net-next/c/025b2bbc5ab1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



