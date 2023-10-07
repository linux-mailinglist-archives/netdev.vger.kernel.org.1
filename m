Return-Path: <netdev+bounces-38720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF417BC364
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 02:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901581C2094F
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97607EA5;
	Sat,  7 Oct 2023 00:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="nsB9FD2R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242A77E2
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 00:42:50 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA543BF
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 17:42:49 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59f6e6b7600so31489557b3.3
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 17:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696639369; x=1697244169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVMlXLjXbEq9vkPA0/Z3RLtT7q/8Tx9JfOtfoXdMJ+E=;
        b=nsB9FD2RnHUhUX5pwQ15W+L57RxFQ6KmzQxVXcdbxBQFsoHh8q6jR/r43dCTWGJtgx
         huA4KvDL5/1JfjNidR5FCsssJjLfrOZ0wPFrdemNRCmHn6ETFSS0KIxZvYlNU7Alq8Us
         928Sm6zICYlGiiDfQUq6gYSZm5C3PhGnK6C5h9npqIPrvR+VG61CE+zDlKU85WPVXoY0
         2iwV4beq+wOMzfSblrkbvjJNCST1ODNwihDiM3OP5FcjIBmfGHraw+Sg0JUrVPuuc20d
         SLjMBWcyAzjcT0ohaaSexBS1HuRQGkfBsEViXjfzs5NTUelEaIVhSbbhXdS0oGzDLgrC
         E5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696639369; x=1697244169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVMlXLjXbEq9vkPA0/Z3RLtT7q/8Tx9JfOtfoXdMJ+E=;
        b=E1g6fV5maILRAcZgknlCk2Bq99vPW8ZhUUp9Vr+dzp6pFuEUj+UaTPn4NbQvBOmw37
         1EDATXXZSTCimflUix7Kht/EjrTz3G4PHao24kjMP2w49WbwrVfhVC/BkCw5aiefpvDa
         ozuaB7P289pDq1b5x8G6Qfb+dcM4zBmPVOy1yt3AAeTi3hMZ3rJW8wFSXWO+76Y/SP27
         uhgwCkS1qo7BmaOtiX060aHl/XAn8zVc8UsN0WaxULvYg8hJ1lAmxjKVCYtuwByStYdS
         IgUfVyOZn1Y28e+vIo+s6WXsNcc+7suoTynk3DRgGd2USLvlS4dlu/5lNjUNCEP3cN4Q
         M5UA==
X-Gm-Message-State: AOJu0YwroHoqA89uGz7002aoB+3nzk3tottvk53us3njqLZqCT5PFg6P
	kLmaqEWDwjmHqHuSgqdg1xqbRkavtoVuZGdB8PARwg==
X-Google-Smtp-Source: AGHT+IGxNYP/x8ROOvJMkfr8xsFLz063uBLH6vkb57HGoVMrT4zefQCOGZM2pFi3Mn5almLSsA7UIlUVB859evCX7Sc=
X-Received: by 2002:a81:83c1:0:b0:59f:64ca:45e5 with SMTP id
 t184-20020a8183c1000000b0059f64ca45e5mr9707365ywf.25.1696639368797; Fri, 06
 Oct 2023 17:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
In-Reply-To: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Fri, 6 Oct 2023 20:42:37 -0400
Message-ID: <CALNs47uzWDOt2ZS9JHOfPYRC4B4pm+bPrp1EnyT-PCRUwUVsFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Rust abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, andrew@lunn.ch
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Replying here to a missed followup on rfc v3 [1]

On Mon, Oct 2, 2023 at 3:08=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> The kernel is documented using kerneldoc. It would seem odd to me to
> have a second parallel set of Documentation for Rust. Just like Rust
> is integrated into the kernel tree, is configured using Kconfig, built
> using make at the top level, i would also expect it to integrate into
> kerneldoc somehow. I see the Rust API for PHY drivers next to the C
> API for PHY drivers. Its just another API in the kernel, nothing
> special. I just use 'make htmldocs' at the top level and out come the
> HTML documentation in Documentation/output/
>
> But kerneldoc is not my subsystem. MAINTAINERS say:
>
> DOCUMENTATION
> M:      Jonathan Corbet <corbet@lwn.net>
> L:      linux-doc@vger.kernel.org
> S:      Maintained
>
> So this discussion should really have Jonathon Corbet involved, if it
> has not already been done.
>
>     Andrew

Having the documentation in the same place and able to easily
crosslink is a goal, but it's still a work in progress. It won't look
the same of course but I think that the rustdoc output will be under
kerneldoc, with some sort of automated crosslinking between related
modules.

The docs team is in the loop, see [2] which was merged. (I suppose it
must not be getting published still)

- Trevor

[1]: https://lore.kernel.org/rust-for-linux/78da96fc-cf66-4645-a98f-80e4048=
00d3e@lunn.ch/
[2]: https://lore.kernel.org/rust-for-linux/20230718151534.4067460-1-carlos=
.bilbao@amd.com/

