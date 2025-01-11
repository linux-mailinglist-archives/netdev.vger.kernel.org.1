Return-Path: <netdev+bounces-157473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12254A0A623
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 22:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFD81889F41
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A464E1BD9E6;
	Sat, 11 Jan 2025 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbIgfj5/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8DC1B982E;
	Sat, 11 Jan 2025 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736630412; cv=none; b=EIHWBcUIMHppRaEFBCj0X25z/31TTnQJ6nox2NGmbVmJimFx+Mh8Hja5cFESDkKDb6xwjhu6YBmYvDNBAU04qj14DcdtBkkhL5H90KSLTlj8vdCO14IC2KzgoqZK4FQRNnlZmnR0bsTGYYJfK/9pPN8lpGPZj9va+KsKsKzNvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736630412; c=relaxed/simple;
	bh=vDWEw6A6EtCy0Ulax7gXxsijZyn2FfluwuXJZBWkaYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a7gUxrCRUfa7K45XBN7nStkC5qlw/Ts3xDQDLWDpJsqsxGgohGi4kZsVC7H35017BYXhmFbcon/exbgwvMsLI6mfRvrE4MB3JaNf+83BbwTV8nhdFaIiHfe2BpTRKWk8SlSlmfJ6iWIngMnHxicvkDFtHZmrDmAUTWrnXXUDRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbIgfj5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7B7C4CEE1;
	Sat, 11 Jan 2025 21:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736630412;
	bh=vDWEw6A6EtCy0Ulax7gXxsijZyn2FfluwuXJZBWkaYY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mbIgfj5/DRvq6oS4zlTJ1LqjTX0wKUMem/bIgraOvFYiH+zrbEVIxiHWkZ9E0cV1e
	 sQseeQADtFtrIgzuz/fprwnFo4PS80kYRpQ4q991e2s8D7Zr/NQShc/GgyRH4Jh78I
	 Eg4jrSwAqRztnsNo9fXNkYSHCu4K8lzht5Ej7GrPUJ4A+i1ON1bkv4gwErZ2bA1jJK
	 faHwJoX+RVp/BT4mguINib1lDx4UteDa5mEVFzRzKzSd/ZbVO/XYBV/OxtPj/lXemt
	 XHZ58aVgiei+mJBDbNgDCPTSNpBR6HQKD8TGYB6XnozbBNt6WGRwFnroqiTlJS3KQh
	 u8m0TOwQ45mqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD00380AA54;
	Sat, 11 Jan 2025 21:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: dp83822: Add support for PHY LEDs on
 DP83822
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173663043433.2451513.1654560811069762556.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jan 2025 21:20:34 +0000
References: <20250107-dp83822-leds-v2-1-5b260aad874f@gmail.com>
In-Reply-To: <20250107-dp83822-leds-v2-1-5b260aad874f@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 07 Jan 2025 09:23:04 +0100 you wrote:
> The DP83822 supports up to three configurable Light Emitting Diode (LED)
> pins: LED_0, LED_1 (GPIO1), COL (GPIO2) and RX_D3 (GPIO3). Several
> functions can be multiplexed onto the LEDs for different modes of
> operation. LED_0 and COL (GPIO2) use the MLED function. MLED can be routed
> to only one of these two pins at a time. Add minimal LED controller driver
> supporting the most common uses with the 'netdev' trigger.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: dp83822: Add support for PHY LEDs on DP83822
    https://git.kernel.org/netdev/net-next/c/c5a965701866

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



