Return-Path: <netdev+bounces-166127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3017A34B2A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A866E3BE283
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0AB245AE4;
	Thu, 13 Feb 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNZI/AEc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE03245AE0
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465411; cv=none; b=TKIoro2J6ceJ0Ol5o1aONRUUKK18+7giMNoDjPvKoXX0Q4ZUnv5p0aEgdJkSrsH6g0cgpKyCt6I20I8ZYzxvO9pCPUJRNrd6Q8MtCQKHvZVE+vMkNXB5tWD2/LQE6aU8jfayfnEJ85axqG508xutcnTqpS4CA7dGAvlfqv2mR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465411; c=relaxed/simple;
	bh=Q8adrryL8903jePB6A+ntgGeXDkRmPX4XNnBmZ/aqkc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qjnZkGHLVA/ICeB/TrgzUHO8wsSvA0nkCAqtagPUkn+a2xNAsDiNfdZRH3EVpgpnHKrV9jggRsFXMFhAyWS0IfnKL+roCrp5OwKB9B3Q4MgSSQx/9JFuwXgSPccxJoo+woEKyFaC8TS5EuzFv5xfQfdK1g0EYsFdDD+tFfwAAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNZI/AEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B88C4CED1;
	Thu, 13 Feb 2025 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739465411;
	bh=Q8adrryL8903jePB6A+ntgGeXDkRmPX4XNnBmZ/aqkc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BNZI/AEc6JH1+OAOppgVzBI2CFQvdPgIPcTm6QXaG6HW56NfXDZ8LKNtjun0LsOno
	 aPGZ/kigdDR1Ghfg3Mpzu8vYUrV7S9aUJmKgOvm4flv2esMtWwdq+HSktq84IhCVdf
	 zDWeL7nwFeheNJMktqOOOEf9JZtrZOdP78KTvF/bN8H2dWSkLKMmLnd2Ejf3WqSQ8u
	 IoEoLVTmrhPW3xQFN+P50tiVSwGlcFpWSOy7MKMfmersKEc/aKwrBM76Tb8LY6uQfp
	 I5eVax4GQ3GvG9JKOIH//LFHubv6WK7eT0jen7rs6pTtS2YlsbFmKGFfR4+6VWFJjG
	 I4XOaGP/mTGuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34058380CEEF;
	Thu, 13 Feb 2025 16:50:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: add support for Intel Killer E5000
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173946544100.1295234.2384724543448892118.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 16:50:41 +0000
References: <9db73e9b-e2e8-45de-97a5-041c5f71d774@gmail.com>
In-Reply-To: <9db73e9b-e2e8-45de-97a5-041c5f71d774@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Feb 2025 08:03:56 +0100 you wrote:
> This adds support for the Intel Killer E5000 which seems to be a
> rebranded RTL8126. Copied from r8126 vendor driver.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] r8169: add support for Intel Killer E5000
    https://git.kernel.org/netdev/net-next/c/d30460f42675

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



