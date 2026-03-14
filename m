Return-Path: <netdev+bounces-267784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +j5PF36dtWmR2gAAu9opvQ
	(envelope-from <netdev+bounces-267784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:40:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3AF28E2A6
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7FE43006B3C
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D4E20C038;
	Sat, 14 Mar 2026 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0+0m4dD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295B1CF7D5
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510011; cv=none; b=eCbhTFZPo1mTeHZQhCz1UaCztxlNCDt+QtHRqkDEl2/BUoUQQpBLZNHVRXfuwb67gc0pza3y3G/C6TOtgixIpLp/sH8dHAE5eDA24IrOLe9LUSeifRJfZJ5k+z5MPZtgJCMxqAvaCrX8652Bj0BvLuo48sobDO+eHuIbygtnI7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510011; c=relaxed/simple;
	bh=sBtpFP6KmyqSDgE2aT+LcGS9e5jiEE892Z+QR/IQc1c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bcn2EnLXE91E9cMN9N/VwwV3vDtPe1Y/T0UD/JiAX6zTsoOUil1tOyLyrUUERhYmjRRXELrqOLitFuYwzsIblw32WF6+wVGOMZGjlJN03FzLHRFfJ9veuSQZGNlfqx34VsYDGd/n0/AlVCcMFXYgteLjeoJyE5qu19bEfDCFlbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0+0m4dD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23374C116C6;
	Sat, 14 Mar 2026 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773510011;
	bh=sBtpFP6KmyqSDgE2aT+LcGS9e5jiEE892Z+QR/IQc1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T0+0m4dD2LCX5eFy0Lem77BvN7p0jp6dOa1jHgdoh7/k43LzcKqLC7RAS6heKP0n4
	 lZ2Ns32yPjYZGdEPSPZsuQHfgNuJOheHBnhdH93fIc9VBSl8kLW4YrCGsGVdxxhEJS
	 K4oMvywBYZLyqBYnhvHPRPr5b1ivQ9DAikCkAzwFGs7fvSmEm2Xlequ7JkNunOuHSa
	 zQMYtsDbawrHg0gpLujBW/wCvlR6rZ0pluY7Nu0DqeY+QEzC5NCHXCcenv7PCm2u+1
	 phA50gtgEXA5Vh7gpScgJvT5bAFEg26TSmdmPVTU0UZQg+ypwCw1MtfgReRalMzmgR
	 VC75A9L3aLZgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0353808200;
	Sat, 14 Mar 2026 17:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] ipv4: validate IPV4_DEVCONF attributes
 properly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177351000529.1742341.18370550438720119732.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 17:40:05 +0000
References: <20260312142637.5704-1-fmancera@suse.de>
In-Reply-To: <20260312142637.5704-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, dsahern@kernel.org, davem@davemloft.net
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-267784-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA3AF28E2A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Mar 2026 15:26:37 +0100 you wrote:
> As the IPV4_DEVCONF netlink attributes are not being validated, it is
> possible to use netlink to set read-only values like mc_forwarding. In
> addition, valid ranges are not being validated neither but that is less
> relevant as they aren't in sysctl.
> 
> To avoid similar situations in the future, define a NLA policy for
> IPV4_DEVCONF attributes which are nested in IFLA_INET_CONF.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] ipv4: validate IPV4_DEVCONF attributes properly
    https://git.kernel.org/netdev/net-next/c/fa8fca88714c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



