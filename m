Return-Path: <netdev+bounces-300333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uIUOHQOdM2oZEQYAu9opvQ
	(envelope-from <netdev+bounces-300333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:23:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B94E569E0E6
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:23:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=CaO8bwlv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300333-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300333-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E251300BD9F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9DA3C4548;
	Thu, 18 Jun 2026 07:23:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF83C5DDE
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:23:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767396; cv=none; b=Da5BB+iWj/41mcVaTYJwnRmU99DaGTEEF7bojxOxDPhuz7zUXjxEdD6sUxTzGwEFqJLbDQ0dFXbOBJMXNZ6mVDQgwzdS0985A9YUTs6ZdJRnfWM+UB3nrclJqHOSe6iqIBZ1ZNSSjheZiubLfoofLD1ptcKtI1DBLQtY89znXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767396; c=relaxed/simple;
	bh=T2RL72LMPbUm6XUhqskQ944FUcEgz9tb+3dQGG7OZK4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xf9btyl7Lxq3uSx7C2vRx6XziSh3QmAqsZEmnf/5tqp+nVRshTI5j/CJ7rmmUIcOwVmZQzKtTaLGdMR+EGX//HygI1lCcvYPpxZbrENe6xN1MvlMUFK3Nccyx4aGGp50nnmiptApw7ba0Uxn2PxbUb0QeX8hZcU03s88w7A2vuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=CaO8bwlv; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 775CD20704;
	Thu, 18 Jun 2026 09:23:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vGTzZaZUtyoD; Thu, 18 Jun 2026 09:23:05 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0153A201C7;
	Thu, 18 Jun 2026 09:23:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0153A201C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781767385;
	bh=3tKuVAsKGQbKj6HqiNuuq9WdJK1y43J+sAU0Vt2qdGM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=CaO8bwlv14Tnaq4YJ/1fCHbJas03ws3QvWp94vLFRhuBl54qpFgZ+doAWatseYHQq
	 EHAWbUVzMekMQxSZInsf4S3G6+mhwSVLoSPP5SaRMFLVf9A+tT02045iiRecyuslUI
	 V1/H7ZNQ9VyPA1pK4s/Sf7HL+2ba3TyXPjqAbWUQqHmMMWKp94DxXbatWRTa0ZZlWd
	 ZcAc1wKwz/x3lsuypfpUkJtYnbUs3UoOVEmB6bieQKdqAfjotgIzuHx13IVimryKwR
	 xow31a7jRDIm2mgCs8PsIhV24Fzm8ovh6wbqZ9tE/y5SFgA6bRRdQPX0dRGiK/l/QK
	 mCc7+8fgqDoFw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 09:23:04 +0200
Received: (nullmailer pid 3961711 invoked by uid 1000);
	Thu, 18 Jun 2026 07:23:03 -0000
Date: Thu, 18 Jun 2026 09:23:03 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Simon Horman <horms@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "zdi-disclosures@trendmicro.com"
	<zdi-disclosures@trendmicro.com>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] xfrm: Fix xfrm state cache insertion race
Message-ID: <ajOc10E_D7k_3NcI@secunet.com>
References: <aiuSE5J-U8SuoZnk@gondor.apana.org.au>
 <20260615084321.GE712698@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260615084321.GE712698@horms.kernel.org>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300333-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:herbert@gondor.apana.org.au,m:netdev@vger.kernel.org,m:torvalds@linux-foundation.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:zdi-disclosures@trendmicro.com,m:w@1wt.eu,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,apana.org.au:email,secunet.com:dkim,secunet.com:mid,secunet.com:from_mime,trendmicro.com:email];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B94E569E0E6

On Mon, Jun 15, 2026 at 09:43:21AM +0100, Simon Horman wrote:
> On Fri, Jun 12, 2026 at 12:58:59PM +0800, Herbert Xu wrote:
> > The xfrm input state cache insertion code checks the validity of
> > the state before acquiring the global xfrm_state_lock.  Thus it's
> > possible for someone else to kill the state after it passed the
> > validity check, and then the insertion will add the dead state
> > to the cache.
> > 
> > Fix this by moving the validity check inside the lock.
> > 
> > This entire function is called on the input path, where BH must
> > be off (e.g., the caller of this function xfrm_input acquires
> > its spinlocks without disabling BH).
> > 
> > So there is no need to disable BH here or take the RCU read lock.
> > Remove both and replace them with an assertion that trips if BH
> > is accidentally enabled on some future calling path.
> > 
> > Fixes: 81a331a0e72d ("xfrm: Add an inbound percpu state cache.")
> > Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Applied, thanks everyone!

