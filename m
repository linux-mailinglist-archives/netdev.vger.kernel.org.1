Return-Path: <netdev+bounces-267203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMbcD6sds2mDSAAAu9opvQ
	(envelope-from <netdev+bounces-267203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:10:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4328D2788C0
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13E9D301022B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8C3401A06;
	Thu, 12 Mar 2026 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo02eGGV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C22F3AB291
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346212; cv=pass; b=lHvRblEuFk+G0rBSAYQRRIYbjkWgWiWeMb6zYpUbvG4+xyvmh4EvrFh8icL1w0+UFLLcQk4shjGCF4+ffwccMejHMFt7WzA7E+E9NiXDvJzJx6qcWyzUUrAD2iEpMPEHkdLaEEvLBAhcJyCjI3IpO0Zg18u/shruG6//a3TsIHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346212; c=relaxed/simple;
	bh=YrKSTG/KUU+5EZU9DCzic7bdcxeYtSaba7SKVjTjUc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyMlmfUf626o7GFX2PHqJYprgXtSHd45jrzwoqCVkZJeGe0B+I/1vPI1X2qxls+r/LoISW+pl4aJIorJJ7G6+R4q5TJT2dri8/YqWgrUPJH8Imjmmgej/3yCwAPUCNJtd5GDsC17vbL14NPGZ9420jP6LH9XVLpqqAoBdJ9Vnb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo02eGGV; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae8177446fso11442015ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773346210; cv=none;
        d=google.com; s=arc-20240605;
        b=jnGoX19db8Og0xw69TUX5EersdwV9k6Tvh7QISJcMokUNu+GFUDvsjpsDGtbozbAM2
         pa+yJ+E6qCpmWetw7xvXXLfKuD4pR0fwmLmIkI5BpfcnSAxT0cme/lu3RnDVHnYhKvE4
         F+aN449qMN/bIV9Mlz4mRAeb1/73TaZovm+NCixiDVo59vEXPABB9KCtdNGhXlz/LIDC
         KWv9cis2+5qTLm+kD12y0HOSn0Daz6dqgxQi/gGiN5Mc+JwiXMsMjHeBI4zhvz565YQd
         4NR19RKr29egJVkg/08wfmmw9tn1ThB+vICAld3Plyqlg+ij9i5rUN8DjlikGTqltkY2
         LeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gm2FCxY20BE6uUQnf+f3bxv0y7OjLwyxJWmXnboau2o=;
        fh=LWbmzZJu+Y6OiLck2dkgcXdmAm7x/gknjqnNOincNy8=;
        b=KUOcfLezkDQr6HoiCeWrHBGQC9wCiGVQyqx/fp6tICL0bo1vk3R9HzZzQSAeSIW042
         VcVK2/yXN61dF3ej3xBWPPXn/px6PqNII/P86pvaTzXJn48OdHyN8/nofsm05iqpIqFf
         725lphcupehUcoRnAf9g8PYClKp+RWXjdpxk/8bzDd+6FWfEJmbi3JbzCAkYKwEbz7YL
         brtRXxf+WhYSSi/38VDKbKjH2xGY6QFMWCae2qb/Sr902sNCZKvnFtacrOIqjCiQLjKb
         b/uR1YFrzyvwbIOCEwH71Nok7M+COW2mG3t3jOsuE9dw/pkVkOnFtQvpketETqt+sDWd
         AXkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773346210; x=1773951010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm2FCxY20BE6uUQnf+f3bxv0y7OjLwyxJWmXnboau2o=;
        b=Oo02eGGV9vYaYCscUNWSGh9KNd/s/AYWYRHCKQnK8gScRIWiUJ4uOZouaRqEewImhZ
         nJtaaEJLDYftiQ6t9pWlnyhFOrpgGVqvRsPsgaloQroirHNVCgjEP5Tq9jamLQf7IDeB
         Ol5Y1oeq4laq9WIvepmd980W3F9fNBi+ykmENJFY6O/MI+SXWjcLM5xbv1AVgfLUwQE1
         e3ft7GSs++VcHjmWcQhydoFDJTweh7BZBQNH8eklE9jr/pK+f+D9Dxr+5AFLsGI2gf3Q
         YLzLZbaQQnTNcQHp+SEN6s4bHf67535TR6hhbzK5ZsOqBsEpYs4WtrhimRAZoumEVVcf
         rC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773346210; x=1773951010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gm2FCxY20BE6uUQnf+f3bxv0y7OjLwyxJWmXnboau2o=;
        b=cyvEV919erO8H2SdG+QW9+Q5O4buWeJjhsxJX5fpzYoM6er+pj/zIpToR4d6wpTA33
         rn85vJQdRXPTbjhXVMmnaj38ryPtUxcVmX4oHYOpEWhn5KtG3CrYYJnkkDFaLqoV8kLw
         GKrnfhzh4p+cwVBX/wDEviQF4i7/NInh5KlrFWW/zC7+P6Bu6EkKE0FxJWxGblhlgIu5
         6TzMC3z26HoY3LWztWg1DBdKW6efH9AV7LxPeT8c2oGIm8KS1hKGw8LnxsXT56FMypUE
         7Q0BPjVv4B8Zam/pRXl10fq5KbxExvqr3eo8rhvbtlkQJdTcJEtNQLpv+5yKqsbR8raK
         fOgw==
X-Forwarded-Encrypted: i=1; AJvYcCXCRk1L19m1UzbBWazZ/XcLwPf92o7nHyOkanFXlPzo5gzg0lNXhQsclEx91SbxXyJa1K7CLMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhcD2WafBqh4sPrs+Mm7sErB+gc9gHlxcbDKzl5KgqYoY9PnAq
	3wjl9yx4cHv4RrbwrmqBpPDoSwsa6BxfzA5RQHkxnW///qDLrAbNn5zX9mL6ZYuaejSrF3gV9Vn
	ttPUp4yEpNiDicLVQG9S6uDOfm7M01Mo=
X-Gm-Gg: ATEYQzygLVSJm3pNMoaGUkr3EScYX38YBw5EC8FpbcOyVgV+GzVXOW/iKdi5ywD1JPQ
	/m/7FnTGfMmP1F/k4ObKJX4tGzj3LcefQcPYGqVLhmZMmVOtpoOG1cjL3UEEHian7ooyXyYugQo
	6e24/6TOH05ZM2xbuHIsWloqiWkA3AiKHadxwuQP9xv+6J3Oev4+Nq7IeEq6vwd9cvSLnnG5+Ja
	cV3Czuv1PINbwu1PqnAtOlCpP+Vg5OCBsEBOkYPI6wL3l7bzn830GxfjdiVpPq/459dHPcjqVwR
	HlTZRqUyesUgGKm+wK4NNi0=
X-Received: by 2002:a17:903:3c43:b0:2ae:5baa:cef6 with SMTP id
 d9443c01a7336-2aecaa26653mr6830965ad.19.1773346210204; Thu, 12 Mar 2026
 13:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
 <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com>
 <CAEf4BzYTO9e-UAEd+W+ftqQZLUZCWHWXAYVnVjHeNtsZL1=Pdw@mail.gmail.com>
 <CAMB2axN+8+V+29r9tuoVF57ObpvkUE5d5_8jtd5iRPYq4_gLGg@mail.gmail.com>
 <CAEf4BzY1O1Ne9Rf+O2terCT8f9e6pNFr3N4hOv98N84ZoehCaw@mail.gmail.com> <CAMB2axN8Qe6r_siq5_6od7D_kDZPcYw_Z6KVOFtXNJVKzajqzw@mail.gmail.com>
In-Reply-To: <CAMB2axN8Qe6r_siq5_6od7D_kDZPcYw_Z6KVOFtXNJVKzajqzw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 13:09:55 -0700
X-Gm-Features: AaiRm53caXxCZkzH0tGBQHZIM52CG4FziCPGYuMyjIEkMB56W7YV4fcZ0enQXQ8
Message-ID: <CAEf4Bza5bNf6MsgNrr9WqE5ZKhRQ_PwtdCEwaWAVLJNmAZzv=A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
To: Amery Hung <ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-267203-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4328D2788C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 9:59=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Wed, Mar 11, 2026 at 4:15=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Mar 11, 2026 at 4:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > On Wed, Mar 11, 2026 at 3:37=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Mar 11, 2026 at 1:01=E2=80=AFPM Amery Hung <ameryhung@gmail=
.com> wrote:
> > > > >
> > > > > On Wed, Mar 11, 2026 at 12:44=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@g=
mail.com> wrote:
> > > > > > >
> > > > > > > The verifier should decide whether a dynptr argument is read-=
only
> > > > > > > based on if the type is "const struct bpf_dynptr *", not the =
type of
> > > > > > > the register passed to the kfunc. This currently does not cau=
se issues
> > > > > > > because existing kfuncs that mutate struct bpf_dynptr are con=
structors
> > > > > > > (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfunc=
s have
> > > > > > > additional check in process_dynptr_func() to make sure the st=
ack slot
> > > > > > > does not contain initialized dynptr. Nonetheless, this should=
 still be
> > > > > > > fixed to avoid future issues when there is a non-constructor =
dynptr
> > > > > > > kfunc that can mutate dynptr. This is also a small step towar=
d unifying
> > > > > > > kfunc and helper handling in the verifier, where the first st=
ep is to
> > > > > > > generate kfunc prototype similar to bpf_func_proto before the=
 main
> > > > > > > verification loop.
> > > > > > >
> > > > > > > We also need to correctly mark some kfunc arguments as "const=
 struct
> > > > > > > bpf_dynptr *" to align with other kfuncs that take non-mutabl=
e dynptr
> > > > > > > argument and to not break their usage. Adding const qualifier=
 does
> > > > > > > not break backward compatibility.
> > > > > > >
> > > > > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > > > > ---
> > > > > > >  fs/verity/measure.c                            |  2 +-
> > > > > > >  include/linux/bpf.h                            |  8 ++++----
> > > > > > >  kernel/bpf/helpers.c                           | 10 +++++---=
--
> > > > > > >  kernel/bpf/verifier.c                          | 18 ++++++++=
+++++++++-
> > > > > > >  kernel/trace/bpf_trace.c                       | 18 ++++++++=
+---------
> > > > > > >  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
> > > > > > >  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
> > > > > > >  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
> > > > > > >  8 files changed, 43 insertions(+), 32 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > > > > > > index 6a35623ebdf0..3840436e4510 100644
> > > > > > > --- a/fs/verity/measure.c
> > > > > > > +++ b/fs/verity/measure.c
> > > > > > > @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
> > > > > > >   *
> > > > > > >   * Return: 0 on success, a negative value on error.
> > > > > > >   */
> > > > > > > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, s=
truct bpf_dynptr *digest_p)
> > > > > > > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, c=
onst struct bpf_dynptr *digest_p)
> > > > > >
> > > > > > but kfunc is writing into digest_p, so that const is wrong?...
> > > > > >
> > > > > > >  {
> > > > > > >         struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dy=
nptr_kern *)digest_p;
> > > > > > >         const struct inode *inode =3D file_inode(file);
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > index 6eb6c82ed2ee..3d44896587ac 100644
> > > > > > > --- a/kernel/bpf/helpers.c
> > > > > > > +++ b/kernel/bpf/helpers.c
> > > > > > > @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const =
struct bpf_dynptr *p,
> > > > > > >   * Copies data from source dynptr to destination dynptr.
> > > > > > >   * Returns 0 on success; negative error, otherwise.
> > > > > > >   */
> > > > > > > -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, =
u64 dst_off,
> > > > > > > -                               struct bpf_dynptr *src_ptr, u=
64 src_off, u64 size)
> > > > > > > +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst=
_ptr, u64 dst_off,
> > > > > >
> > > > > > again, dst_ptr clearly is modifiable because we are copying dat=
a into it.
> > > > > >
> > > > > > What am I missing, why is this logically correct?
> > > > > >
> > > > > > (I understand that from purely C type system POV this is fine, =
because
> > > > > > we don't modify bpf_dynptr struct itself on the stack, but bpf_=
dynptr
> > > > > > is a representation of some memory, and if we are modifying thi=
s
> > > > > > memory, then I think it should be not marked as const)
> > > > >
> > > > > The patch is just to first make the arg type determination indepe=
ndent
> > > > > from bpf_reg_state and make kfunc signature consistent based on w=
hat
> > > > > commit 52f37c4e0f11 (bpf: Rework process_dynptr_func) has laid ou=
t.
> > > > >
> > > > > Perhaps MEM_RDONLY is a bit misleading. In process_dynptr_func(),=
 the
> > > > > flag means the dynptr struct on the stack is immutable. Currently=
,
> > > > > there is no way (and maybe no need?) to specify read-only dynptr.
> > > > >
> > > >
> > > > are you basically trying to determine if CONST_DYNPTR_PTR is allowe=
d or not?
> > >
> > > Yes.
> > >
> > > >
> > > > > > > The verifier should decide whether a dynptr argument is read-=
only
> > > >
> > > > can you please remind us what "read-only dynptr argument" means for=
 verifier?
> > >
> > > Oh well... my apologies for the inconsistency in commit message and
> > > comments. It should be "immutable" instead of "read-only" here.
> >
> > I guess I'd suggest
> >
> > struct bpf_dyntpr *const dptr
> >
> > to mark this through type system? that is, *constant pointer* to
> > dynptr, not a pointer to *constant dynptr*
> >
> > WDYT?
>
> I think they both make sense from different angles, but I am not sure
> which one is better.
>
> From purely C's point of view. the pointer points to a struct dynptr
> that should not be mutated so "const struct dynptr *p" is correct.
>
> From the BPF dynptr abstraction's point of view, the pointer points to
> the underlying memory (e.gg., skb, file, ringbuf, etc.), so "struct
> dynptr * const p".
>
> Any way we choose, I'd suggest that to be a separate patch. This patch
> at least makes things consistent and fixes a logical bug.

if we could rely on decltag, I'd go with that. But *const is unusual
and stands out, so I'd go with that. I wonder if anyone else has any
thoughts.
>
> >
> > >
> > > >
> > > > > >
> > > > > > > +                               const struct bpf_dynptr *src_=
ptr, u64 src_off, u64 size)
> > > > > > >  {
> > > > > > >         struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_ke=
rn *)dst_ptr;
> > > > > > >         struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_ke=
rn *)src_ptr;
> > > > > >
> > > > > > [...]

