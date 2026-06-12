Return-Path: <netdev+bounces-298623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JYAHHyL7K2rwIwQAu9opvQ
	(envelope-from <netdev+bounces-298623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:27:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DAA6795B7
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:27:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=gdWJNPgx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298623-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298623-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7A9E3003814
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FCA3C09F9;
	Fri, 12 Jun 2026 12:27:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B553A8723
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 12:27:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267230; cv=none; b=VEfB758vmkFwNJeo4Dlzt5unFz5OLMURKKaWVucuLTznCstXk9RhuJqzWaV24vuHGdUsEsupd0oW0/+uEVjjeYK3Q07NLFQsaC7MPitBIbAEzfhLoh1w6DHMpd5N2gr8fM+m6xtbl6EN0RRD3yHmMwL2cUCjJB7cbumOHGWjRsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267230; c=relaxed/simple;
	bh=Zsk6KxZbHV3X6/WKHrJG51DM0TlT9dXBLS+m8qe9cJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbIPDcE2X3EUoicvy4yQ1c8vA2Wt/Y8K5m4mabbUVe7xXqKPsieoBZ5sat29aRXMqJWLtbMDF5gllRc+eYldLrUlxglizvlab50/w/3EaiXSKIpH7DFihmOqQbbIVSj2t6p1L8wySgHXW7stbDIG2B8fZrDD2Z8zCq59gQPgkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=gdWJNPgx; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=+NjpIUu5xLL37mmfLFgILjEUcCwsTj4SWUNnT240/Vs=; 
	b=gdWJNPgxcDJHqpSY1w/qTAcr5VS1RknQyCELdVQZNWO1MNxtY7m0BOMSpn+hM1H/AbbGoor4ge/
	cMJzEQy5ePSrQAblKz+AGPIR0ZvSO0oft3efSdbIi7cBeXqJ/Tpp9fCL+soGqnjIJMAI3f8LXYbAy
	dr7ekB1T6hRcOXsxswvNZTJIYKmwyF/i5FUJtGqNDIUnmXFYmxTdndTtGBEqltaNeBFOEaJUU7LqO
	g6UTtP5kepSyOZEZWYJvWHbzJq5pL+sOlMOV1lmrgmGIh8dlxgH+RHcBk1O9LoyBc0c//Hj//zG5/
	UlgiAZHWww9XewFpOVQ+0jlp26CBjj7Gqelg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wY0yS-00000004tbi-2OrV;
	Fri, 12 Jun 2026 20:27:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Jun 2026 20:27:00 +0800
Date: Fri, 12 Jun 2026 20:27:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+d85ba1c732720b9a4097@syzkaller.appspotmail.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH net] xfrm: annotate data-races around xfrm_policy_count[]
 and xfrm_policy_default[]
Message-ID: <aiv7FHN-GqLtRinV@gondor.apana.org.au>
References: <20260612055634.3560352-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612055634.3560352-1-edumazet@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,secunet.com,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-298623-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+d85ba1c732720b9a4097@syzkaller.appspotmail.com,m:steffen.klassert@secunet.com,m:torvalds@linux-foundation.org,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,d85ba1c732720b9a4097];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,vger.kernel.org:from_smtp,gnu.org:url,apana.org.au:url,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10DAA6795B7

On Fri, Jun 12, 2026 at 05:56:34AM +0000, Eric Dumazet wrote:
>
> @@ -2318,7 +2318,7 @@ static void __xfrm_policy_link(struct xfrm_policy *pol, int dir)
>  	}
>  
>  	list_add(&pol->walk.all, &net->xfrm.policy_all);
> -	net->xfrm.policy_count[dir]++;
> +	WRITE_ONCE(net->xfrm.policy_count[dir], net->xfrm.policy_count[dir] + 1);

It's sad that we have to generate crappy code just to placate
a stupid analyser.

It's also ironic that we're doing this after gcc has finally
fixed the volatile inc code generation, exactly 25 years since
I first reported it:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3506

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

