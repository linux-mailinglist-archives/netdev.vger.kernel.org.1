Return-Path: <netdev+bounces-44714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F027D951B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6483928238E
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796D4179A4;
	Fri, 27 Oct 2023 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F788/YGc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067751802F;
	Fri, 27 Oct 2023 10:21:46 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6405CDC;
	Fri, 27 Oct 2023 03:21:45 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b2e330033fso1065244b6e.3;
        Fri, 27 Oct 2023 03:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698402104; x=1699006904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOA5n4+aeaz4PKMBVniFLZW5T/elOQF7U5fSbJ0rn30=;
        b=F788/YGcdmxWXpD+W3pPvX//pz7TzyUQOf8UiBdmqiX+gWk+gbOzyp7bCL8/KCA/Ew
         ssKVx9jSOH4I6Jdpg5jxzCmv5YaWQcmQoySV/hs7CQaCPOHr/ez/My/L/1rb8MUrxaKa
         iQQNGAUqymysmgAyl6b3tZKWM2BsVkmuSeHayfEvOs+rQSHka4vFFRoQTQIovL3wT/5W
         r+MlXZr950KD6befmhUfTOL69oeK9ruZcwBHf3tBI7KmnDwrjR+HhTSfC+5GkxuWWIRG
         yuTNlCBISoqYTXuUS1LNQWTL32pLd3XdQYFQUtDnft7/RuFxRMiZsQsdSopid9dazPKp
         cB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698402104; x=1699006904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOA5n4+aeaz4PKMBVniFLZW5T/elOQF7U5fSbJ0rn30=;
        b=RoFe1VkddhcGJrSqI5Og5Ty24AKDhKQn91Tzk0x8bsmFPBV7Oxq9OS0jJGDqltKHBc
         l3pEyv0h0DhpGTTGI6xG0uZAHSIsb/U1wumzP9ji2DUt2wSdEQXK+dr1dflFKWMXys0b
         7MfGGdnInYFvcD5Gxyk5GK0l12oCsTv2LVH6FJBDWJJfMYywdktyyZAZ4+LKa4fb5w5W
         /mqv7rFWQ43UZmx0GUp2YScX8UH+4aRnypRqPVuGUwXrOHhBp1mG7kYoAXvDlp3y8SAE
         9RdF9wteaWI6YRyOU3Thah2siKkeLT0XiagcqoKOYDE4hJzxCrghfcWugRWZkYtvxwne
         5I/g==
X-Gm-Message-State: AOJu0YyZp9fHbG6EsE89EVCpnPwIBiOAweXR5M3bml3+R5/XV/Z6QYwT
	Ivi1Dnc/HXN2S9gTgn2kni5NzbUGXJSvi7hErnuV8Xmrm2/1vw==
X-Google-Smtp-Source: AGHT+IGNUL6cclD/kMRyUR4nqWwXlH0qxTYwwpnNeLIIEuMZznbp52dhqPsCxAHgwY943rEl/jKsIXz6yPx1IoXB2cU=
X-Received: by 2002:a54:4008:0:b0:3ae:5e0e:1671 with SMTP id
 x8-20020a544008000000b003ae5e0e1671mr2184974oie.4.1698402104647; Fri, 27 Oct
 2023 03:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com> <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch>
In-Reply-To: <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Oct 2023 12:21:33 +0200
Message-ID: <CANiq72mDVQg9dbtbAYLSoxQo4ZTgyKk=e-DCe8itvwgc0=HOZw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, benno.lossin@proton.me, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 1:48=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> That is actually about right for netdev. As i said, netdev moves fast,
> review comments are expected within about 3 days. We also say don't
> post a new version within 24 hours. So that gives you an idea of the
> min and max.

And as I said when you told us that, that may be the right policy for
C netdev, which has been around for a long time, has a well supported
infrastructure, the code base is well-known, etc.

For Rust, it is not, for multiple reasons. For starters, we are not
talking here about just another patch to your subsystem. This is a
whole new subsystem API, in a new language, that needs careful design.
Moreover, Rust abstractions are supposed to be "sound" (a property
that C APIs do not need).

On top of that, two subsystems are reviewing it, and on our side we
simply do not have the resources to commit to netdev review pace, as
we told you privately. I am aware of at least 3 reviewers who have not
had the time to look into the more recent versions yet, and it is
unlikely they will have time before LPC. I would really recommend they
are given the chance to give feedback.

So, if you appreciate/want/need our feedback, you will need to be a
bit more patient.

By the way, your docs say patches are triaged in less than 48 hours as
well as "Generally speaking". From that wording, I wouldn't expect
every single patch to take 48 hours to be fully reviewed (not just
triaged), and I would say the "very first Rust abstractions code" is
not a common situation.

> It is however good to let discussion reach some sort of conclusion,
> but that also requires prompt discussion.

I don't see why that would require "prompt discussion".

> And if that discussion is
> not prompt, posting a new version is a way to kick reviewers into
> action.

No, sorry, posting a new version in order to push reviewers is not the
right thing to do. The patches were not being ignored.

From your own (netdev) docs -- not even the general kernel ones:

    "Do not post a new version of the code if the discussion about the
previous version is still ongoing, unless directly instructed by a
reviewer."

    "Asking the maintainer for status updates on your patch is a good
way to ensure your patch is ignored or pushed to the bottom of the
priority list."

    "Make sure you address all the feedback in your new posting."

Cheers,
Miguel

