Return-Path: <netdev+bounces-32961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0344479AC0E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 00:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7AA1C209F6
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271D88F4D;
	Mon, 11 Sep 2023 22:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142FD23D9
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 22:52:13 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FD99543B
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:50:29 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-68fbd5cd0ceso1416439b3a.1
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694472503; x=1695077303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx0gR2ESc4lJCkHeNwni0JEpr6/GKNTWX/V+qZxf4Do=;
        b=hzWTqB5X/Bi5k5EvWa8491eGxeOAJ9Hw6T0nUI9on7X8sv3Q4PD4Vuc1XqEyYzM7sj
         AaO4zIwtstbW8W+pqSGIvKUZRM7h+bCI40PQmFAedjLqZnPimRBlPjRZoe3CiYe5slYS
         6uUfS5/hhryahS/IG/PcF2KNLmGvb42dpI8cm8iTreZ206bQpPHVztjeWoKE8/EG2JD0
         IiXUN6NXskrWzN7MNHo6KkdLDT127vZXbrCCnyLswvLyhkUSIsXXPZOgsDabmE9vwvEN
         8NUvWQTGYo7tkRCxGwRfyDIKCRjbAn3UQ9qCQbZk5HjeH2UIgaLxrQwg1C350ezYKHz/
         svGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694472503; x=1695077303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fx0gR2ESc4lJCkHeNwni0JEpr6/GKNTWX/V+qZxf4Do=;
        b=o+ZFaywhiw7pV+9HjUxoF9YfWWKQI/cRfS8/nORGE1y6o8/ft6YZs1V9rrkCRlydMV
         un4YxUqoK96UNH+rfhgohrPpTptqhpAOK1VE/1LYpawgoqcxd2PEEqlAhgnJuFoqBaGs
         5/ldXTLUNqkrIL/ryA5LiY8f4gx4TmHE+j9kmx33SE4Tk7woisVlGZ9nuBoJxt+QolAm
         5hQnRi2bLyhnoLLNose9TpEO9vyMAbehOOvcsStwacE09LYT9s4V8XyZmjypLFLNSB/S
         VBMU1suvNsDBniCjIANWRi+wGOQK8KjFOMA3jFs71gbVSLPQAGXUQKsnvgxD+gOS9fwh
         b4Zw==
X-Gm-Message-State: AOJu0Yz9CgenmodjtI3qBjVT18a7rUbaBZ6Ja+hPjR5r31YUr4NnXEI0
	GtHxFcGhtFAmsFD0VMC9ZnUFESzzR8sWHWlhLj+unA==
X-Google-Smtp-Source: AGHT+IHHfIWUIjIzBE6AKQx2HgmCouux51fozxiALlTAf6+prejD6RO4cCCYO4UujkzNTsNXYdatZHi0Ok3aRyWfiC4=
X-Received: by 2002:a05:6a00:c95:b0:68a:51dc:50c0 with SMTP id
 a21-20020a056a000c9500b0068a51dc50c0mr13544622pfv.32.1694472502737; Mon, 11
 Sep 2023 15:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230908225807.1780455-1-sdf@google.com> <20230908225807.1780455-3-sdf@google.com>
 <6c275fdc-4468-7573-a33c-35fc442c61c5@linux.dev>
In-Reply-To: <6c275fdc-4468-7573-a33c-35fc442c61c5@linux.dev>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 11 Sep 2023 15:48:10 -0700
Message-ID: <CAKH8qBv78jTrktfThFK=Ze12tjgAsgYXyNaRy-3m8QE8J-xwuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: expose information about supported xdp
 metadata kfunc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 11, 2023 at 3:11=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/8/23 3:58 PM, Stanislav Fomichev wrote:
> > @@ -12,15 +13,24 @@ static int
> >   netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
> >                  const struct genl_info *info)
> >   {
> > +     u64 xdp_rx_meta =3D 0;
> >       void *hdr;
> >
> >       hdr =3D genlmsg_iput(rsp, info);
> >       if (!hdr)
> >               return -EMSGSIZE;
> >
> > +#define XDP_METADATA_KFUNC(_, flag, __, xmo) \
> > +     if (netdev->xdp_metadata_ops->xmo) \
>
> A NULL check is needed for netdev->xdp_metadata_ops.

Oh, sure, will add, thanks!

> > +             xdp_rx_meta |=3D flag;
> > +XDP_METADATA_KFUNC_xxx
> > +#undef XDP_METADATA_KFUNC
> > +
>

