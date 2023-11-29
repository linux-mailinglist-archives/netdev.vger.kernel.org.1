Return-Path: <netdev+bounces-52311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C217FE44D
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EA61C20AD2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 23:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D106247A65;
	Wed, 29 Nov 2023 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="aD+38mP1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7D510C2
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 15:48:09 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5cbcfdeaff3so3886477b3.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 15:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701301688; x=1701906488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NC6M2ahDfb9yS4fB5Q2Q+a00sO+bDPDpamRwcY9YLA=;
        b=aD+38mP1iM/plI0hGvH3dGQS52CPlKoKbO4PMJo/AmyeUl2TIlWBULyltUFKGoWWf7
         HUGxY4c9Q7DMbb/+zGPqkHtGLaKSxHWJ1/FmliSr37UW8gjUkoNTk9VA8SP2vK03RlRX
         Gp4SXEeVjwMjZvs0ET0r6wo69a6nMpuCdKFzU87/P5MueoSHmv6UrPrfzeFVIP8A08qV
         PdYONByItjb5h56ORzselTUXlaKkvJsx/f4oj4XW2fV+wQqdYz/fA6Sn+085SAAQzsMh
         Ztaz6J4hRsPt0bRvuvsofpcStc8UmmJu3Mn0Y64+JEGYNR+GFwvfFpoMeI1BeYFakXP/
         76MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701301688; x=1701906488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NC6M2ahDfb9yS4fB5Q2Q+a00sO+bDPDpamRwcY9YLA=;
        b=fvWVq6+5YMUWeeXmt5utDjbM0RxtU94xrw9rX1r+n3JWgcFThwYIDCMwgbOk1lYeg/
         D1QZBtSODNXFFpRqhIop3vh9iU2sA1mRX3hY0bczeGCZCdcQ4vBiix2HaUHbctzddDcx
         j7SCgG9lA5Fm1ua/PJYkZiWpllb3AubJFA9w7WCAnWdvnaQ54i3Q4XgC0Sb73tsCktP/
         cKAX1MXnM4GPh6V/7CqXv6cRDekrFii9TVBovjo+c8M6zkJhrECXgDU4dEy9P9sW4nu6
         5GXCn7o2LwIYtve06ebGTLDhnxbXjcjSHxQeFUtHWloAW73NFyUl9BolLohcbkzLH6e1
         BxqA==
X-Gm-Message-State: AOJu0YyxVFK6hZdQaKx3kB+wzCuaJ7jy9i//zQfVyla3bLBVd9KeljBu
	sSwTSSLBbvGjZe9UF+IKTUhrG0KZNPrNlVKLG/HQFg==
X-Google-Smtp-Source: AGHT+IGzlwg1krhw5pbVNhYB2NjkVGjZzcfur4zemp/oS30saYoyeiLUMK8+JztsH4TSXvGe0Lk04Zetks3pQ6ZN/O4=
X-Received: by 2002:a0d:c582:0:b0:5d0:aa04:7b76 with SMTP id
 h124-20020a0dc582000000b005d0aa047b76mr12450890ywd.20.1701301688590; Wed, 29
 Nov 2023 15:48:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129222424.910148-1-pctammela@mojatatu.com>
In-Reply-To: <20231129222424.910148-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 29 Nov 2023 18:47:56 -0500
Message-ID: <CAM0EoMk=oU8PRQoN79ccnVcqcsX9PgcZf+qucr+ni7JNAhmPTg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] selftests: tc-testing: more tdc updates
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:24=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> Follow-up on a feedback from Jakub and random cleanups from related
> net/sched patches
>
> Pedro Tammela (4):
>   selftests: tc-testing: remove spurious nsPlugin usage
>   selftests: tc-testing: remove spurious './' from Makefile
>   selftests: tc-testing: rename concurrency.json to flower.json
>   selftests: tc-testing: remove filters/tests.json
>
>  tools/testing/selftests/tc-testing/Makefile   |   2 +-
>  .../filters/{concurrency.json =3D> flower.json} |  98 +++++++++++++
>  .../tc-testing/tc-tests/filters/matchall.json |  23 ++++
>  .../tc-testing/tc-tests/filters/tests.json    | 129 ------------------
>  4 files changed, 122 insertions(+), 130 deletions(-)
>  rename tools/testing/selftests/tc-testing/tc-tests/filters/{concurrency.=
json =3D> flower.json} (65%)
>  delete mode 100644 tools/testing/selftests/tc-testing/tc-tests/filters/t=
ests.json
>

For the patchset:

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> --
> 2.40.1
>

