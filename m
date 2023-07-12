Return-Path: <netdev+bounces-17165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736EF750A6B
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20453281225
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3412834CCB;
	Wed, 12 Jul 2023 14:03:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2046B100AE
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:03:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C441FCE
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689170583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ff75lVqnviMUw9kr1GYOCVrLQLrXARFNJSPnn3gSjJA=;
	b=GZb8eNLTwZqm30LvDXbkDy+6ps/L9r6EnQGnrhE836pC+tTKXSCA62+N9cHGB/hiTIncOM
	3iNlsxaoJKXdn3uibrQVBILzNUD0WdJkj3cCaAUC2Z/7OVcayDVHwXmRBffP6OfekW9lMD
	sxeAjkArkIvOjspMbKiVf+eOgFvfjdk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-M0hBL9l8OfKtW_kxCbbkkw-1; Wed, 12 Jul 2023 10:03:00 -0400
X-MC-Unique: M0hBL9l8OfKtW_kxCbbkkw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb7bd971aeso470200e87.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689170575; x=1691762575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ff75lVqnviMUw9kr1GYOCVrLQLrXARFNJSPnn3gSjJA=;
        b=TrJI4Ra5c7213Svwa8WjpaHUq+tumb5i6fakyP794ztg9QLXLg+jlESgCj3G831uij
         qhE+wkxmqs0pftnwAYwjCMhl2VrUJeTFF4PeukBA/RVhPBCI4aj+aRKOnC+f/Vvzc5JE
         XQtU4M8iSMhjXKQJpbzMCT5RVdCpCNMv77rKlfEDZSYzsh4O70gDpxCRyiTOExgzGkbT
         EY78AKKyHsbPPQCqENm+Ls4SBUUsR2A2KstQ9KLTTWPT8TgBrC6AVlwReU5cRWEU4iEi
         ZT1SZlKfQPP3Be3xuICwdiQ/p7wktKwJBpdtXIVcpgCoh0YnKUCLLU16pod/pipYcLuw
         xNEQ==
X-Gm-Message-State: ABy/qLaXu0lAByvCuEy4JC7uM1dXg1N6k4Y6pQnPgdx25tXz18xUkvm2
	iFNXtDVANt9qJ+bFOCxVPF/xjLFVKdVXeDciBEpnoiR/K5kBxeXroiKQ2KWoeeBjTT4IkYQ9Zzw
	g7Tp2Cc77ekn4ZTW0PCRvG0SQYqlzsR3l
X-Received: by 2002:a05:6512:2315:b0:4f6:3ef3:13e8 with SMTP id o21-20020a056512231500b004f63ef313e8mr784485lfu.0.1689170575532;
        Wed, 12 Jul 2023 07:02:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGXivV9H/TvZmBUA+rpgLU42Nr4MJhFBVBRliYUdN+AjkVbBKeQr0s1w/jny1JWoi2GEygMewZ2va/LSRyCs0Y=
X-Received: by 2002:a05:6512:2315:b0:4f6:3ef3:13e8 with SMTP id
 o21-20020a056512231500b004f63ef313e8mr784478lfu.0.1689170575150; Wed, 12 Jul
 2023 07:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net> <2cf3499b-03dc-4680-91f6-507ba7047b96@mojatatu.com>
In-Reply-To: <2cf3499b-03dc-4680-91f6-507ba7047b96@mojatatu.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Wed, 12 Jul 2023 16:02:43 +0200
Message-ID: <CAKa-r6sg3QRm3btoWTj7SzBSi29WUpT0et7dgdTmvbNE=74J3Q@mail.gmail.com>
Subject: Re: TC: selftests: current timeout (45s) is too low
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev <netdev@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

hello!

On Wed, Jul 12, 2023 at 3:43=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> Hi Matthieu,
>
> I have been involved in tdc for a while now, here are my comments.
>
> On 12/07/2023 06:47, Matthieu Baerts wrote:
> > Hi Jamal, Cong, Jiri,
> >
> > When looking for something else [1] in LKFT reports [2], I noticed that
> > the TC selftest ended with a timeout error:
> >
> >    not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
> >
> > The timeout has been introduced 3 years ago:
> >
> >    852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout
> > per test")
> >
> > Recently, a new option has been introduced to override the value when
> > executing the code:
> >
> >    f6a01213e3f8 ("selftests: allow runners to override the timeout")
> >
> > But I guess it is still better to set a higher default value for TC
> > tests. This is easy to fix by simply adding "timeout=3D<seconds>" in a
> > "settings" file in 'tc-testing' directory, e.g.
> >
> >    echo timeout=3D1200 > tools/testing/selftests/tc-testing/settings

finding a good default is not easy, because some kernel (e.g. those
built with debug options) are very slow .
Maybe we can leverage also on the other value in tdc_config.py [1] -
or at least ensure that the setting in 'setting' is consistent.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/com=
mit/?id=3Dd37e56df23f9e

[...]

> > I also noticed most of the tests were skipped [2], probably because
> > something is missing in the test environment? Do not hesitate to contac=
t
> > the lkft team [3], that's certainly easy to fix and it would increase
> > the TC test coverage when they are validating all the different kernel
> > versions :)
>
>  From the logs it seems like the kernel image is missing the 'ct'
> action. Possibly also missing other actions/tc components, so it seems
> like a kernel config issue.

when I run tdc I use to do:

#  yes | make kselftest-merge

so that the kconfigs are not forgot :)

> Interestingly enough the `tdc.sh` script doesn't test the filter and
> infrastructure categories. Perhaps it would be better to let it run the
> entire suite instead of just a few tests.

I remember that the "filter" category was not stable enough when we
wrote tdc.sh. If it's in good shape now, we can surely add it.

thanks,
--=20
Davide


