Return-Path: <netdev+bounces-196761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D89F1AD64A2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C791BC397D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF6335977;
	Thu, 12 Jun 2025 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWJpc4Qi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE4EACE;
	Thu, 12 Jun 2025 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749688809; cv=none; b=qAeWjxbPz9k0ahiZhGm655SWSc2JgU85NTqiAcKOV2dxCQBY1V/sMxW4U+MeeUX8sOSREg9Jt0iE3JX2GbA+o8uoOIpmj+MzquRr/X2/4ELHUwpUXMkEpbPwiTukaxqQyNyrrqiIQGmAFJlt2+tlGIV208+qrrErxpCL28IZagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749688809; c=relaxed/simple;
	bh=PiyhoAc6+GZvCsfQ2F+RCgbXpMYwYqCxeykWHBqua9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SqkhbbM7Ct7+WMXC4+EjjX56fAZI+i8k3l+Bnw0zwGB/G+fEhakHWOID0gYR2jYOwGEtXNSDwh2G4HbWHfKFcFoGoL1zYr1lCQ9UvafXLzRu20fT3ztnpUSloEBUK9ce5UYsQLAFi1iFtFkofQbSPM/uc8Pt7FwNXzUc+VoPLV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWJpc4Qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F14C4CEE3;
	Thu, 12 Jun 2025 00:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749688808;
	bh=PiyhoAc6+GZvCsfQ2F+RCgbXpMYwYqCxeykWHBqua9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aWJpc4QiYvNDJluKcI/kEssd81Q/qTMZGjlwBevDIf7lHNVV2hbX0MICQu2KwXo+2
	 VEML/25qyXQiEGv+V5x7qbfXCkWRz1C8uz1hfeqJvRtjCLZgeYoYypU44iF2U0WaXH
	 OQ0M2YfUnJWiY5E0aw9sypySLWb364u8UabUgMkH4SVrwRDUruo97R4OUIbq+c5XXo
	 dd5Bls6rI21d/HIsGa4D8KafVNKMgilAiukyXr0bnn6Yw200TyhcW07pFlCXjNLAxu
	 guUefIAlqMrVDcNkjzCZQcnDd5troYfbEy5HShfi4hA2L6n9otsJoXVlvJ3ELXmxIt
	 7iphlmdoJbqyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0743822D1A;
	Thu, 12 Jun 2025 00:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/3] net: phy: micrel: add extended PHY
 support
 for KSZ9477-class devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174968883848.3549461.11747861450571986801.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 00:40:38 +0000
References: <20250610091354.4060454-1-o.rempel@pengutronix.de>
In-Reply-To: <20250610091354.4060454-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 11:13:51 +0200 you wrote:
> Hi all,
> 
> This patch series extends the PHY driver support for the Microchip
> KSZ9477-class switch-integrated PHYs. These changes enhance ethtool
> functionality and diagnostic capabilities by implementing the following
> features:
> - MDI/MDI-X configuration support
>   All crossover modes (auto, MDI, MDI-X) are now configurable.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/3] net: phy: micrel: add MDI/MDI-X control support for KSZ9477 switch-integrated PHYs
    https://git.kernel.org/netdev/net-next/c/ee868127170c
  - [net-next,v1,2/3] net: phy: micrel: Add RX error counter support for KSZ9477 switch-integrated PHYs
    https://git.kernel.org/netdev/net-next/c/597ebdf37222
  - [net-next,v1,3/3] net: phy: micrel: add cable test support for KSZ9477-class PHYs
    https://git.kernel.org/netdev/net-next/c/b2f96c3c9631

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



