Return-Path: <netdev+bounces-39427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0417BF246
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 07:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8CF1C209F3
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 05:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDA65248;
	Tue, 10 Oct 2023 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyGXX67r"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B298F62
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 05:37:08 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE37AF;
	Mon,  9 Oct 2023 22:37:06 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1dd71c0a41fso3550555fac.2;
        Mon, 09 Oct 2023 22:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696916226; x=1697521026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+ydGI7sff09G/7JETRhlsl6DkdhesL7wxe7Wc1ipso=;
        b=NyGXX67rUNDetTjJkPKNiEevjYDyNjEGyGle1kwtvtf86bv3AQ6e8DTE4T8ffIYSNB
         cRmLJECQVcHhaMP6XjhGKUBpv2Xykds0denH4vAo5xoxEmA5DUXgyqbL4l1yhG3oomKH
         pT5PRPYw0b9RvRlrqKHEmKp+g3/Kvb609aw0HeCg0S9w088DbPVV+z51gFDCYMwkxdEh
         xrgCkG28iCASfzbXgnvyupPMXDjYP5lYIFSdzPB2T01x5gmfpyvjYLEiTnChANvr77fB
         U7CuwUyoxakHQSy/CIM1GHoWVx1DtQ82lnsuDOeLRXC+jEbX9h8l7mNghifU7/zSsbMV
         4fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696916226; x=1697521026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+ydGI7sff09G/7JETRhlsl6DkdhesL7wxe7Wc1ipso=;
        b=AYxcDl9YJKXUgxfIWr9lNrhqC79aI/GCp1owJNJcT0atk9AisJyBWr1VB0xoH7kaGi
         uWXtDnguz9maMCeegMvyqB+P2uYW9t78AHdyEfPtyaX7AnisBOpUUderT5gC2gn0oOfq
         YzlTvM847E+qAXef3TMNMUtcFx0mNbhOzri4i8yhiSVSp+g9u5BK7pt8iKQCTSpTMro3
         At2Fbj7lgZyUX2NQVn59yChfaXtGgNkKVrCNi3WpDLE2WgTEDzBqFMQBkuICqId0oV4a
         QyJcdF41TAQ4tt4leruH1IkURMgp5nlfK5qr/NR7pOqAg072sBgo68i/mLBFPrYoQraw
         mymw==
X-Gm-Message-State: AOJu0YybPOoSZoSLqunYtCD3ns/h8+N6a8/AG6Ik5agGl1GAU1p1kZvT
	EOX/ITer9w92QuiV5eEVQMM=
X-Google-Smtp-Source: AGHT+IEKsubtOOGHSEohPCYMGjWslsLGkbDHkHKk9Srkm0L4XmEWSyeocHgsc01rhV7A0Rnkjd+ptA==
X-Received: by 2002:a05:6870:71ce:b0:1d6:51aa:13a2 with SMTP id p14-20020a05687071ce00b001d651aa13a2mr19869311oag.10.1696916225861;
        Mon, 09 Oct 2023 22:37:05 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id n9-20020aa79049000000b0068fe7c4148fsm7267060pfo.57.2023.10.09.22.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 22:37:05 -0700 (PDT)
From: Edward AD <twuufnxlz@gmail.com>
To: syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	johan.hedberg@gmail.com,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] Bluetooth: hci_sock: fix slab oob read in create_monitor_event
Date: Tue, 10 Oct 2023 13:36:57 +0800
Message-ID: <20231010053656.2034368-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000ae9ff70607461186@google.com>
References: <000000000000ae9ff70607461186@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When accessing hdev->name, the actual string length should prevail

Reported-by: syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com
Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")
Signed-off-by: Edward AD <twuufnxlz@gmail.com>
---
 net/bluetooth/hci_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 5e4f718073b7..72abe54c45dd 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -488,7 +488,7 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 		ni->type = hdev->dev_type;
 		ni->bus = hdev->bus;
 		bacpy(&ni->bdaddr, &hdev->bdaddr);
-		memcpy(ni->name, hdev->name, 8);
+		memcpy(ni->name, hdev->name, strlen(hdev->name));
 
 		opcode = cpu_to_le16(HCI_MON_NEW_INDEX);
 		break;
-- 
2.25.1


