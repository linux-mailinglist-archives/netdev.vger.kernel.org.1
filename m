Return-Path: <netdev+bounces-98175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B762B8CFE7F
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 13:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E6B1C21470
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A72F13B5B9;
	Mon, 27 May 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUkcDjA+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAC17BCC;
	Mon, 27 May 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807629; cv=none; b=fHeN3qEHvcJ/3RY+JAd3V3dDDO8yV8fRF4btNwhwQWnRfgkAtHnADB3RgaszwrFomxIOcM+lPUmYcZ1XQWq2ZVBFE1JbUbepSmtDpqcA2wMhkUzSoyxvoMYe8kspvL30BqxOnBABENvHz54rT2IIIQC5XD4jGEumMi59bzvXkVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807629; c=relaxed/simple;
	bh=9OvgGCLs7UsmYX5hDtFasiQG55WDAV2a+q/y+k0S2Ww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JoMff3LHhgSoPoqh+sz+Lp3MJbBe7YSHjJZpIdH7JLoIsjyBoidZnwqwGIi7n+mpLz6BEWAzlywnr8Q+npJYCDm+1lHrZ9GMNTbPBZ0RGbIjwUbpbHODd74nCIfBrCNP0pJ9A5i3hXO5FIlkz3QQzbgzkqtsoq+/UymcHBq3k0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUkcDjA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A333AC32786;
	Mon, 27 May 2024 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716807628;
	bh=9OvgGCLs7UsmYX5hDtFasiQG55WDAV2a+q/y+k0S2Ww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eUkcDjA+J4EeGU1jei0k9g0HiVpryBGM/5vp+X+5Vk+MznHrmADwPrJiNswqFDKLq
	 F4ZmADjPovevjncTJ/JcQSvgxcpM0phPXFqFniSK0EnDGR5uKM/xsta6PASJjxfBrj
	 tNa30VY9URVQBnclG0Q042u5ABe4AbnkEukdxA2fudDEY8ctt3uqJs4jsYP7r3N7ud
	 ++7qm6OxxqDVZMhpPgYYp6hoOB5PEWECCdE8VY//nDslw9PqSUOzNHZJ0jamixW7g3
	 e5R9xXNQ5m72ozMteVJ0s5H6IZ/7AYEAo5P4NgYituZXLZQQwVtCpMQcPXqNkzpSVL
	 vsVNGW5R7JUOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F94FCF21F8;
	Mon, 27 May 2024 11:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: smsc95xx: fix changing LED_SEL bit value updated
 from EEPROM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171680762858.16270.336533909510921768.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 11:00:28 +0000
References: <20240523085314.167650-1-Parthiban.Veerasooran@microchip.com>
In-Reply-To: <20240523085314.167650-1-Parthiban.Veerasooran@microchip.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 23 May 2024 14:23:14 +0530 you wrote:
> LED Select (LED_SEL) bit in the LED General Purpose IO Configuration
> register is used to determine the functionality of external LED pins
> (Speed Indicator, Link and Activity Indicator, Full Duplex Link
> Indicator). The default value for this bit is 0 when no EEPROM is
> present. If a EEPROM is present, the default value is the value of the
> LED Select bit in the Configuration Flags of the EEPROM. A USB Reset or
> Lite Reset (LRST) will cause this bit to be restored to the image value
> last loaded from EEPROM, or to be set to 0 if no EEPROM is present.
> 
> [...]

Here is the summary with links:
  - net: usb: smsc95xx: fix changing LED_SEL bit value updated from EEPROM
    https://git.kernel.org/netdev/net/c/52a2f0608366

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



