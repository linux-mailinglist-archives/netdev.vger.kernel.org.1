Return-Path: <netdev+bounces-14267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C817473FD43
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 15:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C36C281065
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823A3182D5;
	Tue, 27 Jun 2023 13:55:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C2182CC
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 13:55:25 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143341FCD
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 06:55:24 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4007b5bafceso229261cf.1
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687874123; x=1690466123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGOH63jgnVEs2f+80uEeHRGpcn2owuUaHFI+XI/Lwro=;
        b=4jpRsGb+eEeMvdz049rnzuwxgDroNMoFwnA24xUhw8wYNtRIr6lxsWdA/P/rFb0HkR
         lDMop5UXZhkkHrT2PhbP0SKfe09XFulHDdDX7kkilQf397tCis5Gm4Ywd+bYh4ZmbyFe
         jrMCqd+JLCEHFz9pIpK7fUCljELdHdGRI74Ie6SO3a44srbGtPWzvAA5qD8MLuuVvuYO
         4Ak7S0APJbZNLpYXYwifpTCaM6htT0oZSZ1YSeh1TbD0iUMTTAEb+1vvq3HGMEXyOz5r
         wcFAhd+BLPd3Cvh8SBMl56DYXOoNFsknCSE53CCdmANx6sZcdJkXuUe1gJC3leihqpqG
         ao6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687874123; x=1690466123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGOH63jgnVEs2f+80uEeHRGpcn2owuUaHFI+XI/Lwro=;
        b=Q07aHUKTXCKpApPRLGwDLa3IOjH8fa6BYw8/B56zpUnGMzSw7TYymtTvMcGvgyF5e4
         vyo7Iul3Z5dfC+7SjlNVArVBDGe3lIs95EiY7Msd16az6sK81NWDcTTq15nhriCKmcyY
         LW1kqrSFnLb3Az29zbNoK21yh/uA56o3cYeJo75Z1g13ceYtyzFFiTMPpLq/4rYbY+uD
         7Q+34y8NdyAMMT+rWL7HejU6aWcKMFPGMlqHdMDhWF1gz+orOWa2ZOgwv5giMbuOcpRV
         6O4JjvaHg9mILuDHIG4joYxUz1QlJFgleWYmS7tmE87s4TcZcCJtgMVcUA/mkh5Wl6BJ
         Iv1g==
X-Gm-Message-State: AC+VfDwD1TdI5YyH4djnqvXtflt3be1F9VhD3NvoYDfHOwJmHP/+o8aV
	vth0E1S6floT1NR6OgaivWUQFKFxFE6fO7CZRWYZCg==
X-Google-Smtp-Source: ACHHUZ5GPkxVhmJt7C7Zmwoh0e7IvTuPuxE1QBH9E9t9bnIcJaaMSg5SFknMlx4nZK8GGimQ2eJFlpxzPfLF6K79RdI=
X-Received: by 2002:ac8:5708:0:b0:3f3:75c2:7466 with SMTP id
 8-20020ac85708000000b003f375c27466mr182910qtw.8.1687874122873; Tue, 27 Jun
 2023 06:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627105209.15163-1-dg573847474@gmail.com>
In-Reply-To: <20230627105209.15163-1-dg573847474@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Jun 2023 15:55:11 +0200
Message-ID: <CANn89iJRaT1B=HwWDsEdcAUZzYERzeR8iwGYHZuLcy+G4G39Lw@mail.gmail.com>
Subject: Re: [PATCH] net/802/garp: fix potential deadlock on &app->lock
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 12:52=E2=80=AFPM Chengfeng Ye <dg573847474@gmail.co=
m> wrote:
>
> As &app->lock is also acquired by the timer garp_join_timer() which
> which executes under soft-irq context, code executing under process
> context should disable irq before acquiring the lock, otherwise
> deadlock could happen if the process context hold the lock then
> preempt by the interruption.
>
> garp_pdu_rcv() is one such function that acquires &app->lock, but I
> am not sure whether it is called with irq disable outside thus the
> patch could be false.
>
> Possible deadlock scenario:
> garp_pdu_rcv()
>     -> spin_lock(&app->lock)
>         <timer interrupt>

This can not happen.

RX handlers are called from BH context, and rcu_read_lock()

See net/core/dev.c,  deliver_skb() and netif_receive_skb()


>         -> garp_join_timer()
>         -> spin_lock(&app->lock)
>
> This flaw was found using an experimental static analysis tool we are
> developing for irq-related deadlock.
>
> The tentative patch fix the potential deadlock by spin_lock_irqsave(),
> or it should be fixed with spin_lock_bh() if it is a real bug? I am
> not very sure.

I guess more work is needed at your side :)

