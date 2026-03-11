Return-Path: <netdev+bounces-266556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MENZONE9sWmtswIAu9opvQ
	(envelope-from <netdev+bounces-266556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:02:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53550261AA4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41D093446B19
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A577E3D6CDC;
	Wed, 11 Mar 2026 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ickx9bIH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D573D47A1
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220958; cv=pass; b=M7IG+x/nNKJTJGdufeDZkMs5c8Um3SbEA06NpWb+pmH7GzSKiuR0sfO7YBYPZwHE8gQ+MIMAabP1eD9SlFSKp0+ZEBjIuGnDU32rgPkn8J7O5isyMXC9NTevaxtEgeS8C4nH/D4UHsYsvJNQ5lj4XeqCIGTl3Jyb9eWDBRpxQnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220958; c=relaxed/simple;
	bh=YACcX35xOsZaWzEwi+YLtodbEl58LHKv9PHt6kgvIE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEH+E3CQ2aeGzIu7c2zpDo2wEFPh5442FnOVjb5BCpG1oIuTcrKt6ls9EE5SUqcVOx8kceZf5kk0vNsrlZq3FpLMF7qxDdAAWXIc05D+OZQs7sLlOZ0YFCzR4VJ9FO52EoXI5ZhjhNH92/+pzAy8jglFNYrI+56uc5kI9lAb9LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ickx9bIH; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4327790c4e9so10863110f8f.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 02:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773220952; cv=none;
        d=google.com; s=arc-20240605;
        b=WD1o5FYueK2XjBaHF+yE0EdM+s+ZdajmdTWoy4iUTSlG/hOABEqrBymyNDNB72zOs1
         LQJtjmhtFbEl4hdPTqzF6knlh3eLzd4Rzbfx+iA0+gTBj3uxJTloGDdGG0U+r/5nkN6P
         viNLEnpeeXpZxGGCDK65ffoiJCnlg5ymZLEp3nCJ5mgLvEZj/GHGc8apI1FaTvCivN0T
         dubblnTHpLk56g9O/md5H2b8WzW1MoIRsayKu6YlPdP/ew5C3nXjkIrqEo1C52NDWdfT
         mf1Z/+jNXeYDZS660UnZXwtxCJLKQNedsRG1klLnTJRdqGZRF2SF09KVDVE5m9ZtCK3P
         PtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lFgMihWsoMtZghWDDXPtR/BAjR1Y+4atLFgxslVUViE=;
        fh=a5S8CkdhWYL3fuprEJpsov7hSu6e7D67e3SwXvyq244=;
        b=X+FqxKANSm3FX0T99adFs9Akx0b+1Q1bO/NNsEBrfmUa0ilN2X0mKsog0j5x0JpYt2
         WoKDT7yteScs9AOudRQfSQnqWlm9jVL33fXw9+tgL4QBEH0l5UXTkhTF75OkzlbSajzz
         Z1AR/q56/sImvyaa6h/VAppi3HRHNRNQCY4qlnG4fB7ypeXZDC2CGZg0cQisl0r9/6a+
         NDQpCMKcvBCLEwAxT70GJNr1Gjl2mcJtPQeYrlBP3fdMFg6WNyq8gYl3KMX8HFhXAV7R
         /Hz7PK4zPU6HvSdZUSZD9ZwPet686vWwkejUfm6/1701GrBcjsCu939uz8KXQ33aLQhO
         ChcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773220952; x=1773825752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lFgMihWsoMtZghWDDXPtR/BAjR1Y+4atLFgxslVUViE=;
        b=ickx9bIHtBU+sEi1aRGjZqo71gBfwNnWragbJ5Y8eH6yQJeAOCXmN2Cs0w4diTS98P
         fAHrLuQUe90UVcLlBnQ7IckbzDv9YyEf/SsjmvzrA4l+teUaYAT5UV/+0oqPhMP+sFTe
         Bx3o8QJABxpQrLpMey/y0vFDienmPw6fZSFBf/8AiVUV3YbWRc7K1ZcaNtJTQQnXsmIJ
         Fpsg0G2Hs0P8gzaZis4iEpH1EBHNUWzoAIpTm1HlkLUFWdPTJekar4JDGd6F8beE2d5N
         CwC2T9QKkwm8Ogr8r6qMCmzFcXwh9jPLR+K41Pg40VIbP64xQiFc92GWxhPIpA8XjUF3
         54FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773220952; x=1773825752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFgMihWsoMtZghWDDXPtR/BAjR1Y+4atLFgxslVUViE=;
        b=rmSLh7HGLMTFzzgLbbV8hSIWmNuvU01pO71nnJLWZheV2U7BFGd0hVhN7gnkK/VVrf
         kmTaYhdbyPlxaoJnIzHNCQokAx5hmbcvHTXr1NYWlpjiatfNZSB4H5YRffjq0OnDORsP
         wTlFr3ziH8IRMfQZSS6tVze299EipOdAazjbM8c5CuxXqis+NXNlsCIP6o9+VkWcD2Ge
         TDYIsKUQThMTgEMcHpCCBGMhUH3ZncxZPZfqIKtNpwu7gB3BEfyMVXedZ2CzGftXcFGE
         lgREdWt2e2tcHdtxFvZMOxu1E1lBhBfgD7a6wdSRIwcS30TvlHUqj/cKynFJkHZ/CU+H
         Xuvg==
X-Forwarded-Encrypted: i=1; AJvYcCX3aKHl82Bp5NR1zbtP0MrbT6P+95VB6QFNV72NMuGKhFqe8CZqp/5ZhhYj6UAhvAk1kNJooFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+QUIqHxD939zOy3mzH6SArrloo0eHhMnGR4MC6QvBMYJ6fSi+
	wREqPfhFOIjcBbKGhOuA/kNTBiXXepOeRDzwcBS4ZcAmfPVtWeX5trtZZrAEm3WwDQARiSstRls
	I2cPtldBelqYjwUUDhhVL2VKlY5lWeaA=
X-Gm-Gg: ATEYQzy/7uaImvcF7UZ8Hd9TAY8tZb2HHEzFTT224+ImcCVh7LkT+StmczDrZdvaTKq
	IoWfpKOsDjiP04ITxZBdckJr+FNQqSplvK29AY08Z8PLQTJ1wiHtVTwt9WRjXjMxKTet7jhpXvX
	M+KTysAZNDMLxzom48dToc14CJKLHPvhnLwVLmXGScg/1deGZ96timnRY1hmIoPaGhGrPmas/b7
	KWf9bvCp+NRaspLohy/5GkCyRinck2YToULYcM/twz+D8a43WIqwaewuhw3CG9djcNulFOIoFTO
	LW1II8Wm9aJaruW/Xdigd7G5oTwkynVRWEY/3tKIqLDErGPJJjyht046uY99
X-Received: by 2002:a5d:5e01:0:b0:439:bcc2:bf0a with SMTP id
 ffacd0b85a97d-439f81e7e25mr3490492f8f.23.1773220951904; Wed, 11 Mar 2026
 02:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303150639.85007-4-leon.hwang@linux.dev> <47fbcb9aa941b07054bfef30b802d488688fafdf6df889e78b38313a614b98c1@mail.kernel.org>
 <CAP01T74sqmUAL7=PuzFPNbghX+6N_OzrsZiOHcMEMtg01CuL4A@mail.gmail.com> <94cfdbdc-833a-4838-af84-e0989e988418@linux.dev>
In-Reply-To: <94cfdbdc-833a-4838-af84-e0989e988418@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 11 Mar 2026 10:21:53 +0100
X-Gm-Features: AaiRm50nAQdzlpHM51HW1PyT3VT1H1H64hcFybhjy9jwHkvvigOgK5QbW0gQV78
Message-ID: <CAP01T74w4KVMn9bEwpQXrk+bqcUxzb6VW1SQ_QvNy0A4EY-9Jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, yangfeng@kylinos.cn, 
	menglong8.dong@gmail.com, puranjay@kernel.org, bjorn@kernel.org, 
	pulehui@huawei.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	kernel-patches-bot@fb.com, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 53550261AA4
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
	TAGGED_FROM(0.00)[bounces-266556-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[memxor@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,fb.com,meta.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, 11 Mar 2026 at 07:08, Leon Hwang <leon.hwang@linux.dev> wrote:
>
> On 11/3/26 01:23, Kumar Kartikeya Dwivedi wrote:
> > On Tue, 3 Mar 2026 at 17:04, <bot+bpf-ci@kernel.org> wrote:
> >>
> >>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> >>> --- a/kernel/bpf/core.c
> >>> +++ b/kernel/bpf/core.c
> >>
> >> [ ... ]
> >>
> >>> +     switch (match) {
> >>> +     case BPF_MAP_OWNER_MATCH_FOR_INIT:
> >>> +             if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
> >>> +                     return false;
> >>> +             break;
> >>> +
> >>> +     case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
> >>> +             if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx)
> >>> +                     return false;
> >>> +             break;
> >>> +     }
> >>
> >> In the v1 review, Alexei Starovoitov asked for strict conformance
> >> both ways rather than one-directional validation:
> >>
> >>     "Don't be fancy. Require strict conformance both ways
> >>     in *all* patches."
> >>
> >> https://lore.kernel.org/bpf/CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM3Az197eL_0A@mail.gmail.com/
> >>
> >> The BPF_MAP_OWNER_MATCH_FOR_UPDATE case still uses one-directional
> >> matching, rejecting only !owner->kprobe_write_ctx && aux->kprobe_write_ctx
> >> but allowing the reverse.  Was this an intentional design choice, and
> >> if so, should the changelog note the disagreement?
> >>
> >
> > Let's follow the approach Alexei outlined, while the changes look ok
> > to me, let's remove the one way check and just do
> > owner->kprobe_write_ctx != aux->kprobe_write_ctx, same for the other
> > two checks. With this we can also get rid of this INIT vs UPDATE
> > distinction.
> >
> > Other than that I think patches are good, please also test both
> > directions in the selftest in next respin.
> >
>
> Hi Kumar,
>
> Thanks for your review.
>
> I agreed that both-ways check could simplify the code. But, the UX could
> not be great.
>
> Let me explain it with an example.
>
> struct {
>         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>         __uint(max_entries, 1);
>         __uint(key_size, sizeof(__u32));
>         __uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
>
> SEC("?kprobe")
> int prog_a(struct pt_regs *regs)
> {
>         regs->ax = 0;
>         bpf_tail_call_static(regs, &jmp_table, 0);
>         return 0;
> }
>
> SEC("?kprobe")
> int prog_b(struct pt_regs *regs)
> {
>         return 0;
> }
>
> prog_a is kprobe_write_ctx.
> prog_b is !kprobe_write_ctx. And, it will be added to jmp_table.
>
> With both-ways check, prog_b is required to modify regs. I think it's
> too restrictive for users to use prog_b as tail callee.
>
> With one-way-check of this patch, prog_b can be used as tail callee to
> keep regs as-is.
>
> This was what I was concerned about, and the reason why I did not follow
> Alexei's approach.

I agree but the main question is whether such a case is realistic, are
we going to have write_ctx programs tail calling this way?
Tail calls are already pretty rare, thinking more about it extension
programs are probably also broken wrt checks in this set.
bpf_check_attach_target is doing none of these things for
prog_extension = true. Nobody reported a problem, so I doubt anyone is
hitting this.
It probably also needs to be fixed.
Since you noticed it, we should close the gap conservatively for now,
and wait for a real use case to pop up before enabling this one-way.

>
> Thanks,
> Leon
>

