Return-Path: <netdev+bounces-164268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC1DA2D2A0
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 02:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7364A3A9B22
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CEC881E;
	Sat,  8 Feb 2025 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2ynx6xs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0A1494A8
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738978206; cv=none; b=ln3S8Fp0tuof5eB2+o+AsJCgmwN/ey+zgsn9B2Y7OSTa8o0uW7VxH2x/1RbP5QS2xBK4QyYrD9Ia6tZmFABMCLtyEjjIXXCGwtp1QlkFkUm7+4Lned2Yq9TZ1bXqyRL5sp9wH3LgOQ+/5arMrYbrDhr9UkV0X2okrKpploQ40Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738978206; c=relaxed/simple;
	bh=5Aw1vW9iHAt0PPDB/2Nm6xfOlzhPthxwMNkLuyxsCTs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g6hEjo+MHyn3WE8dpjCRxmxhK66ICjKGnYyrFrs4fPPxJaechhkbC0wKM2PE1OkVV3wUI7clsgIf6+CMR/eS4rhdVZ0uZnQzeleaamZXR5lhjw2vbkt19nlQ/wLxG//PbHWbYSGsaPBi4w3kW8xsM8dh5a41WEwNpYf2O1mrih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2ynx6xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787EBC4CEE5;
	Sat,  8 Feb 2025 01:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738978206;
	bh=5Aw1vW9iHAt0PPDB/2Nm6xfOlzhPthxwMNkLuyxsCTs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K2ynx6xs22YR3/bDDUgVzt+vGFxE2Kr1Zxj9iSQ9jiF8Lad+KXlUCYLJbXBfUYFV9
	 nNTbTB6D0uc8NcHsJAYCD48/2KYhKFWSof4V6sWPSEBaM99SDER4qaYmRnriRAA4Bd
	 OxTfPVNd0vYQk0WmPx7ITsw5h4dDGfPflKBf/CCglvYmg331pc0KD6rfUtRuXo7yjz
	 kZZteGCkzf5lUKPTsZczBAMPP9vU2rSgNhpWt0+Q3DQcDlKA7PC2gniOLpOdcuQ5M5
	 WkqYPPal1mgjXXpSmxQm398XIl456/rDX8ipVf/KDkFY7KFyV8JQ1HqsZ5wKBWXTgG
	 NSBEFVc3XrHXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE26C380AAEB;
	Sat,  8 Feb 2025 01:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: gianfar: simplify init_phy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173897823425.2448842.12118841285720989328.git-patchwork-notify@kernel.org>
Date: Sat, 08 Feb 2025 01:30:34 +0000
References: <b863dcf7-31e8-45a1-a284-7075da958ff0@gmail.com>
In-Reply-To: <b863dcf7-31e8-45a1-a284-7075da958ff0@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: claudiu.manoil@nxp.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 6 Feb 2025 23:06:07 +0100 you wrote:
> Use phy_set_max_speed() to simplify init_phy().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/freescale/gianfar.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [net-next] net: gianfar: simplify init_phy()
    https://git.kernel.org/netdev/net-next/c/6a0ca73e5144

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



