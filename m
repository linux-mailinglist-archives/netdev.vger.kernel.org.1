Return-Path: <netdev+bounces-271657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFRLNJkSxGkXwAQAu9opvQ
	(envelope-from <netdev+bounces-271657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:51:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5008C329656
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ED7F3038A6F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4074B3F788E;
	Wed, 25 Mar 2026 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHJ+VuRj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14F3E868D
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456793; cv=pass; b=nK8pTsT7Ix+BDTbdTjkFCBVu0vtQs1zYLzUk4HkduRG7Z0ShOJ8O40ndNkYrMny4r5oAGntB3JiBLseuDc/XZwZnIRGm+k6qB9udbhDbXASaT5xv36Or0kIkKOTk906jRiq9Y9otXK9zwQYEAHtww2CYizjQctS+sBk6l3UMYdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456793; c=relaxed/simple;
	bh=uc1+LCbY0eoe3upIZlO53VU2OLt3I4CuSqeTxMjq7sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDq5LnwWazBB46T+FmF31hEDGrmfJPOjSq4r7svgWOmg/1YKkEsm5wT//ZmuYXApM/ESjr77w6WBWuhPIEZt+SRiUltVh7h90qNDTW1kzxnFBU7arrk6buqad7sNvjm3CE53jWRbNmuDgGytLOZEmWchAUX7S4sltWL5BpEfZPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHJ+VuRj; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94dd01deb53so12750241.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 09:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774456789; cv=none;
        d=google.com; s=arc-20240605;
        b=ENgLm4BXO+0fVOtXfqNr1dkdKTWci9i4ERsnDeWj5p7U58vCuZb3eRc1S7B3lDuLmG
         Sal1VsjxMZnCts0J7gYPsdHrLKQTpecdnGxu2DgzX6UYz/6897z0pE56WO4549HOgEIg
         U/bertYYh45x76eTn7d4eA0DSpkHtGxmId9uaWgK1ZesATVt9xvSii+CRCOVwjW+HE3/
         ex4mHDRyV51c8Uv2SRa+VbVFTVbyMdP2z6uzjfF2idEfF5I4bQwDwAPaW1a0x4wcSYWx
         LywslqZsXIHc4A0UZoEXk/JDYxSu1Mp+5TYbXC0sZqeQk0Epo20V4wH6fVIP5mKsYVhw
         HA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uc1+LCbY0eoe3upIZlO53VU2OLt3I4CuSqeTxMjq7sQ=;
        fh=7+TDlMgH19FfatCQxNxt1Z2wGx13+cVsvO38EO85Xfo=;
        b=GtWPeeOuiLTqOHHEPE8D7UBN6+WmYRNwVkf3dQAIq7dOrJWiVFgBaiaaqu8xnkZsdc
         BA50O5gzZnTJimqHsBJOxiOOWJF4++9rD8MkHxMbujsmebNWjBYEkJrlV06rHq9v9AtY
         sfVfZYVlRmd2UQK5Sq7WwzosE1mqVIpksxUSkCSm+FXSYRX6YJi2TTBGFkDFquSi2F4v
         /IbZKHk/bx1d36DUvyD7MKdu5XyN18YQGJjlOmC1YEdWEDjgEDFRQIXwn9AKY7CvUhqM
         hDIBj/9boRrBrD7KmC6HZlWVeWlXwjx4v1xgHK+PXLMEcFMldPdptXsNA0aITOigHGgt
         nJ+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774456789; x=1775061589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uc1+LCbY0eoe3upIZlO53VU2OLt3I4CuSqeTxMjq7sQ=;
        b=AHJ+VuRjzqpXaRZBZuetbewVAFx9FXZXza9/SRIJTDHZzYsTsZbEfG6tFHUfIfsura
         L2hBdEEBC3Q0bhdux706vYa72mOufTLBD6nzy/hn2XQvdluh+93B60JACM5wu8Wvzckb
         uZoKLK2r2z8veUelREka86dF/P1MNUW/TijbAwjG0WFfKZymdFG2M/anTPmGKmj1reo1
         PppEAh8j9phIsGFFvcfsVckMp24RxSudK87pDqmNgwKrTkWUsBI8wSGQONVPE+7leAP5
         bSOZW5Kn5iauFmdYHmzCUUDIYzFqmgRWf+nfMH6D1MawFdPTYz2uj67uDn4ugr1KxMfO
         Im8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774456789; x=1775061589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uc1+LCbY0eoe3upIZlO53VU2OLt3I4CuSqeTxMjq7sQ=;
        b=XmNF3GqBbZ+jzC0wOjSBwrcaQke8WP6ksdR0oYFoSExPMj9ZdOdzdOiekvxd7jzS2D
         x8yypcheV7cqc+XRU7zUDiksLCS9K7+1Em000Vxnl3VPIMUtgRR8JyiiwLwZpTkLpWT7
         I5pocuKZNEtHNU0SEnY+LzosHIjvlW4Iwq7s9LdFzbdqJzw21eOPRPkLxkAKSvUDRR/X
         bzFhcbYmAkKgTYj6JqJRxOPPpEree4B68zJkRm7uLpG/hpF/bOP1ut3W5qPVpYwM5fbe
         HPyG/SeRY5BPkkBOqh4pCFQzD4fOQkY7DJdGjoZf4V03JEGKD1PF3oKugpP1y3PPRLLo
         F7PA==
X-Forwarded-Encrypted: i=1; AJvYcCViB8o9CdeB2DHY2+3JSIfM8gEgCTrRaHgqhHqWV+lY1aEToSsHCXr+fxY7Ncjzz5IkaHogrMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKMHWLeK8nVdbCR7KoPDs7E9xMzD57uu87SXQzN/weom+gHdI
	eLfYiM12m9+HdjqYcbj5Rks4ni1xaY6aJjV9n+PAjcpwSDIEFtSNxwi4C4tk0kG1J+DW3EtL0XZ
	ZaTOAF3Iq2TA++7koZX/R8qT/WI3nqH4=
X-Gm-Gg: ATEYQzzgTZcxququCs+3ZSRoZvS+FfflC5zj1Asfyx0fLnZwoCnGOsJ00FzV7ivOU/p
	3EI/tG9b3Hnuu42oUd06Ssp+vnOksjaYAo4XopV9F9oAXjzOEQ/rIZVkpb7QbcsnChAQ/lZ2a1j
	jis3joQlrayIqw/kqOm6xr2wFclY9IBoa3bHRgHrMb3lSO9h8rayw4N4whmsewio8rHwT+Wu96A
	xaZITbdmoFaaPjSFNu72rkvna2X2p3OJ3hDxwCHo4rfuKJg7nbZCyOnT5kHFOxHPxHxE+uiFSdU
	wdIaQZ0=
X-Received: by 2002:a05:6102:504c:b0:5f9:39e6:cb04 with SMTP id
 ada2fe7eead31-60379034dedmr2401577137.9.1774456788570; Wed, 25 Mar 2026
 09:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321141510.68214-1-seanwascoding@gmail.com>
 <20260321141510.68214-6-seanwascoding@gmail.com> <1319acf7-36fb-4be6-9921-b0d19a2aac7b@oracle.com>
In-Reply-To: <1319acf7-36fb-4be6-9921-b0d19a2aac7b@oracle.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Thu, 26 Mar 2026 00:39:37 +0800
X-Gm-Features: AQROBzAud2z6ycdDihUpsB0b5GDaCiO63XRd--2rd1xo0jQDuzo6gaLIj1dDNpg
Message-ID: <CAAb=EJU856-J9tTZCKeUS8toMPEZd5gRckmkYCLDTdZX-9DtbQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] Revert "nfsd: Mark variable __maybe_unused to
 avoid W=1 build break"
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Andrew Lunn <andrew@lunn.ch>, David Laight <david.laight.linux@gmail.com>, 
	Anna Schumaker <anna@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271657-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,kernel.org,intel.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5008C329656
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 12:38=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 3/21/26 10:15 AM, Sean Chang wrote:
> > This reverts commit ebae102897e760e9e6bc625f701dd666b2163bd1.
> >
> > The __maybe_unused attributes are no longer needed because dprintk()
> > now uses no_printk(), which ensures variables are referenced by the
> > compiler even when debugging is disabled.
>
> Some commit message improvements are needed:
>
> This revert is safe only because ("sunrpc: Fix dprintk type mismatch
> using do-while(0)") already changed the non-debug dfprintk path to use
> no_printk(__VA_ARGS__). The commit message doesn't reference that
> enabling commit by SHA or subject. If this revert is cherry-picked or
> backported without that pre-requisite, the W=3D1 build warning returns
> silently.
>
> The commit message says "dprintk() now uses no_printk()", but this is
> true only for the !CONFIG_SUNRPC_DEBUG path. When CONFIG_SUNRPC_DEBUG is
> enabled, dfprintk expands inode directly via __sunrpc_printk, not
> through no_printk.
>

Hi Chunk,

Thanks for pointing out these issues. I will update the commit message
to be more precise and clearly state the dependencies.

The corrected version will be:
The __maybe_unused attributes are no longer needed for the
!CONFIG_SUNRPC_DEBUG case. This revert depends on a prerequisite
change in this series: "sunrpc: Fix dprintk type mismatch using do-while(0)=
"

That change updated the non-debug dfprintk path to use no_printk(),
which ensures that arguments are always referenced by the compiler
for type checking, even when debugging is disabled.

