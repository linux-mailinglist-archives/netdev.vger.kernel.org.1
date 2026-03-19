Return-Path: <netdev+bounces-269549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gM3xAWIpvGkxtgIAu9opvQ
	(envelope-from <netdev+bounces-269549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:50:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6395F2CF239
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BFC731F7F74
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054473ECBE4;
	Thu, 19 Mar 2026 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUjyhmlz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED303EDAAD;
	Thu, 19 Mar 2026 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938421; cv=none; b=beRuGFfyFvvKT0xsarzdoxaCTBaKpTF7ecwxklG6hS5u4QV8tPmcZXcRUW67M+5v2et8PnFJsGcJYqNa1JHuXyY3YFk/G5xzaiF4VnXjKwzWrKzwoOwFGgzHMaVfNqY+c2ceRqHBe7tiKIhtp1WC8NQJLbap5Ekaip8IRqXeMWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938421; c=relaxed/simple;
	bh=iPml70KCaSGxb9G1y6ne8CjhBWAGGD5+u3vLzLKQjxo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oK8Wv+qtZnaV03OkvXKWsVoVCU0MHFlGSVeeTTah2xyikyhNccEIFNG0IlZ41AymaxL6CscdyMfVk+uqy+gwAI4JZoYIsol3ZPYQQvwrl2DPLEEoha1pD1pjwaL/NDP5DoFDmrqxuTJ9eJS0PJOtUANJ2ZZGcM/4/ILuTVmDWic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUjyhmlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910A1C19424;
	Thu, 19 Mar 2026 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773938420;
	bh=iPml70KCaSGxb9G1y6ne8CjhBWAGGD5+u3vLzLKQjxo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cUjyhmlzKAb+LMmJUd8K8xJXPcmt+1OIw9ViNv7wzIqzE1COeSKFSqs9zS5DXKNte
	 FCaJBkSUNOE/2mfSt2Q5zIwHyf23THpJshqRXQn0f1f2i/EX3MA2NjzAzncVuFDSZl
	 7vnczA6qY/Sv75DrEoMEu7+5NxDuom60ItLoNfnDQXKknJv1tRKXXz339s0e03oQjm
	 ia1zf4xk4kxSA4Ww1p+VPg5P5s42HxzNjrJEfgYgbLUxJW+H9p7QjKleQt9izDqPJO
	 McaGkpm06OJ2BVysZJZwDckTL70Txx+zlzrmTkctqlmnfnAI5JeJi3GyTv0os4Nagu
	 U2CRHPvd7xsEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F96380692A;
	Thu, 19 Mar 2026 16:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MPTCP: fix lock class name family in
 pm_nl_create_listen_socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177393841126.1701817.17610297112158397385.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 16:40:11 +0000
References: <20260319112159.3118874-1-lixiasong1@huawei.com>
In-Reply-To: <20260319112159.3118874-1-lixiasong1@huawei.com>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, weiyongjun1@huawei.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269549-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 6395F2CF239
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 19:21:59 +0800 you wrote:
> In mptcp_pm_nl_create_listen_socket(), use entry->addr.family
> instead of sk->sk_family for lock class setup. The 'sk' parameter
> is a netlink socket, not the MPTCP subflow socket being created.
> 
> Fixes: cee4034a3db1 ("mptcp: fix lockdep false positive in mptcp_pm_nl_create_listen_socket()")
> Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net] MPTCP: fix lock class name family in pm_nl_create_listen_socket
    https://git.kernel.org/netdev/net/c/7ab4a7c5d969

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



