Return-Path: <netdev+bounces-54864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D145808A43
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 15:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A764A2820B5
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1447B41A9A;
	Thu,  7 Dec 2023 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEAqqvBG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4949610DC
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 06:20:56 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso9041a12.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 06:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701958854; x=1702563654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkRewiu/NZNFWUxZGqBol41tT6ZsnLqbUhftzqAc+jE=;
        b=MEAqqvBG99bOv9gYMpP2Qo4DQNDbq0xm69Wc707OAVXHOGS76Oti4rMXUdVp/2kBWp
         Z1lNl4UW84d+7rg2LDGfLya0Oi2N3CBkAl25y+hdUHilYo6E/Jupv8D8ofcjsrF157+6
         kYqbXC+V8shxRycKm9S8xtGvBMfZXYoFMhlO+GtlThmfwLIsnYqKOp8+gFOm0YkgM8LC
         L9wri7O8KBdfyZpPVVYU/AU6jaxzBcsRAcEb86v+NTMvDVbwFAO1wslrhzmjUNdgRMh6
         SjwEHRGZTx45BedVgHZGk4O9yo63BDNj3ugEQLUgmjG2hcV2lgmEiQpj0GpYQzZoXrNn
         aK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958854; x=1702563654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkRewiu/NZNFWUxZGqBol41tT6ZsnLqbUhftzqAc+jE=;
        b=SxiBjSOY9FdiAamS/rW9AOJzyCwVZPeFYjKWWRmBstECighE1efpis9B39eJvpOZBg
         jZKqa6McOUFI+gPSkfmllQa1Lj+Zf5J7z2OCKB5JABrsmbAHs8AH9XM5ZJ9CD6mS1Vc9
         LWKaqIqJQz1zPqMue/BpiOfIwZQb2xegczJPX7Go1ervgOYZKE1LItclufe9O25wP0NH
         o2SQbzX6IvTZi2fWrHSjwYm80crrxn7pjw4bUk28I3a+t15qO7vbbNbQe3fWvroUQLIl
         KtgBwzRSBXBSfOmCvOsa2pEU3tYbP2C+v2i5LGz7BEzC5LePG5ahMJaSBTUTXaiA+vJb
         emTA==
X-Gm-Message-State: AOJu0YyamXtjlI0WwFVoUcMGGxKzLh3wack1KwmpesmAYkYZ4zGArTPo
	V4aGfAgLjCaCSRoLM27gQciuvtVf8qJsqmoMnkuC2g==
X-Google-Smtp-Source: AGHT+IFLjUJbZEWxmcKPEqIR6GlBevvmCt7XyrArSlH2PfvinLYze+S7AEZ+gA4JR7ugTHdKo2yo2htiVN6SEIL8RQ4=
X-Received: by 2002:a50:c35d:0:b0:54c:79ed:a018 with SMTP id
 q29-20020a50c35d000000b0054c79eda018mr252385edb.2.1701958854365; Thu, 07 Dec
 2023 06:20:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLxJzspevWrZLOt+6jkybyUEHfYz8MFZbTuRcyyjnExiKA@mail.gmail.com>
In-Reply-To: <CABOYnLxJzspevWrZLOt+6jkybyUEHfYz8MFZbTuRcyyjnExiKA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Dec 2023 15:20:43 +0100
Message-ID: <CANn89iLNOyqDy6p1AZj5A=Vr52xhA_d3aDiNyTWOfczTcC8FFw@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in ip_route_output_key_hash_rcu (4)
To: xingwei lee <xrivendell7@gmail.com>
Cc: syzbot+549e451574ba8bfd0fd6@syzkaller.appspotmail.com, davem@davemloft.net, 
	glider@google.com, kuba@kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 2:36=E2=80=AFPM xingwei lee <xrivendell7@gmail.com> =
wrote:
>
> Hello
>
> I reproduced this bug in the latest upstream linux with repro.c and repro=
.txt
>
> When fuzzing the latest upstream linux 6.7-rc4,  the following crash
> was triggered.
> HEAD commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei Lee <xrivendell7@gmail.com>
>
> console_log: https://gist.github.com/xrivendell7/195eb3c1946ea466f9d8f597=
7b90c6ed#file-console_log
> report: https://gist.github.com/xrivendell7/195eb3c1946ea466f9d8f5977b90c=
6ed#file-report
> kernel commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
> kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D=
ce27066613dacbb6
> repro.c: https://gist.github.com/xrivendell7/195eb3c1946ea466f9d8f5977b90=
c6ed#file-repro-c
> repro.txt: https://gist.github.com/xrivendell7/195eb3c1946ea466f9d8f5977b=
90c6ed#file-repro-txt
>
> In the lasted kernel: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8 the
> crash likes below:
> [  209.523497][ T8593] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  209.530316][ T8593] BUG: KMSAN: uninit-value in
> ip_route_output_key_hash_rcu+0x1ee8/0x3810
> [  209.533357][ T8593]  ip_route_output_key_hash_rcu+0x1ee8/0x3810
> [  209.535524][ T8593]  ip_route_output_flow+0x14f/0x320
> [  209.537312][ T8593]  ip_tunnel_xmit+0x1450/0x3e80
> [  209.538995][ T8593]  ipgre_xmit+0xd1c/0xe20
> [  209.540511][ T8593]  dev_hard_start_xmit+0x247/0xa10
> [  209.542211][ T8593]  __dev_queue_xmit+0x33b8/0x5130
> [  209.543742][ T8593]  __bpf_redirect+0xdd7/0x1600
> [  209.545235][ T8593]  bpf_clone_redirect+0x328/0x470
> [  209.546807][ T8593]  ___bpf_prog_run+0x2180/0xdb80
> [  209.548288][ T8593]  __bpf_prog_run512+0xb5/0xe0
> [  209.549864][ T8593]  bpf_test_run+0x482/0xb00
> [  209.551178][ T8593]  bpf_prog_test_run_skb+0x14e5/0x1f20
> [  209.552612][ T8593]  bpf_prog_test_run+0x6af/0xac0
> [  209.553902][ T8593]  __sys_bpf+0x649/0xd60
> [  209.555000][ T8593]  __x64_sys_bpf+0xa0/0xe0
> [  209.556114][ T8593]  do_syscall_64+0x44/0x110
> [  209.557249][ T8593]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> [  209.558676][ T8593]
> [  209.559232][ T8593] Uninit was stored to memory at:
> [  209.560528][ T8593]  ip_tunnel_xmit+0x1161/0x3e80
> [  209.561676][ T8593]  ipgre_xmit+0xd1c/0xe20
> [  209.562711][ T8593]  dev_hard_start_xmit+0x247/0xa10
> [  209.563864][ T8593]  __dev_queue_xmit+0x33b8/0x5130
> [  209.564963][ T8593]  __bpf_redirect+0xdd7/0x1600
> [  209.566044][ T8593]  bpf_clone_redirect+0x328/0x470
> [  209.567151][ T8593]  ___bpf_prog_run+0x2180/0xdb80
> [  209.568184][ T8593]  __bpf_prog_run512+0xb5/0xe0
> [  209.569187][ T8593]  bpf_test_run+0x482/0xb00
> [  209.570201][ T8593]  bpf_prog_test_run_skb+0x14e5/0x1f20
> [  209.571308][ T8593]  bpf_prog_test_run+0x6af/0xac0
> [  209.572284][ T8593]  __sys_bpf+0x649/0xd60
> [  209.573131][ T8593]  __x64_sys_bpf+0xa0/0xe0
> [  209.574010][ T8593]  do_syscall_64+0x44/0x110
> [  209.574902][ T8593]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> [  209.576008][ T8593]
> [  209.576456][ T8593] Uninit was created at:
> [  209.577301][ T8593]  slab_post_alloc_hook+0x129/0xa70
> [  209.578284][ T8593]  kmem_cache_alloc_node+0x5e9/0xb10
> [  209.579233][ T8593]  kmalloc_reserve+0x13d/0x4a0
> [  209.580177][ T8593]  pskb_expand_head+0x226/0x1a00
> [  209.581096][ T8593]  skb_ensure_writable+0x3d3/0x460
> [  209.582015][ T8593]  bpf_clone_redirect+0x17f/0x470
> [  209.582963][ T8593]  ___bpf_prog_run+0x2180/0xdb80
> [  209.583859][ T8593]  __bpf_prog_run512+0xb5/0xe0
> [  209.584725][ T8593]  bpf_test_run+0x482/0xb00
> [  209.585556][ T8593]  bpf_prog_test_run_skb+0x14e5/0x1f20
> [  209.586527][ T8593]  bpf_prog_test_run+0x6af/0xac0
> [  209.587347][ T8593]  __sys_bpf+0x649/0xd60
> [  209.588058][ T8593]  __x64_sys_bpf+0xa0/0xe0
> [  209.588802][ T8593]  do_syscall_64+0x44/0x110
> [  209.589613][ T8593]  entry_SYSCALL_64_after_hwframe+0x63/0x6b

Please double check the latest net tree.

