Return-Path: <netdev+bounces-20527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680F475FEEF
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 20:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0392814FB
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A22100C8;
	Mon, 24 Jul 2023 18:21:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E4100C7
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 18:21:12 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922E410E7
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 11:21:11 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40550136e54so38471cf.0
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690222870; x=1690827670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlpMaquCbS1MmrUfy3BXNSfbJVus+xp1rCAPtS92EtA=;
        b=ZuBis15hicMFq5tDPhwtRUwmP82up0XlfOjzD4s1O9Kz6+AnkugagoVll3CK2sJIXX
         0zVBe4M6QvTQ7/RYVWm/8aLkKWruxhDI/vmlx7yJcsaDIvs0EIz5Spet04nAx8DDXQm4
         XCsqTi94D4l0k+kxjLXhD0dhD3ozOKkg5kpKnDsSl8YlZoihsfArtpx3NuCeoBFYENkm
         N5ZERW+pJqnln3JQ1w21TwYvsvPiEe9IIn6fGmF+cuNK5MI/dzCnkNBUnBiZ7SERwPHy
         KHx9E+SQuBrW/KYbMWJouh2OKyPnuvMyd2b+MTTBXRdyBuW4/EZDdxWBw4vO5LV6fUji
         92kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690222870; x=1690827670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlpMaquCbS1MmrUfy3BXNSfbJVus+xp1rCAPtS92EtA=;
        b=eMAxbualy1nka2RK8NbxiPlHt5cq/qhdeh4HkZ+29MFJHUY0Wpr4HZBnDGkfSvxsxy
         notM5GRhI3BX6nvCPeNVx0yxDNJ6Z1hIpx0D+NJbKTrsPR86+T4dLH8cJqw8i8CUtDmi
         iHUScEJOaCIEbMytqmTc0SEILd2Ii7DVTSFpTY9GhrmxIGu5b3yVRz3ooy2CIcWz/JKu
         YVjEvWsuSby3RyL5tYYi6PmGOVtDB8vFnkkFPYOHF8nFSXWTb9hDoISxwO4Oelu4frgI
         3793JI6pOcROJYklWyr/O3PochzrPkKEYo6MSjO6q8fFHLmHjH6vVIS6iPRT6di18jN7
         kVXw==
X-Gm-Message-State: ABy/qLYXO5jZ2SnrBkbBNm5SkvsHtjJGxvVSO9wOhH3YDrLZmUw91D4c
	dG2OIII7eFHXUA5Qz4wvNCjM2iBhfoxntEglkZrWpwpCTN1sjgfnNm4=
X-Google-Smtp-Source: APBJJlGTNmJgOTK9dSHw8awJ4FyWUuVk3C8nXLAgTtyidQidHp45ure2o+xIfojvbra0iUEvlRq7PDHnSGu303kjuqI=
X-Received: by 2002:a05:622a:15d3:b0:403:a43d:bd7d with SMTP id
 d19-20020a05622a15d300b00403a43dbd7dmr547698qty.4.1690222870521; Mon, 24 Jul
 2023 11:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3e69ba8-2a20-f2ac-d4a0-3165065a6707@kernel.org>
 <20230720160022.1887942-1-maze@google.com> <20230720093423.5fe02118@kernel.org>
 <CANP3RGexoRnp6PRX6OG8obxPhdTt74J-8yjr_hNJOhzHnv1Xsw@mail.gmail.com>
 <CANP3RGfsp3eHmSabzwsvHJbc6mb6QGgfPmoEF3B0t03SHwNkFA@mail.gmail.com> <20230724110945.55e91964@kernel.org>
In-Reply-To: <20230724110945.55e91964@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Mon, 24 Jul 2023 20:20:57 +0200
Message-ID: <CANP3RGf5J5v5b6O9xm9WiorWF=o7rq_kC9GXBAmpQQnBXEL+Tw@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6 addrconf: fix bug where deleting a mngtmpaddr
 can create a new temporary address
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Thomas Haller <thaller@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Xiao Ma <xiaom@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 8:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 24 Jul 2023 14:07:06 +0200 Maciej =C5=BBenczykowski wrote:
> > I see this is once again marked as changes requested.
> > Ok, I get it, you win.
>
> FTR wasn't me who set it to changes requested :S

That is actually part of the problem, I've commented on this in the past.

The transitions (for example from New -> Changes Requested) happen:
- with no notification (via email or otherwise), thus requiring
periodic manual monitoring of patchworks web ui (is there a better
way?)
- with no idea who made the change
- with no idea what 'changes' were actually requested (sure sometimes,
this is indeed obvious, but not in this case for example).

> My comments were meant more as a request for future postings.

Ack, that's what I assumed.  Sorry for the mess.

> I don't see a repost so let's just bring the v2 back:

Thanks!

