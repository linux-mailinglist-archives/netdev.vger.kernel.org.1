Return-Path: <netdev+bounces-60487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA93581F836
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 13:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900501F23F43
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 12:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD05747D;
	Thu, 28 Dec 2023 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LuMxcYeb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9378D748F
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e74b4d5445so48486887b3.1
        for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 04:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703766953; x=1704371753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bC0m0oYezRsDgswr+7ji0W0q8+R6TuA86SrFNkLkllg=;
        b=LuMxcYebUUAwU2px/vH4bK8Rs8WSwFHeEJqHwFXSwGOc5FjY4kYkxniUtR7NDlaabS
         bsyrEycIl2s4fg1No1ofYycVj+2HtEdB1EGXIgTl+ZTU2wcAlU9FI0jNpanqJRHVYUsM
         UzVS83e8hk7Tge3L9gblLWjFflxItyLgeKpYhtlfe0zB/DfAzQeGWqsCs6R99DNhndYR
         Qj8XJjTw4CJ00yh+5mhjWWhEVMjxAE0jfhD5Zb5XFtWcH91UJ9Ku8Rb4xMY8SkpJRsPH
         2LUqvh2l1UKR8jZiVZsklF5qoctWgzKYsm7xeiw8qthUGN4L4QyIwb1itkI54qAEAh2H
         AF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703766953; x=1704371753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bC0m0oYezRsDgswr+7ji0W0q8+R6TuA86SrFNkLkllg=;
        b=i7PpRdZS8HYZcpBj/cRItmkZfYQvVJH1qyb6lZeswVA2Yt5leDO4XEIMjtNoGA+PNJ
         A3/HYqLzhRqvIRAllXcWzk3/Thb7eMedaWRBSleLTGoCghbvkAaDoSYIRl8N3mc6dkES
         zmp+kEoHMypfjlD0Si9j5nDzFl/uMgsitAogz2DpLeCLQqYZIOVy8I5weOYf4GrSZ57Z
         NZukhn2NaY+SLCnp7vlCjsYKxld8bYPIezDtW7ShOny24H7YIKNcCiIiC1Thb2/VBM8E
         V2w8fE6BT2mVki16XnF66nRZFGNQKoSx2HYRzFSCuqldc+is7F+Fvf1siCXj71CzQUh/
         3x0Q==
X-Gm-Message-State: AOJu0YwsRlrYD25mmO53tEKQdGJVAwAyh+tDfG5cgG3EiAIl3pKQv9S6
	idC+gjxKH1bJunnEQwQ+5NG3lwK1KoEkwDL7z2Xwd2zqKk0p+9alQKUD2eg=
X-Google-Smtp-Source: AGHT+IGt18G0g1dL/KxtMoY4ibrqiLv+A3lS0DWzUe8vE2m4kddYU6F67i1ZfnMyayQc7SQ9tBjJbolnCJ9N6j261oQ=
X-Received: by 2002:a05:690c:270d:b0:5e7:9bfd:779d with SMTP id
 dy13-20020a05690c270d00b005e79bfd779dmr6078844ywb.12.1703766953205; Thu, 28
 Dec 2023 04:35:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219181623.3845083-1-victor@mojatatu.com> <20231219181623.3845083-2-victor@mojatatu.com>
 <ZY1hBb8GFwycfgvd@shredder>
In-Reply-To: <ZY1hBb8GFwycfgvd@shredder>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 28 Dec 2023 07:35:40 -0500
Message-ID: <CAM0EoMkx6JAUdUdxsMe1hRxBVOQX-R0T+CVT=a3jAdKAxEd7GA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/5] net/sched: Introduce tc block netdev
 tracking infra
To: Ido Schimmel <idosch@idosch.org>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com, 
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 6:50=E2=80=AFAM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> On Tue, Dec 19, 2023 at 03:16:19PM -0300, Victor Nogueira wrote:
> > +static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *d=
ev,
> > +                            struct netlink_ext_ack *extack)
> > +{
> > +     const struct Qdisc_class_ops *cl_ops =3D sch->ops->cl_ops;
> > +     struct tcf_block *block;
> > +     int err;
> > +
> > +     block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>
> Another problem, shouldn't there be a check that these operations are
> actually implemented? The following now crashes with a NULL pointer
> dereference:
>
> # tc qdisc replace dev swp1 root handle 1: tbf rate 1Mbit burst 256k limi=
t 1M


I think this broke from v7->v8. Thanks for catching this. We'll send a
fix shortly.

cheers,
jamal

> > +     if (block) {
> > +             err =3D xa_insert(&block->ports, dev->ifindex, dev, GFP_K=
ERNEL);
> > +             if (err) {
> > +                     NL_SET_ERR_MSG(extack,
> > +                                    "ingress block dev insert failed")=
;
> > +                     return err;
> > +             }
> > +     }
> > +
> > +     block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
> > +     if (block) {
> > +             err =3D xa_insert(&block->ports, dev->ifindex, dev, GFP_K=
ERNEL);
> > +             if (err) {
> > +                     NL_SET_ERR_MSG(extack,
> > +                                    "Egress block dev insert failed");
> > +                     goto err_out;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +
> > +err_out:
> > +     block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> > +     if (block)
> > +             xa_erase(&block->ports, dev->ifindex);
> > +
> > +     return err;
> > +}
> > +
> >  static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **=
tca,
> >                                  struct netlink_ext_ack *extack)
> >  {
> > @@ -1350,6 +1387,10 @@ static struct Qdisc *qdisc_create(struct net_dev=
ice *dev,
> >       qdisc_hash_add(sch, false);
> >       trace_qdisc_create(ops, dev, parent);
> >
> > +     err =3D qdisc_block_add_dev(sch, dev, extack);
> > +     if (err)
> > +             goto err_out4;
> > +
> >       return sch;
> >
> >  err_out4:

