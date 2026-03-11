Return-Path: <netdev+bounces-266787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCUfCPbssWnIHAAAu9opvQ
	(envelope-from <netdev+bounces-266787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:30:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 974CE26AE85
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 936A4302FE9F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1225F394465;
	Wed, 11 Mar 2026 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCc3RXiJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC02392C2D
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268211; cv=pass; b=ct5iVeQmGbzsKWLdZGfYyqwTeYYnE2iLpLX8Rwcfe0uyNTtQMtpeTQQe5L6F7Jxl9TRccX9Otwxvff9G8tR+XnnRob1S5j7+yZ2SRJzDKOcZNSPbAgMHQa4TngvqBAJ5lyDYGpXV3hIknuATr0yt2cFmkINH13t4YMMP9lFupQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268211; c=relaxed/simple;
	bh=IXIsZStQj1ZtMod4DHzT83ni9ZEUj0wOPRkbFqMoz+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlBky9cjG6GQlN/aEycM3POWSIPD9jZ9pMkJo4PStNdwGM7EFP+YkM/HHG8JUJ/Of/rIZiLmJL5/6Hwftl0NU4FiInRZ8Ad32+y5QLaRGGC6Fn8n5/T8K20GgRaFnccb4ljmhzkun5H3EKy5FlbRo8eWrO1XNDGNw25Ea0DldRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCc3RXiJ; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4327790c4e9so270302f8f.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773268208; cv=none;
        d=google.com; s=arc-20240605;
        b=XPLLxH7OypA8DcPkSyF3Kujp8G7f2u+vDdYw4L7NkRNoOU9ggER8mdlobz4HbL3bu+
         fgUAWZjCq71/OCLQ7gdBFmtTCJzlFsfH0ZjKDxOgmR3cSYnUiVo3D/Hp9Sa2OgMsSxER
         o78FSwDjxkG9txCD9lk/Itftwj1oyWxrL5I4hY4x9wGyAKcUSR9fnpZOsV4fDEGZPVEF
         XEcaycKfdD0RVdRdFtdQTOl09vg/7pEmNklf+zQXOvcnXSHYPkIALGoSFf90ALo/dK95
         NJohykN4f3QS9ESpzdos7EFwKNcvpzqoQfXSEFhmudMb5VG17Ql2T30DqW59qEmbARLT
         yu6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t2wMJzrqRjTyKyYc15YSzx0VqPlss0xaMiZG9fNQoX0=;
        fh=jisdmHm2AWafSY5Me1cX34Ay9ZkIvACiUJX9pT31Tts=;
        b=j2ukDFDsbAuRQse4MEpBkcorTla7SOmgGUx/aPQqIti/YIgKbIvwcMlI8ys1FoRzyD
         gVJ9uDWRATpX6jkx566S8XnlmYkxSiV+AQrBTbMw/V8HdVZ0A+VJ8AI9kABsd5UsupLF
         VP7mONrFE017xQdWLfMug3OOvkPLzJgUcXkjDLEfct1ddNvM5cwQPN1arTeOaBPN8YG5
         HzXd+/nfP0BUFefwvuNXb632BbpsWQY5Yl8qerm0IsjrhRBv86+fmblOODhiyT9x+Flo
         OVKR8h90+0i8cWEEzbLjujca+3pyN9K6bgSHqzbOvFegl+HsZSs4IraHvn+gmWHhlQAf
         Vhdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773268208; x=1773873008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2wMJzrqRjTyKyYc15YSzx0VqPlss0xaMiZG9fNQoX0=;
        b=SCc3RXiJHC31sf4n+RB5aa5OCR7bZgrR8Kn4rgTLaDs69WuMmd53/TegI4lwLNYtx5
         0vSWjHh+myEoWtriTW51h3Pl4vEJz7eiFS444f/GdVWVudcUP+eXr2hGBxRJbwJ1dmlj
         cgKbNc4w5JJRPqUZRL60p+IH4W46e1nhcr6AZD+YzS7CGr2DzdtH1rSMI+WzDsAGjaru
         fiRfdzmrOCQyQ3VDXbj5oN4y0yHpoLwjCsF4b8NCBof3BB1lDfWP8NKgvJcVLWKZubTi
         GEFSoc5etWbrcs7yhrWfVpoAWD/LafIjZg8Y7igxuG2LbCb8DNf1L213sLEmlno6bY3L
         23LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773268208; x=1773873008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t2wMJzrqRjTyKyYc15YSzx0VqPlss0xaMiZG9fNQoX0=;
        b=UG048p9axcOF4M5J0OXEBxoQAqgWxlDaL0B164iyofuxpU/3yQ/6kg9tpmps9f5IP5
         dl8p4ttp69o5eusj2rvkaHhp5Urr6ueWS0iU8L5oOdRYQxhbpMn09ltbFmkc4saqqEo4
         tDnLV8e/iuAmJnh/Z09efPgE5+gokQB/dyD4+DHbO87v2BNmbYJ/Bby8guelnsubg8SW
         8sj0PrFwnhlQMccnw5ppR2nSJo/flBlvt/9+/K/hKbLTw4l4OYCOnuaqSefqA6rD52Yo
         Hf1asigiOIBEaHDGeO0Wf7Sw19Y27WI7cVHmkP8aXLsaPAodLI41Ge4mo9VwfWgEmgV+
         /M6A==
X-Forwarded-Encrypted: i=1; AJvYcCV4OXeYgSd9u3DPDp7bMsvT56EZwKHuCTB0QNJnbawVyUwMJ2rXL41AxniR7A3LcBB4uXyovv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzYDxBmc/eXyeJA6doE8hr1v4zmpuho5ttOkeL9lQL+0nTVBN2
	Mhd6E7WgbI5j4byAO0/BgZbvNxm+4t2fxUtXDr7d2QStwNXdR/r98ewbsy1I9G7dziQEGYR+EPS
	Oq4QYmhetCZZLNt6YvLrGAoCRy4ihNjc=
X-Gm-Gg: ATEYQzzfmQhOeH7r4Hph7ywgJd2xEyHqfvvjdlUzFJcPQryH5fIA92WN0Lp9TqEjXIy
	wg+FEW7SLAx/k3ZNN5lYQPHQxtIptUQBCqj9xa9FH987b0XfFEO12go4s76RT2a1Ka54ZpJzBwD
	yZcCA9ROGInPSZTCP9u/UmN1bYFkj/cbQ3TmrHYS3+4buwggmox/V4WYs+AI+GXIrFXW8JWfyhF
	bbTofhIRsy5pN0vv898hyNUH5uULtq9J6NV4nJHkCERtB/ij4CqEPhtaBfe7dCGg0qVx1Qd1cPa
	VV6Xg4NTA9xOnc5OJC2s0W5h1lf4RlxbznstcVmcK29zPv0qyyHz6ajrPawkHXL2MqcRXOkatIv
	a/83PR40hvo564Nb1MiDUfTfDTw==
X-Received: by 2002:a05:6000:22c8:b0:439:c14b:2100 with SMTP id
 ffacd0b85a97d-439f81df102mr8608515f8f.12.1773268207904; Wed, 11 Mar 2026
 15:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-6-ameryhung@gmail.com>
 <CAADnVQKkXKyqqW5zFC+N2NaU+7wD1XouqF9T=ReNivCKDWcFiQ@mail.gmail.com>
In-Reply-To: <CAADnVQKkXKyqqW5zFC+N2NaU+7wD1XouqF9T=ReNivCKDWcFiQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Mar 2026 15:29:56 -0700
X-Gm-Features: AaiRm51DVyipjj7ZjH8JPjlowS7QMe6j_IWZpgC279CIhJmlDmGjVule2JCDSF4
Message-ID: <CAADnVQLCKi_QL1FeybW+6MH6FAOAoRJyW06UvtX3my3yNSH5eQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 05/11] bpf: Preserve reg->id of pointer
 objects after null-check
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-266787-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 974CE26AE85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 3:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Preserve reg->id of pointer objects after null-checking the register so
> > that children objects derived from it can still refer to it in the new
> > object relationship tracking mechanism introduced in a later patch. Thi=
s
> > change incurs a slight increase in the number of states in one selftest
> > bpf object, rbtree_search.bpf.o. For Meta bpf objects, the increase of
> > states is also negligible.
> >
> > Selftest BPF objects with insns_diff > 0
> >
> > Insns (A)  Insns (B)  Insns  (DIFF)  States (A)  States (B)  States (DI=
FF)
> > ---------  ---------  -------------  ----------  ----------  ----------=
---
> >      7309       7814  +505 (+6.91%)         394         413   +19 (+4.8=
2%)
> >
> > Meta BPF objects with insns_diff > 0
> >
> > Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (D=
IFF)
> > ---------  ---------  --------------  ----------  ----------  ---------=
----
> >        52         57     +5 (+9.62%)           5           6   +1 (+20.=
00%)
> >        52         57     +5 (+9.62%)           5           6   +1 (+20.=
00%)
> >       676        679     +3 (+0.44%)          54          54    +0 (+0.=
00%)
> >       289        292     +3 (+1.04%)          20          20    +0 (+0.=
00%)
> >        78         82     +4 (+5.13%)           8           8    +0 (+0.=
00%)
> >       252        320   +68 (+26.98%)          21          27   +6 (+28.=
57%)
> >       252        320   +68 (+26.98%)          21          27   +6 (+28.=
57%)
> >       119        126     +7 (+5.88%)           6           7   +1 (+16.=
67%)
> >      1119       1128     +9 (+0.80%)          95          96    +1 (+1.=
05%)
> >      1128       1137     +9 (+0.80%)          95          96    +1 (+1.=
05%)
> >      4380       4465    +85 (+1.94%)         114         118    +4 (+3.=
51%)
> >      3093       3170    +77 (+2.49%)          83          88    +5 (+6.=
02%)
> >     30181      31224  +1043 (+3.46%)         832         863   +31 (+3.=
73%)
> >    237608     237619    +11 (+0.00%)       11670       11671    +1 (+0.=
01%)
> >     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.=
02%)
> >    237387     237407    +20 (+0.01%)       11651       11652    +1 (+0.=
01%)
> >     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.=
02%)
> >      8103       8108     +5 (+0.06%)         459         459    +0 (+0.=
00%)
> >      8076       8079     +3 (+0.04%)         457         457    +0 (+0.=
00%)
> >      8177       8197    +20 (+0.24%)         459         460    +1 (+0.=
22%)
> >      8083       8086     +3 (+0.04%)         458         458    +0 (+0.=
00%)
> >    237608     237619    +11 (+0.00%)       11670       11671    +1 (+0.=
01%)
> >     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.=
02%)
> >    237387     237407    +20 (+0.01%)       11651       11652    +1 (+0.=
01%)
> >     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.=
02%)
> >      8103       8108     +5 (+0.06%)         459         459    +0 (+0.=
00%)
> >      8076       8079     +3 (+0.04%)         457         457    +0 (+0.=
00%)
> >      8177       8197    +20 (+0.24%)         459         460    +1 (+0.=
22%)
> >      8083       8086     +3 (+0.04%)         458         458    +0 (+0.=
00%)
>
> The table is missing names.
> State columns can be dropped instead.
>
> > Looking into rbtree_search, the reason for such increase is that the
> > verifier has to explore the main loop shown below for one more iteratio=
n
> > until state pruning decides the current state is safe.
> >
> > long rbtree_search(void *ctx)
> > {
> >         ...
> >         bpf_spin_lock(&glock0);
> >         rb_n =3D bpf_rbtree_root(&groot0);
> >         while (can_loop) {
> >                 if (!rb_n) {
> >                         bpf_spin_unlock(&glock0);
> >                         return __LINE__;
> >                 }
> >
> >                 n =3D rb_entry(rb_n, struct node_data, r0);
> >                 if (lookup_key =3D=3D n->key0)
> >                         break;
> >                 if (nr_gc < NR_NODES)
> >                         gc_ns[nr_gc++] =3D rb_n;
> >                 if (lookup_key < n->key0)
> >                         rb_n =3D bpf_rbtree_left(&groot0, rb_n);
> >                 else
> >                         rb_n =3D bpf_rbtree_right(&groot0, rb_n);
> >         }
> >         ...
> > }
> >
> > Below is what the verifier sees at the start of each iteration
> > (65: may_goto) after preserving id of rb_n. Without id of rb_n, the
> > verifier stops exploring the loop at iter 16.
> >
> >            rb_n  gc_ns[15]
> > iter 15    257   257
> >
> > iter 16    290   257    rb_n: idmap add 257->290
> >                         gc_ns[15]: check 257 !=3D 290 --> state not equ=
al
> >
> > iter 17    325   257    rb_n: idmap add 290->325
> >                         gc_ns[15]: idmap add 257->257 --> state safe
>
> I'm not following. The verifier processes above as a bounded loop.
> All 16 (NR_NODES) iterations.
>
> Why presence of id on 'rb_n' makes a difference?
> It will still process 16 loops.
>
> Which insn is safe vs not in the above ?
> One after gc_ns[nr_gc++] =3D rb_n ?

One more thing...

How does it interact with reg_is_init_pkt_pointer() ?

That pointer has to have id =3D=3D 0.

