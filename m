Return-Path: <netdev+bounces-126130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA0696FEDF
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72081F23712
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2CCDDA1;
	Sat,  7 Sep 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubTaQwh+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04756D29E;
	Sat,  7 Sep 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725671431; cv=none; b=kcFUg50lpJws5rcQyu1wfuyV4aCTjvvzGGP/fijc5RKHRuwDlWzEIiQiBPx/Lu08PaeJm2L1DgVoVDE+sWb1mtINy13l6CDM9d7dfy3jyXgVUe0/5ISCo251HylXilIkilfP4gHUWejcSUFA6O/ESzdIb5zIuUQlk+RdgtrjrP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725671431; c=relaxed/simple;
	bh=a8x3c9mUegUKqGhIIdEF1wT6HAlHDq4UjYZADbmX+Bc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TQTbAzYoKihRG3K9Hx1y4hzbx7wKMAKeGGl2zuKfxuyV0PpUVatMTANfuNf5qpnHEBY9ON8NVBZfUv+S70vZSe5EUDIb0tJTVtnnvIpPWN8/ZVfKoJSUdFYNhabGUTNxAnTxh0YnEP2U4GolbQp4Tnh8KA2rw9IXNiCvg6VJlAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubTaQwh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9542C4CEC4;
	Sat,  7 Sep 2024 01:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725671430;
	bh=a8x3c9mUegUKqGhIIdEF1wT6HAlHDq4UjYZADbmX+Bc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ubTaQwh+IgmGT1rkJqeGX4sAs2/5080zw1OpnRf2CC7G+og+N5sj53tPzS2z4hl2i
	 4m0110IcNnhGLOKkigaLUbM1C7JG9ihSYJTQQYcXtkZgp/KaBPh2Ub3K1fuaM+E9aD
	 qe84ILniq/XoGmhMyO5cMdHnQdtQ4B5DBWYmWdjLoBwsQoWC7+onUAMznDYzLg0T+l
	 DDNxltzdbh19zb3myIsE/M8iewvOo0d6cI6vupw+IqqGgAHztaeOJXLFa1YQ9bEqU5
	 jejXD9x9ApRKzjhhOQXgt5x3f2EANzEQETIGlQZH4ugwFXKcayUII6fB8+UuwMJ62l
	 riqJvpIBOcm4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4AB3805D82;
	Sat,  7 Sep 2024 01:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ionic: Convert comma to semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172567143150.2573151.15152424640202694174.git-patchwork-notify@kernel.org>
Date: Sat, 07 Sep 2024 01:10:31 +0000
References: <20240904081728.1353260-1-nichen@iscas.ac.cn>
In-Reply-To: <20240904081728.1353260-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Sep 2024 16:17:28 +0800 you wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> [...]

Here is the summary with links:
  - [net-next] ionic: Convert comma to semicolon
    https://git.kernel.org/netdev/net-next/c/62c9f50eabe0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



