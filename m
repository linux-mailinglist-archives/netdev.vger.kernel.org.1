Return-Path: <netdev+bounces-28826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F80780E32
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645482823E5
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217EB182BC;
	Fri, 18 Aug 2023 14:43:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011C374
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 14:43:47 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3C9449E
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 07:43:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso1289806a12.3
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692369799; x=1692974599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dI9ZQNzqe2W46MHEhQwh22zo1t4+PZrthdWYrt5Eodk=;
        b=lEMPxIe+SwoHD55SXzQjuumUhef+DSOxSuOl1NMigACxe7Fg/k3ximhHk8R6euFctL
         IyoPPpthixM/I7MHvOYNCpOkoLqCUtO7i1hcUhfODapb+9f6k7yxgqYUGs0JfQRTaJLh
         sS3oPKGwyjYTm00C1bsylGOGmAGyetzYzE578=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692369799; x=1692974599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dI9ZQNzqe2W46MHEhQwh22zo1t4+PZrthdWYrt5Eodk=;
        b=Myv6hkPDWSKEIjZxzFVQlQXXGROoXKljsc03HIvtC+EFbFGteTvgkvmo8Zq3bbm8mq
         MV0udPGh6fByzoEe3s+NG2wzwJ5LKnPioWuSfmEXc2hGRvn4L0r1xxUPFxFP7qx4oA5b
         rjXsCsL1DVctU9OvJO4aQgaqTIQzLD6gMTvlODVpDH0/26SAJPjqVC68Qf3CO+jgKPQ8
         bVMiJ3miWqZB6mZPBvL8f33jPBlMu6sq7cjMgpSMqi4lYp9ZZ9DcKgPKLFmruJpEd0nl
         63F0FB0/3d1BIfEc7JbX6lldywtCpmKanSne3Xa28Zvh8MBQyPc4QejBvac1tC27zPQ5
         Nw6Q==
X-Gm-Message-State: AOJu0YxjHersbyK8V/Fe4I6dcZ8d7il4kWuEDb4yzJ8s6tua1mv541aV
	Ij/chWbEcOVGpSHnRmeywsYekDPnTLo+ibbzZPxXAQ==
X-Google-Smtp-Source: AGHT+IErHdVC7BYjFNhSlGtL/JSumk+79LBrrHCwUljiKbscXCNIYXKYIf9tkkXe3Ol1yvp/wSfzQfcwKfD1l4TAlaU=
X-Received: by 2002:aa7:d742:0:b0:525:45dc:40b7 with SMTP id
 a2-20020aa7d742000000b0052545dc40b7mr2170575eds.17.1692369799061; Fri, 18 Aug
 2023 07:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814112421.5a2fa4f6@kernel.org> <20230817131612.M_wwTr7m@linutronix.de>
In-Reply-To: <20230817131612.M_wwTr7m@linutronix.de>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 18 Aug 2023 09:43:08 -0500
Message-ID: <CAO3-Pbo7q6Y-xzP=3f58Y3MyWT2Vruy6UhKiam2=mAKArxgMag@mail.gmail.com>
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 8:16=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-08-14 11:24:21 [-0700], Jakub Kicinski wrote:
> > On Mon, 14 Aug 2023 11:35:26 +0200 Sebastian Andrzej Siewior wrote:
> > > The RPS code and "deferred skb free" both send IPI/ function call
> > > to a remote CPU in which a softirq is raised. This leads to a warning=
 on
> > > PREEMPT_RT because raising softiqrs from function call led to undesir=
ed
> > > behaviour in the past. I had duct tape in RT for the "deferred skb fr=
ee"
> > > and Wander Lairson Costa reported the RPS case.
> >
> > Could you find a less invasive solution?
> > backlog is used by veth =3D=3D most containerized environments.
> > This change has a very high risk of regression for a lot of people.
>
> Looking at the cloudflare ppl here in the thread, I doubt they use
> backlog but have proper NAPI so they might not need this.
>
Cloudflare does have backlog usage. On some veths we have to turn GRO
off to cope with multi-layer encapsulation, and there is also no XDP
attached on these interfaces, thus the backlog is used. There are also
other usage of backlog, tuntap, loopback and bpf-redirect ingress.
Frankly speaking, making a NAPI instance "threaded" itself is not a
concern. We have threaded NAPI running on some veth for quite a while,
and it performs pretty well. The concern, if any, would be the
maturity of new code. I am happy to help derisk with some lab tests
and dogfooding if generic agreement is reached to proceed with this
idea.

Yan

> There is no threaded NAPI for backlog and RPS. This was suggested as the
> mitigation for the highload/ DoS case. Can this become a problem or
> - backlog is used only by old drivers so they can move to proper NAPI if
>   it becomes a problem.
> - RPS spreads the load across multiple CPUs so it unlikely to become a
>   problem.
>
> Making this either optional in general or mandatory for threaded
> interrupts or PREEMPT_RT will probably not make the maintenance of this
> code any simpler.
>
> I've been looking at veth. In the xdp case it has its own NAPI instance.
> In the non-xdp it uses backlog. This should be called from
> ndo_start_xmit and user's write() so BH is off and interrupts are
> enabled at this point and it should be kind of rate-limited. Couldn't we
> bypass backlog in this case and deliver the packet directly to the
> stack?
>
> Sebastian



--=20

Yan

