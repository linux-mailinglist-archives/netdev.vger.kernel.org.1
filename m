Return-Path: <netdev+bounces-277860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEJrH0be22lMHgkAu9opvQ
	(envelope-from <netdev+bounces-277860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:02:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D36733E5510
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C1F0303E4A0
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86429364021;
	Sun, 12 Apr 2026 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sH7CqCe/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE63630B3;
	Sun, 12 Apr 2026 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016857; cv=none; b=qKB5gR8HsXOEd7hbIbv3bM41r8f26uFR2MIiV2pLSn9H5SaI3L6FeJF1Ms7kB4NN2RYdblFS/gbnIeR3QEucm6qmIXa6Y5Xl3H/IpUw+wqH8mi0b3pQK0U3NKufwLXr+Sn/97IdPCbCACgVA/Qh357AxP/FnTJlCehqg2NL4bj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016857; c=relaxed/simple;
	bh=efQSmoRjYYaHiY+a4ok3GBL3WlD2Cj+j8q1Q5zHA2zI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cR462qWSDY5GMQNJ2vGMO/CCUKoAKppg88IJ31Rx2gjeaYODiYu0UW7AfE2GYjP8AseBo8aOJr53y4ZzHcHmp5JaKo8LTuA4qWGp+un6CKtipxoj6RZ5aj1y53RQHVQK9SKnbHFrD77L3DCGB7Cwf3mm4vYX3OPOH2GmXnW9R4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sH7CqCe/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15341C19424;
	Sun, 12 Apr 2026 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776016857;
	bh=efQSmoRjYYaHiY+a4ok3GBL3WlD2Cj+j8q1Q5zHA2zI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sH7CqCe/KBET19LOnQcXSh4l+glXwhT76haQYXeeypRzSXlz9CzdKpjSqmS9EKSPn
	 CQ3KQ5H0F3PrZ9Y2zgmx7CKE/iBJ5u7MlsIpvaXnhf3BuGaMKn6gbctbMxA1zxX68O
	 hVpxLHe/h9Fh3F7LURf8iImERgJWMUh9d0buwrVqeDmJRZ4K3jmaq+i6nV1X4wMUvI
	 JCnhykYna1FmfoXgB7Xib5rhbmZjjLu+AumEUQG6+1skO3YcuEScoLm3+NgPOWdlsi
	 p/bES3pqihxNCrXrMgwetuTqXqJf75yXOfq3WUI3qMSkfmpnuMGljsUiqmr5X1M7IU
	 LFyQGLhNXgOzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9ED23809A8C;
	Sun, 12 Apr 2026 18:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: skb: clean up dead code after
 skb_kfree_head()
 simplification
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601682929.3359939.7949540472518430291.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:00:29 +0000
References: <20260410034736.297900-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260410034736.297900-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kerneljasonxing@gmail.com, kuniyu@google.com, mhal@rbox.co,
 almasrymina@google.com, ebiggers@google.com, toke@redhat.com,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277860-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D36733E5510
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 11:47:32 +0800 you wrote:
> Since commit 0f42e3f4fe2a ("net: skb: fix cross-cache free of
> KFENCE-allocated skb head"), skb_kfree_head() always calls kfree()
> and no longer uses end_offset to distinguish between skb_small_head_cache
> and generic kmalloc caches.
> 
> Clean up the leftovers:
> 
> [...]

Here is the summary with links:
  - [net-next] net: skb: clean up dead code after skb_kfree_head() simplification
    https://git.kernel.org/netdev/net-next/c/5758be283ff8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



