Return-Path: <netdev+bounces-51925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B67FCB24
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6614A1C210A3
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859225C3EB;
	Tue, 28 Nov 2023 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6837B19A6
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:57:05 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cfb5471cd4so39523075ad.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701215825; x=1701820625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vN2Ir+Y4JmS/bZdrwe9hRvn9LSobTrbuzI+1V9ZVUoI=;
        b=RUgae9AZQb8WnN3ErW6Qkm9Y3VkNOJIU1rG+22DA5YtC2uD4u089IjarCsdn5qTjnI
         bou0s0SlaB9X7hLOiKfeLH3Klp9HhCOW2lzX8jqnI8Gbf85ay/xmdQO4qcwa4YrGgy8v
         PRJLe49cQa189v4AdHo3pYviqsLjuCdC9zIp8kCh0OZkSYbA+3QX3WCWLTRlj1CnnbO8
         uEDhHGqcjMsbz9+kx/LMIOxgZMLQpKLy9RGut5xkLnHFa9UkkTlTdMjWlLHiqti66Jo3
         /bn6zqcaEOdvYOMWj+sgL25HXwZVQUqBReAgp9naa+goeqo/ISh3yZeAcyLwbuEEdVrz
         18bQ==
X-Gm-Message-State: AOJu0Yy6sGyVgStiSZKTpdpy79M2qrA+UPwya5Tov/86C5bEsj66+QY4
	FLVBEXZeWVD8XcevZKXrqEifJIKv9baguFUzCjdK2Ujy/FB4
X-Google-Smtp-Source: AGHT+IEBmKxuYKtQ/S0w/Sxr+C51n7BNjuA3UdTFIXPrhy6pf4y+36y7PctlYRTxRWgVazDQbWRHjB0qaDOjWNcdvHmORUl52cwI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:4282:b0:1cc:2f2a:7d33 with SMTP id
 ju2-20020a170903428200b001cc2f2a7d33mr3456055plb.2.1701215825023; Tue, 28 Nov
 2023 15:57:05 -0800 (PST)
Date: Tue, 28 Nov 2023 15:57:04 -0800
In-Reply-To: <000000000000efc64705ff8286a1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000efd864060b3f2cf0@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in rate_control_rate_init (2)
From: syzbot <syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes.berg@intel.com, 
	johannes@sipsolutions.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org, 
	ndesaulniers@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b303835dabe0340f932ebb4e260d2229f79b0684
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Sat Jul 23 20:08:49 2022 +0000

    wifi: mac80211: accept STA changes without link changes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125a86dce80000
start commit:   a214724554ae Merge tag 'wireless-next-2023-11-27' of git:/..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=115a86dce80000
console output: https://syzkaller.appspot.com/x/log.txt?x=165a86dce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=abf6d5a82dab01fe
dashboard link: https://syzkaller.appspot.com/bug?extid=62d7eef57b09bfebcd84
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a4fc64e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1363b22ce80000

Reported-by: syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com
Fixes: b303835dabe0 ("wifi: mac80211: accept STA changes without link changes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

