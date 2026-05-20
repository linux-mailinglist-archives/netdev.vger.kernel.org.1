Return-Path: <netdev+bounces-289688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMCBB9QODWpyswUAu9opvQ
	(envelope-from <netdev+bounces-289688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:31:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A61D5868D4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30FFE3041A9A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8870E2E9729;
	Wed, 20 May 2026 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO6OZgsl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C12C21FE;
	Wed, 20 May 2026 01:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240609; cv=none; b=cH0RslRWrR+giEPAQLCMUn/y6KQzNgj09U/We/8a+JBgbte5jnJrl0rAokRF9Y+7SX28g1YKinE4Awzlp9M6g0CskAbZJT0hsWHIctntlUdIA/XyPsk6P22i1DUtJvl5Jkcn8sCr6aOG9/j1VuNSKrDyTBYGi46WAKgiQbP3zpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240609; c=relaxed/simple;
	bh=+TOuricD4/jrr+sw2z+3O0pg41/JP6skn6McZWBNAtY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iIqPjdB/7y1DyhGoMVOI1apqpng4EIs1nziXl+Bsc/ywUy+EyVxTSFMQ9TsG9lYk28bppSQw+YI9s+gI6vnTXfBcmZtbt2iB0JDmjhZ3kqRf5VQFXT7HsqFKiu0MeUruy3+JcNNI4wpacvF6su8gglNMaC7Vb7ZTldpFfdXjKrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO6OZgsl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489951F000E9;
	Wed, 20 May 2026 01:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779240608;
	bh=ebwuN2CuSuzW478h0j47Hn39WcLNDYDMwWofehNNob0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iO6OZgslADUBYFEAO+V39hzwHWt2n0zA0qShkOkSxyuFTzu0UQeFquft7VPIU1f9e
	 X9PNo8hSlRii2+bUSY1zKMuMgqZtqQ/iKCadUA0IRl5Xbw4f7FLsMCtS+qKKQ81nx/
	 07vK6Y+dZyRaTi8kyNAqJ50FrGF7JgZ6NbAR3jTbsm8XI1IgINSvuLyN7N8aD6M7Ek
	 hntW/ItZ6PeMdhFJAIsPM67oweToEJTCzRfv1TjNPkCqTHLZdzBHq0rB+ZfuR4YRdX
	 uzk3u9ImjWDe4gYeeJx375mcGcBBYKIsPxLekSWzXSBfzeCdMKIyjIxaw0zV7+S589
	 ouRSXnn/LN5/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56999383BF53;
	Wed, 20 May 2026 01:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/3] gve: add support for PTP gettimex64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924061888.2943546.1863313939074098294.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 01:30:18 +0000
References: <20260514225842.110706-1-hramamurthy@google.com>
In-Reply-To: <20260514225842.110706-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jstultz@google.com, tglx@kernel.org,
 sboyd@kernel.org, willemb@google.com, nktgrg@google.com, jfraker@google.com,
 ziweixiao@google.com, maolson@google.com, jordanrhee@google.com,
 thostet@google.com, alok.a.tiwari@oracle.com, pkaligineedi@google.com,
 horms@kernel.org, dwmw2@infradead.org, jacob.e.keller@intel.com,
 yyd@google.com, jefrogers@google.com, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289688-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9A61D5868D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 May 2026 22:58:39 +0000 you wrote:
> From: Jordan Rhee <jordanrhee@google.com>
> 
> This patch series adds support to obtain near-simultaneous NIC and
> system timestamps with gettimex64. This enables daemons like
> chrony and phc2sys to synchronize the system clock to the NIC clock.
> 
> GVE does not have direct register access to the NIC hardware clock, so
> it must issue an AdminQ command to read the NIC clock. Two paths
> for obtaining a cross-timestamp are implemented: a precise path using
> system counter values sampled by the device, and a fallback path using
> system counter values sampled in the driver using
> ptp_read_system_prets()/postts().
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/3] gve: skip error logging for retryable AdminQ commands
    https://git.kernel.org/netdev/net-next/c/55687124a86f
  - [net-next,v8,2/3] gve: make nic clock reads thread safe
    https://git.kernel.org/netdev/net-next/c/4bbcd7e24aaa
  - [net-next,v8,3/3] gve: implement PTP gettimex64
    https://git.kernel.org/netdev/net-next/c/22b2aae747f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



