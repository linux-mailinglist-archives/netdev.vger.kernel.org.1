Return-Path: <netdev+bounces-259009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHbzAptMlGkNCQIAu9opvQ
	(envelope-from <netdev+bounces-259009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:10:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A24EF14B2D3
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC9B3300B582
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD72C32F753;
	Tue, 17 Feb 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNWndunu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA24321F42;
	Tue, 17 Feb 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326614; cv=none; b=Bjv9AhJvTEP6HNeNY2OPKWMrTvVcd63kGMFABKS7I5XRzLeSrieN/KiF0gdpE7HEfJhyPP5dh1ibQ0DThx1XiQVI/bD9sMw5xtYbw/iGt2B7Zw5PbveedNti7wql4vAPg8UT4bIFizcrnFAZsf3H454hq8QRZP2ToU6YfldhfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326614; c=relaxed/simple;
	bh=HYQmNgXbaSDujkNgDA1fNaE5PjxPfwLo/OS9lM7Yecw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p25EDQzknj8f9YukmWbZ2+AkYJoHcPv9Ja+W2x3pqKSE4SC0YxNvy6WVfOCwl2tOwZYKePmpUO78d/8NwUZ/pniqTG1br0krVCgjW8Pf+Fdl2R4fPFS/at9W6H+ipXulQyvXXaI8z78Lom3bQWSwGjgzVRS1UfZgZXPEKJobVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNWndunu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81010C4CEF7;
	Tue, 17 Feb 2026 11:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771326614;
	bh=HYQmNgXbaSDujkNgDA1fNaE5PjxPfwLo/OS9lM7Yecw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XNWndunu9rdO3xm0aWJNp9GJ46fJuu/ZKAlJXhb3G3FILuxuDgIN7Q/hW8uKEgSEK
	 CLYaM9Y8NqfkArvCnYq7rDbciZulwBUr0pWXdtYZR6SCtQBnaLeQkTFjqIsufK5Sb2
	 rvlCMBE/fzRRkoKeGyvlhl/gbB0aTxzmbTRomut4GoO6qYgT12LNORAAi8hSPM+XNZ
	 dwow6X4MrrGkC0ZP24hG9th/NUKCHVtC3N43lFYwKjVpaCdVpBS/lKWgtOxxxQmsQG
	 20Ru8Z9bMk9fFtIqlAxqcPVlLH+5w9Y4hrQBnVOlemWAVgQRGsHm/Or4gNDl4wfvGt
	 7gtfn2oV/47eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C22C6380AAD0;
	Tue, 17 Feb 2026 11:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] xen-netback: reject zero-queue configuration from
 guest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177132660658.24996.8282922634336932490.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 11:10:06 +0000
References: <20260212224040.86674-1-n7l8m4@u.northwestern.edu>
In-Reply-To: <20260212224040.86674-1-n7l8m4@u.northwestern.edu>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: wei.liu@kernel.org, paul@xen.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew.bennieston@citrix.com, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259009-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A24EF14B2D3
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 12 Feb 2026 22:40:40 +0000 you wrote:
> A malicious or buggy Xen guest can write "0" to the xenbus key
> "multi-queue-num-queues". The connect() function in the backend only
> validates the upper bound (requested_num_queues > xenvif_max_queues)
> but not zero, allowing requested_num_queues=0 to reach
> vzalloc(array_size(0, sizeof(struct xenvif_queue))), which triggers
> WARN_ON_ONCE(!size) in __vmalloc_node_range().
> 
> [...]

Here is the summary with links:
  - [net] xen-netback: reject zero-queue configuration from guest
    https://git.kernel.org/netdev/net/c/6d1dc8014334

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



