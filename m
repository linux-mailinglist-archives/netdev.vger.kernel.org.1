Return-Path: <netdev+bounces-39320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9CB7BEC07
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098E71C20A48
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4BA3FB0F;
	Mon,  9 Oct 2023 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp9mD7eI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3A200B2
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:54:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F0A11A
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696884856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hb3hq909pNp3frMohyBnuH/S2+3vulVlHKnb6rm84OY=;
	b=Xp9mD7eIrV3ckN9i1Qbw+QWd4Mu77cUbe+UwtVQbOwcbxzdALLDVHhuDYdXv2XoJQ7udFN
	yCeDbjy5GElDlpDkSynYnLVpk9lHVRMOYuC2wl8MzMGDzsGrVtXjSrSf6v0EBHw5fQPkqI
	yIJkzhvOS4v4R0T13jVeo/QQbslhtPE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-Uug9_P_EOB-lWkbIa8Alsw-1; Mon, 09 Oct 2023 16:54:10 -0400
X-MC-Unique: Uug9_P_EOB-lWkbIa8Alsw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99c8bbc902eso398582266b.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 13:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696884849; x=1697489649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hb3hq909pNp3frMohyBnuH/S2+3vulVlHKnb6rm84OY=;
        b=h3HUbh4kGkgsK+qPms7TmgJKZMSQgXmCX9ueGUWSPUk4TPowfaDU/+cR3joKNv8OoD
         4V7iShiXkZE5Wfcb9JU1HzW/towbTZkn2wwgjUStuleTljUdRI3sk+/XCENxY/uieRc2
         b9QVJzFuAeIIz3fpNdrcVNQNgAdmhpM4BQLPj1HIKJGMZ5Z5v/szu5wAQrApUro6yZVj
         BeFtEKrHOJtoQfIGBlxx2M/+mUfuMEC9LITpF4/Y9RWTUPztueoS7JqUjxTRiCDzbLhq
         J4QzgMH+H0vsnysg0DcNSSQhdEoayDX9Ju3jHNXKKfmNYRQVgRzstpCSTqJPldlEpGV+
         hURQ==
X-Gm-Message-State: AOJu0YxBK7qlmHt2hE0ikHk0DpweVmqUBxjUjHLVUYw2fSq3r1/6L1N3
	euoPqFXQ6v3wH8mDey+QPwDOKYwWt9FAHuBLRlpDwNAR5eFuT2Cmf6A9Vo80r9+3tNCzRWhMcwF
	5iJIettPYpHkVrqhcL9iXPqA0giMLrODO
X-Received: by 2002:a50:ee8b:0:b0:530:e180:ab9a with SMTP id f11-20020a50ee8b000000b00530e180ab9amr14662289edr.3.1696884849152;
        Mon, 09 Oct 2023 13:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1/+xRpZTLk/nnXzBKR1haA4FjEa7cXJ4f7YFQhOVySeHp9cLVf5caDcZANqSOwziKk7m4HHpNP9yM4mbsA2M=
X-Received: by 2002:a50:ee8b:0:b0:530:e180:ab9a with SMTP id
 f11-20020a50ee8b000000b00530e180ab9amr14662270edr.3.1696884848868; Mon, 09
 Oct 2023 13:54:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Oct 2023 13:54:07 -0700
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <CAM0EoM=HDgawk5W70OxJThVsNvpyQ3npi_6Lai=nsk14SDM_xQ@mail.gmail.com>
 <ZSA60cyLDVw13cLi@nanopsycho> <CAM0EoMn1rNX=A3Gd81cZrnutpuch-ZDsSgXdG72uPQ=N2fGoAg@mail.gmail.com>
 <20231006152516.5ff2aeca@kernel.org> <CAM0EoM=LMQu5ae53WEE5Giz3z4u87rP+R4skEmUKD5dRFh5q7w@mail.gmail.com>
 <ZSEw32MVPK/qCsyz@nanopsycho> <CAM0EoMnJszhTDFuYZHojEZtfNueHe_WDAVXgLVWNSOtoZ2KapQ@mail.gmail.com>
 <ZSFSfPFXuvMC/max@nanopsycho> <CAM0EoMmKNEQuV8iRT-+hwm2KVDi5FK0JCNOpiaar90GwqjA-zw@mail.gmail.com>
 <ZSGTdA/5WkVI7lvQ@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZSGTdA/5WkVI7lvQ@nanopsycho>
Date: Mon, 9 Oct 2023 13:54:07 -0700
Message-ID: <CALnP8ZbD_09u+Qqd2N4VcrstuGexh7TiNAtL7n4pyUvLAQ8EOw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/3] net/sched: Introduce tc block ports
 tracking and use
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, vladbu@nvidia.com, 
	simon.horman@corigine.com, pctammela@mojatatu.com, netdev@vger.kernel.org, 
	kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 07, 2023 at 07:20:52PM +0200, Jiri Pirko wrote:
> Sat, Oct 07, 2023 at 04:09:15PM CEST, jhs@mojatatu.com wrote:
> >On Sat, Oct 7, 2023 at 8:43=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wro=
te:
...
> >> My primary point is, this should be mirred redirect to block instead o=
f
> >> what we currently have only for dev. That's it.
> >
> >Agreed (and such a feature should be added regardless of this action).
> >The tc block provides a simple abstraction, but do you think it is
> >enough? Alternative is to use a list of ports given to mirred: it
> >allows us to group ports from different tc blocks or even just a
> >subset of what is in a tc block - but it will require a lot more code
> >to express such functionality.
>
> Again, you attach filter to either dev or block. If you extend mirred
> redirect to accept the same 2 types of target, I think it would be best.

The difference here between filter and action here is that you don't
really have an option for filters: you either attach it to either dev
or block, or you create an entire new class of objects, say,
"blockfilter", all while retaining the same filters, parameters, etc.
I'm not aware of a single filter that behaves differently over a block
than a netdev.

But for actions, there is the option, and despite the fact that both
"output packets", the semantics are not that close. It actually
helps with parameter parsing, documentation (man pages), testing (as
use and test cases can be more easily tracked) and perhaps more
importantly: if I don't want this feature, I can disable the new
module.

Later someone will say "hey why not have a hash_dst_selector", so it
can implement a load balancer through the block output? And mirred,
once a simple use case (with an already complex implementation),
becomes a partial implementation of bonding then. :)

In short, I'm not sure if having the user to fiddle through a maze of
options that only work in mode A or B or work differently is better
than having more specialized actions (which can and should reuse code).

  Marcelo


