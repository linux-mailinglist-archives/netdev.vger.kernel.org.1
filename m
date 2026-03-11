Return-Path: <netdev+bounces-266765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAR4B1TGsWkFFQAAu9opvQ
	(envelope-from <netdev+bounces-266765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:45:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC33269948
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5EA73087D09
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981F8377024;
	Wed, 11 Mar 2026 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KniUiV6/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405DF3750BA
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258248; cv=pass; b=hixq0d8fjKKQNHexacCcne3UmdTYhWWP1hkMAe63N89iahHXpmnWqvaHDKA2gxpkS8jvYxX8XAHnzPNW8qiYZK4RTldngb929C/W60Knr1FG5oyZA4NlLxzhudkUeYMgDXfUM1HVYVTWgbMfwDX8M+YHyuoO4zEOdmpvUw/1iaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258248; c=relaxed/simple;
	bh=1nbmNN2+uWLC1om5FX22Xmv7l/AAsmEpegK3jh8gm9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFV7uqxXH44fWrS0uedNdHF/orhUymBkvu0rLMUWn2bk+wE3PtxG9lBtILOpwB25iM/4IEXJox1+ULIcKqX4coayMtnm3ASRn0b+x8S5jkjHgBeOGKH1EUtUQbK2g3Wtv0qMHWkqI/mtR+8yYw4O5pqImnc4MM3egEN2+VUg7u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KniUiV6/; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c73a5473bbdso68604a12.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773258244; cv=none;
        d=google.com; s=arc-20240605;
        b=KxchSkB0sJc//ii4VTtxJd7B43grHHlck3WwwQ/9HqeQNK60gdSMYVu1KIllRBAtRw
         NK7U52PV6KM/eB/7mU9vigetvK++MIjRHJHP6IC6/H95yApNphojSrzbEe3mhzT5pTwb
         cdFoEdnFL1/rqHt3aKisazvfeYm9/n01udplKM1/mcPrhGlxJ+hj976IpRS2tlnq5SBB
         CXGqU+0mumSqd23QP8UBiQBVr4spuh1qkENbFM8I703sPjOJ7DMnzcxn8Uq1DQbwUDPV
         ca/eNnXaDfRTjLHe+MnXTCTYRuWfPxAB5/ivVysiCLMBHD3cvMOfRZC+W5KhIu0QOp/N
         hQjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iEAE1DR3z4IwpbaUy8A7+sGJEjgivXuZJQBR6NB9aws=;
        fh=YiEndGiWKlHlxhfItC+Nhx2SvEuVujf9EWJDDbr0uvg=;
        b=i3iWAM/1xKWwAM1xqsIsetDoBAn0nn9A4rSWiu08jZJFRuLEHCQnr++NVxStyriEEq
         7iFPKrdchP5xJ5lHlCHLUtFf9Mix8NJxfWeCfiCmGUw9DJ8rHTI4DxCpghmAShSR6xI7
         KvSeaYrofnP9RpUUUTVbgC9XqEuNW1Hq9s46I3XtGC5fnV8hP+pz8aPpsIvSG8FFl+Tg
         5cMpjVuEot9c5DqjyomZPz9DZmsS0ZU3imMCy3J4VDk+rvzWzbllTfnqzRP48dcF3kQ1
         BdbPDLZKv/+NjKSy1x/Oy1sadwyoh8Erk+DH9thxyCTs3FiSeQy/7pS7Oo1cX0p3a0cj
         7Oug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258244; x=1773863044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEAE1DR3z4IwpbaUy8A7+sGJEjgivXuZJQBR6NB9aws=;
        b=KniUiV6/XFNmf0hJB5ioZzAUVseKPmiaEBfcQIpIoa6KxbcAoInWV2Nt+xQ/+F1YbJ
         /nFfbK0UG875+X5tUOOfrBL2RafG+lUxulKb17BCWrUFPmizYQULXD8W2m1BJ1ZQXiXY
         Uff4OMkgXQhfIkRHFESovBiMCswuVWtWYrD0fweteTh1Viw1zq6wB52Klv/6qabtHGSo
         7fMMSZXGuZmwefEj77bRuNVL99M8rScV01zksjIiOHqpV9FLArH4fmr0tgP7Ovp9aq0F
         7h4X55fvqNnSux+B2ZKHE7q8bovEJ670hfV2/WRDtLq/65qCRjXd4ngqxhlkTcN4RG8n
         0Srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258244; x=1773863044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iEAE1DR3z4IwpbaUy8A7+sGJEjgivXuZJQBR6NB9aws=;
        b=Pp4oKze/XUILv7FaSG1iz+dVAH0gNjUFHXsuMfiZETyJeRFWnt/MPZ9PClxoSXOfDR
         remExGMfY7ppmaLusJ89SwjjytTncLUSNfTM+rwEwUk7c9XgeSeWCKwQKRslgBI9GNyr
         n2KCzcUNGIvBO9kwQThhf/XQXwcJacKcw/D+n/bJsd5OCNduVS2/ocJb44x2kjjQ/qJK
         nIAn/Pdw+DOAhgCCR6v/5dRfXjjzhr8M+8cGUaGStrJKLBHjYL3zf+ESFvdpMm8fqyuI
         Cy1DB6tkYU+BxUCz9PavqZoXQSBfnzSOSxDHZoOLZVgh4raDWYFWDllRHma+8ZtzrYON
         5ZfA==
X-Forwarded-Encrypted: i=1; AJvYcCW3qbykFCQu574O0tggE3CBHQg69ccPG81aFIzopeHQhwI84e3aQ5KeuW3FC2stfaG8DPoeeF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/u3qPt/lCdRvkAxy/AR2+ei4E3BzRceRsdNQqD6V9dOyEI8d
	03mhpoKiZUcH6U3sITuF5eBFV3zoGluVC8IzwWeK8SwBDOi5H3bWCXPsQT6aZsScKy/iVpl7BXA
	WcFqIFZEIF972uBJBu5O7A8VOv9PCPYw=
X-Gm-Gg: ATEYQzyPEHX++SlSGcSR/fiCKMw4akQgVzhiH+OS7fu15MipADvzsFBQ4KTvck/LRm4
	ETWVdxgItnvY0PcjOMtpadfX0TX0DQn22t5nSMHFv6hYZ9NvEx8uQLJdBCmSJPdyS8npP5COSXT
	CedwjMgSPvLeTXf+0dCzz9Hn0Zktwm2rNvzua/q1lmvqvOMMBrFkrEp4lYUTSl/kZSsg47k0u5/
	m9TXVsh5obTmV5zQ5UfhTPPuwd3IKbquJMDJSQrNq7wtHO7fAaWUsjOpx3fNYllBZdVR4RB9Y5W
	4ISNw9nIPxDglw4UhQ==
X-Received: by 2002:a17:903:3846:b0:2ae:47c9:68aa with SMTP id
 d9443c01a7336-2aeae92a03dmr40203415ad.52.1773258244461; Wed, 11 Mar 2026
 12:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
In-Reply-To: <20260307064439.3247440-2-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 12:43:52 -0700
X-Gm-Features: AaiRm52PenRsEpFvNhvd5ipgeHWlrodqDFVXteRMZhoEVrKoEHLpFtXoYjZLlqQ
Message-ID: <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266765-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DC33269948
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> The verifier should decide whether a dynptr argument is read-only
> based on if the type is "const struct bpf_dynptr *", not the type of
> the register passed to the kfunc. This currently does not cause issues
> because existing kfuncs that mutate struct bpf_dynptr are constructors
> (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs have
> additional check in process_dynptr_func() to make sure the stack slot
> does not contain initialized dynptr. Nonetheless, this should still be
> fixed to avoid future issues when there is a non-constructor dynptr
> kfunc that can mutate dynptr. This is also a small step toward unifying
> kfunc and helper handling in the verifier, where the first step is to
> generate kfunc prototype similar to bpf_func_proto before the main
> verification loop.
>
> We also need to correctly mark some kfunc arguments as "const struct
> bpf_dynptr *" to align with other kfuncs that take non-mutable dynptr
> argument and to not break their usage. Adding const qualifier does
> not break backward compatibility.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  fs/verity/measure.c                            |  2 +-
>  include/linux/bpf.h                            |  8 ++++----
>  kernel/bpf/helpers.c                           | 10 +++++-----
>  kernel/bpf/verifier.c                          | 18 +++++++++++++++++-
>  kernel/trace/bpf_trace.c                       | 18 +++++++++---------
>  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
>  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
>  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
>  8 files changed, 43 insertions(+), 32 deletions(-)
>
> diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> index 6a35623ebdf0..3840436e4510 100644
> --- a/fs/verity/measure.c
> +++ b/fs/verity/measure.c
> @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
>   *
>   * Return: 0 on success, a negative value on error.
>   */
> -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dy=
nptr *digest_p)
> +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const struct =
bpf_dynptr *digest_p)

but kfunc is writing into digest_p, so that const is wrong?...

>  {
>         struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynptr_kern *)=
digest_p;
>         const struct inode *inode =3D file_inode(file);

[...]

> index 6eb6c82ed2ee..3d44896587ac 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_d=
ynptr *p,
>   * Copies data from source dynptr to destination dynptr.
>   * Returns 0 on success; negative error, otherwise.
>   */
> -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 dst_off,
> -                               struct bpf_dynptr *src_ptr, u64 src_off, =
u64 size)
> +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 ds=
t_off,

again, dst_ptr clearly is modifiable because we are copying data into it.

What am I missing, why is this logically correct?

(I understand that from purely C type system POV this is fine, because
we don't modify bpf_dynptr struct itself on the stack, but bpf_dynptr
is a representation of some memory, and if we are modifying this
memory, then I think it should be not marked as const)

> +                               const struct bpf_dynptr *src_ptr, u64 src=
_off, u64 size)
>  {
>         struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *)dst_ptr=
;
>         struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *)src_ptr=
;

[...]

