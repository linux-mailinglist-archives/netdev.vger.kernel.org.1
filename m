Return-Path: <netdev+bounces-18271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2CC7562C9
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F291C1C20981
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1546A923;
	Mon, 17 Jul 2023 12:32:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6673883A
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:32:20 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4DCB5
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 05:32:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565a33c35b1so42424747b3.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689597139; x=1692189139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZSx1KFOZHhK5rBz5q5WI44760CDuuL645BIBMYOSus=;
        b=Cx7gZnSCWUuLzsQIC695ZQ31J+qffQKaUSIIA/Ta6q2pIbK9wHaQMinbKBAqcaPI+c
         FENA1Rws5+HoQ/f8Za7vqnk/1vpLRIwGeDm2IpTde6FpM5apb66SFjzftmuh3lBzysVB
         8Rx+sfR+kg70aBZLBtfbQyoMhxHqzsy6NL4AF4uGYPQZKQDRhIdzCLOXWxunvZpsykyw
         ChY+aR8BlLr28BJFbjEvhVRlT7QpDGGaw34QmfhDl3oDdkmCpkaQd6wIZrWkof5ZzeZH
         XQ70Xa6j5IpUQW/3u95HOFOzluZk6GryzL2weec0APRvqBWF0c//NTRaUr4mdp9No1YG
         D4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689597139; x=1692189139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZSx1KFOZHhK5rBz5q5WI44760CDuuL645BIBMYOSus=;
        b=KAMLJsfxEWAYjwDEIPXBevDj8AtB5GTqdEGOPOLlgu4I+X8nbDIw97JlvC2pgua3WG
         pC5CYQllKTpHiyXbT5HevRSrURtyLT6xGbpWM2p/supN04kZMQjB/hgS3uY7r8Us8wjo
         YU5zmOfF4SrBPI5irSeXuY2SFmO+TUOv7bMPhi/HhSCsh+4ShaR9fdXMBqri842nwGNO
         nFGuAt/7Qm694NbXIGnUBTPzCU2DwzwARI/Jimpr2psk/WcT4VP0IrEVIK/BWq6CG+aC
         JukHk5hpCMIP6mQTvYWME0ysdPf2qyBgFkYHYeKIpDxLIPugOn2NoMFPLlMw2MO6T5G2
         Ua+Q==
X-Gm-Message-State: ABy/qLbSZsiKGm2TCblgqRvz11AeUBrO1dqWPf4XZajXEvCneEk6E6jE
	Ufvaw3t1hL8hHdzkGRS3NdQtJkrVZhc=
X-Google-Smtp-Source: APBJJlF8OuoRwqn3kvulYRYYr8yYr3IHhx9y5lKLEb/tJcb9M9a3xeosZq0kD6pK3XLaQy68f7yAviaOgn0=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:d0c3:d89e:d01:e399])
 (user=nogikh job=sendgmr) by 2002:a81:8b41:0:b0:579:fa4c:1f23 with SMTP id
 e1-20020a818b41000000b00579fa4c1f23mr163675ywk.10.1689597138664; Mon, 17 Jul
 2023 05:32:18 -0700 (PDT)
Date: Mon, 17 Jul 2023 14:32:15 +0200
In-Reply-To: <000000000000dd5c040600366c6f@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <000000000000dd5c040600366c6f@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717123215.3627471-1-nogikh@google.com>
Subject: Re: Re: [syzbot] KASAN: use-after-free Write in j1939_sock_pending_del
From: Aleksandr Nogikh <nogikh@google.com>
To: syzbot+07bb74aeafc88ba7d5b4@syzkaller.appspotmail.com
Cc: bst@pengutronix.de, dania@coconnect-ltd.com, davem@davemloft.net, 
	dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@rempel-privat.de, lkp@intel.com, maxime.jayat@mobile-devices.fr, 
	mkl@pengutronix.de, netdev@vger.kernel.org, nogikh@google.com, 
	o.rempel@pengutronix.de, robin@protonic.nl, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> This bug is marked as fixed by commit:
> can: j1939: socket: rework socket locking for

> But I can't find it in the tested trees[1] for more than 90 days.

#syz fix: can: j1939: socket: rework socket locking for j1939_sk_release() and j1939_sk_sendmsg()



