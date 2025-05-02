Return-Path: <netdev+bounces-187359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB6AA6831
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 03:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1B198737F
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87C519ABC2;
	Fri,  2 May 2025 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbJTv6qq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01961607A4;
	Fri,  2 May 2025 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746148202; cv=none; b=kLBkthtavcMmkYzqpTGdvEvCjSj5Go1K8wHTvhy7vhOOlt0NUH+ubG8xtfKf/31mL+hH+sBtUgvGhSTR7S5G5CrhD58dWYF7C4pSZlhQrd4ob7RU4en1jcIqnkrtpzbH3JnMt3MkD3yMyPaJfaDAs2G/NbQTzBZMlDEHlQWrTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746148202; c=relaxed/simple;
	bh=yHFC7Vodncb6hZWvodkPISpLE3MBF9zP3jVpSJIgrus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hSRUkydl3zJWVTHHtvMwIACBZaUBGr/xKRYxOi2eVu/jKRZgudLMaCJYYudiWisHTT6JS3uX0CtMoKJpgZl/D8XLyKI5enIHRKaTLq0izEoLr8ps9t5iBcd0cIO7JFlNvuITnyISVzaqT6O5M0RqmsxZ/69HGtvuaUhffZARDzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbJTv6qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295AEC4CEED;
	Fri,  2 May 2025 01:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746148202;
	bh=yHFC7Vodncb6hZWvodkPISpLE3MBF9zP3jVpSJIgrus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hbJTv6qqoKl0DVCFwYdJJlSqIMhmcncktgeM6oylBmDk+kxFHvfJT/yNsqvt3csco
	 UOcwcb7p4tglKTVB8sPmbVw1hBsBke6ahVV68QiYzBJrCscR58ge8U2nysOPHT3kZC
	 U2OG3BNfWQY6YOzhLSF/waAALiS/Wf3Cqd9AQoYcbcigSWyGu4v4sG/MBZem+dNyAw
	 MNLmcKl4DtCZHomEXcPQVCfi8B25gsuw1Cd6Ko6gYcYmxH8zr/vY4u1Urs1YxzNHei
	 pXSjUmhPPaT23uxB3JFI+Si3QKrwjnfcbiq7V34h/etVUDVUsYA0NFMeShPN1oHviI
	 4/eRApO0cKfiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CAB3822D59;
	Fri,  2 May 2025 01:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: realtek: Add support for WOL magic
 packet on RTL8211F
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174614824099.3123530.15368363871758692690.git-patchwork-notify@kernel.org>
Date: Fri, 02 May 2025 01:10:40 +0000
References: <20250429-realtek_wol-v2-1-8f84def1ef2c@kuka.com>
In-Reply-To: <20250429-realtek_wol-v2-1-8f84def1ef2c@kuka.com>
To: Daniel Braunwarth <daniel.braunwarth@kuka.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Apr 2025 13:33:37 +0200 you wrote:
> From: Daniel Braunwarth <daniel.braunwarth@kuka.com>
> 
> The RTL8211F supports multiple WOL modes. This patch adds support for
> magic packets.
> 
> The PHY notifies the system via the INTB/PMEB pin when a WOL event
> occurs.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: realtek: Add support for WOL magic packet on RTL8211F
    https://git.kernel.org/netdev/net-next/c/7840e4d6f48a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



