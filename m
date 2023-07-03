Return-Path: <netdev+bounces-15045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5987456C2
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64730280CC1
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695EFA53;
	Mon,  3 Jul 2023 08:02:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D3A52
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:02:49 +0000 (UTC)
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE0419BA
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 01:02:29 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-66881827473so4205318b3a.2
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 01:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688371318; x=1690963318;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiZNLBYfEYXTt1L0qzwGmdJw59vGiJNUhJxkls68qUc=;
        b=VTKWfMk00Wd/2q1vhQ6ZkpUoOOOllBdLYWW7RKMBvkRIm520ea3UOicUXhjB7IaWM5
         0n1rwu9quYj0U2HhEroiUegNMH9J7EaiQBfa+z09vUDY+GGoky0hFjtNmjbnx9PKmSZG
         9VTgx9nVaqqFMbcEV/9gNTJWrr6NuoGqQqVfoPHzH/Ll4nRfNuMahDz2TEr6dO69C17R
         GO3zkJTACU2wWRAeg1z79Q5tGl8jlJmv36yAg4RlpLD0v23yxlrBY9FdvzRI0jYdq4Zw
         v4qUadmHduvCQZvBqmbVDLwyhRCh2ZJDWRk19JKMDvwp07ZqCm8zBRb3GcgH6eCck+7Y
         NniA==
X-Gm-Message-State: ABy/qLZecBFpGZNwe0coBWVpqSiCSBS3PUboIJesSBB8ccW9BAMJkyIK
	H7QXtqiY6NFPQd3sBvlBg8wNlCdp+Fk3escqhiKYhAmnmLf1
X-Google-Smtp-Source: APBJJlGeWl020xWQOz6lUxai5rIohD4968Dp1WHHAtStpCZSioUFTABcQvcbzs3SRpfQDw4mLu6EVZo2m+RqTB1AyAV0e9Ri0Jp4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:238e:b0:675:b734:d30f with SMTP id
 f14-20020a056a00238e00b00675b734d30fmr11228712pfc.4.1688371318706; Mon, 03
 Jul 2023 01:01:58 -0700 (PDT)
Date: Mon, 03 Jul 2023 01:01:58 -0700
In-Reply-To: <20230703-richten-ehren-5a4c9b042a23@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b359eb05ff9094f0@google.com>
Subject: Re: [syzbot] [kernel?] bpf-next test error: UBSAN:
 array-index-out-of-bounds in alloc_pid
From: syzbot <syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com>
To: brauner@kernel.org
Cc: ast@kernel.org, brauner@kernel.org, daniel@iogearbox.net, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Mon, Jul 03, 2023 at 12:14:17AM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    c20f9cef725b Merge branch 'libbpf: add netfilter link atta..
>> git tree:       bpf-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=127adbfb280000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
>> dashboard link: https://syzkaller.appspot.com/bug?extid=319a9b09e5de1ecae1e1
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/bf9c9608a1e0/disk-c20f9cef.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/3bde4e994bd0/vmlinux-c20f9cef.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/5d80f8634183/bzImage-c20f9cef.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com
>
> #syz dup: [syzbot] [kernel?] net-next test error: UBSAN: array-index-out-of-bounds in alloc_pid

can't find the dup bug


