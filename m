Return-Path: <netdev+bounces-34575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460237A4C54
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE7A2818FC
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC511D6A9;
	Mon, 18 Sep 2023 15:31:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6B1A27D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:31:23 +0000 (UTC)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0171718
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:29:37 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34fcc39fae1so306165ab.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695050770; x=1695655570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UbPBofT/4AGGz2HH7yLIR5t4+0yl7YX5yavMVqOyw4=;
        b=EBVdvm8IkUu2/Guxh/ix6OaJakkftl/Cod55/OCkUKpFrNGa8exGJJv8bCFu24eq9T
         xYM9g47NsjikZh/T9wtg+b8Benaa/5Icqg2jxxV02JSMiqUFgibiQeyEOqYFLQ1YRrDB
         47ppHxwhCQU3YWEthLnXEBAromTMiKWhet9PnW5Jk25KXtxsCSAD+jrC2C8z4wy2aCmb
         97RYb5EBTH6oJgo3A/kJbO0CRUd5nHHKiMMVSi+Zh63zdFvMfsw2RuBV60DU4CuL1mbs
         Nu9/gMEa6u26P68LdxAKKoO0RMeIMNuRnX9fTpTKXJc38hz5OyzNFD/5jIfMAxfajaCx
         d55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050770; x=1695655570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UbPBofT/4AGGz2HH7yLIR5t4+0yl7YX5yavMVqOyw4=;
        b=sUPI9rJY85liWhNbl76ws9G42a6j2/xMF6P+kJuXJmxhM7cB3+7C7jDwCLypjIf+lx
         MuasyUZO5MzL56B4Ped/XJm+pUorp+luqsqQD0o7CqBb3e/K+YP5U51VoCuYRuzkDR6J
         KV0J3KJ3EgGkkrih7FXR6a0SQcUeP5gz3zHinG/ogh6QePg/TWKGJaAoGEdnyhE2DMRS
         jDq2cA48knrObHdBfJnEBqg0D+JOLG9V+XJNKPjqXPvqQxEQ/MdPc7BY7pLYY5HPF0t3
         6vuFkmuWrmLekTjgIHyGI1XO3MLL+XbyIG12UoAGMBsKEY4jDPPdoiekahrcUle58+56
         4KCA==
X-Gm-Message-State: AOJu0Yw1/f4osyfUcynedLHB76h012HX1jVA9w7sHfcIRcGmtB0ymKFJ
	QYitgy9nmcmVbyAHfxVMAGYe8TPRfYw5DdahFzUA6J89VEo2jXJ+SMKnWA==
X-Google-Smtp-Source: AGHT+IEnV4KuGka1FgaLdBiGzxFWG2i+6wNH6yhdyyc6xwatPFieTmLbogv2yArVpLXrxbWb5k7kjJCAZQAGSbAc7qE=
X-Received: by 2002:ac8:580c:0:b0:410:958a:465f with SMTP id
 g12-20020ac8580c000000b00410958a465fmr380877qtg.11.1695043555021; Mon, 18 Sep
 2023 06:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916165853.15153-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20230916165853.15153-1-alexei.starovoitov@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Sep 2023 15:25:43 +0200
Message-ID: <CANn89iK_367bq4Gv+AuA-H5UgXNuM=N3XCp7N8nkeMik0Kwp+Q@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-09-16
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 16, 2023 at 6:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Hi David, hi Jakub, hi Paolo, hi Eric,
>
> The following pull-request contains BPF updates for your *net-next* tree.
>
> We've added 73 non-merge commits during the last 9 day(s) which contain
> a total of 79 files changed, 5275 insertions(+), 600 deletions(-).
>
> The main changes are:
>
> 1) Basic BTF validation in libbpf, from Andrii Nakryiko.
>
> 2) bpf_assert(), bpf_throw(), exceptions in bpf progs, from Kumar Kartike=
ya Dwivedi.
>
> 3) next_thread cleanups, from Oleg Nesterov.
>
> 4) Add mcpu=3Dv4 support to arm32, from Puranjay Mohan.
>
> 5) Add support for __percpu pointers in bpf progs, from Yonghong Song.
>
> 6) Fix bpf tailcall interaction with bpf trampoline, from Leon Hwang.
>
> 7) Raise irq_work in bpf_mem_alloc while irqs are disabled to improve ref=
ill probabablity, from Hou Tao.
>
> Please consider pulling these changes from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
>

This might have been raised already, but bpf on x86 now depends on
CONFIG_UNWINDER_ORC ?

$ grep CONFIG_UNWINDER_ORC .config
# CONFIG_UNWINDER_ORC is not set

$ make ...
arch/x86/net/bpf_jit_comp.c:3022:58: error: no member named 'sp' in
'struct unwind_state'
                if (!addr || !consume_fn(cookie, (u64)addr,
(u64)state.sp, (u64)state.bp))
                                                                 ~~~~~ ^
1 error generated.

