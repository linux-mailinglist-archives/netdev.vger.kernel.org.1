Return-Path: <netdev+bounces-251774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JL7N0FacGm8XgAAu9opvQ
	(envelope-from <netdev+bounces-251774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:46:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 925B9512D9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B4AC4E53B4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733C7352C22;
	Wed, 21 Jan 2026 04:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMt3W1lO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B12DECAA
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 04:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768970801; cv=pass; b=A9ErRtBXDt/ArZV9ebmpbcrlEzY3PVPtc+cyCtCJu0Sx/Rx4unK6EFY7/iPMhbxL14QnZTqjirXXhUoYTdCmGHF6426Mj1fwbMYGUYj80GEH6F0hMDZAzQ/yHHcFi9zKZADGdB85bRuM87Is3L5aBd6Z0r+wVK9c17bPzfFamnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768970801; c=relaxed/simple;
	bh=20T2+qqNxO7bztJvGCo2aK/0NUDLwuryRW7TvhVJsKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cly2gARznO4TPA4b9zgSivb/kfQfuLTtQfN/LXg9tr1/4OoBsRAXbe111tBMS93nvjpLxvWTyQwAbfj2h4Kc2bLjhXKAJqX0wjRJZ69sYm6eQSHjGNptao5RVN50WpEYuYXfeGfLYaytUmjE9Vup6C20vji6CZPGYWg/eJ4gczw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMt3W1lO; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-432755545fcso3529448f8f.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 20:46:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768970793; cv=none;
        d=google.com; s=arc-20240605;
        b=gVOOrMc/UFgM4LFyJ8mxkDnpjnwN+hJLy4Pml8HFq5M51Y5ZHvnM/RUd/uOmGtrdUW
         KCnIvXBAp3drwluwS9sLmo/Elgp6IylvPHIAZDA3fYQc/c0R8iRp1j47W4Q5oxSr/o/l
         Y+RWQXp8hiGmEuq3pfUE44QrI4rq097lHYdhd2fxuJFM2WdupwN15HuEV74xxcJKlhOo
         jHfdxEQD4aD4hb41fAnfNP63NBRNuAEABoJ8RKuf8achkcpSTTB4o5V98Ik9yqS3IXJP
         673lZo6Ii+Jl5O7RH3IysKpP20wDK/cOh6g4zNQx4OaI631F5a1nWe8NMzofzNxJNEsr
         JiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ySO47AJJ10B3Ag2hvlHnRbvG+uJN0RuHNF/KWvG9UFY=;
        fh=r8bJXr1UfEdqFzddpumsNxkuiZTR3lBKACLLjMeB4lc=;
        b=f/3mxPWvo5n9EYpyHF76MBxthcbRp8SFPXw4fFaXh7o1Mpf1qpCJo0QItVjX/c+Toe
         jdBlL/UyAe8W2DV0qp+FcQIRShH/UWkWDUSwYE3wn4uEUFX8iHyNZiMx37sTsMRSfvF+
         wiKT3RfwmAbaqIFv3zWaoBrSNIOeuz9k+DL67RLtSvpLLAx7heVJX6qD9QiuJ3tW+Ii1
         wu3K7hXRhW4G1+NyyBwCRw8wBqJ3FZruKUu7El3Vkgy654TiidU+aV+C7GwdftOATmt4
         A2J3kJ5c4K8+pJ9VzMMb/gLHmryEZ4xDRgFyFgAoTwG4PXXG5xQr8luUSlu2apmDtwxV
         ZesQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768970793; x=1769575593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySO47AJJ10B3Ag2hvlHnRbvG+uJN0RuHNF/KWvG9UFY=;
        b=GMt3W1lOuvJTI4LHa2MQvjQO4d/UvqjHmgmGTEuvseq2QplbT4UU8ONAcCPws5RFNv
         2OqMnM7kyDZqKr2gi3HTUF7qKo8476u79UTVlrmFExxZgPL8AC9E42C0+YuQK81FPb6j
         5qeUzTKLJPc9fIWqsnj8mFabcPbeNeZ8/PZsUV+JuSPqo/2PKMh+utINkNpliuYbEZ/W
         GoyJl/+pJG7X00rMioZPFm4AzJrCXTFEZA+gH1jrI5B3XgaKof57v0NkzJu2YerAl1lv
         dn8OfGbR3jo6XRQOobEY4lH+J355OaaTh1wHOq6w4XTsHimDvrfl0DhRK4Q12kGk9zlP
         FP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768970793; x=1769575593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ySO47AJJ10B3Ag2hvlHnRbvG+uJN0RuHNF/KWvG9UFY=;
        b=VA4WhEsV2ikhCVLl3M+KayRCiRvbNRYXqOyueoiVaQJZL7fdXvnppzJTC5N9ZOYjbQ
         UylI79xul9GrhxV48Kh74/UiIJDIkBbdjHSq0UtVMXsE8IXx2CbNHEE2cLLEyjXbPsqm
         Lrjgz04f7xpUCMCfJD5a8t10oxyPel/XSbKgY/muH9FHOH3ZogGZfxjcez3RUObkbnTF
         est9gxDDrHHPvn8KK5OsY8b7NVlNT82ZEqq052HOvysawhpr3V9mEyoMUYR6F+FKNfHb
         Ax8whqLVLoXz76RJpTPwjIkFTDFMR3W2HWTh6hb4WG2p80w3HdT3qQrU/VirsrK8a7Zb
         o2pg==
X-Forwarded-Encrypted: i=1; AJvYcCUlHoaois3YS1Un9ZehtiILjLu/PeZhK/2PggYgbxxQR/mEdfakQjjUAbBLTxhMEB/x1dgpUJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTz0z6JiuDlw04XZ9Nezb6JNwzvNFMCyvjVizAhnRn/QhjfYtc
	uB+M0YwyPc+jsxMCuGQOkY6uzmgW4T5JNDwt17smQEI1Ecns+xe0AxvC1Bmw5xVfxlNW4Ld19aE
	znpzfUC6V2lUPEhHNNiyRcfvu9VlO1A8=
X-Gm-Gg: AZuq6aKRUKwetE90RRUHZOuHaQ2tCaHidFkV8mNZAiITVj4JljdE5LCU1s6KMhNyvFB
	wmBR42amJcA0YINBzta9fimMAQ8ISgrBNYAgjoX/niLEkId7VWmyK1ojtgZw3VJ/Yj90QLoZ6d/
	bQ7J+ucewpGteoxg7Mj+7C2c/Qd8X0/YyrZoH68PLAdRBHd9APzQv542ds8N0Dm3veB1B2rIsXA
	caCQK2SlydtpVcrHt9QDN31xutxJCg4WH60Kfjjer6MnxVLiOic5i1bTqaoYR8TbGfk9FztK7ul
	Ly7IE0Ptsx1op7TAq5Yr2s/vFbAA3ueWIYefQ5lHcf4ApVZlUOv6HJzolHZqpyAFuBrg0SOe+kp
	4S+A6LP6Q5SiP3A==
X-Received: by 2002:a05:6000:4383:b0:431:a33:d87c with SMTP id
 ffacd0b85a97d-43569972bb6mr24731703f8f.11.1768970792593; Tue, 20 Jan 2026
 20:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
 <20260120070555.233486-2-dongml2@chinatelecom.cn> <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
 <10788751.nUPlyArG6x@7940hx> <CAADnVQ+Om14RF1GvA0vkhKdsCtVGzbacftEZarLJ-LKdYXUZ+g@mail.gmail.com>
 <CAEf4BzbVGx+0vn6n9T3rpePN7D4Mm54Xzc1spdSjvmrj1mV-0Q@mail.gmail.com>
In-Reply-To: <CAEf4BzbVGx+0vn6n9T3rpePN7D4Mm54Xzc1spdSjvmrj1mV-0Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 20:46:21 -0800
X-Gm-Features: AZwV_QgiJiSGEmmfS6mahHDTcP2ic6kmGCVJweZ0Bopz5JQHXckd_wzAtG8jFNw
Message-ID: <CAADnVQJZ=OSrQZn4Dk6iK0Os9Uxa5CgLXwjcSh4qOq95xx0uHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-251774-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 925B9512D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 8:12=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> >
> > Looking at the patch again. I think it's fine as-is.
> > fastcall can be a follow up.
>
> Yeah, it's fine as is. But it still seems like

Thanks!

> verifier_inlines_helper_call() is an unnecessary extra hop we can
> remove (even if it has to stay arch-specific).

I'm not sure that we can, since it's used in two places:
get_call_summary():
                cs->fastcall =3D fn->allow_fastcall &&
                               (verifier_inlines_helper_call(env, call->imm=
) ||
                                bpf_jit_inlines_helper_call(call->imm));

