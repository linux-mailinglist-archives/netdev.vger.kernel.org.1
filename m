Return-Path: <netdev+bounces-99939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA038D7277
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 00:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EE65B21632
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 22:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49FC38FB0;
	Sat,  1 Jun 2024 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqdhA0cZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF02E414
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717280434; cv=none; b=KlXQJllO/bhPn+mAUmCc5GzkDr7fg0LaHsAbnqiwmCl5zTAn3aCR8AXRVgxQoOFkV070E+v6FdJQ2AHoa7oYI86LtoOuUtTMO2dwTJ88bG2SVI4Msns7CRZzEVrDWNODA3BXqVtXeeijMuzUBbj3OM8xviMy9mODMaZ/fl5yATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717280434; c=relaxed/simple;
	bh=hC4m0WMxO21zIL3xudEVxdq3x+8S0D+eS5txQi6ChvM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FDW6e6GMQ2Lxb483rNMaJY5rLznnA8ZjQ2cweE0CBXfAT7mHk7z/cKjdQceGMOm2+8pkUHVpk9TKEK3kI+ZmpsP7WFEZtgEFMzQj4ny5rfUH3iVDfgzLvNaPhxMlPCq+fjVBYGa0vhvWLj/4HJTKeBv47FY7kgqQ58DlCPOEVxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqdhA0cZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42811C4AF0C;
	Sat,  1 Jun 2024 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717280434;
	bh=hC4m0WMxO21zIL3xudEVxdq3x+8S0D+eS5txQi6ChvM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oqdhA0cZMkel70ZBvCg2hrMd5S1VhHa1ooNbtkU9JrBGzpi7hpT/olysB7ONRmB88
	 0RkDXRiaXZ8LaP89eSnHnD+L4+QMhm3ZW88OA0MPwyPhkh2Dg/gK4JKB7x/EjdquYH
	 7tClYks9c7KvtNMS6ByBJycWH1n0a4b+wyD/x/40GePShYCq5G/0mojH6LAkRipXxb
	 hSdF3bO8SzPH7iRbutlZTxKcVjryAadNA3sxTJTkcItrG58UfZi/znPOyGiX11Cdon
	 QjwBJS+DH50J5WaGoNLu+4dfs+1T+3V8FviKubbsrRtGhg/6QIL6VWDQW2tYAy+/5o
	 HTQN9+tB3jcyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39ACBC4936D;
	Sat,  1 Jun 2024 22:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: qstat: extend kdoc about get_base_stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728043423.17681.17856908414515850494.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 22:20:34 +0000
References: <20240529162922.3690698-1-kuba@kernel.org>
In-Reply-To: <20240529162922.3690698-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jdamato@fastly.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 09:29:22 -0700 you wrote:
> mlx5 has a dedicated queue for PTP packets. Clarify that
> this sort of queues can also be accounted towards the base.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Cc: jdamato@fastly.com
> 
> [...]

Here is the summary with links:
  - [net-next] net: qstat: extend kdoc about get_base_stats
    https://git.kernel.org/netdev/net-next/c/69c8b998717c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



