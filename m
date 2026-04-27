Return-Path: <netdev+bounces-281485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJjiDUjG72m4FwEAu9opvQ
	(envelope-from <netdev+bounces-281485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:25:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A79D3479FF1
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9CDF30036E7
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAE9366072;
	Mon, 27 Apr 2026 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHIASxPY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA5036403C
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321447; cv=pass; b=Qq1puwOs5Rhm+SmSe7mr1dz2pzxa5jwRvXN4QrCPYqcqwvQiusK2T54LEGBIQVe+7l0mn0LUwHWOuPn08A0ncgxbUDhGGhDkcZMaffzUK/P+XJzrxelF5OQyIc5P/co7UuLqkqXO/VJSjsKUQphgDCtIWb5TR8Py9Q6V49+JAP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321447; c=relaxed/simple;
	bh=MIDQk6IaaivJ9A+oYRAlw1Zvj3fMOH5Mb+7qhf+hWso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5aMHnWpCdj7nst2fh+bEQNuDck0hGbWqnJZnfV6lyGJDsHu6zifN9n0K++0dY4RBnJwJtfQkjCXveLGwg9fVFddLibiXDR0epGgYZDNaxJ9smItBI685ySa7MrxGwsEi498qiv7USoIz/6+6dzXr6hn8FztR2GrHh1+fMMINRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHIASxPY; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a74765703so99597437b3.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777321445; cv=none;
        d=google.com; s=arc-20240605;
        b=MdCzZHnktlEHxu+kZAYekCNHyJ5C+L9/OzbJhK/ZIdzOe+rgdsVYpkyLkJ0v/vhtSv
         H8eefnpuYC2W5q9lHcDUubI5z6ji/SSdzsW/d374xVTgiXStQa6Bfq8Sbn+7hTkEePQ7
         wUWpMnch5zAA+94XXSLA/FhhdOVw9IiyWus5fQZkkSMDizNw1WFHoVh0jNv2kUHRi2rD
         VC0AY/nnimZz5Iy8jyFDLLqH+pnu6VjyM9Ud/JKSnIxP1gsflcsB1QFAft1DOShhnMfH
         9yGPdoN7IN0W3VfZCTZ89lga50wxPsZcOycSuVYn/TuXZLhynF2KjeWIPO0FcOR8KZTq
         gDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BCN7Y9kM9mKkjADQHIZKQPGfRhnTuCp0fYgbJCpzkI8=;
        fh=mlb78KdyprV+OCfZQHc05WiWA9zW51syrNfEtzs+5S0=;
        b=gxLtOVP55Z1cPbkmoB02aMcfnL5+zYqGsUj5HfOVROLcXrjrQgD2Ji5VpHFlt1FgFt
         gkMbPqWxfmxXHGANIwyCoEXZq1OsCNLyubPFeH8QB+pYJQb3kl5/zLnlue+pOXY2KLYL
         GsA5zBms5E8zLaHErKlcM9d5vjMNlAkxE4G38R8j88oYA+TCfr6fvz8fEG9FDZ2DoG1q
         JM3fqJWVtZ9+SrTmGaNu2fWiWP+u9TvXcP4ZQNbH+4lBCbUbp9Lmu+T6eI+7BdbEbPup
         YY1eR9hC4JrTm2b5vYRNbGDoDiowvEuVXEBsEzR8r0HKoQyWAX5D/1SSfxIwrRyxkZv+
         T3ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777321445; x=1777926245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCN7Y9kM9mKkjADQHIZKQPGfRhnTuCp0fYgbJCpzkI8=;
        b=DHIASxPYsK59ooP+zWGMw+F6Sb/dbrUIbOuH310Pjtm7W4QduG9/to5nce+Pzt0CTk
         4+d0Xz1/uxGFi0O/hKMO+1wH+nCI48DIseO81CGHTde+XLwXKuepYnBb6QyhrkZiT2Wm
         JQ1/EudwaLhiZx0eE8kFi26LlbRJry+CMi6O/pPgLSAK2AgYl/UJ9WvS6pl08YY1DOyU
         CvGA4i1kOxYhs1hJPWzLliy+dC8CNUV/l77Ufkt6WBjHIHnj3JBGAE1qcNLjaI4UldCt
         HCdO18kzYeNBWjNYlLjL7YNB4pa5M59g/PhWUnmbj3UMOpCi51Le+aRId96y5hs3jj38
         aiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777321445; x=1777926245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BCN7Y9kM9mKkjADQHIZKQPGfRhnTuCp0fYgbJCpzkI8=;
        b=YSiBHDkmHuVKISOF8Kv/qd8iT6OCWwxHivr2DKYXMq8R07XxSSVSUeVS0RhmTz+eOD
         90mOAJvxi7O+Ktri/gEnB4lgu1DEn1pxe9ghYYzNTI/8f3uHwazI+2dO8bxJF9I3h7Ud
         hY2pH+EBerMh+pIa4wtuBdNDRati7SWE9FouSXwiNrxQkvrQFeOK/JCvPvdxnq86YBSN
         nsIrdUxoCfly3hWRVK86eiQJoWIAoxpOFmlnsQ+pInO+4B5QkB1Va/tAI2g8cR3tPPDb
         6ietVSo+wMdKNVM9/obCqMzVI5/2gnOcykq9o7+/z3fxxbTzqLqr5xSuvXeJhGE/ppdr
         xahg==
X-Forwarded-Encrypted: i=1; AFNElJ/QDc+s2ppKotGrxwVBb05jWc/RiQSwIGGqEZoFVHyy1ZEE9322lkU0ehe6744V79do3tXUnso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfDtgo7tc+5z8v9IhTRchqF+fqY69vdTf9EdH9rUTjolpAWgYx
	UR1u/q9k2Vol6jk7pRL5ulWXSF9GizjsxtYuxyif6WqBbeHP6ASoc9tpYaNW4C5G+SsT9m/ks6K
	BSx1Oa+BlM93nSRPUO9KSkm3ko9JdGO0=
X-Gm-Gg: AeBDievMaOdcfNPxO4Y8+U2lceyo6TlDdyjUYgWwLNv1b7JOl+7OHXWzAfKeL7xBCuP
	qGbRkXtPo9cYsqgrjESK6RDUJgfGu88B4tcg5MwRrY+94UcMw/t0cP1IZa2pq7bGWiNzhp7wT9V
	7lM24mig08uTTKrlieKcvd/Vofw8Nc+W8epGmKAEVFd0qnN0O5zUYmZjSfkffLHOzOHSwFco4Jv
	N7x6EFXDwZAMe28chdI+Fj340GNUrQICxxHf+1JOHhpidOCtDomhylPp8fv91oWtR0BYkWNooa2
	T8KpYFpwOmygFWeAXg==
X-Received: by 2002:a05:690c:e0b:b0:7b1:3579:2ef7 with SMTP id
 00721157ae682-7bcf5573815mr842387b3.28.1777321444779; Mon, 27 Apr 2026
 13:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-5-ameryhung@gmail.com>
 <4de82d94-a975-4703-b45e-8932dfc28248@gmail.com> <CAMB2axO5TJwmYyvRheoZGH4ktRa0d8ig-UGK5E269iVoDH-zPw@mail.gmail.com>
 <CAEf4BzYuaA0xDm9WXv0vnorOgzmzsD-Rf6R3w5kus5Uo37SBFg@mail.gmail.com>
In-Reply-To: <CAEf4BzYuaA0xDm9WXv0vnorOgzmzsD-Rf6R3w5kus5Uo37SBFg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 27 Apr 2026 13:23:53 -0700
X-Gm-Features: AVHnY4LJg5gx-H0HFRx-yTWyPQVFe5viQgXXN39uE_liNxV3HlNQ_-xyGCp3w6Y
Message-ID: <CAMB2axN0tXAXe3k6o_QCY0=VVjdvME7nTE9urYUmYr_7vTuobQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A79D3479FF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-281485-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 5:04=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 23, 2026 at 11:44=E2=80=AFAM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > On Thu, Apr 23, 2026 at 11:19=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> > >
> > >
> > >
> > > On 4/21/26 11:10 PM, Amery Hung wrote:
> > > > Refactor object relationship tracking in the verifier and fix a dyn=
ptr
> > > > use-after-free bug where file/skb dynptrs are not invalidated when =
the
> > > > parent referenced object is freed.
> > > >
> > > > Add parent_id to bpf_reg_state to precisely track child-parent
> > > > relationships. A child object's parent_id points to the parent obje=
ct's
> > > > id. This replaces the PTR_TO_MEM-specific dynptr_id and does not
> > > > increase the size of bpf_reg_state on 64-bit machines as there is
> > > > existing padding.
> > > >
> > > > When calling dynptr constructors (i.e., process_dynptr_func() with
> > > > MEM_UNINIT argument), track the parent's id if the parent is a
> > > > referenced object. This only applies to file dynptr and skb dynptr,
> > > > so only pass parent reg->id to kfunc constructors.
> > > >
> > > > For release_reference(), invalidating an object now also invalidate=
s
> > > > all descendants by traversing the object tree. This is done using
> > > > stack-based DFS to avoid recursive call chains of release_reference=
() ->
> > > > unmark_stack_slots_dynptr() -> release_reference(). Referenced obje=
cts
> > > > encountered during tree traversal cannot be indirectly released. Th=
ey
> > > > require an explicit helper/kfunc call to release the acquired resou=
rces.
> > > >
> > > > While the new design changes how object relationships are tracked i=
n
> > > > the verifier, it does not change the verifier's behavior. Here is t=
he
> > > > implication for dynptr, pointer casting, and owning/non-owning
> > > > references:
> > > >
> > > > Dynptr:
> > > >
> > > > When initializing a dynptr, referenced dynptrs acquire a reference =
for
> > > > ref_obj_id. If the dynptr has a referenced parent, parent_id tracks=
 the
> > > > parent's id. When cloning, ref_obj_id and parent_id are copied from=
 the
> > > > original. Releasing a referenced dynptr via release_reference(ref_o=
bj_id)
> > > > invalidates all clones and derived slices. For non-referenced dynpt=
rs,
> > > > only the specific dynptr and its children are invalidated.
> > > >
> > > > Pointer casting:
> > > >
> > > > Referenced socket pointers and their casted counterparts share the =
same
> > > > lifetime but have different nullness =E2=80=94 they have different =
id but the
> > > > same ref_obj_id.
> > > >
> > > > Owning to non-owning reference conversion:
> > > >
> > > > After converting owning to non-owning by clearing ref_obj_id (e.g.,
> > > > object(id=3D1, ref_obj_id=3D1) -> object(id=3D1, ref_obj_id=3D0)), =
the
> > > > verifier only needs to release the reference state, so it calls
> > > > release_reference_nomark() instead of release_reference().
> > > >
> > > > Note that the error message "reference has not been acquired before=
" in
> > > > the helper and kfunc release paths is removed. This message was alr=
eady
> > > > unreachable. The verifier only calls release_reference() after
> > > > confirming meta.ref_obj_id is valid, so the condition could never
> > > > trigger in practice (no selftest exercises it either). With the
> > > > refactor, release_reference() can now be called with non-acquired i=
ds
> > > > and have different error conditions. Report directly in
> > > > release_reference() instead.
> > > >
> > > > Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
> > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > ---
> > > >   include/linux/bpf_verifier.h |  22 ++-
> > > >   kernel/bpf/log.c             |   4 +-
> > > >   kernel/bpf/states.c          |   9 +-
> > > >   kernel/bpf/verifier.c        | 264 +++++++++++++++++-------------=
-----
> > > >   4 files changed, 152 insertions(+), 147 deletions(-)
> > > >
>
> [...]
>
> > > > @@ -673,82 +675,56 @@ static int mark_stack_slots_dynptr(struct bpf=
_verifier_env *env, struct bpf_reg_
> > > >       mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
> > > >                              &state->stack[spi - 1].spilled_ptr, ty=
pe);
> > > >
> > > > -     if (dynptr_type_refcounted(type)) {
> > > > -             /* The id is used to track proper releasing */
> > > > -             int id;
> > > > -
> > > > -             if (clone_ref_obj_id)
> > > > -                     id =3D clone_ref_obj_id;
> > > > -             else
> > > > -                     id =3D acquire_reference(env, insn_idx);
> > > > -
> > > > -             if (id < 0)
> > > > -                     return id;
> > > > -
> > > > -             state->stack[spi].spilled_ptr.ref_obj_id =3D id;
> > > > -             state->stack[spi - 1].spilled_ptr.ref_obj_id =3D id;
>
> is id assigned somewhere else now? where?
>

I figured that I missed this question. The existing
mark_dynptr_stack_regs() above already assigned an id.

