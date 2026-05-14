Return-Path: <netdev+bounces-287935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APTdBXqyBWqeZwIAu9opvQ
	(envelope-from <netdev+bounces-287935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:31:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F2A541084
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C60B73023A4F
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1633B5837;
	Thu, 14 May 2026 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubFsvF0q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5D1E515;
	Thu, 14 May 2026 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758262; cv=none; b=I+mhnMQL6H36Uv+ydtZVs8PSovCpkw4cTPIxuOs1q6bhTllx8K9tWZtB0MFtTbaAhi+i454/Og6zdAnYIjISmKDnIHMTbOwfHJKEP1adNfgvtdokcPTC+OfnISo4sODzfK/BmtX7BY8J3NI+DckM4M5KFoNuCUlSxt2p5QTwpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758262; c=relaxed/simple;
	bh=VioNOjlurHh72ip0LTmmXgLOug9O1q0NyopeUvv3VDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FkVcwPWmCgFEFJ6o3CnalHBLQyskguzolpzpEMkeLVAzZk3lhnAJU5HG2hp36K6G4XlcU+nFP4KIW8cmsnCh1Mvf+Yzi6t5O803kV3lF0tcK4hyoNzGGpt3DfZ6E77QpcDM5dr7CR/KhxnV7ocKEnzVpOzMxdeZJ1z87do4Byrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubFsvF0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F64C2BCB3;
	Thu, 14 May 2026 11:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778758262;
	bh=VioNOjlurHh72ip0LTmmXgLOug9O1q0NyopeUvv3VDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ubFsvF0qOIaM3KXn1CkODpN7G1W1ta1vEWcQzZX+iYJg7+8Ibrqp6Vfh4xdf5uJ91
	 iwRmI6u2q+UMew66GrjxB5h/SjhqXFDpb/Rup5DLMjY2SKG8+vdThJwqedSyYtS4Kr
	 2oEdIWbwCOgSmq0MtE27sCDlIa41P4yMc/Sqw5TR8EOdTvH4nWQSGrdg0CmzNeNAx6
	 t3LxvaZF1tHSzW4OCxBjhFsYU0QPUGiBNbbJUX+8ivc93tbutZ7DZuELIa4+ALsylk
	 j9+vdRc1xba1EH3PUQlaiCFMMhvWnAYJ0hVKsiRTtL1kJzJWaYFZKhIFw+JJc5YSb3
	 uDJO4NBaSNhUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD1C393109E;
	Thu, 14 May 2026 11:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4] net: tls: net: tls: fix a few random bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177875820730.4080981.4018205848945747981.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 11:30:07 +0000
References: <20260511174920.433155-1-kuba@kernel.org>
In-Reply-To: <20260511174920.433155-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 sd@queasysnail.net, john.fastabend@gmail.com, bpf@vger.kernel.org
X-Rspamd-Queue-Id: 80F2A541084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,queasysnail.net,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-287935-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 May 2026 10:49:16 -0700 you wrote:
> Fix a few random bugs, from external reports and my local scan
> with various AI tools. Mostly corner cases in code which I don't
> think TLS maintainers would consider "battle tested".
> 
> v2:
>  - patches 2 and 3 are new (Sashiko report)
>  - patch 4 is rewritten to remove the code instead of fixing it
>  - drop the selftests, they were a little too specific, more PoC
>    triggers than selftests, and Sashiko kept nit picking
>  - old patches 1 and 2 were already applied
>  - old patch 3 is gone since it can't trigger today (I will send it
>    to net-next)
> v1: https://lore.kernel.org/20260429222944.2139041-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg ring
    https://git.kernel.org/netdev/net/c/285943c6e7ca
  - [net,v2,2/4] net: tls: prevent chain-after-chain in plain text SG
    https://git.kernel.org/netdev/net/c/ff26a0e8377d
  - [net,v2,3/4] net: tls: fix use-after-free in tls_sw_sendmsg_locked after bpf verdict
    (no matching commit)
  - [net,v2,4/4] net: tls: remove bad rollback and UAF on ENOSPC
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



