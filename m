Return-Path: <netdev+bounces-185303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF1A99B98
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7B73AD89C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA08620D4FA;
	Wed, 23 Apr 2025 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U54ZwEMY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15421FECBD;
	Wed, 23 Apr 2025 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745448014; cv=none; b=dUc86dCVfspkLHeb2zRVghcoXtkCAWNFIxzyKjbiCIt7S+xdqhNUVuIqp9GoP/M30bqY9ua9DaCqg8ryIwoXwPymHO/pcUVnLVgo1jg0vQfAKCWUMjeg8EnGjcSr7rI8pDPRquCjOh15jLxfgkseFoUXzOme3R3jAiOZrKJOYXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745448014; c=relaxed/simple;
	bh=u6Ya3rFex4Bwv35xxKZs9OroMGohfAFI5E01NmPrLAo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GJ/996scn2CZlncpqokHNz3uk1fWIfhblChjOE7SjOTO7p5cUq1VioXGf3S73aaPLYY81adiu6l/YG1AlYVvrYb3bvNNySVZMioZbK7K77XvDE7ZcnGv7Nz0NCMGH+8pzN0YRbE1UEGQt6Eo6Qs7hnncd+1uhuXlgPQyl1qeUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U54ZwEMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFBFC4CEE2;
	Wed, 23 Apr 2025 22:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745448014;
	bh=u6Ya3rFex4Bwv35xxKZs9OroMGohfAFI5E01NmPrLAo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U54ZwEMYR2OAoD4ep0einiGpgR7EXtx6KF24zYNvbHaj2VOzBGeYcDtu9JV3uLm63
	 nqQjESmwPojopXkMH6bMik+ScTxspUNpIteAnzHmuijVciIMTMjch9Ei5Dw4l2vPw8
	 3VBEZoO9kvgdqnx3fWoA/NNqtE0tyEmb/9RFoer6B4tJGBiAifKY4z+7OiZU0wJr4d
	 tE7OhdGS+wbzK/ctq8iy9hdFzBn/egeOUfCYr75PJcqB86rKUEQe2RSxFuJHFyfoR6
	 Hr7iDVYv1+9SsoR19R8hyapJEuCIoYz/nrUGtNQkOUzuTQzx4RMxKGfWamC7sfQjRy
	 G2YN83f5h9yhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB162380CED9;
	Wed, 23 Apr 2025 22:40:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bnxt_en: hide CONFIG_DETECT_HUNG_TASK specific code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174544805249.2788494.12713788878611778636.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 22:40:52 +0000
References: <20250423162827.2189658-1-arnd@kernel.org>
In-Reply-To: <20250423162827.2189658-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kalesh-anakkur.purayil@broadcom.com,
 andrew.gospodarek@broadcom.com, arnd@arndb.de, somnath.kotur@broadcom.com,
 horms@kernel.org, ap420073@gmail.com, dw@davidwei.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Apr 2025 18:28:21 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The CONFIG_DEFAULT_HUNG_TASK_TIMEOUT setting is only available when the
> hung task detection is enabled, otherwise the code now produces a build
> failure:
> 
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:10188:21: error: use of undeclared identifier 'CONFIG_DEFAULT_HUNG_TASK_TIMEOUT'
>  10188 |             max_tmo_secs > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT) {
> 
> [...]

Here is the summary with links:
  - bnxt_en: hide CONFIG_DETECT_HUNG_TASK specific code
    https://git.kernel.org/netdev/net-next/c/8ff617513996

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



