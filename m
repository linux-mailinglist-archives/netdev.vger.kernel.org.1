Return-Path: <netdev+bounces-133673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0B3996A3C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46665B23D74
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EDC194C96;
	Wed,  9 Oct 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgDG0C9i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB991194C85;
	Wed,  9 Oct 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477628; cv=none; b=VcxRPQyGOlX8mIq0GWmX0UWn2za/G/ePsx0QkjVMP6LgCqQuzlQMzUUQ5K0wkZFhZnvaUjki1NsClNlVN3J45XVVgdtR/AwSGz3m2oz2lmvqNrDnmxwbdhD/og3fek3pb2+w6A2Mxz3h1FT5GSlcAkW5P37zbPEIiCEb0l3Z748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477628; c=relaxed/simple;
	bh=kXFnJ2VqPRqypAvV/VgA3Yu2BhCGwHxNMpMsrjl06Rg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jxkdjXy7iJJ4CRhidmg0nyTA71Z+LmsVfXyBQ8oq0epLEosn+Yym5Hk5zT1j+yaw63Z34k25tfqJ1MgA2C9i9ZZpDzvlIXNUwUJpqcdGEH6lIUmEXw+OmSA2S0DuNmdXFSDO3quQS/njALhxTXKNt//LVj8clM+9s7mmIMkl0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgDG0C9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368D4C4CECF;
	Wed,  9 Oct 2024 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728477628;
	bh=kXFnJ2VqPRqypAvV/VgA3Yu2BhCGwHxNMpMsrjl06Rg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MgDG0C9ikfj35BW7twXEz7NqEgwowB2vLVCi9iKD/XiWv4TgEjOmnPgXdvM/RAHdr
	 X0pJkwuzVAeiiWO0kT5PdrtaWqMAkGWHrJQWHw8Cue7HoQ01T+jU1v9yA8UzrzElpf
	 d/yLRUrqnUxJ9hVdFcibW+sVnYrFj0FFxsXkF9D2dWPMJNj/lSSXRLlKdl18B+TJAS
	 v+JQUFtgOlxq5nnyRrM4GTZbB8X8hS089On35pAv0ibKlygivh4tbOSkuOfOAvE36J
	 Smg02rsGVhK+LDDCGi6MTd/oKoLVxeW9OtTdY/2xvGsHIdWenGO06eAyR6oW7NCFmm
	 EJZMpzZdZjUQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD3A3806644;
	Wed,  9 Oct 2024 12:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] r8169: add support for the temperature sensor
 being available from RTL8125B
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172847763248.1253149.14421663946636580043.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 12:40:32 +0000
References: <f1658894-4c46-447a-80e6-153c8b788d71@gmail.com>
In-Reply-To: <f1658894-4c46-447a-80e6-153c8b788d71@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, jdelvare@suse.com,
 linux@roeck-us.net, netdev@vger.kernel.org, linux-hwmon@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 7 Oct 2024 20:34:12 +0200 you wrote:
> This adds support for the temperature sensor being available from
> RTL8125B. Register information was taken from r8125 vendor driver.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - don't omit identifiers in definition of r8169_hwmon_is_visible()
> 
> [...]

Here is the summary with links:
  - [net-next,v2] r8169: add support for the temperature sensor being available from RTL8125B
    https://git.kernel.org/netdev/net-next/c/1ffcc8d41306

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



