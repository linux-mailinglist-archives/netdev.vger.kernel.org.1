Return-Path: <netdev+bounces-160524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A118CA1A0D9
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B22116DBB0
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBCC20DD63;
	Thu, 23 Jan 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7ksDXmM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194020DD5C;
	Thu, 23 Jan 2025 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737624612; cv=none; b=sGHKy++YQ9byI+yHXwhRILy/3v+Y/dNaGN8uwdDY2qg5rxwrBBNuxaAdFsOkniCvWl8vgIUE0EKILz1OVupnrkNd/FlnKHS1AbkTuq3loQ1N3BYwpqHkDs/RshH1VJfXfDqnGQqeDSjiPKv7h9HW6O1/sClNoz4TuW6mjJbpPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737624612; c=relaxed/simple;
	bh=N8ZOqsvilbTZc2nD+9GQpHaU6FbhHEu8mqq6T/91CSM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aq/PbESZU3Nt149o3Hv4IsxiQtOPIsshYv4V9rwXxph7T3N5kSFD/P2H6VCddkqMs1Xogy3mED/fNcbhmGQ1zDOd+Cd86c0wAdOqP/R+9sBPI89PenaPqjW3WR8EvoaHoJKz9UZcnMrFTcqrgnSlLEYhqNR1PjrbmSFsDLjgYog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7ksDXmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A482C4CEE4;
	Thu, 23 Jan 2025 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737624610;
	bh=N8ZOqsvilbTZc2nD+9GQpHaU6FbhHEu8mqq6T/91CSM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o7ksDXmM7YkeQPbj+bORg6ySYCEYovw1USaHf+dRyoOqlUK1U7qIXeW8M+oIP6OWc
	 s/YBsw2SHnf6HW8XOqviZW7B1brCD1AJLp8CNDFfj8fNP/oFBk7AI35FzdynTLYQga
	 EuPiNG8t3oHtIVT4NZLa1XTKJcHgJ9ZrDumLaIORmyGYPyzP+exaAuaIJPEi+/c5p7
	 wNUuv+5msyP8JgPBqWtIbKLdjxs5vNACCMc/HJ6Jm6QyiWQXp2MgMA1NbjMY3PRxP3
	 DQADCkimsAVKp+9eev1lfji+dYRmPeJijacpOme/NYl5f4yRDC+WGaCS4szk2k/Yfr
	 /xq/DN86a1XUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DF1380AA78;
	Thu, 23 Jan 2025 09:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: phy: marvell-88q2xxx: Fix temperature measurement
 with reset-gpios
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173762463474.1296391.8377642042031495293.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jan 2025 09:30:34 +0000
References: <20250118-marvell-88q2xxx-fix-hwmon-v2-1-402e62ba2dcb@gmail.com>
In-Reply-To: <20250118-marvell-88q2xxx-fix-hwmon-v2-1-402e62ba2dcb@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 niklas.soderlund+renesas@ragnatech.se, gregor.herburger@ew.tq-group.com,
 eichest@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 18 Jan 2025 19:43:43 +0100 you wrote:
> When using temperature measurement on Marvell 88Q2XXX devices and the
> reset-gpios property is set in DT, the device does a hardware reset when
> interface is brought down and up again. That means that the content of
> the register MDIO_MMD_PCS_MV_TEMP_SENSOR2 is reset to default and that
> leads to permanent deactivation of the temperature measurement, because
> activation is done in mv88q2xxx_probe. To fix this move activation of
> temperature measurement to mv88q222x_config_init.
> 
> [...]

Here is the summary with links:
  - [v2] net: phy: marvell-88q2xxx: Fix temperature measurement with reset-gpios
    https://git.kernel.org/netdev/net/c/a197004cf3c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



