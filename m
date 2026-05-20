Return-Path: <netdev+bounces-290129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKnsD2w+Dmqr9AUAu9opvQ
	(envelope-from <netdev+bounces-290129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:06:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F70D59C8C2
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51477318987E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E2639F182;
	Wed, 20 May 2026 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJq0K/Nr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AC23C13EE
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 22:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316917; cv=pass; b=JpCD2NsEwds2DZZ4of1yF1NH02MinSK+ebtvR4CiWOiayckCP+wrYQJsoeP3uWVcvHgFTqc39NdFNFjPUp5G72glGS4nIx6oYafGwrS4dI/oZYAQroPcUmydjHnkMKRrpsFA+nQSNiHijn66nll6vZxXz+XH/w/232FhR/lOFls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316917; c=relaxed/simple;
	bh=2SO7wAPy092XNI0gt9cmMbx4EgFNUew5054NqGV0czE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlCDXQNwHmCOYL+qMLs3qn8/inP6uC27mLHBH0mlt68+VOnEuB/8UwXJmZpke/oVuWE1fV3KA5u8maR4pGFwQ1anGbu24iMBF7MapqgglDggpqHiomyE0ad8AQ8mDc/2/8Mhl3D4VuflZ0x+VRI06dMDA11lMlDM7M/qxuQjRVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJq0K/Nr; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651c7ddf514so5111560d50.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 15:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779316912; cv=none;
        d=google.com; s=arc-20240605;
        b=BrNR+1T+B1JazImIlZicvV18Gx+d4Bw14rkXz0GRd92RcFleuBM1cXAnwIyaXb1I1j
         sMznhV1/QZwy9sbFBPTyPsb0mCm2wRT8eNSv8BxeEJR9yVs/ubgHeMraA/yx+TJFKDf5
         k4JWUKpv1YWQZpe3SC27PhV7GtJ2gPyy+Ygm/+3QxsOoxQ8YxqEEc15fVAInq5DQP0Ed
         yfF2LoiQu8oNxyUkPtDsTFkY2cYaG4Ii5TkrLOH6rAYVAT2lgh72kf0s8Y0EOXS8IWhg
         s8YYmDlwbkSDIqWLcTCE1ZenRXn2wPkZ5tkeSIRDpgIxOBAryRTQDdxKhGcLwQn0ng0m
         /AYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gnoVo4muIvLjwvzERo11njZlpoHh4lmweBpjS9I57wo=;
        fh=YFaGO8zg5GLmrG6rr/BWhB5pnnNF65V/O7ZZ5p9XQ8M=;
        b=lsPyyijtyrLtlqu1+AyKVCX7BHxdc7MufK1xO3A81pgCvqTqZgC+dzsuKTh/ClydZa
         CbmIeab2D12Z2OE3++PF6e2oKTNEUGmoDGlS9f5pQiFmgLAkwd1bq1mhBZYctYaQZH41
         Ifmm+TZWkAil+EH3makT0/EPUBDTqsrwV6Co9PQOBgcHi1PTUzly1ykLI8xboOD2ZOhG
         Y6FfrHUJu7mvRqzfcFdYfAcptbOxUe6GRuzQOAt0N2mm6unxh7ToGvHtQkIVP6zPUX50
         QZKeDrRt9vrqHnJVECJKA3QogRIwkRmcw7dfquVkwiER9RDtMZ/2PqYUjpyQZrGALkOh
         cM9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779316912; x=1779921712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnoVo4muIvLjwvzERo11njZlpoHh4lmweBpjS9I57wo=;
        b=NJq0K/Nr5B/fm0Baxmq1nv8qfAmaSUrHOFx9t+6k8MI4Gyz1XXaKIqln1xJ4XN8bvQ
         S3gh1uc3hMHG2tkMvFUbyMzZemm2h3xPpS1WjZGgtysJwCOUTP6F9vhD71hpkvxxEFY/
         CxM2L7bpDAzaZBqs1Iw3OfwbAzhnTkMAA3eYTTwGiAH0GU48OxD6AWk5W3EsMqJdtYlS
         7LIO7xcsVVaRWs950CZBOj038ZqQsz9ptkKRiNy812fN0coM9andKqj0vtEsh4VAEdDF
         EU7xi8Fh4kAgw7qMCAik5Tz93zujRbak5jutvI13fDBHh5Xbt8vqnU6sxxo76bCxCPQv
         UBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779316912; x=1779921712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gnoVo4muIvLjwvzERo11njZlpoHh4lmweBpjS9I57wo=;
        b=F7/UxcQfDHXEPfuUMXIETrQ/CUgyxAhjqP3J3KTVACbDc+yZoaSOU0ATMPFhp9mFFA
         /Xv9tXzF5/bbDNoJZHRfNNiqqWqZi+xKpfdMTTANB7db7w5CZSDuPvWwKrvnh4+vDgc1
         mQRsoqnBSjNmFSp3L5V8eFIflZq3wbvJGc7fl3d4CrJzE7XpWRd6guHuje6NA2H7gqZi
         rP/okdFy2GIny0r2t16+znSKBKHbB7WbKs6p0g17QhHvuiDO7zfni/7bBWae6ePN6W0N
         UN2Y8GQf4fq22u4iKJiaXWphLo/XsViOmZ4CptW+sKs0d475P4nrRPjiWQANzywG2foG
         euVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9+0ztL+6G9H08PYq4I172wIlsXpgG3MThZyobyOJ9lhfDCR+DN/BUY6EIeZuKaF+ulAszS88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUAWebb0jS2JQAGvp7UfouDoM3Q2rLT/Hp3ah3+Yi7baSCOjkA
	44O9YubZYSr+gb9OjqQ2g9salX05mYRs2NZPnO1g5MV0tByt0sozeAcL+JXcCJ0MLSeyaKi5oL8
	iQNpBiLOkmSrM8L5/z8jVxemsTaqNtGE=
X-Gm-Gg: Acq92OG4LDg8nwuhTG5for9wJoZJn3synL/4vNI57X8drylnv+Ne9TJL8UCmjr8ccRZ
	9Vzb83sI2aE0uh8OxT491pEj5SU7JM25IrY8Mper0vi+9Nzxx4/s/hurShpyYXRjFaQSrDVX7ER
	/3j/YxEIqF3eDIBYffhlwlWHmtoOQ4DMIhENbXvzwotvTylKnOPIirWmVAvw37STNMfW8UkSKND
	H6JTEN8Gq4xqGuj9Cm8VxtQ+39lTZ+sEhh7dywJPCyL83Z4qK8swS8tPiH/vcYX3b7z+E7110Ey
	5EKkIflVf6JF4XOCtwbmJSQ=
X-Received: by 2002:a05:690e:1484:b0:65c:2a49:883c with SMTP id
 956f58d0204a3-65eae00c30fmr194013d50.29.1779316912142; Wed, 20 May 2026
 15:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519181314.2731658-1-ameryhung@gmail.com> <20260519181314.2731658-11-ameryhung@gmail.com>
 <fa15610bc8ffbd41d418bfe61b2e647d8fb51489.camel@gmail.com>
In-Reply-To: <fa15610bc8ffbd41d418bfe61b2e647d8fb51489.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 20 May 2026 15:41:40 -0700
X-Gm-Features: AVHnY4I75Se3WowJHwp0YgSuxktnuxZ288xbTSztc2A3NMZYBs80UVlG60empWw
Message-ID: <CAMB2axMn5UbHWD6He-dzcPJXogMAPb-80gvZp45g12VjwXFSHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 10/14] bpf: Fix dynptr ref counting to scan
 all call frames
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290129-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9F70D59C8C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 12:59=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2026-05-19 at 11:13 -0700, Amery Hung wrote:
> > When checking whether a referenced dynptr can be overwritten,
> > destroy_if_dynptr_stack_slot only counted sibling dynptrs in the
> > current call frame. If a clone sharing the same virtual ref parent
> > existed in a different frame (e.g., passed to a subprog), it would
> > not be counted, causing the verifier to incorrectly reject the
> > overwrite with "cannot overwrite referenced dynptr".
> >
> > Fix by extracting the counting into dynptr_ref_cnt() which uses
> > bpf_for_each_reg_in_vstate_mask() to scan dynptr stack slots across
> > all call frames.
> >
> > Fixes: 017f5c4ef73c ("bpf: Allow overwriting referenced dynptr when ref=
cnt > 1")
> > Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c b/t=
ools/testing/selftests/bpf/progs/wakeup_source_fail.c
> > index b8bbb61d4d4e..d4d0f1610853 100644
> > --- a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
> > @@ -42,7 +42,7 @@ int wakeup_source_access_lock_fields(void *ctx)
> >  }
> >
> >  SEC("syscall")
> > -__failure __msg("type=3Dscalar expected=3Dfp")
> > +__failure __msg("release kfunc bpf_wakeup_sources_read_unlock expects =
referenced PTR_TO_BTF_ID passed to R1")
>
> Nit: this change seem unrelated.

Indeed. I fixed up this piece to the wrong patch. Should be patch 8.


>
> >  int wakeup_source_unlock_no_lock(void *ctx)
> >  {
> >       struct bpf_ws_lock *lock =3D (void *)0x1;

