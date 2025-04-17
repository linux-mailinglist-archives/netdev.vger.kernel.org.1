Return-Path: <netdev+bounces-183569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C518A91111
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64A94471EA
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587741A83E7;
	Thu, 17 Apr 2025 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wkq4K6Pp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC1B1A7AFD;
	Thu, 17 Apr 2025 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744852831; cv=none; b=g4vmFru/H4kDJSOmH4jbbTk4GoZR3ORyfDKS3YVDKbWKoYp7RL0Rpo9dgCcomcW/+HnConNxjzVS3NNLQQN2GECKdTCa+2I+aBhs0pDDw+t59idSJ2OFQPE+5rqGgx+jf9HdZrGkYc8OoFvoSxm7YvifxIB8q9Vq/naSMKL8PxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744852831; c=relaxed/simple;
	bh=CbVNOXQOaknbCRMdlUFFVunW9UA6aCLGDEXNlWntgCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XvUBIGTg0Og5yVTJVhqBh10u2pv0lckHaadCo53zbrdrALRe+rT4iwS4oYWobEolF800LejjcPukkvPobnMVW3MPUTBGoOTASZ3nj/PG0CEdTpsAsaLuzrwFpi5ZtY8LPXFOWCkqOnx2x3I2+P5L7tYAP6c4MV2rgXiGQRGoOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wkq4K6Pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE721C4AF0B;
	Thu, 17 Apr 2025 01:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744852831;
	bh=CbVNOXQOaknbCRMdlUFFVunW9UA6aCLGDEXNlWntgCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wkq4K6PpYGzmzdInssvOZMnSGkfObr4SwJDpOGhU0gj9juJOIg8uiddui9vo+3fhG
	 k7yk0dqyz5jkBzGhNiOJmdeG4yO2HsI5kqz8R2aqxJgZn0enEOAf4HUEPKqBjUo1N2
	 Z9tRmIHuNxTGQKZDzrcxRV7RYJWbxXMLVI4SifMf966tlnQejVf1D2KJTDY3QUhDui
	 VZx0v0/JUwlGK7rf+/l2C8gBUedTDlKhBh7W1a1V4oL0rGNRn2V/6wxAFHGeXZ3MEA
	 Lb+BJgZOnJOYgSccnkSBSWBw0nqNtxn9h+DJ2Gt8qvf6gceK4l8zShwidolQMU3l/0
	 FNW3ZEAfgDQgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2A3822D59;
	Thu, 17 Apr 2025 01:21:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bridge: switchdev: do not notify new brentries as
 changed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485286881.3555240.12419478540241978966.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 01:21:08 +0000
References: <20250414200020.192715-1-jonas.gorski@gmail.com>
In-Reply-To: <20250414200020.192715-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vladimir.oltean@nxp.com, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 22:00:20 +0200 you wrote:
> When adding a bridge vlan that is pvid or untagged after the vlan has
> already been added to any other switchdev backed port, the vlan change
> will be propagated as changed, since the flags change.
> 
> This causes the vlan to not be added to the hardware for DSA switches,
> since the DSA handler ignores any vlans for the CPU or DSA ports that
> are changed.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bridge: switchdev: do not notify new brentries as changed
    https://git.kernel.org/netdev/net/c/eb25de13bd9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



