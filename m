Return-Path: <netdev+bounces-116950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177CF94C28F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 18:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8981BB22382
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3A2191F7B;
	Thu,  8 Aug 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONPkmZet"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F2191F6E
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134046; cv=none; b=J4xUdVBwinDHeH00PjFFHDFj+JysZ53QauWzMEy7dNlvKW8lx5GRnQJUz6ouLZkk+P4+r6hzfvnHYP2HwTa5SsPA6TyKfVqGYqMS6omPnN4Y2BmOyIEmHO0cyzoARQr6Q3RrG3e4HQqhfFGdPmm6Ebb8fRHE1p1+QAEO0IDyNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134046; c=relaxed/simple;
	bh=ZrY3sA1aEnurntejg6ACvrRvt/K/r9lY4MErRxD0t/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pWHoAtDGu9njDmwkkd6wGosRM5HBAO5G/ZONZ0r8GfNAxHglYk/IRnv+Gu0pIg2Ou5PPEAnxIlqgInWa7FGw8m1h0/CSlv2T5TYwadt2cwsj1PiGiZFw+ktodaCaL/MtKCaDrlMnQTAhTChOlTU9+ZBaVjWKGcuJIL+mUdnK8JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONPkmZet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4F4C32786;
	Thu,  8 Aug 2024 16:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723134045;
	bh=ZrY3sA1aEnurntejg6ACvrRvt/K/r9lY4MErRxD0t/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ONPkmZetOLXk3L+Vugit4gunPYrdtrJ5Fk726UHs/PfZHTRuOoO/LT/9k2dirFioa
	 Hjs4IRB2Qa/Gt0njrihaWvkr1qC855BefNL/MkD+3j9XTSWg/JDZ/p/qNSJQ06HJ0N
	 McYoboKJshxlTnYreJzd1x0k25qZx0w82NOkGDGtlpMr5Y2xmtApgTeEy5uFgivCn8
	 R3nFbePkNbq8PlK70txSS40GBNq7lVwotnsAVo8y+WWpiK6oN+0iov6Dm8GGeW63Je
	 kv7xG+Bbaso8Iav9YdPskS0Iw+wg+1/RdiF4zEKtK/lHdvvTemhsoAXPg4KfgopZ9+
	 InjVdxmMcLB7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1CF382336A;
	Thu,  8 Aug 2024 16:20:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: microchip: disable EEE for
 KSZ8567/KSZ9567/KSZ9896/KSZ9897.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172313404466.3227143.12170621347454100675.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 16:20:44 +0000
References: <20240807205209.21464-1-foss@martin-whitaker.me.uk>
In-Reply-To: <20240807205209.21464-1-foss@martin-whitaker.me.uk>
To: Martin Whitaker <foss@martin-whitaker.me.uk>
Cc: netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 Woojung.Huh@microchip.com, o.rempel@pengutronix.de, lukma@denx.de,
 Arun.Ramadoss@microchip.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Aug 2024 21:52:09 +0100 you wrote:
> As noted in the device errata [1-8], EEE support is not fully operational
> in the KSZ8567, KSZ9477, KSZ9567, KSZ9896, and KSZ9897 devices, causing
> link drops when connected to another device that supports EEE. The patch
> series "net: add EEE support for KSZ9477 switch family" merged in commit
> 9b0bf4f77162 caused EEE support to be enabled in these devices. A fix for
> this regression for the KSZ9477 alone was merged in commit 08c6d8bae48c2.
> This patch extends this fix to the other affected devices.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: microchip: disable EEE for KSZ8567/KSZ9567/KSZ9896/KSZ9897.
    https://git.kernel.org/netdev/net/c/0411f73c13af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



