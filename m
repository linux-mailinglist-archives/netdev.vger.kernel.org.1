Return-Path: <netdev+bounces-298813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OQhoAy2ULGrjTAQAu9opvQ
	(envelope-from <netdev+bounces-298813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:20:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D9D67D07F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:20:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="HF/c224/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298813-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298813-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E108C30ACA26
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EC93890E7;
	Fri, 12 Jun 2026 23:20:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3623644C6;
	Fri, 12 Jun 2026 23:20:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781306410; cv=none; b=XAW4AGWocx3tgIsh2DUYS3Uz/XAeHiU2lr7NXVY37YYC5Be4GN0+Z3Th9roZvgegnKKClQgPRUufy5vkzxabyTGg6OXILUxqdlmFYR0yuu8NSk06McvayeKGAB3ClXcfDMA1QISHwqz/7f7oC6Vn4XcM8xlxjomuUm708qn1YjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781306410; c=relaxed/simple;
	bh=tvQw45qsskbgDSUvCYtgumFBdlExqh0eEEDPwilRRfw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ljtpdPzYMa7MGB+azW9UW5emi6Cd/wKNE68dEhUA6mlVCXI17Pe4nK//dM81+oWBut8vzuv7+/fsipwU03QFcFcsdSwfRc4kRSrW0fpEPfJmzOuHc14iKnL2ByvWxoYSTRpm4k3jCYbxS1HfIQnvhgXjDwFymy3Z22K00ByNDOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF/c224/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F6E1F000E9;
	Fri, 12 Jun 2026 23:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781306408;
	bh=/Zj5QSWL28w/NEVx93SEz1kBpK/lIrdznOIRHCEw+Kw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HF/c224/cXYM1sOu8szgK7OQKl7Dzw0zlCPpW17EaLOXkncLsJ6fY3sXbGI8/gqvL
	 wJ2p+6QKMQAn7n4fG/n+N0Iq9SOAghmKc2AtUdRg2BUpa6bNA3TsMes/EqnWFkGV2q
	 TYqLZ9TnNTsDKGEedsv/+G/vfyOGmu8FYfCx4K+T++XRgpMVjf78A5pOkVxS7nJy6Z
	 HZ/EbsiiKio1sIQerb/F+POqcld5NbNNj6AITenE/ZMO+fee/Hy2xADpEodwQnecDw
	 90NOHitU64PQSwZWKaXIHVtQPnXya7NhKZ2EqUD2dZ45/rDT2iSVQjmWQBGTVqa5WI
	 f5CQ1Adz6mWvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A8F39E9601;
	Fri, 12 Jun 2026 23:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnxt: fix head underflow on XDP head-grow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130640539.1287691.17272459611021895737.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:20:05 +0000
References: <20260609204458.2237787-2-joe@dama.to>
In-Reply-To: <20260609204458.2237787-2-joe@dama.to>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, andrew.gospodarek@broadcom.com, somnath.kotur@broadcom.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-298813-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joe@dama.to,m:netdev@vger.kernel.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrew.gospodarek@broadcom.com,m:somnath.kotur@broadcom.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46D9D67D07F

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 13:44:58 -0700 you wrote:
> The xdp.py test test_xdp_native_adjst_head_grow_data crashes when run on
> a bnxt machine (and also crashes in NIPA).
> 
> It seems that the bug is an underflow in bnxt_rx_multi_page_skb, which
> builds the skb head:
> 
>   napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
> 
> [...]

Here is the summary with links:
  - [net,v2] bnxt: fix head underflow on XDP head-grow
    https://git.kernel.org/netdev/net/c/e26657fe3b85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



