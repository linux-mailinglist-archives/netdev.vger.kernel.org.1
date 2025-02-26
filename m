Return-Path: <netdev+bounces-169692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B30A453E8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F771896153
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAAA25742D;
	Wed, 26 Feb 2025 03:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hODN7Kut"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE152253B65
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 03:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740540012; cv=none; b=UF/GC8vhjQPgrxXAsYx7OaZsUaMVDTWAkJSyMDM4TI18LNnhxSokrMfJbiK4Bql54yomFZFztOvY1qxS7YVWrLQBkcJAwm91wAK0j8XLZQFWihSx1tu6cGsOFq0Dn80/4eLG47t57WvPxENkThNQV6YPL01KxufQnesk7qmKMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740540012; c=relaxed/simple;
	bh=YPRm5ccsdZ/XIZ/mo2ZZD8stDHATpWInd0O/EI6DEKs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dz3FFtIcM266cv1i0RV8hEsR61ruj4hI4czUcZGEu/nFHNDKR6rOEa1aFiBsS6825fuhsRLXSnbPCs0pgRRAwXacJcDPLQmmx06I7jbbxAmltKICcnnDVJ8hQBi9mCwGqo3PPgcYKvxkxaUjq60kaZUPvJsufXO3r7yitmokUUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hODN7Kut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75940C4CEE4;
	Wed, 26 Feb 2025 03:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740540011;
	bh=YPRm5ccsdZ/XIZ/mo2ZZD8stDHATpWInd0O/EI6DEKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hODN7Kut//Idh4G5pXFAo8x8wqAnYEWHugqFIBhxO62o5jamL/AkVQTr4quLKLXiK
	 sJD0Mv9Q4IQTY6IB4W9GLzphFLkUi6bm4fpFZgvd/OkfBuVsYk0YvSXcUxTCEKiIN6
	 b1GTsWQBOq0NNmSr7qbf4PrJr12g6G3v1GR2ZVhGJhK/sbDy8n59puW0UPo/R3eO1e
	 B5GSRILxtzvSTxMU2EVDZLcnswpQtyeLOIVaZum24a/qgGKICVjYuYMvo+VwSHcPRT
	 jhc4dA3vsxcAJRPkp3HHMapoXgRyyMaJqnKqRQ3UarmeB4W4nRsq0cedscpmBehHk0
	 4lWYfmIO/ZR1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72B66380CFDD;
	Wed, 26 Feb 2025 03:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/1] enic: add dependency on Page Pool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174054004298.219541.1027151097527814049.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 03:20:42 +0000
References: <20250224234350.23157-1-johndale@cisco.com>
In-Reply-To: <20250224234350.23157-1-johndale@cisco.com>
To: John Daley <johndale@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 15:43:49 -0800 you wrote:
> Driver was not configured to select page_pool, causing a compile error
> if page pool module was not already selected.
> 
> Signed-off-by: John Daley <johndale@cisco.com>
> 
> John Daley (1):
>   enic: Add dependency on Page Pool
> 
> [...]

Here is the summary with links:
  - [net-next,1/1] enic: add dependency on Page Pool
    https://git.kernel.org/netdev/net-next/c/91c8d8e4b7a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



