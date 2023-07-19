Return-Path: <netdev+bounces-18900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F92075908E
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 10:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584981C20D37
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC2B101E4;
	Wed, 19 Jul 2023 08:45:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3CF3207
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 08:45:22 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD9A19F
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:45:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f58444a410so6868e87.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689756320; x=1692348320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODNQm7Qd7e/6+bGpKRi1Bv+uUs4PUVQ4+Hl7PdGDhgI=;
        b=Shfd+XwM+ukB58E8y/z8euPhlM+SvzoOTYSs6aINdGFcivqnZsETWBhPWCQIfabh1+
         ixRB7zSx6pOpNIowU2P30GYQm5Wwb97ikG+XbEaaNP+T6GL562JY0N0Ce5y2zR/pfkiF
         L/otFKwsLEHDB2Pp5lCN/TGKEZzQ9npdeY9DSXZeCDvG8yPk9SYtT4WC7wonBWJPQ+yd
         j0hsMO2acZ5Sm70zmtbKHynIg9QiwD7weWGFOkfrasA/3NWRGIFNYz46mM7fClKvuLlk
         mHAqFEuhCsm1JSKkH3qvy+iXVHkFjSIcAEm3sZvUpBe3ruQ/wSDjYccFvINIwTUfI/su
         v3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689756320; x=1692348320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODNQm7Qd7e/6+bGpKRi1Bv+uUs4PUVQ4+Hl7PdGDhgI=;
        b=azGJ9rZRT5+H+baBE1wvfTYFtMu+JAkWysGzYH5Mxcgu/RIGB9D3r2/i5z/IzhifAY
         f5ElEDpd2hceBpUsFro4KVfdVWi+5lUALaxlUGbms2lOlaTxvgT2o/pdgLWBigrnrUlJ
         LfmK6K6COMDbY+f7T7Y/sGDuyRVRhABPwANf/ULMMtt1BWjoYEflw8/WvL3RRlcwCREh
         i+wbpFnqemfs9q6fQSa9oXfjpoJvXoaVzoApNC5+xkKNuo5weJ0iPNJfVt0tFLzxU9lq
         /sy8XWeDHbcs524cAmapaamT3wR8lZQbZy5yTcjc3x32nAk83TGaGQBaysiYjvi2QQcL
         qzLQ==
X-Gm-Message-State: ABy/qLZw3WyR4g3DujkzeXLOLDTqbncbyufjr3N/Qx/tFNiudTY4KpUE
	86ZCqMYN5aCuTTEdWWX7bptDy0yB2c5mnZwHl4lAsQ==
X-Google-Smtp-Source: APBJJlHLnwRtT8dY4p/gFDWF0KgvHLNMG0seYCvYQfXnGLLU6blkTWYuxyClSv9V8XvEISNEZUh5P+X8OHVF+seMG/k=
X-Received: by 2002:a19:7018:0:b0:4f2:632d:4d61 with SMTP id
 h24-20020a197018000000b004f2632d4d61mr166153lfc.6.1689756319638; Wed, 19 Jul
 2023 01:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000049baa505e65e3939@google.com> <00000000000077b5650600b48ed0@google.com>
 <20230718124548.7b1d3196@kernel.org>
In-Reply-To: <20230718124548.7b1d3196@kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 19 Jul 2023 10:45:07 +0200
Message-ID: <CANp29Y6T2sKnnTGtotraCX8saAUw1kSUhS-be=3GM_t+szZ-3Q@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in hci_uart_tty_ioctl
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+c19afa60d78984711078@syzkaller.appspotmail.com>, 
	davem@davemloft.net, hdanton@sina.com, jiri@nvidia.com, 
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 9:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 17 Jul 2023 13:22:24 -0700 syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> >
> > commit d772781964415c63759572b917e21c4f7ec08d9f
> > Author: Jakub Kicinski <kuba@kernel.org>
> > Date:   Fri Jan 6 06:33:54 2023 +0000
> >
> >     devlink: bump the instance index directly when iterating
>
> Hm, don't think so. It's not the first issue where syzbot decided
> this commit was the resolution. I wonder what makes it special.

Judging by the bisection log, the commit fixed some "INFO: rcu
detected stall in" error that was also triggerable by the reproducer.
Though for me it's not clear how exactly -- at least the reproducer
does not seem to be interacting with devlink..

--=20
Aleksandr


>
> --

