Return-Path: <netdev+bounces-43285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD067D2300
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 13:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C97E5B20D57
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E645B3D6B;
	Sun, 22 Oct 2023 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DE7D506
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 11:52:33 +0000 (UTC)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DB9F7
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 04:52:31 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1e1cba2da07so3549384fac.1
        for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 04:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697975551; x=1698580351;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXk6ipW0WGEi096jxXY2WBNHGYG5TkCETUVTeM32tA0=;
        b=wa2gTn+hGDEaF+SeJ5YmO6gxOAdRYOgF5aRSktOyLL69jkXDYplwr9daUISokTQka5
         qWF8fgZEZckprF49Dtb38H2W26l01xw9iWDGAHKYvErHf3Y1GODA0QJwk2qcKTqOfMi6
         FYR/++Ts6hVHhTm1hFrNzaHYJsTk3U4JpYHUwdao9/OHOttwc3Y9NO+JkGVkHNikd5FN
         TNMpSiamC0G3dYR+biRPLZRDjJKRYhFf7bIoAGaFo95FiyolvWj4MmROMJEqaXnzKKZo
         fgqURo6G2MqlbCP2V7gyjFlY2mvXG7W1bkUXdspVrHfcccZkxaqbdlxmnfkvvs9+1zUZ
         aAuA==
X-Gm-Message-State: AOJu0YzWfjMJl4oamnlju15KCQvum6cOcC72JmqFqu4QpuBy3Vb20yJl
	Eihl5KC57wvwskBxyFEMxEeCHdpZ1LtnlHdXM0qbKsESY/UD
X-Google-Smtp-Source: AGHT+IEvMT+swEq07R5cFoGX9zXWQzPjIfXPkahPbW7Kk4Q7RWNC6vbYiKNsJ9CIG1L3psFE+kMdNeFhLTSurFuYmMgxx1r9D47G
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6871:3308:b0:1e9:e1dd:b953 with SMTP id
 nf8-20020a056871330800b001e9e1ddb953mr2956608oac.1.1697975551329; Sun, 22 Oct
 2023 04:52:31 -0700 (PDT)
Date: Sun, 22 Oct 2023 04:52:31 -0700
In-Reply-To: <000000000000438c4a06031aff8b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000930e6f06084cbd43@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in schedule (6)
From: syzbot <syzbot+77195ae75047f1438785@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	jiri@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c2368b19807affd7621f7c4638cd2e17fec13021
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:35 2022 +0000

    net: devlink: introduce "unregistering" mark and use it during devlinks iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ed7a99680000
start commit:   a785fd28d31f Merge tag 'for-6.5-rc5-tag' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11ed7a99680000
console output: https://syzkaller.appspot.com/x/log.txt?x=16ed7a99680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=77195ae75047f1438785
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ec36ada80000

Reported-by: syzbot+77195ae75047f1438785@syzkaller.appspotmail.com
Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

