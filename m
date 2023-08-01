Return-Path: <netdev+bounces-23459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F398A76C047
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4096281AFB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5A7275C5;
	Tue,  1 Aug 2023 22:18:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A33263C4
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 22:18:50 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B4019B7
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:18:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-522294c0d5bso8042495a12.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 15:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690928327; x=1691533127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPseTy7IzinUQZpPzP36aZrRMGJ435Us12Gys3Nc6zk=;
        b=oWRJ4PZkbCJ2ey++KZdiAfsp6lEM0ajwDZWvbZ2+wZ4pZdXAocuW8kuVFjO3dnKtnf
         8lzUDjsfEiq9ZGq+SNVu1I1PVaPvDvJ+ZeGXNk6rd9FVxoAV+2Y1PfIgtto1waRbirIz
         66lQccpXqqqoVxMDXlAsWc7hkQOt7OkpsWcx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690928327; x=1691533127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPseTy7IzinUQZpPzP36aZrRMGJ435Us12Gys3Nc6zk=;
        b=d6Z14mibUMvxh3dcys8UFL5O8OrQmz3FAHA87PfKwHf2hTy3ACQaIbLMb3pcah+hvm
         u8IqBVRZwTsxngKybgeyG1sbxdf7JIQTvPwtXn3Fp0+YekxphNKeUbGxlciql/yPB3fU
         H1eabkvslseWkAwBKBrJDQrSt6LWFVnJOkTe/hrmAsJQap9YT/nHNv+77QnXNEmFDfkU
         eAXOsTnXCqdXfnEAO3hicmzWHNrl+L8mhqww6t9x21fs0KYEzy7qV/2wF2rwQZfza4hC
         eO95zFXB305zaEC028AxzUGL5yOC/Z9zePI0Bgd7frz7Bu1Z+dvolb3xswf6SZqQcRd0
         G7cg==
X-Gm-Message-State: ABy/qLZzi73PLAJnIEPAcka+jjYHM9g7qDtKprfhsJaqad1wnc3UXnfs
	HyW+SZsHK/5jRObWY1QmLv2YKbRsc7x565K1DCNj3w==
X-Google-Smtp-Source: APBJJlF6hKrUdco2WhtqBq/dd/fptQdjNbrXp5Xp8ffyLBxvo4Hhe4gPknw50y7nZFOKqOmpsbN//GRQckBdVERYlwc=
X-Received: by 2002:a05:6402:125a:b0:51d:e30b:f33a with SMTP id
 l26-20020a056402125a00b0051de30bf33amr3473017edw.34.1690928327002; Tue, 01
 Aug 2023 15:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690332693.git.yan@cloudflare.com> <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
 <a76b300a-e472-4568-b734-37115927621d@moroto.mountain> <ZMEqYOOBc1ZNcEER@debian.debian>
 <bc3ec02d-4d4e-477a-b8a5-5245425326c6@kadam.mountain> <ZMFFbChK/66/8XZd@debian.debian>
 <8b681fe1-4cc6-4310-9f50-1cff868f8f7f@kadam.mountain> <38c61917-98b5-4ca0-b04e-64f956ace6e4@kadam.mountain>
In-Reply-To: <38c61917-98b5-4ca0-b04e-64f956ace6e4@kadam.mountain>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 1 Aug 2023 17:18:36 -0500
Message-ID: <CAO3-Pbpx8vmC_-o59s61mU=TzYLb+VpZ2qk+QhTMjVM6jf=71g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com, 
	Jordan Griege <jgriege@cloudflare.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 9:26=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> I'm not a networking person, but I was looking at some use after free
> static checker warnings.

Did you refer to the gist I posted or something new?

>
> Apparently the rule with xmit functions is that if they return a value
> > 15 then that means the skb was not freed.  Otherwise it's supposed to
> be freed.  So like NETDEV_TX_BUSY is 0x10 so it's not freed.
>
> This is checked with using the dev_xmit_complete() function.  So I feel
> like it would make sense for LWTUNNEL_XMIT_CONTINUE to return higher
> than 15.

Yes I am adopting your suggestion in v5. Dealing with NETDEV_TX_BUSY
would be left as another item (potentially more suited for netdev
rather than bpf). Would be great to find a reproduction of memleak.

>
> Because that's the bug right?  The original code was assuming that
> everything besides LWTUNNEL_XMIT_DONE was freed.
>
> regards,
> dan carpenter
>


--=20

Yan

