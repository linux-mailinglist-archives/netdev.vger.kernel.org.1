Return-Path: <netdev+bounces-266709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHnMKPKesWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:57:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A18FE2679C2
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC14930086A6
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0933E1236;
	Wed, 11 Mar 2026 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzROdWa8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096DB27F19F
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248233; cv=pass; b=gAP9nSvl8Ke5DhWKqTTk7SRYW+BxNrRfHly2gpDbh1CNuXcW6vE/H+VeNZh5Ta1DlMy+1cNGnxo/Qeha/JGPrxRwxVXOZI/MnKQCfG9yccco+bG+kPrZ3BpcgWpC8P31tR8+3DAJuDxeYy95uxCewEGruL42pBCLBhnmDr3NpMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248233; c=relaxed/simple;
	bh=BRB3wDLz/jn2nOvVLIccx2wENPSwD58xFUwhfC4aI9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbeugWkZaKAWFyha/ub90NUW/9Ch5LhYTfUm61ITTAdfEU6RXEBcbWI+eWJLTT+7Bcn9n4wpwjLbS6IQOhPDIG8CIud98kjof0IhRPwILyQPa7CRvQIg9thjkUIdepadwf2p44tm0EHIF6B/m2lHRnMRRj4e6/Bt3kVb0GDO334=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzROdWa8; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-797ab169454so380687b3.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773248231; cv=none;
        d=google.com; s=arc-20240605;
        b=Di8TjllNymHx+hcRY3IQTEkzCTKbu/1h+F2mBRMmbycqQtq68mUOXA060GPLUBMN0c
         qVhoe/QO2Gt2keaevsLx0zc+oTZzl7J7dFcN9Er/wmY1T+5G1aE+3xR3Os6RWfOBdjzg
         Eoc4EYuQxz24CBv2zw0ZVZgNv3ySASB0BKLTZr0knrXgr0/lsDF+ROtt/CF+CQyD/ywq
         jHFFOKLzgaDiQW2mp/pmzUBT2ynC248UEKEqMEwkORUbZ+AQaLa+Xr2rStb8BhtfTyPp
         Ao0O86xBJyGMMmm04uR4m2LtbzLKWJu5z4l3ulvUvHHk61YrNpSyhTgw1iE068uySp3+
         432Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MRLF7utSMB+F1MK0j+aEXx5BvijhWq8cP3RtjVJVGqE=;
        fh=Tj6K8gTuPhTbuYPJJ40QstBlVOn++gRk+ZSAz9M/72E=;
        b=IxhXGpz6jUHHKAZS3wlqf9t43b+Gz9IbVa/S38V8dKcjihm9yJqQaJTcpDWNGtagBi
         l4EJTNtfxhP2+CX8lIRzWrf4V9QuBRHewmJSYUvYCUzZ/dUwX0/iYpF+XxSAw3fh6yRV
         I5G9gLDgVU9Iu/N6MVVHNUxbXKgGVShfQkFpOvpD1lZn0XcrtxIs1GCoJHnfwJ/QHWk/
         LmTeLTaISiygDBJ2AvpGPICRRrJZlDhU7+4nikLI4SH2MVvmHgfkbjtm65xqY1R+XzlE
         3iYuWJ/v2Xc+Jifnq/EkkpvB7w93dErR1jw5NSzP9fO69ybw7aVICpddhy+dO7VJBTfG
         24Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773248231; x=1773853031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRLF7utSMB+F1MK0j+aEXx5BvijhWq8cP3RtjVJVGqE=;
        b=jzROdWa8+OThkXfxjY7iBbfEA5r41YOAumqUS/+CP/6mBPFm9n4LBgyhhhRAXqh75V
         emGEP9n7Pc9eDeiN84N2QXVq2taAsPQS2Nr+BwruIDoeZKn9yPRygRdB5xV3fVcAault
         7zlqWIfgpKi3Ef2wIrQ6lHBmPg/YlA5wGfmovEB8VibbIYoHXbtZXHUWOfmlu2YLf4H9
         oERNu0urlrBrCL6wM3V8eqFVopzIMmbS0PaI7e6glbFS5HJOHJ8SfadimyhuZBcBHsMB
         SZ6604rHu8kSWlrNm2fVxAbTu+pjM0emU0aoRMfX8ZqscV7RsT58SQG+tFEjrNMwP739
         4m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773248231; x=1773853031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MRLF7utSMB+F1MK0j+aEXx5BvijhWq8cP3RtjVJVGqE=;
        b=drVihpjquGnVBjIzoh4UPFX6rwmu2LG4qqaQwJ1j0OQbvWdHeJpEx5dBidkxEf1LdV
         SCdPdaBG2aFzUbH0bLkhiCtB/ztb/Np0Ym6ZAGR5aGLxMtBzA7z4edNtDAt1JYWaqwop
         qn1OAo9zoV9BLUGQU1Acj8gSBZWXoRX/B6ZMI/otzSqFgSmYj12IeENxeN2cqMti5kEi
         bVivA6OfhWVnudVFnF7fi+7Tu10ng5r1zbavnjIlv90+SR9Ud1+RPOJk02LDVZCq1kIC
         BraC1TLz22RxVfpXAXchRcddG/OiB04eAODTPMmrSyJYhuagySV+j83Y6I93Ae8Cv0jD
         OlMw==
X-Forwarded-Encrypted: i=1; AJvYcCWfLJxrHgtn/dToKdlgoc3JIM7EZC7QtgO5HVtZhyHDQdgThmNr6iclwl1OneZ1gK8ZOhZkFT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2XY7oEIWGLPP42CVbo2QiuZ6cu8iAJJT4aemRiGCFi0Kzsgd
	ay42CQoGWm1+fNiU7nv0kvpDZ4N9sEPpnGX6K47GGNzXcuJM9fa2miblT5ZpUDlsx57NsjQpF5r
	VsKcsqSzxgPPr1NzVrS+Uz+IYj38lk0Q=
X-Gm-Gg: ATEYQzyCG/UWql1So2+dBN+RaZUQHLC7ttCTf0OmxZ1Nlb6mmKY6yqN1kpEgFfeH29X
	7Y5c1uly07gSYXRP0d6YBW2INqY/Su62acRsEAWjKIH3uulKc9+uzRM30vMOgkIBtrPrkUf/SVZ
	GzIAa3Aqr6jON7huzg/Rtjnp6Dk47zDCsCBgBDhIaiainaH+GMG1WWugHPfMKuqF7XI8yuNnv93
	6/EPZpDvWfHhN6WzouKwcMIYdsRmcOa+x3jD/w9hcIj2l0h4apX+pjo0Xdi3TjqdcWSFKnUvgEA
	OoS4scc=
X-Received: by 2002:a05:690c:22c6:b0:798:36:e110 with SMTP id
 00721157ae682-7991801ac2cmr30369447b3.62.1773248230893; Wed, 11 Mar 2026
 09:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-3-ameryhung@gmail.com>
 <87ldfytmja.fsf@gmail.com> <CAMB2axNWHa9aTigQ4G1zxuYtzC7QNj1KVQZNoFiY9fNMhUBsCg@mail.gmail.com>
In-Reply-To: <CAMB2axNWHa9aTigQ4G1zxuYtzC7QNj1KVQZNoFiY9fNMhUBsCg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 09:56:59 -0700
X-Gm-Features: AaiRm51CQMvijRuppXo8FNftbSnpPNiYu2yHtuE3TPP_jR4RQ3GRPGA6-QxhbCA
Message-ID: <CAMB2axM2y2zZxCf5e4rmgK5yB4t14Oqn2-3_+xVHbVmWmOXycw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266709-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A18FE2679C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 9:38=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Wed, Mar 11, 2026 at 8:26=E2=80=AFAM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > Amery Hung <ameryhung@gmail.com> writes:
> >
> > > Make sure for kfunc that takes mutable dynptr argument, verifier reje=
cts
> > > passing CONST_PTR_TO_DYNPTR to it.
> > >
> > > Rename struct sample to test_sample to avoid a conflict with the
> > > definition in vmlinux.h
> > >
> > > In test_kfunc_dynptr_param.c, initialize dynptr to 0 to avoid
> > > -Wuninitialized-const-pointer warning.
> > >
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  .../testing/selftests/bpf/progs/dynptr_fail.c | 37 +++++++++++++++--=
--
> > >  .../bpf/progs/test_kfunc_dynptr_param.c       |  2 +-
> > >  2 files changed, 30 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/=
testing/selftests/bpf/progs/dynptr_fail.c
> > > index 8f2ae9640886..5e1b1cf4ea8e 100644
> > > --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > > +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > > @@ -1,15 +1,14 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  /* Copyright (c) 2022 Facebook */
> > >
> > > +#include <vmlinux.h>
> > >  #include <errno.h>
> > >  #include <string.h>
> > > -#include <stdbool.h>
> > > -#include <linux/bpf.h>
> > >  #include <bpf/bpf_helpers.h>
> > >  #include <bpf/bpf_tracing.h>
> > > -#include <linux/if_ether.h>
> > >  #include "bpf_misc.h"
> > >  #include "bpf_kfuncs.h"
> > > +#include "../test_kmods/bpf_testmod_kfunc.h"
> > >
> > >  char _license[] SEC("license") =3D "GPL";
> > >
> > > @@ -46,7 +45,7 @@ struct {
> > >       __type(value, __u64);
> > >  } array_map4 SEC(".maps");
> > >
> > > -struct sample {
> > > +struct test_sample {
> > >       int pid;
> > >       long value;
> > >       char comm[16];
> > > @@ -95,7 +94,7 @@ __failure __msg("Unreleased reference id=3D4")
> > >  int ringbuf_missing_release2(void *ctx)
> > >  {
> > >       struct bpf_dynptr ptr1, ptr2;
> > > -     struct sample *sample;
> > > +     struct test_sample *sample;
> > >
> > >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr1)=
;
> > >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2)=
;
> > > @@ -173,7 +172,7 @@ __failure __msg("type=3Dmem expected=3Dringbuf_me=
m")
> > >  int ringbuf_invalid_api(void *ctx)
> > >  {
> > >       struct bpf_dynptr ptr;
> > > -     struct sample *sample;
> > > +     struct test_sample *sample;
> > >
> > >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
> > >       sample =3D bpf_dynptr_data(&ptr, 0, sizeof(*sample));
> > > @@ -315,7 +314,7 @@ __failure __msg("invalid mem access 'scalar'")
> > >  int data_slice_use_after_release1(void *ctx)
> > >  {
> > >       struct bpf_dynptr ptr;
> > > -     struct sample *sample;
> > > +     struct test_sample *sample;
> > >
> > >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
> > >       sample =3D bpf_dynptr_data(&ptr, 0, sizeof(*sample));
> > > @@ -347,7 +346,7 @@ __failure __msg("invalid mem access 'scalar'")
> > >  int data_slice_use_after_release2(void *ctx)
> > >  {
> > >       struct bpf_dynptr ptr1, ptr2;
> > > -     struct sample *sample;
> > > +     struct test_sample *sample;
> > >
> > >       bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr1);
> > >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2)=
;
> > > @@ -1993,3 +1992,25 @@ int test_dynptr_reg_type(void *ctx)
> > >       global_call_bpf_dynptr((const struct bpf_dynptr *)current);
> > >       return 0;
> > >  }
> > > +
> > > +/* Cannot pass CONST_PTR_TO_DYNPTR to bpf_kfunc_dynptr_test() that m=
ay mutate the dynptr */
> > > +__noinline int global_subprog_dynptr_mutable(const struct bpf_dynptr=
 *dynptr)
> > > +{
> > > +     long ret =3D 0;
> > Why do we need this long ret? Do we even need this function at all, why
> > not calling bpf_kfunc_dynptr_test() directly from the
> > kfunc_dynptr_const_to_mutable()?

oops. Will remove ret.

IIUC, this global subprog is needed so that the arg will be
CONST_PTR_TO_DYNPTR. Verifier will see PTR_TO_STACK if passing &data
directly to bpf_kfunc_dynptr_test().

> > > +
> > > +     /* this should fail */
> > > +     bpf_kfunc_dynptr_test((struct bpf_dynptr *)dynptr, NULL);
> > > +     __sink(ret);
> > > +     return ret;
> > > +}
> > > +
> > > +SEC("tc")
> > nit: it looks like most of the programs in this file are optional:
> > SEC("?tc").
>
> I will make it SEC("?tc").
>
> > > +__failure __msg("cannot pass pointer to const bpf_dynptr, the helper=
 mutates it")
> > > +int kfunc_dynptr_const_to_mutable(struct __sk_buff *skb)
> > > +{
> > > +     struct bpf_dynptr data;
> > > +
> > > +     bpf_dynptr_from_skb(skb, 0, &data);
> > > +     global_subprog_dynptr_mutable(&data);
> > > +     return 0;
> > > +}
> > > diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_para=
m.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > > index c3631fd41977..1c6cfd0888ba 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > > @@ -33,7 +33,7 @@ SEC("?lsm.s/bpf")
> > >  __failure __msg("cannot pass in dynptr at an offset=3D-8")
> > >  int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsign=
ed int size, bool kernel)
> > >  {
> > > -     unsigned long val;
> > > +     unsigned long val =3D 0;
> > >
> > >       return bpf_verify_pkcs7_signature((struct bpf_dynptr *)&val,
> > >                                         (struct bpf_dynptr *)&val, NU=
LL);
> > > --
> > > 2.47.3

