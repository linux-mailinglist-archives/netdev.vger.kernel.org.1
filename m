Return-Path: <netdev+bounces-162829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A178A281B2
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FD0164240
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 02:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59B4213243;
	Wed,  5 Feb 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3VnEFcO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A170A213228
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722012; cv=none; b=tKngzjX1gxV712LLhbi5foN6jt/cyugroUDj02n9upY4gNoFuiVWSdAOWPKCmPYKhChAQFpIou3q1z2Sf7tO2tYyE9Uoi/1vzf2jUAjaqnIobEeyznpNnEn/mUN2rAF05Yfalq+EauaKGjo8UYtbgmpphV+X8bRa+uJ3T7PIiyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722012; c=relaxed/simple;
	bh=yK4ghLqomOmEeO0WYfvEWlbMUtizFewl2XhFOyo58DA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uQYxLs54zTTMhStoRATsMhS0IrkInL6u5b4zSEIDiSO4dCy95r79/JgU3EXGMu7yUuZPBGFZS03Bq1pRS2Ulih7Oij90KhReCF8Xg5LDw+S8Jxs0YVgD/Q2kvJAnseFkhspVm8fW7oUF4MGVUYwukEXbSfX4IUmmoX+XgLK3utU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3VnEFcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB7DC4CEE4;
	Wed,  5 Feb 2025 02:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738722012;
	bh=yK4ghLqomOmEeO0WYfvEWlbMUtizFewl2XhFOyo58DA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b3VnEFcORu3u/7XQH0sYZVPQeVl4F27pySc8Fw1675kS16muGSOU/XFPkpyr7Hhnq
	 nHujzQ1cX6iuyTZCTE9t23r+TLbZPFXvegPp+J+ZqeQzhkS7BPoqnUMBRFqkU8ZANt
	 Ss42dhyYBwdEr8FbVz4ZG/n/5cgwrjvdN+wPeOdp+vXzcXLrQXHjjwcRwsua3GAlQ1
	 7/6/NXgh1pWrk6B0viJM4iNlcq/DfWHBYfd5F/7C0HGIL16gmAW1d4ARHfq2WG8Tzj
	 lABzAL9ATnJ9n4r6g/TM7K2OaV441UB2f8a62Tc1aSextpcfqp993HLO0SAogonTlL
	 KXQgXMb2Lkd4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE547380AA7E;
	Wed,  5 Feb 2025 02:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: make HWMON support a user-visible
 Kconfig symbol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173872203950.246239.2948687782961371745.git-patchwork-notify@kernel.org>
Date: Wed, 05 Feb 2025 02:20:39 +0000
References: <3466ee92-166a-4b0f-9ae7-42b9e046f333@gmail.com>
In-Reply-To: <3466ee92-166a-4b0f-9ae7-42b9e046f333@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew+netdev@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, horms@kernel.org, geert@linux-m68k.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Feb 2025 21:33:39 +0100 you wrote:
> Make config symbol REALTEK_PHY_HWMON user-visible, so that users can
> remove support if not needed.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/realtek/Kconfig | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: realtek: make HWMON support a user-visible Kconfig symbol
    https://git.kernel.org/netdev/net-next/c/51773846fab2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



