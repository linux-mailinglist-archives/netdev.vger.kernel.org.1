Return-Path: <netdev+bounces-242124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5DC8C88B
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 02:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 461F534A689
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113CF23E356;
	Thu, 27 Nov 2025 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq4R4StW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16B021771B
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206466; cv=none; b=j5S9/c4cLsEm1glpnccwtz7yvz1/DciwmduiHFI60jm+kDcYSiF6W1twRwGvXown8YzKTRDlkW0bC3hSE68RSWSGwJwLmCA6MBBp4T4+NImpnaqQxNmkOe4jNwmQPafphlA2KjSft+//hLCvsEEtSxY96zr8mf6Vta+zbSQtybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206466; c=relaxed/simple;
	bh=wRx0YHKOEsShMXLPHmaFCTbSyTvtntHpYdAEC7aYwU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r4vSZK6UZhSbVXFdA+8Ylgcrn74LPI+Gsb13tRtsqn759baXS+PdxiVDe+ZbCkXkK5acaXoiVTknBPuLhu0AgaWmb3R8MDDgYeG5X2CZ5Ts1ZiMM0K+DVJmR4xXxCJK9vhpC/qT+6/HKf8UlJrQ9POzFppoQVM2SGxvbefsyuzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq4R4StW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C99C4CEF8;
	Thu, 27 Nov 2025 01:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764206465;
	bh=wRx0YHKOEsShMXLPHmaFCTbSyTvtntHpYdAEC7aYwU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tq4R4StWobhXcgoSu7xe70SXQH2kRZeyVHGLw3fvJXuPJIioI82ov0oQXvi1rF0At
	 CbPa2zdpyoftR1J7bn2lvYiQDyfQODDosU/Fi/MYzxAWTtucg/UK/JhlMUM7uzfTdv
	 mTUjU88NH2HL990jBSHQA7/uwLlwn+WDYlglqE7sJGyu91k18h887IFmCSjD136th9
	 lMEq3nwMP7lgOa6VqAqjrAlDn1DNCtpzkVhtRuqbHqN1DbFOice3geiVBHRa+SksFB
	 Lw+fh2PpD8iW3Ndvf5fLftA8mefJZN5je/IlDpsVNYzrBrwV3wj+RxhFpoSUNys1KU
	 +FD1kTRSfG89w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE55380CEF8;
	Thu, 27 Nov 2025 01:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: specs: add big-endian byte-order for
 u32
 IPv4 addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176420642725.1910295.9477606364656602086.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 01:20:27 +0000
References: <20251125112048.37631-1-liuhangbin@gmail.com>
In-Reply-To: <20251125112048.37631-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, matttbe@kernel.org, ast@fiberby.net, sdf@fomichev.me,
 jacob.e.keller@intel.com, yuyanghuang@google.com, daniel@iogearbox.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Nov 2025 11:20:48 +0000 you wrote:
> The fix commit converted several IPv4 address attributes from binary
> to u32, but forgot to specify byte-order: big-endian. Without this,
> YNL tools display IPv4 addresses incorrectly due to host-endian
> interpretation.
> 
> Add the missing byte-order: big-endian to all affected u32 IPv4
> address fields to ensure correct parsing and display.
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: specs: add big-endian byte-order for u32 IPv4 addresses
    https://git.kernel.org/netdev/net-next/c/651765e8d527

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



