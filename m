Return-Path: <netdev+bounces-287326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG94CnObA2p27wEAu9opvQ
	(envelope-from <netdev+bounces-287326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:28:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 884D252A46F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60C1830215A8
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2E238236F;
	Tue, 12 May 2026 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM0MY0Ek"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE5F256C6C
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621296; cv=pass; b=kaSX7rygtjR09khXKNnjLbNs4uBNyQEPHue1nVe4XxWQa9+wlLs8HYFH1hNRA8XaNaSfd9e3h9kWm/XEo2gdrvAkXv53cRA6lnXFXkkj3OW0esl9peVrCSEUXhkyYDukbvBnCPw+JEFDz15zF/Ywx/6CIyXV4g+l9oxmsobcEGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621296; c=relaxed/simple;
	bh=21LBVV1P4gD2k+Z9sRRMdd4+WwOTsiU1kAa8YZ8YOyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjzE9lQ8dVj0DQWVkuEAYz0b7Q3S3LLOFOOqBioSbu6VjeCw4+BWgz+DnufRtUN/ugZeApiyWk+tIm6xktR7dNnluUNVkEdoatnnDqn2eefN14VBVLUpNsVNMmBDwV59QwGu56Xgs+FcEQE/m6+GbDdNGKPBA/Z0dvA8QDXV/N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TM0MY0Ek; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bf0b47d2f1so58142457b3.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:28:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778621294; cv=none;
        d=google.com; s=arc-20240605;
        b=NQHo3DrFBtb6vRnOCMdOhrdf03PTtHootn6aIu0UoLebp5SOFtgW90e9SY7EvIlxOX
         gzxRNZj81+ApZlpcpQ4ic0Mkv9QmcvO+jMsWPHpOSJDyX42l0mMhmOL3KxDhdYvHHSxu
         Vvpgz2bevUB3F2AWgMOBhbeXhOS123CRrA5ARBD5sHc3LKSOUMbfcBJufujdDg8naxq2
         wOXp8IZAxiniAwezFxg4sFOy3hNryOUQdB4yhYxPqNmtCeenshSsfJRFQ2YoKzqQEwQT
         E8tu1bO5CnPZIMUxXraUOpUjjlGvOyQlZc8Gr3na2gsfdHREFLOTwMg7QFnGY0MLtdWi
         XLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/XCRpqvCyWSh/CuUPSVyp2FYQA/PwDdIevbENX39xtY=;
        fh=k8pqAnGhLIuKWxBGASbuWw1JUugvZjpjT1nyzwFOEK8=;
        b=HkcyFBEeRStcCkflYO4CANoNJQB0c5UpNvrZTABcXBDYCAaWjGpD0blJq3i/6w53v2
         U9qfPJ9oRU07eXMhCGUII7qIyGfO3NEKx6BgbcTf+loYzC87DmmCzpAzBEKqEAJTyxx4
         yMEBrGtkW5b9jgVQZdUfWAqaypGjBacfx2FZQDvPl7wmY0UNi0AzoK9Lr9MR5HOdnUEH
         6k8DtzK08ZTZj/iNOJxh7bXTwfZxYlBfVke5Z2zZPIul7DMyIGXKQM+E+w22OGtXfEY5
         I9hywsSd8ij18HaWQoUhy+bQ739gPYzt8502r15CFjAwPP3X9pkYcjT4Iw6nJBt6QP3R
         3cgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778621294; x=1779226094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XCRpqvCyWSh/CuUPSVyp2FYQA/PwDdIevbENX39xtY=;
        b=TM0MY0EkOWUjg0nQbdQUA6BvLONiWyUDro7GKUozwyligN+WXJHtpnvv6tZagDfnRP
         JeOS1fgZDyg+SahMWs0FDIuwuKn2qxO9oMAvQeVdADRF7TXPCeRb7BzWWIevxLy8TAAD
         HtQjiXNQOy5j34xws6i3gvIQ0DmuEoa7/THs0aXhCY2q7VuFHbw4mD3yO4jGiPm/g3hB
         UnHuBFSh1X3cQTeZemtHXa31jaFHAmVhg3smb9asDXAUKyZINCix88+7hRj1T5K3e6t8
         9H6JQJjK9ySAyChOgHT86mRRT/YiYyfA41m3GJ7GoW7p2uDU4TxlCwuYDF2R7EZEgOBZ
         uZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621294; x=1779226094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/XCRpqvCyWSh/CuUPSVyp2FYQA/PwDdIevbENX39xtY=;
        b=k0XjaDq5bIhwt+HL73iukyPIiAtrhNPbvKnczian2/h++drvEKhW6YwJ3ujEIDHzEB
         s/Fzx28zgN5OpPMbNrA77f4mvGgA5sNKJNaerXS3mQSZGZAm1DpVk2n0STqwVNyD/yN7
         ql7ZJaJpEw3KXgXxExYxxt2xVaqA8kbGpABWNMFWdQOZvOWZUlW4N2h0D97U7WshFO+r
         JSPqxFvMeGut8GTyjcNxXZBbaZx0vNo0/kO+AaGaeI04t3Dd59KaPr3l1LVZfUyQXxOx
         XmhzvDNZize5V+bzaWmXibh1wAI+egYUMbfXdjXqyZ2w9NhAY942JHpep/brKOkHtyYs
         Yv2g==
X-Forwarded-Encrypted: i=1; AFNElJ/+H2599VYAIAhs3wypwDkQrJWg/AZQBsfrRKnXehwpSHoCQfrT/LelQYgLO9UqFYefpx1ygDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRxLVqx7hLMSi8RyWsMBk+CYPlN5InYQ9VKoTl4LJUjW4HiSRL
	K1YW/+vsLBfMALTMrrbUOM//ghFwo0ro3JhU/+KQ06BuzJwUhvzso8V3CfPrd0/B+l5Yj63UdKE
	MMuZ4rce+cMQrwxFMItdZvhecqWYaMVw=
X-Gm-Gg: Acq92OHbDbxWxtcmy0fdVWhhG90rwV204UiMopK/Ya2ndlBDXLl/namRE5rMeeR+/k9
	nbg6jMBUZS2r/M1/5F2FfKkDIIsGNOPcKDjOHOiZJxol3SPDzGmWnxAkdtQghT+cs8Z7L9X/+MD
	M4fWjughj4vzUTV+z/Ir/9Qr+lZEOoRsP99202DxTitW4sJFbXBtsB6zTYVP+GVRJtjyUCZxU5R
	LKcGRxxf6icRDXMNc/trJ44sMZEU6mY/0/+Sy1QuQESdKK/BayypqXeKp8h5WbMb3o6rTj/6ZLw
	10Z15u6UnVKUAB2ebW8mlUk=
X-Received: by 2002:a05:690c:ec9:b0:7b2:7dc9:360e with SMTP id
 00721157ae682-7c6a64272cfmr7436117b3.0.1778621294144; Tue, 12 May 2026
 14:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-1-ameryhung@gmail.com> <20260506142709.2298255-8-ameryhung@gmail.com>
 <23140ed4c48babfa8af91f3b67f379773bdc04c1.camel@gmail.com>
 <CAMB2axM8hR=OVqbkbTMJw_ej2pfnEm9Cm-quuoFPqsVhmJxO0g@mail.gmail.com> <701f9924ff6d13cf948c4ce4527eb866a26950e2.camel@gmail.com>
In-Reply-To: <701f9924ff6d13cf948c4ce4527eb866a26950e2.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 12 May 2026 23:27:59 +0200
X-Gm-Features: AVHnY4I8zXbLo124_0hoTCIR87mCYE_vVz86xXIvUSAf6JMnpPU94tv_fvbGDbQ
Message-ID: <CAMB2axOsnVj=PBuMU8utqKsSj7DsVhWNi9Vddytx6BKfFGs0JQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking
 in verifier
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 884D252A46F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287326-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 2:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-05-12 at 22:37 +0200, Amery Hung wrote:
> > On Tue, May 12, 2026 at 12:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
> > >
> > > LGTM, a nit below.
> > >
> > > [...]
> > >
> > > > @@ -8028,14 +8024,13 @@ static int check_func_arg(struct bpf_verifi=
er_env *env, u32 arg,
> > > >       }
> > > >
> > > >       if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_XCHG=
_DEST) {
> > > > -             if (meta->ref_obj_id) {
> > > > -                     verbose(env, "more than one arg with ref_obj_=
id R%d %u %u",
> > > > -                             regno, reg->ref_obj_id,
> > > > -                             meta->ref_obj_id);
> > > > +             if (meta->release_regno && meta->ref_obj.cnt) {
> > > > +                     verbose(env, "more than one arg with ref_obj_=
id %s %u %u",
> > > > +                             reg_arg_name(env, argno), reg->ref_ob=
j_id,
> > > > +                             meta->ref_obj.ref_obj_id);
> > >
> > > I think this should be reported from update_ref_obj() itself,
> > > it is more consistent logically and also avoids reporting code
> > > duplication in check_kfunc_args() and check_kfunc_call().
> > > Also, technically the reg_arg_name() is an independent fix.
> >
> > We have kfuncs that have more than one ref_obj. This is not a problem
> > unless ref_obj is referenced in the verification and is ambiguous
> > (e.g., used it to tie the lifetime of the allocated memory with
> > ref_obj). Therefore, it is kept at the location of use instead of
> > update_ref_obj() to prevent breaking existing kfuncs.
>
> Ack, thank you for explaining.
>
> > >
> > > > Drop the selftest introduced in 7ec899ac90a2 (=E2=80=9Cselftests/bp=
f: Negative
> > > > test case for ref_obj_id in args=E2=80=9D) since the verifier no lo=
nger
> > > > complains about ambiguous ref_obj if it is not used.
> > >
> > > On the other hand, if you think that this property is worth having,
> > > then maybe wrap the check with in some utility function?
> >
> > A utility function like below makes sense if we fold ref_obj_id into
> > id. It would be too cumbersome for v3 as we may need two of this for
> > ref_obj->ref_obj_id and ref_obj->id.
> >
> > static int get_ref_obj_id()
> > {
> >         if (ref_obj->cnt > 1) {
> >                 verifier_bug(env, "function expects only one
> > referenced object but got %d\n", ref_obj->cnt);
> >                 return -EFAULT;
> >         }
> >         return ref_obj->id;
> > }
>
> Maybe just like this:
>
>   static void validate_ref_obj(struct ref_obj_desc *d) { ... }
>

Do you mean:
static int validate_ref_obj(struct ref_obj_desc *d) { ... }

Then to use it:
err =3D validate_ref_obj(meta.ref_obj);
if (err)
        return err;

regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj.ref_obj_id;

> ?

