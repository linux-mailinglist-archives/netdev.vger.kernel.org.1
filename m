Return-Path: <netdev+bounces-43261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 829747D1F46
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 22:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DF41C20929
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 20:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D5E208C2;
	Sat, 21 Oct 2023 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5A2030C
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 20:03:37 +0000 (UTC)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE28DB0
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 13:03:32 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1e9877c1bf7so3273471fac.3
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 13:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697918611; x=1698523411;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WAzTyFISqHdjSyvCMXj3Ko54bxjdlHu7tjC7EE4Bclk=;
        b=eSyUvsiiZU0QmqDjInr14JorPJiTeQPAEx9YaPODiwO9yotd4sJ1ebhLovLGEINJHU
         Oa1u8CMByTWwK8EL+TFwi9+4+GsU5TZvQpLJSGnGy1PmaOH2Xx7cqVk2rXeQloqaXS9D
         CTwayzACIMp6orYYOcASHJ8OiPvnJJ+28sUq6HppQI7J56uYSfMLRwfLJ+2oHOmXQKhB
         yuzrE/YKK4PxsME0NLKWKYGfXTZmsz/FU32OngvE0/gxIFP5JXi8AhnOM/HTHpiI8qe7
         x+WjsoX6kfATVXBkeGWUSxWNUv0Bi/k/LCk1g41M5xf1EKpMRE1dcNWUDElxlE0O8sac
         RtbA==
X-Gm-Message-State: AOJu0YySnfOBlxd/HyR8Vh7K0Ve/DtQThvFWuKqiUJYsA8g5uVWsuxfH
	QOkG3rj7NNTZp00Gfq6QwzsbjnX8J8kyRf2ElixN6RTUSrqt
X-Google-Smtp-Source: AGHT+IGp54TDvOaC30bVb/2e7+ssX1s1YmK9GXb8Z+InCir5Vag8UcafHsFUhYKPux1Sx6Z9mt/2BVsltYo1xzUr9MU+BK0yKHjl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:f205:b0:1ea:2dd6:6a86 with SMTP id
 t5-20020a056870f20500b001ea2dd66a86mr2577551oao.9.1697918611301; Sat, 21 Oct
 2023 13:03:31 -0700 (PDT)
Date: Sat, 21 Oct 2023 13:03:31 -0700
In-Reply-To: <0000000000008f824606052a2d9b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af2dbf06083f7baf@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in wpan_phy_register
From: syzbot <syzbot+b8bf7edf9f83071ea0a9@syzkaller.appspotmail.com>
To: andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit fd6f7ad2fd4d53fa14f4fd190f9b05d043973892
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon Aug 28 14:58:24 2023 +0000

    driver core: return an error when dev_set_name() hasn't happened

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ea2e89680000
start commit:   ac28b1ec6135 net: ipv4: fix one memleak in __inet_del_ifa()
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
dashboard link: https://syzkaller.appspot.com/bug?extid=b8bf7edf9f83071ea0a9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14871d58680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ace678680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: driver core: return an error when dev_set_name() hasn't happened

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

