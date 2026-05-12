Return-Path: <netdev+bounces-287295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJIDF+uRA2ru7QEAu9opvQ
	(envelope-from <netdev+bounces-287295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:47:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F20C9529877
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F3923086F41
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB0A3BC664;
	Tue, 12 May 2026 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akbh/fBo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA49224AFA
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618271; cv=pass; b=u7C2IcgoQ6nvVZZ+GyE93WxOrd2p19Kgq/dGjl8ayzLHU/z2J1/Y8AVa7+LpmQ+1fpul/LHQQl3CSG9ic1rPfUtefcHHdwMaWaiRxe/qSxAimzTcD2I9PQZtu2K36KdIovFHHyuU1ZJF+tmTA1ID3kKTUAbJguxcO8U5yaFQCWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618271; c=relaxed/simple;
	bh=INKRh2r5TxtEA0CusznPy9TbIEWkCxEu7I/5d62aR5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cp2hKiIIju+0XjXpsb9tg8I6II9Ae1Wm9j85W7cGX6JAh4mVl+yTO9WHWwioe0noQK0DEW/kyRQXdVqqAdkb91nn33UzzSmgkOmTrFeG10Mg2IVzsV0IZqpGfwMxAVTxiBbMH3XQWEgDkZRC7U3XTh/6V8aJN3BEHlYCVCVY4v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akbh/fBo; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bd8c55c885so59464147b3.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778618269; cv=none;
        d=google.com; s=arc-20240605;
        b=LSoOnieotUmVyexdONPqRzJ//gwKn/vHQP81H0mjvA9v5htDRaU3wkFIUV3sBzLekO
         U1j9YzH5UK1wGIO+4RuqwU3wQcfwRyyxeKHk11j8aU4H4x4aJlBsRgUIi21RXexQZE2l
         YYGfSSALEWgdcHm7shMjAwANsU0LlMjTl6/Ve8iMwkIanQEEbsWo+Izxlu00QMFRnyso
         PBNiX1a3qknI6xMI80OH9/+JuFkS/Tm6u2R1AsZGWtMOidcIqd7s2gHEmAp2vX9W3mv2
         vMIZxSJQUnfJmOXAxFU3oG9wWmA4vLGhf++A/kpbqkjymYLdANlkNX6k6PoByKDgDVzS
         7exQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aQcZV7DJIyQpUIFVZVp01UmNF7qQBH5otnKV69pByp0=;
        fh=tHQlpyJwlsamjOiFYl8YlizXwBbBAgiSw1zfqKaC9Hg=;
        b=WWQ5alVwFz9egnTrHIH+s8iC/x+ikJxVG5OMBSjdYZurNqDviOGpXysarNMMvCEqF8
         hrYZqnGAfXZaMnQNxVNWFUbJABHM70J2jp6Fwa27VfT2WD1arNn6wgtBH9gz1FGPWPeV
         GA5SC5sPAUk9ECecv/WLmvGYvPIjKS1aL8bIz38i16hvhhR7PqZwi4Ke/vE3MGDcn/YN
         Px0nP9Tj07A9P9+P0GPnTUlHRwhhW0D8Q7UyuBDt/hD6X+by/J1+bz11OuFBmx9nIE/u
         E2Wg/tNUp6ReJQUxBozCYxaRR7mzEXblmElpm5RDy/2fEuFbpvFY+rg5ysr3fnrqBXLN
         j5Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778618269; x=1779223069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQcZV7DJIyQpUIFVZVp01UmNF7qQBH5otnKV69pByp0=;
        b=akbh/fBoxxD0OISH3XkwXyu0apo/saYneCSbCr1gaZtaWHMJvYYR+IoRL8uHNdsgPO
         KpWTC/ip6FaW6r937AHlpWG0pxqDXae7lNZsqcYNIgYIUpXshdILjoP6U1j7KQiqVt6V
         jVpM8+hTJd9dKps+mshn42xMv3KLuh4+Synm3tpNN034zoAkSdc6HLozSYoREO9TFWj0
         dgDUzw09x+9YayfZes+XL+nUwBJnosYH1lL2HTaOXLygSL5HJl1GiZNPKNFoBl3lsSYy
         4bKRsH+uzFmTz7y6/7xWYehNWHyyIYGZpnCysO7ttE7UmwKzkK6I0K9jcXzDfF2QgIBQ
         tWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778618269; x=1779223069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aQcZV7DJIyQpUIFVZVp01UmNF7qQBH5otnKV69pByp0=;
        b=g8541pKkj3pKmGPqCKzAh2TmbLgc/7agHvFEQ+kr7gXfiZGEz7AfKAQjSSVBo4kW4N
         uTW4mk1CylPOppQ51FnSvFU6yrmCA3wVPczUFEEAvJOzs0d1AeoyMPQXSZlMfJCE5Cgg
         LCLzM1HLGRuzDLuiHyOsiZocA/M46TEKsrXu/zT44Hd8pkNchp9/EvkWxv2mmD1guJtW
         8l5OHjGH7B5DHbhZ5wcw7IVHVVbDc2gpxxEr8JomQmNV4l+KNt3ZYTi7wyTdXb9LdTVq
         PSKEHdcFX+Vzny6Xp0m4AcRWiiNeKc2/JrDJYtbDzPhRmN5oCzF2KYkF4QzWB6e6Fp9G
         UAiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0eQaFD7oyrTQihcZ57hzjV6r6boBKz0p0QuZZarHcAjxUH2O8nQCgQa39mwBtXtgavZBCdJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdFY6cIOLjNMuw0+I/xVqGfWwt3D28jsHg01qvHx+22s7Ok3ei
	PAeSBGt8d9XrufqJe+LdpmirXVlt2SoGL7YVpYLxz1YT337x60g7tqaudwljvgdKPlYNp8gsnDT
	7LYUwA1uTMbr8GvJ3J/8m8MKwG3gfGuI=
X-Gm-Gg: Acq92OEjgomebpUyJobo6/nmiYCQlbzIuuRkf3cNUeM9CTEr1fLKuftx+apK5BpU2jU
	nEHPOWzevoa6tWeAwZcF6BWGNuLge7+ac78iTGE2TWMCkyDcrM0C355RY460/Z3cpDT+GZtSbvS
	HPqPd9C4YIcGj5rw9B471yk50w7uPnuSWIgyBy++Kzc3/xwlvUmW1TOOFopCqKOwXur0HLTikUO
	n2iU2nm6h34WezGNxBBAGIG2TzBU0KTXZ5VwstVsd0hFc/BZTkDNbp4E71oeDIK1tPEm8rsrQPl
	0h+OckwXDKhykL6eP+656TA=
X-Received: by 2002:a05:690c:660f:b0:7b7:5f48:d9aa with SMTP id
 00721157ae682-7c6ad761263mr4513107b3.50.1778618269545; Tue, 12 May 2026
 13:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-1-ameryhung@gmail.com> <20260506142709.2298255-8-ameryhung@gmail.com>
 <23140ed4c48babfa8af91f3b67f379773bdc04c1.camel@gmail.com>
In-Reply-To: <23140ed4c48babfa8af91f3b67f379773bdc04c1.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 12 May 2026 22:37:36 +0200
X-Gm-Features: AVHnY4KnwsBMhnS_vPcREhSf-Ap5IvPHQJczvldmbXJF_pKdl5DnYDe8W042Crg
Message-ID: <CAMB2axM8hR=OVqbkbTMJw_ej2pfnEm9Cm-quuoFPqsVhmJxO0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking
 in verifier
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F20C9529877
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287295-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 12:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
>
> LGTM, a nit below.
>
> [...]
>
> > @@ -8028,14 +8024,13 @@ static int check_func_arg(struct bpf_verifier_e=
nv *env, u32 arg,
> >       }
> >
> >       if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_XCHG_DES=
T) {
> > -             if (meta->ref_obj_id) {
> > -                     verbose(env, "more than one arg with ref_obj_id R=
%d %u %u",
> > -                             regno, reg->ref_obj_id,
> > -                             meta->ref_obj_id);
> > +             if (meta->release_regno && meta->ref_obj.cnt) {
> > +                     verbose(env, "more than one arg with ref_obj_id %=
s %u %u",
> > +                             reg_arg_name(env, argno), reg->ref_obj_id=
,
> > +                             meta->ref_obj.ref_obj_id);
>
> I think this should be reported from update_ref_obj() itself,
> it is more consistent logically and also avoids reporting code
> duplication in check_kfunc_args() and check_kfunc_call().
> Also, technically the reg_arg_name() is an independent fix.

We have kfuncs that have more than one ref_obj. This is not a problem
unless ref_obj is referenced in the verification and is ambiguous
(e.g., used it to tie the lifetime of the allocated memory with
ref_obj). Therefore, it is kept at the location of use instead of
update_ref_obj() to prevent breaking existing kfuncs.

>
> > Drop the selftest introduced in 7ec899ac90a2 (=E2=80=9Cselftests/bpf: N=
egative
> > test case for ref_obj_id in args=E2=80=9D) since the verifier no longer
> > complains about ambiguous ref_obj if it is not used.
>
> On the other hand, if you think that this property is worth having,
> then maybe wrap the check with in some utility function?

A utility function like below makes sense if we fold ref_obj_id into
id. It would be too cumbersome for v3 as we may need two of this for
ref_obj->ref_obj_id and ref_obj->id.

static int get_ref_obj_id()
{
        if (ref_obj->cnt > 1) {
                verifier_bug(env, "function expects only one
referenced object but got %d\n", ref_obj->cnt);
                return -EFAULT;
        }
        return ref_obj->id;
}

>
> >                       return -EACCES;
> >               }
> > -             meta->ref_obj_id =3D reg->ref_obj_id;
> > -             meta->id =3D reg->id;
> > +             update_ref_obj(&meta->ref_obj, reg);
> >       }
> >
> >       switch (base_type(arg_type)) {
>
> [...]

