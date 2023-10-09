Return-Path: <netdev+bounces-39095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BE57BDFFD
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D02281646
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E0B27EF5;
	Mon,  9 Oct 2023 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiZqVNS5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6A12E649;
	Mon,  9 Oct 2023 13:36:22 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05865CF;
	Mon,  9 Oct 2023 06:36:20 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d867d4cf835so4856035276.1;
        Mon, 09 Oct 2023 06:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696858580; x=1697463380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9/CE8jf3Kqh5eQOGMntDowyF/zpfW4n4FgQOJsFvwM=;
        b=UiZqVNS5d5A7dgGjEISnf4UtZgWKsQkAeqsZIzu5jJ3EsEdHRXLzhwEuMlnCQ6r0TR
         0/XHkaNWIo8VB1OcaEZboc4XKLba+jDsadcvYh/YvW0u7EvGHC2jqYqmYCw4WijC3U8r
         u+Xcck3uJXUdvqo9nWR9JDfJCPnTG62ER4oib4dRzul5oT0KFoElL9zAjteN1xixsPbB
         dpgoquPx/4UcxUDQVu3YF1QPSg7vO/iV2MMZFVxoDNF9WejRDfPifJcr5h5MFywE5/kg
         Ej2NFdiYHtpAIVjBuDdOSl+Nl5c+cmYS4WIhKhE7KTeQAV+snFMTIQ6EktQbpwMK0nOI
         OS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696858580; x=1697463380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9/CE8jf3Kqh5eQOGMntDowyF/zpfW4n4FgQOJsFvwM=;
        b=p+J9foTcHpg/Ap7JCYRjEik7SzcXgudUBR6ifjxx2H2bkK8O26WVcPapL+GTRVG9n0
         mUIh5GrKComj7Ud5i30Rl4DOtN9OLWUZwAwK0+YrUwX0ELCmy3cIh8ZXycyc9lHo6rGx
         CHPOqfrpSrAAhrYwXHRrNVz6G2QWqgzcTc6/Uhica0FWuYUDxTbfRRJ0jHLaAmVTmQ9I
         mcRgaBe/UHP3oEB7fuBVzpgI3V8fhPl2LjsPbExLah2OTpSpYcmm78zY+vbmi7JEsvV/
         obDHRY9pRH6wTZBPSZBLKtJkWWkn8IeKGjh2uGpawJlrs1ICPaALB9ho6dhQ+SWOmZ6W
         FOFw==
X-Gm-Message-State: AOJu0YxevrMZu34uyBY/SVVgneL5SBgvlJQ/4b7ZTIrtN2m5H6JcAaJy
	X68bJGVktDhMUnwsaDOz8V1AX824abTVNaIde78=
X-Google-Smtp-Source: AGHT+IFwhsKcEVE2t9ABTh+RNK7sOSiSauSYfIqAJqBQtjgr9jpHjvBGwAeHrgqWr47HNkLf7YwWpk4DPBGTMRmVYcA=
X-Received: by 2002:a25:c7c6:0:b0:d77:d31a:e05c with SMTP id
 w189-20020a25c7c6000000b00d77d31ae05cmr16140595ybe.61.1696858580157; Mon, 09
 Oct 2023 06:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch> <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
 <9a23f2da-8f98-4ca2-8ca7-bb264ea676dd@lunn.ch>
In-Reply-To: <9a23f2da-8f98-4ca2-8ca7-bb264ea676dd@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 15:36:08 +0200
Message-ID: <CANiq72m849ebmsVbfrPF3=UrjT=vawEyZ1=nSj6XHqAOEEieMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, greg@kroah.com, tmgross@umich.edu, 
	Andrea Righi <andrea.righi@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 3:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> I really do suggest you work on your kconfig. The expectation is any
> configuration that kconfig is happy with will build. People like Arnd
> Bergmann do lots of randconfig builds. We don't want his work upset by
> Rust code.
>
> And as a Rust beginning, i find this pretty unfriendly, in that i
> followed https://docs.kernel.org/rust/quick-start.html but did not get
> a working build.

It is a "working" build: some people are actually using it as-is on
purpose (with the warnings, I mean).

Yes, it is bad, and we did not like it when they told us their build
had those warnings and still used it, but it means it will make it
harder for them when we restrict it.

But your message is the perfect excuse for me to send the patch to
restrict it, so thanks :)

Cheers,
Miguel

