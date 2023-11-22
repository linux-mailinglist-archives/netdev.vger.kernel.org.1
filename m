Return-Path: <netdev+bounces-50125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E607F4A9D
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D22B20E95
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E29A4CDF0;
	Wed, 22 Nov 2023 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZotGumm1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8774E10FA
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:33:13 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cc3dd21b0cso10848127b3.3
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700667192; x=1701271992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4ei9NRU/G7jwU5acqapK3n4Kv1mApAAownSARqq2L0=;
        b=ZotGumm18UkjuzQlhCKJy3Pu0MPvp/26g9R0vuU7+vIzkLf/zZIC/dVBFj8r4LcvQ3
         4KcAlrI11IjyvgjUHVZYV2Q6BsxRkhpzG45d88mQqmk7WCUGLkXGGwAy8jo4UFDh9UCZ
         B9V2M4UcNPMpSYeZ3U79QjlYVG1mTdhrIMFyBpcnGwVkABFeCF6wiGtpG4iA+mUeLnw+
         PAe8Q7QaA7hl8meuB085PBVal2zn4uaoiRQZ7nY23xgN+SC352eIE01y7Qni55kabB+y
         TfxaCr66ufKsreFEYtxfffAOS0RYr07Huo8yR1eO5xVk3w1Go7zcwGIvArv1ugCWqm1s
         11Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700667192; x=1701271992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4ei9NRU/G7jwU5acqapK3n4Kv1mApAAownSARqq2L0=;
        b=kDyk37G7qZ0m2IZiK/2NtB46lR0uTEBGwZvF5cMthwzRt1uAP5thCplyjiiidwqBXl
         iyB6SNdTfPgEdillaIO5NSZAq/OrpL4RxU0/QuAaTelSrt333NhcWo8sCpqWB1+XZwBK
         0aBvYkzSfDa1woFWbsSo4XJ+zDyEud5THNyxajxn5DW+JIxpIFmtu5kT4TL4Y3jUwQ5N
         XHnlBc0SY1UuUDp2MGcw63vfvO4c4xw2vuYFBgkiz8s0hLDWbfgTKTyLKAg688A/ArXM
         pek8rn/zxyMaGsVcyD+Pd0qujQk5JYqx1qtOAQ6TX2YZFk38DejzTwnUMtUchy5/cK+d
         1f7A==
X-Gm-Message-State: AOJu0YxtveMx4jYG/ymyENhu4dZFfnpmdD4Z9BIg1olrz4bg1XXhWLJK
	tV86rr286fiaUNdep8rtTmR16Xr+9geofmUfN44xng==
X-Google-Smtp-Source: AGHT+IE4G4KLm9Drcj26SIBaIAfNRfhVxN87Ha1FgM1GhfP1jQnP9+8vTA0KhZEZWso2wFxW5NqLLp8rwsJG9A9wifg=
X-Received: by 2002:a0d:efc2:0:b0:5cb:e3a9:5e77 with SMTP id
 y185-20020a0defc2000000b005cbe3a95e77mr2755985ywe.6.1700667192512; Wed, 22
 Nov 2023 07:33:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121175640.9981-1-mkoutny@suse.com> <CAM0EoM=id7xo1=F5SY2f+hy8a8pkXQ5a0xNJ+JKd9e6o=--RQg@mail.gmail.com>
 <yerqczxbz6qlrslkfbu6u2emb5esqe7tkrexdbneite2ah2a6i@l6arp7nzyj75>
In-Reply-To: <yerqczxbz6qlrslkfbu6u2emb5esqe7tkrexdbneite2ah2a6i@l6arp7nzyj75>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 22 Nov 2023 10:33:01 -0500
Message-ID: <CAM0EoMk_OgpjV7Huh-NHF_WxkJtQYGAMY+kutsL=qD9oYthh_w@mail.gmail.com>
Subject: Re: [PATCH] net/sched: cls: Load net classifier modules via alias
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>, 
	Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 5:41=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Tue, Nov 21, 2023 at 05:37:37PM -0500, Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > What's speacial about the "tcf- '' that makes it work
> > better for filtering than existing "cls_" prefix?
>
> tcf-foo is an alias.
> cls_foo is the canonical name of the kernel module.
>
> request_module() + blacklist (as described in modprobe.d(5)) works only
> when calling with the alias. The actual string is not important, being
> an alias is the crux.
>

Thanks for the explanation.

> > What about actions (prefix "act_") etc?
>
> I focused only on "cls_" for the first iteration. Do you want me to look
> at other analogous loads?

Yes, look at act_ and sch_

cheers,
jamal
> Thanks,
> Michal

