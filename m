Return-Path: <netdev+bounces-41980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4AB7CC839
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F163B20F84
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A7F45F47;
	Tue, 17 Oct 2023 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ntV5rT6j"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29045450F4
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:56:29 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874F8FD
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:56:27 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9a58aa4983so6971261276.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697558186; x=1698162986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7GSwWid5rTY6pUqth/qURI2tOHic+DeG6UQFF1Yi+U=;
        b=ntV5rT6jh/3K8ozEzkGsIZKwHrtdSqt/HNvk9oaHLj+nC4BPVAMlGS95z3g5dnWGBt
         OAInUSqqZngXwjHgjFTB9Jf6p+Y9YqfXhyoE2ebEFseVWfbsBXQs/NKJ8+z/Xva5CGCm
         TUhzlkV3EOEX6MI78XtMzN13uSkp+mN7h+U4H6nziX+u89Rij6dqhAvofgR2+o+u1666
         MmTzHKxCc3dyJuz+QlF0ZVYRtGRgbnZ1WE4GxKT2RFSHAPvCIU6AMyn+y96xX2+vhHMR
         mRUM5j3Rjhjr9v30Xz6F4BtvEZqZd9+Ovy2RAkaAdTBXUecqXx5cuNy1tAqa0ZefHGkw
         5C+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558186; x=1698162986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7GSwWid5rTY6pUqth/qURI2tOHic+DeG6UQFF1Yi+U=;
        b=hsz+gpMxGomdGw0QjcqbMgm5GZvw4bmXfwFrsvk9ZXuMIBF0xe5eW6U228Pr3oSyIG
         uuTMiWjci0nqJqA7djo0oCucz/nB83tG/TStGXpIPwsZkzPttOSImE2xqdNx7gHLRSP+
         Vojh2EF78HSpiLroW+UHXgBGMw+m8C7FrWol3bz8Jw+0UOgL2l3Ak5D5aMLNXl+JmfBg
         fXheocg7HkrbmV3IWhUVctHSgfXh4PoJ4rXdQLo0SyCqOAV4Lcni2xJ7EUAT/eS4CuHZ
         lRLa2DHrSfiFnoJ3how92umTQY13L0WYSvpYxSsw7GOphLiiHhh69OG2GMzhXQj9YO32
         0siw==
X-Gm-Message-State: AOJu0YypcWc+qzh42RFgrlmcb4xZCUH74vYEf8328twOveruRgTLb1mb
	whA7uuwjT6lxIXoROuwMPq8hhx9JaQZ9XNuyn8QFIg==
X-Google-Smtp-Source: AGHT+IG+jU3PnwpZ7LCWI+kSFgx+Fj3tlPzeOssMOxi8ahecJe/jh8ZRgkrK05TLscP2spUJw7WCTEgGffx3fM77grg=
X-Received: by 2002:a25:dc13:0:b0:d9a:384a:d4c5 with SMTP id
 y19-20020a25dc13000000b00d9a384ad4c5mr2461609ybe.33.1697558186697; Tue, 17
 Oct 2023 08:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016093549.181952-1-jhs@mojatatu.com> <20231016131506.71ad76f5@kernel.org>
 <CAM0EoM=nT2KQcVqPrWvKJXnW7h8uodhu0daNsLkuAUt5n=zuZw@mail.gmail.com>
 <CAM0EoM=ZGLifh4yWXWO5WtZzwe1-bFsi-fnef+-FRS81MqYDMA@mail.gmail.com>
 <CAM0EoMmA3_9XmTFk5H-0oR5qfEYtxq_1Vc2zRVKfA_vtVTmafg@mail.gmail.com>
 <20231016153548.1c050ea3@kernel.org> <CAM0EoMk6aRnm_EPevO7MuyOHq52KOVXoJpy2i=exCuQeg0X-zA@mail.gmail.com>
 <20231017084029.3920553d@kernel.org>
In-Reply-To: <20231017084029.3920553d@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 17 Oct 2023 11:56:15 -0400
Message-ID: <CAM0EoM=f9qGmTR5jW1vayu0JHy0MQjrOeREX6acjnS7MFQP7Ww@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 00/18] Introducing P4TC
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, anjali.singhai@intel.com, namrata.limaye@intel.com, 
	deb.chatterjee@intel.com, john.andy.fingerhut@intel.com, dan.daly@intel.com, 
	Vipin.Jain@amd.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, 
	toke@redhat.com, mattyk@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 11:40=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 17 Oct 2023 11:27:36 -0400 Jamal Hadi Salim wrote:
> > > patch-by-patch W=3D1 C=3D1 should be good enough to catch the problem=
s.
> >
> > Thanks - this helps. We didnt pay good attention to
> > https://www.kernel.org/doc/Documentation/process/maintainer-netdev.rst
> > Only thing that is missing now is the mention of C=3D1 in the doc. Patc=
h
> > to the doc acceptable?
> > Also a note about false positives in sparse output (there were a few
> > in the warnings from the bot) would be apropos.
>
> Um. Maybe.. Sparse generates more false positives than good warnings
> lately :( We'd have to add some extra info like "Note that sparse
> is known to generate false-positive warnings, if you think that the
> warning generated with C=3D1 is bogus, ignore it and note that fact
> in the commit message".
>

> I don't like documenting things which aren't clear-cut :(

Upto you - couldnt sum up from above if you want a patch or not. I
think it makes sense to document C=3D1 somewhere since it helps your
overhead.
But the comment Similar in spirit to the checkpatch comment if - "But
do not be mindlessly robotic in doing so..."

> I'm pretty sure you have pure W=3D1 warnings here, too.

True - I am not sure how we missed one with function not used.

cheers,
jamal

