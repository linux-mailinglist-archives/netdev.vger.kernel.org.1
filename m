Return-Path: <netdev+bounces-13150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C655573A7D0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DC11C2117A
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D89206A7;
	Thu, 22 Jun 2023 17:55:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43120687
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 17:55:39 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378211FE6
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:55:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-25e92536fb6so3742133a91.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687456537; x=1690048537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mShbBspLML/vUhSWChnEXKDfGnK3HZ0qIDXYawcmoCk=;
        b=yNYBqITg4LxrLFMqdW06O4Tvn4sx8YaR48eNpU0gxXP4o+iA2BqgUxBc16tPZGXCKR
         Nd347AGaEEDFEDsHrAOvZI/VmNR+kSmgdi9/0L4sG/Q1aj0HG0pQBzyR7zkCKugdP/LW
         R1hy5Uy0OXpuEddpCh3RnPUQgFHoY9SFJQDSZ79cfWm+6I2n5G49WJPdXAbvYLBf1l1c
         PzN4SKxibhRudh7PZMb1Uy1FdkGFzbLjg8mDpMDw6/KD9DTkjRP6Wi3qzVfmhREriRL/
         6Z4R1t3yD6doOSqHoibOZPtYu/3BxREWlOg/B353qizMrva35EaPgaJLLNxkzuO7Q8nl
         i4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687456537; x=1690048537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mShbBspLML/vUhSWChnEXKDfGnK3HZ0qIDXYawcmoCk=;
        b=Jdq/mItjEkYIeaSGyebA2kIPDCebexFp/WSaqeNbJhZ6jbDwEtoBuyXeOc8jsew96o
         QvjNalMXl6DwBIk/0sodsz1IjfEFir5FSyh9KfoWSUjixKwriOrkorIdY+Ey7OLQE7Cg
         t/uzFtvpHpqdWzMcak9XVTZy5HYtenM73+ecCr794ijbCoG9cxRAKy1Z1pQx8XLcXNse
         z4fhv7qIvDS/xWx4pvM035BYn5bzUirhTU75sN800W/U2g2mqyzAjbZn9cJx3jAd3NCh
         osXquW4UQWdzdArgVC7L4ZwOe9bKUVCWM0c00URkdcjnRQe12/cx6QiNhj1lHFU9+Rk3
         eHXg==
X-Gm-Message-State: AC+VfDx0B1vue2iUbtdea0WFBWUXE6fjjoumncgv55geDBXM9aOBxS8U
	GOslhQGCm0YA0IyXeuuYLCMCmuITNc4IJlu56XLkSA==
X-Google-Smtp-Source: ACHHUZ7D4mW/wE7jqg3wMJlnUkEx+EO7W5eyIQFn9TXxdZd8nuH3QkKmerNSS+29rkkcf4QvrR+hHZRZxh7B2pRI7Og=
X-Received: by 2002:a17:90a:c90a:b0:25e:a9bb:3900 with SMTP id
 v10-20020a17090ac90a00b0025ea9bb3900mr12321164pjt.15.1687456537505; Thu, 22
 Jun 2023 10:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-3-sdf@google.com>
 <CAADnVQ+QKnFrAFUYcV3XAVVFuosdhi+6K8z0TbwFXbU=euJEDg@mail.gmail.com>
In-Reply-To: <CAADnVQ+QKnFrAFUYcV3XAVVFuosdhi+6K8z0TbwFXbU=euJEDg@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 22 Jun 2023 10:55:26 -0700
Message-ID: <CAKH8qBsfheXDP8Xj_UecdUyxta3jMEOzyue+=35DnENtF23o2g@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 02/11] bpf: Resolve single typedef when walking structs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 10:18=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 21, 2023 at 10:02=E2=80=AFAM Stanislav Fomichev <sdf@google.c=
om> wrote:
> >
> > It is impossible to use skb_frag_t in the tracing program. So let's
> > resolve a single typedef when walking the struct.
> >
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>
> Pls send this one separately without RFC, but with a selftest,
> so we can land it soon.

Sure, will do!

