Return-Path: <netdev+bounces-299663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DjvsLGqNMGpkUQUAu9opvQ
	(envelope-from <netdev+bounces-299663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:40:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD2968A9C5
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:40:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AEoY0qeQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299663-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299663-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8064306B7C7
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6F5340403;
	Mon, 15 Jun 2026 23:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28B2FFFB5;
	Mon, 15 Jun 2026 23:40:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566823; cv=none; b=VYDNtD58scE2IrJO3PjLUSEm85rv4aQR/l/PQy7L6db6/5moBboJY3+D6jz7p12v/e1UOWHvJ7gFWF2rGDyR1rtE8LX3eyHkrbSJ9wddf8t8eel3kYN2h4m/vLnP00+59XD1Fq9BWPwlveXgva3ZtCAypT6XQcf5juc0Z57zTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566823; c=relaxed/simple;
	bh=HHdUfbaEjQ41R9T6Q1Qd+ec2nt8+WSsNqfTCq1pmptU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bw+amFtcZeY17XtV72n2AcUde3HF3xtEzD0sHin4nBiJ4u0k1PNWEwDSPI35Sa6TJkAfuylSeusG52+zPJ+pKlZUbk1Rvr6zeiZ4y3BENJzumB04Y4PkV6fT25Br0EaN4Jg3aPcsV25Q/q5rDuT/is/xbuDamKqL2siLpnl4g/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEoY0qeQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67BD1F000E9;
	Mon, 15 Jun 2026 23:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566821;
	bh=WzzZkl0ITKGF+e89UCTNrQ3QOTm2s+mNTX72P5uC134=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AEoY0qeQ6ryZxCtIx8/jTZzyAqawRslLOub3uUTkYMX0kiicXnwmjkT+oK4NhxzGF
	 EQ7Clm9X03BRFRHtMMxlM12FqgogeM39l96olju/Cz3JSbq8H5FNB4szo83f3KRRmi
	 WN6VVVLB5Fhyabn0d/I+19gDZa5dP7kYodSIveQNLNuB+qkBgdk0BBbmfxAF2NsUOJ
	 hc77OMZA8O8rRqOM93gqmpdoz8C9v91aJxCYGRGVDmic4JX5fnlASBDdbMweeq4K9z
	 ordxeihikraCNS9LC7EHq/7Fp5KucgMJ0OMp4WF39JJpsxxH3u81TyBzcFpPNUxOy/
	 d08IJJQWk/7pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198093839A08;
	Mon, 15 Jun 2026 23:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] ICSSG XDP zero copy bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156681669.339383.12184092559832097375.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 23:40:16 +0000
References: <20260611185744.2498070-1-m-malladi@ti.com>
In-Reply-To: <20260611185744.2498070-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: diogo.ivo@siemens.com, haokexin@gmail.com, vadim.fedorenko@linux.dev,
 devnexen@gmail.com, horms@kernel.org, jacob.e.keller@intel.com,
 sdf@fomichev.me, john.fastabend@gmail.com, hawk@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org, danishanwar@ti.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[siemens.com,gmail.com,linux.dev,kernel.org,intel.com,fomichev.me,iogearbox.net,redhat.com,google.com,davemloft.net,lunn.ch,vger.kernel.org,lists.infradead.org,ti.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299663-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:m-malladi@ti.com,m:diogo.ivo@siemens.com,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:sdf@fomichev.me,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:srk@ti.com,m:vigneshr@ti.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AD2968A9C5

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 00:27:40 +0530 you wrote:
> This patch series fixes bugs introduced while adding xdp
> zero copy support in the icssg driver.
> 
> Patch 1/4: Fix wakeup handling for Rx when available CPPI
> descriptor is zero
> Patch 2,3/4: Fix destination tag in CPPI descriptor to enable
> proper Tx xmit for HSR offload mode with XDP and zero copy
> Patch 4/4: Fix Tx copy wakeup handling for XDP zero copy
> 
> [...]

Here is the summary with links:
  - [net,1/4] net: ti: icssg-prueth: Fix AF_XDP fill ring alloc and wakeup condition
    https://git.kernel.org/netdev/net/c/dfb787f7d157
  - [net,2/4] net: ti: icssg: Use undirected TX tag for native XDP in HSR offload mode
    https://git.kernel.org/netdev/net/c/bcbf73d98195
  - [net,3/4] net: ti: icssg: Use undirected TX tag for XDP zero copy in HSR offload mode
    https://git.kernel.org/netdev/net/c/f9691288413c
  - [net,4/4] net: ti: icssg: Fix XSK zero copy TX during application wakeup
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



