Return-Path: <netdev+bounces-28874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD07781110
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FA2282291
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2DB6110;
	Fri, 18 Aug 2023 16:57:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3065362B
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:57:13 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9512D69
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:57:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-525656acf4bso1458291a12.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692377831; x=1692982631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsyKfMya3T2IG5CsphBG2f1KZVRfw1A44jYZYuUf32w=;
        b=OSdk3FCzOMhI/OH7Tx/fJFVN5dScVuA5+lhY8Dc6KTAzM4L5hXxr6R/t/iwM+s+RFY
         maDf4UXSEsRxmrgqNcb81xU3eXxOknhsm05Gle6GtYgOVq4kW22Ca9olD1KVqEQEGjBU
         SmVjGgqXpugx1FudR52ylhevyrJnGveMBDoVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692377831; x=1692982631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsyKfMya3T2IG5CsphBG2f1KZVRfw1A44jYZYuUf32w=;
        b=BWgxrPJkPODJcBKQaOKQGUh+oAqtY0bSpsT+ggpcjieivpBp2No1UqP65+brV1iXB9
         vR+ZHB/ODpDwY1emLSa4lLY63j6K0TqQCDe0yiwPoDWh9gChr+MQQL5yHFwNcn59uU8Y
         eJVgeFw6wJ2msKefkXo7bU5mFBadn+IdUfkF0Nxk3fUzPk5ceHdt+PeYQdD0eW0WkMPg
         keitxL6sgVWoYGMSrt22hs1UlJ4yTUCu4y2DUpo/rXYDZgCy3ElzF6TENzx8SbsY69cm
         ZT/TBweko33QNJqceqeIpjBWQ2cOUmJKpLFyghX+3+I1YSUBo5WIcg3ThXwq+ZTUFtJt
         do9A==
X-Gm-Message-State: AOJu0Yz+UZmNVLY1guzrdLySP4ScpUzgaB5gGa13xwgd4QmjUPNwcM4I
	rQ1tlpkNjpkPIl7z8hRRhzjzuJIcqkaDKRCLbnkIXQ==
X-Google-Smtp-Source: AGHT+IHuOU5N11Lk5NSSYlDBPWcuphNEBeKr4AafLZ//Dqr/oS4Z1OLTqRF+Ba0oQRXzsmr48VWP6veE7DkGlw9yygo=
X-Received: by 2002:aa7:c58c:0:b0:522:2a0c:d254 with SMTP id
 g12-20020aa7c58c000000b005222a0cd254mr2605082edq.33.1692377830908; Fri, 18
 Aug 2023 09:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814112421.5a2fa4f6@kernel.org> <20230817131612.M_wwTr7m@linutronix.de>
 <CAO3-Pbo7q6Y-xzP=3f58Y3MyWT2Vruy6UhKiam2=mAKArxgMag@mail.gmail.com> <20230818145734.OgLYhPh1@linutronix.de>
In-Reply-To: <20230818145734.OgLYhPh1@linutronix.de>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 18 Aug 2023 11:56:59 -0500
Message-ID: <CAO3-Pbr4u8+UsmmN+kHF4Yv+-THAnUxSgROLyK3Tvjb9W5gHZQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Wander Lairson Costa <wander@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 9:57=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-08-18 09:43:08 [-0500], Yan Zhai wrote:
> > > Looking at the cloudflare ppl here in the thread, I doubt they use
> > > backlog but have proper NAPI so they might not need this.
> > >
> > Cloudflare does have backlog usage. On some veths we have to turn GRO
>
> Oh. Okay.
>
> > off to cope with multi-layer encapsulation, and there is also no XDP
> > attached on these interfaces, thus the backlog is used. There are also
> > other usage of backlog, tuntap, loopback and bpf-redirect ingress.
> > Frankly speaking, making a NAPI instance "threaded" itself is not a
> > concern. We have threaded NAPI running on some veth for quite a while,
> > and it performs pretty well. The concern, if any, would be the
> > maturity of new code. I am happy to help derisk with some lab tests
> > and dogfooding if generic agreement is reached to proceed with this
> > idea.
>
> If you have threaded NAPI for veth then you wouldn't be affected by this
> code. However, if you _are_ affected by this and you use veth it would
> be helpful to figure out if you have problems as of net-next and if this
> helps or makes it worse.
>
yes we are still impacted on non-NAPI veths and other scenarios. But
net-next sounds good, still plenty of time to evaluate if it has any
negative impact.

Yan

> As of now Jakub isn't eager to have it and my testing/ convincing is
> quite limited. If nobody else yells that something like that would be
> helpful I would simply go and convince PeterZ/tglx to apply 2/2 of this
> series.
>
> > Yan
>
> Sebastian

