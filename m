Return-Path: <netdev+bounces-145504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD19D9CFAE8
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FFB284A98
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B327F1AC450;
	Fri, 15 Nov 2024 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyWaAKKW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D81922F9;
	Fri, 15 Nov 2024 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712228; cv=none; b=k5Xp9Xb1VX3X1j9gdge41gdjypZKKFvW59Q/qCQ+QLDLHxuHu6RLNS3Xxh4sfbFW0AJfgLgqN73j2FSL+ESFcPgbJ2SHYQx53nDc/JGq52THKrguF6t9WVk2Pfmy9WDkpmEHXw2xxh0HBvR85iKa7bZOXmavt9VTEnjMs0FMJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712228; c=relaxed/simple;
	bh=NQBnITOZNi1vFSfccm0jyqvLbG+YaclL2jPy1WOI0xE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mlXo/LgFNyaJnNfy8gj44hJ4AdIXeeobba9Eo2iNyr71WNyiuQ2QSt++v9aPEKIBhiLLy3ZkE7XLvJWBvfpudV+X2rR6WUx3sKrOFoPOf0Xj/BUqDLdwCTVgpd/YTbqHp+PwhgFfjSn7TcHwHW+j+CHFb6Ygarfi6mD3Towv9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyWaAKKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2828FC4CECF;
	Fri, 15 Nov 2024 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731712227;
	bh=NQBnITOZNi1vFSfccm0jyqvLbG+YaclL2jPy1WOI0xE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kyWaAKKWG0nLqyA4SS233UbhQvFJJ7XBpsXQxrvMjQkyYxJfFvaCQq8WGzQbjWIz4
	 eXGXQVy5ikUxNT18S0Goj7Ojenn9icKziLGqBC7ozYAZOZVSPPGzqc0NGt9ROFooLU
	 xhBS7Ebm5It5Q1JXL7RAWyVzzyAngwg2c6utGQIT4v7Eqf/te0pGpmg3kqhV5ZJJZP
	 tx1Ij4Ski07gifLM0GPX7xdFqH1WszGnlXpwCZZ9+RgphI97J8IoKQY/4KC8BL08YO
	 TAGM6BcH5KkfyAGFXWgXhLEerlq9qXH7QLJcnPYKVRrDyshLQ3Hh8UO0l00vKujTbk
	 VOBcabP6LDniw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340273809A80;
	Fri, 15 Nov 2024 23:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: dsa: microchip,ksz: Drop
 undocumented "id"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173171223773.2762542.1275950515020254098.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 23:10:37 +0000
References: <20241113225642.1783485-2-robh@kernel.org>
In-Reply-To: <20241113225642.1783485-2-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, marex@denx.de, Woojung.Huh@microchip.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Nov 2024 16:56:43 -0600 you wrote:
> "id" is not a documented property, so drop it.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] dt-bindings: net: dsa: microchip,ksz: Drop undocumented "id"
    https://git.kernel.org/netdev/net-next/c/6bbdb903db08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



