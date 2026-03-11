Return-Path: <netdev+bounces-266768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMGFCl3JsWnvFAAAu9opvQ
	(envelope-from <netdev+bounces-266768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:58:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9476A269BB0
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D3FE30078A4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FC8336ED1;
	Wed, 11 Mar 2026 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSpqNGqY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B102DEA62
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773259055; cv=pass; b=scnRrT2W5SjOPbdwiDlfgd5XkwEtFnW3RQLD+0jxuATXCKsEEo7vSuYeEW/cvuZdYiehTQIRv3H3mhkTfwiIdLtiSbBXlk+gqcOxyIKrmnGNNs4Wxma7rP7CpSe13UnMHC5HeEU9p0Z8dViPZ6rZJpX5MYkdd5WG3DMBwiPSexs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773259055; c=relaxed/simple;
	bh=VxAHg9nrQcdrhsCmwfwi8cNr43nanoGoDRe2zhAByuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXOetjvVBO6qwfsZMsM58FHqQzMKumQkZ3tRkE7DzIZA8rc7yd2PCYU8PpVREcfzj07t97zaQ+9ohLWN19RefEBNRPmEf/ItmdxoTi8aEQpZXL+LJQRT4RnrJuHzQ2GeZxtU2HJfyMPF0V76x131SA2YaMlFLfSp81VeMWkfXGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSpqNGqY; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35a094cc3e9so129919a91.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773259053; cv=none;
        d=google.com; s=arc-20240605;
        b=SNJ1Di7D7qsuwJ+dEZ5MxSuqg/lCS2GwnquqkAUIwMSVaKj4eEhqwBrxW5qaBzsY/6
         D1gaf3g6C0Y5Wp5xl/nvtig7fuolWgJEQwXm1nDFWRBxSiH6VW6RjSMOLXKA/43o32nw
         Yp+KerqIf50IKPdLRQGUbhdu5HGMCmL2YPDugxL4uPhPVPCzQ80eUUhSqBVXpN7qST+d
         Lgsid7X85qdRGDCgdEZRsTocqQRd27KdJqB4ftRG+8A855o/pcR0u73frjjn/ky/1M3u
         Hi/07y9tw2Ekh+tT+Rf9ywgiMy4uo8TOYxmTmgeZVm+za4ktO7TP15gO2Jcr+/FYLoS+
         /lug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oRgmDejJFWe/QqryxfaYjr8wy+YiV6XFgquy3LZyckg=;
        fh=ous5vfhtdc0obmNXcX5fm0wk0ntIySiSd+3gWa9SDUI=;
        b=Rz7vQVs4mfIF/RhPAAwv4MA/6W3cQVVhcXxBlNLGHaPNCwEpNonyK+eO3DTxjh6N7I
         Zcnykq41BsHW3woFmdfcne8A5QsaTofTYDWacNdeCnThFbNHBnoHmxLQgJck5nh99d94
         h1lNd5pQFm3Y3yhKVa6xUSRDa/ErKx2X/KonM9BxB8pNZE4flGtbMlg1eiTsSGl/eVkW
         Da/0f4dkvXBiEnL+V1QIBxHwyDqfSPY3kmqfCxgh2FCbRoI6TyWO6UAtF48lZPzrcXtT
         gB0mQCWwUEkCkF2kmerY+pv4vS8v1p1sgb2I6q2q26b8NVEBvCl9qsUYBkf1NB7DObYr
         BL8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773259053; x=1773863853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRgmDejJFWe/QqryxfaYjr8wy+YiV6XFgquy3LZyckg=;
        b=FSpqNGqYpZqoNQm1VgY+xFcS25k7FBfcFOFYB4TU1zuZ3pe7a/ln/eqmSGAgTHAE+L
         BPm4kBmqGcHiPLI8UubX7sWeJjLKL9Z3RrGOrCOU5TKJD0nusybE/84s8dfOI8Sc50BK
         gITTPf2BneCfBA2+wYGgWPp6H8Udl33hPOTg9WdnaB96L5zFXwTfkpcMq3UK8kB00TrO
         s/SW5rsTYFzNuyK9kj0UyqUzAcnXGqvIIRXLIBS1X/f5QnLKH02Ne1ejtJ/2iElMjQn6
         TN73kUEhbqgBo0Qa+6trYkZXvdxt7uSc6HcJQrzkERECzCm7nsx837bnK2A0ShZPrU9n
         wZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773259053; x=1773863853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oRgmDejJFWe/QqryxfaYjr8wy+YiV6XFgquy3LZyckg=;
        b=qU7ejGttIhLPqHJaK0wXtYIxZdLD5+4+/9wG+ZOs986bhiLt8+1q3bfUK8NjQMQhav
         bjwpGaohaOrYgvrZA2szhNRxlxs0tLOs6HlvHqON/Q5Q2+xdVfBrr0aXd331hsR+k1xI
         ObSZZ7q2yhSAaRZMPycNVXWBQjopSp7k9jDfaD2v5Sifi6Z61qtBWUEW2U0/nCcKFmON
         LlHwyhofLxkqwSEeUm17LQSGlyXCH2Mew0lC0kFmRIvhQZm70j6fcsAGWtgdnaVHMcJo
         craDaYuJ24beAoaPxbsD5DzDNVYyHATWd7Pb8nL5t5mb+GikZkvS3Ljnz4iEm1pkAARr
         jKPw==
X-Forwarded-Encrypted: i=1; AJvYcCVvMUoYpENxu5L3u6pBBKby8O0PBWFzX9lgXOOEF2EcorJ4jaL9dYMI8Y+88W2lo92YFiyNTA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy00/6EFE3eVxekVXU57SocXn48mn/r2UOtJYfQyeGsnyd2o3VO
	QA5w9ZgmXEWh7+d4N2x7EdYXvvy3+KJZLjJ2zb6zAkkH6IivPSHl88YziPH0fwY468fxRrcxOGt
	qWzKMJbt9EqFTcKC/G3VpAtVlx0O5PHA=
X-Gm-Gg: ATEYQzzLl/Co/lPhwqK+Jjs+VBck88e01OcLCymxpmqrt+fdMFSuJyELJxOSyO368Iz
	+Ht2s9oe3G3HgMPBY6Gz7Hb/iEevqNXYX2eA3S34PLCmVFVo2tS3s8Un9RCIc1hYNG2P3pshDuc
	XJHQO/OEjjpM4E1jnsd1dupphIfzDhnz5o/S3lDIHPXBNc+u03r2dba8ajr64uhimr4MK0RU3WV
	PTmdb43coUYyKrb6J+d8gJiE6WBiU68M7HjBR6SXn3+pPLuGOIKPCe789lhCICxEW6Lkr8OiCHx
	JMMtCHE=
X-Received: by 2002:a17:90b:28c4:b0:359:88c5:3add with SMTP id
 98e67ed59e1d1-35a012d38d7mr3576801a91.19.1773259053399; Wed, 11 Mar 2026
 12:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-4-ameryhung@gmail.com>
In-Reply-To: <20260307064439.3247440-4-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 12:57:20 -0700
X-Gm-Features: AaiRm52sIzb6_KbNecTpcE1qg84yxz2Vs0xSrZqMGjFP97M4P8XSEmbhRfLl42I
Message-ID: <CAEf4BzaRJ4hgMZY04=B0nnAE=MjyD4FN2L867vGCbornshOXDw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 03/11] bpf: Unify dynptr handling in the verifier
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266768-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9476A269BB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Simplify dynptr checking for helper and kfunc by unifying it. Remember
> initialized dynptr in process_dynptr_func() so that we can easily
> retrieve the information for verification later.

it would help to call out why all those checks you are removing are
not needed anymore

>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 179 +++++++++---------------------------------
>  1 file changed, 36 insertions(+), 143 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0f77c4c5b510..d52780962adb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -277,8 +277,15 @@ struct bpf_map_desc {
>         int uid;
>  };
>
> +struct bpf_dynptr_desc {
> +       enum bpf_dynptr_type type;
> +       u32 id;
> +       u32 ref_obj_id;
> +};
> +
>  struct bpf_call_arg_meta {
>         struct bpf_map_desc map;
> +       struct bpf_dynptr_desc initialized_dynptr;

nit: let's drop "initialized_" prefix? so verbose

[...]

> @@ -511,11 +513,6 @@ static bool is_ptr_cast_function(enum bpf_func_id fu=
nc_id)
>                 func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
>  }
>
> -static bool is_dynptr_ref_function(enum bpf_func_id func_id)
> -{
> -       return func_id =3D=3D BPF_FUNC_dynptr_data;
> -}
> -
>  static bool is_sync_callback_calling_kfunc(u32 btf_id);
>  static bool is_async_callback_calling_kfunc(u32 btf_id);
>  static bool is_callback_calling_kfunc(u32 btf_id);
> @@ -597,8 +594,6 @@ static bool helper_multiple_ref_obj_use(enum bpf_func=
_id func_id,
>                 ref_obj_uses++;
>         if (is_acquire_function(func_id, map))
>                 ref_obj_uses++;
> -       if (is_dynptr_ref_function(func_id))
> -               ref_obj_uses++;

e.g., why this is fine? (because we don't use ref_obj_id for tracking
dynptrs anymore, right? would be good to call this out in the commit
message)

>
>         return ref_obj_uses > 1;
>  }

[...]

> @@ -13559,22 +13464,10 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>                                 }
>                         }
>
> -                       ret =3D process_dynptr_func(env, regno, insn_idx,=
 dynptr_arg_type, clone_ref_obj_id);
> +                       ret =3D process_dynptr_func(env, regno, insn_idx,=
 dynptr_arg_type, clone_ref_obj_id,
> +                                                 &meta->initialized_dynp=
tr);
>                         if (ret < 0)
>                                 return ret;
> -
> -                       if (!(dynptr_arg_type & MEM_UNINIT)) {

I can't fully connect MEM_UNINIT and CONST_PTR_TO_DYNPTR, this is
something that should be called out in commit message, IMO

> -                               int id =3D dynptr_id(env, reg);
> -
> -                               if (id < 0) {
> -                                       verifier_bug(env, "failed to obta=
in dynptr id");
> -                                       return id;
> -                               }
> -                               meta->initialized_dynptr.id =3D id;
> -                               meta->initialized_dynptr.type =3D dynptr_=
get_type(env, reg);
> -                               meta->initialized_dynptr.ref_obj_id =3D d=
ynptr_ref_obj_id(env, reg);
> -                       }
> -
>                         break;
>                 }
>                 case KF_ARG_PTR_TO_ITER:
> --
> 2.47.3
>

