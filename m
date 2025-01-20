Return-Path: <netdev+bounces-159769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98152A16C74
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19413A524D
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DE81DFDBB;
	Mon, 20 Jan 2025 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pin4uBQC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A081B86F7;
	Mon, 20 Jan 2025 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737376805; cv=none; b=MGBu0zaxfaMhjHggqH7KrC1Y0GX3GR3Vmscq5Zvqls7INldnwCsmHbaZXvskFzgnriJkl4WMEp6HBJtIBOp58Ja0SuL9Xb2XwRKo0uP9Vzt2z86JOxIvX4c6EtRZjLsfgvas09P7tpK1g7Tw56Vfaz5GdrVCX+x21izIIs+uf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737376805; c=relaxed/simple;
	bh=fZc2a6tDS9L/wQ44T90GZf/WZl/atcL0p7qKocnG1QU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JLmMAUR3PG5O7BJabvUzmFOqUhhBZiEuu3dBydFp6kUS8fcTG5GcAbVZDC7DeCs+EdGsvEKybVVMCmL6zjj9yD5RKEU/L7Q+aaY9NW2b5uhpA12BpjI9B2n+4J6ciiBipkInx+/ZGK7/kHUcaAE8QmuZfc269F1C++AQswTkhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pin4uBQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FB9C4CEDD;
	Mon, 20 Jan 2025 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737376805;
	bh=fZc2a6tDS9L/wQ44T90GZf/WZl/atcL0p7qKocnG1QU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pin4uBQCRQILpCSabhj2qJClvg0l1Gnh06iAla3++T5IK3i70hOMBMmxD4EcACfJM
	 JfjhoBo+8hadpR2AJPDWWyyCh46rhXarg0irQ5Dn9MZXy5zlcgquUQVlIO6qgBSpwf
	 txYIszK+T8a4MbClYg1r+PZeyskiSgxNDmvmp9GWJ4iyCmIGqV6bUDnbdhs8gGveXZ
	 6i2tMEu1c2StwZeOx/tdHIT9ZWURRYmlbGUecos/yTHIwRsbeolfHFfWg79yLiMVHy
	 2G5oLveSjXyW4q+t5wBSjOcL1Ey5onX3/CbueaFBM5MgCt8OmYu6Yw2SvhxuOI2x5V
	 qs1iLrXRNqVQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D12380AA62;
	Mon, 20 Jan 2025 12:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: HWMON support for standalone
 versions of RTL8221B and RTL8251
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173737682925.3514605.1334404716425790297.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 12:40:29 +0000
References: <20250117222421.3673-1-olek2@wp.pl>
In-Reply-To: <20250117222421.3673-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, ericwouds@gmail.com, kabel@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 Jan 2025 23:24:21 +0100 you wrote:
> HWMON support has been added for the RTL8221/8251 PHYs integrated together
> with the MAC inside the RTL8125/8126 chips. This patch extends temperature
> reading support for standalone variants of the mentioned PHYs.
> 
> I don't know whether the earlier revisions of the RTL8226 also have a
> built-in temperature sensor, so they have been skipped for now.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: realtek: HWMON support for standalone versions of RTL8221B and RTL8251
    https://git.kernel.org/netdev/net-next/c/64ff63aeefb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



