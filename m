Return-Path: <netdev+bounces-41558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45BE7CB4D0
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57CD3B20F0A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835830FBF;
	Mon, 16 Oct 2023 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Hn3b3B3N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553E381A5
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:38:22 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70D9B0
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:38:20 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so5212760276.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697488700; x=1698093500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab1cQmjcNTze6NoCzSY8OfemgbBn41PWgBmFMxTMYIY=;
        b=Hn3b3B3NlVrYztZVhDtlqnkLXvrqXaAJdS48nh/U7Zi58QTFGfugMU9pbG10NPJ1HX
         P1iv3WW5UNxCKoKDAvsZFVcoexGC+KYhaLCMZfkMvNHwWYxNAzcx/mOJ/dug7Z41Bnc4
         ZmcPTiIySZ/trb0FZN55gdT5BzrZX4yuv6p9ShgQEyBeCBNyhcAQNcMmRuK8aJZoWIzU
         4F/O65E4jLPDwIbKMHktO4zClqQh+p9Mw+yOYgecSI7mJsFFqnMQ1PkvW/W80uD+gykX
         1530c4Sp+MASfKJOrTCsn7cy+i6PKcTCYCfdpL8122n2dELYK2uCyaagawo7DGnYJppZ
         ojvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697488700; x=1698093500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ab1cQmjcNTze6NoCzSY8OfemgbBn41PWgBmFMxTMYIY=;
        b=EarJpgKKH78vRGsXwLWPpe+/aEoPns1qyGHvnTaQRo1yv6ooRHE1yVy7RjHkTEP0I2
         5pGsqfynm9o+uvObPrzKGKhjrv75vV0eqGVWkPOxcOmSFnryxE4MhnpFyvN3A3FwnreD
         s3Ln8KgvLXdC5ezs/om158bW17yvcVLIKUvI2XzCwVs1J7OPSOi7rS+S2n/17rnbeLPr
         jm6OplWkD6ASV28+qx6bqYCSePGLOui/bVsr9uAN5OkBkWrUvZg9RqeiiVlsLbpp+6QN
         Uw/JMR4Pa4RH0d7nFxEW+WyPouXtFb3VJ9fjV295VGI+f9yR7v52fuN8N275jKBaQ4sb
         a9Ww==
X-Gm-Message-State: AOJu0YxppY6SsWLhMoWojAyzGlJVC4YgJAapyfbZce6p/foq2nPI2QTl
	E8nDbp94DCBfkbYWlgwbECIc+nga7cB3WSZYj+Uwjg==
X-Google-Smtp-Source: AGHT+IE71mivRMzQPZ46xAL4eCKfL1kUMjj4mvMCTvlYF8+sZ8n46/5Qj7mYzDOtbWJa91vRbYjQVL46+KAyBgLJ/aI=
X-Received: by 2002:a25:ad93:0:b0:d42:d029:ff99 with SMTP id
 z19-20020a25ad93000000b00d42d029ff99mr141119ybi.55.1697488700121; Mon, 16 Oct
 2023 13:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016093549.181952-1-jhs@mojatatu.com> <20231016131506.71ad76f5@kernel.org>
In-Reply-To: <20231016131506.71ad76f5@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 16 Oct 2023 16:38:08 -0400
Message-ID: <CAM0EoM=nT2KQcVqPrWvKJXnW7h8uodhu0daNsLkuAUt5n=zuZw@mail.gmail.com>
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

On Mon, Oct 16, 2023 at 4:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Oct 2023 05:35:31 -0400 Jamal Hadi Salim wrote:
> > Changes In RFC Version 7
> > -------------------------
> >
> > 0) First time removing the RFC tag!
> >
> > 1) Removed XDP cookie. It turns out as was pointed out by Toke(Thanks!)=
 - that
> > using bpf links was sufficient to protect us from someone replacing or =
deleting
> > a eBPF program after it has been bound to a netdev.
> >
> > 2) Add some reviewed-bys from Vlad.
> >
> > 3) Small bug fixes from v6 based on testing for ebpf.
> >
> > 4) Added the counter extern as a sample extern. Illustrating this examp=
le because
> >    it is slightly complex since it is possible to invoke it directly fr=
om
> >    the P4TC domain (in case of direct counters) or from eBPF (indirect =
counters).
> >    It is not exactly the most efficient implementation (a reasonable co=
unter impl
> >    should be per-cpu).
>
> I think that I already shared my reservations about this series.

And please please let's have a _technical_ discussion on reservations
not hyperboles.

> On top of that, please, please, please make sure that it builds cleanly
> before posting.
>
> I took the shared infra 8 hours to munch thru this series, and it threw
> out all sorts of warnings. 8 hours during which I could not handle any
> PR or high-prio patch :( Not your fault that builds are slow, I guess,
> but if you are throwing a huge series at the list for the what-ever'th
> time, it'd be great if it at least built cleanly :(

We absolutely dont want to add unnecessary work.
Probably we may have missed the net-next tip? We'll pull the latest
and retest with tip.
Is there a link that we can look at on what the infra does so we can
make sure it works per expectation next time?
If you know what kind of warnings/issues so we can avoid it going forward?
Note: We didnt see any and we built each patch separately on gcc 11,
12, 13 and clang 16.
BTW: Lore does reorder the patches, but i am assuming cicd is smart
enough to understand this?

> FWIW please do not post another version this week (not that I think
> that you would do that, but better safe than sorry. Last week the patch
> bombs pushed the shared infra 24h+ behind the list..)

Not intending to.

cheers,
jamal

> --
> pw-bot: cr

