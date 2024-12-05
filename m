Return-Path: <netdev+bounces-149233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312809E4CDB
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 04:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8516918819C5
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0143CF58;
	Thu,  5 Dec 2024 03:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaZgNhmW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921A2770C
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733370625; cv=none; b=goODhbtbIDt2wEIKUwDQljqc51ODbMRgoI/RWpTdPfiR0CL0PF3Q4MnLyTDaj7RFExsjxsnS5L+H+3yvkrv2Rt31CA3lUs0283iMHw56PESOBIoEpppQN78g/5wiccUfRbWXJseiV/3tY/OUoQtybio9h1XA6fYA/Y0RFYRkN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733370625; c=relaxed/simple;
	bh=PzcRsb7zURkScEWCXu0p3OHEQzuO+/YGxB4YL/A3XUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fHdT1m1ubqrDFcBvDhJ7160B72/3HcZ/mfVL6OvgvtgGg3/o9W0V3sIkfOG6vi07utzYutiFaXYGqigkHrDcEloANT+EevG8/Mg8vE59mAPMofC3FOHDKvIzsTgIlbLDePlFp8ubG0QzM8asJHvyU9jUrC7ZazZcOOGLca2rVf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaZgNhmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4105C4CED6;
	Thu,  5 Dec 2024 03:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733370624;
	bh=PzcRsb7zURkScEWCXu0p3OHEQzuO+/YGxB4YL/A3XUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jaZgNhmW8blKBRs6q6O5OrrNnCwOhNz3jA/fi0hQo6+a1cNzX0fUykAG49clW7YNO
	 /9MbaxvsJrqcqtiAVa+FqaUagcxVCgpQWcHBC+nAQ3iXZwMncTXJWHBWD+XKd34Uke
	 4xFKsRG71XRUuTNS1fP1OQhKNLyzU18fnoHbGGBGyTJ7sfCO56MkWicUtPK8SpfJxK
	 MsI1jH5vttXeMQv+jQcjsDRzHKEiqQQ87H++GjvAKf1SRsBWQAghbtryqyya2w1AhI
	 aSWvXrq7N6UXxMnLIkYQtc1w+27uGZzTpmn709qo992VolE28jiGDJe3+KJ+BI9gNM
	 W4q5j/MRqbgYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADECE380A94C;
	Thu,  5 Dec 2024 03:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: simplify setting hwmon attribute visibility
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173337063924.1436302.10269923747938186084.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 03:50:39 +0000
References: <dba77e76-be45-4a30-96c7-45e284072ad2@gmail.com>
In-Reply-To: <dba77e76-be45-4a30-96c7-45e284072ad2@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 3 Dec 2024 22:33:22 +0100 you wrote:
> Use new member visible to simplify setting the static visibility.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Here is the summary with links:
  - [net-next] r8169: simplify setting hwmon attribute visibility
    https://git.kernel.org/netdev/net-next/c/152d00a91396

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



