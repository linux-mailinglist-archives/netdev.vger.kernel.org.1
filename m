Return-Path: <netdev+bounces-259544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDFMI2FNl2m2wQIAu9opvQ
	(envelope-from <netdev+bounces-259544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:50:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F90161694
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB7EA3015CA3
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2560352939;
	Thu, 19 Feb 2026 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsnIqC/U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3434FF78
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771523419; cv=pass; b=HpmCBoumxX7JKADKiQFVIkNuB6dwY7PyVBvimENx9VMxjUHJ0nrB4eJL7JX0vY8hNRYMoW8U8SDbRjXpmDh2Yxdg19AbufI0qpiAkppLAxiN++hBhU7Ie/gNwMzf4/1dx9WUYXj/eM2su2KsRG4314TNIykifjYan6jCAa5owhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771523419; c=relaxed/simple;
	bh=gHUWgff7WmvTx55hmvJ5HXD9obcxHan7DBI288vZwm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeiplBrm5YZLxmvHsOCds8kiM0Q0pbGVeJxztd8teYWsirAdsq6/smjud9gNKrij/YPFiJ6X/NLejFWR6tkeY72ypY35hSPb8eGVfN1EAspp3RAaR5zaoCDfMHQGuAUkuuHB8yHrBetA6JLJ6C6AjMQasQOIlsxl2RfeHc/so4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsnIqC/U; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4362197d174so825472f8f.3
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:50:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771523417; cv=none;
        d=google.com; s=arc-20240605;
        b=jzUxyO9grwu8jUCRUm3sLJcd9ZV2D7MhyI+MbHrvEnXXFW00KDcM96g7ax81cYGMWd
         J5lAotvdYWMTfLh6TsNUBlflH5utuEJgGLT1dohr417PaHp9+ksquA0IGcEzAIGCsYW+
         3vI97xSDawg3APmuHOnq8IZua0RbK+d77hM9ZRNCSCwCByhw2zQnHlFrGCEIGPxN1Y7e
         lBdByhgjelmTbuqyzwDQhX2D0asTI+TlSnaFxQPXR00/Y415ITtxsbexqrxM/toFNk7C
         y+WvdOgDx0Q2QIGQCbtnOukQOU9eDGw20gK+OBuXxYERiE3e3vEiP1nEoPDpxDbc3Y4y
         doPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J7HYm9xMVGBBywh4oao6tB7DD0AcczRTLXxlLGbI01c=;
        fh=/rw0petvFjZBdpHx0ULmekkZcFEqGWVyH0v2B8jCta8=;
        b=KwPSTeXUxmkF9hAiypY4i/SOCRKJ9Bfa/iVOGgHFoSELGs5e/h596c+Trnz0Wr96xw
         /qwwJX0Y5Cdclhsir8zhx3+yBBse8GD3pjyFm/q4luD2dx1UPL7Uaaes9EJxy7l2JwRi
         KzO8rWyWtjflzo+1YQZV6J6OVJpu01z7xnKaKUKvwPViCnl5F7w16mFbtngQUiMV+Ch/
         H+amb0z0QAU5ekCYaZS8U69vYERlq+oaJpb4F7dFcDbvH9aOdRqD0D6LH8qZaFQkEtvn
         tcrMvXsrVtDNW09+FWxfPOEcs5xhwQ0irodYdc3pW8qzQpJcKD6Ep/Zn6BW0yk3RRnlG
         ZXxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771523417; x=1772128217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7HYm9xMVGBBywh4oao6tB7DD0AcczRTLXxlLGbI01c=;
        b=gsnIqC/UE6uQ1p+IPN/UgnXIpnNKwwU79bKqZrHB18g8etnqKiV/lGcnAM2yjkRTfM
         P95Ec4CENYQWOw2lcasFOWipi6xWZ6+OEVVh90/cY80PzH57NuWM+C+7S/27bFEv0Mt0
         NEK6bdOdJwec6jyGWSR1NYrTEPX+tmbWzkBz1E/mdID/G9MLEciaQxiJRxgpOSxkWG01
         qLzT9hGI4SqiERnHy+v0WvHnCTYlnIkSybvX2WXIttkiChuGDqCcuG17H7u/C/nSr42T
         bqBw7DHZZ2IlPEz0Mrp598eq+G+A3V81jNfmwjZwxr9hrsJzJqLuu65vYwdoO2P2KLan
         T2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771523417; x=1772128217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J7HYm9xMVGBBywh4oao6tB7DD0AcczRTLXxlLGbI01c=;
        b=Ix7QpZX/o0O6KU2245K2JKUaPqnKI/vFew9nr7vaUZDzhQ8Av/yxb8Mu2BQkklfODS
         TuxAeT/nCfks97tIJJk1lhe8QED8t6nUb4sLSh92tx9dCSbbC7XJtSskP5yU96MLEQfu
         RltruAODDTUGIFwOJ1j30qkYTco3vOcJ3EiG/tqIkPlHXSjqJifBwtL9G/ccQB5aFC0W
         Q2X+Q+yWvoBubXDsGPffMjg8hX3LCmFXd8hkDLXSSzXsA0dyELCPYwK59Cr09oc8k7sc
         h4hxe4WEL7yz3sPQPD3UDKBnPo/XqaLKy+jVzyZV/+6Fg1/f4Da3pnY4HJq2P+t4LWNK
         9k+w==
X-Forwarded-Encrypted: i=1; AJvYcCUNAlDTHodqUNrC5QHt+7cRQ50S5Tw8CXNafZAPrCm9im0JfZlzyr2Gr/vfwNM8ftx8G+8uGAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAXhAM+NrTAxzOoWgPDUkyN5TBz/1gzo4qHHKvx3FnmAxS4OR
	7XnABeTpipVFIjDsd7tGoQDbJ2aMW69/A+BDmkmYOt8oC7Lqzhq4idK4/UapIhxJzX1IN71yJ9f
	crqI5WQMjUGBpnmqaBuQPUnn+UwzMA+k=
X-Gm-Gg: AZuq6aIW4Lgv/TOWSulA4IMuMYVd9rjhF8GADCX44duQ0SN1CTH/ED/F6qsMhfBZg4B
	KF+BLdimH4BrowH+jybWJEd6v5SlFg9zbqBhjdTRsjDAdD9jy/Ht3E9/m6jV/Bzx2y6pqtw5nrA
	/M2a/vZTVIN907ImsNju1j1x4wYcxZ8xNr/eKqLxoatTAIxkkTp/YC4BZdC1p7M2PyxFVxtISJa
	y5T8xdTPGQjsUoE2p3rjj4IBP6h2/+TB93LezHvYXSMbdCYCEUM3l/moTyTOeutCLU5h3jFBT1y
	eHMSoRtFVgf5pfNkvC2+yxzP/LQXwlbNVw/Mn4+0Kwo4P0Ih8dNE/EmaOl+Mf1WHNmLXMewWs1O
	BifWVeAZz
X-Received: by 2002:a05:6000:40db:b0:436:cea:6165 with SMTP id
 ffacd0b85a97d-43958df4415mr9935730f8f.6.1771523416533; Thu, 19 Feb 2026
 09:50:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219142933.13904-1-leon.hwang@linux.dev> <20260219142933.13904-2-leon.hwang@linux.dev>
In-Reply-To: <20260219142933.13904-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Feb 2026 09:50:05 -0800
X-Gm-Features: AaiRm52i-YIC0PVoZrigOcdI1PlDGl9FQnJThWLdjntzeSoTM5oZkoYI1MwTO7Q
Message-ID: <CAADnVQK=5Gb3w_QG4Vq32EfvpqAK_DPwCHtzzt7DzRkJ5_h6JQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Introduce 64-bit bitops kfuncs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Peilin Ye <yepeilin@google.com>, 
	Luis Gerhorst <luis.gerhorst@fau.de>, Viktor Malik <vmalik@redhat.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259544-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,huaweicloud.com,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,fau.de,lists.infradead.org,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 13F90161694
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 6:30=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
> +static bool bpf_kfunc_is_fastcall(struct bpf_verifier_env *env, u32 func=
_id, u32 flags)
> +{
> +       if (!(flags & KF_FASTCALL))
> +               return false;
> +
> +       if (!env->prog->jit_requested)
> +               return true;
> +
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_clz64])
> +               return bpf_jit_inlines_kfunc_call(bpf_clz64);
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_ctz64])
> +               return bpf_jit_inlines_kfunc_call(bpf_ctz64);
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_ffs64])
> +               return bpf_jit_inlines_kfunc_call(bpf_ffs64);
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_fls64])
> +               return bpf_jit_inlines_kfunc_call(bpf_fls64);
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_bitrev64])
> +               return bpf_jit_inlines_kfunc_call(bpf_bitrev64);
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_popcnt64])
> +               return bpf_jit_inlines_kfunc_call(bpf_popcnt64);
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_rol64])
> +               return bpf_jit_inlines_kfunc_call(bpf_rol64);
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_ror64])
> +               return bpf_jit_inlines_kfunc_call(bpf_ror64);

This is too ugly. Find a way to do it differently.

