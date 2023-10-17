Return-Path: <netdev+bounces-41963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5515C7CC742
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA53B20FDA
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1107C44483;
	Tue, 17 Oct 2023 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDuaXcTW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954954368F;
	Tue, 17 Oct 2023 15:17:57 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A968392;
	Tue, 17 Oct 2023 08:17:52 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-579de633419so71470907b3.3;
        Tue, 17 Oct 2023 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697555872; x=1698160672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+bzE/J8ZGt17tl8akqeT/kIc+0mcRGIKAK2nciDey4=;
        b=FDuaXcTWbUQ2tSnQmfehAt42ixyW2mP6yo210BVgZVbjT3zfNWy1rBb3tSuTn+cUh/
         A3QLTsUwqB7/lz4uwYfCuOuGMlwBpxoXW+elOfrD2GGjtQZ50cpVpmGAc27vjGRLHvCK
         Q6f524ttC8G9MZpk5FaJu4/WzlTPa95rNQfTWtkXeHiex/aysaKWNNKjmMeKHb9/unqh
         HVX1FTqVepeeuKsszTqbC00ADuOe7as0ktrxKZUxnqyUrtMxq3KErWoTng8qmcRl2vTS
         C/rODil09AwV8w+A0+hKdD30KpNsO0ZzVhfkURyMbMcPJBHPdjegELXqTCJve/wYMsIT
         lwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697555872; x=1698160672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+bzE/J8ZGt17tl8akqeT/kIc+0mcRGIKAK2nciDey4=;
        b=Go01fFYeYsZcMrMmy5Oi/f5/jke1zraEbJqjTafS69PteLcVbDH6/Tylt8+omFK0WM
         8u5UX+o4BQFQYspdiAH0tRmqyRJoEue0wRd5tdhRWFqkQEVU7KbRLFuPgC4JltA2RHWY
         T0ToA9PdNKU7DWJiV1YsKdu5QzYpJXB+rtMAFb4gIqPLbzmJWSyvEEzzQs9mJq8Xn/UF
         qCw4qb07qJgRpLAk3oZzYEdtN709ERMy5fUKXtEP2GdFJ+chcBhs1Kh1PBzdFdinEfjQ
         Vpat8v90ohvvl0SoQMp6iX14vMR2HL7Zh/+ugNZWkm67KNM1Rs3s4JiTv8Mlg6aWp//C
         +7yQ==
X-Gm-Message-State: AOJu0Yx0s7KUc4B1UPrjlPH7rVVFABquT4r77XFPz6j9Og62uCxe9y1K
	0SHaqFaxwluV1uw2ObCEHnmuG7/AsYDmPPAa2vb+LQOghOo=
X-Google-Smtp-Source: AGHT+IGAKy4racr1hrrzicGubeAKSnyPCiLhMUkxl1+lYzm0Dno5DLDsv13WcNo6GFT2Xlqy/hENKgz6JYtl96Z5YIs=
X-Received: by 2002:a05:690c:f93:b0:5a8:2007:b5e4 with SMTP id
 df19-20020a05690c0f9300b005a82007b5e4mr2961155ywb.36.1697555871607; Tue, 17
 Oct 2023 08:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me>
 <20231015.011502.276144165010584249.fujita.tomonori@gmail.com>
 <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me> <20231015.073929.156461103776360133.fujita.tomonori@gmail.com>
 <98471d44-c267-4c80-ba54-82ab2563e465@proton.me> <1454c3e6-82d1-4f60-b07d-bc3b47b23662@lunn.ch>
 <f26a3e1a-7eb8-464e-9cbe-ebb8bdf69b20@proton.me> <2023101756-procedure-uninvited-f6c9@gregkh>
 <0f839f73-400f-47d5-9708-0fa40ed0d4e9@proton.me>
In-Reply-To: <0f839f73-400f-47d5-9708-0fa40ed0d4e9@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 17 Oct 2023 17:17:40 +0200
Message-ID: <CANiq72nbhdyPDWebXFphKjwvYT2VdQq-ksDmbOTNezV9OarPpQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY drivers
To: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, boqun.feng@gmail.com, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 4:32=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> This is not allowed in Rust, it is UB and will lead to bad things.

Yeah, and to be clear, data races are also UB in C.

Cheers,
Miguel

