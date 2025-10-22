Return-Path: <netdev+bounces-231497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9810BF9A5C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 03:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83D304FB2DB
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0417721B196;
	Wed, 22 Oct 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgceWf9x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD921B191
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097837; cv=none; b=JqnCfYM/dfxR3Px9nNgvdT/QyZNiK6qGtHZxMbu10LqQho2VWgQmt0B/4O0ngF8fQ3DJr0CE12CH8YRAosjM4cGvynHdcmCY+nMvnYdu8uAM1bdsuMeumk1MqTC9WH0c6xashUgJ83ggcKrsShM4SsUDOty04AuCmUsOXnRevIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097837; c=relaxed/simple;
	bh=hFblUcPGfykjEmoteO/u14ZnXtXgctypD7dMrKub+wg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u6opDG3/SbYBL9cIWJkw5ZoxpDyq2uXb2a14T3smwV5FpEGpkSS/cQ5vaJUihGRTTf2vZJ2xXYYPTFANbmfLURZplktIn7BNPLLmLegIH1vT3hZiASEyIfDfh7t0sS+/XjMyNiDfHEtCKuROJhS7Jc5Y6VudZYb4BDrTTNvwd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgceWf9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DC0C4CEF1;
	Wed, 22 Oct 2025 01:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761097837;
	bh=hFblUcPGfykjEmoteO/u14ZnXtXgctypD7dMrKub+wg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pgceWf9x1cZuca5a3JNW+pRrwMV7IYM/liAc+lCIJfgXtRLR8f3lJlIEfzDQVjK/w
	 dHN8jEsvYjvZDNyUyiCxpP+KkzoAMtBLonvVRZhEDgd/fDZ8aMi6LkayS5qtRO99IF
	 WuutFtIT2/yRD8XXYFzsuTlkwf0bUiPWW/i8kiL0Ove5UXS1k+emUGGcwbAAzI6cMI
	 QkKB3bEsVqazBI5jFVA0bors494pm4Z54bI1WRkohvRoJU9Shu1ZTd4nMmuF7n4zqs
	 MJUmdME6ji4XZnHKfPdO5w2SipAbjOysXqtpUjFJatYOPJuKCijr2rTYpZkS09IaqP
	 sJ3rkJZjEgkig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC2E53A55FAA;
	Wed, 22 Oct 2025 01:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH  net-next v2]: 3c515 : replace cleanup_module with __exit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176109781850.1305042.10802413199570719561.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 01:50:18 +0000
References: <20251018052541.124365-1-i.shihao.999@gmail.com>
In-Reply-To: <20251018052541.124365-1-i.shihao.999@gmail.com>
To: ShiHao <i.shihao.999@gmail.com>
Cc: horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 18 Oct 2025 10:55:41 +0530 you wrote:
> update old legacy cleanup_module from the file with __exit
> module as per kernel code practices and restore the #ifdef
> MODULE condition to allow successful compilation as a built
> -in driver.
> 
> The file had an old cleanup_module still in use which could
> be updated with __exit module function although its init_module
> is indeed newer however the cleanup_module was still
> using the older version of exit.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] : 3c515 : replace cleanup_module with __exit
    https://git.kernel.org/netdev/net-next/c/1471a274b76d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



