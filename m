Return-Path: <netdev+bounces-51727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D91A7FBDFD
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A524DB21CF6
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F9B5E0A4;
	Tue, 28 Nov 2023 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKZOXhvT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4FD10E6
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:19:59 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so11950a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701184798; x=1701789598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fu6vVc3YX44ubG70BR1NWBnTzsg2wVkiW3jzasXUPEc=;
        b=HKZOXhvTI4xGGSb3o0HhiO9hBwGEKSt5fKYtiEACCMvwKuw2Y87eM8pL+7iXTI15t4
         qMf5RwhtdlgSCCvV5fwMN4H/uC9hORKTuG2ugxE/askc5iHGBIWG4wj0eoveqX2GGIBk
         Gfrrxl2+lD2US2snnYf3oRW+vcvYD0t2EXQbytshrGE03a2E7dAFw+9JGbVb9lm8XpCD
         v0Rby6Fw69lSugRgcO2540/UPNNGnqdWD9k5K1+p2Q/JhM6qhtb90202/mV+mZvrIieC
         Q59LQwyPRtPyQmu/xgszQBUCBMrlpIVmHD83aoHjkBk+hCktWVsKWVsDID9AuFyA485Z
         7IHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701184798; x=1701789598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fu6vVc3YX44ubG70BR1NWBnTzsg2wVkiW3jzasXUPEc=;
        b=FvwQtmbfPQJqQ/FWCyjw+wrlWhCUJgKup4aja+9RDIJ6frJ21wHZhNSUYS5w1uBSqK
         yu1cwFkooMPApxdzjIU47XxCKq9AC48iP2aWhuoWbHG4X9fYCr6dKbZ8PaiKzUHFRB/A
         Sz8lsORVUFOvbx3Kf1AHeMCEFFmROoh3vS+pkOL6GFnGqZyuhX6obsmJFzYPsnUfsqq3
         SNIloxpPV4uCcTnhoGCCgIoOrgIE2FLLFL+KkoVTQVQ3hE959kAVxi7TusGOA9YoGPPp
         9JI6xBciEx1XGuOkmJGR+ru4WYPs887TsmhnPSPp14K0kpfADmVwqXkVJHkAoXqxvuUV
         ssqw==
X-Gm-Message-State: AOJu0Yz1B22X4SuyhHjv402fp+sOs6bQpI5Jkc4e80EYazFiHKmRFxgU
	RUKuweriNHesUJFKdTsJvNlPf5CZORw67YZigweo0A==
X-Google-Smtp-Source: AGHT+IGLTLekbh8+XrZ9BmP8O30AHCVnZpfUn8T+aLjdqR8rda4rfP7hcYBwRG/8txqcuYyKghMR28PRMOxj5YbG59Y=
X-Received: by 2002:a05:6402:3510:b0:54b:2abd:ad70 with SMTP id
 b16-20020a056402351000b0054b2abdad70mr412234edd.7.1701184798066; Tue, 28 Nov
 2023 07:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125011638.72056-1-kuniyu@amazon.com> <20231125011638.72056-7-kuniyu@amazon.com>
In-Reply-To: <20231125011638.72056-7-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Nov 2023 16:19:47 +0100
Message-ID: <CANn89iLs36CahFdMMTjHX2GcAXYONXuyS03-yuULaOO=aGmozw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/8] tcp: Move TCP-AO bits from
 cookie_v[46]_check() to tcp_ao_syncookie().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 2:19=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We initialise treq->af_specific in cookie_tcp_reqsk_alloc() so that
> we can look up a key later in tcp_create_openreq_child().
>
> Initially, that change was added for MD5 by commit ba5a4fdd63ae ("tcp:
> make sure treq->af_specific is initialized"), but it has not been used
> since commit d0f2b7a9ca0a ("tcp: Disable header prediction for MD5
> flow.").
>
> Now, treq->af_specific is used only by TCP-AO, so, we can move that
> initialisation into tcp_ao_syncookie().
>
> In addition to that, l3index in cookie_v[46]_check() is only used for
> tcp_ao_syncookie(), so let's move it as well.
>
> While at it, we move down tcp_ao_syncookie() in cookie_v4_check() so
> that it will be called after security_inet_conn_request() to make
> functions order consistent with cookie_v6_check().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

