Return-Path: <netdev+bounces-303912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FLrKK43HRWpEFAsAu9opvQ
	(envelope-from <netdev+bounces-303912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:06:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 297626F2F0C
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:06:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bzsoD8mY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303912-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303912-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6298303259E
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 02:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691452DEA86;
	Thu,  2 Jul 2026 02:05:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004CE533D6
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 02:05:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957955; cv=pass; b=tjYI6CArPU3eDNCJTYy4GYwRbXL6YyZHmIRkZXwCXwqL1QeiX015CKsMS+RyRMMsLyo8Ov4JdfQmNGhpmBAaVjFJQqy0Q2Dv8eVJbECuzN7s5CHQuQFydOalCr3oR8Winqhl0PfrSCcCi0pqOBGcVTQqQhN2QepU3dWBCe1U2/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957955; c=relaxed/simple;
	bh=sQIib2a4T555M3r9e0VkDf/qT+Uy7dptHEDHa5dtQpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvBQFJlUZnGUkOUS0UebbEvjKUqHvrWlrXieYRaA9nl2I9Vu/SSH7If9RwlL8ugXo0ux08/khHVGYymU1Yx5sqkozmZLotuLVk0ptgdNdqCTC8+/jI7Cr+upOZdjEPpwzCa0TIEs22TfIb/4vLXNv7ROqKhXsVbEcm3q8GxCau0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzsoD8mY; arc=pass smtp.client-ip=209.85.208.46
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so203473a12.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 19:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782957951; cv=none;
        d=google.com; s=arc-20260327;
        b=WmIefYKFV0xrVJUSliZeTSDrxGg5J8+8fxGU58xDUGx335A5EMKhFh4/16kFen+G2s
         ieIZjw6Bctz7vS19Z2fgiVEXLatbWXTzLxyBLrFu9ZNwJDaWhGFKL2YdBLr8uxwd4pua
         KPQ1r4vI+yoMMhCORDvHDbXR1IY4m8RL25qMhIjd8JGjJLuRljtC7fh+jmkul9raor4X
         zeMg6ztYlXIIRX7aJ5gjcrjikmotpUq9fng6AVSZHMdhmZeslfMqk2AC8EHAUd/+NzmM
         BWxt9WcVJPAZa0lxm90FC1Xgah9zqJZa/OvSKR3OW/6z0NiQQ0J/cGMnjL2OC1OQohfd
         qB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lqmsGzRyf9KXMWuYwJ1qnqPOrw/78lVWzq4bTMsnek8=;
        fh=C1FVd8PI31p/l+yB/pJYAhbBlbXRY++5+P1zgIdUmtM=;
        b=JI9y8frn6LOUbOiJRMJRnQsxeAe4e/eU6EywBs/8x5RJQ+OaFfJ2m/6KhHUWCUmAcb
         7Y4waR94WBn/PWLX8CMwfHYMuXqcxzXLdGwUzKiJXRTNNMyCpEeAjwkuY1pebxC4pegv
         eAVBO5MsPCFH8qBzyEmiKMzggOk6MRyNYg4Sk2S0fndK0dMgWILMFdT9Uu22okDru0Vv
         aoAn91CLeaeZrnYv4iZQ6VcVpBFk6Bk3lI6uYoGs2e38vwTtX7UcNdNSsLRlS9EDz2GX
         SM8iLeFxRCuUC4ahS6tyIN0frMMj7DoPOKLGnH2ZNLq3QNZ2IZhJmXhdhl957/tibHug
         85Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782957951; x=1783562751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqmsGzRyf9KXMWuYwJ1qnqPOrw/78lVWzq4bTMsnek8=;
        b=bzsoD8mYmayeFYWM3KBYCvJha/GLk8Ssp2y7+HP/Y08eUCYSx68+xsfRYAMeA5Z2X6
         iUEj7a3a1E/9268JgO1/N4pgVY/DBkks+8HYqExZRzWr1L2PktQvSOeJz1IFManfk0g0
         aOOc8wbAec23+6lna7l88mvTSw/T6+hGXLLmjcDqnpbB5K8aJd2H0a12IlBEO9+G8je+
         epXeLbMe4KgPyVG6dX/iuK8tfRvaiqcRlHUhjIUooe163+SkDxVg3pOp5MIxCWddCy9f
         EKiUgvW8H1y/WjUDh3sc8qmwye3RrTKK0GEYF8ktCgHVEdHPP2/y015tGG7Ywu6e4sK3
         TtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782957951; x=1783562751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lqmsGzRyf9KXMWuYwJ1qnqPOrw/78lVWzq4bTMsnek8=;
        b=BzSOtv7QN6PDJAUQQpFgx+uuiJj/+U5dyLU03TTocAJ1dwxwoEa/y+YWUbC26xAu4U
         wp5yu8kqpp0JpElHdPI2xtmSiKT+FjV48PfK7X4ktRH4mnR6fBdY83uDkfJmWBPE09m5
         yKwolEqRiweWp5BgJHAyNrJIGdwoKU1uLeVg4jLeqfyh9tIfxM7sn0mqou7oidrFg+wT
         O/0ZgMDZ+vJ115uc28TP06+p022wJZ9rxUhUoq9KzfAJ1Gnie/kf4ZuZxGP9rf1DbXo1
         p9kw06XLi8ZeOwwWAG+EX2ONNxvvDiJHV49wx6ub/fsrTJ4IWv4dbzkrNaDCT9f+Ze8g
         1oZw==
X-Forwarded-Encrypted: i=1; AHgh+RpgyFepzB5n5MANmj+AHEssnZGyQl08yd1/flI3q5qI/34Q5Ex2pfZDzGDNaV0Lbk5LoDEOIu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUYrLBsKdrkDtr/+3fh1mUSEHVzzGI8U2Se4qc6ZsIXvE4s6RK
	G3KN7T4hLS3DNW5fGVk8vPUBV/fO8Rg6Pr/XdOc/lmK0JhbXmSH4u1qyCLNlSQ7xw19iZXpesGM
	uMaqF8P5iPI0ExJAVmHXX8lYO/lkOQT0=
X-Gm-Gg: AfdE7cl+A0LU/LUF8mgs1ieoYedkcY5zOjqJPMDt4hAUr8ulJEt3Li0fQncLDdVsuDN
	QsCebrqwFPsJaeS/9MX9HqUctaXfqQd5EGjIQjrgIraTt8ReEi6rmTV+CA6g77hSjaDmngh1GFI
	5Za+OFbd1eGJT7bbZklbfIumBoBu7++zeQwYBWp66leKxzzrN1ROQOMhUFAlgDoy1lFelIVn6xg
	nZn195xBxwjoA9vpitAzWiZS6LkrtCKFL3lv/KuIgrrttfOCJBa8snrWr/f2ibhrAvcFpc35wKS
	jBdwGI6vKzcnqEEeYleldtan9ChkBQMTOb7DOPX76w==
X-Received: by 2002:a05:6402:43ce:b0:698:3b7c:7e50 with SMTP id
 4fb4d7f45d1cf-6989f37df1cmr2025391a12.38.1782957951233; Wed, 01 Jul 2026
 19:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630070600.484-1-yimingqian591@gmail.com> <CAAVpQUC_EcpFf9GmNnD07KhFAOcPhrCa5xNF-idz0CsB=TJV9A@mail.gmail.com>
In-Reply-To: <CAAVpQUC_EcpFf9GmNnD07KhFAOcPhrCa5xNF-idz0CsB=TJV9A@mail.gmail.com>
From: =?UTF-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>
Date: Thu, 2 Jul 2026 10:05:39 +0800
X-Gm-Features: AVVi8Cf_QSah0g0A7OX-5JY5QlpZKuBsyf4LHvLf9bGF1X295pd1_ED5KQFV6N0
Message-ID: <CAL_bE8JU8fpwracSRC5ziiT=YMW-XRkYNsUEGGuoSOv0gYZcwQ@mail.gmail.com>
Subject: Re: [PATCH] af_unix: mark MSG_SPLICE_PAGES frags shared
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: security@kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lingchen5202005@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303912-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[yimingqian591@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:security@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lingchen5202005@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yimingqian591@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 297626F2F0C

Thanks, I agree plain AF_UNIX does not by itself provide the writer side.

  The concern was that MSG_SPLICE_PAGES imports externally owned pages into
  skb frags, while unlike TCP/UDP/KCM this path does not mark them with
  SKBFL_SHARED_FRAG. I checked the AF_UNIX sockmap path as well, but I do
  not currently have a concrete in-tree chain where those frags reach a
  writer that skips COW based on skb_has_shared_frag().

  So this should be treated as a defensive consistency cleanup rather than
  a security fix. I will drop the Fixes tag and the duplicate Reported-by
  tags in v2.

Kuniyuki Iwashima <kuniyu@google.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=BA=8C 23:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 30, 2026 at 12:06=E2=80=AFAM Yiming Qian <yimingqian591@gmail=
.com> wrote:
> >
> > unix_stream_sendmsg() splices external pages directly into skb frags wh=
en
> > MSG_SPLICE_PAGES is set, but it does not propagate SKBFL_SHARED_FRAG
> > afterward.
>
> I think it doesn't matter with the plain AF_UNIX.
>
> Please elaborate on the scenario where this could be a problem.
> e.g. sockmap ?
>
>
> >
> > That leaves later writers without the shared-frag marker even though th=
e
> > skb still references externally owned pages.
> >
> > Set the marker after a successful skb_splice_from_iter() call.
> >
> > Fixes: a0dbf5f818f90 ("af_unix: Support MSG_SPLICE_PAGES")
> > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > Reported-by: Can Liu <lingchen5202005@gmail.com>
>
> Reported-by is not needed when it's identical to SOB tag.
>
>
> > Signed-off-by: Yiming Qian <yimingqian591@gmail.com>
> > Signed-off-by: Can Liu <lingchen5202005@gmail.com>
> > ---
> >  net/unix/af_unix.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index f7a9d55eee8a1..f2cd0f8ec0914 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -2458,6 +2458,7 @@ static int unix_stream_sendmsg(struct socket *soc=
k, struct msghdr *msg,
> >                                 goto out_free;
> >
> >                         size =3D err;
> > +                       skb_shinfo(skb)->flags |=3D SKBFL_SHARED_FRAG;
> >                         refcount_add(size, &sk->sk_wmem_alloc);
> >                 } else {
> >                         skb_put(skb, size - data_len);
> > --
> > 2.34.1

