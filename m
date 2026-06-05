Return-Path: <netdev+bounces-295964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0/ENJLMqI2qVjgEAu9opvQ
	(envelope-from <netdev+bounces-295964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 21:59:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F040E64B136
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 21:59:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Z6w6JMuK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295964-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295964-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4BA53028448
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 19:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8901240BCAE;
	Fri,  5 Jun 2026 19:59:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62DC311C01
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 19:59:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689585; cv=pass; b=dUIg2RTAnJL42+f1ItA+OUs3GeiMqdm9Tm79E5Mrluc+JUyy4XDZbs4ISPQAsqoOnJwtEGBa/wEMandCWdBSZozyEPUexq7Ck4lgiei0m6UvP1+yFCYvn2Rv0sMteFI51fe729ZUtmCywwM4ns9Yv4fuRkpd3nf31fwPLQNQVJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689585; c=relaxed/simple;
	bh=1bbslR6O7pAnfgONfzpWzoKVocFLZxHaQJqgfgdo41c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsWLjIOIe/dyfpD+nVpOXcbB6qT8WDi1l+QfkhKTCKSJ5dNnblv+D1D+Hg52yl13KTe/MwwJHLNep/GW8u+R9K9EPKxdu+cL8NzXKMWdPpbKf5LOkgNyeIVGtczhJU0Dz0WwHH2kErSvbehVe3DL11QjSiBMeCv9IKZ+RNXX8M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6w6JMuK; arc=pass smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7dc93d02916so25812837b3.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 12:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780689582; cv=none;
        d=google.com; s=arc-20240605;
        b=S/LfuFj8kPtX5X6U6AhfMZ33kucX7cSAwQLJ/UBXvTEzR7UU8DJMqJhtP5stSVOeJb
         8Mjt4RzTagSqhkUaQOf7f0rQtv+CTxYPHBAZtUFLgEwW2dOpxXfZNeI0d2/RE03C5GhS
         9JVT1NBBtD6qmyenS6nGXze69QP98QD0oGNksNTJmJLufDbMxUr3784nV5VwtojkC9vP
         fSQihHbounSJN0L3vB7tU8Hr8MgpaweZ0J/9jGmmyRHgS3CTDYgMvNsUgLvuxxDAPNF3
         Bgeg04EPU5vQakno5iIT1UYtd4qFcoC24hiysH7zY4kIMILJbSJrh6j99pFExQTyPP0X
         Yu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ctdYFil8k1KSTdKhmfPPRD50Fe9swriPVxWQulSiEeE=;
        fh=mGyJIC1k33E4wPdhrr+06A0y21oJuQMLjKYgiOJ9cVQ=;
        b=FNTMxcwfFXZttLZ8eRYt5zTLKzP8qkPMVzZNE7uhBi5zGIK/FmbU8Z8BtDl7rswtPq
         iznltwhdkweOw6V1JAhLrb8fUKVPPl+ktsv3LfIP7O9u3V0kNZl1GFFsOJComWWaiVas
         DD9yjjjaVWycx9H7MLrxrt4oM7pn4+CPOaDShOaed6nvUKVGmVQw6gcMjr6KyWoTPuI1
         a21GiNXiYbDCj/DRfUAxWd0mr4NUdx2byBF1vF5NK62l8dDAJWErvTxwQ3WWXwwjvFRP
         W6WrppB+QaJGYAgYcJgh2WaY4Q7Cho1DGUJwfCv28vTl2FV2PsXjoRf9UY5/XTzrMVIl
         EylQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780689582; x=1781294382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctdYFil8k1KSTdKhmfPPRD50Fe9swriPVxWQulSiEeE=;
        b=Z6w6JMuKeg8X1C+mFugaS7MnhgVD401g44vC/MfvMhB5jvspHTuqv+zFPt7YQ9uGcQ
         G1Zcg1Q8UVvtXBvf3ruefoINCAYipU050KcbUc0DSPdWH7j3zhh6S82SIzm0388so+xz
         BC4gqze4qAqkWhpCB0pVmNFNObpXqyolUMfpifnigChTbr60CkuHoy9DD6RAoOhw/jSE
         HTXD5R/3BeAfmaw44sj4CPhCJVeLELY1Bjb+CVyES/eOTHe90FpTcNymY+TXOwpm9tML
         CFt10TH5wE6Fj4n1garGjN8bNoGCtcE2H/wM9/LWQh+/7LUyUGtvC49E1RHBmoBX2sRt
         qiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780689582; x=1781294382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ctdYFil8k1KSTdKhmfPPRD50Fe9swriPVxWQulSiEeE=;
        b=UqimUcZsW9A3y4pTjzuLIM3t2/+xA1iU1imexUaxvM2NntGsoDpVFAnJHB5DQKKRRS
         Onqy2a3LJ6YbG2v3jyOYUJsB74ohDcO0r6HpeLRuKxnUt7DeRUWdBiUtfQ2PdKNvpZD/
         N31D37MCtFB8WC5MAO3ISfFFM9MRNwj7PJ6Ekn18h9mOoyyxyWbh/UCpMrvCeJR+SdNr
         osyvC6w18rtRUp9oO11D2lZwDKOiuUaAiV/L2xr7ki86Lbo1ZM1mxum++NHPMSyxiu7d
         vTJKLoYJvMVC23oAgGRSFkSKmd7+oPTs/ba06riplcyXYA6J77TCaFQvRbBKnVoV86dR
         8JkA==
X-Forwarded-Encrypted: i=1; AFNElJ+AQ8D8ONR5eTdgl5H7YTfHeVJcbktFVCB3YaNHi9nBLKvV9QyLkJPjIxzJv3g5gX9gzlEMPLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypWIxGalyBXGJf8XWsML/wjOXVyffYgnYfjLYWiG02G9xFk0g7
	6GMQXDicmKhL8q1WG6sIiBnvO+wynsVi4Cr4uEgslbEkeTR4xM9VXKCVXh+TfoD93DXtls+qhKy
	JhqXCFqw39n4WnQuUFOlCEpEYwcxbjKE=
X-Gm-Gg: Acq92OHPnneu0a/tPh3cVPEeS8CsCDewHuI5WgpjCuGaDpVhT1k11o12ZeuEC2t8+hH
	bBwBv1L+MfjZrSGg1BT/SJl9m+UFxkXY4cEAMACW2AQvN2OlISLBFaqgBoFUl+7J7gSQXrAQ09O
	j63ZBNTeLldWZ5Zt7amPQ1+J3XjoL0oSKEA0ZSHzLdiqXnPSjjOMxUhPVUv61+uhM79hjvBBAkV
	sZNzh7UHxTbMM+Dmclh0r8sWEUedWZUoiSoVqJ/9OfxWSFy/CSsavSrSMgO6t3ayRh87aQIuQLd
	V/MVf2Zoc1H4avgDFSMYdkKT59U/K8xI6g==
X-Received: by 2002:a05:690c:4907:b0:7dc:aa85:5c67 with SMTP id
 00721157ae682-7ed0a9d67dfmr55745037b3.11.1780689581972; Fri, 05 Jun 2026
 12:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605183551.969144-3-ameryhung@gmail.com> <e267e030d9e626dd07af109d4bb866bcd31e034c2041fcf324033591b582bb81@mail.kernel.org>
In-Reply-To: <e267e030d9e626dd07af109d4bb866bcd31e034c2041fcf324033591b582bb81@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 12:59:29 -0700
X-Gm-Features: AVHnY4LmfmkXkfCsZ32Q0qVybvOCxkFOL30jSEf-h-BGFSAM8mzBeTzfUW4ORQU
Message-ID: <CAMB2axOZQjFEP3732DCfyBAyOQU0PaA55GdRZ54E430jzMhLNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Check acquire_reference() error for
 "__ref" struct_ops arguments
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295964-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bot+bpf-ci@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:kernel-team@meta.com,m:ast@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:bot@kernel.org,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F040E64B136

On Fri, Jun 5, 2026 at 12:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a741bf447931..5a69af569089 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -18363,9 +18363,15 @@ static int do_check_common(struct bpf_verifier=
_env *env, int subprog)
> >
> >       /* Acquire references for struct_ops program arguments tagged wit=
h "__ref" */
> >       if (!subprog && env->prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) =
{
> > -             for (i =3D 0; i < aux->ctx_arg_info_size; i++)
> > -                     aux->ctx_arg_info[i].ref_id =3D aux->ctx_arg_info=
[i].refcounted ?
> > -                                                   acquire_reference(e=
nv, 0, 0) : 0;
> > +             for (i =3D 0; i < aux->ctx_arg_info_size; i++) {
> > +                     int id;
> > +
> > +                     id =3D aux->ctx_arg_info[i].refcounted ? acquire_=
reference(env, 0, 0) : 0;
> > +                     if (id < 0)
> > +                             return id;
>
> Does this direct return bypass the cleanup path and leak env->cur_state?
>
> Earlier in do_check_common(), env->cur_state is allocated via kzalloc_obj=
().
> Other error paths in this function set the return variable and jump to th=
e
> out label to call free_states(env) for proper cleanup.
>
> Should this be updated to set ret =3D id and goto out instead of returnin=
g
> directly?
>

Yes. Will fix it and resend.

> > +
> > +                     aux->ctx_arg_info[i].ref_id =3D id;
> > +             }
> >       }
> >
> >       ret =3D do_check(env);
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/270340=
08594

