Return-Path: <netdev+bounces-251692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPFFOXYvcGkEXAAAu9opvQ
	(envelope-from <netdev+bounces-251692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:44:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 688724F471
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B915B24646
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215E52EE262;
	Wed, 21 Jan 2026 01:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNeb+mUi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFAB30F92F
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959844; cv=pass; b=roCYTreIbhyVQrhRZfiQWfIQ2dr5J/qs5a/NdyVu/CxeuuJCMb5H6tuiA9hUQTlRUpCJIKn9t3r/2MU8JgYPR3CPvbFiOthUBLj7cDeN8ynlqnW1PJWoi86BamsSba1Qn7dlUmN/QlBAJsXOeaFPmsltU3L3QMU/bPAxgywFPco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959844; c=relaxed/simple;
	bh=d/fzSty3uhFIl7HiRvNQUIsg1oOiQS3b+VaEtmyTm0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rp/qXH21X2nkIPdayG1YvZmYjgyM1j2fALu4tK4SqzpsyJMY71W+n+yKbEkwLmMTuskgDNSAjcQr6Qy81+TYj333E8jp8WGIWK2ReByvLiC796N8/DcSn9w3u6qrBD8/htXvyF8QDwrfyakQn6rXtx5dyK5+svjTFIVdpdxAxgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNeb+mUi; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43590777e22so694604f8f.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 17:44:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768959838; cv=none;
        d=google.com; s=arc-20240605;
        b=cU76mDgYeDe8/Y4/wwome6fM7G5yIZt/6gJ9Tn2t+wtC3/3qlE72hvl1tyZSZ72YF8
         F622ZEJbgtFbyi+iq3/NpPov3zTdvBGnzoRUWHtFAmcFGeC0c5+ayHijVSgtSuyb2LRB
         QACy+peFkbNu79ro7cD+aAErlGimb2Gi1SqDZsAWc3XAHXbQrwc8Q3otOoI40SVpSUqk
         f/+VqtCuK8vAAwdJb02UbL1KS7D5Do3nuQK6jWn6D12uw/thMHYRHJDZEfDkEpvN8W4X
         CZg3FOOdENtSLkV8IsgRvgrlhEzkdW+Y4rigP+f3/9/0qF2qJnLHy/r0vKqwXz+lJOkd
         vOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2WuKiVRVgARvTZSPf6fz13gJaSXUGYxCsdsd84fjKM=;
        fh=7axpWxH3oQOe2nWTbqi+rtkON/YU5kbJG6mifdW/vec=;
        b=cgC2z/zMfbQISLYnhwV5OTX+kJ02R4i9HvTW1N8BlNmWiGVnXcjG529yFgG4UPu/41
         nbRoX7mEZ0BZMwy/BA7hIk3yWKUt55Mv0ipeTJawRXTPN7oSxMDAhbB8zlMK6eJBEvuv
         Uon70JlKV1VLJOFF+jh5QudMGuw4LkO8pNBFfzDQaU4Yzcpu70dhOKxLrLXTaBS1uz8Q
         NKnVRZhaIsbr+1pb6/c28jhxD1aLrTVUOpuxSrafB7BiIRghm6oCY4gAPqXyGUA9Xjkx
         Y+lXISpt6Z4pluVuvspOnLEML3VWAR/vsub5Wys1tVJumfKeykIV2k/Ejs2hHol5N6mD
         pvbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768959838; x=1769564638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2WuKiVRVgARvTZSPf6fz13gJaSXUGYxCsdsd84fjKM=;
        b=fNeb+mUiHwQFfKzE2by9AcRQCaJZJ+gxOS5aLzJqzDngHnOd+E/x6G+/w4AzvGH/wb
         Ni5xFeVXsBNUvc2MfOu+NiSxFzo1F7ycKb/w5CXeaIxryFmyEUm2q10wzxj4KaLuz+Qp
         GFxpKgGYDjOUVSy2sbM9ElnALKW7sBHVhygHT3zalnsqWxSc0xCrKl87AivvntnMRY/N
         cl64dm6L0Gxstxp4odvKOWRMhmndHcIGj2BfzNLe7YDz2NhhZ4T5ibMsVfxFq4unIriy
         cuKRS84QYTegycgc2CNmjYQmfu7asoP4Zn+lUr+t7guuXmeRiTWLIunCEdb/zixENpUD
         h1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768959838; x=1769564638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2WuKiVRVgARvTZSPf6fz13gJaSXUGYxCsdsd84fjKM=;
        b=juHjlyMCFpGcnoF2cPhsL3MHjaz8o/9bYSd7lnN/IkMTkgOV/lFQjCCwYb3QjywjB/
         2V5OiwK0Z6ek30L/lqlW7By3VNWPjncZrCTQBtC3NqH+g66U34p4JBRmIPW1MgqvmsjR
         p+hB7DnPbyi0o6VMxpAGF59HqcqBILA6oBfu2votYSXSxnmbWhCeEjpMJa20HGj5cDjV
         pNv3ba/6KG+bGNlj7rOyDeHxuNj6gB6gcxujc4N9xItEqmQDZ5KST/2ADMvdjh9oWtpb
         62WwPFyVfEUSD/BFiehpdAP5/KUx4fsZVX7P6/B0iA25c4OMu7v0wCj/kw8O9AV+LQ4f
         FLlg==
X-Forwarded-Encrypted: i=1; AJvYcCWtONySSchjxy2cTCeDWH9jABEr9seavqSiWwxW47yvaHIsPKsPtgyY+tOT3m9FQkgZaTDHuJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywObtNGEZUxqQ213w7x04FW2rEeUnYr/TK+kR99txGheYgJ+rq
	tZtk/QsZnbU0OmdwFdmJZxx11RlyEWsqVuP1o7trkRsemiVJI/sONKufvsia9l2iiEGVVtFpmRj
	fLlWEsjsO+kV6kzmk4QkMgI27MisW1as=
X-Gm-Gg: AZuq6aJYs+8EafhEjU+DONN6xezNDuzw92FqrXyGY6B41TsVWk1GU6ft7jnTYntu8IL
	3lgi8sINuUp8qzGts9lSL9kWmMPkjehiwl+pYE51TH5duhgFvhlszsYMKcojKtVmnNfuFo5Us7E
	gx+e7sk13qg2j4zykxpTA8uyaV7tdwJtCn6mQLp5eMGmXwD55BY4lFzUMGzz9mUKta5BWTuSDfA
	NiEbtlNjaa3u/juq3FP/5UuxMnV+a6Eo3cOldHO9XcT4gPzAg7ykBG2FfO9rPRuUndMM5un8kqf
	uOor7tgfH7Kektu7LtiLKIJKXjzEkYadS5ctWmUM4ybEvOR38HtNbeYTFaees7XvxzEmray9wq0
	7hfol2oi4WOTApA==
X-Received: by 2002:a05:6000:400c:b0:430:f742:fbc7 with SMTP id
 ffacd0b85a97d-4356a0296e9mr21537226f8f.14.1768959838118; Tue, 20 Jan 2026
 17:43:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
 <20260120070555.233486-2-dongml2@chinatelecom.cn> <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
In-Reply-To: <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 17:43:47 -0800
X-Gm-Features: AZwV_QiysGGmddkZRTL8WplB-JY8oujb-hYvMvAQnmBEGpUsh1RE0Tcb7O6rnec
Message-ID: <CAADnVQLkNFDvmzmxEzVBo=C1UfcxYsO_sSaTkvwg8LCswypvWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
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
	TAGGED_FROM(0.00)[bounces-251692-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,iogearbox.net,linux.dev,fomichev.me,google.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,chinatelecom.cn:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 688724F471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 5:24=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jan 19, 2026 at 11:06=E2=80=AFPM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> > to obtain better performance.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> > v5:
> > - don't support the !CONFIG_SMP case
> >
> > v4:
> > - handle the !CONFIG_SMP case
> >
> > v3:
> > - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of i=
n
> >   x86_64 JIT.
> > ---
> >  kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9de0ec0c3ed9..c4e2ffadfb1f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -17739,6 +17739,10 @@ static bool verifier_inlines_helper_call(struc=
t bpf_verifier_env *env, s32 imm)
> >         switch (imm) {
> >  #ifdef CONFIG_X86_64
> >         case BPF_FUNC_get_smp_processor_id:
> > +#ifdef CONFIG_SMP
> > +       case BPF_FUNC_get_current_task_btf:
> > +       case BPF_FUNC_get_current_task:
> > +#endif
>
> Does this have to be x86-64 specific inlining? With verifier inlining
> and per_cpu instruction support it should theoretically work across
> all architectures that do support per-cpu instruction, no?
>
> Eduard pointed out [0] to me for why we have that x86-64 specific
> check. But looking at do_misc_fixups(), we have that early
> bpf_jit_inlines_helper_call(insn->imm)) check, so if some JIT has more
> performant inlining implementation, we will just do that.
>
> So it seems like we can just drop all that x86-64 specific logic and
> claim all three of these functions as inlinable, no?
>
> And even more. We can drop rather confusing
> verifier_inlines_helper_call() that duplicates the decision of which
> helpers can be inlined or not, and have:
>
> if (env->prog->jit_requested && bpf_jit_supports_percpu_insn() {
>     switch (insn->imm) {
>     case BPF_FUNC_get_smp_processor_id:
>         ...
>         break;
>     case BPF_FUNC_get_current_task_btf:
>     case BPF_FUNC_get_current_task_btf:
>         ...
>         break;
>     default:
> }
>
> And the decision about inlining will live in one place.
>
> Or am I missing some complications?

I think it needs to be arch specific, since 'current' is arch
specific. x86 is different from arm64.
Though both JITs support percpu pseudo insn, it doesn't help
to make get_current inlining generic.
One has to analyze each arch individually.

