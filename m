Return-Path: <netdev+bounces-295558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l9SQOjApImpMTQEAu9opvQ
	(envelope-from <netdev+bounces-295558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:41:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 582B7644785
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:41:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ayTrYNFn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295558-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295558-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10A22303CC51
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C253E0251;
	Fri,  5 Jun 2026 01:40:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8813BB115;
	Fri,  5 Jun 2026 01:40:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623629; cv=none; b=IRyubIssrCWIq2Hii+6/ywrq10+EHDCH2jgk0CCcp5a4CBbKfoywgnJYOp5nHNqS16p+kUwcqrM+8vZVLqtaWVgWBAf+6aex3H2TvA/die4a77exAg4nv1Utx8mNX6NT8Nc6JZctV3X76II9ZkPfvW3yX+FI/vUU9y465f+x6Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623629; c=relaxed/simple;
	bh=Bk6KSh7osoOSa9v7pIwPsBtyBiM+c5iUa9g7bgdIFU4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kMyJrpBKosy5TDrhvVjZfrvoG9l7FE8+S/9PFBfJ90Df+lFXffDVUCOHJ4t2jyDmpiFSKeuksK1KHbAbDeUuKFFmx2TZ1TL6qTnghZ5z1EHtRt6Jaw0JdsxtnmMYKEmNceMnvNilJVVx5MOjuY8qdH0oE5htWyxcITif4uEHjk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayTrYNFn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE7A1F00899;
	Fri,  5 Jun 2026 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623619;
	bh=Vd0i8CUiFT34w88Wld/l9sYADsxEvf7jzRAB2oygGEY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ayTrYNFn4+DYyhi9hYSAvl5plS/d59sbBnLgGhcwfdCG01gLKPNDU9zkGsSsl9g9w
	 wBdmsx1P6w7oDAADKcW/TsDHC1q3URI06DTsahbO4xsZlPLyfHl6rxYLLa4JcMj8gz
	 l3VHYeMGaRjo15JUgsut9pq9+zl40kADf/CIXsf4saECwxPQ155I51+7cFGSEK3vJq
	 zYP+fVPPDSRF+UKxniUWijCfQqX/k2JcoXqqaet0ClGppO7raJ+uHW+booJkE+MMSl
	 LwqGa6erE3pPjjZeKuxM7NP04nAoIegu34FXcruGytj7qm6brdtP1xVI+4YpqL0whS
	 L/+0mkKbFab+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C933930A8B;
	Fri,  5 Jun 2026 01:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af: kpu: Default profile updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062361939.3097022.1256558950193949841.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:40:19 +0000
References: <20260602040535.3975769-1-nshettyj@marvell.com>
In-Reply-To: <20260602040535.3975769-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, kirankumark@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rkannoth@marvell.com, sumang@marvell.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295558-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:nshettyj@marvell.com,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:kirankumark@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rkannoth@marvell.com,m:sumang@marvell.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 582B7644785

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 2 Jun 2026 09:35:25 +0530 you wrote:
> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> Add support for parsing the following:
> 1. fabric path header
> 2. tpids 0x88a8, 0x9100 and 0x9200 parsing for
>    first pass and second pass packets
> 3. parse stacked VLANs
> 4. RoCEv2 header with UDP destination port 4791
> 5. single SBTAG parsing
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: kpu: Default profile updates
    https://git.kernel.org/netdev/net-next/c/0416f7b35458

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



