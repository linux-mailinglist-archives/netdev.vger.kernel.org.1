Return-Path: <netdev+bounces-189958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1D1AB4972
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 279497AC3FD
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DEF1D5AB5;
	Tue, 13 May 2025 02:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH8tzJxS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7F01D47B4
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 02:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102802; cv=none; b=tsrqH8LSf7nEzxUrV0pk9C1HydVDDAYPPa1C+/rVdFXuAHP31Y8qa9I6+9kALFob5IkXNmUTaozqlXBi7O5qrp6TaQ08dfTJIOeDVDNpVOkKbW/RJOk4kL5v2dj0poaImqL9f/n4QYsl+Md2KOkUzYQ9Y+gjiLKELqjsSzRvJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102802; c=relaxed/simple;
	bh=R8DIEhmTbYX12d1Wcc09DToJujnFf2eD+zE9ky8I7AQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tLSdFdW7c2TyLnz+vwIuu+6AOCKuxI7NSSMZWj1uIW15/uuV/6hzSBqvP53nmx2MWqAhcUI/xu54Atwjups4GDOvr2Y0kJfi63twr8MCLpTGASgvYC6sHCS+5e1LG1fCUFuPDSum6Tct4MwpX3cKTaykf1dOpp6ppfsKBhV9TWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH8tzJxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A52C4CEE7;
	Tue, 13 May 2025 02:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747102802;
	bh=R8DIEhmTbYX12d1Wcc09DToJujnFf2eD+zE9ky8I7AQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IH8tzJxS2gKimqPc+pgknpkFRqgNA9kxAEdhmOAPVrgvJ5RP3SQKtvamCnP+WY0lb
	 I9WPv/NOQW9fJch5iVlbvZOLPTjXjhKXwE805zgBW6qfgvxVmUqT7B8AHWa78w8APE
	 KH6NTU+JokyS1uMdLzBX3JEmSY961cEIpGnMbQE9xcadEJrZ/przk/K7Wh6/jx/Anx
	 1OQZqdwom7/ZMv2G4jT0hkcHcWIgNMa+mSFA2Bn/aEq3o8D6WUHhqGJHH639HP5tA9
	 3FwWXiKm05Ouq59xWQuBKCd450xrjKrBXOQvOZIYGRX1Gfty0IbboVScbPZ2/Dimei
	 o31YM0Q1tI+Kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 339D239D6541;
	Tue, 13 May 2025 02:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: fix policy dump for int with validation
 callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174710283999.1148099.10818198571300547942.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 02:20:39 +0000
References: <20250509212751.1905149-1-kuba@kernel.org>
In-Reply-To: <20250509212751.1905149-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 syzbot+01eb26848144516e7f0a@syzkaller.appspotmail.com, jiri@resnulli.us,
 saeedm@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 May 2025 14:27:51 -0700 you wrote:
> Recent devlink change added validation of an integer value
> via NLA_POLICY_VALIDATE_FN, for sparse enums. Handle this
> in policy dump. We can't extract any info out of the callback,
> so report only the type.
> 
> Fixes: 429ac6211494 ("devlink: define enum for attr types of dynamic attributes")
> Reported-by: syzbot+01eb26848144516e7f0a@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: fix policy dump for int with validation callback
    https://git.kernel.org/netdev/net-next/c/a96876057b9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



