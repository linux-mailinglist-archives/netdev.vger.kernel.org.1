Return-Path: <netdev+bounces-24523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5471770755
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 19:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951052827A7
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A10E1BEE3;
	Fri,  4 Aug 2023 17:52:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7531AA9C
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 17:52:35 +0000 (UTC)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F614C01
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:52:33 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-79a41b1bccfso812438241.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1691171553; x=1691776353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKhuaPvhv/FJQGJs3SnWgGcCp1xME/oZLELOSvk67M0=;
        b=phYN/2eO1zMae8aMPb70lr/r2z8I/TfzXHHZhjztwJ8artAqBgsJmWX0N5dpJNx0O3
         rzbRZKpQqkmRa/n5/I5x05zXxoNsIFA0TghC2USi2D4UlS+ROnSUsMCsjqhsKZkIfnjV
         knyTPzz+1cIJaololyZRXU7TnKRRBk4ABM0seEdyxz9l4JdDcbwycdbNQ0OC6Qhy7kdd
         CYy22muOjdZ7BxrLGp0p2hKo6y8xZInPsOyqRPOpJmikQrvgpQxxKAOnGN9JBrG4Wljz
         2rCjy4xzgNusTB5HjVnbOBPb0zId/tYLS9XshI88skvbUWOHqhB2RM5bO9ch1LgALSaK
         QhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691171553; x=1691776353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKhuaPvhv/FJQGJs3SnWgGcCp1xME/oZLELOSvk67M0=;
        b=Zud7Vssa4PZTXWbUrSNxG9W2LSWgk6lHN3mzc0T8/19wktOuAPjY2e6JlobN0kSKCC
         DALFgdDXOv4ZHhGhydcqV2ohDackXiWhEPVbYFSlfJx6VhGXmFJNsWsRxtHRql4O52wA
         8Lkybp2XpI5andI2eS80RwP8nU5ZKf8VURRS3WKDYW/i8X5mau/skgGMpjDjNLW09IMM
         iZXXfkGxSIfAOvR5Sm4hj6vIInY3UTB8aYEVtmn/loC/1NfdS7k1lucABnySkch+yIoy
         tRTXrKmNJGJQYBfDHPB4doYGqNDeLQVTiMoOsfCdElxpYPFFWpjfdzYofzkpVW58b+ZS
         /mWA==
X-Gm-Message-State: AOJu0Yzfk9dRICJuDMGE0GAB7ldcFskMJVp9XKymTeJC3uKo5tvNN4ey
	awbduUfMkuKgPEekOJrz75m/2Kd7NhpJGEEbalQruNG+k5GGIhZ1
X-Google-Smtp-Source: AGHT+IF8UqRFqWtwNUNQ1Q+gp7qMomGV5R3bGxEcvNI9aTl71Vq1v+XRJe3MetIwOu8vDb8niCq8yY7BwGzYetWOVjM=
X-Received: by 2002:a67:fc03:0:b0:445:4996:1d27 with SMTP id
 o3-20020a67fc03000000b0044549961d27mr1865469vsq.3.1691171552903; Fri, 04 Aug
 2023 10:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:b0:794:1113:bb24 with HTTP; Fri, 4 Aug 2023
 10:52:32 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <CAL_Jsq+N2W0hVN7fUC1rxGL-Hw9B8eQvLgSwyQ3n41kqwDbxyg@mail.gmail.com>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
 <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
 <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com> <CAL_Jsq+N2W0hVN7fUC1rxGL-Hw9B8eQvLgSwyQ3n41kqwDbxyg@mail.gmail.com>
From: Nick Bowler <nbowler@draconx.ca>
Date: Fri, 4 Aug 2023 13:52:32 -0400
Message-ID: <CADyTPEyT4NJPrChtvtY=_GePZNeSDRAr9j3KRAk1hkjD=5+i8A@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-04, Rob Herring <robh@kernel.org> wrote:
> On Fri, Aug 4, 2023 at 10:54=E2=80=AFAM Nick Bowler <nbowler@draconx.ca> =
wrote:
>> Oh, I get it, to include this driver I need to also enable:
>>
>>   CONFIG_RESET_CONTROLLER=3Dy
>>
>> Setting this fixes 6.4.  Perhaps CONFIG_ARCH_ZYNQMP should select it?
>
> Maybe. Do other platforms do that?

Of the ~40 platforms in arch/arm64/Kconfig.platforms, there appear to
be 5 that do select it.

>> However, even with this option enabled, 6.5-rc4 remains broken (no
>> change in behaviour wrt. the network device).  I will bisect this
>> now.
>
> It would be good to know why the deferred probe timeout doesn't work.
> If you disable modules, the kernel shouldn't wait past late_initcall.
> Though this functionality keeps getting tweaked, so I may be off on
> the current behavior.

I don't know about the deferred probe timeout, but I bisected the 6.5-rc4
breakage to this commit:

  commit c720a1f5e6ee8cb39c28435efc0819cec84d6ee2
  Author: Michal Simek <michal.simek@amd.com>
  Date:   Mon May 22 16:59:48 2023 +0200

      arm64: zynqmp: Describe TI phy as ethernet-phy-id

So, reverting that on master appears to correct the issue (together with
setting CONFIG_RESET_CONTROLLER=3Dy).

