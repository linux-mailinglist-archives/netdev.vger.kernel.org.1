Return-Path: <netdev+bounces-60657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D664820BBD
	for <lists+netdev@lfdr.de>; Sun, 31 Dec 2023 16:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223FB281B5F
	for <lists+netdev@lfdr.de>; Sun, 31 Dec 2023 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F22611B;
	Sun, 31 Dec 2023 15:16:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22799BA30
	for <netdev@vger.kernel.org>; Sun, 31 Dec 2023 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35ff20816f7so69434185ab.1
        for <netdev@vger.kernel.org>; Sun, 31 Dec 2023 07:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704035764; x=1704640564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERXn+tLTNJVMpVARpfqKFaajgSMwYoA2QCmtE1NmFuY=;
        b=KOtJLyfbQl2UuA+7jFBMdsg77QO0h0UywWuevUIyjips2Ov9n/DHBYZu+I29xhI/nT
         JilfvBH/giAYOWkU3RExjnxklTQwaPMUr6K6QSo2ld/yPy/qwizf7jJyJ5Z8I30609Gq
         kjZFZ4b7bZQLpr60Px2DbOHnZ+ocC2HBhvSE6fFwuu0KNl/h8q8FM+ecs1Ne4axYLuD0
         CeWHDBnsZn+5y3MDpGRqJEFAbcLhHdPfVjQv2J0ZD57v/L6AzgDGeQRJiDyBE2Z4EHbO
         4Fk7X+Ky/ds0WL1zUux9EKHNQEeM5w9nqj1QNRv6B3xRCrw9zif9EXqVGsutI/yIs3g0
         lmYg==
X-Gm-Message-State: AOJu0YyWy4ekZEIeET9cuRniW6dzRuJApS+sYjHH6VPqi0+5gorrIA/q
	571+oDStLzYgijpkcOwe9ZxcjXKorpBLdqeDf1PYBjh0wq+I
X-Google-Smtp-Source: AGHT+IEIdHuxU8nTGu94WRSR8lPA2wJdjJj124l34XuaK+aT3x4/M8a7wvRZP1rQjw1+zi1B8eUwKPWNs6SLBNUnUTDhQfQj1Wrw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d87:b0:35f:8652:5ce8 with SMTP id
 h7-20020a056e021d8700b0035f86525ce8mr1682321ila.4.1704035764241; Sun, 31 Dec
 2023 07:16:04 -0800 (PST)
Date: Sun, 31 Dec 2023 07:16:04 -0800
In-Reply-To: <360d5a75-b06a-4b52-ba6c-e24a0bffa530@mojatatu.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000698c17060dcfbe16@google.com>
Subject: Re: [syzbot] [net?] general protection fault in hfsc_tcf_block
From: syzbot <syzbot+0039110f932d438130f9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com, 
	syzkaller-bugs@googlegroups.com, victor@mojatatu.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com

Tested on:

commit:         92de776d Merge tag 'mlx5-updates-2023-12-20' of git://..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10cb54b1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
dashboard link: https://syzkaller.appspot.com/bug?extid=0039110f932d438130f9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d12036e80000

Note: testing is done by a robot and is best-effort only.

