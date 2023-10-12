Return-Path: <netdev+bounces-40193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644BF7C6162
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D37D2823E5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AB0362;
	Thu, 12 Oct 2023 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahk/HipE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AB537B
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 00:08:16 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4659E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 17:08:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5cd27b1acso3541775ad.2
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 17:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697069294; x=1697674094; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBgwJdhIF540v090iE0fBuhhb1+BlmX2mG/dCfcUXHY=;
        b=ahk/HipE7VzGEke4TWK0FTBBFIKunbiviLv3Kd6LQoGMp8otSquU9DfM4x0gIuW4Q9
         07UNqiTeb5T+IDAZvsPVZ9PyntyF/XZLWJPN0B02b66o57ff7b9xJc7Y1mKkkg1c7wxi
         yxfN5PMsNaN3Z21oYN2CsOKKnzObuf9Es90DwUcNZ4FGuqU39yY7ZFNe/LYTvstE1gis
         09vIgSQzQIApe/1UJ6GY/ISObJHOveogM8WnqZfI+wFuLMW4PDjl7lgpKrI71WLOZQKY
         AYZihnx52avDUSXj4aNY4oszkj2wjAaoxN09nQAWAVxU+x1Ciyx0WX9Q9ZjIMoXxzWNG
         rQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697069294; x=1697674094;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sBgwJdhIF540v090iE0fBuhhb1+BlmX2mG/dCfcUXHY=;
        b=L28yvWZ25jV0hRhwIeOP++0qUaXZDCfJxMvCTR9fwmD1vnr65txVfU1H6asnALYOGU
         X9WdOHWwHwWLJ/q766hc/7MLhKOhScVHuXklWoqT7V+e3qTZDNA0n3iUDS89fiIBlXm7
         bm1mkuEpJimsMVCh3AxZIKCU3cCLroyH936HCjChliCCNYXriSatLu9rOR4IHPlDJS/H
         YazsI3vuPbxD2pE3cAx1adfB7uy0Wa2nX4nQDQcW3IhQDf5WcYOhTqzlf/Zk6IJ+T2cs
         auG8ZMgM/5YiXIL0zgElSecIyTqfxwHsximJLYAU9jh46Vc4fSZv3K6tGz500yuh29Y1
         uxJQ==
X-Gm-Message-State: AOJu0Ywr+W6m262Q395AlCNRZSkc4XpvAstYZiLAOeIyPo/gQ3UNo7J+
	/yTiSVFkDgmEs4+9a/6rRCc=
X-Google-Smtp-Source: AGHT+IHAU5bRVYL0uxSZEJIPCsk9gDFE/x54XrRnL+5iG43j3R0xXDlWkdKP1Vnxw9AuM+sqPY8s5Q==
X-Received: by 2002:a17:902:ecc2:b0:1c6:1861:70a with SMTP id a2-20020a170902ecc200b001c61861070amr28440410plh.23.1697069293968;
        Wed, 11 Oct 2023 17:08:13 -0700 (PDT)
Received: from localhost (27-33-247-209.tpgi.com.au. [27.33.247.209])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902ed4c00b001c60a548331sm435554plb.304.2023.10.11.17.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 17:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Oct 2023 10:08:08 +1000
Message-Id: <CW60USAI9NQ4.17G447945I9Y@wheely>
Cc: <dev@openvswitch.org>, "Pravin B Shelar" <pshelar@ovn.org>, "Aaron
 Conole" <aconole@redhat.com>, "Eelco Chaudron" <echaudro@redhat.com>,
 "Flavio Leitner" <fbl@redhat.com>, "Simon Horman" <horms@ovn.org>
Subject: Re: [PATCH 0/7] net: openvswitch: Reduce stack usage
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Ilya Maximets" <i.maximets@ovn.org>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20231011034344.104398-1-npiggin@gmail.com>
 <80b08b65-804b-2c83-c953-67def27ee656@ovn.org>
In-Reply-To: <80b08b65-804b-2c83-c953-67def27ee656@ovn.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed Oct 11, 2023 at 10:22 PM AEST, Ilya Maximets wrote:
> On 10/11/23 05:43, Nicholas Piggin wrote:
> > Hi,
> >=20
> > I'll post this out again to keep discussion going. Thanks all for the
> > testing and comments so far.
>
> Hi, Nicholas.  This patch set still needs performance evaluation
> since it touches very performance-sensitive parts of the stack.
> Did you run any performance tests with this version?

I did, the recipe in the previous thread was in the noise on my
system.

> IIRC, Aaron was still working on testing for the RFC.  I think,
> we should wait for his feedback before re-spinning a new version.

The RFC was a a couple of % slow on the same microbenchmark. I
gave an updated git tree with reworked to avoid the slab allocs
he was looking at, but I thought I'd post it out for others to
see.

> >=20
> > Changes since the RFC
> > https://lore.kernel.org/netdev/20230927001308.749910-1-npiggin@gmail.co=
m/
> >=20
> > - Replace slab allocations for flow keys with expanding the use
> >   of the per-CPU key allocator to ovs_vport_receive.
>
> While this is likely to work faster than a dynamic memory allocation,
> it is unlikley to be on par with a stack allocation.  Performance
> evaluation is necessary.

Sure.

> >=20
> > - Drop patch 1 with Ilya's since they did the same thing (that is
> >   added at patch 3).
>
> The patch is already in net-next, so should not be included in this set.
> For the next version (please, hold) please rebase the set on the
> net-next/main and add the net-next to the subject prefix of the patches.
> They are not simple bug fixes, so should go through net-next, IMO.
>
> You may also see in netdev+bpf patchwork that CI failed trying to guess
> on which tree the patches should be applied and no tests were executed.

I was thinking you might take them through your ovs merge process,
but I'm happy to go whatever way you like. And yes they're not
intended for merge now, I did intend to add RFC v2 prefix.

>
> >=20
> > - Change push_nsh stack reduction from slab allocation to per-cpu
> >   buffer.
>
> I still think this change is not needed and will only consume a lot
> of per-CPU memory space for no reason, as NSH is not a frequently
> used thing in OVS and the function is not on the recursive path and
> explicitly not inlined already.

If it's infrequent and you're concerned with per-CPU memory usage, we
could go back to using slab.

It's not in the recursive path but it can be a leaf called from the
recursive path. It could still be function that uses the most stack
in any given scenario, no?

Thanks,
Nick

