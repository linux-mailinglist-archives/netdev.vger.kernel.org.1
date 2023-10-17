Return-Path: <netdev+bounces-41970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDE77CC774
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222A7281412
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D9F4449C;
	Tue, 17 Oct 2023 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="CWiE5jBz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D55EBE
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:27:49 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBA59F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:27:48 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7eef0b931so71530557b3.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697556468; x=1698161268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma7vdyUFk9Lslh8fjIBRicwXAbC/GtVwlrEu6iyMXAE=;
        b=CWiE5jBzXw9gePtNPZelhCZcoIukzWwzgvwdSBnfnZ5Yg/Fa5E/OWWYcYBqImRLbaF
         2M5lMk8UKUyq24+dB502ye6lPWIkXYooz0cBux575c+YoxyBR22YwxCbc3F7pEpyh1fx
         PxAin3E8KtVDTG1onSaqya0Y9nz5H0ZxSXgAAxKZ0/r5mTIKirkgNn89lKQpn/vQrpl4
         JQfmQK/Iqf2/VsHam2MD/uq67+XdXZjS6IHjNCt1rBZWK9O4/3eO0g2R/Hj7/QcvnRD/
         g/XM+/x002tZRRO/e1GeY/vDeNTZX7WSQE5eVmUxEUchCiwQDxL1+lPDVCrhH5HGbX4H
         dr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556468; x=1698161268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma7vdyUFk9Lslh8fjIBRicwXAbC/GtVwlrEu6iyMXAE=;
        b=v/llb6ibh86fyvgDHM1JL5RnhSeh/oLBf60f7MX8FqeMcqsSoXn6PHGnbe36YIzEAH
         rz8wTvdItkFfFIq5bT8jBVjIfETamNhEE4flInDNCQtPiy6TXEQfiXp+FRj9uVgDvw2C
         +BSrHrI5q9Gn8t3oR1nHB0itK12E8cYNVgO8ImMpJ89GN150seWDdsqXJCfHxayKPenf
         MUIdunmZY9l3O0No2OX5ks8HJdyIBwF/rOMwq0pvvn7OODfBBWVciyAOuwe6i3mN06yb
         leWKLEDlwsj9xiQh/n4rxle6gOqlywG+hUjJKQ0V2CvNe8WIB7ZgN4eeKeCDey3raTW4
         wFwA==
X-Gm-Message-State: AOJu0YyxYBdCp26S2TsObFDFMRD5PHZkyG0XPAeYrfWw/Lw1vBQZAgJI
	2jipTTx5WkNGmYnRFQ9Sn4V9aKniDem4q8OZpdW3kA==
X-Google-Smtp-Source: AGHT+IFwt2LsghOhT99hY3cVk9Qi7bIGeWHlCRkoU/SnOfcMsiLhXaUIUKD/VCfyW+cc4IRYXxexZnhsdp8i0oidimY=
X-Received: by 2002:a0d:d912:0:b0:5a7:b4ab:9d7d with SMTP id
 b18-20020a0dd912000000b005a7b4ab9d7dmr2449480ywe.20.1697556467956; Tue, 17
 Oct 2023 08:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016093549.181952-1-jhs@mojatatu.com> <20231016131506.71ad76f5@kernel.org>
 <CAM0EoM=nT2KQcVqPrWvKJXnW7h8uodhu0daNsLkuAUt5n=zuZw@mail.gmail.com>
 <CAM0EoM=ZGLifh4yWXWO5WtZzwe1-bFsi-fnef+-FRS81MqYDMA@mail.gmail.com>
 <CAM0EoMmA3_9XmTFk5H-0oR5qfEYtxq_1Vc2zRVKfA_vtVTmafg@mail.gmail.com> <20231016153548.1c050ea3@kernel.org>
In-Reply-To: <20231016153548.1c050ea3@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 17 Oct 2023 11:27:36 -0400
Message-ID: <CAM0EoMk6aRnm_EPevO7MuyOHq52KOVXoJpy2i=exCuQeg0X-zA@mail.gmail.com>
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

On Mon, Oct 16, 2023 at 6:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Oct 2023 17:44:20 -0400 Jamal Hadi Salim wrote:
> > > Verified from downloading mbox.gz from lore that the tarball was
> > > reordered. Dont know if it contributed - but now compiling patch by
> > > patch on the latest net-next tip.
> >
> > Never mind - someone pointed me to patch work and i can see some
> > warnings there. Looks like we need more build types and compiler
> > options to catch some of these issues.
> > We'll look into it and we will replicate in our cicd.
>
> patch-by-patch W=3D1 C=3D1 should be good enough to catch the problems.

Thanks - this helps. We didnt pay good attention to
https://www.kernel.org/doc/Documentation/process/maintainer-netdev.rst
Only thing that is missing now is the mention of C=3D1 in the doc. Patch
to the doc acceptable?
Also a note about false positives in sparse output (there were a few
in the warnings from the bot) would be apropos.

cheers,
jamal

