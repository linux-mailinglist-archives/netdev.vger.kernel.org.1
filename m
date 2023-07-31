Return-Path: <netdev+bounces-22724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA95B768F53
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 10:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09911C20B50
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EBE79D4;
	Mon, 31 Jul 2023 08:01:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371C610C
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:01:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150EB1A4
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 01:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690790473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdMD0un6F8kT52bOwhep80N4AP3QqFZ9XYPsEhe2f2g=;
	b=X3aMeSXpk8OHl8r0p84ggEpBgpWAAShLJsdMrbW5BS+QLegYmGpQKmEMRFneIhOdITEUDy
	yUDZYzDa6V6onePpNK99RmIQXp5b8oRUM8hcfXoISF9b4wlyglJWTPiLoXp4KB7oPyDc7p
	8Hx8Mo+UZCvOUh3U3nkO5QzDbvdRaLs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-M8WmNfiPPCahyw-XkP0zFg-1; Mon, 31 Jul 2023 04:01:10 -0400
X-MC-Unique: M8WmNfiPPCahyw-XkP0zFg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9b50be2ccso33299901fa.2
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 01:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690790469; x=1691395269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdMD0un6F8kT52bOwhep80N4AP3QqFZ9XYPsEhe2f2g=;
        b=Jo1yEybeoF1nBrHPZqbv2KDriyS+fMa6XkIT6NkVabzy1iacrzZ2t/NsICpl6X59F3
         OVQ3kgHX8Pt2AZMb0ke8uX/cBgLvNvxm9yQUl5mh/rxRsKbfeY2mpypWbv4EKeF425tR
         WldNiUyeHvRZ0FuY5oY4KufoKqmBxAdPrwnx5KSKDVWcE9vgdmQKjzc1ZtsBY+AAgxMF
         bJ+eQmUab+icQmkWwYtQnAaCngA7Tha8vHcMrC4UozEpWNtPa7d4Mf49PonADHgTsGlO
         DzhODu1BCvyLD0MfZbW6rChAwy0ixWagDXAD4yfi8ITBzE3vHW3ctRIKx3e6wboiH1th
         Ux1A==
X-Gm-Message-State: ABy/qLbtbLYPaX/0PawM3AkZesQb5AX7l9lHdlVrEmzeK/BUuQkK5l35
	KtJ+anQTjQs9LiNaJOh3AIImuYlO2eHAR8H0/LBPDmFNJaq3kXJgX0VUeGFQxn3TBAGAUQjfeS1
	U5ex0LIfcQOIdREqpm+IZoizh/mPvz7fq
X-Received: by 2002:a2e:9589:0:b0:2b9:4aa1:71e1 with SMTP id w9-20020a2e9589000000b002b94aa171e1mr4956026ljh.50.1690790469144;
        Mon, 31 Jul 2023 01:01:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZvqwJE5X9x/V+0taJ5XWJIz7ugrw6Wi4UsMtG3IsqnQJ8i0TM8qd1BP/G6ysIPMSUHRntfXqGpMidaSJ+zL0=
X-Received: by 2002:a2e:9589:0:b0:2b9:4aa1:71e1 with SMTP id
 w9-20020a2e9589000000b002b94aa171e1mr4956012ljh.50.1690790468830; Mon, 31 Jul
 2023 01:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230728154059.1866057-1-pctammela@mojatatu.com> <CAM0EoMnjs4+6PPk_S9uTpFo1Lvd166AwFBZxkj+_BOBAx8yEPA@mail.gmail.com>
In-Reply-To: <CAM0EoMnjs4+6PPk_S9uTpFo1Lvd166AwFBZxkj+_BOBAx8yEPA@mail.gmail.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Mon, 31 Jul 2023 10:00:57 +0200
Message-ID: <CAKa-r6s0u8BEqXuPkMGOzLZLMz2PLhepq1sEKcgUysQ=6s_24g@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/2] selftests/tc-testing: initial steps for
 parallel tdc
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 29, 2023 at 12:49=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Fri, Jul 28, 2023 at 11:41=E2=80=AFAM Pedro Tammela <pctammela@mojatat=
u.com> wrote:
> >
> > As the number of tdc tests is growing, so is our completion wall time.
> > One of the ideas to improve this is to run tests in parallel, as they
> > are self contained. Even though they will serialize over the rtnl lock,
> > we expect it to give a nice boost.

[...]

>
> Davide, if you get an opportunity can you please test with these
> changes and add your tag?

sure, will do and provide feedback in a couple of days. Thanks!
--=20
davide


