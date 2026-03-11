Return-Path: <netdev+bounces-266791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPWiK83usWnbHAAAu9opvQ
	(envelope-from <netdev+bounces-266791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:38:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACFF26AEFB
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45B12305C296
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDCA394478;
	Wed, 11 Mar 2026 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqlmsg3c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FD390989
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268678; cv=pass; b=ahwKuvQHSYpO9Nwia48LOb+yQ2kwp+C6FV/3Mll3BjLuX7VvfQdJcO9wXYre29iv6rlPgsHnrZHscanWqpUIC+pOPQNn0MGy0BBmPszvtOTSJ4YrH5/yyLaql0dqo0pZexaw9eh592HA/rzBsYjCHIILAgQHwGqaVKsLIJVMjHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268678; c=relaxed/simple;
	bh=No+SZ0mPm+dszFojpRK4g9esvb91FrLdwCZRd/DB9q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5R9EKyKaWqKWtAqXIIm5COJaTkx6ZctnXBYNkV6swTZxrDGkkHlFD6xf665gSACEeRmDf/+rVxDc2lqfV17gRJh4b+NWm/fxyto30Jf1p1Kq4buN/YAfdOIIadnQSssqLTk5b17VnyiZmThG4PFxbLlbpZhuyGKzhHo18OuylA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xqlmsg3c; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35691a231a7so191652a91.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:37:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773268676; cv=none;
        d=google.com; s=arc-20240605;
        b=HZ2+JHhjgG30RLMFRsTBWE/6RfgwJ1cGPljt8BwYSykDDjQIaEwE2ekeGQw9O5Z8jA
         y06QRRnopLTT9BgToWR1yHjJlXRcNuWfdWt6gVEsZRkyFn9aXAbn9HjlG1WpuG99VQBJ
         7e5TqrT2aLLr03myw0ORIQFhOIP7TYptzzmNTl8M/n5IdIQasxd0IQvg1Wf7/k9q+1di
         SNWSm0yd2GSwi2K72hcjf/1AR0YDNyrqdolc8JMVdVuuygF/hOfdH0tCDyVmvBG54+dt
         JuF0yM7WLytpH40MWGkbIsyBjSeK1vHHCKEnetFe3LTtAuJVGm0vf+9p5ZQ23ilp/386
         HNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=im8lCYLt3sIq/cVK2Hv56IkJrV7/hwtsfQIFRFCQbIk=;
        fh=7WkPN1qtyTqsQ1iIdvSRc4dBzANC0sgUxFq8UkXRdqs=;
        b=CjRxoTPwimcIzyFOUe1DiUKozxXHWdOzbQAzhsQrULtQBtUt7T87HQ9QjKmLBarcNo
         zcdSGs7LigHUENq1Xub/2bcW+uSDpEGzvlQ+a0WmfiCEHbFSbpTzEsUqQdfBJCNiM5xw
         Ss/IlH88hIm6ywzKuJI2+r/lWtQon3F1/2lBlWspGvyPbX+l4jB0vIfxDj699jgu9DBT
         pIdGcPcRh223/LSopY8KuGnEJ+/3jcBD3xqSM2G+suFCdKDUJB3kLSt3yd1uQcRGBvvD
         u5CQ0LCaYv/b65k1AoCdYOp70mFbtp0lKWl7I62/+rosuFJ6EPVqldlslIzK8nYp4cFC
         /tuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773268676; x=1773873476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im8lCYLt3sIq/cVK2Hv56IkJrV7/hwtsfQIFRFCQbIk=;
        b=Xqlmsg3c7fxSHhazMEJAH2kBAYO+NowDhVf5CoxKFmeyKTXxy8Rii4HOZOZzFo9Hfs
         fxxchYR983NFMapMk299fFdgfKZW/L57zfYrzVuQXTte1V1310232NlEwbGW44yur64J
         76ILZkVbLUi6pJVFfK2RlMyCoz/tjTwdSETgXjOZekWYBn+2ShrKixJv3rB4R1P657O/
         w2NtmT/abExNnY3WuazkNgkf1fe1L7GzMytKHM8NdcD+zFWg67f78Ot5+kJJQRneF7zz
         q1tT4in4ED8uzGbbMtUqkijDswHDsRdTDl6bH7io2TPpzdgX9J8tMyXxwLVvAxTM5EYj
         L11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773268676; x=1773873476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=im8lCYLt3sIq/cVK2Hv56IkJrV7/hwtsfQIFRFCQbIk=;
        b=tm+WpiuhmKFlRnzk2jCf/rQOkREUX9FoWh7PwQbfmzujTY4ifiCeUyDL7MjZVDSyLu
         weY8708JDwUumq6vB3C0PPdb02pAQE4LwVXPk0R6/yRx0M/gOaR+hTxZb3sg5+H3uukb
         C/8QNm5Q3rzuluYv9hxXPwTY9XHsO+x0hPCkRMFQsQPgo5x1+dNUclD5TdvJ9yIetV1K
         xamQ99pR8B23NUH4lVjBMTFeRq9d4azt93foXy/tvc4KJPNfGm+1+64vgFJb0RUe+K2K
         zRcHmg4DkUjDKIia2jn48Pk+r6QXT8T0Q3PprJVD/Q7771e1f2tV0102U5tMfjoCbq1+
         dp7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDtQm3Ffc3xBwTN42wQKSPqTn+zUksirlwjtsTAvEuYioSrXY072s6HvKoNCkf820t3F0s/dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGMCFtC0S4bjBMoxk4ezN2hD83gHqu3QeRrr/V4592C4Hu42U+
	WOBVACiK3WJgSY9lJ2Q0QWUoS6qlNBdow7ytij5czfBi2HaSCfNreCiFYCoTJfSQZYzAFoXnb1r
	sQ4fzIuefXa3Mbf15syP+FPD+9QulkdY=
X-Gm-Gg: ATEYQzyQpCbFP66eae3IMEvwxk29etNQWIwFIjysWneQWzyAOcBjuAjCiAprWklQBXz
	a0nVYYg3ybWdqIFZBUOaoWfmoIRRajsa3hG6Hd+aEj/wTB67qu6h2CWz7ML2+NCKPIR03qqnJyW
	w8XvbgvAHwKdTCgM15m4phgzXIcmk4d9S0NTVaA3aULVOuc/Yt2TPJ/Km9jUkQlcJa4JakDYosj
	Nvw4/D64+YN2RAe3k2vLwLeH6kVzl0xGmrTzH71JotHa9vaG2evfHyMrPEap7HyRehZkDS2Hc5f
	SrxVwFA=
X-Received: by 2002:a17:90b:1a8f:b0:359:7fe6:7e5 with SMTP id
 98e67ed59e1d1-35a0199ca96mr3799571a91.24.1773268675774; Wed, 11 Mar 2026
 15:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com> <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com>
In-Reply-To: <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 15:37:43 -0700
X-Gm-Features: AaiRm50vJaxcN-kF0b9evke2EZ18SvYUGjpaiaWXV923kNaZt8YtqIpRkaBWFlg
Message-ID: <CAEf4BzYTO9e-UAEd+W+ftqQZLUZCWHWXAYVnVjHeNtsZL1=Pdw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-266791-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5ACFF26AEFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 1:01=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Wed, Mar 11, 2026 at 12:44=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > The verifier should decide whether a dynptr argument is read-only
> > > based on if the type is "const struct bpf_dynptr *", not the type of
> > > the register passed to the kfunc. This currently does not cause issue=
s
> > > because existing kfuncs that mutate struct bpf_dynptr are constructor=
s
> > > (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs have
> > > additional check in process_dynptr_func() to make sure the stack slot
> > > does not contain initialized dynptr. Nonetheless, this should still b=
e
> > > fixed to avoid future issues when there is a non-constructor dynptr
> > > kfunc that can mutate dynptr. This is also a small step toward unifyi=
ng
> > > kfunc and helper handling in the verifier, where the first step is to
> > > generate kfunc prototype similar to bpf_func_proto before the main
> > > verification loop.
> > >
> > > We also need to correctly mark some kfunc arguments as "const struct
> > > bpf_dynptr *" to align with other kfuncs that take non-mutable dynptr
> > > argument and to not break their usage. Adding const qualifier does
> > > not break backward compatibility.
> > >
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  fs/verity/measure.c                            |  2 +-
> > >  include/linux/bpf.h                            |  8 ++++----
> > >  kernel/bpf/helpers.c                           | 10 +++++-----
> > >  kernel/bpf/verifier.c                          | 18 ++++++++++++++++=
+-
> > >  kernel/trace/bpf_trace.c                       | 18 +++++++++-------=
--
> > >  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
> > >  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
> > >  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
> > >  8 files changed, 43 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > > index 6a35623ebdf0..3840436e4510 100644
> > > --- a/fs/verity/measure.c
> > > +++ b/fs/verity/measure.c
> > > @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
> > >   *
> > >   * Return: 0 on success, a negative value on error.
> > >   */
> > > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bp=
f_dynptr *digest_p)
> > > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const str=
uct bpf_dynptr *digest_p)
> >
> > but kfunc is writing into digest_p, so that const is wrong?...
> >
> > >  {
> > >         struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynptr_ker=
n *)digest_p;
> > >         const struct inode *inode =3D file_inode(file);
> >
> > [...]
> >
> > > index 6eb6c82ed2ee..3d44896587ac 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const struct b=
pf_dynptr *p,
> > >   * Copies data from source dynptr to destination dynptr.
> > >   * Returns 0 on success; negative error, otherwise.
> > >   */
> > > -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 dst_=
off,
> > > -                               struct bpf_dynptr *src_ptr, u64 src_o=
ff, u64 size)
> > > +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u6=
4 dst_off,
> >
> > again, dst_ptr clearly is modifiable because we are copying data into i=
t.
> >
> > What am I missing, why is this logically correct?
> >
> > (I understand that from purely C type system POV this is fine, because
> > we don't modify bpf_dynptr struct itself on the stack, but bpf_dynptr
> > is a representation of some memory, and if we are modifying this
> > memory, then I think it should be not marked as const)
>
> The patch is just to first make the arg type determination independent
> from bpf_reg_state and make kfunc signature consistent based on what
> commit 52f37c4e0f11 (bpf: Rework process_dynptr_func) has laid out.
>
> Perhaps MEM_RDONLY is a bit misleading. In process_dynptr_func(), the
> flag means the dynptr struct on the stack is immutable. Currently,
> there is no way (and maybe no need?) to specify read-only dynptr.
>

are you basically trying to determine if CONST_DYNPTR_PTR is allowed or not=
?

> > > The verifier should decide whether a dynptr argument is read-only

can you please remind us what "read-only dynptr argument" means for verifie=
r?

> >
> > > +                               const struct bpf_dynptr *src_ptr, u64=
 src_off, u64 size)
> > >  {
> > >         struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *)dst=
_ptr;
> > >         struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *)src=
_ptr;
> >
> > [...]

