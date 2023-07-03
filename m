Return-Path: <netdev+bounces-15043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBAA7456BB
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C05D280CBC
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA6BA52;
	Mon,  3 Jul 2023 08:02:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF26BA34
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:02:41 +0000 (UTC)
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F7A1992
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 01:02:19 -0700 (PDT)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1b81fc6c729so41265935ad.3
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 01:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688371304; x=1690963304;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfNeFv/Jw5jhtJb8APLTMFrU7cthcxZCp8o3g2rnmFc=;
        b=WyMMxy3Myu+cxEm8un+khpDKzmLNIpUWgnYilH12/6Uj6/3hw2AqeQd0miTwDnAT2f
         PPYcX6VzyGoDNeiahOeY/1CRoWSP6PhmOmBwjUICgmfpgBw9ADHiVdKVLLR90t78Hh1c
         KG+6/e1iKizGEPfeVtq3OZxEPivfnZ2zss7AVqThjvT0aCQxudK0yty0ZDEh0CaSG8uK
         7dvIfA0A6t0VEzN0cPVO2ZV6qYIuf8QMBBQdqlYZKnhzMLYtNN2ZFU4Av9dNzHveMYqM
         x/ZVo+B5au37CTHnTQiz0wAH0nNCIi+vvSPfN4myw6gG/A00VCEOW5dqX7YUJbPjsn+6
         17pg==
X-Gm-Message-State: ABy/qLZhtzbxlkoJ8rpc9spNylsHevidHE72G+1h90Ol2TGlc2iglZj4
	sd6O4rFxj5R7Xr0G3U2zTC9FTDvuPr5XKoQ7ujNwvQzj0an5
X-Google-Smtp-Source: APBJJlHJdW8cPjpYEEcPBbId+Rfkx/DY/I5xdl/QyMf5OH8C9dooAtNRER4olIr59NA1z0C/DANxTKe+W7kklN66nK9F7dsOs9OH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:ecd0:b0:1b8:3fbd:9aed with SMTP id
 a16-20020a170902ecd000b001b83fbd9aedmr8194818plh.3.1688371303955; Mon, 03 Jul
 2023 01:01:43 -0700 (PDT)
Date: Mon, 03 Jul 2023 01:01:43 -0700
In-Reply-To: <20230703-unpassend-bedauerlich-492e62f1a429@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2451605ff9093bc@google.com>
Subject: Re: [syzbot] [kernel?] net test error: UBSAN: array-index-out-of-bounds
 in alloc_pid
From: syzbot <syzbot+3945b679bf589be87530@syzkaller.appspotmail.com>
To: brauner@kernel.org
Cc: brauner@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Sun, Jul 02, 2023 at 11:19:54PM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    97791d3c6d0a Merge branch 'octeontx2-af-fixes'
>> git tree:       net
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11b1a6d7280000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3945b679bf589be87530
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/2bd5d64db6b8/disk-97791d3c.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/cd31502424f2/vmlinux-97791d3c.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/33c6f22e34ab/bzImage-97791d3c.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+3945b679bf589be87530@syzkaller.appspotmail.com
>
> #syz dup: [syzbot] [kernel?] net-next test error: UBSAN: array-index-out-of-bounds in alloc_pid

can't find the dup bug


