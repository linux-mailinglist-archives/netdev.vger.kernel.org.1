Return-Path: <netdev+bounces-33366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0806E79D956
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 21:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3F51C20ECB
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF83DA945;
	Tue, 12 Sep 2023 19:09:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5762A951
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 19:09:48 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB3AE6;
	Tue, 12 Sep 2023 12:09:47 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcda0aaf47so1782691fa.1;
        Tue, 12 Sep 2023 12:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694545786; x=1695150586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2QKmtHWodHEWcW+VP4XGZgYZ6yzX48HwXCnApPwIfs=;
        b=POBF48oba/3lNU2t5Gv5zQWVSuvzveI9UMVv2w9Fr7YtDrb+Uby9Sp/sxIeFr33O/l
         5Rdk2sG+Dlwwp/Lpl0HJWD1eADLN1479V+GUWncBqfGpy7IuSPSI7no9CT/MIZNN9u4K
         qibG0qGlHVdB177TpmWecO8vlN3oCZrD5ILbL/xxlRqYNbz8bw52iySAvYCtXFPCaIMn
         hMCU9MgmOIo647oHl4YOYPuuNS2HLqbJ8fTFn24+NGKLOE3PlRMXn6AL6Boigy/gk6IG
         MqthsyJ1gx1juV9JwV2aV2lTn05p9E+UjVR2UyOfUEwHu6+Unx6SCUkmy73NP0cnhs88
         yRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694545786; x=1695150586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2QKmtHWodHEWcW+VP4XGZgYZ6yzX48HwXCnApPwIfs=;
        b=EniLcUvS69AIWwPk1woRZs57UoBb9sZxlaY0mgvCvdoGQUXz0ySIrVaL6Ij1iRXGxQ
         EHOD2VZwq2GgBjSxHMvIuU7+1jxAnmP456dp07pUX0A1OvLXIF9isYbH8LXuPHLQCOLY
         5t7XD+kWJkVEIV+q6z1BCFvblE/xxzbMoVJH/PYqRMToAXv4f9VXjlxlpHPeqw3n4bxB
         EEChbHDQjyhMdFo2ADL2DVe4LPYrJZN3b8H+eNo/xobVJtAwrO1vaH6OYJ9oGNRxb2BX
         XOxtqeFEcai93Fb+08vZfm/6qmI2JiIZ485xzX+4LwPh4A2kXXy/8USo64yugs+IMxZE
         tzVA==
X-Gm-Message-State: AOJu0Yw88sYYYtBPX67hd/wMf2hpN3NpZF8BKYtwYzSIWCVslSqRbm1A
	JKIVI6hKjCbMmhizlEIw1kQvteSF8x5qDBbne9s=
X-Google-Smtp-Source: AGHT+IEOIrNMeNQxPXExf3y0619mpuQ7YipVHakWGYM49/XckJiyVbA5KsHtuC0A5TCAtMojnvXN2l2a7UWmHU64ZNQ=
X-Received: by 2002:a2e:aa22:0:b0:2bc:d993:5a58 with SMTP id
 bf34-20020a2eaa22000000b002bcd9935a58mr1317419ljb.17.1694545785763; Tue, 12
 Sep 2023 12:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230829205936.766544-1-luiz.dentz@gmail.com> <169343402479.21564.11565149320234658166.git-patchwork-notify@kernel.org>
 <de698d06-9784-43ed-9437-61d6edf9672b@leemhuis.info>
In-Reply-To: <de698d06-9784-43ed-9437-61d6edf9672b@leemhuis.info>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 12 Sep 2023 12:09:33 -0700
Message-ID: <CABBYNZK2PPkLra8Au-fdN2nG2YLkfFRmPtEPQL0suLzBv=HHcA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: patchwork-bot+bluetooth@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev <netdev@vger.kernel.org>, Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 11, 2023 at 6:40=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 31.08.23 00:20, patchwork-bot+bluetooth@kernel.org wrote:
> >
> > This patch was applied to bluetooth/bluetooth-next.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >
> > On Tue, 29 Aug 2023 13:59:36 -0700 you wrote:
> >> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>
> >> When HCI_QUIRK_STRICT_DUPLICATE_FILTER is set LE scanning requires
> >> periodic restarts of the scanning procedure as the controller would
> >> consider device previously found as duplicated despite of RSSI changes=
,
> >> but in order to set the scan timeout properly set le_scan_restart need=
s
> >> to be synchronous so it shall not use hci_cmd_sync_queue which defers
> >> the command processing to cmd_sync_work.
> >>
> >> [...]
> >
> > Here is the summary with links:
> >   - Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FIL=
TER
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/52bf4fd43f75
>
> That is (maybe among others?) a fix for a regression from 6.1, so why
> was this merged into a "for-next" branch instead of a branch that
> targets the current cycle?

We were late for including it to 6.5, that said the regression was
introduced in 6.4, but I could probably have it marked for stable just
to make sure it would get backported to affected versions.

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> [1] see
> https://lore.kernel.org/linux-bluetooth/b0b672069ee6a9e43fed1a07406c6dd3@=
agner.ch/



--=20
Luiz Augusto von Dentz

