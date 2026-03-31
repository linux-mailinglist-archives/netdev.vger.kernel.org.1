Return-Path: <netdev+bounces-273464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGQpMLdWy2leGgYAu9opvQ
	(envelope-from <netdev+bounces-273464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:08:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F62363FEE
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0DAF304BCDD
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699662C17A0;
	Tue, 31 Mar 2026 05:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="EvgGVUjA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E826F29C
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774933476; cv=pass; b=BbzDr1ZdKMQeyKTjo9UqcYar2nCRkeC1QZJECGwdlWX5qs199fIFR7X8s/PbIk151qZKw0qba+GPWpKSfe1wEEBIUv27l3xROSQc4piRMb8rq5aq79sNG+JQTnzEGxV/PXJr/1wFjPPXXmb5kRZUxSghsgbWWT9n23JIKucd8ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774933476; c=relaxed/simple;
	bh=yxuYuBbZLIwABdZ2s1R8xVIC2dfGrQJOJmCtx2LBLD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZVprX3EDUCdP3KKaNmxM9Ww0zmfdXGFqblpE7dKx0seQU8eql0ynAQBMgKCUZo91n5Ba8Jxo8M5jTEC+vbo/STWeTND3px9lZrJLdlloq7VNtIMygRC4cpZqYjNExH96tjyaz1Fe2q8zKb7BGf2ZeCUE8RYHiQWxqMJM/cdSQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=EvgGVUjA; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35691a231a7so3160782a91.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774933474; cv=none;
        d=google.com; s=arc-20240605;
        b=FWxDZPxWwRdvqlzEQcjndJqhb9miOoW9PGBilWUNSEquNcjWKfofNm7O2/Vm5S0L4B
         FOmpOJwkJuyyYPZDFmaYEfXpOizY+Ya/kGU7w2xyN9p+oFZYnvZtvXTb8Sl0FsF58pXe
         6+iPoURewf9b/oYovaM+q2vTfwMkWh468O7sEjJhBaBKnMkmUQmPokL3TW/75A7LhpVU
         CJUsjzTozO2knQe9xS0Zy3rV3/+c7UueN+4Lkiw9GAn3M7xY3MdWiRI0aiX4xZR7et6r
         9PkKFi/Wf2tpYrmEev+Pe/SNm7riKT5xp0h0m3v5zTqQnDOsQMfY3lXuUsdWV2jO9COQ
         gjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O589+KG73YRiVveb5lGSVstjuhdF+WQeOyYRzkjPUw0=;
        fh=3W4N1w/UneWPW+V1QBX3z4cBFv1iSdVk99a7cOuhe20=;
        b=OIxPjhuBMmloLr9j4NxRl4ST3httGG3hIZ4OOJ2+yon09rWTuJbgMCRSQaE2584Xt1
         hnS2UbIlf78zwNTswB0XFJJFYyj2Lq8d2CVHTleJd8IjiU27GngUBymczpHzxESIScs1
         garCWxQa+m9YRcqy0VhWCdpFub+xBAeYJWys2bdYEfOsUQQgqMGT0PF5p2QpNJm6uzfB
         zNXuyWxW78h8ikeSr9XF6ndgDpL61fIezjx9d3DhulUf3l6R1nyGUljn+0bswXC7uYPO
         DBzMUBYu/6a3ThWziLfj5UcWYeCUts+lmQjK3z3nxkRzckl3XOTfKXNzwKsNmmAH2bS6
         Qm1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774933474; x=1775538274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O589+KG73YRiVveb5lGSVstjuhdF+WQeOyYRzkjPUw0=;
        b=EvgGVUjAyOx4pDRqcGmdJV0e9H8sYx3m653ediO0ti8RkmJRe3UAXQ7P1OSB6aZpws
         NkLtiOAc33J2pCDvz/UC0SJPS8c4bkCg4thoRHHk0i0hDtNY6YfLzGeDdsKyRTuD3E1L
         XwIYq4Ythn++PoGQ8gAyXwAsbKGGiGbL8OVL7K6tURfK7kGSGGK4NwOOitBq42yrNch9
         3n7QQaZrleH9M6avgIBkvZ4VZisb0+yo45EtalseJvtpUeIhzGPfWzwuMBGO5k9/MIJb
         6LsTyENxP3W9hEjrgke92n2cWD8KGc4ZYWNjPJouSEoG2uK7GEtXlTzv8lwisKRMpDIa
         4bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774933474; x=1775538274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O589+KG73YRiVveb5lGSVstjuhdF+WQeOyYRzkjPUw0=;
        b=E9lwDKD/p1j+tww75aLplGNXpUKGwLWgyxahKzIER/4IOlZAftrFnJGIWMPkXRA7NB
         kFWWg8vzzAMSWTWIoNdYbW4fZgGgBe4dY/dlpMvSOtBdY9H1mDmRWwoaw9iI6lbeuI0K
         Dhab/saeFFxdw1TLpdWcTdifSTdHQi1yPtpC6p7kgAuZNvcWx1ZgGNwtAwbgt4dTJ/NF
         kc7eKNfOA+1+hrHh2wCVc+T//zmo+lMqftdcZtNawpWFcVD4hA8tT12IjnmjXT+PHIWC
         Isd21Nr7KmS0OTsaZVJe1N4LPfpm6M9C7pkKWJePolebQouYKTZHJWhcmOQKMM8Pe/Qj
         i7OQ==
X-Gm-Message-State: AOJu0Yxb+Xvb03S5Bfq6QfHS1mjcQ5Qu2LzgWWfnwWAlUCYm1IhpPILw
	G+N+vOWlkMra4bouCf9PfY8DxlBSdVE+aXO7xX0iIWHsH/yUX9frxxajLqAIAkdpHdGEhew8uCm
	nNbWo6YpwYfeDCiPbmwvPBgWcSqkvzWtFsXtUFlZN9IaZ1lT+/m4=
X-Gm-Gg: ATEYQzyWduaWwCsKWWFV9GkNxOOs0UO+4EWblcXMK38hvMvHzZcI7kQrELMRYwS4JaD
	YSOUsaveJvzc7ZStmMT7sISq7jj7oct+q+pYn8JbCLXfLgNyOnsvnYD/BsJSk7Zoev2UBxa5qEA
	pgidMar1eBoY+t5UBUtS/gs1hPgxOngnVMkFjfNHcY2kc5m55peULel1+dAJDv/8dA0ppdYuwt3
	0Z8F/MhkLQvszeD9nFN+a1Hfzaka5zmMJgsb0wN0fcM6l2B/TwlvKqZKKK8ohxIlgG4JMbJwZC5
	af8TaOas
X-Received: by 2002:a17:90b:1850:b0:35b:a418:698c with SMTP id
 98e67ed59e1d1-35c2ff7cdefmr14554841a91.12.1774933474349; Mon, 30 Mar 2026
 22:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327061300.3066844-1-xmei5@asu.edu> <CAM0EoMkspiNjXpdwnG2HaPK3n+BJkjTRbA8k4TsV4fcVk7g_Zg@mail.gmail.com>
 <CAM0EoMmVey4ayJBZgogMO4S3Z-_n5oDfasdZyiVryEqCNqu6bw@mail.gmail.com>
 <s52rg5clqff6z44qdnjcthqhp3bhyzqn322esxj4caw7tqtkdw@2povbhh5efc7> <CAM0EoMnNp2tV1Gn7a8KFMhUnQAWs0FDzb6bMUwhHtfPz-Uiqmg@mail.gmail.com>
In-Reply-To: <CAM0EoMnNp2tV1Gn7a8KFMhUnQAWs0FDzb6bMUwhHtfPz-Uiqmg@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 30 Mar 2026 22:04:23 -0700
X-Gm-Features: AQROBzCV5guvS8XN79wE-76rBfTKqbMv0N_FJ6gKESKq0g04Jr8uMhe-4Gh-O6Q
Message-ID: <CAPpSM+TkV_sCbUazQE6rrXr6dDaAo99WQP4ofLFWhbAsgsjjkw@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net/sched: cls_fw: fix NULL pointer dereference
 on shared blocks
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-273464-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,asu.edu:dkim,asu.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26F62363FEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the review and advice. It's a better patch. I have sent the v3:
- for cls_fw and cls_flow, we check in fw/flow_change
- Adjust the tests

Thanks,
Xiang

On Mon, Mar 30, 2026 at 9:46=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sun, Mar 29, 2026 at 2:52=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
> >
> > On Sun, Mar 29, 2026 at 08:15:17AM -0400, Jamal Hadi Salim wrote:
> > > On Fri, Mar 27, 2026 at 10:11=E2=80=AFAM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> > > >
> > > > On Fri, Mar 27, 2026 at 2:13=E2=80=AFAM Xiang Mei <xmei5@asu.edu> w=
rote:
> > > > >
> > > > > The old-method path in fw_classify() calls tcf_block_q() and
> > > > > dereferences q->handle. Shared blocks leave block->q NULL, causin=
g a
> > > > > NULL deref when an empty cls_fw filter is attached to a shared bl=
ock
> > > > > and a packet with a nonzero major skb mark is classified.
> > > > >
> > > > > Check tcf_block_shared() before accessing block->q and return -1 =
(no
> > > > > match) for shared blocks, consistent with cls_u32's tc_u_common_p=
tr().
> > > > >
> > > > > The fixed null-ptr-deref calling stack:
> > > > >  KASAN: null-ptr-deref in range [0x0000000000000038-0x00000000000=
0003f]
> > > > >  RIP: 0010:fw_classify (net/sched/cls_fw.c:81)
> > > > >  Call Trace:
> > > > >   tcf_classify (./include/net/tc_wrapper.h:197 net/sched/cls_api.=
c:1764 net/sched/cls_api.c:1860)
> > > > >   tc_run (net/core/dev.c:4401)
> > > > >   __dev_queue_xmit (net/core/dev.c:4535 net/core/dev.c:4790)
> > > > >
> > > > > Fixes: 1abf272022cf ("net: sched: tcindex, fw, flow: use tcf_bloc=
k_q helper to get struct Qdisc")
> > > > > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > > > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > > >
> > > > Thanks for also providing the tdc tests. Looks like a bizarre bug=
=E2=80=94and
> > > > in my mind the question is does fw or flow even factor into tc bloc=
ks?
> > > > Please give me time to review if the approach makes sense - perhaps
> > > > this weekend.
> > > >
> > > Since the fix is exactly as what u32 does - why not move
> > > tc_u_common_ptr() to a header file (pkt_cls.h)? then reuse it in u32,
> > > fw, and flow.
> >
> > Thank you for the suggestion, I appreciate the review.
> >
>
> Actually on second thought - why dont you fix the fw one so it catches
> things at control time? Something like:
>
> --- a/net/sched/cls_fw.c
> +++ b/net/sched/cls_fw.c
> @@ -247,8 +247,18 @@ static int fw_change(struct net *net, struct
> sk_buff *in_skb,
>         struct nlattr *tb[TCA_FW_MAX + 1];
>         int err;
>
> -       if (!opt)
> -               return handle ? -EINVAL : 0; /* Succeed if it is old meth=
od. */
> +       if (!opt) {
> +               if (handle)
> +                       return -EINVAL;
> +
> +               if (tcf_block_shared(tp->chain->block)) {
> +                       NL_SET_ERR_MSG(extack,
> +                                      "Must specify mark when
> attaching fw filter to block");
> +                       return -EINVAL;
> +               }
> +
> +               return 0; /* Succeed if it is old method. */
> +       }
>
>         err =3D nla_parse_nested_deprecated(tb, TCA_FW_MAX, opt, fw_polic=
y,
>                                           NULL);
>
> Also for the flow one, can you add an extack like above.
> Note: This will change the nature of your tdc test, you dont need to
> send an skb marked packet anymore since your config will be reject the
> setup..
>
> cheers,
> jamal
>
> > I spent some time exploring how to reuse tc_u_common_ptr() in cls_fw an=
d
> > cls_flow, but I'm not sure I see a clean way to make it work across all
> > three classifiers. The core issue is that they need different things
> > when the block is shared:
> >
> >  - cls_u32 needs a pointer value (block or block->q) as a hash key for
> >    tc_u_common lookup
> >  - cls_fw and cls_flow need to bail out and return -1 (no match)
> >
> > If we keep tc_u_common_ptr() as-is (returning void *), the usage in
> > fw/flow would be tc_u_common_ptr(tp) =3D=3D block to detect shared bloc=
ks,
> > which is less clear than tcf_block_shared(block) and doesn't save any
> > code.
> >
> > If we rework it to return struct Qdisc * (NULL for shared), it would
> > break cls_u32's current usage where it needs the block pointer itself
> > as a hash key for the shared case.
> >
> > I may be misunderstanding your suggestion though =E2=80=94 could you sh=
are
> > what you had in mind?
> >
> > Thank you again for your time,
> > Xiang
> > >
> > > I am still questioning the value of using blocks with these two
> > > classifiers and unfortunately the commit message of  1abf272022cf was
> > > not helpful.
> > > The testcases look good. Please add a letter head, perhaps quote the
> > > comment in tc_u_common_ptr() since it gives a good description of thi=
s
> > > whole dance.
> > >
> > > cheers,
> > > jamal

