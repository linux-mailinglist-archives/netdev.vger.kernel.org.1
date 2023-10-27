Return-Path: <netdev+bounces-44845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C305C7DA1AC
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49481C20BE0
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211843E00A;
	Fri, 27 Oct 2023 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MW4pV/da"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE06128
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 20:18:49 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A011E5
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 13:18:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507c9305727so118e87.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 13:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698437926; x=1699042726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4JwyRon2XRHZP9ACeaGmtSzGVRizFzaXwaZkouZ9VI=;
        b=MW4pV/da14AZTUn/Hw1ndxzrkhwBh+dodzldEUDOsKIh2LHCrRMyztx3kIBM88d/yc
         0N4xW2/z75+dPQGXS6n51snTARzYp1NHs94swN2JIIChdTI+5acO4+fXN5Mpmov1HYHL
         LNxWhcLSxRI2bSHcr3U3ZhphqviRKco97J5DQEL2pLh6aCGXRaPwrTvwpN2tpC2uxw+e
         J0HUfFE4gjYnBzXj1XB9Q8bU/RjstlwN4s4DDf+wliJZTgI3CzhO+AYUfJo/XN3mWh4g
         hRiCRESuA6tsYPkYKXRwQMV5FFa4bMqkaqNWiwaC2coMImSaVVJ48dR2xdDNuB/3fGav
         ef2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698437926; x=1699042726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4JwyRon2XRHZP9ACeaGmtSzGVRizFzaXwaZkouZ9VI=;
        b=dV6CIn6WopwIBJN4hXb5TTTzac4qW9BJYsYnk1CnbIlNgPSpP1o3leLSPlO4Lzxveg
         DYdMkfD01fJwB0scUJj+0Wjks4wpjX6sjaYSUPNbvVhxccis2yYJvlMC2o2ZTz4p75ka
         xHNJecumCpf5NhIszJ9DtyvWCr8DORNIPBqX0Y/ub0vX10XYcp/pcZbwvJ0mK0Fp4c8j
         Hb+jM6lYNFf0x7noGifUd+m4P03PDmsTftg1RVkZSc+dM0I51xS2gNem8qUUG1wKoP99
         YSmSIXLvSPFYyMlil8UOYuoIjqlTWCbeG7Z9pNc1x1DyoAgdk4xx6upWFfMEPf9piMKl
         eI5Q==
X-Gm-Message-State: AOJu0YwXJbdaB+EuN203UPnHm0B6bNUPa9opZVzNNmjXEshqpvWGaiEF
	whCApZN96HVUdwLonuM3UKsHjSZzhFjv+pgYJpKxpQ==
X-Google-Smtp-Source: AGHT+IEuaqrnzlmzYaTs+g/h7AkPsL5FDCOJk3x60p6rUPotE2GVj1bGGKtjDYhpueoxXrpVMKqZM0BgsPp7OcMeDuM=
X-Received: by 2002:ac2:57c3:0:b0:507:970a:29d5 with SMTP id
 k3-20020ac257c3000000b00507970a29d5mr20490lfo.4.1698437926287; Fri, 27 Oct
 2023 13:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026081959.3477034-1-lixiaoyan@google.com>
 <20231026081959.3477034-4-lixiaoyan@google.com> <20231026072003.65dc5774@kernel.org>
 <CADjXwjjSjw-GxtiBFT_o+mdQT5hSOTH9nDNvEQHV1z4cdqX07A@mail.gmail.com>
 <20231026182315.227fcd89@kernel.org> <CANn89iJsY=ORcYiCAp-2AJKYbgWQS3ygOpYwzY+_vb6ojz3Gxw@mail.gmail.com>
In-Reply-To: <CANn89iJsY=ORcYiCAp-2AJKYbgWQS3ygOpYwzY+_vb6ojz3Gxw@mail.gmail.com>
From: Coco Li <lixiaoyan@google.com>
Date: Fri, 27 Oct 2023 13:18:34 -0700
Message-ID: <CADjXwjgi2V-3K2p=PpK0tB=U=P3Z672kYgU=8Zc5ggH-h_At0g@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 3/6] net-smnp: reorganize SNMP fast path variables
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023, 12:55=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Oct 27, 2023 at 3:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 26 Oct 2023 16:52:35 -0700 Coco Li wrote:
> > > I have no objections to moving the enums outside, but that seems a bi=
t
> > > tangential to the purpose of this patch series.
> >
> > My thinking is - we assume we can reshuffle this enum, because nobody
> > uses the enum values directly. If someone does, tho, we would be
> > breaking binary compatibility.
> >
> > Moving it out of include/uapi/ would break the build for anyone trying
> > to refer to the enum, That gives us quicker signal that we may have
> > broken someone's code.
>
> Note that we already in the past shuffled values without anyone objecting=
...
>
> We probably can move the enums out of uapi, I suggest we remove this
> patch from the series
> and do that in the next cycle, I think other reorgs are more important.

I agree. Will remove this commit in v5 of patch which I will update
soon, and send in a separate patch series to move enum out of uapi and
reorganize snmp counters.

Thanks for the discussion!

