Return-Path: <netdev+bounces-71598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6544C8541AE
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 04:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FEF28623A
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E699449;
	Wed, 14 Feb 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3fT4nZa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849E08F59
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707879631; cv=none; b=bvTsryJEJYADE5ghU7TZIdUb7jabjE0UPZm9ATB3DiVvuSLSZpWGTv6afbMKZYgtr+KjzFBPnCJr2Ka82Xt+qFgnSnab9S79D7HtRnDl3ORiwHD8ZEKqylMgQE7FSKdjaEHL8+ON2Nw6NBu2hOgt4Wq4ZrMZqb2tXqaGQJ7JHi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707879631; c=relaxed/simple;
	bh=jih2dwuXZm9qD48Ygp8VQGmmBo7GqVdyEB2YGyNRBuw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OVlPnLk+/pVLgWmUZdAFsF5dIUogYNT7DfWpseqqv+kvfCtmTwqT52Z0hTvJhTuHI/ueiegiVbGFIaueEX9kaFq7INNEf5N5Wzo68RTB8Y1u61jLlavZPkoAiwfTYtV4jcHXuy0m7Y0JPFSrJmU7xdBqfdqFhUVY5hDxbByYAbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3fT4nZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2949DC43394;
	Wed, 14 Feb 2024 03:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707879631;
	bh=jih2dwuXZm9qD48Ygp8VQGmmBo7GqVdyEB2YGyNRBuw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p3fT4nZaqfYArHNcIwIy2pABm9M62Tj1uwjkjnw6ORa8dyba+N4hXA3FdaCLN74hA
	 0mAIkDnZOtZLeY/MgAEayoKT/zspTAsfIikWsvC27GE+3u3cCoLsB905gBat40fftY
	 CnrKp9mARfJPuFOPOU9M+90cHZ3+D1vah6XwqnPfSG5QiFcDCfWXwbGFur2yf478lx
	 HWRm5W54IOoqLJpLHn3CMQzyGMhPWa7C7G1eVyU6A9aVc5vMbzTvUX4UHH5lVM2i+7
	 0WMgAY/KUVamOYpIjGqguPx0CYB9AwrSTxs42STDgUfHFqIPEt04TnWdzpJtzHGwfg
	 lCPNLYsxhYcDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07E7ED84BC6;
	Wed, 14 Feb 2024 03:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: add LED support for RTL8125/RTL8126
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170787963102.17924.11668187709225523202.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 03:00:31 +0000
References: <f982602c-9de3-4ca6-85a3-2c1d118dcb15@gmail.com>
In-Reply-To: <f982602c-9de3-4ca6-85a3-2c1d118dcb15@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Feb 2024 19:44:11 +0100 you wrote:
> This adds LED support for RTL8125/RTL8126.
> 
> Note: Due to missing datasheets changing the 5Gbps link mode isn't
> supported for RTL8126.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: add LED support for RTL8125/RTL8126
    https://git.kernel.org/netdev/net-next/c/be51ed104ba9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



