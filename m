Return-Path: <netdev+bounces-237065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B94EAC44476
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 18:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8560A4E1CAC
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9671E51D;
	Sun,  9 Nov 2025 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TscH2Fqm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F9D27E
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762709438; cv=none; b=WNEMHV59JJh9gBoMoSPN+2PQzwzHEeiJ7kE9GdAalUt2+M5hGrfYHANPQRxhFdHUz6fyh+R/DpJtS8vnJdyPLyBwV3SiBrAjLwa4Zy/m87FL4/C/4ZcGPZ4ztJDCaOwqj+eQFYLe16xcSnIqaxRm+pyHz3Am2kF2Qt1ZFsw+IzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762709438; c=relaxed/simple;
	bh=vzblFjlqTse1VAd/2rA+YNlcSZMK52Uc4zPSI8/ooCc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IOTiVwsn/pB5q0YZMb6aQHdDzLL1muyb/PoL9X4xIPm63CCQlozsCZTPBc2NfWhcanN5aWsJAZ+uH0Vr/ngKJJpZ27CZZ37Lse+h/W/8mv+T5mSJToxC/OsJ7kJx9Q4JkIZxWRmcyj/X5WdimWtDXEJLErIqg1GuA9A82Oitc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TscH2Fqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0664C19421;
	Sun,  9 Nov 2025 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762709438;
	bh=vzblFjlqTse1VAd/2rA+YNlcSZMK52Uc4zPSI8/ooCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TscH2FqmUGvzTdkJhoGU4Aq+OLKLZ9Gkp/FqUy+607gYuCBImQE80ttlaV597fxOl
	 +q24g/hXvHlOj8sy5+IFqJdLMAtPORiftdZnxBmmItKq1yvet2rAWgAAtf+DfhqLCJ
	 z3g6c0FsT1acxZvlrfoRVZ+KxZwoKu9qRTKNnB1h4wYekVvr6teQmekmvo9bV9+aay
	 4RRAsp18kUOhO48mLuuHoNs2GN03PlT3K++RN0zNxZI9s7YDL5bAOzA/XxSOKcbusT
	 7hb0FOK18Fg1S6vWD2GZrdizXKUbfo2IAbdCSYQ6GrwgYZiYfo0T94VfDaZzLAkVsX
	 +BYGnLQEZB+Cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BD83A40FE9;
	Sun,  9 Nov 2025 17:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] netshaper: ignore build result
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176270940927.1603013.17637402201787811179.git-patchwork-notify@kernel.org>
Date: Sun, 09 Nov 2025 17:30:09 +0000
References: <20251108182529.25592-1-stephen@networkplumber.org>
In-Reply-To: <20251108182529.25592-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat,  8 Nov 2025 10:25:20 -0800 you wrote:
> If netshaper is built locally, ignore the result.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  netshaper/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 netshaper/.gitignore

Here is the summary with links:
  - [iproute2] netshaper: ignore build result
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=2a82227f984b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



