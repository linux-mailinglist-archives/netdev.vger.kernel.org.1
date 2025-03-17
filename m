Return-Path: <netdev+bounces-175447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECFAA65F56
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7977B189F07E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F4D1F8ADB;
	Mon, 17 Mar 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urPPQhA2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E9D1F866A;
	Mon, 17 Mar 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244002; cv=none; b=U1y1cz8HCQ/gVacAbgahOInHmsAyGCNsVctBuiJWQZaK6b15crUQ24/BUQxRfPPOw+8R4+qHJ7ESNxzp/p0l9deDsi+jj/8almPvHFHc5zxDGOQLERgO3UQLHAY6I86ZL3dTTEQrXZerDT5aU9bJ2cmVdFiLKqwIhkNkKun9y+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244002; c=relaxed/simple;
	bh=bg8zh7pHi9WV+Xqo4nnuI4GgxJupgiswX+PxbWPVGNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TAMCqZIOjpct5fYFR04QBV+3Kur1vdugbrWI8T//0jCrqdAJyMXJqehHFd3AcLJRV8O90QBmz6GJTH3Im40f4H6MTGZJB3NSA53zrguuBjKatLCiRh+iegKVFMuMReAXNcaLuhFWTF1cAGA9kBZ2l72hiJqR3lf2JIpd0CJwJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urPPQhA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3356AC4CEEE;
	Mon, 17 Mar 2025 20:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742244002;
	bh=bg8zh7pHi9WV+Xqo4nnuI4GgxJupgiswX+PxbWPVGNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=urPPQhA2v9OINE6Qmu6tByZbozfJtvAywl/I6VI1eUn1zTL3TxVTBNf1BW4kBb8L3
	 91VuIvdFFRqyfujXWhBHpxn7L8+7CncOEslBXJeAyztIPEDZPfTrACSvvd7wwQoGzv
	 VwfSxwhdlpKyaMxXdObKns5NVXwxEvXjHLgr30rjTGFi9JJ8il1jPY1LuG+EC+hiGr
	 zRO8EqE0WnG5wFC2ItdiGut97bCiXdynQNky+IZWg3HLCGIX+kV4nknHOav20L1rK+
	 ZhdU+v/C+3A05lwgqq6SQ+oLAZ88EJFcruWQ77zK3thjhYlC8zzyzhJPrylxWMJ3uG
	 LOgNj64eUohOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE30C380DBE4;
	Mon, 17 Mar 2025 20:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3]: cdc_ether|r8152: ThinkPad Hybrid USB-C/A Dock
 quirk
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174224403749.3906420.14528772392136964974.git-patchwork-notify@kernel.org>
Date: Mon, 17 Mar 2025 20:40:37 +0000
References: <Z9GEP/TksqEWFbkd@birdy.pmhahn.de>
In-Reply-To: <Z9GEP/TksqEWFbkd@birdy.pmhahn.de>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: netdev@vger.kernel.org, oliver@neukum.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 leon@is.currently.online, kory.maincent@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 13:55:27 +0100 you wrote:
> Lenovo ThinkPad Hybrid USB-C with USB-A Dock (17ef:a359) is affected by
> the same problem as the Lenovo Powered USB-C Travel Hub (17ef:721e):
> Both are based on the Realtek RTL8153B chip used to use the cdc_ether
> driver. However, using this driver, with the system suspended the device
> constantly sends pause-frames as soon as the receive buffer fills up.
> This causes issues with other devices, where some Ethernet switches stop
> forwarding packets altogether.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] : cdc_ether|r8152: ThinkPad Hybrid USB-C/A Dock quirk
    https://git.kernel.org/netdev/net-next/c/a07f23ad9baf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



