Return-Path: <netdev+bounces-171590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60F2A4DBBA
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D111785B4
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2FC1FECC1;
	Tue,  4 Mar 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuAYOJdp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791A1FCF60
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085997; cv=none; b=cG2EGo1AIq+PUoyCKyAny/nnVEP7efMr829Rp+4EQYDdOCRImwVFb4pkGzcFK6iUNIntbUyKJkvo5Pve97zzaYswJfOZcc6BlZVoeCgIsfVkcM24SzudxoqCl94byy2pqEXQED6tiLuuS0J/wf69IXXXRvUrpF3SK0zJDXqITlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085997; c=relaxed/simple;
	bh=Hu+al4G/hmiVgTHFLWllA9Wtq8jMsuniuuQHC2VpWuA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=el6vwIUGqW0R+wLsgPvQlKWmCPDWF1QsupdzhE1PpxysVOl3S3EyDmGJPzPt1TvUUSE41TxqgTr5KVvXepIl+gA+SYN1t//ynPsNBj2WhHIyzOXd2vM91UxJMbYwFHciXg0Rr92Ima7w2bi83UifG0EvCLjfu2Zu4kQzfVmehrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuAYOJdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0A1C4CEE9;
	Tue,  4 Mar 2025 10:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741085996;
	bh=Hu+al4G/hmiVgTHFLWllA9Wtq8jMsuniuuQHC2VpWuA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BuAYOJdpNamCwk2fxgqSO0gUrHqq+39OsXMkXty27LWrO70mE2/VhMcRnosqmVuax
	 Q4NZv5Es5V5pHVkku4LiEclE42RtfllWPgutiiYMer05eB3hJyNepZStVgccgeA+Od
	 3J6l72JweB9Zb8jOzaiZNnFh+YIwbA/Q8bsS8YgPNI0LlmPcpid+tn5VhPNU4f8jyY
	 xFxpI3kcwRHPpL2Fnes0uVYDaZTXII/2WmSfko8i/OJY4nYPLfItDT8fNA23bjpGzf
	 qCwyxY2oYmnRRutHopCiEl4CjrwS2caCFtLzhQWWtL3xaXt6JfVV72Hdgp0Rdrktww
	 DrO0eAuG39KyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC8F380AA7F;
	Tue,  4 Mar 2025 11:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: rtl8366rb: don't prompt users for LED control
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174108602975.96362.3483302194475421604.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 11:00:29 +0000
References: <20250228004534.3428681-1-kuba@kernel.org>
In-Reply-To: <20250228004534.3428681-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 27 Feb 2025 16:45:34 -0800 you wrote:
> Make NET_DSA_REALTEK_RTL8366RB_LEDS a hidden symbol.
> It seems very unlikely user would want to intentionally
> disable it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Sending for net because the symbol was added in net.
> Trying to catch it before its released.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: rtl8366rb: don't prompt users for LED control
    https://git.kernel.org/netdev/net/c/c34424eb3be4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



