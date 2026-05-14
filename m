Return-Path: <netdev+bounces-287816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOgWA09VBWqAVAIAu9opvQ
	(envelope-from <netdev+bounces-287816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 06:53:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB42A53DC4E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 06:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32FB13036E70
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273C33B6347;
	Thu, 14 May 2026 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="BKwOS3+C"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33D3B7B98
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 04:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734410; cv=none; b=TLF51uhncEUTH0C3MrHju2R9qfpysy1Sunkv/JGNqo87tQ90mETb/Fie4N36XWlj/+WrENo8IH5fC7aNvUzJcoq17qCOpoaI9WA+pyOhWOCjRbFqiU9zxMHG2IxxUmN1AQAS+bqz1kDDOh8KLrrtwHKWGcJdAsaH/yM12wQvjM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734410; c=relaxed/simple;
	bh=TBasVBtl4YDvRvrYf10bEMt5/K81Tc3CArZvvHAPV8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGgZeQ4lKjaX+QGNoSedSXynoMjS2QcUNSnyHoExjf3K4tOoEKy5GmNTN4txNKOl6EJzQaez9nIUwoiklyr2xAttG3Jt1l1bSeDDwHYmm9FHyFYBnflMJ5hjEK++t0vtG6jHfpOmiCjKkIo+vFi+8epac3MKR8yPfqBtCdAOZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=BKwOS3+C; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=7N8YT99TfR/1x81R/DSiDayVSyQH3Rhupn6pkMHesq4=; 
	b=BKwOS3+CfvEBOhhBbLccGqe+NaICLCrNBzmWa4Jt6MMZVivnNFq46pZHwJQhkKiiDwSl1LOS2Uo
	uxD1ejudoKHSQgS9V3+ROI7bnScPcCuoxSPIPoXhzI/Ip08qmcVFJni5bTSb++k3uWLXNagIaIL9T
	Fkx3Yfb5bkW6E45g4ARu8imzFSGNNcm2Z5hdq+zlVJ7vly/l2463f0g+q629VctAgA3veEQlubG+0
	Jz2RH0NWBmXHS6/ut7kF/OmQP0yXj8LNpgohri5hMsK6swhkiu37bHH1u5QvBGOfKI4BrNFMTW7J2
	f6DWOO47cyzEbdARcw194VtTpPmmUd+UkxzA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wNO4J-00E1ck-0V;
	Thu, 14 May 2026 12:53:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 14 May 2026 12:53:07 +0800
Date: Thu, 14 May 2026 12:53:07 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: steffen.klassert@secunet.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	tpluszz77@gmail.com, netdev@vger.kernel.org,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net] net: xfrm: Fix dev refcnt leak in async resumption
Message-ID: <agVVM1ArZMFS4bl4@gondor.apana.org.au>
References: <20260509074443.104163-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509074443.104163-1-dongchenchen2@huawei.com>
X-Rspamd-Queue-Id: BB42A53DC4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FREEMAIL_CC(0.00)[secunet.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287816-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,apana.org.au:email,apana.org.au:url]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 03:44:43PM +0800, Dong Chenchen wrote:
> xfrm async resumption hold dev ref until after transport_finish.
> When afinfo is NULL (e.g. x->props.family is invalid) and xfrm_gro
> is not set, dev_put in transport_finish() and xfrm_gro path is skipped.
> This will trigger refcnt leak.

There should never be a an xfrm_state with a NULL afinfo.

That would be a serious bug.

How did you trigger this?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

