Return-Path: <netdev+bounces-285095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIvmKv/o+2nEHwAAu9opvQ
	(envelope-from <netdev+bounces-285095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 03:21:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B06144E1E88
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 03:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44D443007B02
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 01:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074B31A682B;
	Thu,  7 May 2026 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1S9e4T8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942B19ADA4
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778116856; cv=none; b=kSO2tEr4OlYLUxiCDlk5YbCyLjA1C9gKGUejyb4fVV6Y0iVXPupJIWKZDsGZUL0rFxA46Wrj4l3/vHd7aQPBYlv9GWnoY0nlKLfLcO7C2h8F3kmf1Vkjx55a6kXmLMt5VAJkTBwd4JMP1Ds+6uYs5KNvH9QitAMD5iXQr24ZJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778116856; c=relaxed/simple;
	bh=gaTVsUzmDP70CuIhumE7WkXUpPCIiRpU25UkBAPsygM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y0ckbsGz20SDuk+rBNiL9ZC7izOLIulivvRXuxuR4EMNpYVOsjyIvGlzK2QWU1aC9tk2QDa4wvAB3vS49vj3uviy3it0V8MltwTw+QwSaUkJzy0ZebXIvyLjp/TGfo3JTbhvpHzOPWBCtNr4qf/fKC6TUwOBP+oBboy3kwnHCc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1S9e4T8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73006C2BCB2;
	Thu,  7 May 2026 01:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778116856;
	bh=gaTVsUzmDP70CuIhumE7WkXUpPCIiRpU25UkBAPsygM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X1S9e4T8N0TTb2U8C/o0hTarBFxRPFGvDWkOLZVCvwQCfvKdtmAFpfFkzKoLtxf44
	 gjTjwCmmMGfHzj4KFXxg0A3WjMYnk7S3ZlE7wo6JYnBBiNV1+B+vNDeUmA91G4h3qJ
	 XxNlLKepErnQsHyxtB7CP6xs5VRzqMh5svPjYE+K8DSle4mAAOtxz3oc/pQ1cSsY+h
	 TN4TZY0gSNQI7qWDJntsUz5q5Hb4jvAXvSNKBJE2OIiPiFCZBHo4SWyTggwHLuvU4j
	 Tjf2UgzpFAyJTqSd9fgmyj+gC5K7Tj5++5gf+W+7f9EUtADa5yHnzoVsnjve+YWsay
	 89m88cbpPAiPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCF1393089F;
	Thu,  7 May 2026 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net/sched: sch_sfq: annotate data-races from
 sfq_dump_class_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177811680605.3288757.12491304550641844471.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 01:20:06 +0000
References: <20260505091133.2452510-1-edumazet@google.com>
In-Reply-To: <20260505091133.2452510-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: B06144E1E88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285095-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 May 2026 09:11:33 +0000 you wrote:
> sfq_dump_class_stats() runs locklessly, add needed READ_ONCE()
> and WRITE_ONCE() annotations.
> 
> Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> v2: fix logic error in sfq_dec()
> 
> [...]

Here is the summary with links:
  - [v2,net] net/sched: sch_sfq: annotate data-races from sfq_dump_class_stats()
    https://git.kernel.org/netdev/net/c/770b136ff9bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



