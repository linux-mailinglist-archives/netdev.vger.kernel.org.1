Return-Path: <netdev+bounces-295963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nvIeAPEqI2qdjgEAu9opvQ
	(envelope-from <netdev+bounces-295963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 22:00:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5335E64B140
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 22:00:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=k7TVysEL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295963-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295963-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31FAE3020A4B
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 19:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21BA309EE7;
	Fri,  5 Jun 2026 19:57:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6565535676B
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 19:57:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689478; cv=pass; b=u4mMGJz+hrrhhz5pMdSPazF2vsv2wHMrBlnP4TVjAeGHR3fHWJU8EYUETmtfSXnQVmBPJiXAS1JosDDiXuo3MP/wwt6tuBUa7oagCnfPJMR7qNr6MHaHSNLK/wHRbLlm86wgbSPxP3QjtP5YPJ2Gy03C7D8pAlDr6FJF+Dfk58M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689478; c=relaxed/simple;
	bh=CwWZX6bA7Wd3IEFPJwjZuLYgybiBOKsUaqQbAdcC6C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4z63RjNJDHDpmjmLqjKsLYJPEJseRgRxUGoPgBTP0hvWtgYkyldfJf9WwK+aAddoqgmr6kKoIe3wJX+t6uO95tWabtJmSDRhA8UcacSlXjcLAHNNQ/9F9D0vC3RTNR1+Ar/G5ukRbKD0OQB2L+scLLKmbIhixBV0ceHvz9KJLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7TVysEL; arc=pass smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7dfceeaf168so23146627b3.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 12:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780689475; cv=none;
        d=google.com; s=arc-20240605;
        b=Od6l5oBJNw+q2IaFTdMJOGeEU8Q8uyL1ViGUoC/tSgG/hQYkV+tPhpBwq7HrFqD/hn
         mlmA7gya4L4SpwjDh6zVKVpkhyLKUsTOMwbztHm5ezbjeQ/aj7eRK+rTjoVGhU/paHUD
         hBW3YmOpsIvRgL/F74r7Elxc0UJXdfXel9VeN7vA+/LmDdMVNI4JqnhUi3S6h4q5Mp9O
         cgoyTt/fy8Rrp/AGDjnvCtNAXO6NVhfWWJeYHQNbZO3svwvD2jZsOY/AGvrA3hcCdWHk
         6C/3f0CYOGFEa8q74wMeNNgH4plw9mzWCw3URk79LVkki5dOccnYRFEVF2BzjK1Ki/fr
         MkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0jGmHTY1/xqU89xp/qNCXcvtPI4E099BtKFLZ3FnV9U=;
        fh=pJlfjWHBtHhXZSeVC2hB30UhIf+FgeaPN5ml9HFkveA=;
        b=OW2KABwtrBmA0X4ViOcPVHCN6D7XNLvzUw2gd0K/wBvERWZ5toZ2AMK+ynhvV5HzGY
         sNhl5xf/0wNas1nY4Ja/JzNrFOHkCQl/VbCWDR8OrVTJkgpdSHB2/EJ5pmnchLiuBv1k
         8VyZK2sUUNJ8PHfoqoWplxPQrMw81LBUblIBVPtOeGGhWhdMgDn74Uqb3lakWkdJogtV
         EW3CZZVScCAPN7CrAFrET+9BgmH2dOSicSmzJ+rwLiv+xLaMdv8Yc1s8JcT5EhsSGInd
         srDTfNmO47vW17HfevT1UJv0Qg9u9Ta3xTdypw9QL+5k3Mf6wC5bbsjjdLrAeV6VfIFD
         /5Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780689475; x=1781294275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jGmHTY1/xqU89xp/qNCXcvtPI4E099BtKFLZ3FnV9U=;
        b=k7TVysELWpW2aXiP37rDRdceNo1d8zFjGu3I8HRErXRHxVw9Gwvq3hZm6c1FwqE0qV
         g5cArpX6wJhPgFTmN6fQRyrzx9wS52t3f+gaiMUxi+Ax1ULEmyG+zruOY2RxhAhJ+b8w
         Iz3nggscxZHbDfPT51G9MwrQR1ZcgzcMsWYwmbjp5TkFpsj63gNKk0bRSG0HezvDDjjE
         uj6r/s2uC6PL+nKseEVtiXt1Jfw0wNhyU7RG2A0FqGuQo7KvQgRFqnx2quwlpyV0MxHJ
         9R/TX4y9Sl16aA93PrDkFvw510qZRZ2iLhxIAqDQorrKa6NsC5dQMyQ7WcxHNzv+xwSh
         wQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780689475; x=1781294275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0jGmHTY1/xqU89xp/qNCXcvtPI4E099BtKFLZ3FnV9U=;
        b=lQ0HgyXiD9QTBfhqMsPoUhe0IarabVfvypJOch26ZFDz3Kz8SBvj9wqeHzt939P0rx
         Fezs8YZ/Par9k0dEbAuzzUWe4uf7vxNp+VkxMZPvjVi6dksye3XDJTiOr8ojuH/Gik7z
         FkCxLJIcejkABiasqlCWh//Ab57NeP6rOTtRWZBaliJflWAL1+DXyhyHPz7XzoYx92gP
         TVNrxjNfVvlZY1azRdnylnTfPwY+f+01if+5GXLmd2KnlvmBQuUhPrudEyY3WMRYIozg
         V+Z/m4G/FIt+fwHYI6Ho8pHIuX9yRqjqyR3+mOwgaEU1qblAggof/VZQjpyVIDj/qGRL
         y+Lw==
X-Forwarded-Encrypted: i=1; AFNElJ9CXVnfe7cWiW/KbKUiVNjJjaQ/xPyUELr1G2Wa5yegJNsMcNOlblpJTZShnVWeQdkjY+xjt2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRwMbtOspLL4QpqP+9pF1YQ/iPKQDH7Lao1i4jwRRLxi52HQAh
	VbfktZaXVyRjmCGqN563OTKWwt/Jdz2B5pQkmaCrMPWNDq0oU5O4eLNySf8FzZM4zmsQpVk3E30
	132pHju9JB9TcmerxIC/s6p7XC9WhIQp2Yw==
X-Gm-Gg: Acq92OFqZg0DVupocnm/TgbuauK7m685WI2zEBTCZpQKCsCC52HvZR+NOcu0FUoha2Y
	KROOLc0KMjThbd6xPTFd4JaQ2C22w3MGIDRMOQVHdjIySDgY5wlUPT0hklFmBLrwLFpfo5y3H+Z
	MT4pbTA6pGflToV9o912Y8A1mrCojQLFtefFo8TxTeBAaRAi6CzoF7X47FyRquMizaDLOYM0VJo
	CmUPOyKWqK0Ok2+36tdjv4rOyK6LiwYSM2oTp2kUFJLoHH13HxqRzUPwlA/bcZoqMW5EflxhyfQ
	3knHe/itShWG8er2Ryl8Vco30th2qpgqjw==
X-Received: by 2002:a05:690c:dc4:b0:7ea:77ae:ccdd with SMTP id
 00721157ae682-7ed0ef4b30bmr50021687b3.17.1780689475373; Fri, 05 Jun 2026
 12:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605183551.969144-2-ameryhung@gmail.com> <80529e40f2a7d1124be6c9d4c914629fe4bfb64ed2e111a1a23700fe268347b1@mail.kernel.org>
In-Reply-To: <80529e40f2a7d1124be6c9d4c914629fe4bfb64ed2e111a1a23700fe268347b1@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 12:57:42 -0700
X-Gm-Features: AVHnY4Ly5qAEYlYw5PTtZuMwUyIdIHcT1U4Qb9xH4-HdlO4xYQ66oh5BaH3Anb0
Message-ID: <CAMB2axMYTkj0yMH-iTjmdsYbktJdkk-vmgqgTwPg+sLhXZicBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Fix dead error check on
 acquire_reference() in check_kfunc_call
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295963-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:bot+bpf-ci@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:kernel-team@meta.com,m:ast@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:bot@kernel.org,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5335E64B140

On Fri, Jun 5, 2026 at 12:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7d27ba396d32..a741bf447931 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12817,9 +12817,10 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> >       struct bpf_kfunc_call_arg_meta meta;
> >       struct bpf_insn_aux_data *insn_aux;
> >       int err, insn_idx =3D *insn_idx_p;
> > -     u32 i, nargs, ptr_type_id, id;
> >       const struct btf_param *args;
> > +     u32 i, nargs, ptr_type_id;
> >       struct btf *desc_btf;
> > +     int id;
> >
> >       /* skip for now, but return error when we find this in fixup_kfun=
c_call */
> >       if (!insn->imm)
>
> This patch fixes the missing error check in check_kfunc_call(), but
> could a similar issue exist in do_check_common() when initializing
> struct_ops program arguments?
>
> Looking at do_check_common(), there's a similar pattern where
> acquire_reference() is called:
>
> kernel/bpf/verifier.c:do_check_common() {
>     ...
>     for (i =3D 0; i < aux->ctx_arg_info_size; i++)
>         aux->ctx_arg_info[i].ref_id =3D aux->ctx_arg_info[i].refcounted ?
>                                       acquire_reference(env, 0, 0) : 0;
>     ...
> }
>
> Since acquire_reference() can return a negative error like -ENOMEM,
> assigning it directly to aux->ctx_arg_info[i].ref_id (which is a u32)
> without checking for errors would swallow the error code.
>
> Does this allow the verifier to successfully accept a BPF program without
> tracking the reference, potentially leading to a kernel resource leak whe=
n
> the reference isn't released at runtime?

This is fixed in the next patch

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/270340=
08594

