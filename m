Return-Path: <netdev+bounces-215461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E952B2EB55
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784565E47C8
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F97274B3D;
	Thu, 21 Aug 2025 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WI/FUjgW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804232561B9;
	Thu, 21 Aug 2025 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744006; cv=none; b=ZZP7jQf7FGautmVqhwZd36hLyNhyYbUWWV5OLBg5kIqrZKqPD6J2bssj/nRi54XmWX1TmcZBHYIwNVE6mK1B0c4uhArid8dgzJ+UsAZtwNT+dV8mIqIRF1CZ10jMPBfX1QP3X7IR/zn1Pf/8p/S3IHziS8yiGQKofT0puDoHw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744006; c=relaxed/simple;
	bh=IQQl3uPLmAi32Q2Bvg56TiUJC3QWqyAVb7proeiZAvs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n/k9tm5oWEYb0go/GfHKLFhw9igfqCVdGiJILp0/DyNB6lSgkJV54FAdsHDN+X3Qo0kE/pJgMm6soW66Qk/E9MEsq0lAY3vKyHZsJxhuGll9G5WBTDbUZ5e7y4/DF5uEqEITAffkHVY0K4Vg6OoSoXIblPiQOBTwUKD/cwndKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WI/FUjgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512A8C4CEE7;
	Thu, 21 Aug 2025 02:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755744006;
	bh=IQQl3uPLmAi32Q2Bvg56TiUJC3QWqyAVb7proeiZAvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WI/FUjgWxG8j5JXbG4S8A9R9WZG0bR+DllZDF90wLbpsxxjQKgfdAwk/B66nzAzsO
	 dqgbm9Qhota2VyXDAPEsOWM0hYsJUBlP0J6xqYYYmvvgPhP+CX9IzIYHYpfc2lFfbb
	 eiRJLq1Oii33/g20FQHbIOth0DYa0CmKVmNqeMRe7CiHYxaL36VgAyhHfKdjt59TqZ
	 F8NWdrlVFaROVheGp9Jc51lxrh8zYbkFme1yhNk9kEpaPo6kgtAxDhVhW8r2sUh4Lp
	 SQ+gS88T0D6WDZSnKIlcm/t7nXBc9ikqaX9LC5094/FvbdTCNsb9Azilv6tWPedWaS
	 B6DOahwkMFXrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8D383BF4E;
	Thu, 21 Aug 2025 02:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "net: cadence: macb: sama7g5_emac: Remove USARIO
 CLKEN
 flag"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175574401549.482952.17654850296504288897.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 02:40:15 +0000
References: <20250819163236.100680-1-Ryan.Wanner@microchip.com>
In-Reply-To: <20250819163236.100680-1-Ryan.Wanner@microchip.com>
To: Ryan Wanner <Ryan.Wanner@microchip.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 09:32:30 -0700 you wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This reverts commit db400061b5e7cc55f9b4dd15443e9838964119ea.
> 
> This commit can cause a Devicetree ABI break for older DTS files that rely this
> flag for RMII configuration. Adding this back in ensures that the older
> DTBs will not break.
> 
> [...]

Here is the summary with links:
  - Revert "net: cadence: macb: sama7g5_emac: Remove USARIO CLKEN flag"
    https://git.kernel.org/netdev/net/c/c42be534547d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



