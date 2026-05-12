Return-Path: <netdev+bounces-287325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ3vOqmbA2p27wEAu9opvQ
	(envelope-from <netdev+bounces-287325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:29:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5243152A4BA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 653BF300DDFE
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B6C38236F;
	Tue, 12 May 2026 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDfes/kB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2B138229A
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621178; cv=none; b=YfNhMDxMt3V8Im8zxGPhx6Z2cNw+2EwOkErETbSj9YcL4WBvOBWRHfYiVVsAjXQO0keTClQLytgDKxasHFIGrp+YXvdFRABuzq4fnowEZwZOaLmoMcFpadnOGkegnJ/+pk2Cxk+4OeIAV3FkYRUW37El6ZvuBy5avy7wCaKIK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621178; c=relaxed/simple;
	bh=0NnGB74299b/skLTU67JZ1C13Xu21n9gXPYZYo5UcjI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RWdyGwpNwd9Ft9zTRdnVQU4znF9CaLBXsirZ9enz6cLYVrEWgQWcUq+l3GYhClMWehMSuXC9RgOO9RVLYVk3TFWcFU1rIrIg4wDBUmFaCUW2Zq/hN6sEwOYQCKKjdnGVPds3G3/Oas7kSy7ykbndHuI4XCalavfjEZHMg54V4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDfes/kB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-366070f71adso5416692a91.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778621176; x=1779225976; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=igrrJH3+RzgjjQHoddHP3/cpPqYFpMoTRiqFmA0zyY0=;
        b=FDfes/kB8FiJjFegMR1fDNGQ0dTk2sz0L4vl3wiDPVgyJ+jPDMo+fItXulNHft//zQ
         UUa3x/ayRasmeGPabPGqhaOunZaYgOGpZsLKgjg7J8D4xEkqfOR46HFKvo+ALaCEqJ0I
         pof90RHSeWpbdPRmPAmZKhC8aG1p4zKfpJRCHhoWI04gfhXiTZIqthHwgmz06tgcg/2x
         w6jt5YQ+Qvyls/Mj5xaB8WbNoX59b6PH/fhaqqLfyL8cH5JMDPZmjtWUtLrEtB7ZQUx1
         8CHqUcDeXp5TZ1D3rR5N403frBC//DPKRPU68B4bmZsl88Tlq0pGSt6S/n32JisUKMVT
         ZcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621176; x=1779225976;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igrrJH3+RzgjjQHoddHP3/cpPqYFpMoTRiqFmA0zyY0=;
        b=ZdHHJRlcGyDD3ZdRGQpbxOhnjeT1BIYEXr9l8wUAzX7QPFguukRa13w+xzbYKabUp6
         Gf9Y9nnA4EBQYCqxTvZLKQl7k6uI1hk34jTdwPWOOySmCbbthojhLjM5pyxC9PXo7T9q
         8Zw95NCuBIXVFUu/A2wJCWOXrNVu5sNMGbAeb7fjkx0jTgwjk3y8MWHq6PU0n0pFGUIY
         YoLGGZjmospmxp0O/CNG2EasWEbtAHNaD8uuGOQa2+3ymJ8w0UIXP1HPTXsXyKsA7JMF
         ZQ+N43BDdtez8z+IJBFIlfhjaxchyorZPwIFtcTGAmH+ld8yFVQHccxFxfWLYDcZqNpq
         uXUg==
X-Forwarded-Encrypted: i=1; AFNElJ+eZwhe2TKrdhIwifxv9sBjLt3qq0wl2N1DTGJSM3q41+SmKs5NaG8VvSw0JhlyYjIneEhFp20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcb5OdRQOV9XAEJistD4+figjW7Jj5euYpuM4sM8v5LbL75hVw
	+HO4KXA/JhIh0Hb7o0byTKMLEGWKTiMswOg/fE1jYYvxabkpDXZQBh5+
X-Gm-Gg: Acq92OEJddg846Bq0Wm5peTInGB6sBY+sOSDERmOjnCil7rc0ijIcmhpjetyFpefkIM
	WrZI1HsGAIZW0vvG0qEhORL/aKm8Ln99Oz8Wl+4PwHSm0QRV32zip+wRUm4jkHlYoXMY9Rmb1D7
	Wkm8aeBTn3Qn86zopGBrCfAou9PFudcJDmMjsIa3ZoSK0P5x2hhoDsuZaluFZjjfJxLWMt6waay
	66lQUVkbBlzk1XKUOYSgpBLtiReUDoVynA2SiuXWdD2YA1W+h4LkobX78Wn3wbEf2tZFkHFlfpt
	fA9FsEW2KAIvNwqtOnHJTHlFpaK+Gua1nYrtIsqRP1kfJpvEZYYXSktFY32rkaqj9aH+nevmx2T
	2SRx+kfPefly1EZKFflrQoQdbXAW/qlqOzcHXR9/FPeb84S1sR+e04Zrjqck+pEf0TFeegw7Grb
	2sgEs+DhQsnYDnQzOpbwhS658stEwPqK5DE9cxTN24fVSHDUMlQE5z
X-Received: by 2002:a17:90b:4a11:b0:368:af5c:5925 with SMTP id 98e67ed59e1d1-368f79ce5b0mr39976a91.23.1778621176192;
        Tue, 12 May 2026 14:26:16 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ad853a86sm1629622a91.6.2026.05.12.14.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:26:15 -0700 (PDT)
Message-ID: <9f6923ed86fcaf228000f7a83ace638ae523161e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 08/12] bpf: Unify release handling for
 helpers and kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, 	andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, 	mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com
Date: Tue, 12 May 2026 14:25:41 -0700
In-Reply-To: <CAMB2axO3pL5uCLL-=Ov7Nnyf7_=8tL+j0vUNHRV=Z8EFg66hyQ@mail.gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-9-ameryhung@gmail.com>
	 <cfdb2d4af893d70bcb15bcc22d6467f800b7291f.camel@gmail.com>
	 <CAMB2axO3pL5uCLL-=Ov7Nnyf7_=8tL+j0vUNHRV=Z8EFg66hyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5243152A4BA
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
	TAGGED_FROM(0.00)[bounces-287325-lists,netdev=lfdr.de];
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

On Tue, 2026-05-12 at 23:22 +0200, Amery Hung wrote:

[...]

> > > @@ -9870,37 +9928,11 @@ static int check_helper_call(struct bpf_verif=
ier_env *env, struct bpf_insn *insn
> > >       }
> > >=20
> > >       if (meta.release_regno) {
> > > -             err =3D -EINVAL;
> > > -             if (arg_type_is_dynptr(fn->arg_type[meta.release_regno =
- BPF_REG_1])) {
> > > -                     err =3D unmark_stack_slots_dynptr(env, &regs[me=
ta.release_regno]);
> > > -             } else if (func_id =3D=3D BPF_FUNC_kptr_xchg && meta.re=
f_obj.ref_obj_id) {
> > > -                     u32 ref_obj_id =3D meta.ref_obj.ref_obj_id;
> > > -                     bool in_rcu =3D in_rcu_cs(env);
> > > -                     struct bpf_func_state *state;
> > > -                     struct bpf_reg_state *reg;
> > > -
> > > -                     err =3D release_reference_nomark(env->cur_state=
, ref_obj_id);
> > > -                     if (!err) {
> > > -                             bpf_for_each_reg_in_vstate(env->cur_sta=
te, state, reg, ({
> > > -                                     if (reg->ref_obj_id =3D=3D ref_=
obj_id) {
> > > -                                             if (in_rcu && (reg->typ=
e & MEM_ALLOC) && (reg->type & MEM_PERCPU)) {
> > > -                                                     reg->ref_obj_id=
 =3D 0;
> > > -                                                     reg->type &=3D =
~MEM_ALLOC;
> > > -                                                     reg->type |=3D =
MEM_RCU;
> > > -                                             } else {
> > > -                                                     mark_reg_invali=
d(env, reg);
> >=20
> > Note: release_reg() does not have this 'else' path, but it seem to be n=
ot a problem,
> >       assuming that MEM_ALLOC | MEM_PERCPU registers are generated only=
 from some
> >       other cmp_xchg call. Is that the case?
>=20
> AFAIK, percpu allocated objects (i.e., MEM_ALLOC | MEM_PERCPU
> registers) only come from bpf_kptr_xchg() and bpf_percpu_obj_new(). We
> don't have a mechanism to derive registers from percpu allocated
> objects such that we need to mark_reg_invalid when calling
> bpf_kptr_xchg().
>=20
> If there is such case in the future, maybe we can do the following in
> release_reg() then
>=20
>         if (convert_rcu)
>                 err =3D ref_convert_alloc_rcu_protected(env, reg->ref_obj=
_id);
>=20
>         if (release_dynptr)
>                 err =3D unmark_stack_slots_dynptr(env, reg);
>         else if (reg->ref_obj_id)
>                 err =3D release_reference(env, reg->ref_obj_id);
>         else if (bpf_register_is_null(reg))
>                 err =3D 0;

Thank you for explaining, in such case I think the code is good as it is.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

