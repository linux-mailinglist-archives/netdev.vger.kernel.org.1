Return-Path: <netdev+bounces-36706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F29E7B161A
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 10:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0F575282A1D
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 08:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E845D15B6;
	Thu, 28 Sep 2023 08:34:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73F110B
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:34:15 +0000 (UTC)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48DCAC
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 01:34:13 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6c4e17f37acso20037535a34.1
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 01:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695890053; x=1696494853;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gnCChu3OPSULseuxsND/OC3A1/+wMaTTBp9NGU091g=;
        b=Pb6di5RC1Cf8O+NtE26bE/4hpUktzzPo/fIh/E2Rem70dOD7MFVzoScYC2ERqlJAQQ
         xhmMR32+Z1xzEvXgVFF25vWV5QIhcK2xkjZ0sDXIK+MTYOWsk7g/r6snBKvlUeCRaK7s
         Cd1qSjxqjdQwpX0sPnQpC5pkCtzjCDn8OKdCuaWaNX83zvf1Oez6KaJkB//KUpNAHKp6
         zXmR8jBeaUhh3iS8Btttf5eghYHk7tllfSyadhINROr4Dc7Mu00uLDbh4TSSqwRGwmTU
         wLSBUZpnLDGAwmoeyKF8JlUZTpmW6qCEX8n0mfHIUdDKApuLNrHjchZGvzd3BJMRbEiM
         66Fg==
X-Gm-Message-State: AOJu0Yz2aa25BKvv12m8MtZr0KMRbEJy5l1b/kjSnfsJDGuk+phR5JTd
	Z/UoOb1HeNnEWn8nzX63RD5MjkmQsX9ntxbOs4O+kIu1AId9
X-Google-Smtp-Source: AGHT+IF9KchoAbdBn8cAF3kwm11v8WwkvIJGdTzNT7wPWDxuCnjFJvdAMeVTMBnzh5aDQ1IM6YlCQX0DcmnNmkK7BVifFzdxX4Sb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:22d2:b0:6bd:b74:2dab with SMTP id
 q18-20020a05683022d200b006bd0b742dabmr137988otc.2.1695890053216; Thu, 28 Sep
 2023 01:34:13 -0700 (PDT)
Date: Thu, 28 Sep 2023 01:34:13 -0700
In-Reply-To: <0000000000003dcc9306031affdd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003341ba0606672c7a@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in
 sys_clock_nanosleep (5)
From: syzbot <syzbot+43cc00d616820666f675@syzkaller.appspotmail.com>
To: edumazet@google.com, hdanton@sina.com, jhs@mojatatu.com, 
	linux-kernel@vger.kernel.org, michal.kubiak@intel.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit 8c21ab1bae945686c602c5bfa4e3f3352c2452c5
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Aug 29 12:35:41 2023 +0000

    net/sched: fq_pie: avoid stalls in fq_pie_timer()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12958976680000
start commit:   6709d4b7bc2e net: nfc: Fix use-after-free caused by nfc_ll..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=43cc00d616820666f675
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10858fc0a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14781270a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: fq_pie: avoid stalls in fq_pie_timer()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

