Return-Path: <netdev+bounces-34617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70447A4DBE
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDA62828D2
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A1F208A3;
	Mon, 18 Sep 2023 15:55:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF5A22EF9
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:55:43 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DB1E79
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:54:34 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c4084803f1so257585ad.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695052188; x=1695656988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDPvNTGnVzfWEnM2vQQWdbts3fJPWj+Kgd251XWPAzE=;
        b=hberOvrBD04oMHFTZJqnFW0v+EtBjjG+1usW1y/je+A4FBF1C3SxllTwlkrCba8Mw1
         37zU433LBaEd07UvystuwSPJnLAqKTpzDurpVb6VN08j22T73lRjAT0QwnkRoLsWTphh
         vMyKGZf206Hcki/8ZdkSJ43Mb/9tF4zWmRlbeM2F4SWhOjWuQITCLDZKg9xj874I6jpR
         mSHVzaWwDikAtfL0tJdc4qcHVXImMZYoMmXb2giunR01cBJWdmsvV25tVvP5iebAiWwg
         oy+2k6dcwTDCyoCTczHNua/fueI/jHpbb6OkwHbbraKhGPL96Rsfi8IPp5fzmFWhBAF/
         VGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052188; x=1695656988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDPvNTGnVzfWEnM2vQQWdbts3fJPWj+Kgd251XWPAzE=;
        b=ULvfO/5310Fxc5a820nhC+B6bVdZeOSbSmtc4P4rOlDDDP1UCOfSGu0q608fp+lMFM
         HQxZe1skpO7PIFZ+OBDficQzHq5JYnfN0NYNl/BNajNELCU+/cgQMNvHxsfeFfQLKAfL
         wtjFsmFw7AV/5Kgv1EinshGmn9sp2nQ4bsLfZHk8tzNNppKhGzumr9OqUSIQNlCkJu+4
         oDxlWLB5D9IylXlW7HttnQEE8P4laznThp+IFlsQOUqBBJQd8LZ3s7FK24yGTyiYwMu5
         W6xPPdLZKS2v0lWqbUQRjFOEqL8MJy/S2tA3tGyoYOk7K1XVGrUUtHpA8fOiR5VfY4q7
         LudQ==
X-Gm-Message-State: AOJu0YwxBBNX9cXeQFC5FyIZKzFjCfvpdxDz7NujAC++R43Nx77M9B4L
	Y4dj9uwfbMyQA0OTiI68YQzdT5nujC2TLnhItEIfhg==
X-Google-Smtp-Source: AGHT+IHX1+2Zl+SQS6wfYua3ZBYCi72FsIZkYPIqSURf8Dthf3fUhwidvKwEQ1mfTRGHNrOVqA63S2x0HPiO3faeRNk=
X-Received: by 2002:a17:902:d2cb:b0:1c5:59ea:84c3 with SMTP id
 n11-20020a170902d2cb00b001c559ea84c3mr158871plc.21.1695052187709; Mon, 18 Sep
 2023 08:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901062141.51972-1-wuyun.abel@bytedance.com>
 <20230901062141.51972-4-wuyun.abel@bytedance.com> <8c470d4d-b972-3f43-9b0a-712ee882a402@bytedance.com>
In-Reply-To: <8c470d4d-b972-3f43-9b0a-712ee882a402@bytedance.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Mon, 18 Sep 2023 08:49:36 -0700
Message-ID: <CALvZod4P3_726Jo_FAoDVTNrYcy1vgp67SSxix1=k8FEKoVM7g@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 3/3] sock: Throttle pressure-aware sockets
 under pressure
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, David Howells <dhowells@redhat.com>, 
	Jason Xing <kernelxing@tencent.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 12:48=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com>=
 wrote:
>
> On 9/1/23 2:21 PM, Abel Wu wrote:
> > @@ -3087,8 +3100,20 @@ int __sk_mem_raise_allocated(struct sock *sk, in=
t size, int amt, int kind)
> >       if (sk_has_memory_pressure(sk)) {
> >               u64 alloc;
> >
> > -             if (!sk_under_memory_pressure(sk))
> > +             /* Be more conservative if the socket's memcg (or its
> > +              * parents) is under reclaim pressure, try to possibly
> > +              * avoid further memstall.
> > +              */
> > +             if (under_memcg_pressure)
> > +                     goto suppress_allocation;
> > +
> > +             if (!sk_under_global_memory_pressure(sk))
> >                       return 1;
> > +
> > +             /* Trying to be fair among all the sockets of same
> > +              * protocal under global memory pressure, by allowing
> > +              * the ones that under average usage to raise.
> > +              */
> >               alloc =3D sk_sockets_allocated_read_positive(sk);
> >               if (sk_prot_mem_limits(sk, 2) > alloc *
> >                   sk_mem_pages(sk->sk_wmem_queued +
>
> I totally agree with what Shakeel said in last reply and will try ebpf-
> based solution to let userspace inject proper strategies. But IMHO the
> above hunk is irrelevant to the idea of this patchset, and is the right
> thing to do, so maybe worth a separate patch?
>
> This hunk originally passes the allocation when this socket is below
> average usage even under global and/or memcg pressure. It makes sense
> to do so under global pressure, as the 'average' is in the scope of
> global, but it's really weird from a memcg's point of view. Actually
> this pass condition was present before memcg pressure was introduced.
>
> Please correct me if I missed something, thanks!
>

Please send the patch 1 and this hunk as separate patches with
relevant motivation and reasoning.

thanks,
Shakeel

