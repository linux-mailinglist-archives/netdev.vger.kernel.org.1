Return-Path: <netdev+bounces-15466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ACD747C2F
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 06:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0357280FEC
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 04:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096DCA29;
	Wed,  5 Jul 2023 04:51:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CEFA28
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 04:50:59 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8141700
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 21:50:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f58444a410so10180e87.0
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 21:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688532656; x=1691124656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lxTrp4xR0GEZ2m0ffNqJXAGvcGUnJBy+897m6qMHQMI=;
        b=5G49xGGChpfhvHhjHsAhcGMXx3gN2toKg2P9J7G1v8neSVgSuSp95j5wQUTGR6J3iZ
         QKOopdrdwzh9o5FlAJhncPCLpK8ElOtJYtGBGTeRLy91c+fjxgjWx74vpI4dOjt7aJOV
         o0Zc1r7Qai19MkBa2U84X89tQRcaZS4cGq2d+FucufUhtXnWPbi0N16B7SXWXoqmuFfH
         5NAvp2QbpsC6/a1pi/S+4jjEnz9bgmPOaqFrf3l/2Hr3ju0IEYmJu0yv8odyvk8jxBeg
         ZKNV+6vtFmaPdcrWEoYdxIEz2dVqjT7QaIvZ64B8u2ZvsAIWe7+XBvGWkr4YulJsHq4E
         DzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688532656; x=1691124656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxTrp4xR0GEZ2m0ffNqJXAGvcGUnJBy+897m6qMHQMI=;
        b=R8aLzV1kLDoXmsTl082Wp//7wF4KB7/Z6IwKyLf56KxsWEJD18n4lraKcNtUVLYI0u
         C84GAmAp4vOt9MWSa2tK2KXzS4Je89ng9y2wWlXavw/Ve71bEjUdCbMxKq5XaXhKGF+M
         QAN1UDNLglDdYeEljWP0YjBXpGDBcfUKbJQ/6qNu4+ge0eB+sFh3xazCgqlkdy6kblgS
         lSKXxnfrX+zrG5D7rhM/14xRDRJ7pJRtS8d0a6yy44lhtSy9Em+RNFj0olA5+rRvNSTj
         6YalLdLsXiZZGF6OJcu+VIM34xHRUAWZ8lYbs6AHoKXKThc2jqsw9A0SZlXtVgiTs6/G
         QGtQ==
X-Gm-Message-State: ABy/qLbF2F0YSJKe2NwMse/mzsgYKUlOCV6HP0Gpoxme7bkXKl3taG+N
	549xpaZ3GjL4BBkD7u2Ru6Rhzcx5I1IAf9sBrE30Ow==
X-Google-Smtp-Source: APBJJlFM/Ill4yNai9aIXJ/3LGtP7Q7TzpQDhcEAWG10KmSwLRArGtPx2RMeFKsM0ujWw1PVRqzjM9Tyi78qnDGgneY=
X-Received: by 2002:ac2:5dc2:0:b0:4f7:5f7d:2f95 with SMTP id
 x2-20020ac25dc2000000b004f75f7d2f95mr7685lfq.1.1688532656470; Tue, 04 Jul
 2023 21:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <F17EC83C-9D70-463A-9C46-FBCC53A1F13C.ref@yahoo.com>
 <F17EC83C-9D70-463A-9C46-FBCC53A1F13C@yahoo.com> <20230705043955.GE15522@pengutronix.de>
In-Reply-To: <20230705043955.GE15522@pengutronix.de>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 5 Jul 2023 06:50:43 +0200
Message-ID: <CACT4Y+bGjJjmMNMQZEZFTh8UnyXNYSTy97SxtuKaJ96XkALkWw@mail.gmail.com>
Subject: Re: [PATCH] can: j1939: prevent deadlock by changing j1939_socks_lock
 to rwlock
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Astra Joan <astrajoan@yahoo.com>, davem@davemloft.net, edumazet@google.com, 
	ivan.orlov0322@gmail.com, kernel@pengutronix.de, kuba@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, robin@protonic.nl, skhan@linuxfoundation.org, 
	socketcan@hartkopp.net, syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 5 Jul 2023 at 06:40, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> On Tue, Jul 04, 2023 at 10:55:47AM -0700, Astra Joan wrote:
> > Hi Oleksij,
> >
> > Thank you for providing help with the bug fix! The patch was created
> > when I was working on another bug:
> >
> > https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> >
> > But the patch was not a direct fix of the problem reported in the
> > unregister_netdevice function call. Instead, it suppresses potential
> > deadlock information to guarantee the real bug would show up. Since I
> > have verified that the patch resolved a deadlock situation involving
> > the exact same locks, I'm pretty confident it would be a proper fix for
> > the current bug in this thread.
> >
> > I'm not sure, though, about how I could instruct Syzbot to create a
> > reproducer to properly test this patch. Could you or anyone here help
> > me find the next step? Thank you so much!
>
> Sorry, I'm not syzbot expert. I hope someone else can help here.

+syzkaller mailing list

Hi Astra,

You mean you have a reproducer and you want syzbot to run it with your patch?
No such feature exists at the moment.

Presumably you already run it locally, so I am not sure syzbot can add
much value here.

