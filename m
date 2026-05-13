Return-Path: <netdev+bounces-287691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNB+OAyyBGoQNQIAu9opvQ
	(envelope-from <netdev+bounces-287691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:17:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A34E7537D7F
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4BC173010BF6
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF583A425D;
	Wed, 13 May 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7DpjLws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0132A3A2E07
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692600; cv=none; b=PyefObqw4iTmhlMhn0nIBr8dy+qA1rRUS5Rg5S0D5Nr9gEEerT6wxBZ5BT/85Z3iOCsRuCgf5+k9+Shzr/OgwRdEetS8HYCZi+i3NC/VYJ+zixRhF0rIX43Aopi/PQwb8mYBuo6Ar1KBEUU0JvqR0/FOGZbGb9IY2kSBx90Ufsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692600; c=relaxed/simple;
	bh=faSlA/Gy4+hGhFjhHo18QPT5jT1Kuy+RVGGvkXN4szQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApOJt7h7pofpbJhWvVpFlappAgn7q4z8gkBQ3NtqM7HvA/O/y+om6CLF2LZqaidnUfyNtpAKbKN+S0/H9x1NW7Eb1/Ky9YZ8LD72LyQeKeY9XNjfMN61BS2jcGOZpC5KCNexI3eHH+Ei63YmjcWUL9woVsdlLOyIuxdYWc/yh40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7DpjLws; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36622412e97so4591087a91.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778692596; x=1779297396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZWcV0rAryTMJnbVXU/76vXU1STIeSGIC5/F+Khj1D8=;
        b=K7DpjLwsdDF8MGXRqWdydrjl1Qb0oEYyIvSmu47ohVZwaNOGTNYi4FllQr6alceT7f
         F3jnWfJbE3xOnLdkQo4zSAnGxev8fWkUxVLl+AgMIKdD12aQVG5CWNGaY1djwJnbo4y6
         jZOYR3f3amke4MpTgivCdN2zleQJqEy80fNY3spvdSHwvfKIvDcK+rR5jeD0OmM30bnZ
         5n/giydgPctb6JVyQehb8IGNr1sh408f5MKEkDrLPNhZok89F2Y2QbHs1TeMucGsXd1u
         7tCztZC89zdWbGEJrcoP7OYeQIfmU3KhqJz3An2Rdhdfv57A1R+e5nBBM/HCZ1aSjND3
         KYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778692596; x=1779297396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZWcV0rAryTMJnbVXU/76vXU1STIeSGIC5/F+Khj1D8=;
        b=Oty/K9spL6OwRcxAdJr64jCGYCzWnKCvYOc4b9QpjKk7Q1TE5SqUnPBU8Xzz/DTCNl
         3itv9w54tBpmeK6R+oXRWieeWyIO854uDw8nF30YUTqrn6t/ASIHhCRyc7zNARqHzMQm
         7aDCZ+Zrx/H/TWo/aB5O8OHsY3WcJkZYDxNg4I88vR+Jjj0qTQu/vyIawKQYvg1u1zim
         q4opx9ML8rqcjfd6KHp8BPAI5r/o0F0utevsJdANWsEDmFReZcJ7C1K+kabFLSaxrPLN
         6pgJhvv7v3y1H2sWC5C2bccUuxsokpiZrlh+SPLXE9d0RtDoAT7NSAPWUg5lciTKlcq/
         FjVA==
X-Forwarded-Encrypted: i=1; AFNElJ8Uw1G/n9dkimeUA8toEikhqo5N7E/R4IZOwqbNvacyCWb8qVaEbHWVda814hEWsWXnj4jZ1Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy3PAYEOmb1XOXmA+rjfT8HkakZptgsjwDt5OC0+bPjlWwnjn6
	tK4dmAJiSVDGsqhIsIKdGHCXuTB35Um0Eqg+MaQ31zOiRmAJ8QZmUxWc
X-Gm-Gg: Acq92OHeG3nGtbRAYur0doWkAOLB8DZV4vPmwokNtkKqbOAgXWf1szUYiEyIHACk8IO
	WDc/Jpgre6bqP9T2oZ2/A772UQSJEbKztnQ9Gx/a8+kayG1x4J71Ga2O78BpiB80m843fyLuNoS
	EA8eSt9tDkmXjhTznHQpjt60aUg5rTDasg1NsE+HRlQQ/TX9pqffUvRMQMLpLtd5GUdEnqzo4Vm
	P5eU/zLD8wf+5EJflpJ2B7WqdHTQMGXSt/cujIn2SHu55Z66Dz6NfxKpMTZaXmcrQ2f1bYaFf6a
	/8yOrOK2YL6rdUBdj1nIyJ1N+C+oBaLqYhEykRrygrKsiM2WAV7p0oQpF45aRqAbsJf4BZ9baXX
	8H6Erp/0sPdg5Xr0saNsY12YWmX33hC+ttaXPXWKHZL5bCxlPd2vq3GKm0IDH44e6W6d6AcxY3B
	QiuoK7fKjqYzijGxrEK02eeOhbTbCDZypAtiZhp6UyP6PyG/Llc+na05xlS4QxkRud
X-Received: by 2002:a17:90a:a81:b0:369:1dff:6bd5 with SMTP id 98e67ed59e1d1-3691dff76dcmr743122a91.17.1778692595883;
        Wed, 13 May 2026 10:16:35 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368eddf5161sm5087917a91.2.2026.05.13.10.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:16:35 -0700 (PDT)
Date: Thu, 14 May 2026 02:16:31 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, dsahern@kernel.org, vakzz@zellic.io,
	stable@vger.kernel.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] net: skbuff: propagate shared-frag marker through
 pskb_copy()
Message-ID: <agSx78pXBFCdn08p@v4bel>
References: <agRfuVOeMI5pbHhY@v4bel>
 <811b31f3373526d1ff60160c2f32ddb359e54c31.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <811b31f3373526d1ff60160c2f32ddb359e54c31.camel@decadent.org.uk>
X-Rspamd-Queue-Id: A34E7537D7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287691-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,zellic.io,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 06:21:45PM +0200, Ben Hutchings wrote:
> On Wed, 2026-05-13 at 20:25 +0900, Hyunwoo Kim wrote:
> > __pskb_copy_fclone() shallow-copies the source's frag descriptors and
> > bumps each page's refcount via skb_frag_ref(), then defers the rest
> > of the shinfo metadata to skb_copy_header().  That helper only carries
> > over gso_{size,segs,type} and never touches skb_shinfo()->flags, so
> > the destination skb keeps a reference to the same externally-owned or
> > page-cache-backed pages while reporting skb_has_shared_frag() as
> > false.
> >
> > The mismatch is harmful in any in-place writer that uses
> > skb_has_shared_frag() to decide whether shared pages must be detoured
> > through skb_cow_data().  ESP input is one such writer (esp4.c,
> > esp6.c), and a single nft 'dup to <local>' rule -- or any other
> > nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
> > skb in esp_input() with the marker stripped, letting an unprivileged
> > user write into the page cache of a root-owned read-only file via
> > authencesn-ESN stray writes.
> > 
> > Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
> > were actually moved from the source.  skb_copy() and skb_copy_expand()
> > share skb_copy_header() too but linearize all paged data into freshly
> > allocated head storage and emerge with nr_frags == 0, so
> > skb_has_shared_frag() returns false on its own; they need no change.
> 
> What about skb_shift()?  It seems like that should also propagate this
> flag.  But I could be missing some reason why it's not necessary.

Yes, since skb_shift() is also a function that moves frag descriptors, 
I think SHARED_FRAG should be propagated as well. The actual trigger 
conditions are tricky (not deterministic) due to TCP write-queue skb 
merging, but I believe the fix is the right thing to do. 

I'm planning to submit a v2 patch. What do you think?


Best regards,
Hyunwoo Kim

