Return-Path: <netdev+bounces-45181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5405D7DB481
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 08:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2FC9B20CD4
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 07:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5156AB6;
	Mon, 30 Oct 2023 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZp7Ftxp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562306AB1
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:39:46 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A8AD6
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 00:39:45 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a877e0f0d8so43834647b3.1
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 00:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698651584; x=1699256384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2xzc+4V3pjtNNji+lt7+KZcsYsbe7/AwgknDeXfupc=;
        b=aZp7Ftxp2VsEE7ZvbwEelk8uUN4tbWHeU8PWkmlPO7lFgVyut2VFSjDAE/Mbbl88AV
         kAlWjgCXKPxIunYabPbfpol3vfPSvYhX+Xzo3J50TRZdeQ1HroOtQ32DcECZ5TZgmQ2o
         8/6UJaASQPEB0TCDi7nkRTA1HleITA0pWtV9Ehu1ILIlinERGC8bv+o9pYBrq2VY6GWV
         AbVA6WknWIJ7MQjMVtocg6JIpxWPWNOuSPUMTBFHRGcscbPWvjkno8pxvQhXPKEUW4ow
         pAtiIiZr3RSjfax0vO9hQEGdanbHa/Bfh2HkP19v8l8qj7mQmLGTdTua6rlVT14WA1fl
         0FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698651584; x=1699256384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2xzc+4V3pjtNNji+lt7+KZcsYsbe7/AwgknDeXfupc=;
        b=vCIb+cmUlsOjEGJPYv91jaRyWvnucgCMAVPgldfRg1P8nf2YDvCQm22SbrsjBShwEG
         36Pv2j2XtOV2JUbwJ7P9jrXjkYTNkNAqdNpY9ZqQX4ymsX7PASwZjER3V4ETOUkfR+/Y
         TUDR4lNVTGpLV2gSCpvh+LykoeU/KE90L3K/iQY70rehtVVlXfVzZdSRtltGUQWdlE8E
         VE+QPjv84FNiH+Gho47bxn+qMmBY04wrPLVu4ZIdn0FxFBV3nmSZulG2tQgCvK3wbjsN
         6bxRslBkoTTb6gS/NlIFy3u4B0t10KdkGLnjKujJf89I8sN/WIpM4+8iNEVLiKalC8a1
         m0rw==
X-Gm-Message-State: AOJu0Ywq1bzp9/fR0ZPil/XEb9kfuuj0jQEBtK+WU45txtoeUxDe5Akh
	qOSgGHabuALJagLnAYgJwXwbEYjG34wEe0J/FRZsqQ==
X-Google-Smtp-Source: AGHT+IGzN5VdTFqyOdXnElQpS0BpsQlNE2DuCDvNp8TKt1PyIUJ/oxKGJYobpdPpd4lVLkf5kG9gp2v3udScopsX0Dc=
X-Received: by 2002:a25:4246:0:b0:d9c:28cb:2e54 with SMTP id
 p67-20020a254246000000b00d9c28cb2e54mr17328230yba.18.1698651584308; Mon, 30
 Oct 2023 00:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
 <20231028220402.gdsynephzfkpvk4m@skbuf> <CACRpkdbq03ZXcB-TaBp5Udo3M47rb-o+LfkEkC-gA1+=x1Zd-g@mail.gmail.com>
 <54f8d583-e900-4ce8-87d1-a18556698f10@lunn.ch>
In-Reply-To: <54f8d583-e900-4ce8-87d1-a18556698f10@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Oct 2023 08:39:26 +0100
Message-ID: <CACRpkdZXAqkn0QeX4s2JFmyMOz82uQq7C18408Kow-peN8tCqA@mail.gmail.com>
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, DENG Qingfang <dqfext@gmail.com>, 
	Mauri Sandberg <sandberg@mailfence.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 12:00=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:

> > 1496 is suspiciously much 1500 - DSA tag size. However the
> > MTU of the parent ethernet is bumped nicely to 1504 and the
> > device MTU is set up to accomodate it as well.
> >
> > Modifying the patch to just pad out packets >=3D 1496 bytes
> > solves the problem in a better way, but maybe that is not the
> > last thing we try here...
>
> Have you tried playing with RTL8366RB_SGCR in rtl8366rb_change_mtu()?

Yes I set the MTU to increasingly larger sizes.

Sadly MTU has nothing to do with this, it's really annoying,
I have a v2 patch that is better and working, I'll include some test
text so you see where the problem is.

Yours,
Linus Walleij

