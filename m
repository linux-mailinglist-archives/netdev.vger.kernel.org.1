Return-Path: <netdev+bounces-264966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJUfL91lq2kfcwEAu9opvQ
	(envelope-from <netdev+bounces-264966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:40:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 376C5228CAC
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7801F301026D
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 23:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768383806D5;
	Fri,  6 Mar 2026 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exKiICuw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7534A79A;
	Fri,  6 Mar 2026 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840407; cv=none; b=oQILm3WYtUC1i/rH/S9GGw/sNA8qEz2gLI0w7KhOKir0Eucq0Frpfj4M0cgGvjl14VZ25Nt4wruyZl5M2Ys+XscXjXl5pkUcifTKBsPizxihUIzlXEZisvvcF4H7ucYH5wTfIMA6YsWLcYjzZV3BVZzoaz+/vrQEcCclEEzwR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840407; c=relaxed/simple;
	bh=0eGcpca/iwncf1ngXeKA1c1UCXdC4dXIB/SNJQStxoY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FnDZmgLX6cAUZeoWT4tU+ZCS5ygzbx/ZapHHnOp1Lj7RoIfDQ08uSmtpwnljhSLTvMhxht6ViYAW64AlMOL3oFsuNyCjF7TI9/p2m7DnGeglsLZ5H6ksYJxoA3Quh3J2JZfA0M2hnmG65aerlT+fJ4XFzTB3lHuTME0kcFZLC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exKiICuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7049C4CEF7;
	Fri,  6 Mar 2026 23:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772840406;
	bh=0eGcpca/iwncf1ngXeKA1c1UCXdC4dXIB/SNJQStxoY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=exKiICuwMCyGsztZK+zW4i404deQhbRiqjS4WJp9PcE7K1LLJSengO/G3gV8G7Hpq
	 IhxFWpW3K+aAmdpgQvzcUUeckWprAsPGv9B6+Xfp+w4MQqrSnKZVylSfj/NoxznuZb
	 zE76tZd/MRI75vcqO47ykKKiG37Y68X7TxkJ7ZI6beTdUBW151z9WS6PfFsn3O8GP5
	 a5fxfmRLpUFK6gMWGVLK/n7FoR9zW8qdGQSazBcmZjtw02vQ/EfZGjfxQAAozvDOro
	 uqfPevYZOYmcIhoj78b01tuTGSFd/kP4ERQi6Kdgl5hC5JiJc/G/j3Hiy8j89yH0e5
	 elrbTgxqls11A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF723808200;
	Fri,  6 Mar 2026 23:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: iou-zcrx: wait for memory
 cleanup of probe run
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284040580.92971.6197801206670271498.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 23:40:05 +0000
References: <20260305080446.897628-2-dtatulea@nvidia.com>
In-Reply-To: <20260305080446.897628-2-dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 376C5228CAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264966-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Mar 2026 10:04:45 +0200 you wrote:
> The large chunks test does a probe run of iou-zcrx before it runs the
> actual test. After the probe run finishes, the context will still exist
> until the deferred io_uring teardown. When running iou-zcrx the second
> time, io_uring_register_ifq() can return -EEXIST due to the existence of
> the old context.
> 
> The fix is simple: wait for the context teardown using the new
> mp_clear_wait() utility before running the second instance of iou-zcrx.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: iou-zcrx: wait for memory cleanup of probe run
    https://git.kernel.org/netdev/net-next/c/507ccb668f2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



