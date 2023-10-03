Return-Path: <netdev+bounces-37735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 472CC7B6E1B
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id C03C71F20F7B
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2800738BD5;
	Tue,  3 Oct 2023 16:10:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1038DC5
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:09:58 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC64B4
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:09:57 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5856082f92dso734665a12.2
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696349397; x=1696954197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMNd5cy+iJOW1gFpgN/QZ1aYRGnrlEzRG0+fZIEWVq4=;
        b=G+7ALQXeNDDhSmSk4qnatL+1DHUKLIVEZjHYOfhF7FK6GKQ8STfpH9opF8MZ5I9TzK
         529hw8Qb887/fijJoQI/1ovOd3pIy8oR/LTU+mc089lpEhnDkruw9zyK1uw8uD13wGgi
         EFqsuNHRMDMIUFFWTmyoDkd5Br8XxiM4tsmXfikhucPOnBPMk1arPS3WF2etL/zswQBA
         qC/FpXGy/CAWErIHmwSo5VyvzdULgpVaUE4d/EvvZYmCR5dqQ6XUbnFaPzB98P7arL+H
         AIUu0ts03fYqQY0xhwa3dPbD3wGH5CwX9D0lQui60/dnU22aPzGyFexWhENbTrS9FNyU
         ZNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696349397; x=1696954197;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fMNd5cy+iJOW1gFpgN/QZ1aYRGnrlEzRG0+fZIEWVq4=;
        b=De62ITUZryoXHtMs3X3o+ELs0i3/zRxd+cMSHIx8nk+UNSFW9tmpoD6QW5MPzr6XEv
         jtqG9zMyXP0QtNMBNxhnmLnX4rp+GD+5Zoc4nnCORYzOgGZiYaA/YhhBQH7VnFPlvgYX
         Mzux//RxeSRSZr7d0D+u3B95PC4cT0vOIj5lGeK93oX36Q6gPXWK4tV0tdhtFTVmVSo8
         zVrSw8glScjYvoRln6uD6PWYKAChLb+j9eEEyfDa/qpduqAlvJfIkoI6ShqQGS/zyljF
         u6H6wnlAnA0vW4jV93XIrCVQ4L8eiW0D5lBtVdaV9HiQ2Ns8CFcQjpNZ5TVbstzYjmkL
         WOCg==
X-Gm-Message-State: AOJu0YxYJl1duvYtNt2172nH/q+qlxMkPZxNtac2ZLaZtRwIkpM6pZGb
	oHRDDzeaCMo69khaZOLHigP9k+E=
X-Google-Smtp-Source: AGHT+IFUI/zSRouM2YNJLSf/d4E6lhAcKza+USPolB7JhkwY/YXDC9+n+f30QlKeQNyx/U9ERtAAlk4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:294a:0:b0:57a:32e7:3240 with SMTP id
 bu10-20020a63294a000000b0057a32e73240mr224124pgb.5.1696349397201; Tue, 03 Oct
 2023 09:09:57 -0700 (PDT)
Date: Tue, 3 Oct 2023 09:09:55 -0700
In-Reply-To: <ZRu4OJMAOApPsoVx@lincoln>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231002162653.297318-1-larysa.zaremba@intel.com>
 <CAKH8qBtGBOw7j01s-ZO4tZmU9kQf-jQi1xUP9UmZ0ebN+W0whw@mail.gmail.com> <ZRu4OJMAOApPsoVx@lincoln>
Message-ID: <ZRw804r4JM3vTCDH@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add options and ZC mode to xdp_hw_metadata
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/03, Larysa Zaremba wrote:
> On Mon, Oct 02, 2023 at 09:46:08AM -0700, Stanislav Fomichev wrote:
> > On Mon, Oct 2, 2023 at 9:35=E2=80=AFAM Larysa Zaremba <larysa.zaremba@i=
ntel.com> wrote:
> > >
> > > By default, xdp_hw_metadata runs in AF_XDP copy mode. However, hints =
are
> > > also supposed to be supported in ZC mode, which is usually implemente=
d
> > > separately in driver, and so needs to be tested too.
> > >
> > > Add an option to run xdp_hw_metadata in ZC mode.
> > >
> > > As for now, xdp_hw_metadata accepts no options, so add simple option
> > > parsing logic and a help message.
> > >
> > > For quick reference, also add an ingress packet generation command to=
 the
> > > help message. The command comes from [0].
> > >
> > > [0] https://lore.kernel.org/all/20230119221536.3349901-18-sdf@google.=
com/
> >=20
> > I did similar changes in my pending [0], but I made the zerocopy, not
> > the copy mode, the default.
> > If you want to get this in faster (my series will probably need
> > another iteration), let's maybe do the same here?
> > ZC as a default feels better.
> >=20
> > 0: https://lore.kernel.org/bpf/20230914210452.2588884-9-sdf@google.com/
>=20
> I do not need those changes in tree ASAP, that is just something I had lo=
cally=20
> for some time and decided to send. So I think I can wait for your series.=
 This=20
> way it is less work for both of us.

SGTM, thanks!

