Return-Path: <netdev+bounces-32714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47132799A2A
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 19:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E821C2087B
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 17:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF27464;
	Sat,  9 Sep 2023 17:03:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709476FA5
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 17:03:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7789C
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694278997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KRsfGWDiakSCdlAdAROSL7HgPfkAmtDGqTNLHJo4TzA=;
	b=DcId9aIRVf/MQAELfI19OLywG+9oz1x7SX03+mLZe60VdcEuiii+57JfEXH0HZM9H3xU+q
	VUam+zlPnR6Th1+QLa8gnmvNulWS6AyszcwsfhatcmFJgiNXjz/2BPLBz1vQyITL4nCW4D
	nNWsz8tt/JBsUpEL3i/n1I6Rw9kgT1w=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-wkjfvHwYPfWW7rEThuEe2w-1; Sat, 09 Sep 2023 13:03:16 -0400
X-MC-Unique: wkjfvHwYPfWW7rEThuEe2w-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a741f4790fso3541756b6e.0
        for <netdev@vger.kernel.org>; Sat, 09 Sep 2023 10:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694278996; x=1694883796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRsfGWDiakSCdlAdAROSL7HgPfkAmtDGqTNLHJo4TzA=;
        b=HQbsE4RvAcufsLdal3zWGphOWaU/5Wu+bMN1QjBDqKcfxFFpzqxP41JeQhhdd9QBpM
         Vs6xwnURFrY0JP5fZ9EzdMXrXs2YCC9luzUListmsru5zWswhIO0WxGDusOjnBqy7VTG
         7LnHa68YBt/bxlWs3nvNh8ZCl/JPCyhUywFtHzqomM+P/zsFcnKQZx2kfOxNciUW2IIK
         38CIHpJJ71Z0okQnHcj9oSC3x63npmaitfFhzhfLtjmCuw60F9bZvwwYfXM3pNUQk2pp
         Ksw+XwPM1HWz2DzB/soKdfu/NwaomYNqDtrJoUrxA0xmHuwQreT03THsz5LvkTj4L7hm
         nZlg==
X-Gm-Message-State: AOJu0YwmOaMJk5jm33ry47EdmyzzO6txWYSRGzSUSFsOFFdWaYA3SYtB
	0Jy73RU/PbcnI9ZNsY1ddu454h0+uRiGwB7AF41qG3DlX4Si5XNCi61atCdH2vs9aLftzx5Vs6s
	ziufzXmNnoO2yzmEe
X-Received: by 2002:a05:6870:b50d:b0:1b7:3432:9ec4 with SMTP id v13-20020a056870b50d00b001b734329ec4mr7421918oap.10.1694278995766;
        Sat, 09 Sep 2023 10:03:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHewocO8VMFHcxmM6tjTB6hUq/W2PQDcgGcMorZTDjzD+HilF0jRgw7t5/4Xv8olN1HKNaLfg==
X-Received: by 2002:a05:6870:b50d:b0:1b7:3432:9ec4 with SMTP id v13-20020a056870b50d00b001b734329ec4mr7421891oap.10.1694278995479;
        Sat, 09 Sep 2023 10:03:15 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id c2-20020a633502000000b0057405fc20c3sm2935490pga.72.2023.09.09.10.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 10:03:15 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com
Subject: [PATCH net v2] kcm: Fix memory leak in error path of kcm_sendmsg()
Date: Sun, 10 Sep 2023 02:03:10 +0900
Message-ID: <20230909170310.1978851-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot reported a memory leak like below:

BUG: memory leak
unreferenced object 0xffff88810b088c00 (size 240):
  comm "syz-executor186", pid 5012, jiffies 4294943306 (age 13.680s)
  hex dump (first 32 bytes):
    00 89 08 0b 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e5d5ff>] __alloc_skb+0x1ef/0x230 net/core/skbuff.c:634
    [<ffffffff84606e59>] alloc_skb include/linux/skbuff.h:1289 [inline]
    [<ffffffff84606e59>] kcm_sendmsg+0x269/0x1050 net/kcm/kcmsock.c:815
    [<ffffffff83e479c6>] sock_sendmsg_nosec net/socket.c:725 [inline]
    [<ffffffff83e479c6>] sock_sendmsg+0x56/0xb0 net/socket.c:748
    [<ffffffff83e47f55>] ____sys_sendmsg+0x365/0x470 net/socket.c:2494
    [<ffffffff83e4c389>] ___sys_sendmsg+0xc9/0x130 net/socket.c:2548
    [<ffffffff83e4c536>] __sys_sendmsg+0xa6/0x120 net/socket.c:2577
    [<ffffffff84ad7bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad7bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

In kcm_sendmsg(), kcm_tx_msg(head)->last_skb is used as a cursor to append
newly allocated skbs to 'head'. If some bytes are copied, an error occurred,
and jumped to out_error label, 'last_skb' is left unmodified. A later
kcm_sendmsg() will use an obsoleted 'last_skb' reference, corrupting the
'head' frag_list and causing the leak.

This patch fixes this issue by properly updating the last allocated skb in
'last_skb'.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Reported-and-tested-by: syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6f98de741f7dbbfc4ccb
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
v1->v2:
- Update the commit message to include more detailed root cause. 
---
 net/kcm/kcmsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 393f01b2a7e6..34d4062f639a 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -939,6 +939,8 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 
 	if (head != kcm->seq_skb)
 		kfree_skb(head);
+	else if (copied)
+		kcm_tx_msg(head)->last_skb = skb;
 
 	err = sk_stream_error(sk, msg->msg_flags, err);
 
-- 
2.41.0


