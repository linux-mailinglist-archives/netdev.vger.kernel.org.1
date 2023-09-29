Return-Path: <netdev+bounces-37113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93F27B3AC9
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 21:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8A0BE282653
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 19:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E833266DDB;
	Fri, 29 Sep 2023 19:45:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC85D42C0B
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 19:45:24 +0000 (UTC)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408F5139
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 12:45:20 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e113662d75so2982204fac.3
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 12:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696016719; x=1696621519;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOUbdmuYhfXA8PXd4YARC5tF6kjo7P/y7HVDRuq7ymQ=;
        b=NUx/Rc6uxO4wy5pC+LMVLz3nY0LBalYUa6tR1raiacwi2ZQLSzD/QimRVd1oZUGd3D
         +hyLJY2s0OX1YIAHLxBrV1gcqjfm7BCHLplnau675Pay5m1KzS8e81y3zgzWuQxuS7SS
         wzlnwlzyFwI0mT1cZhStXWST3vKi4z8O+OjMb/opb+anhXzeg/FfiPsT7s6lCQd02H56
         Z49sfGk69Y1Foli536ls2wP6plxOWIA5QNjxRpT6Z8fMXkMxq9V66UDhjYGUgC9Ipwcn
         QRmPLVw4roOan1e8Am/jj1eeMc5aWRuO5bRwGe1zrTR7RMinpE5ow4S1z0QHB4b8t5Y2
         qbuA==
X-Gm-Message-State: AOJu0YyJi6VxWy8VwAxdf3mIUJa/jzVE2Ilh/aPeqEHf7sQqHlbg/VjR
	on5Q1oh2c/+80gvDta5rPrx3TbsHGI4L2gdATCjvq59HtVig
X-Google-Smtp-Source: AGHT+IFYMqItjJEVGHOIHmUPeuMNaMxy8KqwKD+rwjOwwTOlXsRSXiwCv6oua1+5pQPktR4BQVSd+yRH6/cIOImXUzqYibBfr/5x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:98ae:b0:1b0:9643:6f69 with SMTP id
 eg46-20020a05687098ae00b001b096436f69mr1969651oab.4.1696016719665; Fri, 29
 Sep 2023 12:45:19 -0700 (PDT)
Date: Fri, 29 Sep 2023 12:45:19 -0700
In-Reply-To: <00000000000021dc2806031ad901@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001be691060684aa2c@google.com>
Subject: Re: [syzbot] [wireguard?] INFO: rcu detected stall in
 wg_ratelimiter_gc_entries (2)
From: syzbot <syzbot+c1cc0083f159b67cb192@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, daniel.wippermann@resol.de, davem@davemloft.net, 
	edumazet@google.com, hdanton@sina.com, jason@zx2c4.com, jhs@mojatatu.com, 
	jiri@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com, 
	syzkaller-bugs@googlegroups.com, victor@mojatatu.com, vladimir.oltean@nxp.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit da71714e359b64bd7aab3bd56ec53f307f058133
Author: Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Tue Aug 22 10:12:31 2023 +0000

    net/sched: fix a qdisc modification with ambiguous command request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129c464e680000
start commit:   8a519a572598 net: veth: Page pool creation error handling ..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e670757e16affb
dashboard link: https://syzkaller.appspot.com/bug?extid=c1cc0083f159b67cb192
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129f8553a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1205baada80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: fix a qdisc modification with ambiguous command request

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

