Return-Path: <netdev+bounces-19008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3696B7594D7
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 14:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5C31C2096D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 12:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800341426F;
	Wed, 19 Jul 2023 12:13:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD112B87
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:13:28 +0000 (UTC)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B106E0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 05:13:24 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-78f6a9800c9so2527783241.3
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689768803; x=1692360803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T7uaAM3IG9/sDmhpozHaMLcOFvD19cGDCrRe8I/e0f4=;
        b=BhKFdy3wPgpKHIhX70cNSyv33QSVymvyo3hfYE+f2Ag4sPmsr0+28usn63wtIcY6V6
         qbXbJ8j6OON+WMEw8VU5uouQ+HUKCARsHLDZWWRn7FLiASJtfMMTug3pqXX5EcFzV4EK
         Rd6g10XfbgU3nIX+q3S+4YxeumKdln3UalnC5Y2u2sm2ZO+07voRNuc4xW2TVk9lCQoL
         xXwm7Nm2HM5yDylXvN9D6OuqONknRHMuZM4bSPxGxiOHGkhZ3GZvhY1GaNKGFvk92HMn
         A+JMmxukdUcFZx8ebo6m6CjxVNOZcSgASi4YE2+otdWhTjlLV47Zs4qRLuBThpa2AkRu
         rOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689768803; x=1692360803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7uaAM3IG9/sDmhpozHaMLcOFvD19cGDCrRe8I/e0f4=;
        b=TeGz+jtf0BipiYlp2GfeaXu1ryh0AWePXOfQThbEUWMQIr+Fev5Kmynrm9j6iOdBOP
         z2pEpX4sKPj8MHmtENH5uTt9V7iM0coyA4YvTP4He2ec978P1ZwCqHttrVuS4ZJ9fBJO
         WK6LMaR7IkOwFkbasT/al7ooYrpWUUor0TrjlIXDR/jH8TD29ARYs+YdvgcYvH5NCvOX
         fXbxQD/A1BOucEikWnvzRKtIlBCGl6dGg6M+xSswoLX0Fcmxq1eqygqlxIGDaZVPMbya
         lkp5dJoYt0vU7Ic1YFPCTDTAZfqiwXpYRv0HnqoirnwdH0zTI3CZXZfBUD/aCsBiBzYO
         tHXw==
X-Gm-Message-State: ABy/qLaneqkhiPWsIip+vYo6T/l9QvVca31OqAUNZM3R1B83xIoU1rL2
	rRZDynf8O9PHJz/yZNENy2i7uOiX8HibaLG8+20siw==
X-Google-Smtp-Source: APBJJlF1aks3c7digQqKAZkAKuQPlo8yFc2AgcSo3cZa0M3a0Mizd6gaWLgL1oYsRQOs2wKEPqEq52r2WlSyQEa9uuk=
X-Received: by 2002:a67:f290:0:b0:443:6deb:2b4 with SMTP id
 m16-20020a67f290000000b004436deb02b4mr1572014vsk.2.1689768803556; Wed, 19 Jul
 2023 05:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net>
 <2cf3499b-03dc-4680-91f6-507ba7047b96@mojatatu.com> <3acc88b6-a42d-c054-9dae-8aae22348a3e@tessares.net>
 <0f762e7b-f392-9311-6afc-ed54bf73a980@mojatatu.com> <35329166-56a7-a57e-666e-6a5e6616ac4d@tessares.net>
 <593be21c-b559-8e9c-25ad-5f4291811411@mojatatu.com> <fdf52d83-6e58-3284-8c61-66cf218c7083@tessares.net>
 <3b7a96db-70a1-9907-6caf-e89e811d40f6@mojatatu.com> <ccfa7c51-d328-4222-1921-631f10057349@tessares.net>
In-Reply-To: <ccfa7c51-d328-4222-1921-631f10057349@tessares.net>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 19 Jul 2023 17:43:11 +0530
Message-ID: <CA+G9fYvRJCQn+0t9GHWH+N+Qc7Ggxn++4OB5gV_KCoK17AFHvA@mail.gmail.com>
Subject: Re: TC: selftests: current timeout (45s) is too low
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Pedro Tammela <pctammela@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Linux Kernel Functional Testing <lkft@linaro.org>, netdev <netdev@vger.kernel.org>, 
	Davide Caratti <dcaratti@redhat.com>, Anders Roxell <anders.roxell@linaro.org>, 
	=?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>, 
	Benjamin Copeland <ben.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Matthieu and Pedro,

On Fri, 14 Jul 2023 at 02:41, 'Matthieu Baerts' via lkft
<lkft@linaro.org> wrote:
>
> Hi Pedro, LKFT team,
>
> @LKFT team: there is question for you below.
>
> On 13/07/2023 22:32, Pedro Tammela wrote:
> > On 13/07/2023 16:59, Matthieu Baerts wrote:
> >> On 13/07/2023 19:30, Pedro Tammela wrote:
>
> (...)
>
> >>> Could you also do one final test with the following?
> >>> It will increase the total testing wall time but it's ~time~ we let the
> >>> bull loose.
> >>
> >> Just did, it took just over 3 minutes (~3:05), see the log file in [1]
> >> (test job in [2] and build job in [3]).
> >>
> >> Not much longer but 15 more tests failing :)
> >> Also, 12 new tests have been skipped:
> >>
> >>> Tests using the DEV2 variable must define the name of a physical NIC
> >>> with the -d option when running tdc.
> >> But I guess that's normal when executing tdc.sh.
> >>
> >
> > Yep, some tests could require physical hardware, so it's ok to skip those.
>
> OK
>
> > As for some of the tests that failed / skipped, it might be because of
> > an old iproute2.
> > I see that's using bookworm as the rootfs, which has the 6.1 iproute2.
> > Generally tdc should run with the matching iproute2 version although
> > it's not really required but rather recommended.
>
> Ah yes, it makes sense!
>
> > We do have a 'dependsOn' directive to skip in case of mismatches, so
> > perhaps it might be necessary to adjust some of these tests.
>
> Yes, better to skip. Especially because the selftests are supposed to
> support old tools and kernel versions:
>
>   https://lore.kernel.org/stable/ZAHLYvOPEYghRcJ1@kroah.com/
>
> > OTOH, is it possible to have a rootfs which runs the tests in tandem
> > with iproute2-next?
>
> I don't know :)
> But I hope the LKFT team can help answering this question!
>
> @LKFT team: is it possible to run the latest iproute2 version, even the
> one from iproute2-next when validating linux-next?

As you know, LKFT is using debian bookworm as rootfs.
We always try to have minimal maintenance and user space tools dependency.
However, I will check with our team to upgrade iproute2 and
tryout testing iproute2-next when validating linux-next.

We need to check our LKFT budget for this additional build and test cost.

Links:
 - https://kernel.googlesource.com/pub/scm/network/iproute2/iproute2-next/

- Naresh

