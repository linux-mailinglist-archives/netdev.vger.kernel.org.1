Return-Path: <netdev+bounces-285355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHxTFkSj/Gn2SAAAu9opvQ
	(envelope-from <netdev+bounces-285355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:35:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 951134EA4A2
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F6733035B6A
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A589401A09;
	Thu,  7 May 2026 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEa3vw2r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DEE2E2850;
	Thu,  7 May 2026 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164257; cv=none; b=u4vqPNb8oMbMHnDhEI5yUbX0+7YwZy7GPvncmTKXIUqrTwuhySDClFtEVkaiKLBpCly/zltl8s8NZvTHXf3TqOkVUAqYxo9kwwAJrA6d7P1DL6ESvKjpF+OQ1c7/2EndsOfNO9DdvxGbbvWpIl+cSox1zQfRONVnEWzj7p5hU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164257; c=relaxed/simple;
	bh=IFtDFssdahyt1hvVS5/SnAnafeF8Slh0mPRxU2hqVnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gs5SgxALz7e1DUqZNxc3kjDN0SYVqb/yIaTCEImE5PlUWtuIznasRF9OmgG8+xVRLKGT/UjJdDLymIGw178AM077PAGQtg0Aemr+cBI/cC5sK9M7OCcVpGFvsVtjYMaOdzyHvkh4DJ3J0PP4SiwSyHq54xxEfIUrci3u35kLfdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEa3vw2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10816C2BCB2;
	Thu,  7 May 2026 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164257;
	bh=IFtDFssdahyt1hvVS5/SnAnafeF8Slh0mPRxU2hqVnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pEa3vw2rqqlQGP6EXtCvTogZNbjujM7BuU5BPsI8uqh0Jg4SGC7p5SRAeSQM3sIUM
	 AXRbpIlio9IMgzMZIInJ/rAw9L55G1qe0DAw6q09qQXr6rzRJZO/j+mbyk/Q1/Xapz
	 ijv0UXuXad9+ajonLy9/cnv9dfNvTOuk1nrl7HXMLISHlr2glgb2RYTVonFnr+OvcI
	 CfmzNBgW3nNVotP/MkcuBUursHvjvlmBnrzLcyTt4EPUa0gEqSVqfHFN5M0m2gx/jM
	 XaMsAA1v5SlHTZAZsG11/C9mlo5z1qkO2W76okv+BO+28LAuk0s0LdYe19vRM686qx
	 dDufajxhCcS0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCE33930903;
	Thu,  7 May 2026 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/5] veth: add Byte Queue Limits (BQL) support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177816420629.4015158.7466630027933005343.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 14:30:06 +0000
References: <20260505132159.241305-1-hawk@kernel.org>
In-Reply-To: <20260505132159.241305-1-hawk@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 carges@cloudflare.com, mfreemon@cloudflare.com, toke@toke.dk,
 j.koeppeler@tu-berlin.de, leitao@debian.org, simon.schippers@tu-dortmund.de,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, bpf@vger.kernel.org
X-Rspamd-Queue-Id: 951134EA4A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285355-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,toke.dk,tu-berlin.de,debian.org,tu-dortmund.de,iogearbox.net,gmail.com,fomichev.me];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  5 May 2026 15:21:52 +0200 you wrote:
> From: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
> latency by dynamically limiting in-flight packets in the ptr_ring and
> moving buffering into the qdisc where AQM algorithms can act on it.
> 
> Problem:
>   veth's 256-entry ptr_ring acts as a "dark buffer" -- packets queued
>   there are invisible to the qdisc's AQM.  Under load, the ring fills
>   completely (DRV_XOFF backpressure), adding up to 256 packets of
>   unmanaged latency before the qdisc even sees congestion.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/5] veth: fix OOB txq access in veth_poll() with asymmetric queue counts
    https://git.kernel.org/netdev/net/c/08f566e8f83b
  - [net-next,v5,2/5] net: add dev->bql flag to allow BQL sysfs for IFF_NO_QUEUE devices
    (no matching commit)
  - [net-next,v5,3/5] veth: implement Byte Queue Limits (BQL) for latency reduction
    (no matching commit)
  - [net-next,v5,4/5] veth: add tx_timeout watchdog as BQL safety net
    (no matching commit)
  - [net-next,v5,5/5] net: sched: add timeout count to NETDEV WATCHDOG message
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



