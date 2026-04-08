Return-Path: <netdev+bounces-276750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHtYOYTk1mksJggAu9opvQ
	(envelope-from <netdev+bounces-276750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:28:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 941B23C4C4F
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04923303852B
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5F39EF1F;
	Wed,  8 Apr 2026 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="oPwacU0b";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="f12CY/bB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109EF2877F4;
	Wed,  8 Apr 2026 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775690879; cv=none; b=SQZtFfbXn8Rs6+xWx1JaTc2MM/OLiobovw3/T8IN2Q5AQOV+1kiNaSbHyUcM9Fi19wznNUPAIoqubnRvaaHqGB8nA+R4DxopmxVxPPN8x6kdlY9DjB5tLSxRfpi6TDnUR8S3bwxXJhwy2SG+gkoVGomxXQw4pN2Iw/TR/Gi6OrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775690879; c=relaxed/simple;
	bh=cbR8XrY9+JQe/+AkET29zywNHu/7aXS6coqT/s6zM9M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g32AkxUoEX7GPv3jaJtgdIuqVO9aaMDMvINad/rGRBXCpE+/BldwtkO7NoB+EYEVH6MeIPnv0jZBYTlS2+4j+563A0CvBkf4Y1fZGz3fD/yYhoJtsx1aKlIONWNoQmWMutAHSI5Jc8MhOSokjC5mEFD4asHcPvOLTbfrIndr9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=oPwacU0b; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=f12CY/bB; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 638NRDiD027151;
	Thu, 9 Apr 2026 01:27:18 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id E9D28120542;
	Thu,  9 Apr 2026 01:27:08 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1775690830; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Guc4tAMsLbLbcWb/j5eblk0rzSKs3Av6NGjOehKL8w=;
	b=oPwacU0b+ApJos03RqXbEpoyCUgqTuulfQY2w7Mqp4uxIigAk74XIPEZ62S03EkTA6adl3
	9+BI6ceJ97hAqKAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1775690830; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Guc4tAMsLbLbcWb/j5eblk0rzSKs3Av6NGjOehKL8w=;
	b=f12CY/bBg0RzDISkA3/6ygq0Epm1p7Be7cLAzq8ktOcFc1rnHvI8Mx3r8cB26EyY9CVwbk
	v3ofywRYw5ZVjNtbB9tXRcrsm9U/He3VF10DUwqq0hm4bf2WbjRN5J9rpM6aWRZbXgkPOt
	JmiR/XLgoLZX/DZBDIv0LWc7S26rbUVCqyPVixDilPu65nH2rAjWWyTgWCjVOOiPL0HVv4
	pkplRexUJGMPjBbmdv0DHg4JaG4379rvnvr2U5HskpSndXNW0a9Z/gSEfXREoKVJ9HvJDK
	ON8Nd5hMatOCOfmLu1Ia7vO2x73Lc29g+HVBT2UMPdd71sT06OYJVmlTcVFF1g==
Date: Thu, 9 Apr 2026 01:27:08 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
        david.lebrun@uclouvain.be, stefano.salsano@uniroma2.it,
        paolo.lungaroni@uniroma2.it, nicolas.dichtel@6wind.com,
        justin.iurman@gmail.com, linux-kernel@vger.kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v3 1/2] seg6: separate dst_cache for input and
 output paths in seg6 lwtunnel
Message-Id: <20260409012708.78040268c05e3285742157ae@uniroma2.it>
In-Reply-To: <20260408032039.314762-1-kuba@kernel.org>
References: <20260404004405.4057-2-andrea.mayer@uniroma2.it>
	<20260408032039.314762-1-kuba@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276750-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,uclouvain.be,uniroma2.it,6wind.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniroma2.it:dkim,uniroma2.it:mid]
X-Rspamd-Queue-Id: 941B23C4C4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue,  7 Apr 2026 20:20:38 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> This is an AI-generated review of your patch. The human sending this
> email says "Seems orthogonal but also legit"
> ---
> seg6: separate dst_cache for input and output paths in seg6 lwtunnel
> 
> This commit splits the shared seg6 lwtunnel dst_cache into separate input
> and output caches to prevent blind reuse across different routing contexts.
> 
> > diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> > index 3e1b9991131a2..d6a0f7df90807 100644
> > --- a/net/ipv6/seg6_iptunnel.c
> > +++ b/net/ipv6/seg6_iptunnel.c
> 
> [ ... ]
> 
> > @@ -504,7 +505,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
> >  		/* cache only if we don't create a dst reference loop */
> >  		if (!dst->error && lwtst != dst->lwtstate) {
> >  			local_bh_disable();
> > -			dst_cache_set_ip6(&slwt->cache, dst,
> > +			dst_cache_set_ip6(&slwt->cache_input, dst,
> >  					  &ipv6_hdr(skb)->saddr);
> >  			local_bh_enable();
> >  		}
> 
> This code appears to cache the dst entry resolved just prior by calling
> ip6_route_input(skb).
> 
> Does ip6_route_input() assign a NOREF dst to the skb?
> 
> If so, this dst is protected only by RCU. If the underlying route is
> concurrently deleted, its refcount can drop to zero. When
> dst_cache_set_ip6() is called, it attempts to use dst_hold(dst).
> 
> If the refcount is already zero, dst_hold() will warn and skip incrementing
> the refcount, but dst_cache_set_ip6() will still store the pointer.
> 
> Could this cause the cache to hold a dangling pointer, leading to a
> use-after-free once the RCU grace period expires?
> 
> Should this path use skb_dst_force(skb) or dst_hold_safe(dst) to safely
> upgrade the dst to a refcounted reference before it is cached?
> -- 
> pw-bot: cr

Thanks Jakub.

It does seem orthogonal to the dst_cache split and worth investigating.
I'll take a look.

Andrea

