Return-Path: <netdev+bounces-239785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFB1C6C6AD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 343B24E9153
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618CB29AB07;
	Wed, 19 Nov 2025 02:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLEFlijJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D029A32D
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520051; cv=none; b=DhVHEdZlRftR7tQK9c5+wy9hhwmjE9HJkxZZgy4X2Or/fpmKkJ0nVb44C+gpze4wZl42RqP+1UV4o4NOSGxJBzauhDxP582PreUP9guCuxRt8BtPlhiT0dgIITSLkv/+8I/FVYomtxH2N9/Y4XSr9oumPg6PlKohsOg01Zg84JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520051; c=relaxed/simple;
	bh=CSbQF8LnYndTY4fknVsJdn434WZQpDGl/ZAueipIMVA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uapFwIOfVRXlGcXkc008XZR0AUFMsJR1/9fmatU2B9C9+WeOwj5T5UHgqDWDLvfR6LzAyGAfi0a/3RT7FJokVFDbGyyVGfaH11Jg2wnmdVz1pU1Pvd+ypElw0v029LosV7c2p2cJWsdoPFtQp6h8cttcHMjgtpqKVIax35WKYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLEFlijJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F63AC2BCB0;
	Wed, 19 Nov 2025 02:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763520050;
	bh=CSbQF8LnYndTY4fknVsJdn434WZQpDGl/ZAueipIMVA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tLEFlijJV5hFxakJpZnG3csp7JHcpnX4tGdHlR8mfIv0hQtDbh+wu6j6rlGbQLthj
	 u5IMWMqkhlLuXzQ3qIwyhE9H0cGlVNAkiz80tilcBPh34C7+QuBS2J4hmaBh+Zo+yx
	 6OBPb7HUogtRh3Yye4cHWVpwxjq0hkajlSQ1N8maN6jZFIl4FYostkosJLqr5jaxyU
	 fXUZNc/mdJFE1CboSwLCLaCekrqhB1bhoxGiz2gTBfB2x1EvH+zLXEq6SAPsa4lojw
	 sLGVSA3Z/VFtL1FyLMtCi3MwevJ7I1vM8oZGMPtg34S4I13Nub1yUBdI9dH2WBsYGC
	 s8ESNN+r3m8ZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B61380A94B;
	Wed, 19 Nov 2025 02:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: ks8995: Fix incorrect OF match table
 name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176352001574.191414.2014923310708500357.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 02:40:15 +0000
References: <20251117095356.2099772-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251117095356.2099772-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: linus.walleij@linaro.org, andrew@lunn.ch, olteanv@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Nov 2025 01:53:50 -0800 you wrote:
> The driver declares an OF match table named ks8895_spi_of_match, even
> though it describes compatible strings for the KS8995 and related Micrel
> switches. This is a leftover typo, the correct name should match the
> chip family handled by this driver ks8995, and also match the variable
> used in spi_driver.of_match_table.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: ks8995: Fix incorrect OF match table name
    https://git.kernel.org/netdev/net-next/c/eb74ae2f87d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



