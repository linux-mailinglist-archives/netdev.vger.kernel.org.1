Return-Path: <netdev+bounces-13485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 192A573BC89
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 18:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532D61C212AF
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DB7100B4;
	Fri, 23 Jun 2023 16:28:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6BA100A6
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 16:28:16 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5099270E;
	Fri, 23 Jun 2023 09:28:14 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b5910c231bso2895911fa.0;
        Fri, 23 Jun 2023 09:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687537693; x=1690129693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvgeaWwow5dQzFM6Uw8ojK5T7WjFQWYGvDt1Izr/8jk=;
        b=j1eDX+rfTascQewMT2R8wt077pwLqnl3/fHykK9weg+VTC5KosdoIuB3zkzwR8IbOS
         zvycxikFdqCQrAFXyinBgS6VtwRUPIYDJmHT3WEAyY3h+eTR5DrO6qeNEeLc2zsAJUIA
         l1fySydLjAUM2cOffkZKTzJsk/jQSx/uXVuAI8IgFvbLFnpnq79LCiLs197N43BePVbo
         KFSmfEUTU+5hSX/d9lIiStR9EMAjb5sgc0pg/YOYZ3Drxp2oKRcVSQdzjooW29X63mKa
         /m45mGkJ+ZlzoQS1f6eFUSxI8JOabddWQWis+NJBzR4q6I+6JVTgQACj6eaXib+tWd74
         DeVA==
X-Gm-Message-State: AC+VfDx9wxskLyjZy3Z7uFCMal1z4aDHi7gSVzqOpz1QXtLcqKdjfDUs
	IQcBHcu+GfVOcvpOukI3xmSgJm3EFqwnup38i0w=
X-Google-Smtp-Source: ACHHUZ7MZE3zsM6gspBvAbI6j3yhuhxSNyO7LoHURailwc+M8lU+tu/GWJJ/M+xF6Lk75Dt+elliEUR2HeQhtX0eK54=
X-Received: by 2002:a2e:a492:0:b0:2b4:6d9a:2222 with SMTP id
 h18-20020a2ea492000000b002b46d9a2222mr9575407lji.0.1687537692753; Fri, 23 Jun
 2023 09:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621054603.1262299-1-evan.quan@amd.com> <20230621054603.1262299-2-evan.quan@amd.com>
 <CAJZ5v0iqy0yMJP5H7ub67R8R6i42=TcS_6+VF-+fWrM-9tYFQA@mail.gmail.com> <c518da2a-5ba5-af7e-e26d-1973db7b4c9e@amd.com>
In-Reply-To: <c518da2a-5ba5-af7e-e26d-1973db7b4c9e@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Jun 2023 18:28:01 +0200
Message-ID: <CAJZ5v0gnTt0pV4nF+jcYCyZuZXDNuRn3mS0bDoAv-ZDpetyxVg@mail.gmail.com>
Subject: Re: [PATCH V4 1/8] drivers/acpi: Add support for Wifi band RF mitigations
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Evan Quan <evan.quan@amd.com>, lenb@kernel.org, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, johannes@sipsolutions.net, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mdaenzer@redhat.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	hdegoede@redhat.com, jingyuwang_vip@163.com, lijo.lazar@amd.com, 
	jim.cromie@gmail.com, bellosilicio@gmail.com, andrealmeid@igalia.com, 
	trix@redhat.com, jsg@jsg.id.au, arnd@arndb.de, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 5:57=E2=80=AFPM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
> On 6/23/2023 9:52 AM, Rafael J. Wysocki wrote:
> > On Wed, Jun 21, 2023 at 7:47=E2=80=AFAM Evan Quan <evan.quan@amd.com> w=
rote:
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> Due to electrical and mechanical constraints in certain platform desig=
ns
> >> there may be likely interference of relatively high-powered harmonics =
of
> >> the (G-)DDR memory clocks with local radio module frequency bands used
> >> by Wifi 6/6e/7.
> >>
> >> To mitigate this, AMD has introduced an ACPI based mechanism that
> >> devices can use to notify active use of particular frequencies so
> >> that devices can make relative internal adjustments as necessary
> >> to avoid this resonance.
> >>
> >> In order for a device to support this, the expected flow for device
> >> driver or subsystems:
> >>
> >> Drivers/subsystems contributing frequencies:
> >>
> >> 1) During probe, check `wbrf_supported_producer` to see if WBRF suppor=
ted
> > The prefix should be acpi_wbrf_ or acpi_amd_wbrf_ even, so it is clear
> > that this uses ACPI and is AMD-specific.
>
> I guess if we end up with an intermediary library approach
> wbrf_supported_producer makes sense and that could call acpi_wbrf_*.
>
> But with no intermediate library your suggestion makes sense.
>
> I would prefer not to make it acpi_amd as there is no reason that
> this exact same problem couldn't happen on an
> Wifi 6e + Intel SOC + AMD dGPU design too and OEMs could use the
> same mitigation mechanism as Wifi6e + AMD SOC + AMD dGPU too.

The mitigation mechanism might be the same, but the AML interface very
well may be different.

My point is that this particular interface is AMD-specific ATM and I'm
not aware of any plans to make it "standard" in some way.

Also if the given interface is specified somewhere, it would be good
to have a pointer to that place.

> >
> > Whether or not there needs to be an intermediate library wrapped
> > around this is a different matter.

IMO individual drivers should not be expected to use this interface
directly, as that would add to boilerplate code and overall bloat.

Also whoever uses it, would first need to check if the device in
question has an ACPI companion.

