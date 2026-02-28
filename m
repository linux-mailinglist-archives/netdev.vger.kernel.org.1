Return-Path: <netdev+bounces-262050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEMpDYpVomng1wQAu9opvQ
	(envelope-from <netdev+bounces-262050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:40:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CB71BFFFB
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA58E302E330
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DAD261B71;
	Sat, 28 Feb 2026 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heXFmDyX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC119C566
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772246407; cv=none; b=EPq4eaxAsvvxp8JyP+QelFX1wx33kYlX/MQtkgDsnhJKea/aRYX3Nu/ZQMcI2ofx2hLZddx6ZH4i1607y7yqESCGxelU3A+dvPLE9VVTSyjcInxzLJIL+c4RWagSwHmEDVh4/Gb0tMiCVZQg1Ll7is6AootJ48cb4PAZVNkEkuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772246407; c=relaxed/simple;
	bh=HI30VMOfSUYYOwg2N1Ufd4FpHkiK14a+VWS9Yzw36Pc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FqHzsNTEg4bWQd5N/dCbhD4XtStbaEDTtphK1r1EpXB6sj1+RZIzvw0A0Lz8ju0V8RAneOKlDJAW3uw4R12MSYwxhc8Cb4h/bsRsgc+MT06WtOnCm3BrMDxEiR/VayPKee4A9z7SUtZYW0riGCttPRGmSQt92u5ZOpNFNO/wYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heXFmDyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8909FC116C6;
	Sat, 28 Feb 2026 02:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772246406;
	bh=HI30VMOfSUYYOwg2N1Ufd4FpHkiK14a+VWS9Yzw36Pc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=heXFmDyXbjVDjZREj30tCzB+2lmEMdJWblvRXWIiOfcDjmbSXRFCQMu+l5OiZD/v2
	 2zNI67xH0Fg1srMymk1t7ldk/yRf2oDzWhrcz71mLwmDyPUReK43vdGsCSTjKLHsoX
	 n2hX6Cg5uEtztAEClkw9DSqJTLI+3DRZF5obdmbcMghUe5u0W568VJ7BlX8K01WlQv
	 6FYT9i1KhzrjRt0flpfI+ixFe95OhWGOkXc/deoKSEnaWzDOqe0uaMOZZ687ymxa6D
	 23BGFpszk5hHG3EbeglGrfsCRN/0i6z+o+VjVi3Je4ft7FUtUGiCwRArqVQSw966z9
	 VmLlo7gpz2pdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE7C39EF96C;
	Sat, 28 Feb 2026 02:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net/sched: sch_cake: fixes for cake_mq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224641004.2844958.4473592954504519099.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 02:40:10 +0000
References: 
 <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-0-01830bb4db87@tu-berlin.de>
In-Reply-To: 
 <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-0-01830bb4db87@tu-berlin.de>
To: =?utf-8?q?Jonas_K=C3=B6ppeler_=3Cj=2Ekoeppeler=40tu-berlin=2Ede=3E?=@codeaurora.org
Cc: toke@toke.dk, jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	NEURAL_SPAM(0.00)[0.769];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262050-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,tu-berlin.de:email,toke.dk:email,mojatatu.com:email]
X-Rspamd-Queue-Id: 87CB71BFFFB
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 12:40:14 +0100 you wrote:
> This patch contains two fixes for cake_mq:
> - do not sync when bandwidth is unlimited
> - adjust the rates for all tins during sync
> 
> ---
> To: Toke Høiland-Jørgensen <toke@toke.dk>
> To: Jamal Hadi Salim <jhs@mojatatu.com>
> To: Jiri Pirko <jiri@resnulli.us>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Simon Horman <horms@kernel.org>
> Cc: cake@lists.bufferbloat.net
> Cc: netdev@vger.kernel.org
> Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/sched: sch_cake: avoid sync overhead when unlimited
    https://git.kernel.org/netdev/net/c/0b3cd139be56
  - [net,2/2] net/sched: sch_cake: fixup cake_mq rate adjustment for diffserv config
    https://git.kernel.org/netdev/net/c/15c2715a5264

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



