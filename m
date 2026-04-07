Return-Path: <netdev+bounces-276038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDtCC94f1Wnr0wcAu9opvQ
	(envelope-from <netdev+bounces-276038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:16:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFBA3B0C92
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6994530ABC9B
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949E1355F22;
	Tue,  7 Apr 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaAgYNwX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7241D2750FB
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574628; cv=none; b=ki+pFYMYnWEUeiFMP/+YKxJlDsbOcJ3qmCVhnHoF6D05PHzRxYwANrlYjhwiF56BWv8BLxoqWDf6x+Lm7sHn94k40RmbhMYkeln+sQ4qqbZuE1e3pR7S3XB6bOqrT5Jc3WXVuWsUKpwp4vqP241ceaci4Uc844zQ4SvVQxNMmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574628; c=relaxed/simple;
	bh=IoTyBCW9wTja7KoFS/ZjCxEpZ1XkG7EDkRa0/QnK9cI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vESSig0Go136+jNWNxXBx4Wl99/mrYHmKH4zerJadHVJ4U8aC5OORtSkb3KcT9zUXoaqO9nnHxzLVMmxe2oeOg1HW4bvtghIVHvMxKm0tcYJZjK44adMJWnObZjIYj0O1h2lbmUTxRO1XWJuFoVPpT/hRQn7V49S6m5Z2za2zw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaAgYNwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5E6C116C6;
	Tue,  7 Apr 2026 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775574628;
	bh=IoTyBCW9wTja7KoFS/ZjCxEpZ1XkG7EDkRa0/QnK9cI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SaAgYNwXzO4PKQE3AenSgE2xlYvsBegPOHlli5RmPigAcCo4vrSrENAOtcFASNjRY
	 Vg0p1wpDA7N1PCCV6MtNNWfvH/BOa0KImr310xHAXDAay2BcCmLoEkVoIrvObgjRya
	 Ji5A8sa8YywOtay2E84KiltEN56Mhhm/nKeqaAHkNzW54Z83aEdvrd3WfuFawvftQc
	 bgvK6lqn+OKsF6fGXCeUio151z4QvHgaEtL2oW7cjzDd0JNlQ2u03Woa+cmv3rXqQ1
	 jSo6PuZj0jLLNAn0W+Uv0wlCmS4cirxNILCTEqIQrLGB3LSfybtQX1A+hIPCtR9qDK
	 S8CROufCYeWrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD9D3809A2A;
	Tue,  7 Apr 2026 15:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hsr: emit notification for PRP slave2
 changed
 hw addr on port deletion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177557460605.4029279.17980296393660222452.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 15:10:06 +0000
References: <20260403123928.4249-2-fmancera@suse.de>
In-Reply-To: <20260403123928.4249-2-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, acsjakub@amazon.de, liuhangbin@gmail.com,
 kees@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, fmaurer@redhat.com,
 luka.gejak@linux.dev
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,amazon.de,gmail.com,kernel.org,redhat.com,google.com,davemloft.net,linux.dev];
	TAGGED_FROM(0.00)[bounces-276038-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CFBA3B0C92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Apr 2026 14:39:29 +0200 you wrote:
> On PRP protocol, when deleting the port the MAC address change
> notification was missing. In addition to that, make sure to only perform
> the MAC address change on slave2 deletion and PRP protocol as the
> operation isn't necessary for HSR nor slave1.
> 
> Note that the eth_hw_addr_set() is correct on PRP context as the slaves
> are either in promiscuous mode or forward offload enabled.
> 
> [...]

Here is the summary with links:
  - [net-next] net: hsr: emit notification for PRP slave2 changed hw addr on port deletion
    https://git.kernel.org/netdev/net-next/c/2ce8a41113ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



