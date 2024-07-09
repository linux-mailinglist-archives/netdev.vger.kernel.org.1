Return-Path: <netdev+bounces-110083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E54992AED5
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 05:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B595BB21318
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 03:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52995B1E0;
	Tue,  9 Jul 2024 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZa212fQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83442067
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720496431; cv=none; b=RaKfl78/oK5n6XwffUjE7ViUMJbW69IcWeLyJLCmM+S6O3HSk++dAWMcV+plRCu/zm2hAdCVRfn2l4evKnBt/Tv2D8TJrtItRGOY2NNTzpdXmNNRr7ydx6r7qYnmU9EyJsI3YBcwjZ/TrOW1t6qEXzeLf/mPEcj05RTgmOI7qKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720496431; c=relaxed/simple;
	bh=QQcPQJbmYekuvU7jlO2+Ez7d5Vp/zxhnV5HtYBEFB9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OkVTejc64Jpzy6EAYoedcg9p9SOPjzqBApl8v9wBIPiMNfMRi0oyd+aZ0SUzEe+NfIBCM6fk7YaoXE4Qftjp5mRtKLpqGc4/leGMZzhjQ0fIansfycKkRiUhsXWeUAsuBU5ZCzDJKdRaQSFj0tFl1Hcxrt1vch7fma1D6CKMYEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZa212fQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1133BC4AF0C;
	Tue,  9 Jul 2024 03:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720496431;
	bh=QQcPQJbmYekuvU7jlO2+Ez7d5Vp/zxhnV5HtYBEFB9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QZa212fQB10NTpoALkoHGc8tpXVwXxFjXtQaVkyq19VtQZC9lwWH0CKZvdEsMcD2+
	 tKiGM9T69LLRSfRJOBtiXNpHDDbEwqePTANa1RjT6AIXaYmHnLIgRM/zsr9BknX7wc
	 Unc+w3uykwt7ZBH1GIEzs/FEWvtxwlkYCMNYNYv5YrkifooEd3JBK93yJm/VpfpWuf
	 qDN0YIF+fcLEny2N6IVXfH8HNjtjjgzY32gTH+EVfA8DJA2csi9tg7+7/fSJC1iE2n
	 +BGXubRc0n/xPSFjVW3Xn1GfBxAx1s44gGepe2tret/5aADDoO0IC2PAs8VK2uW2As
	 ypvO+8MlbTDVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00D66DF370E;
	Tue,  9 Jul 2024 03:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: page_pool: fix warning code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172049643099.15240.6330640075069515164.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 03:40:30 +0000
References: <20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
In-Reply-To: <20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 johannes.berg@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Jul 2024 13:42:06 +0200 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> WARN_ON_ONCE("string") doesn't really do what appears to
> be intended, so fix that.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: page_pool: fix warning code
    https://git.kernel.org/netdev/net-next/c/946b6c48cca4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



