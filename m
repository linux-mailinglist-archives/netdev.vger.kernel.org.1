Return-Path: <netdev+bounces-32446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7476C7979A5
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38DD1C20B7C
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123F613AD2;
	Thu,  7 Sep 2023 17:17:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD813AC7
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 17:17:40 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B44B1FD3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 10:17:14 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40a47e8e38dso13191cf.1
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 10:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694106973; x=1694711773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JO/3BDkDhLSW30Yb+nMQZxL2mZ3dukJjYEt9ywGN1w=;
        b=cGUEDPCkRAa2UyDjv/N3AnUrp2P8j5yALoHCNsXJeIJLuHOMzvCW1o2NF7xI6HFarr
         bVnKKGkccQVEirygTHF8j8OgpdvEggxff0fpRCRISrtxPomPvTiCIoMpFq7Y9aiZb9O1
         HG8f5fKAh8MKEEOY1y7qZeh7RiMJp/oZkRshGjRuCW/w/xWxYl+KC64g6GjoiYt1SsV4
         Lm/3YNqI7wcI8VwewPjUU3DCuNZquXrT1L+JOpKdZS5UlVtNB8OZK95GTUSCZnInaJMK
         j1ugZA4PpJHDj4N8idUMi4XkP/200tI6MZlW9ZSezSZD5lf4gvThjhfi1oKpD+tZTkMH
         rUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694106973; x=1694711773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JO/3BDkDhLSW30Yb+nMQZxL2mZ3dukJjYEt9ywGN1w=;
        b=FTzagqDKgPIFIksfgopAtBwbkMkUxP4BlhcLEE3WWN4r6fF8KPC+trCD3kaxI6flMq
         lu/1BwvJuBS+AsZv7ClDin/VmX6TTnN48unnvEcI9ngL/w4Zj8rcEQGhq5s4Uk7fBouS
         q60oXnuEH76BmDRT6tKt7RGr+RUGpET1sRJSiVQPvi6ZnHqWmnYRbH5Pw6OM1HtpACPr
         tFNqhOt3NS6KU6re5CC0Xf4BZm2hOIetA+PxoZv1VS7L2nwzdxarqjWUMsmTW+aa7pyw
         ookdHRDyZeDjn6IF0yBydQ7+H5XkPmhpBoMSHfSvmjzJDdsLWyZV+ea58xU4gLMUEU5h
         zFCw==
X-Gm-Message-State: AOJu0YyblIlPp1trVylwoU3aBwjfDgOC3Yqq1TzFgZjQttwbu6OFsI9y
	FXidzGFoFDiUnRX5rjD1bpWmjmxWepEevu3T8y/d0Q==
X-Google-Smtp-Source: AGHT+IHuTQ6QaFmcdNdopiDJcxyiVE+0vtRqwOJKzl3MtJTdVjkndtQuomzhG33eFScAulKSEpeW6mXYJfcAdexn/qA=
X-Received: by 2002:a05:622a:1312:b0:40f:ec54:973 with SMTP id
 v18-20020a05622a131200b0040fec540973mr9972qtk.22.1694106973273; Thu, 07 Sep
 2023 10:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906201046.463236-1-edumazet@google.com> <20230906201046.463236-5-edumazet@google.com>
 <20230907100932.58daf8e5@kernel.org>
In-Reply-To: <20230907100932.58daf8e5@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Sep 2023 19:16:01 +0200
Message-ID: <CANn89iJY8UypOGqSOJo531ny4isPSiTg2xW-rO_xNmnYVVovQw@mail.gmail.com>
Subject: Re: [RFC net-next 4/4] tcp: defer regular ACK while processing socket backlog
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 7:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  6 Sep 2023 20:10:46 +0000 Eric Dumazet wrote:
> > This idea came after a particular workload requested
> > the quickack attribute set on routes, and a performance
> > drop was noticed for large bulk transfers.
>
> Is it okay if I asked why quickack?
> Is it related to delay-based CC?

Note the patch is also helping the 'regular' mode, without "quickack 1" .

This is CC related in any way, but some TCP tx zerocopy workload, sending
one chunk at a time, waiting for the TCP tx zerocopy completion in
order to proceed for the next chunk,
because the 'next chunk'  is re-using the memory.

The receiver application is not sending back a message (otherwise the
'delayed ack' would be piggybacked in the reply),
and it also does not know what size of the message was expected (so no
SO_RCVLOWAT or anything could be attempted)

For this kind of workload, it is crucial the last ACK is not delayed, at al=
l.

