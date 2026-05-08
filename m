Return-Path: <netdev+bounces-286016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJxcCDJi/mnCpwAAu9opvQ
	(envelope-from <netdev+bounces-286016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:22:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DB34FC517
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2CC6300825F
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF7239F16D;
	Fri,  8 May 2026 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ilibAvyS"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F839DBDD
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278958; cv=none; b=o6lSVF3SjUbyo24tH8+DniaNGSz9JCv/NUfiECU84I+iOn8UeTkeki6OYbnph1rDVShDuGvYKiA354Cs9R5QHWaKq+bBTov3bc+I+DemT7oz+3PHwz0GTFfuaTw2Nu6OmVbA+YVLsQ8c5nG4+v2JjuAKAwWiZ529+lTURmR9p5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278958; c=relaxed/simple;
	bh=v+YrmPN98rmOPgqI8qzMEYAYy7v6oa9s+yEkKSjHflQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZbDzZYK8PGpI17IQWDkqbJ/LIFeY9DTCk6q8DiPxHb4CSSuqPXNOIDMH+Ti7aniXjlWMfaqtBzzjQlBmgc4UvH07hX543rfEy9BqC0HLzW0M02k3zySKoUE8Wi/a2b//Ei3Nwg0ks5RvK60MkyyLsvTbQEsz+aDVN46lQLCFHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ilibAvyS; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 9 May 2026 00:22:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778278942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AX0C4a1+ZGYkQkuyscavIIXsbJ2Zce7Z7oYzxtQbRF4=;
	b=ilibAvySx0V8cMRJ0cnH443wtv+acaEQ50SCRWFOyAI37FJuiobGfKVrjAot549HFeIA5V
	t/wcBj2sHfHp3trvv74dVAyqR1H6UDuc6qj06wuMkCNzR4oyH5nElWr+xzRCRr2YStEBXr
	SypEpiFYW0fltkLQLP/KNJBi8fFsrT0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Tim Bird <tim.bird@sony.com>, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] keys, dns: drop unused upayload->data
 NUL terminator
Message-ID: <af5iFwm9Nckoz4Jt@linux.dev>
References: <20260427114422.313356-3-thorsten.blum@linux.dev>
 <af5TvSZHwBH0N8Jq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af5TvSZHwBH0N8Jq@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: B4DB34FC517
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286016-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 12:21:01AM +0300, Jarkko Sakkinen wrote:
> On Mon, Apr 27, 2026 at 01:44:23PM +0200, Thorsten Blum wrote:
> > ->data includes an extra NUL terminator despite never being used as a C
> > string and only accessing ->datalen bytes. Remove the redundant NUL
> > terminator and allocate one byte less in dns_resolver_preparse().
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Never being used where?

Does this conversation [1] with Jakub answer your question?

[1] https://lore.kernel.org/lkml/adw5cvtPfx1SWQq9@linux.dev/

> Let me go this through.
> 
> I read this from the documentation:
> 
>   /*
>    * Preparse instantiation data for a dns_resolver key.
>    *
>    * For normal hostname lookups, the data must be a NUL-terminated string, with
>    * the NUL char accounted in datalen.

This documents prep->data and prep->datalen, which must be
NUL-terminated and is checked here in dns_resolver_preparse():

	if (!data || data[datalen - 1] != '\0')
		return -EINVAL;

According to this, datalen (prep->datalen really) must include the NUL
terminator, otherwise -EINVAL is returned.

However, my patch is about upayload->data and upayload->datalen, and
upayload->data currently has a trailing '\0', which upayload->datalen
doesn't account for (a mismatch that prevents adding __counted_by).

> So what is confusing here for me is that should upayload, which is
> original data with options and '\0'.
> 
> So my question is which is the regression here:
> 
> 1. Incorrect length. Then the fix would be simply setting length as
>    'result_len + 1', which aligns also with the snippet of documentation
>    I pasted.

This would be an option, but there is currently no consumer of
upayload->data in the kernel that uses the trailing '\0'.

> 2. Unnecessary '\0'.

Yes, '\0' is an unnecessary extra byte that no consumer of
upayload->data uses, and my patch removes it.

> If there is an issue, your commit is lacking fixes tag and cc tag to the
> author of potentially failing commit.

It's just an unused extra byte that prevents adding __counted_by(),
which is otherwise harmless, hence no fixes tag.

Thanks,
Thorsten

