Return-Path: <netdev+bounces-40943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A48C7C926D
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 05:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5659C1C209B3
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 03:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E80A46;
	Sat, 14 Oct 2023 03:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf7Qb1rH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C58367
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 03:13:39 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3953D6;
	Fri, 13 Oct 2023 20:13:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9b95943beso23275735ad.1;
        Fri, 13 Oct 2023 20:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697253218; x=1697858018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ofkxnOmb7cqwZjJ5IHHNe3UaCC4MdflRYJIUEycODA=;
        b=mf7Qb1rHN3nW1AKtxfAABJMYYARGGKnK2nYwmzPNCUEmUcTElE2+D9Xl8I2M3W4PqA
         frknuMs8bGgBiiC8FwlyhiNbX+lKYQ70BvNG2aM3kfXJXMf/q09/RxHJBQ1Vc+yL4VS0
         uDpzhtwZlbXHWR/kIhsbJQYly37eahFNwEmpkHABmEXANR6w4a2q06VimecGYxQVCQdr
         uOZZ2mG2qM7apdnrQQG1yC2jhk7YD1KGw97HCfe9n3UMA43DzNivQy4e+nMTsBihSmqz
         1GNsL3wI7zaDmjiNRDBbOQ/T+k4BuzCNFdFexkV/rMf9tBJK1DLVIA/LrKbiEmGJE6/I
         wYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697253218; x=1697858018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ofkxnOmb7cqwZjJ5IHHNe3UaCC4MdflRYJIUEycODA=;
        b=Czf2WXVgdYQAFLt3X6pbTjyrTTa2Tn2Jyfv6BqnMr6DDmtQPj1RHPJNrkOSn1+TrNY
         MpyI5VBJqICEVj1mq5cWWJLnVxgLoyJLJy8bG3j6LOQF+A33iG1qj8h7wqVEKIQUSMWJ
         YrgPRsuzlEg3w7dedfhWmmcczeJiE8Op+5eUye9Iw/q8gkCbxgaQ9vG30fTnYjP9nX/n
         qBpa90PxkNKooS/XvclRPNP6amKF3QBJUWT8r3XxWYycWT7ZjaqhjkCYYygcPUP2XS6P
         oBgRdgaA3zzFv5H++OSFRZChLU1YjcX2YMpfSdq2vXZ9Qbvz9wGa44hdznLdWkCUgdgc
         G3/g==
X-Gm-Message-State: AOJu0YxDVrIlZFl+HY4Bi4V2rctlB3Z/CVxAh53/IehRCXMb+Ivx2vAC
	luJUR7e6+kCfreAk8h5JJsy2mIgbs5ey68a4csM=
X-Google-Smtp-Source: AGHT+IGzfPvW7n4zXQ/L7W7VDl+z9apG5TzXSlGDcTK6w8h/OWl5IvZCS14HavnGhFdm853zAIu4Tw==
X-Received: by 2002:a17:902:cec7:b0:1c9:9144:5740 with SMTP id d7-20020a170902cec700b001c991445740mr18656762plg.2.1697253218003;
        Fri, 13 Oct 2023 20:13:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b001c55e13bf39sm4632078plk.275.2023.10.13.20.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 20:13:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull-request: bluetooth 2023-10-13
Date: Fri, 13 Oct 2023 20:13:36 -0700
Message-ID: <20231014031336.1664558-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following changes since commit a950a5921db450c74212327f69950ff03419483a:

  net/smc: Fix pos miscalculation in statistics (2023-10-11 10:36:35 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-10-13

for you to fetch changes up to cb3871b1cd135a6662b732fbc6b3db4afcdb4a64:

  Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name (2023-10-13 20:06:33 -0700)

----------------------------------------------------------------
bluetooth pull request for net:

 - Fix race when opening vhci device
 - Avoid memcmp() out of bounds warning
 - Correctly bounds check and pad HCI_MON_NEW_INDEX name
 - Fix using memcmp when comparing keys
 - Ignore error return for hci_devcd_register() in btrtl
 - Always check if connection is alive before deleting
 - Fix a refcnt underflow problem for hci_conn

----------------------------------------------------------------
Arkadiusz Bokowy (1):
      Bluetooth: vhci: Fix race when opening vhci device

Arnd Bergmann (1):
      Bluetooth: avoid memcmp() out of bounds warning

Edward AD (1):
      Bluetooth: hci_sock: fix slab oob read in create_monitor_event

Iulia Tanasescu (1):
      Bluetooth: ISO: Fix invalid context error

Kees Cook (1):
      Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name

Lee, Chun-Yi (2):
      Bluetooth: hci_event: Ignore NULL link key
      Bluetooth: Reject connection with the device which has same BD_ADDR

Luiz Augusto von Dentz (2):
      Bluetooth: hci_event: Fix using memcmp when comparing keys
      Bluetooth: hci_event: Fix coding style

Max Chou (1):
      Bluetooth: btrtl: Ignore error return for hci_devcd_register()

Pauli Virtanen (1):
      Bluetooth: hci_sync: always check if connection is alive before deleting

Ziyang Xuan (1):
      Bluetooth: Fix a refcnt underflow problem for hci_conn

 drivers/bluetooth/btrtl.c       | 10 +++-------
 drivers/bluetooth/hci_vhci.c    |  3 +++
 include/net/bluetooth/hci_mon.h |  2 +-
 net/bluetooth/hci_conn.c        |  9 +++++++++
 net/bluetooth/hci_event.c       | 48 +++++++++++++++++++++++++++++++++++++++---------
 net/bluetooth/hci_sock.c        |  3 ++-
 net/bluetooth/hci_sync.c        | 26 ++++++++++++--------------
 7 files changed, 69 insertions(+), 32 deletions(-)

