Return-Path: <netdev+bounces-39197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798337BE4B3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4141C20A69
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBA337160;
	Mon,  9 Oct 2023 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k24X9IbA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEDC36B06;
	Mon,  9 Oct 2023 15:27:49 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90BFA3;
	Mon,  9 Oct 2023 08:27:47 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-579de633419so57488587b3.3;
        Mon, 09 Oct 2023 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696865267; x=1697470067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab1PvQ4kZODCulvC3SuPUlLKw9VlDQuA4HRmLKKxcsU=;
        b=k24X9IbAVNGahuoGnYKQdMLhqxYB6j7JXi/l/e1r11p2/iOZsgYIfg9tBt5YasxvqS
         IlPNGRyq9P4OJxT2MXjJE+JntQGQ0wlUVoXCXLcC/NDTfbX5KFtKO4gRTwNgFIwmOQQJ
         MzWnT1mzlNlbaVjqnbJA8XbEUPjBt+lHr5EJLn0rPJm9pV/g4WvaNzXcwQA9ts0uuPRi
         RSS0GN6HsCrTFRMqbsmnA1g1F6wbixE020mBdzJDdL8huMmkCHr3SsARn2NHJO0p1yKg
         +0BgdJKCXsKHz3XhiYviGUM2AAT804GzIVkyWjYecXs1AhRZHNyjrTO1ud5NCoVAdjV6
         co+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865267; x=1697470067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ab1PvQ4kZODCulvC3SuPUlLKw9VlDQuA4HRmLKKxcsU=;
        b=JRWmfVoHD8auF07falyvZWrg1wBBMEHRupbHmUzvHsrxr6Co9LEwSH95nFvCA0zCyN
         oabYE1IfAfaGvy8sByixOlYhNhjmyW41yr8zQs5ianuQqokuXSFiIV22rSFrGQzFNnCX
         4e6sZb7UYEKa+ZHp6MvZPXVdDiz9TAgIAesh/XkgF6C73T50aoKp5YFGPoWw6CwHk0PR
         0SiTlmkJnsWJRcmx83SgkbBLjC1e7HcWZIFBRYiX/vQjE/ZiDr33BummaraN57xI2CjD
         vPrZeHSdTAP3xO/CAYYOCGpyv/ghVhebhplGBqKH1wPSXUc+7wT3gp3BUts3pDrQBqzz
         7oyg==
X-Gm-Message-State: AOJu0YwYjwclevJkR1t82crZNW2YJ2tr/SGOcesNsyGPaRC7fJthmE0F
	1P9gTzemjVxZhhTXH9JpmGFeqe9q89Cb1dwJD60TWcCm+NILcWnN
X-Google-Smtp-Source: AGHT+IFf5FgVNSLAkOaLEuEixLF48BfqU/cugAYMUNGUVUXFyOKQvRhwZcJqveiDCwnKG04htqNumOrnpxNv3aBK5ZM=
X-Received: by 2002:a81:bf54:0:b0:59f:4e6d:b56a with SMTP id
 s20-20020a81bf54000000b0059f4e6db56amr16194787ywk.2.1696865267077; Mon, 09
 Oct 2023 08:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-4-fujita.tomonori@gmail.com> <ZSOqWMqm/JQOieAd@nanopsycho>
 <bdfac30f-364f-4625-a808-fcffab2f75b4@lunn.ch> <CANiq72k4F4EY-cLYMsRFsAnjd9=xyMN_4eHS9T7G1s=eW7kHjw@mail.gmail.com>
 <fd715b79-3ae2-44cb-8f51-7a903778274f@lunn.ch>
In-Reply-To: <fd715b79-3ae2-44cb-8f51-7a903778274f@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 17:27:36 +0200
Message-ID: <CANiq72=OAREY7PNyE2XbFzLhZGqaMPGDg3Cbs5Lup0k5F7fnGg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jiri Pirko <jiri@resnulli.us>, FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, greg@kroah.com, tmgross@umich.edu, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 4:31=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> We are at the intersect of two worlds here. Maybe these issues are
> well known in the linux for rust world, but they are not really known
> to the netdev world, and to some extend the kernel developers /
> maintainers world. We need to spread knowledge between each world.

Indeed!

We are presenting in netdevconf 0x17 in a few weeks a tutorial [1] to
try to cover a bit of that with a tutorial on Rust & networking
(thanks Jamal for inviting us). Hopefully that helps a bit...

[1] https://netdevconf.info/0x17/sessions/tutorial/rust-for-linux-networkin=
g-tutorial.html

And, of course, there is LPC & Kangrejos (the latter already happened
3 weeks ago -- we had most of the slides already up at
https://kangrejos.com). We also had some LF Live: Mentorship Series
done in the past.

> So maybe this "lessons learned" is not really for the Rust people, but
> for the netdev community, and kernel developers and Maintainers in
> general?

I apologize -- I didn't mean to say that you should know about those
things. Just that, we are trying to do our best to get things ready in
the best way possible, while letting people "play" meanwhile with the
abstractions and so on.

Cheers,
Miguel

