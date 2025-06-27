Return-Path: <netdev+bounces-201846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2080AEB2C4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA90A189FE4C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234322951D3;
	Fri, 27 Jun 2025 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgwWRWVD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC322737F9;
	Fri, 27 Jun 2025 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015989; cv=none; b=Ge/ZfoiaFhHK+gEqsSzS3x27dynb4rzg+psD8imPa0L3MHsPrGzFSlDKHqvYZKUuDZyGE0R8sqRv2aaykBYZYys4qn9mfbIHvgeKM0ebVYQL69H414LYIul+CcVN0KwYMKE0gnLn79xlvliK0Ubsgd3Yut6ox51Vk3LcdYvsH1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015989; c=relaxed/simple;
	bh=HHy2Pg+UE5KBn+wjLN9AO5SYJKUua6er5GUgihVjtY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=max/m8ziC9A3d9jx/CyQwCll8zOWriApFwYuEroBoMOQL2k+hTjUJN4INhnTnwbBX2PqDNhKLYaMA0ea0byB0snbxRTFSu+JiJVUUKAPp2zZExrSCVfqOO9RH403LP7NTFqcruiXwEHX/5DEx/75bEIOl93oQuZ9KO/Jp4mr+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgwWRWVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62638C4CEE3;
	Fri, 27 Jun 2025 09:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751015988;
	bh=HHy2Pg+UE5KBn+wjLN9AO5SYJKUua6er5GUgihVjtY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qgwWRWVDVhheB5BxvJvnEp840lhClu6AanuM19OkKHyd4M8Rj+dIQUAFUIRZbtspo
	 KEgMosl1lEYvSgC8oGl6vbbS4TT8uRfasoJ4hmTQ/De9vfoJjANzB+XrJsZ66D+npY
	 DdD7dju4WW9F7g3C3uz190GZUYUN/pUDRdHLiJqfnugJ1itua3DtAAaLE8tBSYV2/k
	 Y8xsDxWVIzScNMTFem9akqq09JRpU4OOMIGUuCcsf0BwJftyaRo4LKkJNXvz7M5VVN
	 XZxDmwVX1NzsktqiQ+ycP5FFNbKcYUopm2mwBCvd4HwNCMSwFruaE21r/nQfum2iGN
	 SwpgboaZwRO9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB73A40FD5;
	Fri, 27 Jun 2025 09:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v2 1/2] dt-bindings: net: Document support for
 Airoha
 AN7583 MDIO Controller
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175101601424.1850068.15093063500117944287.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 09:20:14 +0000
References: <20250617091655.10832-1-ansuelsmth@gmail.com>
In-Reply-To: <20250617091655.10832-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 p.zabel@pengutronix.de, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 17 Jun 2025 11:16:52 +0200 you wrote:
> Airoha AN7583 SoC have 3 different MDIO Controller. One comes from
> the intergated Switch based on MT7530. The other 2 live under the SCU
> register and expose 2 dedicated MDIO controller.
> 
> Document the schema for the 2 dedicated MDIO controller.
> Each MDIO controller can be independently reset with the SoC reset line.
> Each MDIO controller have a dedicated clock configured to 2.5MHz by
> default to follow MDIO bus IEEE 802.3 standard.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] dt-bindings: net: Document support for Airoha AN7583 MDIO Controller
    https://git.kernel.org/netdev/net-next/c/a6ee35bd1fe0
  - [net-next,v2,2/2] net: mdio: Add MDIO bus controller for Airoha AN7583
    https://git.kernel.org/netdev/net-next/c/67e3ba978361

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



