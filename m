Return-Path: <netdev+bounces-38710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5657BC2FD
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 01:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04401C20A90
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305FE4734F;
	Fri,  6 Oct 2023 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="HT6hfT0U"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D833545F7C
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:37:28 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506FFBE
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 16:37:27 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59f55c276c3so32741117b3.2
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 16:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696635446; x=1697240246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnNECXNUu4GUPsDV49wIsglUJEpwf338rXw2kCJfHbI=;
        b=HT6hfT0UsuHCle8JyqYPMje/lG9jAArD4P0I8c+IZC/b2uFXP/GcZ1yQ1PxRqT171o
         T3swMBpLjOY4mqfyaZiekTVYkZfb/pzSPLi+74coUT5bDJPaC2bi6fPKMqhpYfZTztCQ
         A6DalmfJ2k6cZMag/Jk6YLE/XLa4+9jSSWSxLa9LtxnN4OzoLfsyzg+nn3+2ZOV/w/Xf
         N0bczYQfQrpEGXW/5E3sf2KNcKOhDD8YaL/JLRvwshWxe1vuLVm6WAvhFuiFxNgzVVOb
         nX9+LWN8m+HgFQ7x/7EsxT5MPZXVn2dHcN0nvleOf/OYUAeuCLbszHlgoPyX7O6bdRl4
         Iw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696635446; x=1697240246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnNECXNUu4GUPsDV49wIsglUJEpwf338rXw2kCJfHbI=;
        b=H8uFr0ZlxyYdXAz43BI7hnSkzzPaXt9yHAlO6VnTMp3303qdMxCgO71k8NVWpvNqeZ
         2iG0Z0ugodEokGLfQFkPXydaZewnmEOXltvk9veI1QLXAMcqAOn75VO7MVtavY6iG9qr
         pqbCSqhV2WvWDyACvNcMs1MqI2VcclT7ppRG7WtcGGbKxdiQ/G+OhuRhMbKT7Iw7xUk8
         j0ItRRyUcoAgpaCqWUnqCC+IWfniBUH5ueto/0bGQs9M5LBGxsLHl5WGruxfzS+2FSDT
         QhAPgWmLnqb6iWIMYBMIuipPEvTOFGl6AerQEYvQlnBIoQ/t4yVbk0H8V7PJbpjOHvWJ
         tU6A==
X-Gm-Message-State: AOJu0YzK1jVm6o0VmIkUBovM6hnDd+WxSW35JLlSRJGM6cYStfYmZi+4
	8C3GMRUN2GFTcYfAGrYjlPFllhyv7ddbXRm5LHZnAw==
X-Google-Smtp-Source: AGHT+IEQ+m2hySCv8Rd/ab0Chl+30RvRvLxaKpLilGDdNuEScWQ/IIywZbSRjH1kGmdxWbFOf6BxN4uuiXSx4dRTevc=
X-Received: by 2002:a0d:d606:0:b0:586:b686:8234 with SMTP id
 y6-20020a0dd606000000b00586b6868234mr10748355ywd.8.1696635446532; Fri, 06 Oct
 2023 16:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
 <6aac66e0-9cbd-4a7b-91e6-ea429dbe6831@lunn.ch> <20231006.230936.1469709863025123979.fujita.tomonori@gmail.com>
 <40859cee-2ee7-4065-82d0-3841e5d7838f@lunn.ch>
In-Reply-To: <40859cee-2ee7-4065-82d0-3841e5d7838f@lunn.ch>
From: Trevor Gross <tmgross@umich.edu>
Date: Fri, 6 Oct 2023 19:37:15 -0400
Message-ID: <CALNs47ukgFCs631v7wiaMTH0wtW6y4AcHcZ7uOaAS505vOEnzQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Rust abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, miguel.ojeda.sandonis@gmail.com, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 10:47=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> > So I think that merging the patchset through a single tree is easier;
> > netdev or rust.
> >
> > Miguel, how do you prefer to merge the patchset?
>
> What are the merge conflicts looking like? What has happened in the
> past? [...]

Miguel has said before that if subsystems are comfortable bringing
rust through their trees then they are welcome to do so, which helps
get a better idea of how everything works together. If you prefer not
to, it can come through rust-next with no problem.

There are no serious conflicts on the rust side since there is no net
module yet. I think that most new things will need to touch lib.rs and
the binding helper just to register themselves, but those are trivial
(e.g. same for wq updates coming [1]).

> Or is this the first driver to actually get this far towards
> being merged?
>
>       Andrew

I think that answer is yes :) at least for an actual leaf driver.
Hence some of the build system rough edges.

[1]: https://lore.kernel.org/rust-for-linux/20230828104807.1581592-1-alicer=
yhl@google.com/

