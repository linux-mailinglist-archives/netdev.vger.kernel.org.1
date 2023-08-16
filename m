Return-Path: <netdev+bounces-28021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5915E77E001
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 13:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204721C20D05
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E1B101CE;
	Wed, 16 Aug 2023 11:09:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD2DF6F
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 11:09:19 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDD3B5
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 04:09:18 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58d70c441d5so424957b3.2
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 04:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692184158; x=1692788958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46MmpKCDeYPr+9gXsONMhrxsJist0H6yLChd8yUgMyU=;
        b=OuuPQNbCg1QMqoM+zhRvoavtzRr1gThC4vkjQygT16D3DGb/0c4seiIBv1Omfh7K5o
         Pgf1rgPccXu0+xiAL/VXjc9HJQ/5oobDCsEazHrGDat1Ez5SNDtoXuy0bjdyDtdX8Xoy
         psQVSTt4fLhPlI/TJZqT3BwnrSackfz9LAXvA1/Dq1muCKZJ/MYMB3nB3YUOW98ax/25
         pp5ARwZ8Vb3NOJwxLwaeOPT1gSTf0eDxYqEbRAEgfO3Zir0p1A7UCYg86HvO999/6VFG
         wXCS5FyeeHbE5qZZH7Khr2IWNzHHEzFbmWP8+UC/r21TG4tVGWjw5Ykxri0SHEQuY8ZK
         1GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692184158; x=1692788958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46MmpKCDeYPr+9gXsONMhrxsJist0H6yLChd8yUgMyU=;
        b=Wpnhz7qH4NBAaNvNf/nQSO95KXYhYuF23ir3fVZzPG6qJ4nZF4wrNi1ddqK/hqbnnJ
         /WJYnyg8DLUAQrUFuDFMS8ma1hyIVF8001AGD4oaPzzfsBtE3sbGVTxtp935MCOvHoEQ
         UkmSCj8QsvNIAltDUO1l4fEmj9b3otXsqpdlPVRXI2Cpbo7cAeLNQi6UqkHTP3S5BN//
         Kpl9TeAs6V/dSQnxPSy8kL9Cflsw+QoUlYocz4r8zAIYaUc41hS8UO3h75O9HILGZrVb
         p90AkiZNyJXymBtEZHwsxBa0SllVaqD81Hg3pcsGLts3268C44IXwEfQwBULnW1A+tOY
         v+fQ==
X-Gm-Message-State: AOJu0Yzp4qWs0Ev63S7T0eMaAoi2W/l/qupiS+0ZtCESxKmvzAkr05te
	cqrN4is/gEUM2wpnwZFjltvBo/Skd07Rc65E53cPkg==
X-Google-Smtp-Source: AGHT+IFOf9yihukhwPEIoe2yIyvvkSVRFkChdspISLy5wcP5WyiEhD3vlVy6EI6YHmvkr/EJUWXE7QOs4hTcdx48Fek=
X-Received: by 2002:a0d:ca82:0:b0:576:916d:96b with SMTP id
 m124-20020a0dca82000000b00576916d096bmr1257470ywd.36.1692184157813; Wed, 16
 Aug 2023 04:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230815162530.150994-1-jhs@mojatatu.com> <20230815162530.150994-4-jhs@mojatatu.com>
 <ZNyRsOB0nfqhZM1m@vergenet.net>
In-Reply-To: <ZNyRsOB0nfqhZM1m@vergenet.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 16 Aug 2023 07:09:06 -0400
Message-ID: <CAM0EoMnRkScQbp6eNDADZkOX-tgL__ZMcATwUyBQYnet8PzN8A@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 3/3] Introduce blockcast tc action
To: Simon Horman <horms@kernel.org>
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

On Wed, Aug 16, 2023 at 5:07=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Aug 15, 2023 at 12:25:30PM -0400, Jamal Hadi Salim wrote:
> > This action takes advantage of the presence of tc block ports set in th=
e
> > datapath and broadcast a packet to all ports on that set with exception=
 of
> > the port in which it arrived on..
> >
> > Example usage:
> >     $ tc qdisc add dev ens7 ingress block 22
> >     $ tc qdisc add dev ens8 ingress block 22
> >
> > Now we can add a filter using the block index:
> > $ tc filter add block 22 protocol ip pref 25 \
> >   flower dst_ip 192.168.0.0/16 action blockcast
> >
> > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> ...
>
> > +//XXX: Refactor mirred code and reuse here before final version
> > +static int cast_one(struct sk_buff *skb, const u32 ifindex)
> > +{
> > +     struct sk_buff *skb2 =3D skb;
> > +     int retval =3D TC_ACT_PIPE;
> > +     struct net_device *dev;
> > +     unsigned int rec_level;
> > +     bool expects_nh;
> > +     int mac_len;
> > +     bool at_nh;
> > +     int err;
> > +
> > +     rec_level =3D __this_cpu_inc_return(redirect_rec_level);
> > +     if (unlikely(rec_level > CAST_RECURSION_LIMIT)) {
> > +             net_warn_ratelimited("blockcast: exceeded redirect recurs=
ion limit on dev %s\n",
> > +                                  netdev_name(skb->dev));
> > +             __this_cpu_dec(redirect_rec_level);
> > +             return TC_ACT_SHOT;
> > +     }
> > +
> > +     dev =3D dev_get_by_index_rcu(dev_net(skb->dev), ifindex);
> > +     if (unlikely(!dev)) {
> > +             pr_notice_once("blockcast: target device %s is gone\n",
> > +                            dev->name);
>
> Hi Jamal,
>
> This code is only executed if dev is NULL, but dev is dereferenced.
>

good catch;-> Cutnpaste thing..


cheers,
jamal
> > +             __this_cpu_dec(redirect_rec_level);
> > +             return TC_ACT_SHOT;
> > +     }
>
> ...

