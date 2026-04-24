Return-Path: <netdev+bounces-280894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLhHCY2z6mnACgAAu9opvQ
	(envelope-from <netdev+bounces-280894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:04:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCD74587C2
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AC0B300B44F
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E751A625;
	Fri, 24 Apr 2026 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TErWXGdo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22FE1A275
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776989066; cv=pass; b=AVebHYTgwfwmHSozyotUjLpef92LXQYrBCiJt+/EsQZ/ExvdRCwTHm60s5u9X5X6IKcQJQ5Xc++9vRCyyZeAZR2fUlRhpj/LS4vw9zW15eW2oqS1KpaqVGqoo0x00hBPGBMUkPPKEYoRitco4Ox/TAO9zm4sSw6uOmPYVyIZCok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776989066; c=relaxed/simple;
	bh=vTzzIgE2JS6IRMC6snTrIYVwAiDYQSSsSpWSe0DCrmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7F2IBApRtSkTg1Pw2ceSqtY/GbD/YSQfzwkRl//kdqxUbE28y7TYaA5c4lf+0XGUSFmBqR+cMZCGWdup1S8FtE/l1N5neAspD3bgbVzdFF06YeTsCGFf50ED0DyOKaZSSV+7jPG+qMGJFRqGHj2IlwEISXdcefljSkv2NjKH0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TErWXGdo; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad9a9be502so45492605ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 17:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776989065; cv=none;
        d=google.com; s=arc-20240605;
        b=YZh/snuzRojA5BgnCr/oMJiFlfMlctV71eQZHLAHmv3n2kGcaCtUhmCpjuIPpQ9YuG
         Fj5RSpSnbb+PCA1jykm6NoYGfuxjcoFrggaMmel579ds5ooxSNsa+G47T+fVndn3FRGU
         +xC+R3zhSUGCtUKC73aTx2yjcUXhMrKw3r53MNIhJ0gk9duIoc2vQ40ZqKF9E8QiZW8x
         o6BnpQmW+4S0FZuuV1l2ZFuziuw6Ate9GnLELcq9wxSS1cjBKHPViAEG+wUsg5XT0N/F
         h/MBAmpXoEfv28/7kBG+FLoEpAbzuiPQMlYrtWJ2/IvWk1v9XW/HxDvcMVv9WH8nft8e
         kKrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KTZwoGKCRXn3NUS7spmMnD55V+Zr0LB1j5fzzvDTNr4=;
        fh=Jqj1RmQdzAJPrQASOVwhR1NFa9JiGY9NM7opj4jBpzw=;
        b=lN6R9II3vqJwJ5EJKIhWKk+syvn6bJbnzzLvhhITmeAw6/8WrWQrK8j7MbVHHu+0kX
         vWRLBOjE3AZgdfof6xeOMPKwtHKfQfRtLrBKJj5bE2vs1BVJoq3O4XGLKG8MLtiIZSJq
         hDuTKfPBGy95YTxIcrQSM1T9DS1pYdp7AqCg0c6+HpNugjqoUuzZhcbTLD+b67DzJ6mm
         qDd331PbMdkKqUK0JXaXjlzANu1Q9gwEzBM9UnnQvo51sXhe+Wlzvn3bQ5spVplfQvBa
         4GkjtVfsNlSbtuYTYM6gfNQwGfVEhsmf1mCjdVrUDSLgEaFlAxxN++0eTVcoORq7OXxF
         tmuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776989065; x=1777593865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTZwoGKCRXn3NUS7spmMnD55V+Zr0LB1j5fzzvDTNr4=;
        b=TErWXGdoy1oZ4eoTvshWpEZmUnr6hQF/8rxdzwEmBn020aOKP0gQLUNjC8zjmR+6XV
         u4la2d5f3OuE7zQVwbPRDEERan2P+V1l/r8R92fn/iD3FroVuOYxqEhG04MFdp3H1+Mf
         XGJ7dD+bOonV5B91mGCqmma/YgXQvLOgGvi3zNRpo1uHQmtmjLtlEOn0Qo+LAN3J0Vpq
         Ycm2RHE4q8SdLv5UH65l/ulqRVvMDsinPH8JGMwXO6XBsxqeKzCJ4UcniBv6i0ZjBxAN
         sGwzttqqaY/shgvQ8fRuBJnadgdRpnQY1gnq+V/YUHk8GFUKdoA8iWOfgzpX5R28BeHo
         sepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776989065; x=1777593865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KTZwoGKCRXn3NUS7spmMnD55V+Zr0LB1j5fzzvDTNr4=;
        b=qnP7FsZmBaOFxrwXKMHcQdCsIbI/zhTKF1xG6Et+kIgT3WzqLol/F2REN3r6cM/m+X
         qOxDKJu8gRuWkKTL+PiPH1VKhNyp/mHU2hoH/dVJ19YbtYb0SFQ+BU8aYOoXVxdkrzId
         4WK/+nFG2fig+Q11DqPUWNoLM5KSIUBvplKiZgJpICRgtzQMg7TIogRrFV20h4ir3cnX
         csYD8W8ngr//nl08AM5R/3bQCMMeEjwhJi/cfxBoUTK4tKpGUUzn0hS46TpyA1y86nTo
         IbnFrf1/0QorTeQQNT4jtpCHCT4u4cE1I8RmrjCwTZDXHEZBo4SbrNCO00qHLABWJUs+
         CG3Q==
X-Forwarded-Encrypted: i=1; AFNElJ98FG5yYbFzTr7F/bXGq83ZQ5unsZedVWP2nKlrpKLMWqAm83OmvHs61oklGWdmVxS6IbXdKeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhX9fr7UWk8JazAF4Hp9GQRNh5+Rw5yMB28d3SmqlvFh5SY06S
	iBmX7EyFSQjrvGENduN3H1vMud+4L2zaA9Tbf3eaw0xik6YasYLFz12xyL/IHbf0ORMm0kcAEfV
	Q8EqGmf8DAY8KfKnugx/tSYIYMYZd/0Q=
X-Gm-Gg: AeBDiesa2CJzLtKpUqE4esJJ8x4MgZnEBBDrwa1ptS4acpXJ5OQmKlbgR9PuYhTuoQE
	SQd8GCwAeuhgSZl9bnlE9w1VZgMq64/ig1/W0pttnDDHO6TBkTxZ8WyXx6vVRS74SJlNVlS3IZO
	FUL4C8q59GN5CWQxEOe2tbHu5aDl7HxWzW91n2IakFWq1I+HFh4HahGXCG1cVVDxlCXGTzUm1fs
	4DqnHRUxtZDMwxh1Av086Ot4cKxEizl+SPdXxVhV+kfIP7yYeOZ823PMhi4Mhzs2qNMXSfrRwiu
	Yp6BPFX0jNIUOY0ljAPPqeKor8Pl0nmAaQ==
X-Received: by 2002:a17:903:38c4:b0:2b4:5f69:715d with SMTP id
 d9443c01a7336-2b5f9f36ea9mr350053565ad.25.1776989065079; Thu, 23 Apr 2026
 17:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-2-ameryhung@gmail.com>
In-Reply-To: <20260421221016.2967924-2-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Apr 2026 17:04:09 -0700
X-Gm-Features: AQROBzB8_Arenp3456-5JT05sOdeqNAovNdxghwId6kPXP5l_pUoFbmC8Km46ic
Message-ID: <CAEf4BzZGg1EKwYFG6QKrkNbiE6RwWKew_Zz8mz9rjshKjWzcKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Unify dynptr handling in the verifier
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BCCD74587C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280894-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Simplify dynptr checking for helper and kfunc by unifying it. Remember
> the initialized dynptr (i.e.,g !(arg_type |=3D MEM_UNINIT)) pass to a
> dynptr kfunc during process_dynptr_func() so that we can easily
> retrieve the information for verification later. By saving it in
> meta->dynptr, there is no need to call dynptr helpers such as
> dynptr_id(), dynptr_ref_obj_id() and dynptr_type() in check_func_arg().
>
> Remove and open code the helpers in process_dynptr_func() when
> saving id, ref_obj_id, and type. It is okay to drop spi < 0 check as
> is_dynptr_reg_valid_init() has made sure the dynptr is valid.
>
> Besides, since dynptr ref_obj_id information is now pass around in
> meta->bpf_dynptr_desc, drop the check in helper_multiple_ref_obj_use.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  12 ++-
>  kernel/bpf/verifier.c        | 178 +++++++----------------------------
>  2 files changed, 41 insertions(+), 149 deletions(-)
>

[...]

> @@ -7433,7 +7426,8 @@ static int process_kptr_func(struct bpf_verifier_en=
v *env, int regno,
>   * and checked dynamically during runtime.
>   */
>  static int process_dynptr_func(struct bpf_verifier_env *env, int regno, =
int insn_idx,
> -                              enum bpf_arg_type arg_type, int clone_ref_=
obj_id)
> +                              enum bpf_arg_type arg_type, int clone_ref_=
obj_id,
> +                              struct bpf_dynptr_desc *dynptr)
>  {
>         struct bpf_reg_state *reg =3D reg_state(env, regno);
>         int err;
> @@ -7499,6 +7493,20 @@ static int process_dynptr_func(struct bpf_verifier=
_env *env, int regno, int insn
>                 }
>
>                 err =3D mark_dynptr_read(env, reg);

if mark_dynptr_read() fails, should we exit instead of proceeding to
fill out dynptr info?.. even if mark_dynptr_read() cannot fail because
of is_dynptr_reg_valid_init(), it still looks wrong and error-prone

> +
> +               if (dynptr) {
> +                       struct bpf_func_state *state =3D bpf_func(env, re=
g);
> +                       int spi;
> +
> +                       if (reg->type !=3D CONST_PTR_TO_DYNPTR) {
> +                               spi =3D dynptr_get_spi(env, reg);
> +                               reg =3D &state->stack[spi].spilled_ptr;
> +                       }
> +
> +                       dynptr->id =3D reg->id;
> +                       dynptr->type =3D reg->dynptr.type;
> +                       dynptr->ref_obj_id =3D reg->ref_obj_id;
> +               }
>         }
>         return err;
>  }

[...]

