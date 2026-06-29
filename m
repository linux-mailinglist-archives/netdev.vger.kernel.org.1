Return-Path: <netdev+bounces-302573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 05KDAIZVQmrJ4wkAu9opvQ
	(envelope-from <netdev+bounces-302573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:22:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 465616D955B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:22:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=odltRhtO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302573-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302573-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27D05303DA81
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79323B584F;
	Mon, 29 Jun 2026 11:17:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E953A1695;
	Mon, 29 Jun 2026 11:17:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731867; cv=none; b=b6/G1ZlxXCBCrJy8zoMbH/Gm/8FTh2ZD5fW3v94VUeeK+NTrIyVxwli1l1dfLTD0ou+K3WatZrMZfLUF7Pqod+pCt81ete+eIESMHkSY32BlzNpH0cnbbPiUe2c0OOBqxJSHTYMoYn4d7+4vF4WJjdmfl+ZN/puHdPRXB1+yWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731867; c=relaxed/simple;
	bh=yvQCF02nOs4BwiTI6NlwD65z73LZosYs/rmUKX2BDdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPEn1W6hn+ml7C459LRWh6yPoMiMugukrBBseEtLoIGimGExTtEEJNc2YqG39QSc8AX9WJDNowqHU5/aGMLjBBiOX2LzK+cFUGf0ldwzT3uAyTNQTrrpMrcfVCNVtEmmgawTomLq841SgM/W4R4CMjhRGfzWHdrrXZVsN0jxzWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=odltRhtO; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SUQBEhu95eP3EjuCD6GRz1PTTIH0/hJSv8az7XVCww0=; b=odltRhtOKEBBtuOWMdiunwps1D
	rCdbKB6BR8/rOutJ9G3Slg3Nw9Pr3mzQq1e/HQ7K69XFApKQ/DwQwB/cU3gDeb8/TgQTD7PYHElFx
	3VwMoXH2eGA7NB/nZFk0v374ArwN4+v7MIQBKWTIJ0O3Lvhm46V2xBs6w7SYP73GRs0l8cxqvYuDZ
	/i2LiSWn2T9BWP9/cFLLgJ40oopJNbfSxa6rWbKfbZOzHofNSHQg3XdNm/iK8AguCW+OxMeVgeSx5
	BLTJFMTsjjyc9lQIXq+0VHQy+LDLmma6sNixvPhG/HfudbYwxNRpd2UrIM6tv4uif2ruSsU4H9Vg2
	QA3JvwUA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1we9zJ-006Fj9-0g;
	Mon, 29 Jun 2026 11:17:17 +0000
Date: Mon, 29 Jun 2026 04:17:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Jakub Kicinski <kuba@kernel.org>, davem <davem@davemloft.net>, 
	edumazet <edumazet@google.com>, pabeni <pabeni@redhat.com>, horms <horms@kernel.org>, 
	sashal <sashal@kernel.org>, bigeasy <bigeasy@linutronix.de>, netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, "jianhao.xu" <jianhao.xu@seu.edu.cn>
Subject: Re: [RFC PATCH net-next] netpoll: hold RCU while walking napi_list
Message-ID: <akJSi1g0F2k9a3cs@gmail.com>
References: <20260627101228.1191586-1-runyu.xiao@seu.edu.cn>
 <20260627142105.29f1322c@kernel.org>
 <AFEAtADoKs22QyipHhKwe4op.3.1782623057057.Hmail.220255722@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AFEAtADoKs22QyipHhKwe4op.3.1782623057057.Hmail.220255722@seu.edu.cn>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302573-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:sashal@kernel.org,m:bigeasy@linutronix.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 465616D955B

Hello,

On Sun, Jun 28, 2026 at 01:04:17PM +0800, Runyu Xiao wrote:
> Hi,
> 
> On Sat, 27 Jun 2026 14:21:05 -0700 Jakub Kicinski wrote:
> &gt; Please provide the stack trace from the report, rather than just saying
> &gt; that you can trigger it.

I am really suprised to see this warning. I've been runing this code with
CONFIG_PROVE_RCU_LIST for ages, and I haven't seen anything similar.

> Sure, sorry for not including it in the RFC.  The warning was from the
> reviewed reproducer used for the CONFIG_PROVE_RCU_LIST triage, not from
> a production crash.  The relevant part of the dmesg is:

Reading it, it does not come from the kernel's netpoll code at
all -- it comes from an out-of-tree module (!?)

>   WARNING: suspicious RCU usage
>   6.1.66 #3 Tainted: G           O
>   -----------------------------
>   /home/ubuntu22/msv_workspace/shared/vuln_msv.c:45 RCU-list traversed in non-reader section!!
> 
>   other info that might help us debug this:
> 
>   rcu_scheduler_active = 2, debug_locks = 1
>   no locks held by insmod/190.
> 
>   stack backtrace:
>   CPU: 1 PID: 190 Comm: insmod Tainted: G           O       6.1.66 #3

Have you tested it on a more modern kernel?

>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>   Call Trace:
>    <task>
>    dump_stack_lvl+0x45/0x5d
>    lockdep_rcu_suspicious.cold+0x2d/0x64
>    poll_napi.constprop.0+0x43/0x71 [vuln_msv]
>    netpoll_poll_dev.constprop.0+0x27/0x36 [vuln_msv]
>    ? 0xffffffffc0005000
>    rcu_list_msv_init+0xe2/0x1000 [vuln_msv]

What is `vuln_msv` exactly?

Could you reproduce this from an in-kernel path instead -- a real
netpoll/netconsole/bonding caller, with the frames resolving to the kernel
rather than [vuln_msv]?

Meanwhile, NAK until the above is clarified

--
pw-bot: rejected

