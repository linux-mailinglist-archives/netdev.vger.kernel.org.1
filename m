Return-Path: <netdev+bounces-295784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RbS+LzKuImpBcAEAu9opvQ
	(envelope-from <netdev+bounces-295784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:08:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F066479EE
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:08:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=KmBtNZci;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295784-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295784-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0617C300AB1F
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 11:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0D44C9566;
	Fri,  5 Jun 2026 11:01:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED0F4C957C;
	Fri,  5 Jun 2026 11:01:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657287; cv=none; b=OTJ1fPOFLrEnnfVw2Sl8j78bzCZD+DjnbJ+WO5dtGKlGRzkWIKhlCb9fKaxZEbQ+NaighfOKdkMwRotF308pNvGZBc9ipa9GmI7Jp5m1jJci8n2dlWTZQncuDjfuhha5VGGtiWkm2pFdxYBgA1TtU7Kq97lXxamOOj6ssK5Mfc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657287; c=relaxed/simple;
	bh=Fpder4Oqfjab6/4yXfhZeahA4vZPdzpytTMCaPoOdrY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/GfIlaW2jcVd9Ew4hiwylg4A4NWKUGOR2lil8ERk72j8SYXGdAtqiSi/ndkMXaXM5Q3EGsDTC5gQ+CGPoyMxDTPp6Z5caDi/7D5kxh1mRxTjVuFQoI2ScQHaUzzQXRs9B0MQ+V7Qv3vliypX6BrZbHMJ8L6j2OLQD7OPO6YWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=KmBtNZci; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3381E207D1;
	Fri,  5 Jun 2026 13:01:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09y2bkjk5gqY; Fri,  5 Jun 2026 13:01:20 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id AA71F206E9;
	Fri,  5 Jun 2026 13:01:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com AA71F206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780657280;
	bh=2Dpu3VkkL2dO3C0UjTy+rBEp9kalyuZmtSFDJSeUToY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=KmBtNZci16HjA8KTn8p0VBOX2PMsB9LLdmLu3sYXpaBpuw9rgcAFLJk2TD4dLndEa
	 XJfv1AZRIQX/1U1Q7Uojw70hlguQafHfPhHTmY8QB8d+owSX8Ss2eQtD1llkVq4aF+
	 0LmXOypeFaIR2gxdgxIBFCQ9XWCOzsK/tLsXlg9ixWMHHEn4SFTv7yzEwkCKUDNS5G
	 DEU/LlJ85kB7UebYH9sZMMgkoI1mUI+Il5avdGAdZnqDCIp0oGHoX0dDhlDYhaPZNE
	 rilZJryHldHY4zP6s0OhYh6jLJoDfYz7U9CxmsQVdgvk2rLgJHTZ0Qykb5M0L+HFh5
	 /8YCgpXi7/GRw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 5 Jun
 2026 13:01:19 +0200
Received: (nullmailer pid 365645 invoked by uid 1000);
	Fri, 05 Jun 2026 11:01:18 -0000
Date: Fri, 5 Jun 2026 13:01:18 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
CC: <fw@strlen.de>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] xfrm: policy: fix use-after-free on inexact bin in
 xfrm_policy_bysel_ctx()
Message-ID: <aiKsfiLFPGBFJECs@secunet.com>
References: <20260602094908.2194262-1-sanghyun.park.cnu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260602094908.2194262-1-sanghyun.park.cnu@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295784-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,secunet.com:mid,secunet.com:from_mime,secunet.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sanghyun.park.cnu@gmail.com,m:fw@strlen.de,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sanghyunparkcnu@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12F066479EE

On Tue, Jun 02, 2026 at 06:49:05PM +0900, Sanghyun Park wrote:
> Fix the race by pruning the bin while still holding xfrm_policy_lock,
> before dropping it. Use __xfrm_policy_inexact_prune_bin() directly since
> the lock is already held. The wrapper xfrm_policy_inexact_prune_bin()
> becomes unused and is removed.
> 
> Race:
> 
>   CPU0 (XFRM_MSG_DELPOLICY)           CPU1 (XFRM_MSG_NEWSPDINFO)
>   ==========================          ==========================
>   xfrm_policy_bysel_ctx():
>     spin_lock_bh(xfrm_policy_lock)
>     bin = xfrm_policy_inexact_lookup()
>     __xfrm_policy_unlink(pol)
>     spin_unlock_bh(xfrm_policy_lock)
>     xfrm_policy_kill(ret)
>     // wide window, lock not held
>                                        xfrm_hash_rebuild():
>                                          spin_lock_bh(xfrm_policy_lock)
>                                          __xfrm_policy_inexact_flush():
>                                            kfree_rcu(bin)  // bin freed
>                                          spin_unlock_bh(xfrm_policy_lock)
>     xfrm_policy_inexact_prune_bin(bin)
>     // UAF: bin is freed
> 
> Fixes: 6be3b0db6db8 ("xfrm: policy: add inexact policy search tree infrastructure")
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>

Applied, thanks a lot!

