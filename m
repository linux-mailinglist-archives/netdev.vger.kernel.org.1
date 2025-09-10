Return-Path: <netdev+bounces-221493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46986B50A42
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 03:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F9C188E207
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBA61F5847;
	Wed, 10 Sep 2025 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqTpSUiO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FC11F5617;
	Wed, 10 Sep 2025 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757467816; cv=none; b=KqktmlIWcRADEYlm50v0F+VPKo7LO3J4WU33gHy6oc1A8bPkN3JwjgjIWgOOoGmfVkbc/9wZ3xVdNPH2tHScQsrqFFIocCINCD1c+Q/5Amleb7QrYCx6diT2kCKmvYvgKzcZWBxz+/Mm2zcUiJwHCTgAoUdRGzQzcJl939FEy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757467816; c=relaxed/simple;
	bh=n7RRcM2VmdxAHDAqCP2wBOJtykDyB6WRXj2rYpHA37g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y/5FTmXcYsv31sIMG7oMkUwq9AM2bZgRFwLzDqQ3tBaWas3aqze3GRod3ozBy+j9JJVwk8v0w0lZYLbskwmXtiwPSe17vewy+5j3aO+VTEAW+jytnbQF5MRzhT5+DbDyTh0VqQ4mhtYYjfM9/fRgT06VGaEgEvK/IPGQm1aJlz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqTpSUiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2292C4CEF8;
	Wed, 10 Sep 2025 01:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757467814;
	bh=n7RRcM2VmdxAHDAqCP2wBOJtykDyB6WRXj2rYpHA37g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sqTpSUiOxUHy5n8InPp5zSQp1YzPHXj++ljC1mEw4+cuerVQkvzd/LO3kZoEBKDEB
	 9LC1ZPczZH6Va8Jnl3VnTRG4DIRV4DT1NUaZgbyQ8GRVdN8cShRXlBcuY6cstnQo6u
	 Ze5v62xPT+OkMU+zOK2tyFHNfIrHk+8+T00xmtD2nDZfzVzBaD+DvzFQdjk/UNfmvI
	 yalzrdi+K0Oxm4sHZm3DrzSrZvaickG0Abz8f/SJOGYv4CoYqKk8NK6MHitoAiHwrv
	 uulMZu3f+a1sLGA2qnxEf2FEMPKqtf+z8RTaIvmf2Imz1XUYYsdYBFMpDW6rSmE3Ay
	 mMNKVbalfUxyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBDB3383BF69;
	Wed, 10 Sep 2025 01:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: aquantia: delete
 aqr_firmware_read_fingerprint() prototype
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175746781774.866782.16029878229611252912.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 01:30:17 +0000
References: <20250908134313.315406-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250908134313.315406-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Sep 2025 16:43:13 +0300 you wrote:
> This is a development artifact of commit a76f26f7a81e ("net: phy:
> aquantia: support phy-mode = "10g-qxgmii" on NXP SPF-30841 (AQR412C)").
> This function name isn't used. Instead we have aqr_build_fingerprint()
> in aquantia_main.c.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: aquantia: delete aqr_firmware_read_fingerprint() prototype
    https://git.kernel.org/netdev/net-next/c/051b62b71e2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



