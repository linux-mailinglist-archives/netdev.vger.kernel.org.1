Return-Path: <netdev+bounces-252429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFg5O1pScmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:37:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE096A172
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAD00308FFE7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA7A3D7260;
	Thu, 22 Jan 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2d6uBIQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9713D5F59;
	Thu, 22 Jan 2026 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098222; cv=none; b=R1yCUn9m9n1vg+E6+sA/ONfCSTvKnqSSV2ypvBOUn6n2ZVuqEXWwCntfBNScgBLrVXwsT/zMLesJEXjJYO5Hml0sdUGrbW7+M0Ay+AdkDqDYfrSrF7DJd73AvZDxuruU6U2eE+tH1ZWTQSFkWJUnReGdRWL7eX7EwMQVK4iCb1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098222; c=relaxed/simple;
	bh=2bAlA9gFL5wt5NUhdfiV1QPinl/S38Ba+SkiCQ8JNnI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eyO+SFZrKQyOas/9rFd5y7NdCA+MTxlHilnTZ5ezW1dIZPUOQaYhGtTmT8xBYPCPKFPiF/MNNRJUHtOb8OrjX7BnZ3kQJXWU6lkV9EB9HzUJ7RVSCqpg8tuJF0IbJHM94aDQ0oZ2oOUHTpw9i1JNZjFkaS0/WSZ4WkKfB8S6KIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2d6uBIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719E3C116C6;
	Thu, 22 Jan 2026 16:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769098220;
	bh=2bAlA9gFL5wt5NUhdfiV1QPinl/S38Ba+SkiCQ8JNnI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p2d6uBIQCmFjqUdwPq632cM7oJwfvnore8iw8oZwSMsKI2L1yRCJhnSTiO5TcXm9a
	 eECyLJZAZUTtmKHcaV8oN4bEUhNuVPpd6kHtYVV9p3vfHRN8f0b47bjL92aeJKQAgr
	 ia5Aesm+98qXSYm3ND1Dl0Dtlc+l7YInj0mUlSYpO+x7g5KbWcM6ptAUQAYq37gumt
	 euOKk2cEuzWSFsK/H5IgOymqghIRPFp2VkQguJyQtf2BD+dYkhiyL9c6YcQPALTmtp
	 mH6sXFoBrfGJ/vwxoqTHpiTx2pY6isdsvtsmcf4t/nIcCimtdfO8hfTYSXIBuz/BOG
	 sq7ZDre+kl5Ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11AE13808200;
	Thu, 22 Jan 2026 16:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] hinic3: Fix netif_queue_set_napi queue_index input
 parameter error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176909821684.1785789.11855438020354968851.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 16:10:16 +0000
References: 
 <7b8e4eb5c53cbd873ee9aaefeb3d9dbbaff52deb.1769070766.git.zhuyikai1@h-partners.com>
In-Reply-To: 
 <7b8e4eb5c53cbd873ee9aaefeb3d9dbbaff52deb.1769070766.git.zhuyikai1@h-partners.com>
To: Fan Gong <gongfan1@huawei.com>
Cc: zhuyikai1@h-partners.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, luosifu@huawei.com, guoxin09@huawei.com,
 zhoushuai28@huawei.com, wulike1@huawei.com, shijing34@huawei.com,
 luoyang82@h-partners.com
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
	TAGGED_FROM(0.00)[bounces-252429-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CE096A172
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 17:41:55 +0800 you wrote:
> Incorrectly transmitted interrupt number instead of queue number
> when using netif_queue_set_napi. Besides, move this to appropriate
> code location to set napi.
> 
> Remove redundant netif_stop_subqueue beacuase it is not part of the
> hinic3_send_one_skb process.
> 
> [...]

Here is the summary with links:
  - [net] hinic3: Fix netif_queue_set_napi queue_index input parameter error
    https://git.kernel.org/netdev/net/c/fb2bb2a1ebf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



