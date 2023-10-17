Return-Path: <netdev+bounces-41639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21CE7CB812
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C85328141E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E566B17D2;
	Tue, 17 Oct 2023 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTR92KVf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA41FD5
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:41:19 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DD09B
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:41:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso1022e87.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697506876; x=1698111676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7yEIoOo6qiH/PstI18lX2FjmHyxn6PPTox69S0bHPU=;
        b=BTR92KVf7iXoxaiHUQSo08au0SsJnmsCFgtTs1loudVRuXbAReAfPzRfQNwr9LyqsJ
         axxUQOldod0ZS2f/KIhaMFTYCXHwDQu9svCc7ELjLTaUSi9ecfyM/GXsyW6XPWJyQ7Iv
         KWhdOCA0owiZgKXcEdFP7TKUh6QdbM5lOBXiTeLi7M4pwlXcuK++zqElgYnNUbPTZE2g
         24jQCg/arJKYMkakyb4OTme2mfhqsVkrsR+Ofl3dUk7p3qr3piVoXpPNkOF5ynMH15FT
         gbmiU/aVVJdmonLyiV0eKmtLQO93yWIW0U8qI2elfEDHprkoIqwjUmv+Uwyv26IuuThb
         K1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697506876; x=1698111676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7yEIoOo6qiH/PstI18lX2FjmHyxn6PPTox69S0bHPU=;
        b=v2wBNjDOyOBzGwIbIVw3PbAr/K/N5cH3aAww04ypo2UDU/Kc/g5vjIzGzwYKQkfdYg
         or1eL1qFZbyk7jQs6ZOJIysDp7BhO1LHcGBYTQlfY4zaVgWSGIUNneYBbiJigRBO6hdt
         x63yjjZvhep3O1f1J9P6L94YAmD0G+0jkm6T+Sw2XkEKoZWeeohWHX1gxEuaiB25+Uvg
         QZLWy/SUtJXlZse3XHjrp1fkXaG6MEupqZIWuuagPAqp4itgASaiDrEO+zTR3KFDZaRW
         WrIrTJGcI4PWB2zTtceDjvPzfB4yLK4CoPt5yXrSpD5M4B9NJgx35a7DM2GvT/HgFVlZ
         OTIQ==
X-Gm-Message-State: AOJu0YzxyOiMBpAsAB2qAjBHlr986U8zocCnNBQ3KVbd0r4SKx9Pi8wl
	r35sPJxmR/qxYReWn/Ohrr9/Wq/l/JvdA0hJwTICug==
X-Google-Smtp-Source: AGHT+IFyQxCiH4kTROLVbdIEBIcXbzBxrNJj/g7oLASDIhci/OS9n6CQcrMMnthY4R9HNh6pK/0fOXovo1ob1GZq/6o=
X-Received: by 2002:a05:6512:3e9:b0:507:9a37:1483 with SMTP id
 n9-20020a05651203e900b005079a371483mr23191lfq.3.1697506875821; Mon, 16 Oct
 2023 18:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916010625.2771731-1-lixiaoyan@google.com>
 <942de224-f18b-474d-b75b-6f08f66541c9@lunn.ch> <CADjXwjjP_8mM8y6KRF6_VQDpM7-UAXKDW02gRKf3FeJijnjSPA@mail.gmail.com>
In-Reply-To: <CADjXwjjP_8mM8y6KRF6_VQDpM7-UAXKDW02gRKf3FeJijnjSPA@mail.gmail.com>
From: Coco Li <lixiaoyan@google.com>
Date: Mon, 16 Oct 2023 18:41:04 -0700
Message-ID: <CADjXwji3cWtgcO9gzgTE06wOsOnYFcQhj-tDcbJ6UGVj+BC5PA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello all,

There are some issues in the arm64 testbeds that we have access to
internally and the solution is not short term, so we are unable to
data for other arches at the moment.

Note that the optimization should be platform generic, and the cache
line organization is not tied to a specific cache line size, so for
other arches we'd also expect some improvements. We merely use x86 as
an example of the platforms accessible to us.

Thank you for the reviews!

Best,
Coco



On Wed, Sep 20, 2023 at 11:47=E2=80=AFPM Coco Li <lixiaoyan@google.com> wro=
te:
>
> As replied in the other patch, we have arm64 platform in our testbeds
> with smaller L3 cache (1.375MB vs 256Mb on AMD), but its L1/L2 cache
> is similar or even bigger than our AMD platform cache. We will send
> results with this platform in the next update.
>
> Thank you for your suggestions.
>
>
> On Sat, Sep 16, 2023 at 7:23=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrot=
e:
> >
> > On Sat, Sep 16, 2023 at 01:06:20AM +0000, Coco Li wrote:
> > > Currently, variable-heavy structs in the networking stack is organize=
d
> > > chronologically, logically and sometimes by cache line access.
> > >
> > > This patch series attempts to reorganize the core networking stack
> > > variables to minimize cacheline consumption during the phase of data
> > > transfer. Specifically, we looked at the TCP/IP stack and the fast
> > > path definition in TCP.
> > >
> > > For documentation purposes, we also added new files for each core dat=
a
> > > structure we considered, although not all ended up being modified due
> > > to the amount of existing cache line they span in the fast path. In
> > > the documentation, we recorded all variables we identified on the
> > > fast path and the reasons. We also hope that in the future when
> > > variables are added/modified, the document can be referred to and
> > > updated accordingly to reflect the latest variable organization.
> > >
> > > Tested:
> > > Our tests were run with neper tcp_rr using tcp traffic. The tests hav=
e $cpu
> > > number of threads and variable number of flows (see below).
> > >
> > > Tests were run on 6.5-rc1
> > >
> > > Efficiency is computed as cpu seconds / throughput (one tcp_rr round =
trip).
> > > The following result shows Efficiency delta before and after the patc=
h
> > > series is applied.
> > >
> > > On AMD platforms with 100Gb/s NIC and 256Mb L3 cache:
> >
> > Would it be possible to run the same tests on a small ARM, MIPS or
> > RISC-V machine?  Something with small L1 and L2 cache, and no L3
> > cache. You sometimes hear that the Linux network stack has become too
> > big for small embedded systems, it is thrashing the caches. I suspect
> > this change will help such machine. But i suppose it could also be bad
> > for them. We won't know until it is tested.
> >
> >     Andrew
> >

