Return-Path: <netdev+bounces-176764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA7A6C0F2
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B3B189E95E
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A3022D780;
	Fri, 21 Mar 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHVOT2g9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA3E22CBF9;
	Fri, 21 Mar 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576998; cv=none; b=sgzgaWapypXo4toeFOBShWW3wUo6LOaJKuLzlHd0IlmgEvgtdusYMvegiNmtzlKshgm+STtVf84XeRmnFSUBbQkcvIF+tMQgUnBDgDt1xU0+eXwy5jhPDG+oMwwqpNgRBIxXKKPgaI8ob8vHnmHEWa/nsk9TbSdug3kInLwFoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576998; c=relaxed/simple;
	bh=dv9zRJVGrnq94Yok8BJ+wJlSI1EAN3sBzGEgs7RGYS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RO6FU8epS53xiQ6GLNxmldXk6ChYmFP2z0qOggHSpZhmr9jQRzQUobixz6RYm2ZaBAio/dD6o40HFpnGrRPqvIB1HdUkJ1lEzj38FGEKMTAq4Fa+8SdhFxI1cJrolna96TnLbZc+XgrfnZ48XSoN06zJ6q7TPAKPMO/VuBCOn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHVOT2g9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19455C4CEE3;
	Fri, 21 Mar 2025 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742576998;
	bh=dv9zRJVGrnq94Yok8BJ+wJlSI1EAN3sBzGEgs7RGYS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lHVOT2g9hi2la1cyLkmeK9fcj498oX/WZ3zNw3vXhUOvwq0ZQdceL7EgJUeQNSD+T
	 PC+v9FsHbT3bXrz9R4bxxtUC8j4fEyQ0jg0IFu3xSuyEVqD/DYCVNwF4K1yNIZjE0u
	 UDVxrgYfjTikDrjY11J2radM21d4KgOxHPOEnfGT8gvoTGASXh0t/TB6hHaHFvpqAT
	 3RBagONJU+PVU2is3dHlR77wSyHzOcY3YP8VIrU2RPckmIYsU+6phyKC8Dv/khh7NA
	 gpIoGY5vZ/oDlAuSR8NgromDxPbR5lNRsqtZFesPDq9YxTI9acA6PDM1/Lk3jC23f+
	 pVdh7hyjV3FcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341153806659;
	Fri, 21 Mar 2025 17:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: phy: remove calls to
 devm_hwmon_sanitize_name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174257703402.2556904.4878855272406551127.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 17:10:34 +0000
References: <198f3cd0-6c39-4783-afe7-95576a4b8539@gmail.com>
In-Reply-To: <198f3cd0-6c39-4783-afe7-95576a4b8539@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com,
 edumazet@google.com, kuba@kernel.org, davem@davemloft.net, lxu@maxlinear.com,
 netdev@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
 linux-hwmon@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Mar 2025 20:43:44 +0100 you wrote:
> Since c909e68f8127 ("hwmon: (core) Use device name as a fallback in
> devm_hwmon_device_register_with_info") we can simply provide NULL
> as name argument.
> 
> Heiner Kallweit (4):
>   net: phy: realtek: remove call to devm_hwmon_sanitize_name
>   net: phy: tja11xx: remove call to devm_hwmon_sanitize_name
>   net: phy: mxl-gpy: remove call to devm_hwmon_sanitize_name
>   net: phy: marvell-88q2xxx: remove call to devm_hwmon_sanitize_name
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: phy: realtek: remove call to devm_hwmon_sanitize_name
    https://git.kernel.org/netdev/net-next/c/62e36b244135
  - [net-next,2/4] net: phy: tja11xx: remove call to devm_hwmon_sanitize_name
    https://git.kernel.org/netdev/net-next/c/91ee21962430
  - [net-next,3/4] net: phy: mxl-gpy: remove call to devm_hwmon_sanitize_name
    https://git.kernel.org/netdev/net-next/c/0426bd18af92
  - [net-next,4/4] net: phy: marvell-88q2xxx: remove call to devm_hwmon_sanitize_name
    https://git.kernel.org/netdev/net-next/c/345be5cd6e1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



