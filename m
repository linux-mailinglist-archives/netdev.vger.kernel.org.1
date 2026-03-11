Return-Path: <netdev+bounces-266770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDRVMzzKsWnvFAAAu9opvQ
	(envelope-from <netdev+bounces-266770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 21:02:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 355D7269BFF
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 21:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADD4830B14FC
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42375382380;
	Wed, 11 Mar 2026 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6OJbPgq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36072DE6E3
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773259302; cv=pass; b=LKPKbUCayuMP5x3WxGrb+9JdYBVp3s1kqPAQo0xR4feOMOp2B2UNZgojmPdV2/u3tDYv6d8RCMFW2o7AD8+HivXWvd1wqJ/8Hzqibmb+lplF93pWM5rqdn8x3G9Gd24aUD+cc5dVLcElPIvnHFhuOpBoxAlwsWDB4QfeMtk1wDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773259302; c=relaxed/simple;
	bh=R+ZXp3/tqW/i0wREeECzf9YJ666Gdsm9vw9LNfjCxKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quRq+/ygxHqgFxItZs8ZMQ7AdLfpM7I801k3MEBIavIPqwt7h+BBsjM/TslMjvR9mIJe9xS2S20MILSA6lA0Sa/bUQET9QlRBl1Ey6P8TEuZOxsv7axr6onb0awZMNeWhEdnaRvp+9a2SCyUHWTuHoomaIXCmUpNlNEvfJFVIdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6OJbPgq; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4170e916d77so108567fac.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 13:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773259300; cv=none;
        d=google.com; s=arc-20240605;
        b=UUb4CWSCH0R7bdDJgLpWgKtUeoAa+U08bSI/nv2bMZcOyYN50EEv2WgGq5jRy0OZZE
         MHJ5EMgiu9AKy4HhScKzw/Ouw1X9ag7WGM5JPpK9iYojQBA5DRkeft22LZ6W9EQNvwPI
         dTLD4G0BFTX+zbqOeZFG66T7GdTIrifnCTZLXT39R6K867wzdb4Pzhz4NOq90M5HIiHH
         mf/dS6b5PLoxwYdJhPToUInqCq5h58eMQQPVsvwaHelX4AvIUYWOIqnlcwdmZbyZo71S
         apck9qkJErSyQ32XYzIqH5Pe8jQuRn4iwLbloRSlFCHnDnQp8F6LoErFoDXrvcx1w2by
         ky2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fHPnCWsaqfvTp1UbNlu89sJKMGTnnSPPMuKtOaYd/aQ=;
        fh=n5nkV6D6KQ7ZScz5ZIOy9wqTdyZ5VIlFPtf3YflB7bk=;
        b=O1QAi8XuJ9ZVoueeouFy/D9Fu83Z45y0GlWNSV4f6I9BFDGUIq+ds5bie7cuzZ0oWl
         yz2ZVhqqYMfCiopxllsind6xQaCVwAygYtWDSaxOCaebvsifHXyrclne50/IHiJ8hioK
         ImXXnP/EdN4mZac+2k0IXh6mlsM80AMqzZjaW3e9l8BFaepkae6XlRoEihzEXXqLQNFK
         /WZR8eN6MPKacnTqTxulRCLCTYKAj1b8mlPZrtnSIBQWoIvGf98Lcqmd4+FMD9zgXkAj
         e3zpT57pUVWAakirAIqKNtKm/fCOn0b8RIJKiCRCuwrCh1LiHVdtK95CuUFutXVrMM5I
         TW9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773259300; x=1773864100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHPnCWsaqfvTp1UbNlu89sJKMGTnnSPPMuKtOaYd/aQ=;
        b=l6OJbPgqDAN9JeVNzGdYlfVpubpFb2mKo6QQ2ilV3jdxm74uUryoSFL/D1Td7SHx6d
         +5TkW5fR3lcZtcVBQCTA8yCZYJeT+oWx98xGA8vgT4TUWHqWh15p8oG5mHfFj8oeHVWs
         R5dP2u2by/8f7ri9kE7U/Zgvu6DUm1fmG52UadYfvkcnpcPKeFNT9rWCOou1LCqyKSvK
         SRIbzTekTGOscb7oARz5xq08v7s3fkZBOZPX95VVCIdisbcE6pQ6j795dCD1x4TP5N+B
         zxeo42V1uhxaEOdiJWbht7MiT5qVItCuNx5JRx17o/RSWCkT4gIZbg5EratW8u5yBiHX
         gnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773259300; x=1773864100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHPnCWsaqfvTp1UbNlu89sJKMGTnnSPPMuKtOaYd/aQ=;
        b=TH+N/9No6dhX9dTMZOvDxDYPe6Kc+OZEZl8VdxKYZ3iabVLhYWbIZndDuOAkeQeWps
         ZL9NX9ul0Ugt6UoUb9JfdWvKpSB3xQygzr2nzyUwRM9DeAKbfwCgM28yngLlILwbdCpx
         2XQNbvh0Dz6jmkmTUgue3VAyhy+lIp7YtcGmRLBSV6NRgpWGIsosgZtw++XmnRxNonbK
         Cy0zrcYr9ZdAFJlNDz3gmKYG/pRE0h6F6QGk7BFw34/7E0RZtMEFRZjk6j3Y2rwmTCXE
         CjLkg02KrLQ4GffocRx0gS8YXvdIbYuY5Mrq3pcV1zqbF8LCx4WkxUEnl3YoFl4pVnvB
         c35Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiD/TF2NVwz1sjYzW5hB9TovLggy9Ln7tvhLsWBH4byPDQ3ld+GWPQyHZzQAFXLqC9EKD609A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLDQZkh7gUDBL4pjfMknjk+Opue8ksjQ6cGGg2LjlUOA29bSa
	/PqMKTQnvcRRGHa1SOVHqeF1ZOAQH/wFYFHKPYC77pJxOA2Lypj58v4BtcTvrJV8NV6GPtX+l7S
	h+1krPMbaMFWFlEQz8giZvFBxwfmem4k=
X-Gm-Gg: ATEYQzzuVVFkbSf1xl//1TJs3g8TM/uuzPGtydm5EUf8Hf0fpoZTfHtoua52G667Fhy
	MNzo3nUdqNJJyldd7RmZO/SUxQNDrepT/mNN6CjeHYgOqel0nSwociL141eR6lkxURhrQP0ZIQY
	n9rseqVNHol4MSChFWFKCoswJiHFUBx8gT5JKofU9h9KqscG3GRSYFlA4WlgNGXzgJwaTN7J6g1
	du3U9nBVrlBZ4Q4p3jsJjqAC5hxDoiFu6KmjBgB83tsfzsTTgOJD7TX/Whdn9MZcW+lGYLuniNG
	LvcUnI0=
X-Received: by 2002:a05:6871:c303:b0:417:382f:c242 with SMTP id
 586e51a60fabf-4177c8b2f10mr2070301fac.18.1773259296417; Wed, 11 Mar 2026
 13:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
In-Reply-To: <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 13:01:24 -0700
X-Gm-Features: AaiRm52HnBR9tlmL7QySEZ_Sk1jcSBT-CpyZhFn0m48zVnwHKYssAOY6H82_17Q
Message-ID: <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-266770-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 355D7269BFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:44=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
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
>
> but kfunc is writing into digest_p, so that const is wrong?...
>
> >  {
> >         struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynptr_kern =
*)digest_p;
> >         const struct inode *inode =3D file_inode(file);
>
> [...]
>
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
> > -                               struct bpf_dynptr *src_ptr, u64 src_off=
, u64 size)
> > +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 =
dst_off,
>
> again, dst_ptr clearly is modifiable because we are copying data into it.
>
> What am I missing, why is this logically correct?
>
> (I understand that from purely C type system POV this is fine, because
> we don't modify bpf_dynptr struct itself on the stack, but bpf_dynptr
> is a representation of some memory, and if we are modifying this
> memory, then I think it should be not marked as const)

The patch is just to first make the arg type determination independent
from bpf_reg_state and make kfunc signature consistent based on what
commit 52f37c4e0f11 (bpf: Rework process_dynptr_func) has laid out.

Perhaps MEM_RDONLY is a bit misleading. In process_dynptr_func(), the
flag means the dynptr struct on the stack is immutable. Currently,
there is no way (and maybe no need?) to specify read-only dynptr.

>
> > +                               const struct bpf_dynptr *src_ptr, u64 s=
rc_off, u64 size)
> >  {
> >         struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *)dst_p=
tr;
> >         struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *)src_p=
tr;
>
> [...]

