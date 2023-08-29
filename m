Return-Path: <netdev+bounces-31174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD3478C204
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F03280FF2
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757CB14F7F;
	Tue, 29 Aug 2023 10:09:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2F13ADA
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:09:33 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECBECCE
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 03:09:27 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40c72caec5cso256061cf.0
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 03:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693303767; x=1693908567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sej7GXbzaGRniVAEP539wALJS6f8t09s59uGFa+3FQ4=;
        b=jKKYIa4R2vG1p5QjSLUKbV6f1+Vf/Iq/OOuQEB6YMg+XNOyLNMfNmdT+N3F4OJA6ko
         DEY0odQnw4wOx3ZwyEWUYRR7eES89SGY22Jn/ojILe3xjDd9jVNsaBqjQfo9fxdhN0Vi
         0Jyw2ToYzql4O9XkY05vaEdPB1ZRzQpVImjPEXpn4rsctjj86YY18FqVJpLp38r5Ruxj
         pHdMdx/Y0C3pPzzmelVlmUFZnRPifTKqFjf4fvxArWBNuz0wihupFfhQ7bgPXXZfTTkg
         +IXMQeJjj9wXSTV1p7wdSSi1wNikhIob+aG9adDCfHZId1+uYlOQ/7Q7v//oW9IHq7po
         1crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693303767; x=1693908567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sej7GXbzaGRniVAEP539wALJS6f8t09s59uGFa+3FQ4=;
        b=VaKqEN3bra6XVgQILd0/o8N7s8PBS32wzGCeZU+yD/GAbP3BGhh8U5KCqI8xwfjbRY
         W2XSk2kPbP31FQwfmhFmkmOMIBPKJwHXkeGFbY/HO+bfWxwCpN5qRgV/SOVBKH5oYz7u
         IUkV+3SJARx8nVKPnNvqPBxBAMbYkc/9F/IMel9lNH62RCoc+G/MT+1OE6iSnbe2BDB0
         U7R6tQ88/j8kxTMw1ijhLxrHUE+bdMRTRwPpErf1612CYrP7dPHjID4SDBzQ+uuqmHMR
         T23w5dYhr4DW4wwGDwAtvln1b3xnnB8kOIUJCCk2rtW374mO2mSz+326Gzh/zaNY9ybq
         lx1Q==
X-Gm-Message-State: AOJu0YzbzyxA1n8N9Dd+7ThP1SvAGvD4WD7lK1qhsmfY4veinMlxNRW6
	2tMU0DV5JV+HUq4V/mwq4xmZ7uQkbNdp1ap1mg4ATg==
X-Google-Smtp-Source: AGHT+IHBNvPSf0ideBleDwuintvch3KuyusTvKe59sFQVtNXMJWfm9w1UCcqPprTL1xjf0/2WxfLIQ+aF4VK65gUJIc=
X-Received: by 2002:ac8:7e83:0:b0:410:9d71:ba5d with SMTP id
 w3-20020ac87e83000000b004109d71ba5dmr159649qtj.25.1693303766647; Tue, 29 Aug
 2023 03:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230828233210.36532-1-mkhalfella@purestorage.com>
 <64ed7188a2745_9cf208e1@penguin.notmuch> <20230829065010.GO4091703@medusa>
 <CANn89iLbNF_kGG9S3R9Y8gpoEM71Wesoi1mTA3-at4Furc+0Fg@mail.gmail.com> <20230829093105.GA611013@medusa>
In-Reply-To: <20230829093105.GA611013@medusa>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Aug 2023 12:09:15 +0200
Message-ID: <CANn89iLzOFikw2A8HJJ0zvg1Znw+EnOH2Tm2ghrURkE7NXvQSg@mail.gmail.com>
Subject: Re: [PATCH] skbuff: skb_segment, Update nfrags after calling zero
 copy functions
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: willemjdebruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Alexander Duyck <alexanderduyck@fb.com>, 
	David Howells <dhowells@redhat.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Kees Cook <keescook@chromium.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 11:31=E2=80=AFAM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On 2023-08-29 10:07:59 +0200, Eric Dumazet wrote:
> > On Tue, Aug 29, 2023 at 8:50=E2=80=AFAM Mohamed Khalfella
> > <mkhalfella@purestorage.com> wrote:
> > >
> > > On 2023-08-28 21:18:16 -0700, willemjdebruijn wrote:
> > > > Small point: nfrags is not the only state that needs to be refreshe=
d
> > > > after a fags realloc, also frag.
> > >
> > > I am new to this code. Can you help me understand why frag needs to b=
e
> > > updated too? My reading of this code is that frag points to frags arr=
ay
> > > in shared info. As long as shared info pointer remain the same frag
> > > pointer should remain valid.
> > >
> >
> > skb_copy_ubufs() could actually call skb_unclone() and thus skb->head
> > could be re-allocated.
> >
> > I guess that if you run your patch (and a repro of the bug ?) with
> > KASAN enabled kernel, you should see a possible use-after-free ?
> >
> > To force the skb_unclone() path, having a tcpdump catching all packets
> > would be enough I think.
> >
>
> Okay, I see it now. I have not tested this patch with tcpdump capturing
> packets at the same time. Also, during my testing I have not seen the
> value of skb->head changnig. Now you are mentioning it it, I will make
> sure to test with tcpdump running and see skb->head changing. Thank you
> for pointing that out.
>
> For frag, I guess something like frag =3D &skb_shinfo(list_skb)->frags[i]=
;
> should do the job. I have not tested it though. I will need to do more
> testing before posting updated patch.

Another way to test this path for certain (without tcpdump having to race)
is to add a temporary/debug patch like this one:

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a298992060e6efdecb87c7ffc8290eafe330583f..20cc42be5e81cdca567515f2a88=
6af4ada0fbe0a
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1749,7 +1749,8 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mas=
k)
        int i, order, psize, new_frags;
        u32 d_off;

-       if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
+       if (skb_shared(skb) ||
+           pskb_expand_head(skb, 0, 0, gfp_mask))
                return -EINVAL;

        if (!num_frags)

Note that this might catch other bugs :/

