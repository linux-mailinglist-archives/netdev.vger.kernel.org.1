Return-Path: <netdev+bounces-299005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t1ANMVaYLWpAhwQAu9opvQ
	(envelope-from <netdev+bounces-299005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:50:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFCB67F3AD
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 19:50:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bwnTkOWt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299005-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299005-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E6A83023349
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52FF21773D;
	Sat, 13 Jun 2026 17:50:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897713D891;
	Sat, 13 Jun 2026 17:50:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781373010; cv=none; b=TH3neXnekK+PX/wqExdro1YBgTeBjRr9iocDPKZ2Dr6WqdcXvrxoKTfTQ0zGK/ofJQG6vB95ibiHdsjtDw0vE8/CQsU1X7dBD9NBZy13SzQ9T7dBz5kQ33rUFW79L4Sdgg2itgBY3JnyqZ024Z/KBscfUT5+rVtnH7gJOKtwLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781373010; c=relaxed/simple;
	bh=BtvfR3DbGdHisefM4lH9IR40L7buuRm1UvuBzGnxNZ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hrtkH8/jYk8RfBZEzlE8rmiQ9jffk/A1dqA1HzwRlxeLZtAZN5kRgyWcZLu1PtF7kRbItExT/Q12nDcqGu8W1gb5K2S1pJrJhT6/SbyYebJSM/QtmOUUVvDcWSO1lxhr2GdLcwJyqAopaXknK8YJUdyATf4eUdbtKMymhQOiBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwnTkOWt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642521F000E9;
	Sat, 13 Jun 2026 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781373009;
	bh=EXdXTzkLAaFiG05TlUnjmzkDsg/Mt4NakHNRItwhcDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bwnTkOWtdaEOhcrhv00UWUNPuvirGVzdEPnnzecR/HBUE61pKdRich2wyQHkKswmY
	 bGjZgRhwSLbCsOfWkuu3gwmNm65GktGqjw4SOelg0vjBD+fUMeo78eyk2YhWCwSFao
	 rL/KWVrTRpFLAP9r1WF93hKbglav1o+uWcSw/O8BvM5299nT4wXWUrFAkKFLH7AxnP
	 5dW44ECW9X1IMjTd8oq1CxXXD2dh4EDQ5ka52J0bWZo7UCLkKYF+uRkrvTWmNlf3vd
	 KZIVy2gFP2Q8BeflISYmYLfcdb5ss4ZxFhTLQnRcb1+90IE1iA94UEnD+2laSHI7Yc
	 6jO6LMylWWtzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A5F3A40FD9;
	Sat, 13 Jun 2026 17:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: wwan: t7xx: check skb_clone in control TX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178137300571.1548981.6167640520032704806.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 17:50:05 +0000
References: <20260612035613.1192486-1-ruoyuw560@gmail.com>
In-Reply-To: <20260612035613.1192486-1-ruoyuw560@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: chandrashekar.devegowda@intel.com, haijun.liu@mediatek.com,
 ricardo.martinez@linux.intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,mediatek.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299005-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:chandrashekar.devegowda@intel.com,m:haijun.liu@mediatek.com,m:ricardo.martinez@linux.intel.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BFCB67F3AD

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 11:56:13 +0800 you wrote:
> t7xx_port_ctrl_tx() clones each skb fragment before passing it to the
> port transmit path. The clone is used immediately to set cloned->len, so
> an skb_clone() failure results in a NULL pointer dereference.
> 
> Check the clone before using it. If previous fragments were already
> queued, preserve the driver's existing partial-write behavior by
> returning the number of bytes submitted so far.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: wwan: t7xx: check skb_clone in control TX
    https://git.kernel.org/netdev/net/c/05f789fa90d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



