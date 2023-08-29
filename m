Return-Path: <netdev+bounces-31170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367C478C188
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 11:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C54A281000
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D03914F69;
	Tue, 29 Aug 2023 09:31:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E43113FF4
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 09:31:39 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA624CCE
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 02:31:08 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bf04263dc8so1938797a34.3
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 02:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1693301468; x=1693906268;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=guePXrPopLgOPcdT283gc5sTu7sw+Yj419mnndMktxQ=;
        b=G46WNf6fPWXXmiaXK3LOGve4BCV8l2KqIxaloMmV3wkqAr3ZO5uSD1EkVsUytFDNd3
         ZW4wQc3URjkmfHrKBc1uGO5VYKoynZgFmnk5k16OkThVEiarySxdGyUnYRHng+Yt/fSH
         NCB07AZkoGuNVEDW5GYDoeYyUd2f5KfLOmyRNRwsctkVhLExnZjkRl3BrldDlq3AP6kd
         uwdb9K9QgkwThOczV4x6f3yoKSVIYJqxQiS3n/krZDQQ9uZC7lcHl7RdUJiUjBbtpruE
         uERXMKeg8Q93dAefTNg/TtxWxcUFrwtd/D7UADUeJAwcRqLx26yJ87Kz1LBjcAayiaE3
         lj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693301468; x=1693906268;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guePXrPopLgOPcdT283gc5sTu7sw+Yj419mnndMktxQ=;
        b=ANnEPjJ8QYDC33HjxvfBRZvOeQOyjH+Lj3JNjZrYw+yPKbbpqrlfkmmkUTgslNZmbD
         SZMuXNHsCzzvV2DfovbT7Sa851yiM2swC8WM01lscTi7/IkkJoA3Ub30CRc1UzByMDtq
         2Bt+dW+UgiBY+ViQj4EGGSzCLxL9dU4CnyqBEge0KLqdEWw/c2m74gRdq+IXBIK3N2jc
         AiW1NO2FZQrf1RCcDqESpqHnhnk2IzqaiN5haVfFENMhIZ/h+FGN40hrFXj1/Z2sh1DW
         bySlmh2yX9ZKxPdI1vhZ1LheExHZqhEBJSRLvnfd+IcEjLHHsDGciUTmPfawV5OAQes2
         6JuA==
X-Gm-Message-State: AOJu0YyKaLvW2zv4XOALtn0XYFY+Qjuf8loA2VMVKw7+4r7m+YZyVG8w
	w7NSD/COCmCIxqCcdN0JCBM5qA==
X-Google-Smtp-Source: AGHT+IGkPraI08Qww1nC+lwqJvqyudyb6VsEAq0bqdSWvhaRu2JO4pyOm2p9Ozj4qi8c/yS/CCrB5A==
X-Received: by 2002:a05:6830:119:b0:6b8:7a79:db37 with SMTP id i25-20020a056830011900b006b87a79db37mr16733428otp.22.1693301467999;
        Tue, 29 Aug 2023 02:31:07 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id g7-20020a63ad07000000b005649cee408fsm8741081pgf.0.2023.08.29.02.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 02:31:07 -0700 (PDT)
Date: Tue, 29 Aug 2023 02:31:05 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Eric Dumazet <edumazet@google.com>
Cc: willemjdebruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	David Howells <dhowells@redhat.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:BPF [MISC]" <bpf@vger.kernel.org>
Subject: Re: [PATCH] skbuff: skb_segment, Update nfrags after calling zero
 copy functions
Message-ID: <20230829093105.GA611013@medusa>
References: <20230828233210.36532-1-mkhalfella@purestorage.com>
 <64ed7188a2745_9cf208e1@penguin.notmuch>
 <20230829065010.GO4091703@medusa>
 <CANn89iLbNF_kGG9S3R9Y8gpoEM71Wesoi1mTA3-at4Furc+0Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLbNF_kGG9S3R9Y8gpoEM71Wesoi1mTA3-at4Furc+0Fg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-29 10:07:59 +0200, Eric Dumazet wrote:
> On Tue, Aug 29, 2023 at 8:50 AM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
> >
> > On 2023-08-28 21:18:16 -0700, willemjdebruijn wrote:
> > > Small point: nfrags is not the only state that needs to be refreshed
> > > after a fags realloc, also frag.
> >
> > I am new to this code. Can you help me understand why frag needs to be
> > updated too? My reading of this code is that frag points to frags array
> > in shared info. As long as shared info pointer remain the same frag
> > pointer should remain valid.
> >
> 
> skb_copy_ubufs() could actually call skb_unclone() and thus skb->head
> could be re-allocated.
> 
> I guess that if you run your patch (and a repro of the bug ?) with
> KASAN enabled kernel, you should see a possible use-after-free ?
> 
> To force the skb_unclone() path, having a tcpdump catching all packets
> would be enough I think.
> 

Okay, I see it now. I have not tested this patch with tcpdump capturing
packets at the same time. Also, during my testing I have not seen the
value of skb->head changnig. Now you are mentioning it it, I will make
sure to test with tcpdump running and see skb->head changing. Thank you
for pointing that out.

For frag, I guess something like frag = &skb_shinfo(list_skb)->frags[i];
should do the job. I have not tested it though. I will need to do more
testing before posting updated patch.

