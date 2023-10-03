Return-Path: <netdev+bounces-37547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2705A7B5E39
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 02:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8479628164D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 00:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6545362;
	Tue,  3 Oct 2023 00:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68771632
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 00:30:28 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D64AA9
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 17:30:27 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-65d066995aeso2335066d6.2
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 17:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696293026; x=1696897826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm95BT66K1A2Zf/YgTxpWCUle5PuInPRhEHdoEUKoQE=;
        b=F3SOZI5Affm7XwvYCNy1kYbY2urL72mIe19Vo+2y0mYD9/U5GK+mcgSSCcZ/frjKRK
         4NigmqhHFASsvkPbf9Wr3pdyJzr6uM3cyvZRdu91Z1GrqVKW34A84djwqe6vLE2E9pmd
         Co00+HztcfTv6rBDwoQVlUWALKZLpLytnNulhsbLXQtYfi2Fm6zbdoBJ3+YINB8wLVVf
         IQl5QhFXq7VvNWYQgZkxXh/+9Oncga4EMQ+4ApkM9Sa4he5mtsmqfX5TDqF0niPydF7o
         hSeYBwUe8d51xmX7AkhhJWeoZCpfr3XoQDgZpgoRf8o9/uBDIlHOI0BPKW8qERrirvqq
         M/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696293026; x=1696897826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gm95BT66K1A2Zf/YgTxpWCUle5PuInPRhEHdoEUKoQE=;
        b=C/lQyQYY2HaL/hISo4/cvy2ujBh7P5Mu2+A5qn6VCcthJOZn5wSwERZkW3PFDNuLS3
         cOmzye16lNIftU5YbY6b3uZTYU1xe3S6hCt0O7MCbfWhAHeisucZ6bEevnbQ3UhhXy97
         9XaNTLflAws87eESMBy1YnS5HBH6rYJmH1GCRIqLYZZFlpYTyEOPGf284QbidEcNePS5
         5ICAzn/IbT7iod+/3rI9O1us1Ze/iRB5su0j49rzYwYm6GMM65kc3/69W8yI++mPWwkQ
         0aFn3LO0CEo2oYJOXGgxAt6sQAxEH3lqB+N+wRq+K+o/plRW7XRj0Dc71Mlr2kRvCDhv
         qkHQ==
X-Gm-Message-State: AOJu0YyQ3ykSdzTKbXqVgrJodjV+zGfyohQwF4ql6Ed0wWIn3OxlICnV
	7poSk7PsmkQ6ZKK4x5uMtyJKj58hJkLq0a/+30lscg==
X-Google-Smtp-Source: AGHT+IEpb7Cfo0yp4UqChQuah8UnSbiBBCbiC5lnkF9DzW3+QZ+WfjSNxRJF6F4+aUbfmcOC/wgFcIB74fjZr1vko4s=
X-Received: by 2002:a0c:e383:0:b0:65d:4840:6eb4 with SMTP id
 a3-20020a0ce383000000b0065d48406eb4mr13854778qvl.6.1696293026067; Mon, 02 Oct
 2023 17:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929023743.1611460-1-maheshb@google.com> <ZRiSQ/fCa3pYZnXJ@hoboy.vegasvil.org>
In-Reply-To: <ZRiSQ/fCa3pYZnXJ@hoboy.vegasvil.org>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Mon, 2 Oct 2023 17:29:58 -0700
Message-ID: <CAF2d9jgWpwNye89qrANfngG2+NQPDhpZQjXMKBDG6x7e32_cOw@mail.gmail.com>
Subject: Re: [PATCH 3/4] ptp: add ioctl interface for ptp_gettimex64any()
To: Richard Cochran <richardcochran@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 30, 2023 at 2:25=E2=80=AFPM Richard Cochran
<richardcochran@gmail.com> wrote:
>
> On Thu, Sep 28, 2023 at 07:37:43PM -0700, Mahesh Bandewar wrote:
> > add an ioctl op PTP_SYS_OFFSET_ANY2 to support ptp_gettimex64any() meth=
od
>
> This is a useful idea.
>
> But how about a new system call instead?
>
>     clock_compare(clockid_t a, clockid_t b);
>
The purpose of this API is not to compare clocks but to get the width
of reading the MTS value (offered by NICs) in terms of the timebase
that is selected to essentially improve the accuracy.

> It would accept any two clock IDs.
>
> I've been wanting this for a long time, but never found time to
> implement it.
>
> Thanks,
> Richard

