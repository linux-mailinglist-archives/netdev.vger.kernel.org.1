Return-Path: <netdev+bounces-176242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 132FAA6977A
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8029E174A46
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF281DE3A9;
	Wed, 19 Mar 2025 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6ATXVzn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CF194A44
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407798; cv=none; b=LRJw0ScWE53C19DxpMzfzaNkMeQO4iGPI6NTEYgvMcEX6KR2C4O9P0S84T6QEgBix0RKTweToKNHHDoeqyNf5G5RjR2blz9RcajcQ24AMLzB2XJFctngqGjFjqY0Gvs8tdstJYVrB+mFRQz4yBliWsM1LgZaJlV0TYFqy6Vizu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407798; c=relaxed/simple;
	bh=H+KpTHxhvv8QV64IBfDI0XnrKtV8qdqc0An26cMYSCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pfcJFNhq0EvqMUuWDlahI+NeQ9M1VBUfjd08cooIL5m/tQMEdj71gOMNMYY9K5oQy8RDVNKPSm5602YxG8v/rSPRbOA7YHOK7zyxJhFgfVh54x5BjaAUUkX/Sn2N76pzAQaRl0d7nxk5B6lIwxVCKDkj5I9eFCQX7LvnSyVpBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6ATXVzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CD5C4CEE4;
	Wed, 19 Mar 2025 18:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742407797;
	bh=H+KpTHxhvv8QV64IBfDI0XnrKtV8qdqc0An26cMYSCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p6ATXVzngJqqdQHrsdyQba2Ue3VQ8YHL6UDZ/1J+3KgNnuNjaxwpszIXglxl/TQsV
	 9++tTk1Yek/uB6PreWDYmlf0Quva3C0zJz9kYxx9qU/TehD4uxwoBwBRcui0yvSmx+
	 wdA5ClTaO80+lpvr1gasLTaf8J/DoXCP8Pgtnwh8qk7C8RTps9JWDfiS1nE6OWF5Ro
	 cI7ibETQTCsm/cdD7uIFBPerupODH6nso1kLPx5ZmtWs6IuY/HsxySG9EgjalytkE0
	 OWFkt+jU98bEc7PmCuprX8nDRVAYeUi6UHyrYdOPfgsVk4BJKl1xWC09o7O6HBniU0
	 X9Q3LlZ8NWLsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7547E380CFFE;
	Wed, 19 Mar 2025 18:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: switch away from deprecated pcim_iomap_table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174240783327.1140209.13355697057442913577.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 18:10:33 +0000
References: <a36b4cf3-c792-40fa-8164-5dc9d5f14dd0@gmail.com>
In-Reply-To: <a36b4cf3-c792-40fa-8164-5dc9d5f14dd0@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 20:21:42 +0100 you wrote:
> Avoid using deprecated pcim_iomap_table by switching to
> pcim_iomap_region.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] r8169: switch away from deprecated pcim_iomap_table
    https://git.kernel.org/netdev/net-next/c/34e5ededf4b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



