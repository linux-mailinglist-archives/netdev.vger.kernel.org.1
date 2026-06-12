Return-Path: <netdev+bounces-298814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mhtFHFmULGruTAQAu9opvQ
	(envelope-from <netdev+bounces-298814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:20:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF2467D093
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:20:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iLElf77Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298814-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298814-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A4A630B8F02
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6399C3AD500;
	Fri, 12 Jun 2026 23:20:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF43644C6;
	Fri, 12 Jun 2026 23:20:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781306415; cv=none; b=h0BXaPvfhdzjVb3vuoqm2hm6ufT5j8TZiE/rbMLTUPd5CuRdGTxf5X0EsBetzgLu54dodBu59tLWiMTMCzcuNQeWfiuDNKE/YPC05bRE4uIdl/kHc/Ue1kZPcgHDnbwtIUbKRms8LeR+wqiHe5WdkPztJt+ZAa6zWu+YyW7Ve/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781306415; c=relaxed/simple;
	bh=se+Brg3iZu5ZDrzfwlW+igux18U7p0I3qdK4R1T2E2s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bw38H/fBhHetSaWopC06RDdDLbgoUNfL5q3QCUJOl/yr7vVcT/nh1PFohaPdQAhb3P/sRuoYJXW7rOuVRgU/IFXRYLXMfFzgU+mVGebY1n1NHSsLQlY0+lRgMsruHpFK9M36e5Cmd3B938JbcKHrgh3/qFaA6pjLCBMlqbzysqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLElf77Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4301F000E9;
	Fri, 12 Jun 2026 23:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781306414;
	bh=LCbQ8yvIig1Ed/P0kwB2fXLSkVMGX7ng/sfDKoyIOD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iLElf77ZHH4L4GkvxBI+YFu40wsnzSyyNNGwD15EtloG8tezDUBi1FXlkKSpjzmkF
	 7JltrAFTQvU2J7HhlqCWwW76kA42eL6IOXCTH6aKcyU3M3qHDgUk10mU1Zw6K6dzVD
	 xbf8n7NHTV/ehpv+AJoJjHKnRF6YHztpgUc+PmO8FPm9J8iKNQ9S2x4gNbrDHGe2QU
	 e+Uo0hb2dSybAMn5DbiSAVmAp/IAWHg/9SVhGTVIExsdQH5S149quFWS1gUHymLCvg
	 zxC+G0pUC/0gHkUsQ3DxiTnm3Z2/P8DTUDZIixo/KKulZjYR0ovrg8V5oL509iNZVJ
	 vOP6v+SXlbk8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196ED39E9601;
	Fri, 12 Jun 2026 23:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] docs: net: more adjustments to docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130641063.1287691.4628986985390612274.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:20:10 +0000
References: <20260609201224.1191391-1-kuba@kernel.org>
In-Reply-To: <20260609201224.1191391-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298814-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:linux-doc@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAF2467D093

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 13:12:21 -0700 you wrote:
> A few small updates to the docs. Mostly typos this time.
> This is trying to prepare docs for getting fed directly
> into AI reviews.
> 
> Jakub Kicinski (3):
>   docs: net: fix minor issues with XDP metadata docs
>   docs: net: tls-offload: document tls_dev_del, tls_dev_resync, and
>     rekey
>   docs: net: fix minor issues with devlink docs
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] docs: net: fix minor issues with XDP metadata docs
    https://git.kernel.org/netdev/net-next/c/6213cf54adad
  - [net-next,2/3] docs: net: tls-offload: document tls_dev_del, tls_dev_resync, and rekey
    (no matching commit)
  - [net-next,3/3] docs: net: fix minor issues with devlink docs
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



