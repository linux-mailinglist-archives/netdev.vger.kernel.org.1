Return-Path: <netdev+bounces-143888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27FA9C4A8B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05CF8B2C7AC
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B7DC8DF;
	Tue, 12 Nov 2024 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+OOwH4K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21A75695
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370220; cv=none; b=tYIv3WDtHMU2Q2x/xlbsCJ4GIHFF2qUTftwtN1CtuziKjXxnazd8NTjmFTJ9SjnONX5x0LJmM1hD1IqJpAE13vnE3tE2qaYUIqyLNWOKtUluHcEUMzRDR2J5ibF2iYq3+GF94vWIKMIb9XZJdLVRC1kMT8ELFq+lKo/7kcQfWio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370220; c=relaxed/simple;
	bh=7D9fhjTvoxtbfdbYG/+qUN2UEZ9kHamxETgQaMnAKl0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WwAm17LHIjGDljr0aGbsEk9+b1fqQzUTww4g4IagkDDr7qwNt4UiKr8EhZKmNKxAryjKykIz1TaNKPPdWqz7+CGnzhrl9lE5H8g31iEGBvO9wUnrMK4VTr7pMxsdbLsaLqEju/fe+kUwgByR51hOCWwcC29bozI+1m0enqfcoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+OOwH4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D57C4CECF;
	Tue, 12 Nov 2024 00:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731370220;
	bh=7D9fhjTvoxtbfdbYG/+qUN2UEZ9kHamxETgQaMnAKl0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T+OOwH4KqZM0vqSxENQYaLQPgvVWidb0jZkTRTpgYFPxAdPpSeB7Ev9/1hBoMwJfy
	 HocsYqBMlmNjxnoK4CYZw9WkHSliImjJSycHeQTZgQxG1yGrTE5JJq/1OcrI8YZ1PW
	 gJQ/oBsz/KRDDTeFTnbRHR4rY+A+aLHgflu9IgxpA6YOt+kPuzDa7fSIcXAgqPXlmc
	 giMdinNTkZCvt8HJkslqqAe5dMrSCuBOFuHuCS8lj+vSXPKlOl5rChnRVrMRlWAgNM
	 GOmWSkF74RriA6oE+bp2V3Wgo8kaU99gNsn2mTQ5n5hfdg38bc9XTImexLu8k/BMIA
	 pgWyBqIY0EfnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE443809A80;
	Tue, 12 Nov 2024 00:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: use irq_update_affinity_hint()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173137023049.20619.4533569885951072685.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 00:10:30 +0000
References: <20241106180811.385175-1-mheib@redhat.com>
In-Reply-To: <20241106180811.385175-1-mheib@redhat.com>
To: Mohammad Heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Nov 2024 20:08:11 +0200 you wrote:
> irq_set_affinity_hint() is deprecated, Use irq_update_affinity_hint()
> instead. This removes the side-effect of actually applying the affinity.
> 
> The driver does not really need to worry about spreading its IRQs across
> CPUs. The core code already takes care of that. when the driver applies the
> affinities by itself, it breaks the users' expectations:
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: use irq_update_affinity_hint()
    https://git.kernel.org/netdev/net-next/c/fcf42409c6e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



