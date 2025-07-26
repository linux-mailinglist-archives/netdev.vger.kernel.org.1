Return-Path: <netdev+bounces-210310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9ADB12BE2
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 20:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E55F189FB50
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 18:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7A0288CB3;
	Sat, 26 Jul 2025 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKmuLd9N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB75288CAF;
	Sat, 26 Jul 2025 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753555208; cv=none; b=lHiLqw0suD5tEKTAYcUtAH3mrtDi0hLebVil6O3lhWHx4LmDYDst2tIH9mgBalVVM8aLO4Na9Jt8hb4AWDGqEdL2eET5hhDyIzNA21ty5T7bgRoAouV4NBaoWTh25nBkPkQ4gur/F7hhuBef0TzLVReyWXwN4uayoXUdoNWDdj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753555208; c=relaxed/simple;
	bh=slhXj9ZnZblb/hPj1KmavhFL4eNp8rvn2VLkAoSF4Yw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GQoP1Dj8eLwtusytMDNXA0UZSJdWcz1GjJOwtyyERuym2x5C7BDtYesNmep/8o0j7OQ9wvIaB+OFmUxUqxL2+oUyTPYmEiaXejX5dyfeH6bGlIPhfKu5Xt3z1kUMRkb47nCxDzGrabFUO1QMokpBX9cPRFcpY2vGdzDeeLz8UhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKmuLd9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491FAC4CEED;
	Sat, 26 Jul 2025 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753555208;
	bh=slhXj9ZnZblb/hPj1KmavhFL4eNp8rvn2VLkAoSF4Yw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aKmuLd9NUEDBWiehiKidDGOLyTaHP+FVIo66IPc6HzY8W6vN7nbDxcVTV6UjD6QR+
	 8Y3gjMgOc079huDHpqCy9EQaWDHBxDaFalRh9a/vZIc0ZLT0Ul1bdpF9AE8ifcp8iu
	 usD+328flA76vLtlzQjpvwlDHl8vJE9OfNeJfPdsZ3fCi7u278oeclaW9Vt7kR8EAi
	 44Kokim/gcAYzLPIO4JT5AV8cwfKUZrXkzqoH3nb3BMbxBWb1P/TQV2ZdGMbRgHdSg
	 EFEtpibLvQb+4bEttayxLmSgyy4aaV2lCaXQFLMxXWO5Ca9Ig455CnKD8EtMd33Ll3
	 bq6JQ6Y4r3WUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE20D383BF4E;
	Sat, 26 Jul 2025 18:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND v3 1/1] dt-bindings: ieee802154: Convert at86rf230.txt
 yaml
 format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175355522524.3664802.13412387588392922957.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 18:40:25 +0000
References: <20250724230129.1480174-1-Frank.Li@nxp.com>
In-Reply-To: <20250724230129.1480174-1-Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Jul 2025 19:01:24 -0400 you wrote:
> Convert at86rf230.txt yaml format.
> 
> Additional changes:
> - Add ref to spi-peripheral-props.yaml.
> - Add parent spi node in examples.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,v3,1/1] dt-bindings: ieee802154: Convert at86rf230.txt yaml format
    https://git.kernel.org/netdev/net-next/c/d7e0d327805b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



