Return-Path: <netdev+bounces-214175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C98A5B286B2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 21:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FE0B0636B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363712C0F77;
	Fri, 15 Aug 2025 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+qhkSiE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEFA2C0F66
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287406; cv=none; b=SY1u/KdEn697iBBjg6qtemR6GQUYZ+4ew1xAE1A+eFPFOHIhg5KWe+5oA3rtLUt9xm4BzbBmeHfTKjlq7pGKU6C9aJTx8yJfCeVhEPYRdg3OOA3WH430nQcX1/tnxr2KmFd/8r1cwE41A69Z11c9C2OBPUKdRhJm/qxM9UWISfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287406; c=relaxed/simple;
	bh=xkCxhK9vFWYqwc4geX9ekP7gMh3dl2bc19LP3doowWA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f2+LIuTrBm0/bGDggykYKPJYp6P3DirFud75+Zber5PtNt389UimMbEOxM5TdTU8I+HTqRfQATxffJfHHWjxZixuhC+aYIZ5F5cwblwE8fBYiuwyIFIAn+bJFeRufR2MqUh9WWq+hIX1B1WaYOepflEQn5zPRkLXp8UaFnX2qJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+qhkSiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4435C4CEEB;
	Fri, 15 Aug 2025 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755287405;
	bh=xkCxhK9vFWYqwc4geX9ekP7gMh3dl2bc19LP3doowWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q+qhkSiEhO1TqkUSX2NRNHRx6cywWXTVZpmvdf9Eh23KHp15BGI8Y7Slvop0SZ6In
	 Jr9tUA2QqeABzo06xtImzX92oVDenSDKgJFPrKorMC9mdKIs8gchZpoaYZNTrdRoPZ
	 2aGgOWHixdP6xg3Omk2A9QEVQtOHWHQw0rh2akGbQ41n31XCB9geKER8mHE40I7Nc+
	 GXsmDXE9Kerghu9o87GJ/IllbM5RPAe3UNRGtg7h3PyyAyfrMRzapbcdMBKpPfbw85
	 SQ0R6euQi7CLYOeuk+l2cuN9mUWrj+8HSsQ0FBmP7XlEZKn/DwKUE2MNavZRqiD3UC
	 t60FmXRZn9xIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E5B39D0C3D;
	Fri, 15 Aug 2025 19:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: phy: fixed: remove usage of a faux
 device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175528741674.1253623.1950644109913722977.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 19:50:16 +0000
References: <e9426bb9-f228-4b99-bc09-a80a958b5a93@gmail.com>
In-Reply-To: <e9426bb9-f228-4b99-bc09-a80a958b5a93@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 21:18:03 +0200 you wrote:
> A struct mii_bus doesn't need a parent, so we can simplify the code and
> remove using a faux device. Only difference is the following in sysfs
> under /sys/class/mdio_bus:
> 
> old: fixed-0 -> '../../devices/faux/Fixed MDIO bus/mdio_bus/fixed-0'
> new: fixed-0 -> ../../devices/virtual/mdio_bus/fixed-0
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: phy: fixed: remove usage of a faux device
    https://git.kernel.org/netdev/net-next/c/d0f110773d77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



