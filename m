Return-Path: <netdev+bounces-41562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275417CB4FB
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 23:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65AE281290
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051D374E0;
	Mon, 16 Oct 2023 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1k2df/R4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D529428
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 21:00:04 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B9795
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 14:00:02 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7c011e113so67812667b3.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697490001; x=1698094801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/NsK+xOSFbk+7yIlC25Zvc4arS4RPBl9T36vUtyDO4=;
        b=1k2df/R4MtWhdvM9rBOM5VOBYiJVfqZYG0yZUY2MQJUjshRYqquNkMfjVR2RoAZGKR
         b2zwpuDINy5xX+h1B42XLqwSg9M2Rrc/NUN7h48lygbKC48ZtxtR7g6itIs3Rl9Aaw/s
         L2LEKug15v2oiuPW5P0TdEzooXiTWnf45Rzu7WElKN7vZeWNIUJM22apK+HE1jkaa890
         RY55YA1btw5RHG+1vq99bR8QJgdkt48oPmnkoMOHyXOSUEp1YDv2JucKu96QKJViSnfN
         Rxb+MllWZSj1muYcOypj7o8xH9mUVmYLcSVg/wIOSgj8WjGf9xH64lrw3Z/e5wmo0acf
         dREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697490001; x=1698094801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/NsK+xOSFbk+7yIlC25Zvc4arS4RPBl9T36vUtyDO4=;
        b=a1Z3V2Yv3f7d9PJ1oGVlGBtkKb1Luo3bymD52JuVTFpgtVkblZ0JjvOIn/ZzWa1sgd
         E/tbaZBKZxYW5NWE3+iewmQpqliCPMTdG+r3sYEZLzXfWc9FjYSTi6gEOpN1BlX8OYUZ
         cY1HxLJg8xBRNrsPFVlJcgUkIIke038O5+4N2U2o8WVYvJJlDXDt+zZuSUCREfe1HgU/
         6hwIaPnBwAQ4OSg3pTFx2MWCyAd9jr8Qt0+ibE8tgnoYVqBp0+jB3LvMxJsRRkQoVBuI
         Qa/AeFzPP5mQtJL6yvKNgHG6cLjyvAgN6pXl7A+pKUCyGimuafjV9Av1hkFe2Cl2AIyp
         L9qQ==
X-Gm-Message-State: AOJu0Yxf1U9COPdVW5NGkr88NWdav6yPnNf/E77VpmZcO30CVmiEKoDW
	+tI2g2EEPicY5HOD3pkqlnNBa7gs4Wb8MJsatauhsQ==
X-Google-Smtp-Source: AGHT+IEpOOwpWfEVfknmbuyMiuAZO0fNP7/ZWnLyjgqoL0eMJATg2U+ZG3M9x/TK/x2BMcC53S43lSSXUsDjFfynSd0=
X-Received: by 2002:a81:5c46:0:b0:594:e2e6:25e8 with SMTP id
 q67-20020a815c46000000b00594e2e625e8mr293479ywb.48.1697490001377; Mon, 16 Oct
 2023 14:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016093549.181952-1-jhs@mojatatu.com> <20231016131506.71ad76f5@kernel.org>
 <CAM0EoM=nT2KQcVqPrWvKJXnW7h8uodhu0daNsLkuAUt5n=zuZw@mail.gmail.com>
In-Reply-To: <CAM0EoM=nT2KQcVqPrWvKJXnW7h8uodhu0daNsLkuAUt5n=zuZw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 16 Oct 2023 16:59:49 -0400
Message-ID: <CAM0EoM=ZGLifh4yWXWO5WtZzwe1-bFsi-fnef+-FRS81MqYDMA@mail.gmail.com>
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

On Mon, Oct 16, 2023 at 4:38=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Oct 16, 2023 at 4:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 16 Oct 2023 05:35:31 -0400 Jamal Hadi Salim wrote:
> > > Changes In RFC Version 7
> > > -------------------------
> > >
> > > 0) First time removing the RFC tag!
> > >
> > > 1) Removed XDP cookie. It turns out as was pointed out by Toke(Thanks=
!) - that
> > > using bpf links was sufficient to protect us from someone replacing o=
r deleting
> > > a eBPF program after it has been bound to a netdev.
> > >
> > > 2) Add some reviewed-bys from Vlad.
> > >
> > > 3) Small bug fixes from v6 based on testing for ebpf.
> > >
> > > 4) Added the counter extern as a sample extern. Illustrating this exa=
mple because
> > >    it is slightly complex since it is possible to invoke it directly =
from
> > >    the P4TC domain (in case of direct counters) or from eBPF (indirec=
t counters).
> > >    It is not exactly the most efficient implementation (a reasonable =
counter impl
> > >    should be per-cpu).
> >
> > I think that I already shared my reservations about this series.
>
> And please please let's have a _technical_ discussion on reservations
> not hyperboles.
>
> > On top of that, please, please, please make sure that it builds cleanly
> > before posting.
> >
> > I took the shared infra 8 hours to munch thru this series, and it threw
> > out all sorts of warnings. 8 hours during which I could not handle any
> > PR or high-prio patch :( Not your fault that builds are slow, I guess,
> > but if you are throwing a huge series at the list for the what-ever'th
> > time, it'd be great if it at least built cleanly :(
>
> We absolutely dont want to add unnecessary work.
> Probably we may have missed the net-next tip? We'll pull the latest
> and retest with tip.
> Is there a link that we can look at on what the infra does so we can
> make sure it works per expectation next time?
> If you know what kind of warnings/issues so we can avoid it going forward=
?
> Note: We didnt see any and we built each patch separately on gcc 11,
> 12, 13 and clang 16.
> BTW: Lore does reorder the patches, but i am assuming cicd is smart
> enough to understand this?

Verified from downloading mbox.gz from lore that the tarball was
reordered. Dont know if it contributed - but now compiling patch by
patch on the latest net-next tip.

cheers,
jamal

> > --
> > pw-bot: cr

