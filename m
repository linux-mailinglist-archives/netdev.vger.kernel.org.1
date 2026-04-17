Return-Path: <netdev+bounces-279211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOfJOLSd4WkQvgAAu9opvQ
	(envelope-from <netdev+bounces-279211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:40:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B2416472
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9590301B8DE
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865722C026F;
	Fri, 17 Apr 2026 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6a5gzV2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5E54654;
	Fri, 17 Apr 2026 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393649; cv=none; b=BFiPZU2GscuZHcMK20ruSwla6r72N40KQskw9OAcERjBRPWp6jDZEPvH8cqrSaC7x9lix5CpbHu42QU8ZMoZjVAEWwWiPBuJpvGloAhAPdwtdg1BV2QwM9lFghsoQdsx45/KGMkRl3NLY1C5W4/0dO/nkTXkW6g9MLhOnIG/7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393649; c=relaxed/simple;
	bh=QUnObaBhJTDAlBb/fKf0iO2RPjvDD1HfhPUJizDkEbE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SrFV0fw4njVJv3nLA9SD5RSJcMv5yRJpPoUkmQlxBFUK29yqPyNyufR4EkIHDT+nUgU/07CfwdtYsGfDwZ2VBetBl5ZsANMKadkwGvh//DWJ7rF1Xgj5+a74eItbEQbgmFZhwn8+Hgo5dives4NGw5v/ggSGgi2FR99ixj7qcD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6a5gzV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39431C2BCAF;
	Fri, 17 Apr 2026 02:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776393649;
	bh=QUnObaBhJTDAlBb/fKf0iO2RPjvDD1HfhPUJizDkEbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q6a5gzV2FPjW7qfq2gSdIvN81TEpLOHIm/L0ocIcH5l4hi7MQyG9Dt0yhqEWYoVzN
	 acgtCw/xQ15fG99sme/qYxkRupSxrum9IxLTgOFZcr5CkpqVoCiS6gtUuxLXFHQ5SG
	 oEDN9aVSJc6Sj9kXNoprj7ur7hi8ArAuqrZHOy/4fifWBqUURunf/WRCLzLxxj0Ko6
	 y7Qlq8dzDpnI3rJJorQrXuOZbUd1zzKgunaXeXrRwxhB8OD3QfSEvN/xoCAFuohtCe
	 TMzNMFAZnTz7OEUHtOalpYEndtO4G6x5HInyTj7rpMQhNYefNYKqjR1BShwwLn3QDO
	 UD1e27hGIVC0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE14380AA76;
	Fri, 17 Apr 2026 02:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] vsock/virtio: fix MSG_PEEK calculation on
 bytes
 to copy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177639361729.3490984.1458427039139248914.git-patchwork-notify@kernel.org>
Date: Fri, 17 Apr 2026 02:40:17 +0000
References: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
In-Reply-To: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, avkrasnov@salutedevices.com, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279211-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D6B2416472
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Apr 2026 17:09:27 +0200 you wrote:
> `virtio_transport_stream_do_peek`, when calculating the number of bytes to
> copy, didn't consider the `offset`, caused by partial reads that happened
> before.
> This might cause out-of-bounds read that lead to an EFAULT.
> More details in the commits.
> 
> Commit 1 introduces the fix
> Commit 2 introduces some preliminary work for adding a test and fixes a
> problem in existing tests.
> Commit 3 introduces a test that checks for this bug to avoid future
> regressions.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
    https://git.kernel.org/netdev/net/c/080f22f5d302
  - [net,v4,2/3] vsock/test: fix MSG_PEEK handling in recv_buf()
    https://git.kernel.org/netdev/net/c/a3f77afbf67d
  - [net,v4,3/3] vsock/test: add MSG_PEEK after partial recv test
    https://git.kernel.org/netdev/net/c/2a2675ef6190

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



