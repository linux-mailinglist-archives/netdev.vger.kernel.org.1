Return-Path: <netdev+bounces-200898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D18CAE743A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC0F16C2DD
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 01:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1BC16E863;
	Wed, 25 Jun 2025 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0Al0brl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6747D07D;
	Wed, 25 Jun 2025 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750814380; cv=none; b=h0Y4W3l5WHjBnlfg3nohX80ZYQvq8A2B6919S5EXymE8rTqdBBXNsGqmXpCCbM2XvtuJEAn9p11zLbU42c5Xh3X+CRXwFrs7fCWXxHk7V4UsJoRZQcrstxQAshk5WI5E5wutfz/ohgnuwbO+oxn903zkf33OpLGmXdwpiwbkwFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750814380; c=relaxed/simple;
	bh=ZZpsGWbOpD7WESphcM99JbXk8HbeWzvARFtH/vuKhN0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gmOlMNoSB5Av+prdiMVR3yG2GplNYxKeaTizyavrYZTz+qPpr4QKrye9EFcTTmGa+luyxehKb/UX7e9G9avyUfqrHvXv9gE1g9ieyp2sjF+AAYmMWJ/nDQlDXtg5Wts7AlW9shSW+AlcLBekwz871UU8vJoGqpS/DRfYn3CP1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0Al0brl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017B1C4CEE3;
	Wed, 25 Jun 2025 01:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750814380;
	bh=ZZpsGWbOpD7WESphcM99JbXk8HbeWzvARFtH/vuKhN0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I0Al0brlBqf41dLwop2rFptO4UbjKFq70OE8lHSZ9yLbuijSpw2nvLSyTxMCV9IWo
	 Y6zTrT6ppD2GOter0dx8krnwznO80xFTUf6DHxkXT3L2Sxz0vqvhekFTGkqaN80eX1
	 Dpq7JgpB5qliGIf1LQqYtYfN2x2o5Sb2fqXubdm9ukJTeju8KJxUwn11L8hLEonUF4
	 8eNYlL2upxOjBDW6/nRGav6L42H1P5PDm14NT8MczCys1qjbvqBL1s2dx2W+gta7js
	 QXc6oqS26M3rjdbArmmy2JcRFjrcImUHwBVIcbCFvo5ZVq1KgHAXtMfbki0lXM6j90
	 b87KEbttVHzAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9739FEB73;
	Wed, 25 Jun 2025 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND][PATCH 0/1] Enable FLEXCOMs and GMAC for SAMA7D65 SoC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175081440675.4094974.16233310616580116141.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 01:20:06 +0000
References: <cover.1750694691.git.Ryan.Wanner@microchip.com>
In-Reply-To: <cover.1750694691.git.Ryan.Wanner@microchip.com>
To: Ryan Wanner <Ryan.Wanner@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Jun 2025 09:11:07 -0700 you wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This patch set adds all the supported FLEXCOMs for the SAMA7D65 SoC.
> This also adds the GMAC interfaces and enables GMAC0 interface for the SAMA7D65 SoC.
> 
> With the FLEXCOMs added to the SoC the MCP16502 and the MAC address
> EEPROM are both added to flexcom10.
> 
> [...]

Here is the summary with links:
  - [RESEND,1/1] dt-bindings: net: cdns,macb: add sama7d65 ethernet interface
    https://git.kernel.org/netdev/net-next/c/8dacfd92dbef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



