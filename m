Return-Path: <netdev+bounces-17005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4280074FC84
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4C22817A9
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 01:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB16378;
	Wed, 12 Jul 2023 01:16:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FC362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 01:16:27 +0000 (UTC)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA221718
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 18:16:26 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b884781929so493989a34.1
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 18:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689124586; x=1691716586;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVCDywhHpMOGTFqG/gDYk0S45lUTl1W6WhYjBIpoNpw=;
        b=VQ0dPu/FwWcpJQguhSudVe+QOlVawtfbq2BakVIf5SFBw1gv3I71CI+EYNe5KN2cOu
         rMUbhfleybK4VIYPfmxhCUfY4BfgrIWTZv95Y1tPrp0GGqwvS4OLs6ix9NO2Lq/dQBb5
         d4I1h5eiRfR9wxKsxFaBqAqAh53m4HFkQxrHtVoWSuXzrqW8m0gQ2qHMdfPs43Hvea/A
         /woIuXI8kd7tjwpoKD0TBJqAfY02MP9srwRQG5aikpAHedTSwGII/g35hgGnUxz0Q+at
         NYa63lV1lioQuQTsvcoLxpFKWAOlvNNJCShnUtmy+nCT9RnS+m0vPoRyV2vJFD6sUC4t
         ZCCg==
X-Gm-Message-State: ABy/qLbAvjTp64Vw+BoIolOEIN1+OJ3EBK6+4dVXKG1Iy8SUoX342xo/
	XV6Sxp92gAPEzTujFwZ6E4dVpKJrRFm3+mAhtEhsZJH571MC
X-Google-Smtp-Source: APBJJlEfdPeTrhOct9RIcxFE/RE/xuq9yIIGgVNHdByqdXJPK44xyvBuBojGYPkI1HcFu3nt3m+tr7yZqNEffrD+pg4iJnyU9rQU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4524:b0:6b8:70f3:fd36 with SMTP id
 i36-20020a056830452400b006b870f3fd36mr712756otv.2.1689124586175; Tue, 11 Jul
 2023 18:16:26 -0700 (PDT)
Date: Tue, 11 Jul 2023 18:16:26 -0700
In-Reply-To: <20230712004750.2476-1-astrajoan@yahoo.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0c50706003ff6f3@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_sk_errqueue (2)
From: syzbot <syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com>
To: astrajoan@yahoo.com, davem@davemloft.net, dvyukov@google.com, 
	edumazet@google.com, ivan.orlov0322@gmail.com, kernel@pengutronix.de, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org, 
	o.rempel@pengutronix.de, pabeni@redhat.com, robin@protonic.nl, 
	skhan@linuxfoundation.org, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com

Tested on:

commit:         3f01e9fe Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=130a98a2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c2acb092ca90577
dashboard link: https://syzkaller.appspot.com/bug?extid=1591462f226d9cbf0564
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1380a782a80000

Note: testing is done by a robot and is best-effort only.

