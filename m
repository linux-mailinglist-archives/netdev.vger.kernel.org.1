Return-Path: <netdev+bounces-13426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B82873B8D0
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529121C211BE
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 13:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD218BF5;
	Fri, 23 Jun 2023 13:32:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7AE8BE0
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:32:25 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA602683
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 06:32:23 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-76998d984b0so40935039f.2
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 06:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687527142; x=1690119142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPlj0ePe9xQ/WGGxyQBMmpisE5qo9ZSTCQrilqsvigQ=;
        b=Ld/4BYwl/m/MvE9z1KjX6A8FlNZM7tcYphNKzUermuZV0YqbVbGGElSH+P621YYaYE
         ozziQ2ErLUZBX3tqu63vpuOBj7XJKGAjF1vkpJwdOSFKJ8+Nuv/X27l0PS7UtaoSZ6o+
         6HfLkdvrMjoK6ZHoEYsSuDhXLGBLSmFZHcRsG7u8FDeYnO1nw73B0AA7fW/nYBGH1qEH
         aKkQIe6foytUNxuDWdGSZU5W6bJbBue5izuP+re3qs+7D6wn7hnLoeT4f19+RiUJkClT
         xY2BDBM71fLTkpn/D9/mSZVaWhBy6g7Z1ifNuAP5xtsD/4XldkrKs4SHt7402BFpFft5
         N17A==
X-Gm-Message-State: AC+VfDy9S+e8Ob4NrH/0RyD694nvZxd4LAHryq3evNXIoM6BYh6erynK
	rMgYiqUI+cwAS39y2eh8jv+MLKiVWPStCcku0nt3g0MXvPIJ
X-Google-Smtp-Source: ACHHUZ7es2/0OYCgP9Xe9+U9nOMkBNUXSJs2+g2Sx3i1cyfAId1btZVYLtMzAKFe6WLIK1k38RkxmhHr4PLlb5Wssps8Nws/9xja
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:848f:0:b0:423:219d:81ce with SMTP id
 f15-20020a02848f000000b00423219d81cemr7555030jai.2.1687527142625; Fri, 23 Jun
 2023 06:32:22 -0700 (PDT)
Date: Fri, 23 Jun 2023 06:32:22 -0700
In-Reply-To: <000000000000a56e9105d0cec021@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e298cd05fecc07d4@google.com>
Subject: Re: [syzbot] [usb?] WARNING in usbnet_start_xmit/usb_submit_urb
From: syzbot <syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com>
To: andreyknvl@google.com, davem@davemloft.net, dvyukov@google.com, 
	edumazet@google.com, gregkh@linuxfoundation.org, kbuild-all@lists.01.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	lkp@intel.com, netdev@vger.kernel.org, nogikh@google.com, oneukum@suse.com, 
	pabeni@redhat.com, stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com, 
	troels@connectedcars.dk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit 45bf39f8df7f05efb83b302c65ae3b9bc92b7065
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Tue Jan 31 20:49:04 2023 +0000

    USB: core: Don't hold device lock while reading the "descriptors" sysfs file

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124b5877280000
start commit:   692b7dc87ca6 Merge tag 'hyperv-fixes-signed-20230619' of g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=114b5877280000
console output: https://syzkaller.appspot.com/x/log.txt?x=164b5877280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=63ee658b9a100ffadbe2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1760094b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1359cdf3280000

Reported-by: syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com
Fixes: 45bf39f8df7f ("USB: core: Don't hold device lock while reading the "descriptors" sysfs file")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

