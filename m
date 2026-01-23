Return-Path: <netdev+bounces-252987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEYMFej8c2mf0gAAu9opvQ
	(envelope-from <netdev+bounces-252987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:57:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7365C7B4F4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC9E8300B9FF
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490792857F6;
	Fri, 23 Jan 2026 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW7fHD/w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66041643B
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769209056; cv=pass; b=LSrdNqBelrNUKfem2/uvqmkrwOHzV/BM4bGq2dtkBvaAVT0KfXiNMQfqTLuvLYxsx6h3MM4nokzM6o2XWLfQFQYx1DkH+ERXId//gfriDgnmk+QRZC6esOhAiNf0n0QxWA8S7nfxk9uNEVUAYMB1xq5JMl3A04ukP7vZLLYl9e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769209056; c=relaxed/simple;
	bh=6v4rZ9oJpz8LUKiLodEbEuxsY/ZrUiOquPogvNms0iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww5yHxF7j57DmegEPJ5YehSFGAP0cm2C8VhTybkRa/9om6MSlYPM9VkXsM0uCA97vtJJaMbj3NoZv0fd3BDAiFqIpUGs67EtZNFCuMhl45s77lHe2VZYJfyvC1UpmFVaKThzLeuZrNaLuZpW3XUWVkv0Rv3Tg+r97qnfGPOhgYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XW7fHD/w; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so2499360a91.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 14:57:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769209054; cv=none;
        d=google.com; s=arc-20240605;
        b=MdoFEuGhZsJwWr/6NcTMph3VAqyMXdiEgBYtvlmKmYuxumCEomDSl8B+LCNMFsREU4
         lwipE3CMFDUVLBftd/gmEz2zU0xSkglL5LFgb8kqR14wavC42M9Ha6hITEGh3u0gkFGU
         yXu+1Vr6Ljopl+PSDsnY77ArH6VmW0lapyFz9jh3QjL3kgQQJS8kZt+0yKlxfG/iy7P9
         jwk8dscTpa0PEyxzXOZxU0nQuPxZJLAjeF8uuAbfVxeyUAJvHwjm3Us6CV4Z2tN3gMLh
         vkj2GjvE62hpbBiARPh8PfzAJOD1fc+D8pX9xETB8IwQfO4dZoJ44Dm0ncMSOQlcrISR
         ssAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4j31uslQqJ9kDCp8Ht1kV/SN1veEZSVwfHGiVKs76y8=;
        fh=2m6iovLyWvbvtOxV6AxKWdYmHJ9DdaRHH1d1tf/yiLk=;
        b=jU+3p0NoPiQR7sozBGiLt6wsXMzC4sB9hf1rCmgU6uHgNFQ7DxzBoHuFxeLoFSCuDb
         a7xoUhiGqOlXWeArIrotff5TMLr554VmzVyCaKp7XhItmQ1Dy2EHOrHHFzxW/m/luyr6
         VJ1a9aS01czBCsXuBDcNb45zki+twtow/R+9pB0NbrIsadChrRhGMOt5NQ0OSqJahScJ
         tX8NJaMTojY8szks23u5IvfVwFtwbdm4CWMA5OjqyecKum0ZDHaGINRQbdoRJtrN8tX9
         RekJxIbJKFz2YzV8fbYfke/kY267WRqvRZznfIeGaQtB2gqPErcMpKUj2+hZfgbkgyME
         aujA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769209054; x=1769813854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4j31uslQqJ9kDCp8Ht1kV/SN1veEZSVwfHGiVKs76y8=;
        b=XW7fHD/wk8H98YWft98bmxnvQdkfV3uYiQVlHQaL+kL9Kn+SAlKGgLMCZY+vOqncT2
         c7sEQ/ZFPXH8G3eyIRTkxWjXQdxQNgfpXVaqXvj56B3hoTl9i9WMjJD0CL+Eocmx7Wl0
         SYWQXhLSj7WwsuBwbGGEWeJZcXJgMJVCVeaEBPl9A22KoDX+ynkHX2vE/0WqDEV8HN69
         7wJvt4SwMxcJa0ZOjnLfWIaLDCSaK5kzVlv4WzXmY2vsT34ezyNQsXu6spI0K5MO9YnZ
         u9JklG2P9TTavpHWaPUHA4Licl63Kf6QKi0igUo22fIEmoyCSn2NKZWGyoX2QuaCGow2
         zVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769209054; x=1769813854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4j31uslQqJ9kDCp8Ht1kV/SN1veEZSVwfHGiVKs76y8=;
        b=vVi0lExm8Ilut1nyhWJxfZ+7XtvCP8fCeZakN5+Rwe4al0KNoKIwRANZPt4M7uhcdZ
         QrQTSiuAYdzL3PZS4a+TkEw66dS7sajRo+MHXAWwMtb4odiL6L1S8GalB7DhivSU6dQW
         DWPVssQhjJ73I6zG/phxbkNLmkwHC/KA/lUM0H7OXdZdhicAGRQXCqeQHeXJ8omOfeLZ
         ebOFYs/IaDRoj/jbA+Jr+IhBh9USJE6yO5ant/Q0dLlm4xcUz0Q/ub5rTAf9pNQjF38r
         jHPB7XAc80+dqDTCjecyTWUWzOPcn0Zwj5DNN+fUvpTdlaZS91dZc002c3JNnBBZh0V3
         QK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOaqVquD29MqJ66tPOHAxfCbiul6/vpIgBE1Ghv41MVqsPyEcnwllzDUCw8BUOfTiF2DBX9OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiF9gDuPsORz5U6g6pYACRHCAKYclgqX9ewNxn5e42r7OqF35a
	51UmiyBga9vD8nF3qwAkgaTbIB7qWt3kffkfaXoMtuRfW9AOOjYu2pw1t57NHbGfvqQRN6XsTq6
	JZSuHbsdHTpDYS7z45dc2ChcyOvrMpV4=
X-Gm-Gg: AZuq6aIW65+Q5yPsXB0AwUwHrndVh9EoCrS2xMiSfIJAgStfVXeBiMz92gStjE8SJaB
	9BQ0vX5X1xXfWLUGrAWhGiDiqkQ3p8X6jqRQ2m3+dRGXaLO+4l4UEOPcqqbU7jvw08dsycdNtOn
	QgDilkypwvdzjbz70RHWTcGmMWmdyJlzYitsBz9NtGhcEAObvJOXV33Ou+kzVNNwwo/34rBobXZ
	jFrWXEbktgJglVddxBZJWzGZWlDJOlgJlSMqp29FufeleRfgcRLXCMjX8NevMDMwKEHNI9eddLa
	K6tiggwGYs8=
X-Received: by 2002:a17:90b:57e6:b0:349:9d63:8511 with SMTP id
 98e67ed59e1d1-35368c42f49mr3571701a91.25.1769209054201; Fri, 23 Jan 2026
 14:57:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123073532.238985-3-dongml2@chinatelecom.cn>
 <d91544bd4b513290bf468386c0261f913b59b761c34405839c424f8eaf8b1d04@mail.kernel.org>
 <2250332.irdbgypaU6@7940hx> <8632406.T7Z3S40VBb@7940hx>
In-Reply-To: <8632406.T7Z3S40VBb@7940hx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jan 2026 14:57:21 -0800
X-Gm-Features: AZwV_QgjtKbg3xcVVs0fXgYTWRVrke_V4VqsUfD77JrusnPTgbwxconkivavg84
Message-ID: <CAEf4BzabUj0APqROb7ibkEovoXVmxbiHq0kNAPWExpEfRmQwiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 02/12] bpf: use the least significant byte
 for the nr_args in trampoline
To: Menglong Dong <menglong.dong@linux.dev>
Cc: menglong8.dong@gmail.com, andrii@kernel.org, bot+bpf-ci@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, martin.lau@kernel.org, 
	clm@meta.com, ihor.solodrai@linux.dev
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
	TAGGED_FROM(0.00)[bounces-252987-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 7365C7B4F4
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 1:21=E2=80=AFAM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2026/1/23 16:29 Menglong Dong <menglong.dong@linux.dev> write:
> > On 2026/1/23 16:07 bot+bpf-ci@kernel.org write:
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 41bbed6418b5..b3f912ad18ba 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > >
> > > [ ... ]
> > >
> > > > @@ -23779,12 +23781,13 @@ static int do_misc_fixups(struct bpf_veri=
fier_env *env)
> > > >                       eatype =3D=3D BPF_MODIFY_RETURN) {
> > > >                           /* Load nr_args from ctx - 8 */
> > > >                           insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_R=
EG_0, BPF_REG_1, -8);
> > > > -                         insn_buf[1] =3D BPF_ALU64_IMM(BPF_LSH, BP=
F_REG_0, 3);
> > > > +                         insn_buf[1] =3D BPF_ALU64_IMM(BPF_AND, BP=
F_REG_0, 0xFF);
> > > > +                         insn_buf[2] =3D BPF_ALU64_IMM(BPF_LSH, BP=
F_REG_0, 3);
> > >
> > > [ ... ]
> > >
> > > > -                         cnt =3D 6;
> > > > +                         cnt =3D 7;
> > > >                   } else {
> > > >                           insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, =
-EOPNOTSUPP);
> > > >                           cnt =3D 1;
> > > >                   }
> > > >
> > > >                   new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> > >
> > > [ ... ]
> > >
> > > >                   delta    +=3D cnt - 1;
> > >
> > > Note that the bpf_get_func_ret block above correctly updates delta af=
ter
> > > patching.
> > >
> > > > @@ -23808,12 +23811,15 @@ static int do_misc_fixups(struct bpf_veri=
fier_env *env)
> > > >
> > > >                           /* skip 'void *__data' in btf_trace_##nam=
e() and save to reg0 */
> > > >                           insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, =
nr_args - 1);
> > > > +                         cnt =3D 1;
> > > >                   } else {
> > > >                           /* Load nr_args from ctx - 8 */
> > > >                           insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_R=
EG_0, BPF_REG_1, -8);
> > > > +                         insn_buf[1] =3D BPF_ALU64_IMM(BPF_AND, BP=
F_REG_0, 0xFF);
> > > > +                         cnt =3D 2;
> > > >                   }
> > > >
> > > > -                 new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, 1);
> > > > +                 new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> > > >                   if (!new_prog)
> > > >                           return -ENOMEM;
> > > >
> > > >                   env->prog =3D prog =3D new_prog;
> > > >                   insn      =3D new_prog->insnsi + i + delta;
> > > >                   goto next_insn;
> > > >           }
> > >
> > > Should there be a "delta +=3D cnt - 1;" before assigning env->prog in=
 this
> > > bpf_get_func_arg_cnt block? When cnt is 2 (non-RAW_TP path), the prog=
ram
> > > grows by one instruction, but delta is not updated. This could cause
> > > subsequent bpf_patch_insn_data() calls to use incorrect offsets.
> > >
> > > The bpf_get_func_arg block at the beginning of this patch has:
> > >
> > >     delta    +=3D cnt - 1;
> > >     env->prog =3D prog =3D new_prog;
> > >
> > > And the bpf_get_func_ret block similarly has delta updated. But this
> > > bpf_get_func_arg_cnt block goes directly to env->prog assignment with=
out
> > > updating delta.
> >
> > Ah, good point, I think this is a valid problem. The selftests didn't c=
over
> > this case, and I think I'd better to use bpf_get_func_arg() and bpf_get=
_func_ret()
> > in the exit path of fsession to cover it.
>
> Oh, the problem doesn't have much impact. The only impact
> is that the verifier will check the "r0 &=3D 0xFF" instruction redundantl=
y.
>
> I'll see if there is more comment before I send next version.
>

Let's still fix the problem. Just go ahead and resubmit (with the fix
and improved test).

pw-bot: cr


> Thanks!
> Menglong Dong
>
> >
> > Will fix it in the next version.
> >
> > Thanks!
> > Menglong Dong
> >
> > >
> > >
> > > ---
> > > AI reviewed your patch. Please fix the bug or email reply why it's no=
t a bug.
> > > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/R=
EADME.md
> > >
> > > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21=
278745581
> > >
> >
> >
> >
> >
> >
> >
>
>
>
>

