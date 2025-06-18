Return-Path: <netdev+bounces-198857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52EAADE0C6
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 03:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB5E17A380
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453C31C54AA;
	Wed, 18 Jun 2025 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9fLrjK4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226001C1F22
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210847; cv=none; b=rSKMrPOaeMTWeWQMG+TQV2owiiWj8UdPZ6vNi2F/JVGOFqYmlEL3MPFZLdkzy4j3Z8jlyMqjL3d5pjnx2hqOQ4dzbs59loywLmnFXSrnEeYJSsQeI0j9tAFP86Dehyof1QkRMw3kIWRumh673xIbDtHljIRMP7J4eKtK462XNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210847; c=relaxed/simple;
	bh=shkgRdsq0oMcO63KauYOVczjozHUqma8bF+4DiAQ+64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BeaYW2GJrtUMRiDMkJz3N0GWGVn9ymU4Jf6e3KPoPkPjBUiRCUq3QNUy39aW2hOYYjP39gOh4QS5vpKMA9TtdlT94dtAlmyRiSlNaznPD4G6TE2RV+vOvpyGuZrAjASTlszxoJSd+gzcGIUGH2OYQHkOhcvLqhp55liYESkDskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9fLrjK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF9AC4CEF1;
	Wed, 18 Jun 2025 01:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750210846;
	bh=shkgRdsq0oMcO63KauYOVczjozHUqma8bF+4DiAQ+64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P9fLrjK4UXPfczqfWKL8iLQiKcCnN7zSc/cbDSTD5dvBpuvsMV3BIMrPlIwEHqSr1
	 aXNWJFe9FK3FnG53CQD6OFIAUjfj3B1u3iMvUGZldb9ecPUZi6UsXz+iFPM4uLL2eG
	 rRabqaVxwBLIu6GXLzDXF9MMFww5SdIDZ+HOkDL7PDSy8hymymi9BsqqUeAddzVgu4
	 ZehoRHmsQPCNpjdP4/OIWZ6d/yaermRZNs/ZAUYcrMYt5bhu1j6eC84kh2uYLw2Sd1
	 Aet3SjbHqw1DjZHXIPMNyTbv8/Ld1Zub1QJ24J0bi5dIQHW7w5rRkLK8xj1qtAOyMn
	 XQcFf/e3davDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B8338111DD;
	Wed, 18 Jun 2025 01:41:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] Misc vlan cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175021087524.3761578.17869990457841609350.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 01:41:15 +0000
References: <20250616132626.1749331-1-gal@nvidia.com>
In-Reply-To: <20250616132626.1749331-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 16:26:23 +0300 you wrote:
> This patch series addresses compilation issues with objtool when VLAN
> support is disabled (CONFIG_VLAN_8021Q=n) and makes related improvements
> to the VLAN infrastructure.
> 
> When CONFIG_VLAN_8021Q=n, CONFIG_OBJTOOL=y, and CONFIG_OBJTOOL_WERROR=y,
> the following compilation error occurs:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: vlan: Make is_vlan_dev() a stub when VLAN is not configured
    https://git.kernel.org/netdev/net-next/c/2de1ba0887e5
  - [net-next,v2,2/3] net: vlan: Replace BUG() with WARN_ON_ONCE() in vlan_dev_* stubs
    https://git.kernel.org/netdev/net-next/c/60a8b1a5d082
  - [net-next,v2,3/3] net: vlan: Use IS_ENABLED() helper for CONFIG_VLAN_8021Q guard
    https://git.kernel.org/netdev/net-next/c/9c5f5a5bf0da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



