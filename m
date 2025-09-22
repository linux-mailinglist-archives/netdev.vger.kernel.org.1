Return-Path: <netdev+bounces-225434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360E8B939E7
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2F43AD8A4
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FFB2FC00D;
	Mon, 22 Sep 2025 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmvm1AZn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FBB2EE5FC;
	Mon, 22 Sep 2025 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584419; cv=none; b=QnzIutZzArVMrzc+y45+YofPHQRw/6Nx8DiW1S2tEZnxYXFYkDSFz+H7bAZRoOLteIMZEDyo6ced5P864xD5FfWHy62veFBDaPGPRW+/GbST8RTDyD//IthlLSY/9bHHojLCCol4xEfKYFfEf6pkyPWt3OM7PiVgBmfxlKOhA28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584419; c=relaxed/simple;
	bh=e+4gDmocNIpbwDa+bz2tDklxvVz7dECa+umrwZTQInk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CeC17bI22jhG2PijG+fDK8YwRjQWutkr1CzlKg7/ACqU1MXrg27dYRIMK6FZ+mlai8hWbJMtTgVofRimLtG9Cq1wxGt5k5u7+5Q4W/DQ3dRqc+VQiasMW8lUwuNu86iLGveVMCUcS7FazKMI++ZsM+MH3hw+Y54kulWQpcZdm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmvm1AZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED28C4CEF0;
	Mon, 22 Sep 2025 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758584418;
	bh=e+4gDmocNIpbwDa+bz2tDklxvVz7dECa+umrwZTQInk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rmvm1AZnNxfYMEYyHxPen4kTromVR6yk7rN68uWmy/1Hh/eHBkOL018T7IFmU+BvC
	 elU7eUsji2PVKOwMhhH1bpO99AePJNUoSuGWrs8rbnPPi9Lw5w/UExIQhAyOTXQDv2
	 K1x8rPZUKnoKMTuGL7h0HzhaFG8aBRQGmbdVvmG0hGwx72iHQxaLAI/IE1VrL04Go9
	 zbeG2brQXPm1mGnXdYEqM1MswHXr6pfQIDz6yDvw+hFP2HyzvOPom9/QtkiKhAAJk9
	 ROETqy+zwWTR5f6PPRZTO0+9eAf4twQ/WtAPMyitqAk2sc+OQdfuv820ElFG9jcuyh
	 EOIBCdp5+PHDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D5C39D0C20;
	Mon, 22 Sep 2025 23:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: dsa: microchip: Add strap
 description
 to set SPI as interface bus
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175858441625.1195312.14260104623562139849.git-patchwork-notify@kernel.org>
Date: Mon, 22 Sep 2025 23:40:16 +0000
References: <20250918-ksz-strap-pins-v3-0-16662e881728@bootlin.com>
In-Reply-To: <20250918-ksz-strap-pins-v3-0-16662e881728@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 pascal.eberhard@se.com, Woojung.Huh@microchip.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 10:33:49 +0200 you wrote:
> Hi all,
> 
> At reset, the KSZ8463 uses a strap-based configuration to set SPI as
> interface bus. If the required pull-ups/pull-downs are missing (by
> mistake or by design to save power) the pins may float and the
> configuration can go wrong preventing any communication with the switch.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] dt-bindings: net: dsa: microchip: Group if clause under allOf tag
    https://git.kernel.org/netdev/net-next/c/6bd5b7297c95
  - [net-next,v3,2/3] dt-bindings: net: dsa: microchip: Add strap description to set SPI mode
    https://git.kernel.org/netdev/net-next/c/e469b87e0fb0
  - [net-next,v3,3/3] net: dsa: microchip: Set SPI as bus interface during reset for KSZ8463
    https://git.kernel.org/netdev/net-next/c/a0b977a3d193

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



