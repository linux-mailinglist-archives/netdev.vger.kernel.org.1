Return-Path: <netdev+bounces-198831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4D1ADDF8C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95F5189CA6C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1192BE7BE;
	Tue, 17 Jun 2025 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxHNB7E/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86892980B0;
	Tue, 17 Jun 2025 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202403; cv=none; b=fHPO3+VsCH1dWZ+ENaxQvu2csDhIRHUKEiXB3DlZtuhJSng7RBFzaVkqJxkOo5ptfNM5FSopHhgzP2FUfaOmLymnm/GugsHwdtcoUl5vt112bh+iwQWvI7k8CRQHJWM/ExMQ/YzJ5DYX5Rtdv1rZvuH0xwEoNBdjh2SzkP0lBTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202403; c=relaxed/simple;
	bh=D/MwPuNU7YSZbfUwSYVCnvHmZw+UsvYgVrx2QwzZlwE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V+F1OSRSp30HJO4l02M3939hgK5yxca1px2kmHORAFJeb2AKIgVc+vcj2hTMcpO5UK2cO8NIMWAHfeG6bwVka75t3mc9DLzyC5tZkHFLipzsfaDJKJZJ1zYDUlJ5rCEJ79bUgHlq+5nHIsLFCRqZm8bYCXmyICeuh6o6MoUNgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxHNB7E/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FAAC4CEF0;
	Tue, 17 Jun 2025 23:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750202403;
	bh=D/MwPuNU7YSZbfUwSYVCnvHmZw+UsvYgVrx2QwzZlwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WxHNB7E/kR6pm2qGY6LmRvp2wDqa5Uf6G3FrZHQ6Abz8w/cXakkDceIoeaSzGSsOQ
	 lbbvenJaRFEHtaR8K8lg7erM8JxMDCkoyL1vI+A7IRxeVRw8UpKZzmmXJEuDBqBV8m
	 jxY8BZY0A/pP2bmd4OoGBg/BwieDFNCVpt9lmaS5JPNaPPJtcly/12ccee8dTa16DF
	 o3e21pb8jejXy0wFlZ28ogUbSzOFjjGS+ONBNijyofanWJHHgt+hppNkmakH2d0H+o
	 1WsgfrtXfNjqkV6qDKWElODfzf8sZcg3Q2Ef9Zqwz4WDwi+VtjHpwECUv7OQSSmTlM
	 Ry+w3DECM41Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE538111DD;
	Tue, 17 Jun 2025 23:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: bcmgenet: update PHY power down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020243174.3732875.2118110252101243802.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 23:20:31 +0000
References: <20250614025817.3808354-1-florian.fainelli@broadcom.com>
In-Reply-To: <20250614025817.3808354-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Jun 2025 19:58:16 -0700 you wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> The disable sequence in bcmgenet_phy_power_set() is updated to
> match the inverse sequence and timing (and spacing) of the
> enable sequence. This ensures that LEDs driven by the GENET IP
> are disabled when the GPHY is powered down.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: bcmgenet: update PHY power down
    https://git.kernel.org/netdev/net-next/c/90b4e1cf6de0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



