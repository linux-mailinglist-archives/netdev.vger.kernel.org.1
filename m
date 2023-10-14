Return-Path: <netdev+bounces-40980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CFA7C9472
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 14:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F64B1C20A78
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 12:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E711094B;
	Sat, 14 Oct 2023 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHx5kQpu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7362811CA5;
	Sat, 14 Oct 2023 12:00:25 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05460C9;
	Sat, 14 Oct 2023 05:00:23 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7b92cd0ccso37215707b3.1;
        Sat, 14 Oct 2023 05:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697284822; x=1697889622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PmC5R9RoA6q/DVLNOvUSR2MbcKzh5eKTdtmaYPsehw=;
        b=gHx5kQpuJO8rfVKAznrH2f3qjqpw7BVEWzrWyaC6ekbbl50w80JJVVXKbqS9yKugHB
         8OFT7v4c2E9VcXIi2eZ7QQsuL4E+QfD7hXWpvKFlaaKQHSSuUSBnsYu1PiSi0sLQg1m+
         QSzuDWsp6EYPGqKmXieHjtD/XpSjYidbJBdvHX6sJOGIjFif/oCdCjg7udOB3eo+laZE
         QSSQp5OkTYPnVBXTAGq0Z2DMF1kgJZlvrld9gYd+uojkLapTkA9WIlT2iYksN2UxkRDD
         7nrm5F1whyq8xNcy/2Zn+t1GNtqrpPXrod3wNAxQllyrKQUW3wxDcuSOPC5g0RxnF2bB
         K1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697284822; x=1697889622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PmC5R9RoA6q/DVLNOvUSR2MbcKzh5eKTdtmaYPsehw=;
        b=UzE4/l7PsHfR/OX6DV8fyzJkjlogJRB/JNRWDJj2xJJPkQhnEYRgzYJa0HWtCixcvG
         rUOK9KRrQwMGtT+AOP0xBuElW7OsntdkiHj1svgBd9CaYrHnjnOmFLUcloy2aFtKhKP6
         J77+sqXmzI8fTWTFfRJuwo2TzN4rLkgdKjOe3eK57GiX9Em4vkvIp+fQ+XFYH+dqN060
         GHv8FlWDraIeelzccOZdLsHisJNDcKa0I+LI1CHaMo/lLiqxHmO+gsFYeojTtvfqb03M
         tTHvbncxUFpOPHHEAANqOX45mNUrUDy4r2UOMGHDaRvk7tOWjwdl6jmJ2jISaIKMSH3r
         5pSg==
X-Gm-Message-State: AOJu0Yz67+Od2i8W3Gd3ilQgSurgT+s991mq8S1WWKNJUw+FBbGt694s
	H7+TfwMlvsRDmGidnxQrg4nRTNzpCZsrs5qq+X5oAHXoqbyQfw==
X-Google-Smtp-Source: AGHT+IG5GAZXAzIL9988hhr4XYXvzD9PRMgMLduyYmzCT6d0Z14pjEj/tgHUccmKOy0/V5G2Pz0AO8mTCQV8L+Y5ekI=
X-Received: by 2002:a25:9182:0:b0:d9a:c304:bb78 with SMTP id
 w2-20020a259182000000b00d9ac304bb78mr6551375ybl.12.1697284821228; Sat, 14 Oct
 2023 05:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
 <20231012125349.2702474-2-fujita.tomonori@gmail.com> <85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me>
 <20231014.162210.522439670437191285.fujita.tomonori@gmail.com>
In-Reply-To: <20231014.162210.522439670437191285.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 14 Oct 2023 14:00:10 +0200
Message-ID: <CANiq72kT=wWDO-tb9z3N962g3Zi2v=_jwhE9YC4ZwteAOyYfCw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: benno.lossin@proton.me, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, 
	boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 9:22=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> The same quesiton, 4th time?

Perhaps you should then be documenting this better in the code?

> Boqun asked me to drop mut on v3 review and then you ask why on v4?
> Trying to find a way to discourage developpers to write Rust
> abstractions? :)
>
> I would recommend the Rust reviewers to make sure that such would
> not happen. I really appreciate comments but inconsistent reviewing is
> painful.

Different people will give you different feedback. That feedback may
be inconsistent or may pull you in different directions, which is
typically a sign that things are not clear for at least somebody. Some
feedback may be simply wrong, too. It is what it is, even if we try
our best to be consistent.

It is especially interesting that you are the one saying this, because
you were the one that wanted to go quickly to the mailing list,
including the netdev one. That is perfectly fine, but the result is
that people may not be on the same page and it will take time to
converge, especially for something new. So I am not sure what you are
complaining about.

Now, something more serious is happening here, which is you implying
that reviewers are intentionally trying to discourage you. That is
simply not acceptable.

Cheers,
Miguel

