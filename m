Return-Path: <netdev+bounces-281554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mByYJn7272mFMwEAu9opvQ
	(envelope-from <netdev+bounces-281554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:51:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687947BF32
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20DE93036601
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF03B38BE;
	Mon, 27 Apr 2026 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZNQQU93"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF293793BE;
	Mon, 27 Apr 2026 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777333853; cv=none; b=SA9uCVJW1n0mqP3cup9cjXSPLf4qVzEUDGRsIU/vhPi1qM3ldbqHPCf1iQCRwD6KHUcvqyEL1tC2M4NWTjRoa8NJFLBPWWDxbbR+0zsKweK3xr7FDicMohLByWmGKepMl9l9Jlr3YfH27Wn/6EyUAxNb8UNh67PAAO0H8EjTYK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777333853; c=relaxed/simple;
	bh=X1fZFyNroCJa6reojVrnWAYpzo1iDdnEFohS8Xa3R7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uKTrXBD7rmNNFnzAJA7xP6kuMmDjsCA4LUhzt7urNb1FxwR2VFRSy9/83g4PZmlyXh1krUzfS/xY5NnHFtbhRZlYAe8L1s7gT3d4qY04XqmmIfFHhpXKFh91SdCP2wTuBRFVy11zYgbBCA+pjiOKbgjMCIjhLoBFLKwbOIIGM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZNQQU93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AEEC19425;
	Mon, 27 Apr 2026 23:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777333852;
	bh=X1fZFyNroCJa6reojVrnWAYpzo1iDdnEFohS8Xa3R7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rZNQQU93LX6yWt9MYCEc6g50ezuk6BW/8vax0ZTWdagwBItYz2puwnMFvu0gkxi7c
	 8jARE1sH5Hee+1y0KaROJiEbOcm03+lRUlEvej/EaIJAKa9/7UygibBFKn8tsFzoVZ
	 vnrbHKqX67hvE9DHzy48yyxDQNLESrWIgxZpHLW3wtc8AN8YqWddVkuJI9grGx5eZI
	 STu9o6i5hl7hWJL4FfP4cEDpoMDJ8EOv/zCnvJNdtp9eib9NGXl1kvWR5hVGY0RxV4
	 2BDDZPLdVBx+ETvkGl6bLc1VSsNCVI4LP0pjxxpKK13JDAwvyIAYkxh7vRCEm/ZQWp
	 p0MZeLzp66BeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD9F392FFCA;
	Mon, 27 Apr 2026 23:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] Documentation: net/smc: correct old value of
 smcr_max_recv_wr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733380979.156599.12718363063536049749.git-patchwork-notify@kernel.org>
Date: Mon, 27 Apr 2026 23:50:09 +0000
References: <20260424052336.3262350-1-mjambigi@linux.ibm.com>
In-Reply-To: <20260424052336.3262350-1-mjambigi@linux.ibm.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
 wintera@linux.ibm.com, pasic@linux.ibm.com, horms@kernel.org,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org
X-Rspamd-Queue-Id: 0687947BF32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281554-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Apr 2026 07:23:36 +0200 you wrote:
> The smc-sysctl.rst documentation incorrectly stated that the previous
> hardcoded maximum number of WR buffers on the receive path (smcr_max_recv_wr)
> was 16. The correct historical value used before the introduction of the sysctl
> control was 48. Update the documentation to reflect the accurate historical
> value. Also fix a couple of minor typos.
> 
> Fixes: aef3cdb47bbb net/smc: make wr buffer count configurable
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
> Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] Documentation: net/smc: correct old value of smcr_max_recv_wr
    https://git.kernel.org/netdev/net-next/c/790ead939486

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



