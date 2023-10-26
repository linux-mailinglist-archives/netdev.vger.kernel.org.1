Return-Path: <netdev+bounces-44466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9FB7D8173
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 13:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9464F281E4E
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 11:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE59199C3;
	Thu, 26 Oct 2023 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQhtYWMt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB613FEB;
	Thu, 26 Oct 2023 11:03:10 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602AB18D;
	Thu, 26 Oct 2023 04:03:09 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so515204276.0;
        Thu, 26 Oct 2023 04:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698318188; x=1698922988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUQ/5wmlkJPU6v6x0VuEEuWOOfCn0FpowBmEhjh61ng=;
        b=cQhtYWMtSvY0/iNS8cowkb7w/MuYCMNgAtpR2Sn5rOVaIDytLGeytIXX5MhZa53F8L
         Fk1duCPIdgkgfnRxZPSHrmiRCmi7guS2oauMKf7pATyU+SMYGD4USq1YLbv4xZCwR0SR
         PeHq791CA3MBTZtXqI63j1oGownkdl3V5bhbmSIzZy3Ts52av9nBcGAgLFPPhVw/OzFg
         oyr/Q7ODI68AjuSFbGfnDKUNYKY5IMZOzZ6M0txNKAZmHLFvbjwJnBc8nMPhbU9qjWd4
         iSeI32xmLaui17UyJgpGbScVTsiShYOMwf5ce+x0XDrYVZ2Ve/UX4MTMbKNn/l88kL8x
         NkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698318188; x=1698922988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUQ/5wmlkJPU6v6x0VuEEuWOOfCn0FpowBmEhjh61ng=;
        b=Vsb/z3E37DW2u8LzuaLscky++LGB0Isruj65bQ2Uh5aTc5Sm7B4ufYNEwgBpKy9cby
         qmEf8dGW1WGK5kqHoqiwDozCmi/EYRXhEMe014+qCql3PggMZXxFWhzWEai6ybR9jLI3
         O+J/YUHM2GEuJHMC+gIhFCWGQe17vF9a89nYdpIddKv/X1TF71ZQNKBXNR3DNszOskpm
         oWfniNN8qIoWhqKR/iGznxvjQDa5j/5u83qOH+oqM0YnGviUTvxBmTc8vlY2hWlgd1xE
         zObTsgOM9uCmARzn5C6buiB+129QeEntjwsSFnMQF92StGJneXuM7IYZS+u4qrcroFvr
         bCkQ==
X-Gm-Message-State: AOJu0YyF0yCfkjNZsEGRalKKHaBEf5H7CpS/kQ/CxczFnLiKe99H9qwx
	tvASXKdzzI56sg8bYnW5BaHeaWCR7I0BBO+hxZI=
X-Google-Smtp-Source: AGHT+IH4/FDit7NlrbqCRHv21BSJJHaeCqTqwHM2v5JqXjUYZOaXAmtip0Jt2WRJRS492yinHqGVSbLHwYcgx5Zg98U=
X-Received: by 2002:a25:7811:0:b0:da0:5c2e:1799 with SMTP id
 t17-20020a257811000000b00da05c2e1799mr6280317ybc.19.1698318188498; Thu, 26
 Oct 2023 04:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com> <20231026001050.1720612-4-fujita.tomonori@gmail.com>
In-Reply-To: <20231026001050.1720612-4-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Oct 2023 13:02:57 +0200
Message-ID: <CANiq72n6Cvxydcef03kEo9fy=5Zd7MXYqFUGX1MBaTKF2o63nw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/5] rust: add second `bindgen` pass for enum
 exhaustiveness checking
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	tmgross@umich.edu, benno.lossin@proton.me, wedsonaf@gmail.com, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 2:16=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> From: Miguel Ojeda <ojeda@kernel.org>
>
> This patch makes sure that the C's enum is sync with Rust sides. If
> the enum is out of sync, compiling fails with an error like the
> following.
>
> Note that this is a temporary solution. It will be replaced with
> bindgen when it supports generating the enum conversion code.

> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Please do not modify patches from others without warning that you did
so. I did not write this commit message nor agreed to this, but it
looks as if I did. I even explicitly said I would send the patch
independently.

As I recently told you, if you want to pick it up in your series to
showcase how it would work, you should have at least kept the WIP, put
it at the end of the series and added RFC since it is not intended to
be merged with your other patches.

Cheers,
Miguel

