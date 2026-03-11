Return-Path: <netdev+bounces-266700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LdeI6aZsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:34:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFFA2676B0
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 891F33021B8E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1B43DEAEB;
	Wed, 11 Mar 2026 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R45Z+FyX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5B36402A
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246881; cv=pass; b=HNUuBDXAw93iHyLliypPqOnV3hqDubiMHdVZrFB1rwF+3ZE1X3wvRNVJAbvfaZHHz0pylQZLUbGVBGzl9CZAAZHIaFHEKqO0bIDFg0a8VphzDtBqEjZKEfhNrTSYp3z4un6iuZMhORsANwHzSkuqQ65yfwwoSPOn6AqXw+Ij4wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246881; c=relaxed/simple;
	bh=N7jO3orMqZR2oJ+QCZmCYBbnPuVa7c8V9rQdctlCuc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgvC+R0ynSfwOvjsJ1qlJPzK1HQp3u9mvUXfYJj6kme1FfzHgL8Rwwg+Wkl6y4+AvmuGILc9vIL0sGcYQQtDSltfVDqUPmS1xhx6gtxjjKW8QgG21iSkPD1SQmbsMuMhmLMn4e2h8Sx1cYT/8Jmr9x4ZZDA80Xxj2BEEKxNEOd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R45Z+FyX; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79628fb5c05so132747b3.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773246878; cv=none;
        d=google.com; s=arc-20240605;
        b=XBqmAek+Pu7kzCn7SmB5vOqiuDSEtWcZjGTPxxjPgstUC5FPSlbOv7YEaLd8WxZ4LS
         7vYIzy3/+fFWaYHBVviTed4mlpbQeryFU6uAScmTNitEd4uzBbO926B/XIW/AtJM8Kti
         vzfcxhx88l4rMzYLNSRk87I8+oIKRyfggfEUS13+IFIg5DCbKGX7LS8whHHLwmqdTRYF
         z8tHXCkNkVW6+EITwSOqIgk62uRZDAjnKseCpDCEPudGguowtNWYIzfErE0Pi+9UVTYE
         bE6QXjDCrrPNL1kmaoMekCW0/nQikq8HrRZuR2tN5Tj98WcZL2jGcuTA7u8iRQhYCvie
         +ylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7u6RlutJheLDs8sUeXMwUnSzGxwPE/feaSihiWTJ5jA=;
        fh=CM4FaoXlIgigPehEFo+uotgu1H0AzGw1EY8em/tKCvs=;
        b=h99w53+o7gw9OwAwpIm5KpvtasCi8Gl1QBdeSbh5fBdJLf58X1F4wIehm61P2Hhfx8
         RrXhEhPl9D9XQrHe/zX+HPUp1FafUOmWLxlS2EqRbwOHxp8R5eJ7VdBTZgtKEiux2qRs
         xPHZv1AxspXJk/a8n5WlbfxximgT9lrgfSdPf5+Cvgx5n4KIcMr41b4395Qd83U0g5Au
         /URmWXF2npOXXqZKWsUMviUAdYrENV4e6aKPANnwCAZZtClVMKDj/et3HYMA8g03Oz2F
         s+R8m/uPkOef85viS0mcU16bKfaENwSN8KF5fDH1rKV3fueZYP7lKfiji0XmjIIEXh9w
         8sww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773246878; x=1773851678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7u6RlutJheLDs8sUeXMwUnSzGxwPE/feaSihiWTJ5jA=;
        b=R45Z+FyXNurHPVM0Jt7ruWUaCnHa+2kW4RVgmzMrd/2MyVzNo2n0dSqW4s7FZOkiP1
         Dd4VjfXWL20+SNV/pnjaUFLvRwGk9xAfNsRrTRgqAR3+pgNb7Nm1Ul2FALdXpPe/ue+v
         1vLhLMbkUgMZ8TWCfVsoyq1bS86LrpYIGmlLuD+Fm4P8JD1CPQyya5Q0IikAidCuIv29
         7zXNC14TvsQ+a/UyoOElX6pblYUbhv71A9q68rvDnXR99kzvOamrZd9oTDy4D7sivKNc
         F8eirQwaG7JQFCmWzzXoof2h7X6+Ka8U5SEC9aOXUwN2hT3uQH3ogo69IEfoqubPnxti
         BJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773246878; x=1773851678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7u6RlutJheLDs8sUeXMwUnSzGxwPE/feaSihiWTJ5jA=;
        b=pfv9tqTSSfiJhRALMBIfTJRQNyxkToS//74MT40oxGH/2X8P7qt42OaMkp7Lsa5Py4
         sucU1vCksnY8C7doHJX7JjS/dt19ievxIP4qIUgfoXsjacCiySNizMhLB5sOH181oBQe
         up+pBvf0aO25g2EKNPMTrg1fKZ+35XCqhLPPjlIahhagtgPPtpH3yhz9YNxEDFC/VOVw
         vlVDjbUMK2Z2lvenR93FsLaUnJSZq0bbpeti9EgHUSR7qyRw1EKCW7N7uGGjLPwM4ddI
         vy851FBYWAE3U0R7cgfDFrh62RIak98Au/QuA2tUnJMI4Wlyw84zf759hn7sNc+qzTtM
         bJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVpkwwos3jjp6yiDwKRrZbKrgdFLqiUuK7jlebuTT0MULpyW2/VT235H6qooPcAETNbFH+GWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb3B5WCbjfXwqEuLwCT09bOdbX5FXtYlcledxtCCCX+KSsPUck
	vOabuGaQbbR+OwWI7zYckOEWiyv6f0eDiawexveFHCS1ddjsW/ZGSo/fs8mJZNKCEkpnaoPeLTz
	laLqrmzztd8fui9V03FSGSNmL6yxL4mI=
X-Gm-Gg: ATEYQzx9Y0l6YsnD/iO9V6mbnz6nJlRlkYRBB4v4ea9xLHnKyP470O0xciNswJj/LPc
	9uGRBFjYF/0a0S7aXT5PHYVBOOhI3Xadoyg2JjCjLDvjQBgiRV+vyA80uEuebwv7FIp74nKlLJv
	VCq+LVoULVZo2L6PWQlFBlFJ+oGSSq6jQInTBnNLU4JAVM5MHEKioXc6OeuH57ttJZeqlKpgOhH
	0Jv2AN/9dsoD5Dda4/BQ3qWFf1jQdtSWQLoPHDy6UEXazV8b7c/pvIkarKO8icJWmuH9AFKGSGG
	Hlz+NuA=
X-Received: by 2002:a05:690c:d8d:b0:796:31ce:6026 with SMTP id
 00721157ae682-79917ec0f44mr30299877b3.16.1773246878137; Wed, 11 Mar 2026
 09:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <87o6kutoc1.fsf@gmail.com>
In-Reply-To: <87o6kutoc1.fsf@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 09:34:27 -0700
X-Gm-Features: AaiRm53cJgiEvgS-_NttJhCdTCZqNrtSmB3q_0uS0_PGxkN4Ci8FyP79OLZGVGQ
Message-ID: <CAMB2axNeo53OftBUuvh_FtYqujk8veUFCQ652YTtBiBWkcLxqg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266700-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2AFFA2676B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 7:47=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Amery Hung <ameryhung@gmail.com> writes:
>
> > The verifier should decide whether a dynptr argument is read-only
> > based on if the type is "const struct bpf_dynptr *", not the type of
> > the register passed to the kfunc. This currently does not cause issues
> > because existing kfuncs that mutate struct bpf_dynptr are constructors
> > (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs have
> > additional check in process_dynptr_func() to make sure the stack slot
> > does not contain initialized dynptr. Nonetheless, this should still be
> > fixed to avoid future issues when there is a non-constructor dynptr
> > kfunc that can mutate dynptr. This is also a small step toward unifying
> > kfunc and helper handling in the verifier, where the first step is to
> > generate kfunc prototype similar to bpf_func_proto before the main
> > verification loop.
> >
> > We also need to correctly mark some kfunc arguments as "const struct
> > bpf_dynptr *" to align with other kfuncs that take non-mutable dynptr
> > argument and to not break their usage. Adding const qualifier does
> > not break backward compatibility.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  fs/verity/measure.c                            |  2 +-
> >  include/linux/bpf.h                            |  8 ++++----
> >  kernel/bpf/helpers.c                           | 10 +++++-----
> >  kernel/bpf/verifier.c                          | 18 +++++++++++++++++-
> >  kernel/trace/bpf_trace.c                       | 18 +++++++++---------
> >  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
> >  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
> >  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
> >  8 files changed, 43 insertions(+), 32 deletions(-)
> >
> > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > index 6a35623ebdf0..3840436e4510 100644
> > --- a/fs/verity/measure.c
> > +++ b/fs/verity/measure.c
> > @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
> >   *
> >   * Return: 0 on success, a negative value on error.
> >   */
> > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_=
dynptr *digest_p)
> > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const struc=
t bpf_dynptr *digest_p)
> >  {
> >       struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynptr_kern *)=
digest_p;
> >       const struct inode *inode =3D file_inode(file);
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index b78b53198a2e..946a37b951f7 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3621,8 +3621,8 @@ static inline int bpf_fd_reuseport_array_update_e=
lem(struct bpf_map *map,
> >  struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags);
> >  struct bpf_key *bpf_lookup_system_key(u64 id);
> >  void bpf_key_put(struct bpf_key *bkey);
> > -int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
> > -                            struct bpf_dynptr *sig_p,
> > +int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
> > +                            const struct bpf_dynptr *sig_p,
> >                              struct bpf_key *trusted_keyring);
> >
> >  #else
> > @@ -3640,8 +3640,8 @@ static inline void bpf_key_put(struct bpf_key *bk=
ey)
> >  {
> >  }
> >
> > -static inline int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p=
,
> > -                                          struct bpf_dynptr *sig_p,
> > +static inline int bpf_verify_pkcs7_signature(const struct bpf_dynptr *=
data_p,
> > +                                          const struct bpf_dynptr *sig=
_p,
> >                                            struct bpf_key *trusted_keyr=
ing)
> >  {
> >       return -EOPNOTSUPP;
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 6eb6c82ed2ee..3d44896587ac 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf=
_dynptr *p,
> >   * Copies data from source dynptr to destination dynptr.
> >   * Returns 0 on success; negative error, otherwise.
> >   */
> > -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 dst_of=
f,
> > -                             struct bpf_dynptr *src_ptr, u64 src_off, =
u64 size)
> > +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 =
dst_off,
> > +                             const struct bpf_dynptr *src_ptr, u64 src=
_off, u64 size)
> >  {
> >       struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *)dst_ptr=
;
> >       struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *)src_ptr=
;
> > @@ -3055,7 +3055,7 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr=
 *dst_ptr, u64 dst_off,
> >   * at @offset with the constant byte @val.
> >   * Returns 0 on success; negative error, otherwise.
> >   */
> > -__bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *p, u64 offset, u6=
4 size, u8 val)
> > +__bpf_kfunc int bpf_dynptr_memset(const struct bpf_dynptr *p, u64 offs=
et, u64 size, u8 val)
> >  {
> >       struct bpf_dynptr_kern *ptr =3D (struct bpf_dynptr_kern *)p;
> >       u64 chunk_sz, write_off;
> > @@ -4069,8 +4069,8 @@ __bpf_kfunc void bpf_key_put(struct bpf_key *bkey=
)
> >   *
> >   * Return: 0 on success, a negative value on error.
> >   */
> > -__bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
> > -                            struct bpf_dynptr *sig_p,
> > +__bpf_kfunc int bpf_verify_pkcs7_signature(const struct bpf_dynptr *da=
ta_p,
> > +                            const struct bpf_dynptr *sig_p,
> >                              struct bpf_key *trusted_keyring)
> >  {
> >  #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1153a828ce8d..0f77c4c5b510 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12276,6 +12276,22 @@ static bool is_kfunc_arg_dynptr(const struct b=
tf *btf, const struct btf_param *a
> >       return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_DYNPTR_ID);
> >  }
> >
> > +static bool is_kfunc_arg_const_ptr(const struct btf *btf, const struct=
 btf_param *arg)
> > +{
> > +     const struct btf_type *t, *resolved_t;
> > +
> > +     t =3D btf_type_skip_modifiers(btf, arg->type, NULL);
> > +     if (!t || !btf_type_is_ptr(t))
> > +             return false;
> > +
> > +     resolved_t =3D btf_type_skip_modifiers(btf, t->type, NULL);
> nit: t is ptr type, maybe we can do t =3D btf_type_by_id(btf, t->type)
> before the loop starts, as we know the result of the first iteration.

Will add it before calling btf_type_skip_modifiers.

> > +     for (; t !=3D resolved_t; t =3D btf_type_by_id(btf, t->type))
> > +             if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_CONST)
> nit: btf_kind() is a bit shorter than BTF_KIND_INFO()

Will replace it with btf_kind()

> > +                     return true;
> > +
> > +     return false;
> > +}
> The logic in this function looks correct to me. The refactoring makes
> sense as well (although I'm not 100% sure how this is relevant to this
> patch series)

Thanks for taking a look at the set!

Indeed independent. I will separate these two patches if the rest is
going to take more time.

> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> > +
> >  static bool is_kfunc_arg_list_head(const struct btf *btf, const struct=
 btf_param *arg)
> >  {
> >       return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_LIST_HEAD_ID);
> > @@ -13509,7 +13525,7 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
> >                       enum bpf_arg_type dynptr_arg_type =3D ARG_PTR_TO_=
DYNPTR;
> >                       int clone_ref_obj_id =3D 0;
> >
> > -                     if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> > +                     if (is_kfunc_arg_const_ptr(btf, &args[i]))
> >                               dynptr_arg_type |=3D MEM_RDONLY;
> >
> >                       if (is_kfunc_arg_uninit(btf, &args[i]))
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 9bc0dfd235af..127c317376be 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3391,7 +3391,7 @@ typedef int (*copy_fn_t)(void *dst, const void *s=
rc, u32 size, struct task_struc
> >   * direct calls into all the specific callback implementations
> >   * (copy_user_data_sleepable, copy_user_data_nofault, and so on)
> >   */
> > -static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dp=
tr, u64 doff, u64 size,
> > +static __always_inline int __bpf_dynptr_copy_str(const struct bpf_dynp=
tr *dptr, u64 doff, u64 size,
> >                                                const void *unsafe_src,
> >                                                copy_fn_t str_copy_fn,
> >                                                struct task_struct *tsk)
> > @@ -3533,49 +3533,49 @@ __bpf_kfunc int bpf_send_signal_task(struct tas=
k_struct *task, int sig, enum pid
> >       return bpf_send_signal_common(sig, type, task, value);
> >  }
> >
> > -__bpf_kfunc int bpf_probe_read_user_dynptr(struct bpf_dynptr *dptr, u6=
4 off,
> > +__bpf_kfunc int bpf_probe_read_user_dynptr(const struct bpf_dynptr *dp=
tr, u64 off,
> >                                          u64 size, const void __user *u=
nsafe_ptr__ign)
> >  {
> >       return __bpf_dynptr_copy(dptr, off, size, (const void __force *)u=
nsafe_ptr__ign,
> >                                copy_user_data_nofault, NULL);
> >  }
> >
> > -__bpf_kfunc int bpf_probe_read_kernel_dynptr(struct bpf_dynptr *dptr, =
u64 off,
> > +__bpf_kfunc int bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *=
dptr, u64 off,
> >                                            u64 size, const void *unsafe=
_ptr__ign)
> >  {
> >       return __bpf_dynptr_copy(dptr, off, size, unsafe_ptr__ign,
> >                                copy_kernel_data_nofault, NULL);
> >  }
> >
> > -__bpf_kfunc int bpf_probe_read_user_str_dynptr(struct bpf_dynptr *dptr=
, u64 off,
> > +__bpf_kfunc int bpf_probe_read_user_str_dynptr(const struct bpf_dynptr=
 *dptr, u64 off,
> >                                              u64 size, const void __use=
r *unsafe_ptr__ign)
> >  {
> >       return __bpf_dynptr_copy_str(dptr, off, size, (const void __force=
 *)unsafe_ptr__ign,
> >                                    copy_user_str_nofault, NULL);
> >  }
> >
> > -__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(struct bpf_dynptr *dp=
tr, u64 off,
> > +__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(const struct bpf_dynp=
tr *dptr, u64 off,
> >                                                u64 size, const void *un=
safe_ptr__ign)
> >  {
> >       return __bpf_dynptr_copy_str(dptr, off, size, unsafe_ptr__ign,
> >                                    copy_kernel_str_nofault, NULL);
> >  }
> >
> > -__bpf_kfunc int bpf_copy_from_user_dynptr(struct bpf_dynptr *dptr, u64=
 off,
> > +__bpf_kfunc int bpf_copy_from_user_dynptr(const struct bpf_dynptr *dpt=
r, u64 off,
> >                                         u64 size, const void __user *un=
safe_ptr__ign)
> >  {
> >       return __bpf_dynptr_copy(dptr, off, size, (const void __force *)u=
nsafe_ptr__ign,
> >                                copy_user_data_sleepable, NULL);
> >  }
> >
> > -__bpf_kfunc int bpf_copy_from_user_str_dynptr(struct bpf_dynptr *dptr,=
 u64 off,
> > +__bpf_kfunc int bpf_copy_from_user_str_dynptr(const struct bpf_dynptr =
*dptr, u64 off,
> >                                             u64 size, const void __user=
 *unsafe_ptr__ign)
> >  {
> >       return __bpf_dynptr_copy_str(dptr, off, size, (const void __force=
 *)unsafe_ptr__ign,
> >                                    copy_user_str_sleepable, NULL);
> >  }
> >
> > -__bpf_kfunc int bpf_copy_from_user_task_dynptr(struct bpf_dynptr *dptr=
, u64 off,
> > +__bpf_kfunc int bpf_copy_from_user_task_dynptr(const struct bpf_dynptr=
 *dptr, u64 off,
> >                                              u64 size, const void __use=
r *unsafe_ptr__ign,
> >                                              struct task_struct *tsk)
> >  {
> > @@ -3583,7 +3583,7 @@ __bpf_kfunc int bpf_copy_from_user_task_dynptr(st=
ruct bpf_dynptr *dptr, u64 off,
> >                                copy_user_data_sleepable, tsk);
> >  }
> >
> > -__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *=
dptr, u64 off,
> > +__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(const struct bpf_dy=
nptr *dptr, u64 off,
> >                                                  u64 size, const void _=
_user *unsafe_ptr__ign,
> >                                                  struct task_struct *ts=
k)
> >  {
> > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/s=
elftests/bpf/bpf_kfuncs.h
> > index 7dad01439391..ffb9bc1cace0 100644
> > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > @@ -70,13 +70,13 @@ extern void *bpf_rdonly_cast(const void *obj, __u32=
 btf_id) __ksym __weak;
> >
> >  extern int bpf_get_file_xattr(struct file *file, const char *name,
> >                             struct bpf_dynptr *value_ptr) __ksym;
> > -extern int bpf_get_fsverity_digest(struct file *file, struct bpf_dynpt=
r *digest_ptr) __ksym;
> > +extern int bpf_get_fsverity_digest(struct file *file, const struct bpf=
_dynptr *digest_ptr) __ksym;
> >
> >  extern struct bpf_key *bpf_lookup_user_key(__s32 serial, __u64 flags) =
__ksym;
> >  extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
> >  extern void bpf_key_put(struct bpf_key *key) __ksym;
> > -extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> > -                                   struct bpf_dynptr *sig_ptr,
> > +extern int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_pt=
r,
> > +                                   const struct bpf_dynptr *sig_ptr,
> >                                     struct bpf_key *trusted_keyring) __=
ksym;
> >
> >  struct dentry;
> > diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools=
/testing/selftests/bpf/progs/dynptr_success.c
> > index e0d672d93adf..e0745b6e467e 100644
> > --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> > +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> > @@ -914,7 +914,7 @@ void *user_ptr;
> >  char expected_str[384];
> >  __u32 test_len[7] =3D {0/* placeholder */, 0, 1, 2, 255, 256, 257};
> >
> > -typedef int (*bpf_read_dynptr_fn_t)(struct bpf_dynptr *dptr, u64 off,
> > +typedef int (*bpf_read_dynptr_fn_t)(const struct bpf_dynptr *dptr, u64=
 off,
> >                                   u64 size, const void *unsafe_ptr);
> >
> >  /* Returns the offset just before the end of the maximum sized xdp fra=
gment.
> > @@ -1106,7 +1106,7 @@ int test_copy_from_user_str_dynptr(void *ctx)
> >       return 0;
> >  }
> >
> > -static int bpf_copy_data_from_user_task(struct bpf_dynptr *dptr, u64 o=
ff,
> > +static int bpf_copy_data_from_user_task(const struct bpf_dynptr *dptr,=
 u64 off,
> >                                       u64 size, const void *unsafe_ptr)
> >  {
> >       struct task_struct *task =3D bpf_get_current_task_btf();
> > @@ -1114,7 +1114,7 @@ static int bpf_copy_data_from_user_task(struct bp=
f_dynptr *dptr, u64 off,
> >       return bpf_copy_from_user_task_dynptr(dptr, off, size, unsafe_ptr=
, task);
> >  }
> >
> > -static int bpf_copy_data_from_user_task_str(struct bpf_dynptr *dptr, u=
64 off,
> > +static int bpf_copy_data_from_user_task_str(const struct bpf_dynptr *d=
ptr, u64 off,
> >                                           u64 size, const void *unsafe_=
ptr)
> >  {
> >       struct task_struct *task =3D bpf_get_current_task_btf();
> > diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.=
c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > index d249113ed657..c3631fd41977 100644
> > --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > @@ -11,12 +11,7 @@
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> >  #include "bpf_misc.h"
> > -
> > -extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
> > -extern void bpf_key_put(struct bpf_key *key) __ksym;
> > -extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> > -                                   struct bpf_dynptr *sig_ptr,
> > -                                   struct bpf_key *trusted_keyring) __=
ksym;
> > +#include "bpf_kfuncs.h"
> >
> >  struct {
> >       __uint(type, BPF_MAP_TYPE_RINGBUF);
> > --
> > 2.47.3

