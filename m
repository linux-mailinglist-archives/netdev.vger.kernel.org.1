Return-Path: <netdev+bounces-223151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63C9B580D7
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7134C5C26
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662EF22173A;
	Mon, 15 Sep 2025 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+CjGK2Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329CB21FF44;
	Mon, 15 Sep 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950212; cv=none; b=fcI+mmAGToZLTkqROhIweIRT7Mzlyz/6/4LWig1fRXW9EOqrxTNrntB0lNR8U3bY5fl8EXD7lWzn7E9I8LSPy3t8M4i6fvl+y4Qjj6nppB4G0r5ffHUfSdSvJawN0/kCvm2tGKsWysINomT7TSa/bBqavB+hqXicpyih4ajSKEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950212; c=relaxed/simple;
	bh=8gErwK9vl376zHParQc/U8TQQZ0l10guNX3poZqd8X0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M3/8kjk1qPOdVd9vK/7sM1YZlu5KxW5nxzNtAsl38REZvWGgMHTaR5G6dnJ+Y0sxlukmc5ow33jy4i9mw2JU2Bs3zAedIGY4YHcCXQVzJoGC8zgobjhkTXcqOHo+PNOdVYtXYEkuwfhHWtxeDmK2gvW7oUTS2lh+mu43ZRuTtqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+CjGK2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87C4C4CEF1;
	Mon, 15 Sep 2025 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757950211;
	bh=8gErwK9vl376zHParQc/U8TQQZ0l10guNX3poZqd8X0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l+CjGK2QimLHetqwHtfS3lquxFuLIAEohtmDOP9/470G9Z9iFcKMf7rJMV1aY4fM+
	 sb86GhqmdD3pvoy5pZ6F2eKc9+oGcHttzgBbOkUwNqfTK58e80KKNoPHecFfNHiS43
	 9l6s/zGEDQqW7U7dRajW6jL9WBLj01fez0RNOhvlveZC203JPms0a7+KnSevL/FtKm
	 x5QNQOXmc00Vty4YWhB+oNqRH8NcsGv4B3lYqGh6d0qzPBi3ocvFXA7AgYsZgI+w3j
	 wCPOhPrfU9B9cLKAiv0YmeCMTolm8jsMjWNaXQFi6FFVm3XwPDJm2IBXmmmvj6SfpM
	 2cxVv8cSgNcuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C4F39D0C18;
	Mon, 15 Sep 2025 15:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/5] dpll: zl3073x: Add support for devlink
 flash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175795021328.29952.16558907395592843610.git-patchwork-notify@kernel.org>
Date: Mon, 15 Sep 2025 15:30:13 +0000
References: <20250909091532.11790-1-ivecera@redhat.com>
In-Reply-To: <20250909091532.11790-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, Prathosh.Satish@microchip.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mschmidt@redhat.com, poros@redhat.com,
 przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Sep 2025 11:15:27 +0200 you wrote:
> Add functionality for accessing device hardware registers, loading
> firmware bundles, and accessing the device's internal flash memory,
> and use it to implement the devlink flash functionality.
> 
> Patch breakdown:
> Patch1: helpers to access hardware registers
> Patch2: low level functions to access flash memory
> Patch3: support to load firmware bundles
> Patch4: refactoring device initialization and helper functions
>         for stopping and resuming device normal operation
> Patch5: devlink .flash_update callback implementation
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/5] dpll: zl3073x: Add functions to access hardware registers
    https://git.kernel.org/netdev/net-next/c/259ede9da4ec
  - [net-next,v6,2/5] dpll: zl3073x: Add low-level flash functions
    https://git.kernel.org/netdev/net-next/c/3639bd087679
  - [net-next,v6,3/5] dpll: zl3073x: Add firmware loading functionality
    https://git.kernel.org/netdev/net-next/c/ca017409da69
  - [net-next,v6,4/5] dpll: zl3073x: Refactor DPLL initialization
    https://git.kernel.org/netdev/net-next/c/ebb1031c5137
  - [net-next,v6,5/5] dpll: zl3073x: Implement devlink flash callback
    https://git.kernel.org/netdev/net-next/c/a1e891fe4ae8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



