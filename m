Return-Path: <netdev+bounces-153547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF2A9F8A0F
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5809A1694E6
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349A01DFF8;
	Fri, 20 Dec 2024 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuuW/aUU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087731C6BE;
	Fri, 20 Dec 2024 02:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734661218; cv=none; b=eXzFKGF6Cp9MuBuk4HYwoaq+pisEpjfIRS5LnekR3IlnDnK1Xv2zGWY572GqBZPrqH/ht66MO3U1ZkHkid0AkyqIY1AWgblme3indnVqeU4a88FYqT67q/+qTJzX7ff/K54bH19SoCrFIqudx4h/N7CI/saUQ6PLEnq4PtD3SqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734661218; c=relaxed/simple;
	bh=MEHtzrwVoYO4mR3l8Z9MZvbrZkvQt4WlOEoVjhZe4AU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kyq9D6WyOi+xXf3k/nkbZN50egJ7zPNmsoq5xVviiB/q5oDlJcluwNzKViJ5h8/Ayh1byE3+9O0kQzl4xmIln1gHfw/CtPpjhZQK2qy1Lfhl05oxSSGyvls4mdghFVASZoVeq5LmJEGaaYKnQfKLBAGHIBVzvrhPkoxrKI4NHJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuuW/aUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FBBC4CED0;
	Fri, 20 Dec 2024 02:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734661217;
	bh=MEHtzrwVoYO4mR3l8Z9MZvbrZkvQt4WlOEoVjhZe4AU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DuuW/aUUlGwD01VX5VP9SGE4x90H4bICmnVo72GhVJqLblZvOFtlbBts/Jwl49qNm
	 BFMtWFPnyYqysdNv+8emwpTqgGuedhAbFl7Adps2t6X16X0OfXTlkx5c7grxpvxrLY
	 Pphby43+ZPY6Ot/s0nGbvV24lJ+lDwCZQxHzHR6vOkJIJBmS3IzEuo/PirMUBLKl7M
	 oJjJbP6rvezwpvngsoMUIFEEVeI/osmrCoDJ/3XiaPebDNfRkWX+Nbv+tEAwCSnLY+
	 k7pwXMRXR249expzJ25oJU7dXHVley4BRhiaeZcL8f19CdkY77Cwt1LKGrvRradBDL
	 KlsyoxoVDnKkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 725B83806656;
	Fri, 20 Dec 2024 02:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: microchip: Add suspend/resume support to
 KSZ DSA driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466123524.2451213.17397152374725499590.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 02:20:35 +0000
References: <20241218020311.70628-1-Tristram.Ha@microchip.com>
In-Reply-To: <20241218020311.70628-1-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: woojung.huh@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Dec 2024 18:03:11 -0800 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The KSZ DSA driver starts a timer to read MIB counters periodically to
> avoid count overrun.  During system suspend this will give an error for
> not able to write to register as the SPI system returns an error when
> it is in suspend state.  This implementation stops the timer when the
> system goes into suspend and restarts it when resumed.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: microchip: Add suspend/resume support to KSZ DSA driver
    https://git.kernel.org/netdev/net-next/c/3fc87cb94f5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



