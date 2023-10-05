Return-Path: <netdev+bounces-38447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D439F7BAF4E
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 01:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 83E41281FF0
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 23:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DDF43AAD;
	Thu,  5 Oct 2023 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uifcnlli"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E3042C1F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 23:23:56 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ABE1AE
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:23:54 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-65af8d30b33so12715736d6.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 16:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696548234; x=1697153034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPy1KIj47wf2+7ji7ueJsN5688cGu/wo+yyPOcjYdVI=;
        b=Uifcnlli7dwwFZRMuv9KAJBcPKW8lgTmflGiyiyAM3nLZbwHJcW2QrWOxfAp/Ix60B
         H2BOv3Q7nnXDdiiEdQHUSJm+9dXtSkvhUWprHuYigDKCnk/1XrdV+DHF0+spG9ApWhTX
         AAKQ5pdVV3D6veV06fkIKSu+N5bfB5rYsT4t2wpaO49dZs91obca84Ser5W8hESYCAzK
         7FmRUWWRB996if9dL0KMDEbTwYggaCHTRKfXLNDSl/shdzKuG1iA4Io318yw9sC0xgCR
         xU2mhh80e2M/tXf2v0uhgBi4DWoDKsibAmZ/+8I0A/dDo0zg/9ZEu+KOR5o3iwAw3tcO
         w3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696548234; x=1697153034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPy1KIj47wf2+7ji7ueJsN5688cGu/wo+yyPOcjYdVI=;
        b=SxUscipQJTIAvbZl6J23DP68eaN62SOSBGVvnOokpbttpm+0AXf1rCkj/ClsGIYTcH
         8i4AiIraMoj+5LOBR+2jTHosXg4L9eCSQiU5aziEgcyoww+Q1NI9BLl+ICZKd0z80hV+
         f0iumc+QX9PX+UP0B3IzR7QwCoLRx07jXZyoQVWiCtYtVxGM1ozhkgnOtQ7prmrlu7AW
         NTsg1wl3r1QkBFq8zEP2sxn2Zq5qzNvvevi3sUcCYwab4WAG+AHQgBcFhDImEC21ZH2a
         D9KTqGSrZJoHLf0WXnwjEuL2Uy1sMj3Oi9Raq9TW3IvB+t4O5GN6q8OFdEveor0GNTIg
         RsPw==
X-Gm-Message-State: AOJu0Yye12Ul37BffFgUrMt1AxgEZ76ZTkLBd2BA008YORDh2F4rT0P/
	11U7Y/GqmSk2x8dgF2pn7fdoQ9stfKMPq1r3H3XUzA==
X-Google-Smtp-Source: AGHT+IHs3h4fp5OSVp1J9NSDTyrp2yMMSLYrfQzWcGVBx/vR+8jrWyqSGXlSYgYjT43Y+/dHWUhqKcgNjOTM8zUxAEA=
X-Received: by 2002:a05:6214:d06:b0:63f:9130:4e9c with SMTP id
 6-20020a0562140d0600b0063f91304e9cmr3493143qvh.26.1696548233746; Thu, 05 Oct
 2023 16:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003041701.1745953-1-maheshb@google.com> <ZRzsWOODyFYIxXhn@hoboy.vegasvil.org>
In-Reply-To: <ZRzsWOODyFYIxXhn@hoboy.vegasvil.org>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Thu, 5 Oct 2023 16:23:27 -0700
Message-ID: <CAF2d9jh46s=ai1Ykgk3Lsg8Nb6qRNY6bWPV3fVCTC_S95csyag@mail.gmail.com>
Subject: Re: [PATCHv2 next 1/3] ptp: add ptp_gettimex64any() support
To: Richard Cochran <richardcochran@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Don Hatchett <hatch@google.com>, 
	Yuliang Li <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 9:38=E2=80=AFPM Richard Cochran <richardcochran@gmai=
l.com> wrote:
>
> On Mon, Oct 02, 2023 at 09:17:01PM -0700, Mahesh Bandewar wrote:
> > add support for TS sandwich of the user preferred timebase. The options
> > supported are PTP_TS_REAL (CLOCK_REALTIME), PTP_TS_MONO (CLOCK_MONOTONI=
C),
> > and PTP_TS_RAW (CLOCK_MONOTONIC_RAW)
> >
> > Option of PTP_TS_REAL is equivalent of using ptp_gettimex64().
>
> This change log is horrible.
>
> Please write a proper explanation, and be sure to cover the following
> three points.
>
> 1. context
> 2. problem
> 3. solution
>
> Every change log must have those three items.
>
> In addition, this series needs a cover letter that clearly justifies
> the need for this change.
>
Fair point and the series does have a cover letter  which you can
access it at https://lore.kernel.org/lkml/20231003041657.1745487-1-maheshb@=
google.com/
Probably it's fault of my mailer-script which finds the reviewers for
individual patches by running scripts/get_maintainer.pl but then
coverletter is just sent to the mailing-list


> Thanks,
> Richard
>

