Return-Path: <netdev+bounces-18426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CD9756E1C
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 22:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B02C1C20B99
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 20:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06355C2D7;
	Mon, 17 Jul 2023 20:22:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1EFC14C
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 20:22:26 +0000 (UTC)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBDC1B0
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 13:22:25 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1ba6eca72e0so3260426fac.3
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 13:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689625344; x=1692217344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGrQ+szKoMK+EaVan75CnITnplIPv8vValzWkyBMelk=;
        b=I0DE6w71osjeaYUgP7DJ0j50Dqox+iLJ7p139GGYAYqB2+CastQqSwQ7Dthh3J1Vs7
         n1yEGKK9sT2OInLF6KdLq0shSf8M8SwX4juZrcfsiiy73m8xKN0mWmKwMuVgGV4bS7tz
         OegaYFbPP5poXjAieGtTa6jAlVHMfw9+0SVmheuS1Dln59yYQcuVbxJNEnOj6Mm/3r6Y
         jo1ksp7SJJXtPySEai9eQr4wPkTbwSLz77d+bZy2qPM0jISd43T7oFnxzNDIrBo6syPW
         rrURqOVua4zh60LNP18fe/ILtJbOv6vmt7dQnuEExxUuSk2J8eLAFyh0np75cYS18ynu
         PyrA==
X-Gm-Message-State: ABy/qLaK6VX97C35T3LsEVO/QD4JVEgkB1wswpH03R58QRbbMTryAck/
	Z5A/oVD1D5D2LhZZspyBmw7i1heWYCN7XXH12lULOaK0FSsD
X-Google-Smtp-Source: APBJJlH3Timn+OhaHJ/79ZumgdgzTTzyEzblDmWTxmlZfYEFG5zG9Y/2M+u7w8vJLIufO3NBE/Ht7+La67whJbsd8/rLPvXWbJRL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5aa5:b0:1b0:60ff:b748 with SMTP id
 dt37-20020a0568705aa500b001b060ffb748mr11252238oab.3.1689625344585; Mon, 17
 Jul 2023 13:22:24 -0700 (PDT)
Date: Mon, 17 Jul 2023 13:22:24 -0700
In-Reply-To: <00000000000049baa505e65e3939@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077b5650600b48ed0@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in hci_uart_tty_ioctl
From: syzbot <syzbot+c19afa60d78984711078@syzkaller.appspotmail.com>
To: davem@davemloft.net, hdanton@sina.com, jiri@nvidia.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit d772781964415c63759572b917e21c4f7ec08d9f
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Fri Jan 6 06:33:54 2023 +0000

    devlink: bump the instance index directly when iterating

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=136a0414a80000
start commit:   84368d882b96 Merge tag 'soc-fixes-6.1-3' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=24d192d47d02d9e1
dashboard link: https://syzkaller.appspot.com/bug?extid=c19afa60d78984711078
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168fc765880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1376e745880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: devlink: bump the instance index directly when iterating

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

