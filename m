Return-Path: <netdev+bounces-43392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC57D2D6E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 10:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563B41C20842
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7677125D8;
	Mon, 23 Oct 2023 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="Ztcng0lp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B6125A6
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 08:58:03 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39738E8
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 01:58:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso4616803a12.1
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1698051479; x=1698656279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h2WG4KUSU+YtmvvjUHtWBSQpqrAOSEV3sTQwM7C/Ug=;
        b=Ztcng0lpN9O6/VRWeBqx3h8q1c/IeEXY7oUSqwKap5Vjor5FJ8o3Qbuwxkwm3yMvVS
         ZbMIf/+16idz/fnp2Qgp/JOGlLEbstbwmNNX/smxc16ZUQZZxNtG2DxK/Xbi926Dg4Zq
         11CYCKdmighwlhAGC5e5lMhQDdgbT8xm5zjZbY6K/A0inPoYeZYihQ1K4RvhE/j8JTHm
         ZrxLK0Bvh18kfEKMPZaJJFb4OBmPjaCbIh9mjIgfwbOwx7ijG1RIOxdES/PxSb/emuAB
         5QdRaag0+mgmd4TEGiqi2bIIXzzGesSlbo49YOhhF4a8IrN403Av82fRKx9A8BHlLq+G
         63Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698051479; x=1698656279;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7h2WG4KUSU+YtmvvjUHtWBSQpqrAOSEV3sTQwM7C/Ug=;
        b=SuUVmwdSqUuqP5T1lWrCgDzSQ9VB1MTmGO4L4bic5qOhpESpgbRnMetXjsaULsJROJ
         Gwig2cYplbRResSGtRD2zJYlJimQQo+R52ar3yzB0ueUH4QInZFWpkBW1NuesDk0cJTM
         QFnGvuqZIT4Z5gwD7Tirlz3VHCYiz4uwxDZBIbfGViUf5/0dE0KcD+UHGAkDo9z534ZQ
         0lOKIPGeAzsdldBcmnSZJVMBq4h3hc8MWdGExZd8Pzb0QjmIcXrBwGEzNXdFpq9MKI2d
         A6Ih4h3SJLo4Nij6h/FFTdDJavgfa+XrJZJYMLKKysL2BpBXoLWOr+OJYra+5ecjLuVJ
         1Zrw==
X-Gm-Message-State: AOJu0Yx1N0/5ExyxzKum/VCN/A18vHpHIgfoPHIdNNT5gjnnpKpMzITs
	uVpeQ7mlcHysS17oyQrTqgBH+Q==
X-Google-Smtp-Source: AGHT+IGjVxI0f9phHE1ahayFyDC+7bgeXPsV5ImR3xEXfKth55KTo11sGFKWfrHT5mbEgePwbYNj1Q==
X-Received: by 2002:a50:a6dc:0:b0:53e:343a:76bf with SMTP id f28-20020a50a6dc000000b0053e343a76bfmr7000942edc.1.1698051479633;
        Mon, 23 Oct 2023 01:57:59 -0700 (PDT)
Received: from localhost ([194.62.217.3])
        by smtp.gmail.com with ESMTPSA id e24-20020a50a698000000b0052febc781bfsm6122055edc.36.2023.10.23.01.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:57:59 -0700 (PDT)
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
 <20231017113014.3492773-4-fujita.tomonori@gmail.com>
 <871qdpikq9.fsf@metaspace.dk>
 <CANiq72kWu-zNbhYxvcM7TVFLOEoRczK434J2t4rLhU31AMWAwQ@mail.gmail.com>
User-agent: mu4e 1.10.7; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 boqun.feng@gmail.com, wedsonaf@gmail.com, benno.lossin@proton.me,
 greg@kroah.com, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH net-next v5 3/5] WIP rust: add second `bindgen` pass for
 enum exhaustiveness checking
Date: Mon, 23 Oct 2023 10:57:46 +0200
In-reply-to: <CANiq72kWu-zNbhYxvcM7TVFLOEoRczK434J2t4rLhU31AMWAwQ@mail.gmail.com>
Message-ID: <874jihhg15.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Fri, Oct 20, 2023 at 1:42=E2=80=AFPM Andreas Hindborg (Samsung)
> <nmi@metaspace.dk> wrote:
>>
>> This patch does not build for me. Do I need to do something to make it
>> work?
>
> Please change:
>
> -        --crate-name enum_check $(obj)/bindings/bindings_enum_check.rs
> +        --crate-name enum_check
> $(srctree)/$(src)/bindings/bindings_enum_check.rs

This works, thanks =F0=9F=91=8D


