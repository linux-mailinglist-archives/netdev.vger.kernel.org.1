Return-Path: <netdev+bounces-266701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKrzCgybsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:40:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8262E2677A3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FA5C3023DFA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6147F37106D;
	Wed, 11 Mar 2026 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDA6e0Km"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CAE3DCD89
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247113; cv=pass; b=R+mC0lx+iVW2lpruoMl2qksif8yjQcfH+MDZA5z7LEOuJ9Sn0fyBJt6JCTwMJtXgsGR2eOeOoQwzvlxxcPnlcgZRD61vhp6IGL+sW8lARP5TT1B8GH1vHii7lq2PqrSxKxgxpquIjnzHCpneOFR8+N4/ZLZ/pW84ih++M0XeoEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247113; c=relaxed/simple;
	bh=AMMI15d+s7pTmfoE1fiMuQZTwNVK4nGX6l+tsFLNgrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcKV1mFZDYSblziIUn6bkZeHMV0wqmulOyjEgOR6NSCafV6oc09Jn6AhnQdPsj+eTnFqRuafcb9iiPJNdRx5scYfKrK51kNY+yU8QtMQ1IFIGpTYcB/Ge90IG/X3mgJZwTWnwK/wpxmRHHPssjFfeeHCvHfLOChcVgNk5bT2Gpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDA6e0Km; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ad9238d8fso91824d50.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:38:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773247111; cv=none;
        d=google.com; s=arc-20240605;
        b=BKVpg26BXAjxCi24ziXqvb/5NxQO4BfFcCLzf502QUUuiXgcwfuVPaGjBZDnGXw8Q1
         2IVZK3P1kouQvg3p38fBqTyRu+U7jhcDpqFYfnfMj/1JQrZqwHBfFcEL4Tjf38p8M/cR
         GVoYjc2KyU27TxeUOvJxks8swScKoe08xib8jcRQDIX1yJqMLUqNCx0VciH5nMKLMiWb
         2gQrIvwfq3Cza638GOWsQ7t7l7jImvrtORBaT5cMtcSjRYy3Kz8WYmzruIw6CFyaZ9HR
         7lYQ5PMEDMPf6JOaFPm8uPptc0oD3UHbxQUbQZ533bxSV52odVADISMR9T1e/mhWKJXu
         QNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6fElsDI5EEh6ALprW2iuuzCdvhv2CT1kMYpnMsm1Ty4=;
        fh=awogf4R/BygijoSg4MJcJk8j0yY1Pjt8mbkCSNiS64o=;
        b=bBKj/0yWVzwzrvnf2eXJL3qBgM7lCfxoE4EOrKtNUwnF5GImaHfdbyx4cJqSLRORCi
         twut4G+Ju+mInzrl8U5uFaXq9Cw+ugJ8rj0dOP1FZJaYLihNO6+IFTD3Hlc59UG0qqm5
         egLZvv/9yex0/Fx+eNmvhNbET99+/I0p6Er37MNUZsPMaLOwAD2d39BW+x7hMS/wFK77
         vMfRs71yHt1/VK3tQMgve2JAS9TBvYQIE2qsJSOkt/sDTnCGY7Oos7hg2X9x/me9RFis
         VwA+WbqKsCxfI4lldQubChG7AHGqOlxZlylPfb1md3c7HGLPWYE5DR1z8+zM5CSruIQZ
         jWYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773247111; x=1773851911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fElsDI5EEh6ALprW2iuuzCdvhv2CT1kMYpnMsm1Ty4=;
        b=JDA6e0KmSuuoNsJ0kUKVDpQWfcwCtSCHyB2bz9sxFUDvAIgzOlVLFT75sC2k/L9nje
         IZkQYuVWnVT/5g83VtO/lJWwTuQhDTnQFWDmixPzfeG6TZpWOyvzhKsM/TtarWd9YiZU
         s6ooRczlO6qLovgbo9JJKADByu4PvbcJYF9rDPjemsfD6BVNqLmk1g2pxs/JTx9RUwEP
         DZNcvQbY6lgnYkbeLELsG5MDRaDhOaStFK9814uzIRrvxCvKlVKGMtEe544XXCcQvrcW
         fpoX1cDmLsl7efz833uAI+EWWiIOoj1dSh/WX0J+h9M+Lvm5JCfXMQS6V5LqV9qOKt68
         Ko2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773247111; x=1773851911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6fElsDI5EEh6ALprW2iuuzCdvhv2CT1kMYpnMsm1Ty4=;
        b=Gly0YIqPZKkcddgzeTfylbGIv3duO437+8qK6NlixVzdfHIqt729Ce9e5aHTi8204I
         GFXFN/ga1tLADdPdnmI0cvhEXYtd+eps369TOVk9O61a3o9Q4de3fw8ikaBCCZ/0Ggoi
         JhkzuH0GwlshKoxqbI8Xl3rVgoCFiozCdL1X6fwzwCHydCn66jn6kfwo414vhJ4CnOWF
         +izh8Td5mfYXVb1Y5D1HOBmeehCyZvPv4O8yAjkevQjwjzYF6ykegNoqRaSSjiLrCKMQ
         aRcqjvW7xyBY0H7oRoNoynw/vlm8VH67k/JQ/6opVQVZ8IfpW4ozo37cnpnxnrrUlI9j
         XHfA==
X-Forwarded-Encrypted: i=1; AJvYcCVa0sSSefXU9lou7crOg3H5ANtZHpOFzP5aUTQiEhUAGYfL9a4DeBaGHQAuo5N7EJRPPkEsb/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxcm1kevypKDZhtZ30C7FRypolNajxNoZVicNuZzIBBUyjHP31
	DkdWMgsGSaARDARlAvhBcjTOzJt1R+k5q4cLnAHvuMGLh7l/pU71PMfMzRjFMXQjpGe+IhTxqcW
	vUus3f+198H8QbyQOQpO8gjbb/GiffLU=
X-Gm-Gg: ATEYQzyPXB80/3ubC1fJVMXEEVpDkj0GAIQFM57p0RqVgMGlvy5MzRW/AZGDXwWEpJX
	P7wtaS0bfnYsgDVsgcWFtD6eLQjBf9bmGXoXDxWVEgL1/YOpdu56sOaNpsD29Lz+qFbMuIOK16K
	wQeGO/Xg45lhoVp628eD5j1z+kE479/lvI8z58duEMrFyhoHecf3z1q/6pniinoQOM5VuN8ySqM
	SkRlV6fAII2Q7Kq1Ay238hp64f4s9D8vjXgdhGy0B+qwt/3IpAq9gd06HEFQKXT53ooEgJ93FLT
	jnhQDZM=
X-Received: by 2002:a05:690c:6e83:b0:798:2cd4:5567 with SMTP id
 00721157ae682-79917fce634mr31914247b3.56.1773247110914; Wed, 11 Mar 2026
 09:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-3-ameryhung@gmail.com>
 <87ldfytmja.fsf@gmail.com>
In-Reply-To: <87ldfytmja.fsf@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 09:38:19 -0700
X-Gm-Features: AaiRm51dqOIMR6ioMceqANJxWV3HRlorIvLhVhQ8U3y78KKMZL76mjWV4QQeICA
Message-ID: <CAMB2axNWHa9aTigQ4G1zxuYtzC7QNj1KVQZNoFiY9fNMhUBsCg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 02/11] selftests/bpf: Test passing
 CONST_PTR_TO_DYNPTR to kfunc that may mutate dynptr
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266701-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8262E2677A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 8:26=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Amery Hung <ameryhung@gmail.com> writes:
>
> > Make sure for kfunc that takes mutable dynptr argument, verifier reject=
s
> > passing CONST_PTR_TO_DYNPTR to it.
> >
> > Rename struct sample to test_sample to avoid a conflict with the
> > definition in vmlinux.h
> >
> > In test_kfunc_dynptr_param.c, initialize dynptr to 0 to avoid
> > -Wuninitialized-const-pointer warning.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  .../testing/selftests/bpf/progs/dynptr_fail.c | 37 +++++++++++++++----
> >  .../bpf/progs/test_kfunc_dynptr_param.c       |  2 +-
> >  2 files changed, 30 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/te=
sting/selftests/bpf/progs/dynptr_fail.c
> > index 8f2ae9640886..5e1b1cf4ea8e 100644
> > --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > @@ -1,15 +1,14 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright (c) 2022 Facebook */
> >
> > +#include <vmlinux.h>
> >  #include <errno.h>
> >  #include <string.h>
> > -#include <stdbool.h>
> > -#include <linux/bpf.h>
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> > -#include <linux/if_ether.h>
> >  #include "bpf_misc.h"
> >  #include "bpf_kfuncs.h"
> > +#include "../test_kmods/bpf_testmod_kfunc.h"
> >
> >  char _license[] SEC("license") =3D "GPL";
> >
> > @@ -46,7 +45,7 @@ struct {
> >       __type(value, __u64);
> >  } array_map4 SEC(".maps");
> >
> > -struct sample {
> > +struct test_sample {
> >       int pid;
> >       long value;
> >       char comm[16];
> > @@ -95,7 +94,7 @@ __failure __msg("Unreleased reference id=3D4")
> >  int ringbuf_missing_release2(void *ctx)
> >  {
> >       struct bpf_dynptr ptr1, ptr2;
> > -     struct sample *sample;
> > +     struct test_sample *sample;
> >
> >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr1);
> >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
> > @@ -173,7 +172,7 @@ __failure __msg("type=3Dmem expected=3Dringbuf_mem"=
)
> >  int ringbuf_invalid_api(void *ctx)
> >  {
> >       struct bpf_dynptr ptr;
> > -     struct sample *sample;
> > +     struct test_sample *sample;
> >
> >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
> >       sample =3D bpf_dynptr_data(&ptr, 0, sizeof(*sample));
> > @@ -315,7 +314,7 @@ __failure __msg("invalid mem access 'scalar'")
> >  int data_slice_use_after_release1(void *ctx)
> >  {
> >       struct bpf_dynptr ptr;
> > -     struct sample *sample;
> > +     struct test_sample *sample;
> >
> >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
> >       sample =3D bpf_dynptr_data(&ptr, 0, sizeof(*sample));
> > @@ -347,7 +346,7 @@ __failure __msg("invalid mem access 'scalar'")
> >  int data_slice_use_after_release2(void *ctx)
> >  {
> >       struct bpf_dynptr ptr1, ptr2;
> > -     struct sample *sample;
> > +     struct test_sample *sample;
> >
> >       bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr1);
> >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
> > @@ -1993,3 +1992,25 @@ int test_dynptr_reg_type(void *ctx)
> >       global_call_bpf_dynptr((const struct bpf_dynptr *)current);
> >       return 0;
> >  }
> > +
> > +/* Cannot pass CONST_PTR_TO_DYNPTR to bpf_kfunc_dynptr_test() that may=
 mutate the dynptr */
> > +__noinline int global_subprog_dynptr_mutable(const struct bpf_dynptr *=
dynptr)
> > +{
> > +     long ret =3D 0;
> Why do we need this long ret? Do we even need this function at all, why
> not calling bpf_kfunc_dynptr_test() directly from the
> kfunc_dynptr_const_to_mutable()?
> > +
> > +     /* this should fail */
> > +     bpf_kfunc_dynptr_test((struct bpf_dynptr *)dynptr, NULL);
> > +     __sink(ret);
> > +     return ret;
> > +}
> > +
> > +SEC("tc")
> nit: it looks like most of the programs in this file are optional:
> SEC("?tc").

I will make it SEC("?tc").

> > +__failure __msg("cannot pass pointer to const bpf_dynptr, the helper m=
utates it")
> > +int kfunc_dynptr_const_to_mutable(struct __sk_buff *skb)
> > +{
> > +     struct bpf_dynptr data;
> > +
> > +     bpf_dynptr_from_skb(skb, 0, &data);
> > +     global_subprog_dynptr_mutable(&data);
> > +     return 0;
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.=
c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > index c3631fd41977..1c6cfd0888ba 100644
> > --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > @@ -33,7 +33,7 @@ SEC("?lsm.s/bpf")
> >  __failure __msg("cannot pass in dynptr at an offset=3D-8")
> >  int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned=
 int size, bool kernel)
> >  {
> > -     unsigned long val;
> > +     unsigned long val =3D 0;
> >
> >       return bpf_verify_pkcs7_signature((struct bpf_dynptr *)&val,
> >                                         (struct bpf_dynptr *)&val, NULL=
);
> > --
> > 2.47.3

