Return-Path: <netdev+bounces-252464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BStIDlfcmnbjAAAu9opvQ
	(envelope-from <netdev+bounces-252464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:32:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA4E6B5CF
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCF4F30946AC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53FD3915B4;
	Thu, 22 Jan 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzqVgZed"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F023815DC
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101099; cv=pass; b=X3/d2yECNr0A+ljv+GFkgLg1LJo5hS7FrmoRfcFajRkIRDSdH2/KGtBlmldtwWazw2S5/WrY4bxzYDL0scX1J4KtSY0qP0bILC0tzYQf+fB8RHZvzpCbueRYZl/4tpPtECct2TzsfUfsJ8m0HukVBUhsKqTx+x06Fo8DmFewgY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101099; c=relaxed/simple;
	bh=lPbyE5HVBGcvAtveEW567s0jPq8xfXpiKG2oyWYcLWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxHfozIKnKpReil7TwGuoLJb+0abr0JwrVguATq/TiDNJECCEQbyv4gb2s2IX7qQQmrcxpnm9HOcG7df4NKYqUJawCi2eJbTS5mN0DQ79CV2qZcbC7Ht2c5zr78DeKWKCyx/0Ph4y3Ng6xxTmJELOWBL8mS7LBB/U+BOj1l/WYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzqVgZed; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81f46b5e2ccso823081b3a.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 08:58:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769101090; cv=none;
        d=google.com; s=arc-20240605;
        b=G85IUkE1FfUySbyROwBT6bZkARqKK/U7sEjg6cqRuu+WJDwxW/5th5ouMImvXGyCzV
         1nnqhjPUiX4cTYQe3C19uf2T51ANmnTmNTfAgeumornxrcgfvNrw9Puw16PU9KPhUSyc
         6Inmq0gsKkqZlqb3CTVUJt2rcxO+/c0mO0+tC5Xj51zlIuXR2bq6ITc0HUMaH+ddyCHA
         6jnffsOBAdYlQmsHElxXUMd/YIoAVHKZLB0zBtR6vFCTWtTrbugPp7bPOt85UAm7AL3F
         xzVEjcVjGkEzBgfNRq/RD2b7/qlyth7Wku4JPVIkiOtj+ZpqhOxWG9ZEExcK3eUiTbgD
         rM7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dlYWNytdbLuoBlz0DkwQwH1hWCGIcWrpH4X6lCzbbyI=;
        fh=sWaf41cVSUnRYzFXWIkstdpExxMHyU8zL/1yhtmwCXg=;
        b=k3SYgfuAMaX9bBowkL4twEUlLPB9YJvxYUmGjHFCcknyXScoUXSldjSFKlUnwVOiLz
         zscl/C6QqJSDTiNB2fKpf/kUZeXmYn4dAS98cqk0SNQjM2r4I482XRRxt/fu/bq7cT1G
         woggjx0ALzn6N62SULvmXy3QT1kPYvzGL7pWKxSNpK3QsMRU0A3LXUdtaovckcfER/3U
         VOWrc7hOUV1fnJBUfoC7A3gS/qI4+QoadYRkqMDTBp6Z8NTjMfX/IXkg/vNEmlhjTg27
         qTlzxSlfe8JpF0LUQxYMOXvGDpTvKvNi/o1mFZoW1B3rmlYTkRTmZKeBtSYRnjR52OUK
         Wkeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769101090; x=1769705890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlYWNytdbLuoBlz0DkwQwH1hWCGIcWrpH4X6lCzbbyI=;
        b=ZzqVgZedBew0uyeV0+NQjzrc6f5h4n9eH/ovrUrtnL8qLTqkG/xyQV1NvHYRu68jKT
         bFX57csUEIa0F9HKG5v+bMCwVe8zuABF7Ixxize7SiggwydNr9/e4Oda+U3D/SL02u7h
         5wMaeaBnfKYlgMNLxPrXoPPtee4epX4LOyakAUWWhYXsMgI1SR5WKsru6dCsJr1l26ON
         wYPMlHOzg2EEn94TidVBjp9qcs+9gcCAcgYkv76DXx0bJfJ09sAPoM/cD6EuEyocr94m
         39J7o9O+kaRWh1PeQKexOeSAPFdbIVYjgITIailgDx71I08gL+ymG6IPjbNIT1/wVe9k
         scWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769101090; x=1769705890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dlYWNytdbLuoBlz0DkwQwH1hWCGIcWrpH4X6lCzbbyI=;
        b=RjlHnPSMEg4LkYpmppHvMyp48xMxnexV+vAb4xDj3o+WHsJ8y39cx/n1rVy5/rGUpP
         jDqHlVzOySgIGoEXnj5267izPLwkj2w4QEd7ydxj+5mVzoYTJjq8qRIoRDJWQjPtCGdC
         RTh28NJdOUmrrvPlsXgyjnoUTIa+4a89jL7qx8tDUw3TeLbZCp3oldpD+9Gl0JQyigyU
         mfQHLVcbbldY/JFB1GBVy2Be07Y58CR/nseItTj6dmUOtBYCyM420/6837BeV0GGI/zv
         YbTjE6fX1uwAEaGLElaLvC9taEZhc1RXdRZZ25eGTAc1P5cwzaUiJEfvV5wm5H364hpP
         Ektg==
X-Forwarded-Encrypted: i=1; AJvYcCWWqBil4JtsuSqvYuWzhUfM4nDyu4weR9/UF8+LGCtYW2KHnGfKJHfElpb1xCruxrgsY2KFw+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0/I8t+HBN2GiW3kX4B3hDDknKd+B5R+FlZZFxYSBlJYqN5Hv
	rc6qZ0G/h5ByaiTGDXq1VUlFNVpl/lxOv2wwHlHfhseI0XPTJr9I/R+7h4nr1UvBNK34YFGTZl+
	U9p2Oe4O/7kg9KxRaXrbBPe2o+sfKNtw=
X-Gm-Gg: AZuq6aKyKJnfIJPpzi4GjMvtKWMNLQy7zxgqZRSsnqsasxcNTi9z/pw1edWHmvdu1iq
	PKxTOLaepWY5iT/ePmsU/T7bcNSK1J+8V2scG+sCyxxD9Eb0u75B/z0ZVywZXWdAYmnOpU/fSnz
	ziNfrP89srd1AihQC7T/e1ZulK0wgfhI6uJAxJ3+HN90p1wk1/E1BNVElccDw7PY9oojDOrHr6A
	PFqTK51aJhITWmnatE9tJ3yxMBOIeNzzzj96Om6uHJP9yN2dEDFBSjMp0VU52nqWAcV48wu+t3S
	YUVjt8/KHN8=
X-Received: by 2002:a05:6a20:d80d:b0:38d:657f:7d9d with SMTP id
 adf61e73a8af0-38e6f823b2fmr243279637.75.1769101090077; Thu, 22 Jan 2026
 08:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
 <CAEf4BzYop1GT1v7qxNQi44dsEebjwnLp-sHDp-HPzVrj69WzTw@mail.gmail.com>
 <CAEf4BzZm5uenrYO3ZXiGB8qXCg67Ov7crNvZtsj=Be4XEm6OpQ@mail.gmail.com> <3026367.e9J7NaK4W3@7940hx>
In-Reply-To: <3026367.e9J7NaK4W3@7940hx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jan 2026 08:57:57 -0800
X-Gm-Features: AZwV_QjPBQw-apRLcGe2OrHL4UUNo4YK_kjv4s9fPB2irHVYsQr_3qH8dSMkPr4
Message-ID: <CAEf4BzYR87Tpp4=UXBe=_A50kfZsAh1b8P__wmNU_4tKo5LqHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 07/12] bpf,x86: add fsession support for x86_64
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252464-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,chinatelecom.cn:email,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECA4E6B5CF
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 6:41=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2026/1/22 08:22 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > On Wed, Jan 21, 2026 at 4:06=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Jan 15, 2026 at 3:24=E2=80=AFAM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> > > >
> > > > Add BPF_TRACE_FSESSION supporting to x86_64, including:
> > > >
> > > > 1. clear the return value in the stack before fentry to make the fe=
ntry
> > > >    of the fsession can only get 0 with bpf_get_func_ret().
> > > >
> > > > 2. clear all the session cookies' value in the stack.
> > > >
> > > > 2. store the index of the cookie to ctx[-1] before the calling to f=
session
> > > >
> > > > 3. store the "is_return" flag to ctx[-1] before the calling to fexi=
t of
> > > >    the fsession.
> > > >
> > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> > > > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > > > ---
> > > > v10:
> > > > - use "|" for func_meta instead of "+"
> > > > - pass the "func_meta_off" to invoke_bpf() explicitly, instead of
> > > >   computing it with "stack_size + 8"
> > > > - pass the "cookie_off" to invoke_bpf() instead of computing the cu=
rrent
> > > >   cookie index with "func_meta"
> > > >
> > > > v5:
> > > > - add the variable "func_meta"
> > > > - define cookie_off in a new line
> > > >
> > > > v4:
> > > > - some adjustment to the 1st patch, such as we get the fsession pro=
g from
> > > >   fentry and fexit hlist
> > > > - remove the supporting of skipping fexit with fentry return non-ze=
ro
> > > >
> > > > v2:
> > > > - add session cookie support
> > > > - add the session stuff after return value, instead of before nr_ar=
gs
> > > > ---
> > > >  arch/x86/net/bpf_jit_comp.c | 52 ++++++++++++++++++++++++++++-----=
----
> > > >  1 file changed, 40 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_com=
p.c
> > > > index 2f31331955b5..16720f2be16c 100644
> > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > @@ -3094,13 +3094,19 @@ static int emit_cond_near_jump(u8 **pprog, =
void *func, void *ip, u8 jmp_cond)
> > > >
> > > >  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> > > >                       struct bpf_tramp_links *tl, int stack_size,
> > > > -                     int run_ctx_off, bool save_ret,
> > > > -                     void *image, void *rw_image)
> > > > +                     int run_ctx_off, int func_meta_off, bool save=
_ret,
> > > > +                     void *image, void *rw_image, u64 func_meta,
> > > > +                     int cookie_off)
> > > >  {
> > > > -       int i;
> > > > +       int i, cur_cookie =3D (cookie_off - stack_size) / 8;
> > >
> > > not sure why you went with passing cookie_off and then calculating,
> > > effectively, cookie count out of that?... why not pass cookie count
> > > directly then? it's minor, but just seems like a weird choice here,
> > > tbh
>
> Hi, Andrii. I think you misunderstand it here. The cur_cookie is not the
> same as cookie count. The layout of the stack looks like this:
>
>   return value  -> 8 bytes
>   argN          -> 8 bytes
>   ...
>   arg1          -> 8 bytes
>   nr_args       -> 8 bytes
>   ip (optional) -> 8 bytes
>   cookie2       -> 8 bytes
>   cookie1       -> 8 bytes
>
> So if the bpf_get_func_ip() not used, the cur_cookie is exactly the same
> as cookie count. But if it exist, they are not the same.
>
> The location of the cookies is independent from the context, and the
> cur_cookie, which is the index of the current cookie, don't rely on cooki=
e
> count too and can be bigger than cookie count.
>
> PS: the location of "ip" should always laid before the nr_args, as we get
> it with ctx[-2]. Maybe we can optimize it later. We store the index of
> the ip the func_meta too, therefore it is independent from the ctx too.
> Ah, it looks not make much sense ;)

no, it makes sense, I missed that we have this optional ip stored,
which changes cookies offset. So let's leave everything as is.

A thing to consider for the future would be whether it would make
sense to have dedicated ip slot on the stack regardless of whether we
use bpf_get_func_ip() or not, just not fill it out if not necessary.
That would fix offsets and make things a bit simpler. But as I said,
just something to think about, no need to change the logic right now,
I think.

>
> > >
> >
> > consider also just calculating cookie count out from bpf_tramp_links?
> > would that work? Then "func_meta" would really be just nr_args (and
> > I'd call it that) and bool for whether this is entry or exit
> > invokation (for IS_RETURN bit, and maybe we'll need this distinction
> > somewhere else in the future), and then invoke_bpf() will construct
> > func_meta from scratch.
> >
> > It's relatively minor thing, but as I mentioned before, it's this
> > hybrid approach of partially opaque (from invoke_bpf's POV) func_meta
> > which we also adjust or fill out (for cookie index) is a bit of a sign
> > that this is not a proper interface.
>
> Yeah, the current approach is indeed not perfect. But I think it's
> a little not flex if we construct the whole func_meta in invoke_bpf().
> For now, we need to pass nr_args, is_return, cookie_off to it. And
> we need to add more function arguments to invoke_bpf() if there
> are new flags occur in the feature, which is not convenient, right?
>

I think at some point we should just collect all those different
arguments into a small on-the-stack struct and pass it as an
"invocation parameters" argument. That way we'll have properly named
arguments (struct fields) and we can easily have some defaults
skipped, if necessary. But again, just something for the future to
ponder. Just resubmit your patches as they are right now.

> So what do you think?
>
> Thanks!
> Menglong Dong
>
> >
> > >
> > >
> > > >         u8 *prog =3D *pprog;
> > > >
> > > >         for (i =3D 0; i < tl->nr_links; i++) {
> > > > +               if (tl->links[i]->link.prog->call_session_cookie) {
> > > > +                       emit_store_stack_imm64(&prog, BPF_REG_0, -f=
unc_meta_off,
> > > > +                                              func_meta | (cur_coo=
kie << BPF_TRAMP_SHIFT_COOKIE));
> > > > +                       cur_cookie--;
> > > > +               }
> > > >                 if (invoke_bpf_prog(m, &prog, tl->links[i], stack_s=
ize,
> > > >                                     run_ctx_off, save_ret, image, r=
w_image))
> > > >                         return -EINVAL;
> > >
> > > [...]
> >
>
>
>
>

