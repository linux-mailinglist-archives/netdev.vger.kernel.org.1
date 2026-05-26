Return-Path: <netdev+bounces-291643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLgqD5p2FWrHVAcAu9opvQ
	(envelope-from <netdev+bounces-291643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:31:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2855D4352
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D608A3043FEE
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650613DCDBC;
	Tue, 26 May 2026 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="XRBSr1R7"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9933DCDBE;
	Tue, 26 May 2026 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791118; cv=none; b=uANv3fA2MVAtS5EuqGUqHb/GYfnI0J/iuqYWsuIXVWb1HAoA/yobnBw5Ur+jxa5kvzbQGo6Rq2pawGyNcdDt3wwhvg+ZX4yi0kQGbaNpmMIzQKcqvkCA2aUaBDoPErFQZnDBg9bR5FpJADS4qi0VhOAC+sY3uFoVbV5dDBMoYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791118; c=relaxed/simple;
	bh=eYzZozUiIvyoQPCMQVglrEPprFL23l/V5y8hFPN3Ktc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1NLF9ZMFusvZZZBwpzLQubvbl/DUY/ykbHXlJpEmwLSi+Hh9OuqQzVrsga9fujSuZu48rwjv0T16loOcSliU0gX87X1qEPyEyR0nK/DxkW1nrfs5Enk6JNtFamgyg/tyTdebASV0DiL36JNunsXLSPjXSw0GFrRqaPuHNaei3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=XRBSr1R7; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C006D205DD;
	Tue, 26 May 2026 12:25:13 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XMVwZ1bgUEtV; Tue, 26 May 2026 12:25:12 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D553120185;
	Tue, 26 May 2026 12:25:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D553120185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779791112;
	bh=adMD49drfk/iXmqrWpYo5PmtAJwLPy+Vc8USldkTCrQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=XRBSr1R7Vgi1c0uokucoFIUDSlfy7oSSsOLsKjMeOof+cw6Bb7fUr9YxgltU6YOuV
	 6Ft1AGNDY6kkcWWoSgSwZ/wkyp8s6gZtNxXyaWH1j/GggPQzYT618TzOdYGXPGLgyS
	 QSAacDrKDItywJf1yTdoW5DMXhXGJXiv06cEl10EspZe3/I+tb7/FNJyWp1TrY2kIH
	 WN1QZnQ6zURBGwBZI5LMgWepW/wHnfp47GrvuAbpPS3WuXc3WXR7uXDHen1dc5ue7g
	 bALkApCHpakf7Q2X1qv0AQMPtcIeU4pOJGmjxwQTQhf9gFDNQYI7wumUNEfVMAWGXL
	 aDNiU1U7bzfwA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 12:25:11 +0200
Received: (nullmailer pid 224194 invoked by uid 1000);
	Tue, 26 May 2026 10:25:11 -0000
Date: Tue, 26 May 2026 12:25:11 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Usama Arif <usama.arif@linux.dev>
CC: <davem@davemloft.net>, <edumazet@google.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <horms@kernel.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <alexanderduyck@fb.com>, <enewton@meta.com>,
	<vlad.wing@gmail.com>
Subject: Re: [PATCH] xfrm: move policy_bydst RCU sync from per-netns .exit to
 .pre_exit
Message-ID: <ahV1BxasOuDHX7Zy@secunet.com>
References: <20260521102926.2613544-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260521102926.2613544-1-usama.arif@linux.dev>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291643-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,gondor.apana.org.au,kernel.org,vger.kernel.org,redhat.com,fb.com,meta.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,secunet.com:mid,secunet.com:dkim,linux.dev:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AB2855D4352
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:29:26AM -0700, Usama Arif wrote:
> The struct pernet_operations docstring in include/net/net_namespace.h
> explicitly warns against blocking RCU primitives in .exit handlers:
> 
>     Exit methods using blocking RCU primitives, such as
>     synchronize_rcu(), should be implemented via exit_batch.
>     [...]
>     Please, avoid synchronize_rcu() at all, where it's possible.
> 
>     Note that a combination of pre_exit() and exit() can
>     be used, since a synchronize_rcu() is guaranteed between
>     the calls.
> 
> xfrm_policy_fini() violates this: it calls synchronize_rcu() before
> freeing the policy_bydst hash tables (so no RCU reader is mid-
> traversal at free time), but runs from xfrm_net_ops.exit -- once per
> namespace -- so a cleanup_net() of N namespaces pays N full RCU
> grace periods serially.
> 
> Use the documented pre_exit/exit split. Move the policy flush (and
> the workqueue drains it depends on) into a new .pre_exit handler;
> xfrm_policy_fini() then runs in .exit and frees the hash tables
> after the synchronize_rcu_expedited() that cleanup_net() guarantees
> between the two phases. Providing O(1) RCU grace periods per batch
> instead of O(N).
> 
> Observed on Linux 6.18 with a workload doing unshare(CLONE_NEWNET)
> at ~13/sec sustained: cleanup_net() and the netns_wq rescuer kthread
> both stuck in xfrm_policy_fini()'s synchronize_rcu(), >300k struct
> net accumulated in the cleanup queue, Percpu in /proc/meminfo climbed
> to 130+ GB on 256-CPU hosts, and memcg OOMs followed. setup_net and
> __put_net counts were balanced, ruling out a refcount leak.
> 
> Fixes: 069daad4f2ae ("xfrm: Wait for RCU readers during policy netns exit")
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Applied, thanks Usama!

