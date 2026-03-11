Return-Path: <netdev+bounces-266771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCi/Oc/NsWmQFQAAu9opvQ
	(envelope-from <netdev+bounces-266771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 21:17:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F177269D54
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 21:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7627330234E0
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA0038D008;
	Wed, 11 Mar 2026 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3pTjzrQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397238D002
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 20:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260233; cv=pass; b=mT5F5yLPS7ZVzXP/ao23Ad2Pf8bptmoVcEvL8OZQB5zFUKlXYVC5RpX/8fMad2vxw9Lh80yy4R+FImq44gONBP/jow0/ld68Y2bTcQk9Sn6FemYnwbLH5n3jhySXbhPbAgtQKTG/fAmXT4ajc0+4xNYmRqN409nXGcJcICqL/z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260233; c=relaxed/simple;
	bh=d1eyVS+Zp9IXBT7u0kM5sa61xIBMpLOIIWtclrSsC5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7CHS3FnekR+Pevsg2COjjBXKdIOTjfuhcYevnTVTtbg8ZMRKUIMJUl+CpH+54mwPzXT1JPYeqpB6crwHhU8PYQNmCK00Cdw9297tYG0myS3JxbFpD36grZuS0FyJHl5SBskjOTecsrsun3E0r544A5QiqjRZWJIw7MT24BJsDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3pTjzrQ; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79860421382so1908647b3.0
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 13:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773260230; cv=none;
        d=google.com; s=arc-20240605;
        b=MP/sbx6wmLOpwjTyqNTDXgYfTytdvfHCzJllOV50D0xcH0a5RPzW6zUcziP16WMcDh
         RybuoCTWBjdt4IDHLF4GdKXJn6OV6JZXfhSG4b6TnhBahFMaJVwwwg7mBS29kej8Cke5
         EeRQ68XDfVhGJ41ZLDtpY3IPgnH2H84p4RZ3yVwzbjME9HV/jbROs9Z7oyZPu5+WV8k0
         IVNas4f0Kbca3wB/oAqUbEIuN3FYZ0TFju4gBtiUG5FelMlJyIKOvODq99wwJzx073Az
         cSJ8pifs9eTkvc6fYrxVme//ypZ18c0pTHvOiXWyX7J7ojucq3PRjoThpKGmeG2uD+Iu
         NIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KzF+cwM8huPAZ1UgnF/5+z+9CVUtm6duOXzfOITv/a0=;
        fh=yGfRJNs7iphAM53QRjSmlbVcpwueRa4VqedSvVkXqg4=;
        b=cIHApeMPerhw6qJgGimDFyzvRPvYd6uqmBZeLfD8D+QTEX+a+s9gnXZIrkHw9edPQZ
         at5KaQ5o3i61sleI5DejHJznuJsDxx8vjhZLtan5IBPPY9wWkpe3781/2l2B7pwr6NU8
         dkSlsE/FXEiFHs7J94BUypnfbSUfeiJK5U0D6pKHtoGD5mQQJ9bzaSqHOkJI/q9MKo7/
         zq48Y8+S0nBlhWINSZ/Kpk3tJu2+aduRIgsnKBxs4cjG/vr2d9E4Awiy1dDpmvV8OUQ/
         hI1IY4wGSdaCrST484bf8UHpJqjHKsJf3z6hdq13tZEjaBZxeFlya25436pdwtSEZ2Su
         TAUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773260230; x=1773865030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzF+cwM8huPAZ1UgnF/5+z+9CVUtm6duOXzfOITv/a0=;
        b=M3pTjzrQlGKHQZ8aKgd+y+GOH37WmJgdPU+ML9s1KfZTXbvF2JLblL3bclDT01AONh
         pWDIqLxKY+LiMcxOI77DTck8XXKd/AumLItpVYTiPBWB3A6EfGguYfC0jAxvLeOQrF1z
         UsEuQjq7qocT11f5EnhJbJr3iGU/T9rjK9Ul3SgRgddndXWhHFBNOyrjMLoGPhu2PON2
         KZPn767KINYMLmz3dmtVllXfF5yp9M5myTzRW8UyrwNLDLmS8Hv4xRNdxoICtIM8Cguq
         Da7+KQ6CA32B2I7tIVjhCGSd4xFU2pSyjIHGSPF3kZKVwxdas3WTm68a2JqUW43fLdTC
         2kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773260230; x=1773865030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KzF+cwM8huPAZ1UgnF/5+z+9CVUtm6duOXzfOITv/a0=;
        b=aHKB9lnUV+idqQpOjsaJaAiepB4aPd+BYo7WUzPYtVfNR+QDxusTwyoijmxupvVaa8
         pLw3MRXr6mtluMkPnGvZMOZuojya1Pq4FA/EbXcTEd89sconB0lbMBjHKsM5GTGjXVYY
         9jFZ1mcN6inl3M/wCONC9ODSuOmDCSIpyy4nUCTTMdr+08xYvoGuixGZ0t7z2N6SwxiC
         izGrc7cXy5QLH7YNzkkkZx2A5hYiH288mPeMu4jhjOxdJ6uw0S8ZcQrMR0H9AxkieRlj
         RluOHAQQioVY9n7HJR444wioKwL1fD9vWcxwoHYR2zgU/HTjrorW16Vdq65hZJiU3JPw
         /e4A==
X-Forwarded-Encrypted: i=1; AJvYcCWBE0LtXgVm+oCRfUkSkb7pxCADshkXXz+4rYqYPEZvNdj5U6X5hTkbqOLL0AF5wOms0ZMS0hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoTbNwA1qts7X8T/j94Xk7GraHNMXFpqHAVBH/zGF4RkEwvLVt
	Y/cO6Bsmo0nXjS61ME3TNUFWDqXT6QActzzpXn6gC6QYgFPMIp9XHlr5eP/CndpPTmH6IEL5Fnm
	oWaC1s4V7YaxmCBRHQ+mcWzDmZY9C/yQpav/k6p8=
X-Gm-Gg: ATEYQzzxKw3H35/gzQZmUqDy0tBvzQvvOKGcr/RFgPusWImPlpFCA/WMnE63Ma+MkeI
	DK07z0gslgaR4dOKVuE3k7UVu4d6cJafaTF42SgY0aqhqU7d6gLYdxwAwLHG7KUcFCdYm6M8/IJ
	uJiexRB6iOJPIyMgv1iFDLpel9OuPkYulzgYIK7k2Uz4wD8II+kqnlrz7nIdA6RTOG8fin9hEZM
	xZZhKFXNIZFwPgj4DuWrHuTF1w5WCYVVlm1xgISPDlBZd7UzrKNm834e5tL3KZgJvL9Oz6rAFtv
	kS+wRx8=
X-Received: by 2002:a05:690c:e3c6:b0:798:78ea:f0c5 with SMTP id
 00721157ae682-79917e97d83mr38847737b3.13.1773260230066; Wed, 11 Mar 2026
 13:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-4-ameryhung@gmail.com>
 <CAEf4BzaRJ4hgMZY04=B0nnAE=MjyD4FN2L867vGCbornshOXDw@mail.gmail.com>
In-Reply-To: <CAEf4BzaRJ4hgMZY04=B0nnAE=MjyD4FN2L867vGCbornshOXDw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 13:16:58 -0700
X-Gm-Features: AaiRm50_1E906IE_5n6OlSDFA1nUlOC73HbmufmmtzwTEwEgDBcaxSIlMklfoMo
Message-ID: <CAMB2axPL07LZXAjy=FMBh2GeRkF0KQ81ixNFmX_+ZxZWm7nvSQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 03/11] bpf: Unify dynptr handling in the verifier
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266771-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5F177269D54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:57=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Simplify dynptr checking for helper and kfunc by unifying it. Remember
> > initialized dynptr in process_dynptr_func() so that we can easily
> > retrieve the information for verification later.
>
> it would help to call out why all those checks you are removing are
> not needed anymore

Mykyta also raised a similar question in another place. I will explain
in the commit msg if there are checks dropped in the next iteration.

>
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 179 +++++++++---------------------------------
> >  1 file changed, 36 insertions(+), 143 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 0f77c4c5b510..d52780962adb 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -277,8 +277,15 @@ struct bpf_map_desc {
> >         int uid;
> >  };
> >
> > +struct bpf_dynptr_desc {
> > +       enum bpf_dynptr_type type;
> > +       u32 id;
> > +       u32 ref_obj_id;
> > +};
> > +
> >  struct bpf_call_arg_meta {
> >         struct bpf_map_desc map;
> > +       struct bpf_dynptr_desc initialized_dynptr;
>
> nit: let's drop "initialized_" prefix? so verbose

Ack.

>
> [...]
>
> > @@ -511,11 +513,6 @@ static bool is_ptr_cast_function(enum bpf_func_id =
func_id)
> >                 func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
> >  }
> >
> > -static bool is_dynptr_ref_function(enum bpf_func_id func_id)
> > -{
> > -       return func_id =3D=3D BPF_FUNC_dynptr_data;
> > -}
> > -
> >  static bool is_sync_callback_calling_kfunc(u32 btf_id);
> >  static bool is_async_callback_calling_kfunc(u32 btf_id);
> >  static bool is_callback_calling_kfunc(u32 btf_id);
> > @@ -597,8 +594,6 @@ static bool helper_multiple_ref_obj_use(enum bpf_fu=
nc_id func_id,
> >                 ref_obj_uses++;
> >         if (is_acquire_function(func_id, map))
> >                 ref_obj_uses++;
> > -       if (is_dynptr_ref_function(func_id))
> > -               ref_obj_uses++;
>
> e.g., why this is fine? (because we don't use ref_obj_id for tracking
> dynptrs anymore, right? would be good to call this out in the commit
> message)

Thanks for the example.

>
> >
> >         return ref_obj_uses > 1;
> >  }
>
> [...]
>
> > @@ -13559,22 +13464,10 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_kfunc_call_
> >                                 }
> >                         }
> >
> > -                       ret =3D process_dynptr_func(env, regno, insn_id=
x, dynptr_arg_type, clone_ref_obj_id);
> > +                       ret =3D process_dynptr_func(env, regno, insn_id=
x, dynptr_arg_type, clone_ref_obj_id,
> > +                                                 &meta->initialized_dy=
nptr);
> >                         if (ret < 0)
> >                                 return ret;
> > -
> > -                       if (!(dynptr_arg_type & MEM_UNINIT)) {
>
> I can't fully connect MEM_UNINIT and CONST_PTR_TO_DYNPTR, this is
> something that should be called out in commit message, IMO

Will explain in the commit message that !(dynptr_arg_type &
MEM_UNINIT) means the argument expects an initialized dynptr.

>
> > -                               int id =3D dynptr_id(env, reg);
> > -
> > -                               if (id < 0) {
> > -                                       verifier_bug(env, "failed to ob=
tain dynptr id");
> > -                                       return id;
> > -                               }
> > -                               meta->initialized_dynptr.id =3D id;
> > -                               meta->initialized_dynptr.type =3D dynpt=
r_get_type(env, reg);
> > -                               meta->initialized_dynptr.ref_obj_id =3D=
 dynptr_ref_obj_id(env, reg);
> > -                       }
> > -
> >                         break;
> >                 }
> >                 case KF_ARG_PTR_TO_ITER:
> > --
> > 2.47.3
> >

