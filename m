Return-Path: <netdev+bounces-13484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C75973BC5B
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 18:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA0A281C68
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D42100AE;
	Fri, 23 Jun 2023 16:07:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C644D507
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 16:07:32 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C30270A
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 09:07:31 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3420c84e530so5076625ab.1
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 09:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687536450; x=1690128450;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rj1HcKKNnldMdeD2XNSySckZRvgWRLe0ofFpk2T+xdg=;
        b=dc0km04hx7hbvHZTvXo6TH/Hos6ZgC96gw7AojfDCkERpHjXRgpubUEKLTgtjlK8F/
         SzzX+Wi8ML+mD/KvS1pS9m29LluCkzWwC+8LoZune1+Fc4JP3oaqDvOC85LmmOaWojsI
         JvPXogl6l1OG5kPGY5az1q3jkIm0eaN/di9v8EkOhfgXifqYmOcma3z8zcmhEqg4EZYb
         Lgw8lcuClf0KA5mn2GUcdm6N9nLEUdDQT6zi9pMWtHYG8Kat5Y3CH0z4nVaTMYrK1+sH
         zuMPJYHxpoE4vNryDufQsIcuPL50k5Rv8jHkmib4Pw8kcmLwENek8ZJPshyqY/MZBo4N
         1caQ==
X-Gm-Message-State: AC+VfDy7tRx8pssEzSi7KChMRi8B7Jjnx0dwHKnwYTDsW7eu5fQAW+ni
	U9rraxvsn0gHIL7YTom3cXOwrLzx7nSWdYy68AhUkcIvwATz
X-Google-Smtp-Source: ACHHUZ4+tDqI4FxVxVx9esMJCzQ872Ye0OjJJfbBVuvc0Mj1O61IdyXl+Stk7c+KRlN0TpqpR4ZQBAw5Cl29h3MS6l18DgdS1ZxM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d44b:0:b0:340:ba08:3c45 with SMTP id
 r11-20020a92d44b000000b00340ba083c45mr8076102ilm.4.1687536450338; Fri, 23 Jun
 2023 09:07:30 -0700 (PDT)
Date: Fri, 23 Jun 2023 09:07:30 -0700
In-Reply-To: <0f685f2f-06df-4cf2-9387-34f5e3c8b7b7@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab076105fece32e3@google.com>
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

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com

Tested on:

commit:         45a3e24f Linux 6.4-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.4-rc7
console output: https://syzkaller.appspot.com/x/log.txt?x=1210e557280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=63ee658b9a100ffadbe2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e0e557280000

Note: testing is done by a robot and is best-effort only.

