Return-Path: <netdev+bounces-28072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F9577E204
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8198A281A1F
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CEB10959;
	Wed, 16 Aug 2023 12:58:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D82D52D
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:58:24 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DF71BFB
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 05:58:23 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-584034c706dso70622927b3.1
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692190703; x=1692795503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMXmYLVHZqKnsG2n5X5JlSYhtqnz7OrV1QfIZ8adIok=;
        b=F4x6bdRY3lFE0NFVXxrSNd2myWA6bNaQz2NDCQQOaWOWgKQrtQKuYARLB9T1c/4V2D
         +7FOT6jElX3Std8/fRKS9jMl4/UjFmocfXT/KHoDaV80y4XTadgpR3QhDQUDrMjdVhD0
         d4zXfZvcXzNUWUIthYzMsxhdtoWqrMnV7bOuLpC34E1yGs9As2plfsbEusgRmVaDOwKq
         /9+g+bZAQTlbyw9cPDbBkbon4wQPSn0WyK2t+rXcjzgKOoJ8MJ+RQ017IL13VBSsioM1
         aHREDg+ufCh8+o/t5HaZ5ZHidgUmr1uKAYQ9YGLONEwm3Abzfyvz42g94eYX95tvIn/N
         Y/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692190703; x=1692795503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMXmYLVHZqKnsG2n5X5JlSYhtqnz7OrV1QfIZ8adIok=;
        b=hnIGkmHPvaOrHPDaKH5mbLqWMfyugPS39a0IyW/EC1W/RqEx1/QWyGfe7PkA/bNEEx
         MsOA7b9IKM+FwaCpfi/S+BOJHOQErjmqYvvrKOkcL4omkeMp8A/mMcQG+19jmd5Zbx/h
         GQeXbldST8RPPLBNQDXtAWkGpYCxo0YCPNbpCgvczwH4M1JWvRY5iN1wBfLtf8okQWaj
         vBzP1WkNF52ERE9Hj3OYFlLBF47BUbn2OCSkb8ujYVX4JUuW43qXyTEzrG51Q06WYV1b
         4CtsmlHmLkckutSN3bv6cCIu1g20DvCTvlllFv/dGPtb44g1qBl+NRdEUNSiy/hXoTf+
         9ikw==
X-Gm-Message-State: AOJu0Yz8kpicJwgW15ZLeP8Z90pWmf0RHOzHNZ8XBmRsm9m273UR5SIF
	hThtZbDsMcpPYn+Znhc9nNTxAh0+dXp4Q2pNyTUjag==
X-Google-Smtp-Source: AGHT+IHyd65e3RVPtVTVp7LSftLWkGxulguY75q2ea0SeVzqw8TKX2hNbuGk92YKBZkNKbrESBF3Y5rzEbosh9VkLNc=
X-Received: by 2002:a0d:d50d:0:b0:589:f439:4cd1 with SMTP id
 x13-20020a0dd50d000000b00589f4394cd1mr1425527ywd.33.1692190703104; Wed, 16
 Aug 2023 05:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230815162530.150994-1-jhs@mojatatu.com> <20230815162530.150994-3-jhs@mojatatu.com>
 <20230815105246.0a623664@hermes.local>
In-Reply-To: <20230815105246.0a623664@hermes.local>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 16 Aug 2023 08:58:12 -0400
Message-ID: <CAM0EoMmMtH1rJZNYgAmKmDeRQ=eRa9GKCuSK6UL9AOSw55MMKA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/3] Expose tc block ports to the datapath
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	vladbu@nvidia.com, mleitner@redhat.com, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 1:52=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 15 Aug 2023 12:25:29 -0400
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > +struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
> >  {
> >       struct tcf_net *tn =3D net_generic(net, tcf_net_id);
> >
> >       return idr_find(&tn->idr, block_index);
> >  }
> > +EXPORT_SYMBOL(tcf_block_lookup)
>
> Use EXPORT_SYMBOL_GPL?

Actually... all the other symbols exported in that area use
EXPORT_SYMBOL() - i just cutnpasted. For consistency shouldnt i keep
it?

cheers,
jamal

