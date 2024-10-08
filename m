Return-Path: <netdev+bounces-133219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A899555A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADFB1F23E5A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEC21E1328;
	Tue,  8 Oct 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8rm9rOO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1725B1E1325
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407430; cv=none; b=f1fLNz1YqO4DXJkqOd+kuSE03Wqpn8V2vC9GdjqAZX08Yyax+UcJ6P76rmTQLhTrrl/6hSCDyDLGlFnpIhMqwNuTNaNYcoLTs1jRgOym0VsPtk2YZiFfhN8jXkenecoKf/vkIFfhH6xu/uPNC0qEHACibP/CgnI/OUWOv9qRamU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407430; c=relaxed/simple;
	bh=0lA4LyUiGAHI+mRub12uWlmcovJoLpg7c74xi1aO+UU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bvbm8ceDcHMtR8ATKMzP/e1yw20MbwcthaKY1V2J5YzaXMBxCNagUtgEwIGlEZV2SkPqJPJHRI8oQ3OHcPxAoeD7MLpFoFbAOpnkeAvsv1Qb/ahkI7xbokEjXPlfmpkVZI0+k+q9QRxp90D85pZ2l0IlX10Yl2iYXhqCVX3DX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8rm9rOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E986C4CECF;
	Tue,  8 Oct 2024 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728407429;
	bh=0lA4LyUiGAHI+mRub12uWlmcovJoLpg7c74xi1aO+UU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n8rm9rOOrjVEPH8VrntxGrVwokut/OJdcwcrJWKhkiyLwFaXB7tBVzk/aRuU+grn1
	 9D5N08VuT45y9eUJKf5xatLWMd7PGr2uCZgJ6gk3nZJyXZYvVM8rCYvZlX/R3Ez6GI
	 GifyQuXAv5nuxpqmQCHkdFWDjgeFmTS2uSLM1mMO0AFVtVf7auY/Ztb8t8qaSr9kj7
	 2NR1XRGY0WuIWxxZOv0fDJhjpvu8iStcM2uLMk+YdgqUNNdyWuW7RwUxEChpoPQ0M9
	 zn/kdzXbuT/0/jru/XCQjMRUcrAumdGujPIlX7bc57zwVtXC8VGw1mWeV8iU1PB8bZ
	 psz89oXRusWbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADFE3810938;
	Tue,  8 Oct 2024 17:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen: refactor check validation for
 TypeBinary
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172840743373.616435.10599454404409127870.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 17:10:33 +0000
References: <20241007155311.1193382-1-kuba@kernel.org>
In-Reply-To: <20241007155311.1193382-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, antonio@openvpn.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Oct 2024 08:53:11 -0700 you wrote:
> We only support a single check at a time for TypeBinary.
> Refactor the code to cover 'exact-len' and make adding
> new checks easier.
> 
> Link: https://lore.kernel.org/20241004063855.1a693dd1@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen: refactor check validation for TypeBinary
    https://git.kernel.org/netdev/net-next/c/42b233108117

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



