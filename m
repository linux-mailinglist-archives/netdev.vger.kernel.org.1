Return-Path: <netdev+bounces-268090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO78LrzVt2kwWAEAu9opvQ
	(envelope-from <netdev+bounces-268090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:04:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58287297A30
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 705063024A02
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 09:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A82382362;
	Mon, 16 Mar 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="MmG2+Vei"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569D7355819
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655079; cv=none; b=JhDNNzshlDa5v9cPOmBj/Vy/ramMrzP+yTBm/bBPoLf2uAWyEpPI67kff+2oeamW0l9zqYxnHN5go72IenYr1UBgQwzoHjIS7U6d1O0ozK1/bwkCg6DL1xz8krdKwuihKR50Ubnh9Nk7s9kxZhU2504cHt/BsajvkzUIaqv4ke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655079; c=relaxed/simple;
	bh=OsGFfDpdyi/QO5me7Da9Y0yywnB4xiDwhutxZmtcFWM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzk+rR9olQ038gMPPvuf4XFrZtsVyWjgeYRstp5ouAhiIQUaz5HBKxl59OAMPS6ySSLdEP63DU0OaVepkUobjW1fm4aAi29NEeo6JjazAuZubPSg4+XReG/3jIi2lbi4kvIs1+aZ4gjNDNn0LV2A6IT1QvMf4vUMGKy3a+Kgqdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=MmG2+Vei; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D702E204D9;
	Mon, 16 Mar 2026 10:57:47 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id puRbF-RS-6q0; Mon, 16 Mar 2026 10:57:47 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 53B6A201A7;
	Mon, 16 Mar 2026 10:57:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 53B6A201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773655067;
	bh=KcOHQ4Y3EI+ZDtyV/xhVV4Omx8Y2RUfIycVVFFNOc64=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=MmG2+Veigk3kgOH+GhdTdA0gzf/XYNVD1hSUESgPHOp5uUXPu0fpiWm0skAnvEjGX
	 Gdo2lVNkHCSGMjM9aL0KDe5XIzO4KZzhLpo0Gsj+nCvlKr5EtAOP4qkOk4C3ZqKJoq
	 UDONw5gXrshRmkp9AF7vUHSmklvUMsPcXvktN62rHNMJFJJumz9QRSPb8tUSQDWExw
	 RqOgCZYOXmNAvsl5PcCS8BIvM/pgSdSyL8fQHAmeJIVKL+gP1GNfbtjM7+K9ogvRa9
	 HHt8HIzERfK+MKZ/YLPMZKCvCVbiCuYXsfh/QF0wvX3GuXx0CLxMz+fpMORI2GmcC8
	 wRLYU32fB2Rrw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 10:57:46 +0100
Received: (nullmailer pid 783978 invoked by uid 1000);
	Mon, 16 Mar 2026 09:57:45 -0000
Date: Mon, 16 Mar 2026 10:57:45 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: Fix work re-schedule after cancel in
 xfrm_nat_keepalive_net_fini()
Message-ID: <abfUGf-GvWLfGqjG@secunet.com>
References: <abBf_R81PYmafhWv@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abBf_R81PYmafhWv@v4bel>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268090-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:mid];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 58287297A30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 03:16:29AM +0900, Hyunwoo Kim wrote:
> After cancel_delayed_work_sync() is called from
> xfrm_nat_keepalive_net_fini(), xfrm_state_fini() flushes remaining
> states via __xfrm_state_delete(), which calls
> xfrm_nat_keepalive_state_updated() to re-schedule nat_keepalive_work.
> 
> The following is a simple race scenario:
> 
>            cpu0                             cpu1
> 
> cleanup_net() [Round 1]
>   ops_undo_list()
>     xfrm_net_exit()
>       xfrm_nat_keepalive_net_fini()
>         cancel_delayed_work_sync(nat_keepalive_work);
>       xfrm_state_fini()
>         xfrm_state_flush()
>           xfrm_state_delete(x)
>             __xfrm_state_delete(x)
>               xfrm_nat_keepalive_state_updated(x)
>                 schedule_delayed_work(nat_keepalive_work);
>   rcu_barrier();
>   net_complete_free();
>   net_passive_dec(net);
>     llist_add(&net->defer_free_list, &defer_free_list);
> 
> cleanup_net() [Round 2]
>   rcu_barrier();
>   net_complete_free()
>     kmem_cache_free(net_cachep, net);
>                                      nat_keepalive_work()
>                                        // on freed net
> 
> To prevent this, cancel_delayed_work_sync() is replaced with
> disable_delayed_work_sync().
> 
> Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Applied, thanks a lot!

