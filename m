Return-Path: <netdev+bounces-299046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E0AuNG7ALWrojQQAu9opvQ
	(envelope-from <netdev+bounces-299046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:41:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5521367FAE4
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:41:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RumzhwMC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299046-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299046-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38C67301E3CC
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CCF26ED3D;
	Sat, 13 Jun 2026 20:41:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113D39A047
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:41:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781383264; cv=none; b=Gu3aI6T7CuFsdRSaiFoZFpMM1MeqEXNFilCKMJGkgYOhUPjxFK1vOTGq0VK30x+gYNefQNPecaJmbG/p3L1dFrrsb4AAD/zAl3Wr/5OHY0EoiRd5uwO2AK5rm9r+Q/rdDIrHbMnynTxV40SQNrCbArC3JjmvZFcgL1Fh0g87Epo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781383264; c=relaxed/simple;
	bh=Z27F1MiJkR32NPyBd4Ylnk4mhWs7vLOaMk243A09ARY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rfhKYV3pg007gCedyRmyYFUG3/onlh+e+NzEGkiFVtI62Qi+FDXteWrSX6a2yS4KsHSdgfMp9EYf+5VwDXmxpK9lq2TDPyE/B3VElQgbsAcAvS0QjtOiaDzG6rl7AHuzI5gGdbvGJ1SSUR15EzqnSGck4A1N5CX4gMrGQym1dns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RumzhwMC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743131F00A3A;
	Sat, 13 Jun 2026 20:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781383261;
	bh=NoxqJnJ3RXrNXSb1yIxmyyOMj/xIz9bqOPmPdO5z7GQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RumzhwMC0ge9T4xB51E3rTTCa6Kwoxigd4r00GmQYcKhw6uB6hUXtFPJPTSl5KDAW
	 juSO/ZxzXsEU95NHn7+J8MRedzEqnA6qGOrbkbkTbB3R4MRJ/IpCW+qsXRvGTG9IxY
	 qJ+3h7qWXeAF3j+dr/tPTbzPiKiG5WjLtsKogodnuCLGEoarZVWHGe8aIEwXkU1xZQ
	 jkD4ji41SNqQm/1Xei3nFOAfYdwfJX7qAXjri91GGxwABWUNDN7fSsooi3DVMiKb6/
	 DqsRIHmLHX2oBd8PzsKsv7GISVcVMA0huBFhyvfDZjbTEpeL2gMlN8e8mVEwgigtXw
	 EYOLluAN5gg1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AA73A54A32;
	Sat, 13 Jun 2026 20:40:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/18] xfrm: cleanup error path in xfrm_add_policy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178138325738.1587607.4411330476742685465.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 20:40:57 +0000
References: <20260612074725.1760473-2-steffen.klassert@secunet.com>
In-Reply-To: <20260612074725.1760473-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299046-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5521367FAE4

Hello:

This series was applied to netdev/net-next.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Fri, 12 Jun 2026 09:46:17 +0200 you wrote:
> From: Deepanshu Kartikey <kartikey406@gmail.com>
> 
> Replace the open-coded manual cleanup in the error path of
> xfrm_add_policy() with xfrm_policy_destroy(), which already
> handles all the necessary cleanup internally. This is consistent
> with how xfrm_policy_construct() handles its own error paths.
> 
> [...]

Here is the summary with links:
  - [01/18] xfrm: cleanup error path in xfrm_add_policy()
    https://git.kernel.org/netdev/net-next/c/a77d172177f3
  - [02/18] xfrm: Reject excessive values for XFRMA_TFCPAD
    https://git.kernel.org/netdev/net-next/c/41c4d3b26f5e
  - [03/18] xfrm: remove redundant assignments
    https://git.kernel.org/netdev/net-next/c/440bf355d32e
  - [04/18] xfrm: add extack to xfrm_init_state
    https://git.kernel.org/netdev/net-next/c/231a1744dc43
  - [05/18] xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
    https://git.kernel.org/netdev/net-next/c/b8addb8884f2
  - [06/18] xfrm: fix NAT-related field inheritance in SA migration
    https://git.kernel.org/netdev/net-next/c/364e165e0b63
  - [07/18] xfrm: rename reqid in xfrm_migrate
    https://git.kernel.org/netdev/net-next/c/e2e92714d081
  - [08/18] xfrm: split xfrm_state_migrate into create and install functions
    https://git.kernel.org/netdev/net-next/c/8de53883a4bf
  - [09/18] xfrm: check family before comparing addresses in migrate
    https://git.kernel.org/netdev/net-next/c/b2cb192b95e5
  - [10/18] xfrm: add state synchronization after migration
    https://git.kernel.org/netdev/net-next/c/bac7a60e2678
  - [11/18] xfrm: add error messages to state migration
    https://git.kernel.org/netdev/net-next/c/15e5d32de6bf
  - [12/18] xfrm: move encap and xuo into struct xfrm_migrate
    https://git.kernel.org/netdev/net-next/c/1d97daee3038
  - [13/18] xfrm: refactor XFRMA_MTIMER_THRESH validation into a helper
    https://git.kernel.org/netdev/net-next/c/92550d30c69b
  - [14/18] xfrm: extract address family and selector validation helpers
    https://git.kernel.org/netdev/net-next/c/38d400e5d0fd
  - [15/18] xfrm: make xfrm_dev_state_add xuo parameter const
    https://git.kernel.org/netdev/net-next/c/8eed5ba25734
  - [16/18] xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
    https://git.kernel.org/netdev/net-next/c/a9d155ea9b44
  - [17/18] xfrm: restrict netlink attributes for XFRM_MSG_MIGRATE_STATE
    https://git.kernel.org/netdev/net-next/c/c4460171d78a
  - [18/18] xfrm: add documentation for XFRM_MSG_MIGRATE_STATE
    https://git.kernel.org/netdev/net-next/c/c13c0cc6f52e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



