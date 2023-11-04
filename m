Return-Path: <netdev+bounces-46051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A387E101F
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 16:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C3F281604
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB41BDD9;
	Sat,  4 Nov 2023 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="sbW+jIaj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1DD18AF6
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 15:46:37 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3754ADB
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 08:46:36 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-da819902678so1433631276.1
        for <netdev@vger.kernel.org>; Sat, 04 Nov 2023 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699112795; x=1699717595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlXlSm0Y7Yq50KmWSE2Soop/FzqcxgJGgu+l7Gpe/dU=;
        b=sbW+jIaj4EtRTULG6es1pW1Sb93ScrMfCSWRLpVoIPVy0QN+gUJm+dkryIhz7LV+Th
         Y0/2UFZa+xba1G1xHZ+6pEZPOOhzcgYb/eDK6z3rYzxJFMn9SCmgbPIKmfg8205uXg1Z
         vnSrxY+wiBoZEvZHsEUv0e5ZoR6ORXlms60DXom36iy26NMhKldokyxColYC9CXs57gP
         /LzAh7DnWAcHjNEd0sMXdXr/HZKu4/8YRmSDO2+flAOwVi5PBYZem7QV/gWacVsm40eg
         tTFvtzrfjBuH3kb308ocx4zzt9Mau992HIA2cqigq1Lf6XBHPyZBwIR2D7qpkE/5Sm8u
         DAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699112795; x=1699717595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlXlSm0Y7Yq50KmWSE2Soop/FzqcxgJGgu+l7Gpe/dU=;
        b=W95AWyd4yPsM3k7DDcTzTw9ZUjNl1aKHynvllwKilzRtYU+8lc7Yo+8fzmXpodaZVL
         rnAM6eLWJrlgJnhU2Co863lQnc0M58Iv1H0nHh5eHexTolrhA6ekigMNJrqM9FC2+gCx
         fWHX1eajYOL12FjW/EIvHbmOe4HnfVfOj9dVfh7a7m+ZRzLvULS4yzo4I55a8q/grrff
         38rS06IESjbsKuE+wx79fZnQIzmxm/IHTY8s0b4HbAVnFFL696J1H/mD1MXj+6onGGZF
         BfMDZ7CDZGX9MADq+LKanl/bNGR4Vf8SqGKNSRKwInm2syOOG0D4TYxDrSa+GGlmSPvC
         anlw==
X-Gm-Message-State: AOJu0YxMmLclvu9Q/NOPcMYHqNh0yU8dKUQv6DPAbtXplf6T+QLRLZlK
	rRZy2yABmAcIIaO/UdM9nBvnJ64/XUkeA8YPGe5ujg==
X-Google-Smtp-Source: AGHT+IEsfHBmUeJSPGul/D9+TvQcxOj3LTSndfN4g1M0S97002PnUZsfPg+hWQAlEGT0n+VFdWBAvk9pw6fALWVBWn0=
X-Received: by 2002:a25:da97:0:b0:d9b:87f3:54fa with SMTP id
 n145-20020a25da97000000b00d9b87f354famr25157963ybf.16.1699112795312; Sat, 04
 Nov 2023 08:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231028171610.28596-1-jhs@mojatatu.com> <20231104131054.GB891380@kernel.org>
In-Reply-To: <20231104131054.GB891380@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 4 Nov 2023 11:46:22 -0400
Message-ID: <CAM0EoMn195kQXDq9hn=NZoCNHOVyh3qS1kGxN+N3q4qNXj2mVA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net, sched: Fix SKB_NOT_DROPPED_YET splat under
 debug config
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	daniel@iogearbox.net, idosch@idosch.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 4, 2023 at 9:11=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Sat, Oct 28, 2023 at 01:16:10PM -0400, Jamal Hadi Salim wrote:
> > Getting the following splat [1] with CONFIG_DEBUG_NET=3Dy and this
> > reproducer [2]. Problem seems to be that classifiers clear 'struct
> > tcf_result::drop_reason', thereby triggering the warning in
> > __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0).
> >
> > Fixed by disambiguating a legit error from a verdict with a bogus drop_=
reason
> >
> > [1]
> > WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason+0x3=
8/0x130
> > Modules linked in:
> > CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6d958=
2e0 #682
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc=
37 04/01/2014
> > RIP: 0010:kfree_skb_reason+0x38/0x130
> > [...]
> > Call Trace:
> >  <IRQ>
> >  __netif_receive_skb_core.constprop.0+0x837/0xdb0
> >  __netif_receive_skb_one_core+0x3c/0x70
> >  process_backlog+0x95/0x130
> >  __napi_poll+0x25/0x1b0
> >  net_rx_action+0x29b/0x310
> >  __do_softirq+0xc0/0x29b
> >  do_softirq+0x43/0x60
> >  </IRQ>
> >
> > [2]
> >
> > ip link add name veth0 type veth peer name veth1
> > ip link set dev veth0 up
> > ip link set dev veth1 up
> > tc qdisc add dev veth1 clsact
> > tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:11:2=
2:33:44:55 action drop
> > mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1
> >
> > Ido reported:
> >
> >   [...] getting the following splat [1] with CONFIG_DEBUG_NET=3Dy and t=
his
> >   reproducer [2]. Problem seems to be that classifiers clear 'struct
> >   tcf_result::drop_reason', thereby triggering the warning in
> >   __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0). [=
...]
> >
> >   [1]
> >   WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason+0=
x38/0x130
> >   Modules linked in:
> >   CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6d9=
582e0 #682
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.=
fc37 04/01/2014
> >   RIP: 0010:kfree_skb_reason+0x38/0x130
> >   [...]
> >   Call Trace:
> >    <IRQ>
> >    __netif_receive_skb_core.constprop.0+0x837/0xdb0
> >    __netif_receive_skb_one_core+0x3c/0x70
> >    process_backlog+0x95/0x130
> >    __napi_poll+0x25/0x1b0
> >    net_rx_action+0x29b/0x310
> >    __do_softirq+0xc0/0x29b
> >    do_softirq+0x43/0x60
> >    </IRQ>
> >
> >   [2]
> >   #!/bin/bash
> >
> >   ip link add name veth0 type veth peer name veth1
> >   ip link set dev veth0 up
> >   ip link set dev veth1 up
> >   tc qdisc add dev veth1 clsact
> >   tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:11=
:22:33:44:55 action drop
> >   mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1
> >
> > What happens is that inside most classifiers the tcf_result is copied o=
ver
> > from a filter template e.g. *res =3D f->res which then implicitly overr=
ides
> > the prior SKB_DROP_REASON_TC_{INGRESS,EGRESS} default drop code which w=
as
> > set via sch_handle_{ingress,egress}() for kfree_skb_reason().
> >
> > Commit text above copied verbatim from Daniel. The general idea of the =
patch
> > is not very different from what Ido originally posted but instead done =
at the
> > cls_api codepath.
> >
> > Fixes: 54a59aed395c ("net, sched: Make tc-related drop reason more flex=
ible")
> > Reported-by: Ido Schimmel <idosch@idosch.org>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Link: https://lore.kernel.org/netdev/ZTjY959R+AFXf3Xy@shredder
>
> Hi Jamal,
>
> FWIIW, I think it would be nicer to fix this the classifiers so they don'=
t
> do this, which by my reading is what Daniel's patch did.
>

I dont believe it was nicer tbh.
In any case we are going to send cleanups to do this with skb cb.

> But, I don't feel strongly about this and I do tend to think the
> approach taken in this patch is a nice clean fix for net.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> BTW, this patch is marked as Not Applicable in patchwork.
> I am unsure why.

Weird.

cheers,
jamal

