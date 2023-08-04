Return-Path: <netdev+bounces-24582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D14AE770AFE
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 23:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE47282382
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 21:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917C61ED5C;
	Fri,  4 Aug 2023 21:31:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C6F19891
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 21:31:31 +0000 (UTC)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E39268B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:31:23 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-44779e3e394so1134465137.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 14:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1691184682; x=1691789482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wgSDWxrxVZiPe9PKOQ5nehYLRx5JXmpKDK7pPAaQEc=;
        b=CzbssBraeCJGuHQUAt/Sfe5yrmbDMT3r8+MSa6a/KeoJ/q/xyXFdUVzTV63QPwPoX+
         FknePgnNRBHdAJq4gtFJZv6mBgdShTVaOZ+PlxzJol0VPMx3YHZkpnunKZubeTFviKv8
         BYC80q+xgJ0M2QeGDz8whD65V0lRff0TFmajWEXzOG9ZLstp0/0QSS8xZtpwOVBAD8rI
         wgTwHwzBfl68OIy9xzaae4TL341qZx/XX6okTQhOA3HtnzZSLciba+/6pDZ0pct77c4J
         aoRKoLat+q7ie6PViLLY9i+Sp1IEo7OeUXBlnw0b85aAU6HoH9xj32ZAaPGaNsXc9RdZ
         pr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691184682; x=1691789482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wgSDWxrxVZiPe9PKOQ5nehYLRx5JXmpKDK7pPAaQEc=;
        b=XVvdb5oq9TvB8sfjoXiRPzHgRu3v6u+SBGTKlt0/BOJWQnB1jKeBiGORTg2+95BafJ
         MWk8htEp3rWsVsokjZTUGx/4BR4g3EjY77Vihif5gP/Dk17+HpaZCvqd2G3yAiXzkcSQ
         lN9V/9pKvJXWFzQDbK1D+pKw9XZ9fipFSLDzPPscX+c0dZ/iNN9nukc8kdEQDj7EEp2J
         rE/bNCf4rmjVy5IV+MbjMjcxfTn6d8JBtMMM18npCOsNsa62olIhLxT6roPCBrU+ChLF
         Lpb2FjWa1HUL30euJE6nnevHOiY7uVjrDXlMSTKsZ/8pDra0p/MBAWoAgcqfOyTq+76r
         vsjw==
X-Gm-Message-State: AOJu0Yyail+q26faX9/AB75QdK29aC5b382kC4zP4stkpVtN4782RoNe
	PZusnHJh5WNMk3pXD4t9rrMqeWTBZr7DXxj4R2bxXw==
X-Google-Smtp-Source: AGHT+IHkeWcu5pSL+NXE/vtQuegT1kdwjEfT+C7bYVQ80I5JaMOKEk3YOWFw8Ln2hYau3FxYFEMedkeiggsWc+MVPqQ=
X-Received: by 2002:a67:fd86:0:b0:443:8898:2a50 with SMTP id
 k6-20020a67fd86000000b0044388982a50mr2187951vsq.35.1691184682195; Fri, 04 Aug
 2023 14:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:b0:794:1113:bb24 with HTTP; Fri, 4 Aug 2023
 14:31:21 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <CAL_JsqKGAFtwB+TWc1yKAe_0M4BziEpFnApuWuR3h+Go_=djFg@mail.gmail.com>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
 <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
 <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com>
 <CAL_Jsq+N2W0hVN7fUC1rxGL-Hw9B8eQvLgSwyQ3n41kqwDbxyg@mail.gmail.com>
 <CADyTPEyT4NJPrChtvtY=_GePZNeSDRAr9j3KRAk1hkjD=5+i8A@mail.gmail.com> <CAL_JsqKGAFtwB+TWc1yKAe_0M4BziEpFnApuWuR3h+Go_=djFg@mail.gmail.com>
From: Nick Bowler <nbowler@draconx.ca>
Date: Fri, 4 Aug 2023 17:31:21 -0400
Message-ID: <CADyTPEwY4ydUKGtGNayf+iQSqRVBQncLiv0TpO9QivBVrmOc4g@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-04, Rob Herring <robh@kernel.org> wrote:
> On Fri, Aug 4, 2023 at 11:52=E2=80=AFAM Nick Bowler <nbowler@draconx.ca> =
wrote:
>> I don't know about the deferred probe timeout, but I bisected the 6.5-rc=
4
>> breakage to this commit:
>>
>>   commit c720a1f5e6ee8cb39c28435efc0819cec84d6ee2
>>   Author: Michal Simek <michal.simek@amd.com>
>>   Date:   Mon May 22 16:59:48 2023 +0200
>>
>>       arm64: zynqmp: Describe TI phy as ethernet-phy-id
>
> I don't see anything obviously problematic with that commit. (The
> #phy-cells property added is wrong as ethernet phys don't use the phy
> binding, but that should just be ignored). I'd check if the phy probed
> and has a DT node associated with it.

I think the answer is "no, the phy was not probed".  Without reverting
that commit, there is absolutely nothing in /sys/bus/mdio_bus/devices.
There is no phy device link under /sys/bus/mdio_bus/drivers/"TI DP83867",
and there is no mdio_bus under /sys/bus/platform/devices/ff0e0000.ethernet.

When I revert that commit, I can locate the phy device under all these
locations.

> fw_devlink tracks parent-child dependencies and maybe changing to
> parent-grandchild affected that. We don't yet track 'phy-handle'
> dependencies, but we'd have a circular one here if we did (though that
> should be handled). Does "fw_devlink=3Doff" help?

Booting with fw_devlink=3Doff results in no obvious change in behaviour.

Thanks,
  Nick

