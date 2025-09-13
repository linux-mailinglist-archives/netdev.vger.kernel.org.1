Return-Path: <netdev+bounces-222755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884BCB55AC6
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 02:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A85A3A17EC
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 00:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4449B70824;
	Sat, 13 Sep 2025 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2bYdji8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B137081C
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724003; cv=none; b=OtdGv7BdaJXrOGR0oyG7GslUuwzsHOxRGdonCDGLRjyHtHM1SK7CXP/QDSbqLm7dSFBqkOinlke7pTQsK5fga5kokz+AzKa1UiU9FvHgASO6+CH26U4gLRlH5MiRUx/rjVqQEGnbfJmBwSiuWfikxR4ZlvSS4Bo6jd30deXu7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724003; c=relaxed/simple;
	bh=4/JpEcQWfjnniZzk2QrMSDVWxm7r9Pmz48ObzYURDqo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y15AQQIvDUq7W7BDbTBak2D0mtDfj65adXDyLsRJoj4AaEYa+9qxuDvTDH0AUlvSCNxY4+heS59xG0QRMQmFFXJBq2Ez72YoGjEVLBwrVO8yzpXw07oQgJ1Gsnz0AcXr9Pg1bXAgsahNmrbcaok73rGz34yNsqutj8Gr7Q0pebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2bYdji8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4985BC4CEFA;
	Sat, 13 Sep 2025 00:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757724003;
	bh=4/JpEcQWfjnniZzk2QrMSDVWxm7r9Pmz48ObzYURDqo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m2bYdji8slk1XZ+2YVFRFWHOWTl82T7jXbtgZPsSKa+A2Xy+CEuc5CzNt5USqEet5
	 bepYJ6R0r85emIckfvEiJ+3Pja6NO4jlVRQnFwHmI/hASjKa1TByWO97OTrmBuNrZ0
	 LlE//Q6gf+WjERGf9xSWHZ3+4+7A6G4eoM+LBQTsJYC2W306SEqigDTbUScJhij04u
	 Fifq+l5czX3WhxcErg5/F91lARxc/31Pw3R4ZLNzo2pQN0DWxcmwjL2dgaUU/tp/H/
	 YLdfl8nVvn2CZEO6g0knHBR0IkcnmgY/ot/ELfKD1aTYSD2GXKKxPTtvo4/6/6KO81
	 r+QkJl2oIz0Ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE09B383BF4E;
	Sat, 13 Sep 2025 00:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethtool: handle EOPNOTSUPP from ethtool
 get_ts_info() method
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175772400550.3115588.6343280449330593634.git-patchwork-notify@kernel.org>
Date: Sat, 13 Sep 2025 00:40:05 +0000
References: <E1uwiW3-00000004jRF-3CnC@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uwiW3-00000004jRF-3CnC@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: kory.maincent@bootlin.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Sep 2025 15:43:15 +0100 you wrote:
> Network drivers sometimes return -EOPNOTSUPP from their get_ts_info()
> method, and this should not cause the reporting of PHY timestamping
> information to be prohibited. Handle this error code, and also
> arrange for ethtool_net_get_ts_info_by_phc() to return -EOPNOTSUPP
> when the method is not implemented.
> 
> This allows e.g. PHYs connected to DSA switches which support
> timestamping to report their timestamping capabilities.
> 
> [...]

Here is the summary with links:
  - [net] net: ethtool: handle EOPNOTSUPP from ethtool get_ts_info() method
    https://git.kernel.org/netdev/net/c/201825fb4278

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



