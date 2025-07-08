Return-Path: <netdev+bounces-205043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7200EAFCF72
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4042E7B54AD
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C80C2E092F;
	Tue,  8 Jul 2025 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWgCcGxa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252901D5150;
	Tue,  8 Jul 2025 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989191; cv=none; b=TluuAre7N2h2aYhIpZtOHC8oMP9mgDvHlj7ys55XVq7aTWjE83c9xN/GMGlPDIbyIr44tkk8tcPWkJfZOMaxC+WtXD21+8Tavh4sHJfXxGbJFWVDfzJdl9qRYNl6lleRqaNnsswArTdS9FqITZZQ6es86aqeYLmMEWp2mTmtMqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989191; c=relaxed/simple;
	bh=6a64cyDgTkEAXdeAVE2ZqtPeIjHWMsvkoEkspXSXwXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LYAzuEW+4XEJjOs5ohqMhNGCfc6XSLXh1Zf4Jumf3TMNeTMX3ZvEUGVdNOruNyBQOSS7WIZH8o8IU1nGd5qsK5eoI8u977XCfyomN69yxJrsiBmEXkeh7U4WvKFcackwjN7pjBpRIEaFE7DJ5iA7ycHpZntc58yr2gLq+Citg7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWgCcGxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810D4C4CEF0;
	Tue,  8 Jul 2025 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751989190;
	bh=6a64cyDgTkEAXdeAVE2ZqtPeIjHWMsvkoEkspXSXwXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZWgCcGxadlruCnTk5/zGHnJ2Gx4a7IZkFoi8w+nVew/c3NSU/glIJm2iJZLr5X7qV
	 dsDEMmExqm92uBaYrnQoBbQSOhbOnKcj0hDP99ImV50K69RfJXtHi8Z46LjuS76O7h
	 O8YC9LOypQxr7GWAT947nalfelgWFW0rK4RCfb9ct/1uR9OqG+8lNTtWkiJN7yUqGE
	 ApmsPD0fA/MgPsgbk5KaIFMUv1qUKlQRTI4fwh3+Fw8gkqwWwrt7YcoLWkvSUg8V5c
	 5kgq/WRUyFrq91Zx/9IEoKir1U1CLk17R91aTGj8zED1HC4rs4/P/qfnrdHj3KNhVB
	 M+tlMb5QvK1Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ED4380DBEE;
	Tue,  8 Jul 2025 15:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] atm: lanai: fix "take a while" typo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175198921325.4109948.5911889991821254848.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 15:40:13 +0000
References: 
 <mn5rh6i773csmcrpfcr6bogvv2auypz2jwjn6dap2rxousxnw5@tarta.nabijaczleweli.xyz>
In-Reply-To: 
 <mn5rh6i773csmcrpfcr6bogvv2auypz2jwjn6dap2rxousxnw5@tarta.nabijaczleweli.xyz>
To: =?utf-8?q?Ahelenia_Ziemia=C5=84ska_=3Cnabijaczleweli=40nabijaczleweli=2Exyz?=@codeaurora.org,
	=?utf-8?q?=3E?=@codeaurora.org
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Jul 2025 20:21:16 +0200 you wrote:
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---
> v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnrufop6tch@tarta.nabijaczleweli.xyz/t/#u
> 
>  drivers/atm/lanai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v2] atm: lanai: fix "take a while" typo
    https://git.kernel.org/netdev/net-next/c/60687c2c5c3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



