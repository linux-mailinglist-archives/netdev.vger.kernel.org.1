Return-Path: <netdev+bounces-38949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7C67BD258
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 05:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64631C20949
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 03:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0329F8F75;
	Mon,  9 Oct 2023 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="X0ZVDFh1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D180F8F57
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 03:23:01 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0409A6
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 20:22:59 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59f4f80d084so48641027b3.1
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 20:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696821779; x=1697426579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5rWOjZMA+Wx1ZERnLIr99/RJOheXn8WoCGO6fDXV6M=;
        b=X0ZVDFh16EvyxiO9et0O6aQ3j5adHnNg3Fo4O+d8pFKGfyI54PTNVBHmowrFTEmW4M
         eYCtGPFXV4y5rDYaP3HBe+SLkyR9YQD1VmMegwsoVgS2jG/bC8n5x9vjcBwmlQc3pIS4
         NZeCn3oxFbMY4WKF2dittkko/a6YBJ9PtF25vvR7HJgtR92Q4ggAqlKfhrA/LfyBniB9
         0pxEWURmmE4FflOvsynK/dU3tCrtrH+to28q+6NVuaOeaN9VLC7vQjZLLTB3pT+AqzX1
         EY9aSkiQxcONnX8yfMk4vUhVC9nYJMvXH+YY/6J0TOicjQc+Ye8PT92a9RTBrddwE9NS
         NZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696821779; x=1697426579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5rWOjZMA+Wx1ZERnLIr99/RJOheXn8WoCGO6fDXV6M=;
        b=UklS+mYo7Ga6ZtWZ+QmYIDDzMSj5ts6imtOtZQpJz6VQkQmo1uk9FTI/amLUkTOVuG
         cW88vg5rTnYxRw5LlYrfDAEjfPeJy2qtuGh18QbGl8Wt7lglcsM1nFJFsrM/8LAOt3So
         8lzht5ZcP8MpmzET+SqUFEOcex0KIalDBFQDcaCEnmJxYWCIZaGui4wTwFL93jqJsvt9
         Wpora5Ant3BxYOFOy0Zy+Lts7dzBoNz4Kuo+Ie2booYz+eoVUP4+Q5qhXWLwyLaol8xG
         ElZULPIM3/CZiaXWbLnhti81Dddw5Eit4fqpLJdN912THbMMPos3nLGLFSF0XcT3LUHI
         w39w==
X-Gm-Message-State: AOJu0YyygbGM1mkBaN/saU54oXuyOaBrDVjT8/QkWPiENchwpH6HtwTk
	IqO/xJs7zcE8Bdo+0f6M4hVxoO3ZmvZ3TFGBsapuuPYxAxo1wMeKiSuKJg==
X-Google-Smtp-Source: AGHT+IGPH2zPpal2bpCB1kVhT4XQQWq7gTrrKUKB0nMKnPJYN8iHkqVbVtjTxFIwIUezE99urTybY4e4vygcYKRnwmQ=
X-Received: by 2002:a0d:e905:0:b0:59f:69ab:22f2 with SMTP id
 s5-20020a0de905000000b0059f69ab22f2mr13534388ywe.40.1696821779171; Sun, 08
 Oct 2023 20:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com> <20231009013912.4048593-4-fujita.tomonori@gmail.com>
In-Reply-To: <20231009013912.4048593-4-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 8 Oct 2023 23:22:47 -0400
Message-ID: <CALNs47tnXWM3aVpeNMkuVZAJKc=seWxLAoLgSwqP0Jms+Mfc_A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 8, 2023 at 9:41=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> This is the Rust implementation of drivers/net/phy/ax88796b.c. The
> features are equivalent. You can choose C or Rust versionon kernel
> configuration.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---

Thanks for adding the speed bindings. The last thing is that I still
think we need to figure out a better way to generate the correct types
for #define values (discussed around [1]) but we can fix that later.

Reviewed-by: Trevor Gross <tmgross@umich.edu>

[1]: https://lore.kernel.org/rust-for-linux/CALNs47sxuGVXBwhXZa5NgHQ8F0MH2O=
oUzsgthAURE+OuTtJ1wQ@mail.gmail.com/

