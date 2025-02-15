Return-Path: <netdev+bounces-166635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D3DA36AC5
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 02:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4890C170130
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 01:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D3F824A3;
	Sat, 15 Feb 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1uOovKH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037C410F2
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739582407; cv=none; b=iKaoRqZud4JY3Qyn4eBUfQXisXFr2YloDzDqnHnJwxHd7y2u8gS4f4aRFRP/N5R/uKkHzt/Oc+rXcncigevCcEHBBqG4jZq0HRKmDA7ysudrTP3GpeqWyaqqBO3N3NoPGY96aoeZTUbRuKVvepe0A82y27latXsX4Z29w1cQGYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739582407; c=relaxed/simple;
	bh=u28CMpHeO9lqCC57zqQ1dJUD59exfibVzvy8eRHvszw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SAMAb5yyz96bQYNvikkugQEgOqxOpLkLuxKz5tN5BR163paPmA8IsPPHBAI2aktckInhXamd7cklXE423T0f1LqvXj1C2FZaKofgbuOjxGL0qriQX/Eu6OResbyAzxHAtVcwk/ej7vRtBU7/8qgq0vk5Is6PnyTroDawpOMX72c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1uOovKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C93CC4CEE2;
	Sat, 15 Feb 2025 01:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739582405;
	bh=u28CMpHeO9lqCC57zqQ1dJUD59exfibVzvy8eRHvszw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B1uOovKHiaFPJbGrZK5TK+KadOpVjNfUNJvz4CYj0SiaAE1juNf8P/5ajiDqmBfJx
	 qMlVtb1PqcFjqLlSd0d7NesnVGGda+DRVVClGLoFahHKtbMYwLkHP2N2+dNRS8V1Dc
	 BpxW+tOB3uBViF4MJjNcYy0xoXLxRlhfhWnDU4ssclRKx4C8vgTu3bzHvW1YSY1i0u
	 Qxvk2LhydJP5WeNzB5mWHfGp0W7pc44VPQLJhKYRo8wvh0+wKqxqVxZvy988iV44+z
	 FJehrqOEDiZBA6OIPy0T4SKEgVo5wiHnxDXobQy3AkvYaNY0VqKPOu8PcpiIq5GO1a
	 KfFMp9cYux84Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3415E380CEE8;
	Sat, 15 Feb 2025 01:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: phy: clean up phy.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173958243475.2159741.3520221651417794343.git-patchwork-notify@kernel.org>
Date: Sat, 15 Feb 2025 01:20:34 +0000
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
In-Reply-To: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Feb 2025 22:47:04 +0100 you wrote:
> This series is a starting point to clean up phy.h and remove
> definitions which are phylib-internal.
> 
> Heiner Kallweit (4):
>   net: phy: remove fixup-related definitions from phy.h which are not
>     used outside phylib
>   net: phy: stop exporting feature arrays which aren't used outside
>     phylib
>   net: phy: stop exporting phy_queue_state_machine
>   net: phy: remove helper phy_is_internal
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: phy: remove fixup-related definitions from phy.h which are not used outside phylib
    https://git.kernel.org/netdev/net-next/c/ea47e70e476f
  - [net-next,2/4] net: phy: stop exporting feature arrays which aren't used outside phylib
    https://git.kernel.org/netdev/net-next/c/d3a0e217f850
  - [net-next,3/4] net: phy: stop exporting phy_queue_state_machine
    https://git.kernel.org/netdev/net-next/c/ef6249e37df5
  - [net-next,4/4] net: phy: remove helper phy_is_internal
    https://git.kernel.org/netdev/net-next/c/6b2edfba7469

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



