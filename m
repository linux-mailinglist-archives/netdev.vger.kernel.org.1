Return-Path: <netdev+bounces-129517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D78984414
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 13:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA76FB2394C
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447641A4E8A;
	Tue, 24 Sep 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDmerg2/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207351A4E84
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727175629; cv=none; b=aXuHCBlFBptYyklYjhgzutH8q7/lV6OsscM5l5yqSHZiRLnw50kvt7cTPGQuycI4WUtBX1/ifp9wI2mTLwDftuCGmQlpLDRgoWiot376CnFMdFQkTRCWLeFCcUFCRbNUGnjA4Jg5nXwgY0d+az04GqDrJfKh9fAizGOkNXt752k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727175629; c=relaxed/simple;
	bh=afQbrbZOJHecmVUFRXMVMemhZh0pO0U5byO4MWxFs6g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oIMSSuQTBhf8iPasflYWZF5oDKFXRmrBUY4WNECsr9l52Tc5NRxNJm1ZghCkCaj4WTzTjFD8nS8UaUg6JYW6iJnspgbo8kZ3HOnkiLw7gHgtxZz8fsXTjoY2WfPNFyBvK9JiuD1SHq8qC+NTrK8Hs/8fUZHGArWMtEVyNN1Ur0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDmerg2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C890C4CEC4;
	Tue, 24 Sep 2024 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727175628;
	bh=afQbrbZOJHecmVUFRXMVMemhZh0pO0U5byO4MWxFs6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IDmerg2/umulyR9sNw09HvgIHbII4bYbki/kUJS0cGSYnJZjOfS1QtUlh801Lja6Z
	 Fdz3kZlPmc3X0x6V85urtIX1tyOFNTWZw63RVbW//YgHjsERADD+6oNMUshhKvaSu9
	 q4M7+e9bjiwmZv76vyw3AHMUU9gUTdR/HzMOPv0/eWmnPYf++rJZjrJ9twvfXXrzVk
	 HaGQ4VEcBWLD17Ie/18+HxnePaTV8nJ9wg/l3UtLEgica8yn5LvRTxx9UDtcwGyf2n
	 ygKUbOblayVhm1i2dei/EGMJROJZryYHoMjka3yMwOyHuLMdbHxG/joU5Nt8Ivquor
	 CaO+QKPA94szw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FAF3806655;
	Tue, 24 Sep 2024 11:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8169: add missing MODULE_FIRMWARE entry for RTL8126A
 rev.b
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172717563101.3990878.14506917998516293967.git-patchwork-notify@kernel.org>
Date: Tue, 24 Sep 2024 11:00:31 +0000
References: <bb307611-d129-43f5-a7ff-bdb6b4044fce@gmail.com>
In-Reply-To: <bb307611-d129-43f5-a7ff-bdb6b4044fce@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, nic_swsd@realtek.com, netdev@vger.kernel.org,
 hau@realtek.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Sep 2024 20:45:15 +0200 you wrote:
> Add a missing MODULE_FIRMWARE entry.
> 
> Fixes: 69cb89981c7a ("r8169: add support for RTL8126A rev.b")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] r8169: add missing MODULE_FIRMWARE entry for RTL8126A rev.b
    https://git.kernel.org/netdev/net/c/3b067536daa4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



