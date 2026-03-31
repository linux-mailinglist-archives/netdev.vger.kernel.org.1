Return-Path: <netdev+bounces-273506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKu5N75/y2kKIgYAu9opvQ
	(envelope-from <netdev+bounces-273506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:03:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBC5365B75
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30FCD303CC18
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DD136F42C;
	Tue, 31 Mar 2026 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="suKrskLE"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD883D332E
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943443; cv=none; b=CxtH2JREm6SnxzTWlFskMH6AcHN2vNcevfZZ01KbDtFe1rBULN9ECYFEJtv+NAL300QPb3NK/WEsIdYUs51tVgU6S4RDRCJqL7AKE2cMItZ4jknD0jJ2EClLQY4R1A2Q+Aq/C+gJbFASEFzA1bCxNEOsBC9vCxxtYVNvsE9V8B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943443; c=relaxed/simple;
	bh=mdPeeJoWaY/FEdeB1gZCuU3NmQdwalLB08y+b87yg88=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+h984SgWyYBYPuz+BQS5qd4JB5PWXkB1m/lq7JVoUfJsM7LZbNa+ysFQOSzxt72nhTyeZBug4rIdTNcqv9uKrDMwaImA+1weRsoDJhlhBcBTSb5hnLFQ5MIjJA4p1JqrbOTudioheRomW4bw0uUXYriU6IJWniZRk7zwMBWDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=suKrskLE; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id BB06F207BB;
	Tue, 31 Mar 2026 09:50:39 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G0OSxYg32PfD; Tue, 31 Mar 2026 09:50:39 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 141EE205E5;
	Tue, 31 Mar 2026 09:50:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 141EE205E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774943439;
	bh=k9yL4sNL9NSzItenOeRoT43xmKm+rIk7f9WJfgt+1fA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=suKrskLEjf+NFsZn7RDLwicGgdZJx+002uKk1mjuWv5W5lOT8bC4MNFJmm44HxarX
	 vqI8In70XUD7t13u+t/ujSktdoHDZfIbbX8d+hgub4hRiLd/q3uIxDffFrUu+aeG2d
	 GRhOAi7uglydnhKECHUsf5zmy/TA2IuXB1LqXdReibW8g5aZ1rasp2lCelQiIuF4DQ
	 D60ALEErqtLImRZGPSKkhHk+kNqNve5UmlSyTwDxNTDlFxrWWnIbJm019uaE25I6C8
	 UjILW/DXoxzOhh8YXTz82xijE2f61FyVhTVDyNionQdGRF9bmDp5iSBUIec20oH5Oo
	 PQNMRFaWEH2hA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 09:50:38 +0200
Received: (nullmailer pid 1487476 invoked by uid 1000);
	Tue, 31 Mar 2026 07:50:37 -0000
Date: Tue, 31 Mar 2026 09:50:37 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <nicholas@carlini.com>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S . Miller" <davem@davemloft.net>, Milad Nasr <srxzr@anthropic.com>
Subject: Re: [PATCH] xfrm6: fix slab-out-of-bounds write in xfrm6_input_addr()
Message-ID: <act8zZGYpN9DJ4-w@secunet.com>
References: <20260328163516.2111971-1-nicholas@carlini.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260328163516.2111971-1-nicholas@carlini.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,carlini.com:email,anthropic.com:email,secunet.com:dkim,secunet.com:mid];
	TAGGED_FROM(0.00)[bounces-273506-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CDBC5365B75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 04:35:16PM +0000, nicholas@carlini.com wrote:
> From: Nicholas Carlini <nicholas@carlini.com>
> 
> The bounds check guarding sp->xvec[sp->len++] uses == where >= is
> required. When sp->len has already reached XFRM_MAX_DEPTH via prior
> ESP processing in xfrm_input(), the check (1 + 6 == 6) is false and
> the write goes out of bounds into the adjacent skbuff_ext_cache slab
> object.
> 
> An unprivileged local user can trigger this by entering a
> user+network namespace, configuring six transport-mode ESP SAs plus
> one MIP6 routing SA, and injecting an IPv6 packet with six ESP
> layers followed by multiple Routing Header Type 2 extensions.
> 
> The check was correct (>) when the function was introduced, but
> was changed to == during a refactor in 2007.
> 
> Fixes: 9473e1f631de ("[XFRM] MIPv6: Fix to input RO state correctly.")
> Reported-by: Milad Nasr <srxzr@anthropic.com>
> Signed-off-by: Nicholas Carlini <nicholas@carlini.com>
> ---
>  net/ipv6/xfrm6_input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
> index 9005fc156a20..a958c08589d6 100644
> --- a/net/ipv6/xfrm6_input.c
> +++ b/net/ipv6/xfrm6_input.c
> @@ -246,7 +246,7 @@ int xfrm6_input_addr(struct sk_buff *skb, xfrm_address_t *daddr,
>          goto drop;
>      }
> 
> -    if (1 + sp->len == XFRM_MAX_DEPTH) {
> +    if (1 + sp->len >= XFRM_MAX_DEPTH) {
>          XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
>          goto drop;
>      }

Your patch is malformed (whitespaces instead of tabs).
Please fix this and rebase on top of the ipsec tree.

Thanks!

