Return-Path: <netdev+bounces-196766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 589FCAD64C3
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C9C18830A3
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCB82AD02;
	Thu, 12 Jun 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kz2ko++8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE55258
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749689399; cv=none; b=qa9nEyFiwVoYmAw5G/wUJxKZuSjbYCjnss2+Ta8HnB6Yud7ArKdvMTMhntd0DykyDcLM7xnGeaF0eIdWaqPNhijaBYbBOtf/10M0/AOQZAzs6HmDsIb9we4KJUBSpi6NcGsEH22l9JUehmhcxaSJnUkmP2HL1aClkjdfu+ZBBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749689399; c=relaxed/simple;
	bh=VMQbleK+QH86N2o3nZYuYur66iE6goe2YWh6U5lZ6X0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t9+LEku0+pDXibsBzhlxZwoh5+OrN8CZ/5BfwDorPPBtL8YOm9OaqkskHrkDjZPHmsD5SlgQI2VAao7RVsg3JeMvewfx2kXuQK3AuE2j+D+jmU6XLIEQo/CLPFUZuouzDcwXxPeyidPA1J/LFFVUd5zA6feG9N+XxbEosLFg2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kz2ko++8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696FCC4CEE3;
	Thu, 12 Jun 2025 00:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749689398;
	bh=VMQbleK+QH86N2o3nZYuYur66iE6goe2YWh6U5lZ6X0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kz2ko++8kyasg7UOXPb+n4Phouyk/GCMmOpHb00r1mV0yQOtz4SHF+nq/lBk8r3O1
	 MH9w1Gg7zA1Jnlx0buDt80hWaBwZqxd3AF121rQ3Cn3T2lMzmbnZV/NJBAdMGAZR0k
	 vM5ZtkFfeQEfnqwSO0qm+CBIyMNi/gQztV8QR8swKwJ3LG5kg5fcBhTl8cm0/n6Ysl
	 9x3JqAdXO25dntwcq+bm24aCMw4mE2V0DKCn/pqpBRiNxsNKFpU5VAeJydVapKJsNA
	 vWEJ1xpAozJPASx7zzi+O5fyDsSZtHIiTwH2+tpgKWXkwZubHxhoOFDnhzoPYAq4PJ
	 rmPa9J0YJDdVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE0D3822D1A;
	Thu, 12 Jun 2025 00:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] MAINTAINERS: Update Kuniyuki Iwashima's email
 address.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174968942850.3552664.10610156407502774597.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 00:50:28 +0000
References: <20250610235734.88540-1-kuniyu@google.com>
In-Reply-To: <20250610235734.88540-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 23:56:58 +0000 you wrote:
> I left Amazon and joined Google, so let's map the email
> addresses accordingly.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  .mailmap    | 3 +++
>  MAINTAINERS | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [v1,net] MAINTAINERS: Update Kuniyuki Iwashima's email address.
    https://git.kernel.org/netdev/net/c/27cea0e419d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



