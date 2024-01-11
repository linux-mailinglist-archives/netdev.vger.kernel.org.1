Return-Path: <netdev+bounces-63094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C480D82B2E8
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 17:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92241C21CD6
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1674F5FB;
	Thu, 11 Jan 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NTm3gxkW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFBC28E33
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40b5155e154so70921645e9.3
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 08:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704990451; x=1705595251; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pce3TyUU1ijjK5OCvutHzeGTlpt2KdritH1L2p2VA40=;
        b=NTm3gxkWpdgoVTk5SKoPTuBRw/3tzXRh0ZjwGTnDWh0NNDpnuL40P12FF2b4sZglE5
         I3GdCirp8nkvgih4WZVErD9Gag8MbUqFOCVL4qZyVyzBzWPxZRIki2ZYYP5H2FiNKBDk
         gJQh/EikZCjSr3ADovjo92CkIWdY/35y/1yABNGlMkKtuEEIOc5t8CrJAsgoF/bGo/Fo
         yOSVz/CddwQEpzDJxNIMojab8Ut/QzMSdosR/CgpGwnYpkVr4/8zVhy6ggsWmYB2EQlj
         ITTYVg/ru3UTwHyV0QRm8SX0hGz4kpjoaCQaCzG1VIQEUfatXVZyfHeiDr0lE5JL4N/W
         4BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704990451; x=1705595251;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pce3TyUU1ijjK5OCvutHzeGTlpt2KdritH1L2p2VA40=;
        b=G17tDBe+PrsTr3eJDZPSFIRbs6aflLccZbgSETF48xnNDZcjGDVYgfYHalVGwq0vgd
         3NoH/K/6rQ/OARJNS4hb68RwB5QYTATziAAH81AjkAOFzmeUG8NJqy5Hsm1GPjSGFXZf
         kOFG7GoIEKtUDA0hutfoAjQrJA2A9p6fLIlLZx70BXD3K0ydIHvZlu3B5OqfRK9ZVJBw
         zsOgLAWsByyMW36aak2QinKJyNpbDtg8lUn0hIOUfJyqIpoHf8KPPgXc8/KONoGiJKFO
         n//plIsq+gwtJi0aFb2qJZ2UwxVwuHEkGGLdiK2o0qyAElFZUGfxZmnrBtH20H201Obx
         MmnA==
X-Gm-Message-State: AOJu0YyLy9ggqzCpJFJzp/9wqfkFTErNumN3HbFUyV01YXK9LesnDhig
	axfkd+HsRDoZOdEKM1nQqTU6feRZwJzS5w==
X-Google-Smtp-Source: AGHT+IE4s2OBZd8FiVG8lCHxy4Bn0cVUJHSgVb74LzsrFySznRxpB437lu4+N+bW8Wssk9Gf8di7Lg==
X-Received: by 2002:a05:600c:314a:b0:40b:5e21:bddf with SMTP id h10-20020a05600c314a00b0040b5e21bddfmr42236wmo.110.1704990451134;
        Thu, 11 Jan 2024 08:27:31 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm2493689wmq.12.2024.01.11.08.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:27:30 -0800 (PST)
Date: Thu, 11 Jan 2024 17:27:29 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, xiyou.wangcong@gmail.com, victor@mojatatu.com,
	pctammela@mojatatu.com, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com, Petr Machata <petrm@nvidia.com>
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Message-ID: <ZaAW8fRkfcDmfFCn@nanopsycho>
References: <20240104125844.1522062-1-jiri@resnulli.us>
 <ZZ6JE0odnu1lLPtu@shredder>
 <CAM0EoM=AGxO0gdeHPi7ST0+-YVuT20ysPbrFkYVXLqGv39oR7Q@mail.gmail.com>
 <CAM0EoMkpzsEWXMw27xgsfzwA2g4CNeDYQ9niTJAkgu3=Kgp81g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkpzsEWXMw27xgsfzwA2g4CNeDYQ9niTJAkgu3=Kgp81g@mail.gmail.com>

Thu, Jan 11, 2024 at 04:42:55PM CET, jhs@mojatatu.com wrote:
>On Thu, Jan 11, 2024 at 10:40 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>
>> On Wed, Jan 10, 2024 at 7:10 AM Ido Schimmel <idosch@idosch.org> wrote:
>> >
>> > On Thu, Jan 04, 2024 at 01:58:44PM +0100, Jiri Pirko wrote:
>> > > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>> > > index adf5de1ff773..253b26f2eddd 100644
>> > > --- a/net/sched/cls_api.c
>> > > +++ b/net/sched/cls_api.c
>> > > @@ -1428,6 +1428,7 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
>> > >                     struct tcf_block_ext_info *ei,
>> > >                     struct netlink_ext_ack *extack)
>> > >  {
>> > > +     struct net_device *dev = qdisc_dev(q);
>> > >       struct net *net = qdisc_net(q);
>> > >       struct tcf_block *block = NULL;
>> > >       int err;
>> > > @@ -1461,9 +1462,18 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
>> > >       if (err)
>> > >               goto err_block_offload_bind;
>> > >
>> > > +     if (tcf_block_shared(block)) {
>> > > +             err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> > > +             if (err) {
>> > > +                     NL_SET_ERR_MSG(extack, "block dev insert failed");
>> > > +                     goto err_dev_insert;
>> > > +             }
>> > > +     }
>> >
>> > While this patch fixes the original issue, it creates another one:
>> >
>> > # ip link add name swp1 type dummy
>> > # tc qdisc replace dev swp1 root handle 10: prio bands 8 priomap 7 6 5 4 3 2 1
>> > # tc qdisc add dev swp1 parent 10:8 handle 108: red limit 1000000 min 200000 max 200001 probability 1.0 avpkt 8000 burst 38 qevent early_drop block 10
>> > RED: set bandwidth to 10Mbit
>> > # tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000 min 500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent early_drop block 10
>> > RED: set bandwidth to 10Mbit
>> > Error: block dev insert failed.
>> >
>>
>>
>> +cc Petr
>> We'll add a testcase on tdc - it doesnt seem we have any for qevents.
>> If you have others that are related let us know.
>> But how does this work? I see no mention of block on red code and i
>> see no mention of block on the reproducer above.
>
>Context: Yes, i see it on red setup but i dont see any block being setup.
>Also: Is it only Red or other qdiscs could behave this way?

Just red.

>
>cheers,
>jamal
>> Are the qevents exception packets from the hardware? Is there a good
>> description of what qevents do?
>>
>> cheers,
>> jamal
>>
>>
>> > The reproducer does not fail if I revert this patch and apply Victor's
>> > [1] instead.
>> >
>> > [1] https://lore.kernel.org/netdev/20231231172320.245375-1-victor@mojatatu.com/
>> >
>> > > +
>> > >       *p_block = block;
>> > >       return 0;
>> > >
>> > > +err_dev_insert:
>> > >  err_block_offload_bind:
>> > >       tcf_chain0_head_change_cb_del(block, ei);
>> > >  err_chain0_head_change_cb_add:

