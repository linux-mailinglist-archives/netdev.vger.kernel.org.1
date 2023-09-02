Return-Path: <netdev+bounces-31812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91167905A2
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 08:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36761C2081D
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 06:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EFE1FD8;
	Sat,  2 Sep 2023 06:41:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D572D1FC5
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 06:41:32 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D5B1702
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 23:41:30 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40a47e8e38dso108871cf.1
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693636889; x=1694241689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbhU7DejU+nrYIYO5cu9sl5jDevxhkijxz0vKp2NzO0=;
        b=DIsYzVzSXr+0VfcUpQGC2gHwQK91wql+01/x2NQQhceBhkvdnEv7mO09dmuyc+huaM
         MWeU4dE5jWaiAnvcCAVl/XDHiJ+fYMb6kuVPfW5Xh1/p4rs8+N6vRefeXLpztHIAff6+
         oJoMlJRVK3Z1uYQr6YZUh7uwMICl6Iiom82776JTl+g1aPUc/pGkmNDQcyX+6wpi5ZGa
         3S/Wqr3ug9NeM9KPnBSznRlsy+jD+OF3EkiSMqH4ZB+3DuwtbmwAItH6gX7zQvh7IqM8
         Cz7Eir3RX/WzXLeFIgBmHwnu23f9RycUWXAlmnoWb/QStY06VLSYjfad/3f5JNUX9ssX
         egXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693636889; x=1694241689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbhU7DejU+nrYIYO5cu9sl5jDevxhkijxz0vKp2NzO0=;
        b=ewHTR1knmlGBHtegKobkZKxCSGl9I096PB9FufuJv3MVZSbg3jsv+un7j0nO6FM1ve
         q1B4bfiBkskZHIeOp+3uHgQzbOv60Y+rcpi9QwRoKIFeb5sTrdCLB8nr0pqUa2Bd83I7
         fpCmAJ0h4MjhrBuPs6pKM1nyi3ld6wTU88nZ2Dp5VcsG49z9as28gECfZY/1pPnR6fNn
         sBokEIp9d/dRixWew6SykQnrNixUW2aj72kQStuf2jlfEdXe5C7xLBuU0iA/d8hp9/dl
         cBY3UUbJPy9/vJJ6n2EayP/99/kysSqcEEPFBowbRflE1x4+jsWcz/nAWPKfseTAtNZE
         6ETQ==
X-Gm-Message-State: AOJu0Yxrrd4WXKH/Ryhmo+w1Ip+Sw04OXJSDJJi676Gu61tu1ilrCg8z
	8NS/lSnsLzv/3cwsjK/DpfR0zhbx8FLIsHsA6ZM26w==
X-Google-Smtp-Source: AGHT+IHX7+rYsQsq97JCeNhqsLYjd0sa1xbje4+kcbiadVnoJtDZXkEdLegFZ8TM4E+kn2bafGUe+YDZXFLO73gOtpY=
X-Received: by 2002:a05:622a:347:b0:410:88dc:21b with SMTP id
 r7-20020a05622a034700b0041088dc021bmr137190qtw.26.1693636888872; Fri, 01 Sep
 2023 23:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230902002708.91816-1-kuniyu@amazon.com> <20230902002708.91816-3-kuniyu@amazon.com>
In-Reply-To: <20230902002708.91816-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 2 Sep 2023 08:41:17 +0200
Message-ID: <CANn89i+06vspuPjuJ76s1QZbTe1-JUe4coPixP6eVDv1j3xtjw@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/4] af_unix: Fix data-race around unix_tot_inflight.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>, Pavel Emelyanov <xemul@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 2, 2023 at 2:28=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> unix_tot_inflight is changed under spin_lock(unix_gc_lock), but
> unix_release_sock() reads it locklessly.
>
> Let's use READ_ONCE() for unix_tot_inflight.
>
> Note that the writer side was marked by commit 9d6d7f1cb67c ("af_unix:
> annote lockless accesses to unix_tot_inflight & gc_in_progress")
>
>
> Fixes: 9305cfa4443d ("[AF_UNIX]: Make unix_tot_inflight counter non-atomi=
c")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

