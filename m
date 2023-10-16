Return-Path: <netdev+bounces-41539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA137CB390
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6E91C20941
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E16234CE8;
	Mon, 16 Oct 2023 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij7Gnp0k"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0248B29425
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 19:56:38 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92056B4
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:56:37 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3668590a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697486197; x=1698090997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIUbumNBbfGRc4S/93+Nkfq8j7yrGIHi8Po2wOxRLs4=;
        b=Ij7Gnp0kLPd2TaiMt+kyJrE3OuBb4fsUdJ/GgVHRS82EXmMZ5WF1xSXWKUF0B6Gx34
         2ykfBtcPGGzTjJSX322kEpknkJDHxdMmuigIepCqr+mQupivmuyt860lMXrAAkAgKKUO
         M3YHXV7RVyIZX65O+6plDE3BdcKmIVhSpbe1NEAdyX7i6dgooQ+s/nDq7r+jET/sKtwM
         rUSeFGeaPsrfrNFv/H+0qQbeH4fDpxseBcyT7XVvEE9SBgaMmCdebn7CA6m+hGJNUiM/
         6aeq94hrWBPo998wXzixCcTlKSRhI+qHAnDfO8lFXaWgmTPooBHQfRU3OZnpiq8cpM7u
         YCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697486197; x=1698090997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIUbumNBbfGRc4S/93+Nkfq8j7yrGIHi8Po2wOxRLs4=;
        b=spEfJxH6+g3LuSINp8CqPUOesE7qjYoKVlULhKAkROa52U3GSmag/BlZPMUP4Olumn
         /qqMw2QNW63BCYb2LGOvAENUJvY2FDYoGZL3z7uBJNaSTsTHUewONvkEeCdHjqWxn9Qe
         B+XEAxIoWGYL+kh3X8KLzphYJltkZpdwJuG8qQifBvEZa37Qin3hFc93NcBqRIvrnALH
         b+ftA/FLxnWUxxbCmPakjOcgJf/G2lIkt4JFli6M03/ZwgppQKQYUWOKPOmmMz4nA90T
         QWRWM1IYenQ8i12Kg9gkP5jgRym747Yb/KzfIS3WuqlO51b5htpjAtPo5wG3kymYQuxh
         j6yA==
X-Gm-Message-State: AOJu0YzCt3NR7BEWL+BeWV0HIm3KGhaTUgStvojH7FEIS0u+cmL3AWt2
	KTv+qSaJkoCw5MErcbSiV8GKTUOG9R7ALYdttqM=
X-Google-Smtp-Source: AGHT+IHopxevhR6VjBQxQU5Oq5HwXyEj2oNSUH6w78ME2StIkZwBcY7PAiYzOylHlrje02NHl9C+UbOSpksmvvIdc9E=
X-Received: by 2002:a17:90b:1901:b0:27d:af3:f15d with SMTP id
 mp1-20020a17090b190100b0027d0af3f15dmr173823pjb.4.1697486197013; Mon, 16 Oct
 2023 12:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8e887133547cca97d583e78c79f2ee8@rjmcmahon.com>
In-Reply-To: <f8e887133547cca97d583e78c79f2ee8@rjmcmahon.com>
From: Dave Taht <dave.taht@gmail.com>
Date: Mon, 16 Oct 2023 12:56:24 -0700
Message-ID: <CAA93jw5pMqz3qm35jpkdQQQOX1pUSStR8yF+Eger=+17Eur8Dw@mail.gmail.com>
Subject: Re: Suggest use -e or --enhanced with iperf 2
To: rjmcmahon <rjmcmahon@rjmcmahon.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Bob has put in a lot of work over the past few years on improving
iperf2's capabilities. The new bounceback tests and histograms are
great! I hope more folk here upgrade to the newer versions, and pour
through the man pages for the new options.

There is more to good networking than just throughput tests.

On Mon, Oct 16, 2023 at 12:20=E2=80=AFPM rjmcmahon <rjmcmahon@rjmcmahon.com=
> wrote:
>
> Hi All,
>
> I suggest the use of enhanced reports w/iperf 2, for those using iperf 2
> version that's actively maintained (not 2.0.5.) This will provide a bit
> more information to the user including CWND & RTT samples.
>
> If the clocks are synced, then also use the --trip-times option on the
> client which will enable latency related stats. There are also
> histograms.
>
> Man page is here: https://iperf2.sourceforge.io/iperf-manpage.html
>
> Finally, there is some python code in the flows directory - though it
> may be a bit brittle.
>
> Source code is here:
> https://sourceforge.net/p/iperf2/code/ci/master/tree/
>
> Bob
>


--=20
Oct 30: https://netdevconf.info/0x17/news/the-maestro-and-the-music-bof.htm=
l
Dave T=C3=A4ht CSO, LibreQos

