Return-Path: <netdev+bounces-29036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB39A7816F1
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 05:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBC31C20D18
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 03:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939C0ECB;
	Sat, 19 Aug 2023 03:04:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2263C
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 03:04:00 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993B61706
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:03:59 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40a47e8e38dso89631cf.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692414239; x=1693019039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=924+jy2vjhfHmaEy0QaEJXWhtAmNncKf3/NmnJk1YuE=;
        b=hxSiI/8gjN2sh/ZetDFtiVjAtUhJGUSAdvuzy9YNh2dDV+5H9WIhdpSbU1szdejRJr
         XOrXV0LA0o7JeL8ELJjjeuC+MzW/u34n2SPKA5tS0i4z6qKvlki+hKGSKDwqYMcZIIhA
         DH068f8ZxaqxVtowIoJSCuDBoNFOKJ6uy30qZpkLpxetUrLGVvAg6XZJ4Pp8oGePm/Ce
         dNH77hxMYGVNdbm4zwACnX2Cry4HlegMCYimWO/fLA41EL2LootM8/1W7EoIP47du0pf
         T9a6DBNCZewwFsSqi0oT2mkccPL9v90cF+pDz0DpOblx0IXHkFNLJI3U+9O1K+XrSR1B
         99wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692414239; x=1693019039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=924+jy2vjhfHmaEy0QaEJXWhtAmNncKf3/NmnJk1YuE=;
        b=JwRQjKKC8RY8bFxe7dwl5FCElpZJcYn2e0HLh/LcSYurh+KTIg8xEvjyKBE59kRm4Q
         6tcoWvQFYsJalzkSyEpd1cLqXW2323EzGhHpj+sG0VB0JHG4iuSeRffIt34jezyqrCje
         q7+sVuGjVWPr/gRBLKdxAK0D2FE53T9aTEwFhZy7ftSnSIZZiEx+A07c6S7y7/IUv8tm
         K9m+PGoAJbLhl8HDbkZOrNTXTdI2EIxwSAYL6EGd6cCsvIASn4aueOVo1WUePepE3xkn
         qEENrNZLrqr1DuEf2vpt/jRBxSDlaIAhpR0snpmRhPOtfrX6trnGGu2yTgF9eykNMO4M
         jJyA==
X-Gm-Message-State: AOJu0Yxxd/n7gUonZH2Gc8MXaGDlam5pppoh0I6Brqg/kiyTUFMmh0je
	xYvS9KzXSOqmvpklAjsPeAjH/N62hWUaPN/JIUVXzA==
X-Google-Smtp-Source: AGHT+IEpIr01k98ltorHqGUPKcAH8PG4E0wnwrbjk11pgGW6cr31e4BqWQKUVmZJ5ca6nOYNAZFShKCI2Uk/EfqrPZI=
X-Received: by 2002:ac8:5782:0:b0:40f:d1f4:aa58 with SMTP id
 v2-20020ac85782000000b0040fd1f4aa58mr342122qta.8.1692414238642; Fri, 18 Aug
 2023 20:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230818021132.2796092-1-edumazet@google.com> <20230818192850.123e8331@kernel.org>
In-Reply-To: <20230818192850.123e8331@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 19 Aug 2023 05:03:47 +0200
Message-ID: <CANn89i+2_exCdN=qMGJ=cYmpx9P58am98nW5x4fju1PpsMFW_Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: annotate data-races around sk->sk_lingertime
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 4:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 18 Aug 2023 02:11:32 +0000 Eric Dumazet wrote:
> > Remove preprocessor logic using BITS_PER_LONG, compilers
> > are smart enough to figure this by themselves.
>
> clang does complain that we're basically comparing an in to a MAX_LONG:
>
> net/core/sock.c:1238:14: warning: result of comparison of constant 368934=
88147419103 with expression of type 'unsigned int' is always false [-Wtauto=
logical-constant-out-of-range-compare]
>                         if (t_sec >=3D MAX_SCHEDULE_TIMEOUT / HZ)
>                             ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
>

Ah... I thought I was using clang.... Let me check again.

