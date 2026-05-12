Return-Path: <netdev+bounces-287306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAJTKRiXA2pG7wEAu9opvQ
	(envelope-from <netdev+bounces-287306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:09:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B1C529F61
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49B71303CA59
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4CE3C1978;
	Tue, 12 May 2026 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJR6lpjj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97081D88B4
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620180; cv=none; b=bGjbmXaFMHzy0iLD8UWLU8Nvs1KCslHCltTmDcLukF63xEAlWgYLhCJJ2FIgCFgf//UG0kL99UWcsGFDjiaNVV69f2idMmr5npm1kgBe8qHF+5Wxl/qb50QJoB93WIDGrnx+o6rrMuWICFFZwDr87FYstArKpPMZEUaBol8WbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620180; c=relaxed/simple;
	bh=r5NfCaDR8XuBdLS5aQzoPlC0IDF+9iTlBaiLPWCz8/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UPlErFKwlbwdDdPydgUTMTT3myKi+in9TmFc4kcplAgthvRCjfRMG1Td9KWnJ7yKli4ViAubEtPVCc4mI+TYXAPR73c7Y0sADZ/F10M+faMH6cEeL9cjGHBKdjRCwfdA4/op+WgYO9SVFoNmUC1mWwvzVFNRLqGgLK7qfi+ZwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJR6lpjj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so2443965a12.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778620179; x=1779224979; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tldKA9Y19SPav5iRpI+W8dNtnr9IWxgUOCs/Hfp0DfE=;
        b=IJR6lpjjdyCKSQhGXJojJzAYSPFt+HZQp/mKQ768XaBBdWMP63J3KECcu8gv08iAYP
         LeZes9hImkVzJmXtzhtB6jv+cgO5YyDmG4e+1gRXux4F3phOrdZ3vkIk6aUq0KwBDMc6
         O0vPGaZB/QoB9eqaWIvhSuTaRiWNpjw8H65MyNa6AJ0WpYjlu8beZnQwwtdmu+kj8q/c
         Hv5sabYfyp8Yuqq0v5hMjZm2mWj+TUkDPib4gZN4QVADQFT2dq84oKrhtFdWt4o3jHum
         pPXirSu2bjdwP4SeDShgXbrvaPrqNqhq2Vve4OYqkN48RxKkHwhqBdoAQb6DBPHJqIXg
         9Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620179; x=1779224979;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tldKA9Y19SPav5iRpI+W8dNtnr9IWxgUOCs/Hfp0DfE=;
        b=QfVg/2Yy/0bHXfTaZI7ffN2X/lnC5dzX73GZ/JpSYy2SrJCe6NJ2Yeag2UIVbxBQVv
         Iu4i/zEpo2SQtraHFyijc6UMTwe8K513XwfXoP5jBAa+mpuTQVdUz6EUPSNTgXn8fKSP
         E+Pf5LOW03bUp7XmwOdTSqai4ppog36kqQAGRtA/L6nVjcAl/U6q/xH4BVlXpI3zy9gR
         +vxjefEz4P561viWBea0qKIHT9Vh+eROi3PN2c8Q1nK+UcXJQ/W4GVwdylSwZ14TIJXY
         wVeiqQxgODiKPaU3BsTbh9fnVc27HwolbGKHjxwkuSJjgGXBnKGuK9PpIMvp6ydjrz9h
         iKPA==
X-Forwarded-Encrypted: i=1; AFNElJ+lr6n6cF+h4yK4k2GRKimPDkiF+nY6QybxMgVxeYGPaYnwFQZ+yVIg3C3wvHOCV99FfBjuW2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQsPI0JoyWhef5+TazY+xabFXsmpfmIu7AJgB0GTI/CenMPxe0
	eYOYkRqZSc9xjg1mo4OCNVRnu/u/ytFBYhArSP2LEVkdXeHxAMo/Yh7m
X-Gm-Gg: Acq92OE64bUtZeRPgp4DVNhnFrRspZoPxyy4uk83jVF86lnQLlSZRp8DV0g4FJxxisj
	VYBhC9QK7Pu6AzY9icqI3b1MSCwWD8H0ivFXT6uPGbQEdRqxX2fbwNbtaS1HxVoJbhhg24HQTa3
	xOnjcDyebOKUqccE/Mc1SiWiugy7qZVCIp7eRHsTUf0grKWzxro1f00FgptK/Q86KIiVlvOVzjd
	pQcM2qiJvMBJzdz8aMCdIXLhiNTjTsMFfec5BhRTVaX4Qc48tcSEeBD0shfoA8ssCGUm5vcw2Z9
	axovFgToK25rweBuUNy7NJZ4QUppqGmMdbmjx4Dfwl4MqZZeZsB2Un8ig6TRN7Vp+iPh09300uu
	0ykHxNSOah+SkOjXVWaT6Git0WOUR2wYKuYQVTOMIbIbich/kWNbRdA+vhNsYfyrBUYsuE06b9B
	gx6cfKam7bwWAecEVEFntkFewy3NneNzsfDuP2n24FMMTZ5vlnDLQ2
X-Received: by 2002:a05:6a20:748f:b0:3a3:21db:8ee8 with SMTP id adf61e73a8af0-3af7fb6dd28mr311449637.1.1778620178922;
        Tue, 12 May 2026 14:09:38 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82675fb236sm13144528a12.0.2026.05.12.14.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:09:38 -0700 (PDT)
Message-ID: <701f9924ff6d13cf948c4ce4527eb866a26950e2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking
 in verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, 	andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, 	mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com
Date: Tue, 12 May 2026 14:09:02 -0700
In-Reply-To: <CAMB2axM8hR=OVqbkbTMJw_ej2pfnEm9Cm-quuoFPqsVhmJxO0g@mail.gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-8-ameryhung@gmail.com>
	 <23140ed4c48babfa8af91f3b67f379773bdc04c1.camel@gmail.com>
	 <CAMB2axM8hR=OVqbkbTMJw_ej2pfnEm9Cm-quuoFPqsVhmJxO0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 08B1C529F61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-287306-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 2026-05-12 at 22:37 +0200, Amery Hung wrote:
> On Tue, May 12, 2026 at 12:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
> >=20
> > LGTM, a nit below.
> >=20
> > [...]
> >=20
> > > @@ -8028,14 +8024,13 @@ static int check_func_arg(struct bpf_verifier=
_env *env, u32 arg,
> > >       }
> > >=20
> > >       if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_XCHG_D=
EST) {
> > > -             if (meta->ref_obj_id) {
> > > -                     verbose(env, "more than one arg with ref_obj_id=
 R%d %u %u",
> > > -                             regno, reg->ref_obj_id,
> > > -                             meta->ref_obj_id);
> > > +             if (meta->release_regno && meta->ref_obj.cnt) {
> > > +                     verbose(env, "more than one arg with ref_obj_id=
 %s %u %u",
> > > +                             reg_arg_name(env, argno), reg->ref_obj_=
id,
> > > +                             meta->ref_obj.ref_obj_id);
> >=20
> > I think this should be reported from update_ref_obj() itself,
> > it is more consistent logically and also avoids reporting code
> > duplication in check_kfunc_args() and check_kfunc_call().
> > Also, technically the reg_arg_name() is an independent fix.
>=20
> We have kfuncs that have more than one ref_obj. This is not a problem
> unless ref_obj is referenced in the verification and is ambiguous
> (e.g., used it to tie the lifetime of the allocated memory with
> ref_obj). Therefore, it is kept at the location of use instead of
> update_ref_obj() to prevent breaking existing kfuncs.

Ack, thank you for explaining.

> >=20
> > > Drop the selftest introduced in 7ec899ac90a2 (=E2=80=9Cselftests/bpf:=
 Negative
> > > test case for ref_obj_id in args=E2=80=9D) since the verifier no long=
er
> > > complains about ambiguous ref_obj if it is not used.
> >=20
> > On the other hand, if you think that this property is worth having,
> > then maybe wrap the check with in some utility function?
>=20
> A utility function like below makes sense if we fold ref_obj_id into
> id. It would be too cumbersome for v3 as we may need two of this for
> ref_obj->ref_obj_id and ref_obj->id.
>=20
> static int get_ref_obj_id()
> {
>         if (ref_obj->cnt > 1) {
>                 verifier_bug(env, "function expects only one
> referenced object but got %d\n", ref_obj->cnt);
>                 return -EFAULT;
>         }
>         return ref_obj->id;
> }

Maybe just like this:

  static void validate_ref_obj(struct ref_obj_desc *d) { ... }

?

