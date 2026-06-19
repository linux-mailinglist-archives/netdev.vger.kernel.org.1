Return-Path: <netdev+bounces-300591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /XU4DHe/NGp0gAYAu9opvQ
	(envelope-from <netdev+bounces-300591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:03:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1836A3B79
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:03:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C9pMEGVX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300591-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300591-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BD70307AFD3
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 04:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23204328635;
	Fri, 19 Jun 2026 04:02:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1C31E107
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 04:02:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781841733; cv=pass; b=kUBsJfvevbfkQ3m9CYiDYDr+uQ9awEEHzjuMtyPs50ARdHjnwC90YH0h11UXF2DfjzOPNR+i+teR77GQWcenozUVhYRd6bRIcObpmrIEaSDyqvW9I5jF2Tw4RL5PtWrmRXUKMDHP8AwPQPPbgODgrjUOOq9eNvxJEIaqiaq9TDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781841733; c=relaxed/simple;
	bh=SrmVCuE0z2A60bEwTGx2vI1HOCDindP1Sg+9lAI0ufY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMUm+47Oxqm+DivaBqRn6WQaLYB5MtKtHcGsPpOtpbeQD4xAsk3kumAc1wfuGg2fT84iMVPUu/YneaXeRXdEi33QiSmqzdAiWT/o5Mv0RoawDGnADPuw7BRrACJvBX9SaPQ+T1ZteRtLFg7aCUOs5AUv92SjHU/0PE9NnrJSTQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9pMEGVX; arc=pass smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4922244f7c7so13419595e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 21:02:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781841730; cv=none;
        d=google.com; s=arc-20240605;
        b=AJCKA7Khb8JG/fb9zlgnSUxZc+AOHsFG2ShSyEdBCNzCymEA5oI/2Lug1OKrkr3N1N
         ZsPteQg4o9MQFsL2dxaHLjCXifSorK2dHnLyR58ZUtUr+cxpYHMlovnZOvMkPBfd2/WA
         LfxZ2LwkPykKYhXZ3pRNCP8yjpOH7y1UWnx3Dy8ooe582b7tSYBpfTFjfrxt67/Zv7GB
         NjA53DbQOiABTPzqJx0lO3bT5NF+ajmTixPJ0VOvZVdUZc2rQW4cvJKMNaUeOt0lx+qo
         urG9aJVJXdoB9UoYunjjKRORyTVuXJ0Q/pEwQChyrRGw6A6STxw5tPiBICP9UR+MMhV5
         YMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4J7Oj3rQ90qWkUx3SPFCrLpqO7hYMcDVBOpscrXdscU=;
        fh=d1ui7b/IB5feP1lX6qti26Wv0x8Y+XVHY9L5yossyfc=;
        b=SbKkWlm1PohyCDR+EBfswm5hVD7vZBePyaEnb1oEkfUL6yK/22X1ixMkqTUmx5inMi
         34HGMol3bDPXHCr98oX1QB3lNpHGJe1KfeZjqhSYj4qdxKJMrHQRE+W/QUHPFzzp/YYH
         t/VU0VkfglLk8KBNhflry3TeuqGw/FvOSpj+ct/eV62Whg6NaYstaF1r8jS7vGkaGefU
         QkHs0nBk6AVWvDwi1PD8Lk8CyMG6Fn6Zq4dJunXdxfhYqjwzLjtpdwRF64cixB5/xy91
         kIG6WKf2GYjodskJNn6SfsuwHv2y6dxc1GrA+5iIU7Jv+HPyrM6BoKFH6r18vdLooeAK
         Tn+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781841730; x=1782446530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4J7Oj3rQ90qWkUx3SPFCrLpqO7hYMcDVBOpscrXdscU=;
        b=C9pMEGVX4hivZfVg1Oz74LLyaOMRiVCS70aR94ntPVsyeM4AtkVbhhwdiVTioCWUKt
         5MN0jtsNBr+WuOdnJLBaWyTW2SHn/m/kNmvChXLcctTzxi+eEe5EbD2Ky+nTTyg64jc3
         e75Q4h0geARrFSY2+74G8DSGKqpEmpY4UanUjyofGI3KwrepLbqXd+xHk8npuDJGgZc+
         LrGMAE4krntE7+j7d2cnWrZM3CKhDiSe73k3iPbFUkqVKWaaM+y1i2yzSBUW5E1GpfOi
         Mb9Uhwnq/Z+ZKpLVDIzh8ZSrh3dg1Iy3Igz6yuFMPn8SaFFoh0Xqa/mNAnG7Y+piQWao
         J0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781841730; x=1782446530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4J7Oj3rQ90qWkUx3SPFCrLpqO7hYMcDVBOpscrXdscU=;
        b=BjCqboHwo0en41juUZQNFuS3wIQqyr6kgQc2qqUTGHqOKSufjkrZKuylqrFMVMeHNL
         B9VgVVmxuEx4fLN8vEEZ7dSiBIPiLCcLcbTveMOO8nU4SeKFDPon8XfpQ3Hd4QdYN9GG
         u09DIM1sAMjfKtpsFzrF0RkXbmUCFNje6bwGgBg3NHixfaoB8svjLWm4TDSVdQbC+k9I
         zGKLtfr2nsYMb1p2AGorHtY4aWos3GNE8AAOLoNvhiVISDoAwMdtHq+SUvBzwZNjsBRX
         hDRa+reFFdQSnfYHajR2a+jGDT7+CDTygMdAyNF953qujlH9qdt8Mb3RnnNotZB+IpKo
         gK1w==
X-Forwarded-Encrypted: i=1; AFNElJ86DFy3j4s3ER2m/JWtJpPGmYygD/s0+0C0lMPo39e/7mhshx8TSbWrZbRPE3kgZ1JHo1OKFVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZgLnR6HQlc0/O/7tOzM19ITKCwIh8ZVywLvO223TgDxitxCEk
	fhKzovbj4++R48vw9pMhjSB+7OTrIlSULVfB9YrtRFckNqN9DFzrc22OZCFxOAPHG5oAJMbRDq/
	KgUNu7OetRYqNuGiWg/gct2LQwUlyMjQ=
X-Gm-Gg: AfdE7ckaGsL5hNJY/MkUKQ5JnX5w6iP0GXuW6oHiAohKZTO4H5qLuWCkHKcfyAODZl3
	0v/LFoyJGftS7QSWC+VpB+AnNpDg5ZVkK+VFJcjyrtNpBMIBfzD+CPDnr9xS3Mpg1RpDOpxNV7h
	+RgjjUwTlpNCN9ekDFbEpbgI1fZ1SScSg1b4/MpY3ZBXeRItFxdid/Zxip/K9+T5w6/odoEXnon
	fwPzPlwlB0dCa8xsjww3ZV4Hwl8o+80sU6HlsXEMsDTOSvHPieYUVidWyIGWd889cuA5GdZO7b9
	DgmPF7BgU72Acs3PKURR29qZUVxybg==
X-Received: by 2002:a05:600c:1552:b0:492:1e36:4271 with SMTP id
 5b1f17b1804b1-4923f5a3015mr33871615e9.37.1781841729565; Thu, 18 Jun 2026
 21:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781194510.git.jt26wzz@gmail.com> <7f27d335fa6280d5eb04e7b27a7e3d7e7ac1d641.1781194510.git.jt26wzz@gmail.com>
 <ajDiLjjSYPp5p7KF@u94a>
In-Reply-To: <ajDiLjjSYPp5p7KF@u94a>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Fri, 19 Jun 2026 12:01:57 +0800
X-Gm-Features: AVVi8CfIxnV6GRS_uMsP3TeXzLkxWVmYY9cT2iPjdN2Mvfo3khN1rli6Wc4V29s
Message-ID: <CALgi0XkEqMdawDeU5ewz_uzyweMd7XvhPbNt_qQNd=KCZYziqg@mail.gmail.com>
Subject: Re: [PATCH stable 6.6.y v3 1/4] bpf: Track equal scalars history on
 per-instruction level
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, menglong8.dong@gmail.com, eddyz87@gmail.com, 
	stable@vger.kernel.org, mykolal@fb.com, tamird@kernel.org, 
	Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:shung-hsi.yu@suse.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:sunhao.th@gmail.com,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,m:sunhaoth@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300591-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,fb.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E1836A3B79

On second thought, I'll drop the cnt =3D=3D 1 reset (and the matching cnt >=
 0)
and follow upstream's cnt > 1 in v4. It gives no benefit over upstream, it
only adds the corner cases the bot flagged. And The other two points the
bot raised (clearing id on overflow, collecting src/dst twice) are upstream
behaviour, so I will keep them as-is.Thanks for the pointer.



On Tue, Jun 16, 2026 at 1:51=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Mon, Jun 15, 2026 at 12:58:38AM +0800, Zhenzhong Wu wrote:
> [...]
> > +/* For all R being scalar registers or spilled scalar registers
> > + * in verifier state, save R in linked_regs if R->id =3D=3D id.
> > + * If there are too many Rs sharing same id, reset id for leftover Rs.
> > + */
> > +static void collect_linked_regs(struct bpf_verifier_state *vstate, u32=
 id,
> > +                             struct linked_regs *linked_regs)
> > +{
> > +     struct bpf_func_state *func;
> >       struct bpf_reg_state *reg;
> > +     int i, j;
> >
> > -     bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > -             if (reg->type =3D=3D SCALAR_VALUE && reg->id =3D=3D known=
_reg->id) {
> > +     for (i =3D vstate->curframe; i >=3D 0; i--) {
> > +             func =3D vstate->frame[i];
> > +             for (j =3D 0; j < BPF_REG_FP; j++) {
> > +                     reg =3D &func->regs[j];
> > +                     __collect_linked_regs(linked_regs, reg, id, i, j,=
 true);
> > +             }
> > +             for (j =3D 0; j < func->allocated_stack / BPF_REG_SIZE; j=
++) {
> > +                     if (!is_spilled_reg(&func->stack[j]))
> > +                             continue;
> > +                     reg =3D &func->stack[j].spilled_ptr;
> > +                     __collect_linked_regs(linked_regs, reg, id, i, j,=
 false);
> > +             }
> > +     }
> > +
> > +     if (linked_regs->cnt =3D=3D 1)
> > +             linked_regs->cnt =3D 0;
>
> This part seems new, not found on the original commit, and also not in
> bpf-next. Can you add some more explaining (in the notes before your
> signed-off-by) regarding why this is needed?
>
> > +}
> [...]
> > @@ -14704,6 +14899,21 @@ static int check_cond_jmp_op(struct bpf_verifi=
er_env *env,
> >               return 0;
> >       }
> >
> > +     /* Push scalar registers sharing same ID to jump history,
> > +      * do this before creating 'other_branch', so that both
> > +      * 'this_branch' and 'other_branch' share this history
> > +      * if parent state is created.
> > +      */
> > +     if (BPF_SRC(insn->code) =3D=3D BPF_X && src_reg->type =3D=3D SCAL=
AR_VALUE && src_reg->id)
> > +             collect_linked_regs(this_branch, src_reg->id, &linked_reg=
s);
> > +     if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id)
> > +             collect_linked_regs(this_branch, dst_reg->id, &linked_reg=
s);
> > +     if (linked_regs.cnt > 0) {
>
> Same here, the original commit and bpf-next has the '> 1' conditional,
> where as your has '> 0'. Can you also added some explanation on this
> part?
>
> > +             err =3D push_jmp_history(env, this_branch, 0, linked_regs=
_pack(&linked_regs));
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> ...

