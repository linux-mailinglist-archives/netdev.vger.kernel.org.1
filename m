Return-Path: <netdev+bounces-251780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI7PBx50cGktYAAAu9opvQ
	(envelope-from <netdev+bounces-251780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 07:37:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1DF52215
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 07:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C22066C0D1E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B5244A72E;
	Wed, 21 Jan 2026 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOzBZC2y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632253502BF
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977366; cv=pass; b=WjAGPeNlqCkdu+7tiYO6UmA2Ao0m0DGKWcszKde6imYxbIwKIya7YU71KazX7SDxDmlSq+UtPepqKeo5/oSc3THZKLat24M73WaLFkeU8UVwWrE+u1wshvS0N77tSZA5lVrCO3XAz33L2zOElHbE/ewjMu8eBsfvwYGazuCbN5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977366; c=relaxed/simple;
	bh=trvdI0a8VZHf/ha3bFoj3a3QxrObHtVi7lvVYGKC+uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2R98/P+K/mvXMPEBdcvQdgNyNprvxsSpdEqr/8KFgnxGQkIFm/tMrPLa7kRxhE/F7KxhFgX91entaWUDoyY71Q/rAHEWQjp0QnDS78l+7i+MUzE7welxS47D8FKxSavTDRqOM28+FoZjzf0e6yPuh7U3llwzeQoTb11DQf/MzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOzBZC2y; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c6001632e4cso413544a12.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 22:36:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768977357; cv=none;
        d=google.com; s=arc-20240605;
        b=K9EpTTQNryGPkKIhmq8S1t90VkayrTHd2UozZiUnlyFAJdGkeqr2iTJml1JtM0ZN49
         Mvcp1+4S5+g3oNKq86fT6/6EJLX/fo4S57okLO0HLPwErjWehadngnCSPDhB8iN4Wa37
         svIjTTiS4tjEa1UXxVrrUo0m0NFZQgfIsIJ5Aw7SrCxYS9tJWSZZOLDOqxUprMmBeztm
         kBmDx63k+hQlk3btGBDY8zk6kmhxkyTnM7O7QwikXUwI8TkcMsqQ/U+bXOFKlW1ZHiYu
         fke3pelLN/rK9e9uwLCYFVX/t47Afi2mx4YyLw2RRFawry7SGzfCeC7gr9ETm5wMI0NN
         1rgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X7jj6Vi4WLaF0iL4b2JIgloeXSGsPUxXEpOTubxKuMo=;
        fh=8TCat4VMNqSp62NIEMzuM82pzGfgRVyPzeZYYfZiC8w=;
        b=P3cCEp/rcbI01mvz/mY/GH0di3/xTd1pnvWFxno6BFAYhq1gMhXIdndJH9I9yVMKx4
         u89XcObD9+pOgvHjGg7K2NREwkmcZarjnU+IN5B+c5dbCb2EBcx65UVq3WZnA3G38KP9
         WetivtqbSFpryQjnv44C3Um0bV6OD0aVb0SFOk2sk86RP5VjIDdCnm1TW5DjoC8D246m
         tB1O5C0mbJB0SWWwm8nZPAgAx/wECSBTAoDEiYeli2IXH9cBOw49Q/wdk+Z28+HAVRtb
         HKwq2BRXD/Ivp5E0qR5ODXSmvwdGV4/uM2fDnXUaPwMV0gtW60MvGvmoHZ/BOOUcNPAu
         rzJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768977357; x=1769582157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7jj6Vi4WLaF0iL4b2JIgloeXSGsPUxXEpOTubxKuMo=;
        b=cOzBZC2yVNULrKqFjBhck9VyIljo8eqn0CvPqIw1N1omamZ/Rzw80TkktbZNiyGwPt
         ToBn7p5LjS5Pp4Ex7IVTbNkKVrmIUw/kiKFnre6Az7IloyRixW6OvEn62xgDXR/GbTHI
         Zw0mDefmtSGaOfICnJ2AkFAgkwSs2/HnWMkIzHGzZRVE37y5wDUTd5f4DzX+pSZrpE5R
         eNei9wScYliV1ranCXSzMk6cljsWqNu1Vhu3hhnuamZc/ZJxIdQ05D0PMY77LHUGdxCu
         5Q28Wnh9nnAq+fBQGCug9FyKBpZyQtCU0rZITqN+3NvskS2j2sB58n+F7obNUV3G8/Fu
         x65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768977357; x=1769582157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7jj6Vi4WLaF0iL4b2JIgloeXSGsPUxXEpOTubxKuMo=;
        b=VDAdZe0Wt2PkxQ8Vw2FJelgIPS2Una8gfjLWuBc3jBQuNifhU03DahGhLJHR7ePu4g
         cirfjv9efjvE8Qp4HXuKgF1+MNm9FQN7VM/1RgIcwRUNMBgim+JQ0sX2Etq4+ZIvFrAd
         RBEoFwIIcKTdPeO8l3g5GSjtHdBnahK43vPu/RUllaQgE4476PbWcgOUV8OJngRLhzXB
         aF5anc6osJT0WnkVzJPTRP0YKDmNxfigILjb+YFwMfNorPIkRTuZT8GslY1svhRJOIF8
         PPQZ1+NULxTsvp/XwKTCFmli6I+GUGGojNDgGypKj1Hs1ggH4JzaHhMhmGp3f8LCe1A9
         EdQA==
X-Forwarded-Encrypted: i=1; AJvYcCVzJnfbTrGYYqLil73paWkpL0R9xGETz8057uxUh9NWBSw3GAk1/q41PlYB4b2szl4m2jMaH7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxpxXJxEhC67IA70HV5MtEZdKHTqfagF9Y9Y/alNbTTjEVj7da
	TYxp1RkxIB14Z6dhxklhvUryvECrNFJs4Ju4kBVkEtheajnNJUNVv1dXzw774UOdtp2ts5JqlFH
	WCvAE00HBPR7dMHmlX7xbZbyYR2eWJ3I=
X-Gm-Gg: AZuq6aJLG2DrJa5Ul/NJzIiDbRVN8feY+/eq3iYNHOteSTQ23E3y3Gge5p4C6bGJgNx
	4iHwqEFu9LpjKKnp46EsqsOw7i5Z3mhtDCd25uUn6dvSCutvncOAyeKOXS8NvdJdroVb7bpsBPI
	h/FPzEpGlwmTZDpUFOwJJXHuQYAyGNBgwEL+yYQpBlD9JddaiiZ8tXfCqZNNp12jgffLp1vlCVj
	5yZgTkD7FlssjeQxGSB22p6upkEA0ev5HsR2s01pAS8LWCUQgro4O5GDx+GqCnaQ+iqHvY=
X-Received: by 2002:a17:902:d4d2:b0:2a0:acca:f3f0 with SMTP id
 d9443c01a7336-2a71893cddcmr150614405ad.49.1768977356681; Tue, 20 Jan 2026
 22:35:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
 <20260120070555.233486-2-dongml2@chinatelecom.cn> <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
 <10788751.nUPlyArG6x@7940hx> <CAADnVQ+Om14RF1GvA0vkhKdsCtVGzbacftEZarLJ-LKdYXUZ+g@mail.gmail.com>
 <CAEf4BzbVGx+0vn6n9T3rpePN7D4Mm54Xzc1spdSjvmrj1mV-0Q@mail.gmail.com> <CAADnVQJZ=OSrQZn4Dk6iK0Os9Uxa5CgLXwjcSh4qOq95xx0uHQ@mail.gmail.com>
In-Reply-To: <CAADnVQJZ=OSrQZn4Dk6iK0Os9Uxa5CgLXwjcSh4qOq95xx0uHQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Jan 2026 22:35:44 -0800
X-Gm-Features: AZwV_QjOr_ehj8PtJmMMlBQZTUy6a8f_4Wha0__70LtdJHYQqw_Mxp7ZpXy9RnM
Message-ID: <CAEf4BzbER285+j+DLsRdTyw1z_f=6-DYW8k88ehqi_mNW4Kv_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-251780-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,davemloft.net,iogearbox.net,fomichev.me,google.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8F1DF52215
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 8:46=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 20, 2026 at 8:12=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > >
> > > Looking at the patch again. I think it's fine as-is.
> > > fastcall can be a follow up.
> >
> > Yeah, it's fine as is. But it still seems like
>
> Thanks!
>
> > verifier_inlines_helper_call() is an unnecessary extra hop we can
> > remove (even if it has to stay arch-specific).
>
> I'm not sure that we can, since it's used in two places:
> get_call_summary():
>                 cs->fastcall =3D fn->allow_fastcall &&
>                                (verifier_inlines_helper_call(env, call->i=
mm) ||
>                                 bpf_jit_inlines_helper_call(call->imm));

well then, just ignore me :)

