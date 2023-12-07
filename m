Return-Path: <netdev+bounces-54863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23923808A3E
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 15:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD84281B5E
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BC341854;
	Thu,  7 Dec 2023 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzdNbJ1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B182730DB
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 06:20:00 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so12193a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 06:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701958797; x=1702563597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cg+kyvs6whLnp94BpNVRhpcWLXdDwv5DFCjHXa8X9m8=;
        b=hzdNbJ1mORZNZ6W4cIJfjbmvTEFc5XJQTz7NXrjj3Fij+klTwEv6EgPuDJacDxmHh1
         ZNcWM/c0TIogF5o0FnpRtlpp6o9rpYPK7vnQd3IqAfn2QzZAiSfDOuKoWYfKkpf2EXCD
         I/jSBXELtN7jeYJFr/XRRlbMCPvsQijd06h9dKiRQ6qXIvLJIFrBElwC+HreJAhyFW3k
         rWTb24Drjbl5OBZahiHMT4I0eiChgqbceN46bJrrrfrIbyyTmL2joDelAOxaTWb9rjMA
         yijnJMIhSQOq0SVPc91tzpXBRTSyMfrUa8QvtIuHEKPKiU03FX5neMEZvjZUGAmgxdwK
         AZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958797; x=1702563597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg+kyvs6whLnp94BpNVRhpcWLXdDwv5DFCjHXa8X9m8=;
        b=NFLdPnqCDmfLlTqahCRPtRnvhoemicGIpHTTL4z80HDvcd6Q6wHC+Cbqh68VeibH6a
         ZLQuya7aMzK4uIldaKyOnV7uaNEFG+bTuxu7iw3/hHun9m/NBpjm7MoB3FFnuTPQ3TDS
         Kj3XNVkeZIorgsGSMdLuP73xU0jzXMGz02FPeRV4ae3cGvznPxhjLRZQYOfVhIQLDegG
         bo0it6SiT+t5lzcGAJL6vDnaPrc9zodkTEzayak0UBhZ/3bsxDZIizRaQ8waIxMncrby
         f7fb4gNazvTwURXV6nC0Gj2QbzxuwmDvnypSazAHdzq+/MkrNX70SjUuanlv70orxhVr
         kmBw==
X-Gm-Message-State: AOJu0YyS5fqZa/kRK9IcFxFk/DGtzQiwhnDbTd1UHDLr4VdZTbupMQOJ
	lphOkRGHcM/keS6mv7BHAu14xqswbB9YcArKkKhIgA==
X-Google-Smtp-Source: AGHT+IGXOZOZ4pQiJJUXla1388CP6kL+6w7lkaO8vOiBdOjIpyd8gct1j8GkezTmcPoNx9DJuKrdRMDE1v5jm6Av/Es=
X-Received: by 2002:a50:9f89:0:b0:54b:bf08:a95f with SMTP id
 c9-20020a509f89000000b0054bbf08a95fmr229791edf.6.1701958796595; Thu, 07 Dec
 2023 06:19:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLyH=PmSoP8=PdkyK5VG1vhiG8fHKg2Xie4oBrVeYbdhHw@mail.gmail.com>
In-Reply-To: <CABOYnLyH=PmSoP8=PdkyK5VG1vhiG8fHKg2Xie4oBrVeYbdhHw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Dec 2023 15:19:45 +0100
Message-ID: <CANn89i+xOT-CPxyBN5nkfHFN_Z78D3BPQCwN8phRur41CTyJSQ@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in ip_tunnel_xmit
To: xingwei lee <xrivendell7@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, 
	syzbot+4a2c52677a8a1aa283cb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 2:27=E2=80=AFPM xingwei lee <xrivendell7@gmail.com> =
wrote:
>
> Hello,
>
> When fuzzing the latest upstream linux 6.7-rc4,  the following crash
> was triggered.
> HEAD commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei Lee <xrivendell7@gmail.com>
>
> console_log: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90=
c98b6583#file-console_log
> report: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90c98b6=
583#file-report
> kernel commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
> kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D=
ce27066613dacbb6
> repro.c: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90c98b=
6583#file-repro-c
> repro.txt: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90c9=
8b6583#file-repro-txt
>
> In the lasted kernel: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8 the
> [  199.471467][ T8590] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  199.475015][ T8590] BUG: KMSAN: uninit-value in ip_tunnel_xmit+0x857/0=
x3e80
> [  199.478180][ T8590]  ip_tunnel_xmit+0x857/0x3e80
> [  199.480541][ T8590]  ipgre_xmit+0xd1c/0xe20
> [  199.482393][ T8590]  dev_hard_start_xmit+0x247/0xa10
> [  199.484530][ T8590]  __dev_queue_xmit+0x33b8/0x5130
> [  199.486433][ T8590]  __bpf_redirect+0xdd7/0x1600
> [  199.488258][ T8590]  bpf_clone_redirect+0x328/0x470
> [  199.490250][ T8590]  ___bpf_prog_run+0x2180/0xdb80
> [  199.491997][ T8590]  __bpf_prog_run512+0xb5/0xe0
> [  199.493691][ T8590]  bpf_test_run+0x482/0xb00
> [  199.495215][ T8590]  bpf_prog_test_run_skb+0x14e5/0x1f20
> [  199.497026][ T8590]  bpf_prog_test_run+0x6af/0xac0
> [  199.498701][ T8590]  __sys_bpf+0x649/0xd60
> [  199.500029][ T8590]  __x64_sys_bpf+0xa0/0xe0
> [  199.501411][ T8590]  do_syscall_64+0x44/0x110
> [  199.502757][ T8590]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> [  199.504463][ T8590]
> [  199.505159][ T8590] Uninit was created at:
> [  199.506344][ T8590]  slab_post_alloc_hook+0x129/0xa70
> [  199.507690][ T8590]  kmem_cache_alloc_node+0x5e9/0xb10
> [  199.509191][ T8590]  kmalloc_reserve+0x13d/0x4a0
> [  199.510411][ T8590]  pskb_expand_head+0x226/0x1a00
> [  199.511657][ T8590]  skb_ensure_writable+0x3d3/0x460
> [  199.512905][ T8590]  bpf_clone_redirect+0x17f/0x470
> [  199.514135][ T8590]  ___bpf_prog_run+0x2180/0xdb80
> [  199.515325][ T8590]  __bpf_prog_run512+0xb5/0xe0
> [  199.516479][ T8590]  bpf_test_run+0x482/0xb00
> [  199.517580][ T8590]  bpf_prog_test_run_skb+0x14e5/0x1f20
> [  199.518901][ T8590]  bpf_prog_test_run+0x6af/0xac0
> [  199.520015][ T8590]  __sys_bpf+0x649/0xd60
> [  199.520996][ T8590]  __x64_sys_bpf+0xa0/0xe0
> [  199.521949][ T8590]  do_syscall_64+0x44/0x110
> [  199.522926][ T8590]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> and I notice the problem is reported at 2018/2020 and seems fixed twice.
>
> https://syzkaller.appspot.com/bug?id=3Df62d236e2fceaeb104f4e8f77d2324ef9d=
a4b41b
> https://syzkaller.appspot.com/bug?extid=3D4a2c52677a8a1aa283cb
>
>
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

I think a fix was merged into the net tree yesterday, please double check.

80d875cfc9d3711a029f234ef7d680db79e8fa4b ipv4: ip_gre: Avoid
skb_pull() failure in ipgre_xmit()

