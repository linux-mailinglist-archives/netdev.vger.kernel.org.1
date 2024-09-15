Return-Path: <netdev+bounces-128419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABA99797B3
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 18:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DBC28253F
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 16:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60D51CA699;
	Sun, 15 Sep 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GABdhnkG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926F1CA691;
	Sun, 15 Sep 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726416089; cv=none; b=CXS9bFYEvCRDKfmZw0pFRylFGCFmIMKIpfdKuQGZRr0w5++qzBwEJYysietU7FKoFnRFlzDL7xtc52jqXfXGnkeXiaSzvNOHgedBr3J3ZzHAYjDSLYMjUGHWHe+0A0qaRjWBeKYUKueAysqCtJBNV4UhBBm/GHc0rc309O8VoDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726416089; c=relaxed/simple;
	bh=x20z1uut2Av/47Ndzmv3VV1AWvA7tpBOUumR1sOmFNU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dnkgY1gMfIF6aQMnCEME58rl/4b4zt17tGhWxOqttheOqjXOOuPHefpkPogObctTeuB2xGTQnSZq5iwP2rC5MiwyiMpOmx7OgwysHRKAWF5PVosx+zzuWh1ato0VU5e3jTIExmkWWHheaZu23aR6R7idMiqWJwLslifNcjZKEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GABdhnkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DD7C4CED0;
	Sun, 15 Sep 2024 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726416089;
	bh=x20z1uut2Av/47Ndzmv3VV1AWvA7tpBOUumR1sOmFNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GABdhnkGIM3DwqQVfR+ZEerRt0iFtHYWmEM8U7s+D2zbL1hpd/DwMI74vD4fL2Loi
	 2t0fFkLsFO4h60pZbTNi4eatqK6yU+Jl/U3o1oUDj9WGOjrYFZmcQWdIe0i0M2VYMp
	 iiwFbRN5HL+jTUtJFsIbty64KHxNCdL/u1Pa50Uob8wKWCqrjPvnK4FxHXMpqSLC52
	 OZyyDFaGZMBy34lK1U5U2JhAxBcnJu3uAv+D0NeyPBJ08yBoPQEAZ5Fizu3o66fLx7
	 ypyTX1DGznA8RV+DxnfOLWRlANfdp25VqulIMDZhNT2dNgWJ0sCURh/f/jbtKCRk3f
	 39jhKPhqMiXFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2D93804C85;
	Sun, 15 Sep 2024 16:01:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ice: Fix a NULL vs IS_ERR() check in probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172641609027.3111582.15058524738519708008.git-patchwork-notify@kernel.org>
Date: Sun, 15 Sep 2024 16:01:30 +0000
References: <6951d217-ac06-4482-a35d-15d757fd90a3@stanley.mountain>
In-Reply-To: <6951d217-ac06-4482-a35d-15d757fd90a3@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: piotr.raczynski@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 michal.swiatkowski@linux.intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Sep 2024 12:57:56 +0300 you wrote:
> The ice_allocate_sf() function returns error pointers on error.  It
> doesn't return NULL.  Update the check to match.
> 
> Fixes: 177ef7f1e2a0 ("ice: base subfunction aux driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_sf_eth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] ice: Fix a NULL vs IS_ERR() check in probe()
    https://git.kernel.org/netdev/net-next/c/472d455e7c6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



