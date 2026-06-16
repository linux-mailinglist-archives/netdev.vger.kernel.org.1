Return-Path: <netdev+bounces-299698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i3ngDXSqMGouWAUAu9opvQ
	(envelope-from <netdev+bounces-299698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:44:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C983868B510
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:44:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=E2o0frn2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299698-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299698-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24C243078F73
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE237C0FE;
	Tue, 16 Jun 2026 01:44:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4537BE7A
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 01:44:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574250; cv=pass; b=I94YZAIPIoKCVOVBOi8X6POhs4VJcPdO76hkgbQcaRZ4Gh3tSpfa17lnJarO564bYKdqm3hLXfNJTWBA3UkvddIipkhbnVLLiX8ornet2MNNZ4x2bqrceZZ2CpQ9FSMcLbq3Cr2DKZ/a/fQ//v64lO+ho3HGVO59pdqpdl3xuOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574250; c=relaxed/simple;
	bh=236fBEIJz/KEeeV7woGGo3ZYcOTNrCWyCpSWEhiGQK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIOCk2hfN54MnxuJghYSeX81SKfzYkJiQDmvOqOeuyKLC/DMd/qEEIOPwZbJccdiiDSdOLwbzeXo5v6IE4gL5om+cXybU/feMycQVsHS/T4Aoi2ntQIuOezzaxNlIvgGpuDljV1qj8YhWst9cynw4bCetJTCfw1f3hZdxxIWr48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2o0frn2; arc=pass smtp.client-ip=209.85.128.181
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7e0b3db3499so29328287b3.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 18:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781574247; cv=none;
        d=google.com; s=arc-20240605;
        b=OqET2tcCfBPNq2zyOYVlmAnTMYSy3AvzSGnpsyDwl3rxE2+x7RaLvDr8jctKV50WO2
         pK4LLn5xiN3duWm4bidBZrRTS71NnDI5S2Wve8U+0LBn0UGEZDMGoc8KcpzkLriC2UTK
         2ZfoczDUunyNeNYQrVsfVBIH98M/Quk7R7938Mdd7dpbAVeFJ6PFZxDyp4L5NKZoWvSo
         iFTES6uyEvA7cAiExzwEtPAIQJJzFFsj/s2TJdbFiibBWHN4SYX4V0uH7IC/SKrAnyAt
         DLG84h5H6V0mtN9+xo2uLENx2bcdRn59jgrJryP5QSj6LXQ1VBv2rHeQnldFjO6HVQJ2
         2X7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+oKKpyH4QTZmF9PWO5iAvNe25h+SsPEG6KTMiiFXfCc=;
        fh=wWBAzSoKLjqiWt+J7fALIVlSvzywFdVkppuwTUM+HoQ=;
        b=K2J5ebM3eKGjzXQDFynSvbHHi8dqsyKSsq3IXZptDPkVjtC200dgZezDzEoW6pUmRR
         uY1AJUcXskRRnFd50Ypboy0HVHMMCdROkATS2OsaL5Wvh8UK3U5n8vdPXzK1Y67Dz9Gz
         Ne1AFxw06Wh/cSzDXR0KisQ3pVc2euTUqFsFR0tKAuKbH09DGByH0tEi0G43ze/WO0wJ
         EoGRnmOkdKp8EVSSKTtHbj2JMAbSshhYlKLciCEm/BmlXgeMiDK8lR70Eany2T+FeaxK
         CBzCnMSxm/CaIMEe1QJpSjxSvA8QNHRZMq908TqdVcz/Bz2pUZrtyUeVCNGIZMO4lxKs
         G+cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781574247; x=1782179047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oKKpyH4QTZmF9PWO5iAvNe25h+SsPEG6KTMiiFXfCc=;
        b=E2o0frn2KSkwnFR4DV7A6TqMGa/Oei7dB2VJLSbtZxgmj/8asuPSLDfPSjAg7Tgo9s
         ZaL9wyUtGjGBjjNQo7B+ywKOAzZ2qYwDsYuTP4yHYGHB/+FJfE15KvbQb+pkhulZ8lSM
         jcXzc+7loptnXJaYbCw2OIGI4KLG/S+6fswjUIq+0+zXdIP0TUCVAFxP7ioa2w+F5FfR
         26cVzvsrGnC0mbgCQm6ED96BK3uOUoPQ7T26lFDZFmBj1hib2zi3TOoGd+dkIZBV5jqd
         8hgBt7a4jMW53dT4SiudefPd6660+zv4qhyu2aLAWNr2+3kT3nkkUxmhjgdrK72MGyqB
         pKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781574247; x=1782179047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+oKKpyH4QTZmF9PWO5iAvNe25h+SsPEG6KTMiiFXfCc=;
        b=j0uKwj3qOcn6nkgRnlamrqX7xaKZBzIsYJcUtrkHxPonr+l9Q3j615zUIvjCqme/Pf
         eKBGu9oFGcCqIIYaMCE/MHvtMA8pXp8NNUWy7crNP7kI2Lhtw64kaJ1eahar09XpXw65
         L2QoFuV/XspERBVqPP6haccOO40eu0u+tg4hz/cEgoejtE4bIcuVpsxnUV1vy8vkBTuz
         LkLhVpANtXLhU+xnBqs1kqcLHP/WEN0N3H7ZIk6toKO2ZaLlm11nIDEIUA9yCD39Xp8d
         jVasSMIFNwC3dWB4HeBeHJV9TDJxHDyqT9RufqyCYPfo5Mc1+dwemIy/qbAVgLFJfMqh
         fEbw==
X-Forwarded-Encrypted: i=1; AFNElJ/Df3chfkgXdtVSVgzb68COCQEPuelb4qdPju1GPfPMN5llvmOB76w5ZYtu0oXhGsbyiug0CWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLfGCsmvIDde2s1TwpMEmG4gIdrxFJi0XTxG6CFFKbnUAzofb
	LrNXh26n+TVNxsLyQRI8MGqDreeHRDwSqjMYh859VgcIbAMihLFKn+zHWlfWvv3/rPQoW8qDgoe
	HyyUPhxaBSmFbVNDKUscmX6iKVHcQd+k=
X-Gm-Gg: Acq92OEEGVhXn+TxevJ29Pya8bRc0pnFZ0LAMiJBVB9Sy6KJSmxLj/4NIrnS5nTOoFN
	xEL6WVxr4TtZB29iKrsH4sYaA/WtFbAV7ePWa4pNqN5pVWQf5FTqDytj8e9wwMAsYVev5s1B520
	R3CbWBC8bJZpB1mosQ+ou9bQ7Ke0kwQlrRQ4X2/NId4kvLc9cERbRwDwzw2u+0iAr5Z/VTcvDqy
	+F8qS8kZbTbw9spScXbYIBp7aK/rjEQbJdapoB6Of70vVv6tfPQWU0lK0SPdXrn6mg6qD9IukgF
	Fv1fkOYk1oocFP0Nd2U/rA+3ECrK9LNLOOFH4q8f4oNmH34Tgx9sdelToFilVA==
X-Received: by 2002:a05:690c:4902:b0:7a3:7ad3:3e9e with SMTP id
 00721157ae682-7f8c37d34b1mr121804007b3.32.1781574247418; Mon, 15 Jun 2026
 18:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
 <20260615073856.152479-2-sun.jian.kdev@gmail.com> <ajAAkIv0R3ztfc5g@mail.gmail.com>
In-Reply-To: <ajAAkIv0R3ztfc5g@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 16 Jun 2026 09:43:57 +0800
X-Gm-Features: AVVi8Cf7im9Wiat3H2R_vuZVWzFKDi57wMkvXVzURWHo32EAr5QTdOPWPc2BPvI
Message-ID: <CABFUUZFKTsaHLSzoMDogSnnzUCikZcb6TzxQ4G640oO4OxmAjA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix partial copy of non-linear skb test_run output
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:paul.chaignon@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299698-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C983868B510

On Mon, Jun 15, 2026 at 9:39=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> On Mon, Jun 15, 2026 at 03:38:55PM +0800, Sun Jian wrote:
> > For non-linear skbs, bpf_test_finish() derives the linear head copy
> > length from copy_size - frag_size. This only matches the skb head lengt=
h
> > when copy_size is the full packet size.
> >
> > When userspace provides a short data_out buffer, copy_size is clamped t=
o
> > that buffer size. If copy_size is smaller than frag_size, the computed
> > length becomes negative and bpf_test_finish() returns -ENOSPC before
> > copying the packet prefix or updating data_size_out.
>
> Thanks for fixing this!
>
> >
> > Compute the linear head length from the skb layout instead, and clamp t=
he
> > head copy length to copy_size. This preserves the expected partial-copy
> > semantics: return -ENOSPC, copy the packet prefix that fits in data_out=
,
> > and report the full packet length through data_size_out.
> >
> > Fixes: 838baa351cee ("bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN")
>
> Wouldn't this bug actually go back to 7855e0db150ad ("bpf: test_run:
> add xdp_shared_info pointer in bpf_test_finish signature") and also
> affect the XDP bpf_prog_test_run_xdp()? If so, could you also add a
> selftest that covers it for XDP?
>
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  net/bpf/test_run.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 2bc04feadfab..976e8fa31bc9 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -453,19 +453,16 @@ static int bpf_test_finish(const union bpf_attr *=
kattr,
> >       }
> >
> >       if (data_out) {
> > -             int len =3D sinfo ? copy_size - frag_size : copy_size;
> > -
> > -             if (len < 0) {
> > -                     err =3D -ENOSPC;
> > -                     goto out;
> > -             }
> > +             u32 head_len =3D size - frag_size;
> > +             u32 len =3D min(copy_size, head_len);
> >
> >               if (copy_to_user(data_out, data, len))
> >                       goto out;
> >
> >               if (sinfo) {
> > -                     int i, offset =3D len;
> > +                     u32 offset =3D len;
> >                       u32 data_len;
> > +                     int i;
> >
> >                       for (i =3D 0; i < sinfo->nr_frags; i++) {
> >                               skb_frag_t *frag =3D &sinfo->frags[i];
> > --
> > 2.43.0
> >

Hi Paul,

Thanks for taking a look.

Yes, that makes sense. I'll re-check the Fixes tag against
7855e0db150ad and add XDP coverage in v2, since the issue is in the
shared bpf_test_finish() path.

Thanks,
Sun Jian

