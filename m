Return-Path: <netdev+bounces-197284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB720AD8033
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959611E1E2A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92BF1DED5B;
	Fri, 13 Jun 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pARyP37I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52DD1420DD
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749777603; cv=none; b=MROSFhLA2qkzwp99L0IoRCq1eVOd44JWbr3gyXjk0h1z587OYjZ3YEzYOexG+ykX1S7guqPpw3SYAegT1E6uUYqQlfhUY1yHdc4kooYbmW4jWQ1RwYrGqVESjFJtIgBSoNqO4OlqgP/GBR43R07oU7t3lpsOQ3qbyo2TaJIqHmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749777603; c=relaxed/simple;
	bh=wIqBQL98xHp3rUbvmJ5U5fMsfAiTspFoqSSw8k+F4+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VcRXo6jn/RmcIIsgfwO/e+/LbT86zoGw//wGiuArGuucHZXlPU8p5jUKWED6qEe+t1X9V1VoY0u9udmS4cz49T0IcmkbSChde1DJkX4FHESsnhAUTkxMNVhVElXN+IG5ZmavGTnHo0cxIJnqPSX4uA2qUMzihHT1NZVBXRcZXuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pARyP37I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E7AC4CEEA;
	Fri, 13 Jun 2025 01:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749777603;
	bh=wIqBQL98xHp3rUbvmJ5U5fMsfAiTspFoqSSw8k+F4+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pARyP37Ilg4d+tVjkX9m0A4xzETDzHnRBAb3Qtm20lFBmcrN2UGg2/iJzOg7zXh6m
	 ZpQ+oEAw499qOSCD2629gucc6SNmS/36dxOeJyrOv1YF9rswLjNdCitB2ddEqZbJLn
	 1ZwDiRc8x8/9uulF52OJTFvWcoptGxiMdkU4IbzMeZVOAS74ogW9ZCnEiuseyXC0tV
	 gptZ+zhDCKEf1lm/8nAaADsbRzcoPWQkDpw0KTFXxnZ3fY8UMAjTfsGoeimG2TOUcw
	 rl4h8XsHhOoEiiMxT/FppCRnZdi+r5uKa4HDji9zZmCFVLmyW1TNFYEyDv0T0beOIC
	 u5HpjlXpR81Zg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B5339EFFCF;
	Fri, 13 Jun 2025 01:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESUBMIT net-next] net: phy: assign default match function
 for
 non-PHY MDIO devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174977763273.176894.12096002664354990915.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 01:20:32 +0000
References: <6c94e3d3-bfb0-4ddc-a518-6fddbc64e1d0@gmail.com>
In-Reply-To: <6c94e3d3-bfb0-4ddc-a518-6fddbc64e1d0@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 08:03:43 +0200 you wrote:
> Make mdio_device_bus_match() the default match function for non-PHY
> MDIO devices. Benefit is that we don't have to export this function
> any longer. As long as mdiodev->modalias isn't set, there's no change
> in behavior. mdiobus_create_device() is the only place where
> mdiodev->modalias gets set, but this function sets
> mdio_device_bus_match() as match function anyway.
> 
> [...]

Here is the summary with links:
  - [RESUBMIT,net-next] net: phy: assign default match function for non-PHY MDIO devices
    https://git.kernel.org/netdev/net-next/c/b1b36680107e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



