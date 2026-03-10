Return-Path: <netdev+bounces-266172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKlUH9wnsGnYgQIAu9opvQ
	(envelope-from <netdev+bounces-266172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:17:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A49D251A53
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E1FB30CA8FD
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6AA391E45;
	Tue, 10 Mar 2026 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrLwr5+8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25BB38E107
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151732; cv=pass; b=BI1laGG6hrfxg+3gAjjzxllM10oHQLXZPeOlYRNHpjuu7UTKARM1sjVOjA1Vi24l0VkS30CnEQw/R0uPDpfWJ237IDLZpw66fYmw9S1eLFOakfuN1G+3ZYrVDpFeN8mvb7eFj9WPL5k0EIC4bHuc/Sc3djjClHDjFL671Z5VDGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151732; c=relaxed/simple;
	bh=spe8LoTYbHeB1Jyqw9JcKEmNaWtQKDOlFwfxqVqSfug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGKvYTGW5fHibQfPJY0SVaXL+v2nqzVbs9Sbou9+Z55t4bDpAc4sSvGGwd8r6i68aR45krMF2RfRn4TIDu+71Szleldea89pakGrEdJAoxU7TWKN0lammRNVTOfGKTZpSKVb9JCKTm+Fb3YGP4luj48iU8YVq/pv5brMpxaTRx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrLwr5+8; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94ace5d0e39so3777049241.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773151730; cv=none;
        d=google.com; s=arc-20240605;
        b=I+Yn/I9TQ8vXXz6YE2IVPsgRMLGs+sYubBlpZ4arT6V4gpLcrGJFaIbGFX8vUXAFQA
         UKlX1/BRz0knHkMxhqTPFem8OIUz4x6Y2sVvtLbfj5GGN1CvTzjX07ATM04ycb29x3eV
         anInjFSeza3lnegTXrYCTJaYWR3rmXIOMG6Zmu0t0KCw7H5CNz0YbthgXdmimmV+FIvG
         DZYejNDTBL4qb5RA8rfseBZ2O61pw7oj/J3WJv8lOAPgQhFCe9wzM49OCeXjpoQu1K3d
         ECS9is0hysI2Lm4SWKzXV9PC81+h7dhXyTbALwUl4hy2F+/yMrkjNR+QQOeOJfD2ZMZ6
         UgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xl31xYRfMGlxbUEPVQ1ZmMuxL7GZ3d3B7rKbRKAjch0=;
        fh=Q+8iyv3X7xru77kz1qP4e933RBJM/RY4N3oQA3Q80EU=;
        b=jAb9WNXMi12MG4v7pe5UHrqdl1b6v7qbJ/5h3QdtH82O91sOTIM7mn7InFPlPKV/yx
         EUkS/il6hq9oQhTHRWT32Sy2vOY/akdEcV5asrp4VeGsMcbYlM5VGzYUdolw0czMPIXk
         nDR7Udg5zp459xWe2b6aWHf6ZUTa58naF6pctMbGZcHyaqn65bFenKUyw7wC4LmlupEB
         rHWTjhl8mkqMstHs9+7j3rubUZwdDeqXkou1IEkNCJjNi6L9DPeenFSK9k1MEslraukl
         nXtxnUSFGp2QXl1/N4OD2QSLYt3qjjtSUx4neLxRHTnOQq7ZWp5fWQfQjS+lqLtkUvpE
         B33Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773151730; x=1773756530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xl31xYRfMGlxbUEPVQ1ZmMuxL7GZ3d3B7rKbRKAjch0=;
        b=CrLwr5+8Rt/sFmmf1ykwo80fkoMyiz+7dGFw5lW7QuZ8pybnIJGepieZxtWx23WXpi
         HStQh42wV+0vO3bXihX6UwMLslZ0EERjv6PWYFIUKGwRZGqWutfYlK/FKyO80MPtQl8y
         AdasqgBpYxBbcqdj6c6sqXi7gCzMgFne/05+YBTe8PFD6uyIsTY06DkkY+83jL/pCJif
         CSEI9dlngGP2OMeSZb5SuNPMHtWjFPXg19RjIaxyaLJ5odT53cKLPn/EzAgFe11HN59d
         7xrOZktUMoV03o8ulh5U3GZNRsqLmgneCjijPg+AbT1AUzgfsSyAZw8wpV7G9Z15wmoq
         bvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773151730; x=1773756530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xl31xYRfMGlxbUEPVQ1ZmMuxL7GZ3d3B7rKbRKAjch0=;
        b=U5eNCrmHUxi7JRz4Ccg5ffXoSBQTfnIK4RbdlKX46+3MdhUEByB6O/iRA4AczJMT+R
         q9x7y2Z4AMvPMn5CPCetbJDLzboWwXVTcG0o6oKxksLd1y9C2TaT0cCAcouV2eUiqleU
         UCU0OTJ+8VoiJq4Ig+Ewp5LHwceFUUNPtvOdEHHRqSaOiD7qorjbwLWnIM3FGvKg8Ggw
         9e6XWNPFoq3px7B1T+of2Bk5Sv2rML4WmlzktGQihAXdrlNzi6Sa+T+yP8JbaI5W7OY7
         3rdIO99rrWT0HXPYmpT6nnmrTYfBRMbmqZucIXbpZiErUjSVE6C6dybkX4fszVzu6P5Z
         n0jw==
X-Forwarded-Encrypted: i=1; AJvYcCULaNDjWVKJ1h9j2ojfXSMCiw7HtHFgb0/zJQCy4rFB5qipIRcuz48yFzg4jA8jBXuoTmgs3IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV4GRuEPhq/jV96l1SyJfv66g+9cd2NM2nBI/J7g22hPqbzbGR
	hgFBvqJ2u6CNaPkIZ847FNKlvOoaNvsFlU0425vFP2DhP5Seoa3ClMfVgVWR76sR1RYrz+Kz1BI
	ONb6ZHXkUHkSG/Y+Nfj2x5ZcRdpUt/zw=
X-Gm-Gg: ATEYQzzCNJHQhDq1IyDGhMiygNTYTsJDMKiaRdKjoazwQlNXwDm4vXkwMBUjTSPmUgM
	u9IS0rXdr6n/j7urbxAIVC2V2+AaJS5z2p6yAtwjypEl8532rtlaNrzahNS6FWUPNadg7/98ghz
	ombGt5gQ82jUBN28dU0XXxh+zLj2PLeoWn9PZA8MAXoqGD6I9f72czmAdZdIh4k2M6JFhLF/e9B
	eEB6Btlp3ZeBPjKp7HPwH/RDfgCHQ4q+tOctpqbVfn2O2nPKWVYcbrC0rqiOs/B0mDK2vZqo9mB
	xsSSdvWsRrqBMHkdGgzVbCrUTeLmdgdOEY7zkrO3W7LFCHVVgpuDE1BOA/ckwEHUeDwgeQIgB6y
	tAC03Lak=
X-Received: by 2002:a05:6102:3585:b0:5ff:e39d:9f9d with SMTP id
 ada2fe7eead31-5ffe61e8553mr6095870137.33.1773151728213; Tue, 10 Mar 2026
 07:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309180804.3471287-1-kuniyu@google.com> <20260309180804.3471287-2-kuniyu@google.com>
In-Reply-To: <20260309180804.3471287-2-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 10 Mar 2026 10:08:35 -0400
X-Gm-Features: AaiRm53eN722kg7V_g551TMt0LOl4Xzt5mR90QD_MNv26np-GHo-jannfjv91ns
Message-ID: <CADvbK_fAbq023SvWiKTw+T5AoMvCWkap3_BC65FGSwPXHkpXHg@mail.gmail.com>
Subject: Re: [PATCH v3 net 1/2] ipv6: Remove permanent routes from
 tb6_gc_hlist when all exceptions expire.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1A49D251A53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266172-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 2:08=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> Commit 5eb902b8e719 ("net/ipv6: Remove expired routes with a
> separated list of routes.") introduced a per-table GC list and
> changed GC to iterate over that list instead of traversing
> the entire route table.
>
> However, it forgot to add permanent routes to tb6_gc_hlist
> when exception routes are added.
>
> Commit cfe82469a00f ("ipv6: add exception routes to GC list
> in rt6_insert_exception") fixed that issue but introduced
> another one.
>
> Even after all exception routes expire, the permanent routes
> remain in tb6_gc_hlist, potentially negating the performance
> benefits intended by the initial change.
>
> Let's count gc_args->more before and after rt6_age_exceptions()
> and remove the permanent route when the delta is 0.
>
> Note that the next patch will reuse fib6_age_exceptions().
>
> Fixes: cfe82469a00f ("ipv6: add exception routes to GC list in rt6_insert=
_exception")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv6/ip6_fib.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 9058e71241dc..fadfca49d6b1 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -2348,6 +2348,17 @@ static void fib6_flush_trees(struct net *net)
>  /*
>   *     Garbage collection
>   */
> +static void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_arg=
s *gc_args,
> +                               unsigned long now)
> +{
> +       bool may_expire =3D rt->fib6_flags & RTF_EXPIRES && rt->expires;
> +       int old_more =3D gc_args->more;
> +
> +       rt6_age_exceptions(rt, gc_args, now);
> +
> +       if (!may_expire && old_more =3D=3D gc_args->more)
> +               fib6_remove_gc_list(rt);
> +}
>
>  static int fib6_age(struct fib6_info *rt, struct fib6_gc_args *gc_args)
>  {
> @@ -2370,7 +2381,7 @@ static int fib6_age(struct fib6_info *rt, struct fi=
b6_gc_args *gc_args)
>          *      Note, that clones are aged out
>          *      only if they are not in use now.
>          */
> -       rt6_age_exceptions(rt, gc_args, now);
> +       fib6_age_exceptions(rt, gc_args, now);
>
>         return 0;
>  }
> --
> 2.53.0.473.g4a7958ca14-goog
>
LGTM, thanks for the fix.

Reviewed-by: Xin Long <lucien.xin@gmail.com>

