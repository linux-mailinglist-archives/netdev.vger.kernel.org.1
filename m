Return-Path: <netdev+bounces-39324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24827BEC55
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 23:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C55B281B67
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 21:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A334D41210;
	Mon,  9 Oct 2023 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="f7fK7oYW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD33FB3A
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 21:07:31 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE73A3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 14:07:30 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59b5484fbe6so60920547b3.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696885649; x=1697490449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhHHmnMpAVB3xgxYZZEuhrUO5GUtsjcq6PiX2il6rXk=;
        b=f7fK7oYWJlJftB0XL1nTp0ZYAEpgw7JNQDxX9sRzoEpDY0j67r2T26bcKEZlnf/TnI
         CQ3iRbSpAsCbALPA38LqJY2SMd3mhHXW7vIXqb906+NFwZECykCJoes4lGugQF01BSmk
         LukzsK2A45EYYjJZuGcHiY5N4VWb/MZzgxI7rXQqyAE7q9WUwVLVaYVuWEtyv0rfK58W
         jb+zJvcQSSEahFicMDcR/U/niXMWFNMgC4vyOGNV1KTL6ws4iVq1tfNjLPaC/SiQpCYS
         wKoq5IHOU+m8ztNnSNfkSbLEcjCAbvn3pSIhI5KZQIV/39DPLyka6D4z6U5qWSHQGLZa
         StOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885649; x=1697490449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhHHmnMpAVB3xgxYZZEuhrUO5GUtsjcq6PiX2il6rXk=;
        b=vKsoNZpZkJhlqrR4Vl3K4YOAZSOeC4HR4PiVw6+l+ccfjVxACExGZtOQMI1fZe7Ghp
         Qy/HT0ungVgbwgzlAvIseagcNUdUIDQacjrmQCBQ5SU8TEtgfeGld9JafBRPnP9ApW99
         rSJuVaPa1s1PE2saepCVvC64bMgphMQbGgIFzE7vqsXwWENOySKt6lnvDi7wuumA98kI
         m6ecqtiuac6v37UCJDxxe7rSFTZjbySSXwMO7wNow3ZW/4Cnl8irs+8c5Ydku1uzOHsV
         r/w09IughhJyH0gybploH6idZncPd9//C1P9ilBJlAONx26CPuLX3L8e2q0s1e68+0bl
         2xoA==
X-Gm-Message-State: AOJu0Yww0Qjj9W7ufkGZDF+8+Ah2AnC62j0T7MBWntYN5OB8EFhY+5Di
	0qDL7lVtsREtvFJuOtMhFds268p/VMLobk+F7jBngQ==
X-Google-Smtp-Source: AGHT+IFOyJSwDK4Gvh2QH+SIfWKit9G2xxBqdIDWi4IwiYePhqViFWyKFTSML3UW7GWqxckhJ4dflsCHMK+5nqmTZyU=
X-Received: by 2002:a81:778b:0:b0:59b:ca2f:6eff with SMTP id
 s133-20020a81778b000000b0059bca2f6effmr17595885ywc.40.1696885649746; Mon, 09
 Oct 2023 14:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
 <20231009.224907.206866439495105936.fujita.tomonori@gmail.com>
 <2023100926-ambulance-mammal-8354@gregkh> <20231010.002413.435110311325344494.fujita.tomonori@gmail.com>
In-Reply-To: <20231010.002413.435110311325344494.fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 9 Oct 2023 17:07:18 -0400
Message-ID: <CALNs47unEPkVtRVBZfqYJ_-tgf3HJ6mxz_pybL+y3=AXgX2o8g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: gregkh@linuxfoundation.org, miguel.ojeda.sandonis@gmail.com, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 11:24=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
> Trevor gave Reviewed-by. Not perfect but reasonable shape, IMHO. Seems
> that we have been discussing the same topics like locking, naming, etc
> again and again.

To be clear: this is ONLY for the rust design, I am not at all
qualified to review the build system integration. I provided a review
with the known caveats that:

1. The current enum handling is fragile, but only to the extent that
we do not handle values not specified in the C-side enum. I am not
sure what we can do better here until bindgen provides better
solutions.
2. Types for #define are not ideal
https://lore.kernel.org/rust-for-linux/CALNs47tnXWM3aVpeNMkuVZAJKc=3DseWxLA=
oLgSwqP0Jms+Mfc_A@mail.gmail.com/

These seem to me to be reasonable concessions at this time, but of
course the other reviewers will request further changes or perhaps
have suggestions for these items.

