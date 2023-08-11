Return-Path: <netdev+bounces-26924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDC07797AA
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 21:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25D51C2178C
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 19:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB429E08;
	Fri, 11 Aug 2023 19:23:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB58468
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 19:23:00 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC3D2709;
	Fri, 11 Aug 2023 12:22:58 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc3d94d40fso20489155ad.3;
        Fri, 11 Aug 2023 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691781778; x=1692386578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jm7tacNX1/JBWSDzCVihz1ghkTJ7K+vcsQlyEKzbQdQ=;
        b=lRyGNMwFmN9hntaf4/ohl0C5+DjDkapl5/uNsKKL7wPcFd+7fTqaQauTThrndW8N4G
         zhWO4CKRc8LR9gZDq/0VBKZYq8LO6Y3rj2zMWgSgrOgiDORaEFb2QxlqP2MkO4r7rjie
         tDJrhe6tm6DOtJk9IdOm+a/7WKF0XOPCcuZOMI5jBfQwv9+13y3DoY2uBGRHTkzSV0+Z
         ifpugM9b1N9QLXpIRhyfsCJ1K04yl6/4gFQTYjZgwFBbnzuZC2AsDDxapZMmO/No5mi4
         zGAFdg1Z1pG+WZFv4Er/y5fX0ycekcVM/CEK6+7v37t7XTof8UBIf/2NL7tiKr0bCCjK
         x20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691781778; x=1692386578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jm7tacNX1/JBWSDzCVihz1ghkTJ7K+vcsQlyEKzbQdQ=;
        b=dULxtmJWx4BLNztw2iaPQiXADH6seXe+qNLKWcbAqKcI3BTLERYl6SCgkc//WR26Pi
         F2pAFGUTw+Gd8/0Ys9sFxHw7YrZ6h2m2JHpvLLgCr9AX5SJwL49GijEnoST5U0XAcxcf
         RVq1dwz6cSzBSEquIpUz1U/8gU6IS6dcoWi/neHuzfk594MO6jLqHpSxLGJeLS07H69X
         eeCq6B0/k+ZYgHOUArYOjKBDYkygYURg9uhKcXoCZWBDb0/ASGDcZzZv03uTja0pj1eS
         WoTRJIgJeesZNqY5g+B2R8+ODQVPKM0drC8+T3DpuWHk9b2aJiOr7bvqZdQtMHRWizxb
         xRFw==
X-Gm-Message-State: AOJu0YzIFdsPjCFxycWzweTkmi6760giWOwvFrIONbwvxJpWg6KKsLB8
	T9aX3JdAp1Oa7lyokDL6hofJeiQpuJ0=
X-Google-Smtp-Source: AGHT+IE5HfVIMOTrOJK451NhkHkObBptSXUa+l50LWWgkWOtrxOJe7oeNRNhUSg/e5gyeBncMvOthw==
X-Received: by 2002:a17:903:64b:b0:1bd:c6ca:e0db with SMTP id kh11-20020a170903064b00b001bdc6cae0dbmr774088plb.37.1691781778242;
        Fri, 11 Aug 2023 12:22:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902b61000b001b80d399730sm4285131pls.242.2023.08.11.12.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 12:22:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2023-08-11
Date: Fri, 11 Aug 2023 12:22:56 -0700
Message-ID: <20230811192256.1988031-1-luiz.dentz@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following changes since commit 80f9ad046052509d0eee9b72e11d0e8ae31b665f:

  Merge branch 'rzn1-a5psw-vlan-port_bridge_flags' (2023-08-11 11:58:36 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2023-08-11

for you to fetch changes up to b5793de3cfaefef34a1fc9305c9fe3dbcd0ac792:

  Bluetooth: hci_conn: avoid checking uninitialized CIG/CIS ids (2023-08-11 11:57:54 -0700)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - Add new VID/PID for Mediatek MT7922
 - Add support multiple BIS/BIG
 - Add support for Intel Gale Peak
 - Add support for Qualcomm WCN3988
 - Add support for BT_PKT_STATUS for ISO sockets
 - Various fixes for experimental ISO support
 - Load FW v2 for RTL8852C
 - Add support for NXP AW693 chipset
 - Add support for Mediatek MT2925

----------------------------------------------------------------
Chris Lu (5):
      Bluetooth: btmtk: add printing firmware information
      Bluetooth: btusb: Add a new VID/PID 0489/e0f6 for MT7922
      Bluetooth: btusb: Add new VID/PID 0489/e102 for MT7922
      Bluetooth: btusb: Add new VID/PID 04ca/3804 for MT7922
      Bluetooth: btmtk: Fix kernel crash when processing coredump

Christophe JAILLET (1):
      Bluetooth: hci_debugfs: Use kstrtobool() instead of strtobool()

Claudia Draghicescu (2):
      Bluetooth: Check for ISO support in controller
      Bluetooth: hci_sync: Enable events for BIS capable devices

Dan Carpenter (1):
      Bluetooth: msft: Fix error code in msft_cancel_address_filter_sync()

Douglas Anderson (1):
      Bluetooth: hci_sync: Don't double print name in add/remove adv_monitor

Hilda Wu (2):
      Bluetooth: btrtl: Add Realtek devcoredump support
      Bluetooth: msft: Extended monitor tracking by address filter

Iulia Tanasescu (3):
      Bluetooth: ISO: Add support for connecting multiple BISes
      Bluetooth: ISO: Support multiple BIGs
      Bluetooth: ISO: Notify user space about failed bis connections

Jing Cai (2):
      Bluetooth: btmtk: introduce btmtk reset work
      Bluetooth: btusb: mediatek: add MediaTek devcoredump support

Kiran K (3):
      Bluetooth: btintel: Add support to reset bluetooth via ACPI DSM
      Bluetooth: btintel: Add support for Gale Peak
      Bluetooth: Add support for Gale Peak (8087:0036)

Lee, Chun-Yi (1):
      Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO

Luca Weiss (2):
      dt-bindings: net: qualcomm: Add WCN3988
      Bluetooth: btqca: Add WCN3988 support

Luiz Augusto von Dentz (18):
      Bluetooth: Consolidate code around sk_alloc into a helper function
      Bluetooth: Init sk_peer_* on bt_sock_alloc
      Bluetooth: hci_sock: Forward credentials to monitor
      Bluetooth: hci_conn: Consolidate code for aborting connections
      Bluetooth: hci_sync: Fix not handling ISO_LINK in hci_abort_conn_sync
      Bluetooth: hci_conn: Always allocate unique handles
      Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH
      Bluetooth: af_bluetooth: Make BT_PKT_STATUS generic
      Bluetooth: ISO: Add support for BT_PKT_STATUS
      Bluetooth: btusb: Move btusb_recv_event_intel to btintel
      Bluetooth: hci_sync: Fix handling of HCI_OP_CREATE_CONN_CANCEL
      Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
      Bluetooth: ISO: Fix not checking for valid CIG/CIS IDs
      Bluetooth: hci_conn: Fix modifying handle while aborting
      Bluetooth: hci_conn: Fix not allowing valid CIS ID
      Bluetooth: hci_core: Make hci_is_le_conn_scanning public
      Bluetooth: hci_conn: Fix hci_le_set_cig_params
      Bluetooth: hci_sync: Introduce PTR_UINT/UINT_PTR macros

Manish Mandlik (1):
      Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_add_adv_monitor()

Mans Rullgard (1):
      Bluetooth: btbcm: add default address for BCM43430A1

Max Chou (2):
      Bluetooth: btrtl: Correct the length of the HCI command for drop fw
      Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C

Min Li (1):
      Bluetooth: Fix potential use-after-free when clear keys

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Add support for AW693 chipset

Pauli Virtanen (5):
      Bluetooth: ISO: do not emit new LE Create CIS if previous is pending
      Bluetooth: ISO: handle bound CIS cleanup via hci_conn
      Bluetooth: hci_sync: delete CIS in BT_OPEN/CONNECT/BOUND when aborting
      Bluetooth: hci_event: drop only unbound CIS if Set CIG Parameters fails
      Bluetooth: hci_conn: avoid checking uninitialized CIG/CIS ids

Peter Tsao (1):
      Bluetooth: btusb: Add support Mediatek MT7925

Rob Herring (1):
      bluetooth: Explicitly include correct DT includes

Roger Gammans (1):
      Bluetooth: btusb: Add support for another MediaTek 7922 VID/PID

Sai Teja Aluvala (2):
      Bluetooth: hci_qca: Add qcom devcoredump sysfs support
      Bluetooth: hci_qca: Add qcom devcoredump support

Sean Wang (1):
      Bluetooth: btusb: mediatek: readx_poll_timeout replaces open coding

Valentin David (1):
      Bluetooth: btusb: Add device 0489:e0f5 as MT7922 device

Ying Hsu (1):
      Bluetooth: Fix hci_suspend_sync crash

Yuanjun Gong (1):
      Bluetooth: nokia: fix value check in nokia_bluetooth_serdev_probe()

Yue Haibing (1):
      Bluetooth: Remove unused declaration amp_read_loc_info()

Ziyang Xuan (1):
      Bluetooth: Remove unnecessary NULL check before vfree()

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   2 +
 drivers/bluetooth/btbcm.c                          |   5 +
 drivers/bluetooth/btintel.c                        | 198 ++++++
 drivers/bluetooth/btintel.h                        |   3 +
 drivers/bluetooth/btmtk.c                          | 133 ++++
 drivers/bluetooth/btmtk.h                          |  42 ++
 drivers/bluetooth/btmtkuart.c                      |   1 -
 drivers/bluetooth/btnxpuart.c                      |  39 +-
 drivers/bluetooth/btqca.c                          |  13 +-
 drivers/bluetooth/btqca.h                          |  12 +-
 drivers/bluetooth/btrtl.c                          | 233 +++++--
 drivers/bluetooth/btrtl.h                          |  13 +
 drivers/bluetooth/btusb.c                          | 366 ++++++-----
 drivers/bluetooth/hci_h5.c                         |   2 +-
 drivers/bluetooth/hci_ldisc.c                      |   3 +-
 drivers/bluetooth/hci_nokia.c                      |   6 +-
 drivers/bluetooth/hci_qca.c                        | 164 +++--
 include/net/bluetooth/bluetooth.h                  |  11 +-
 include/net/bluetooth/hci.h                        |  11 +
 include/net/bluetooth/hci_core.h                   |  99 ++-
 include/net/bluetooth/hci_sync.h                   |   5 +-
 include/net/bluetooth/mgmt.h                       |   2 +
 include/net/bluetooth/sco.h                        |   2 -
 net/bluetooth/af_bluetooth.c                       |  53 +-
 net/bluetooth/amp.h                                |   1 -
 net/bluetooth/bnep/sock.c                          |  10 +-
 net/bluetooth/coredump.c                           |   3 +-
 net/bluetooth/hci_conn.c                           | 684 ++++++++++-----------
 net/bluetooth/hci_core.c                           |  34 +-
 net/bluetooth/hci_debugfs.c                        |   3 +-
 net/bluetooth/hci_event.c                          | 201 ++++--
 net/bluetooth/hci_request.c                        |  21 -
 net/bluetooth/hci_sock.c                           |  77 ++-
 net/bluetooth/hci_sync.c                           | 263 +++++---
 net/bluetooth/hidp/sock.c                          |  10 +-
 net/bluetooth/iso.c                                | 134 ++--
 net/bluetooth/l2cap_sock.c                         |  29 +-
 net/bluetooth/mgmt.c                               |  27 +-
 net/bluetooth/msft.c                               | 412 ++++++++++++-
 net/bluetooth/rfcomm/sock.c                        |  13 +-
 net/bluetooth/sco.c                                |  32 +-
 41 files changed, 2370 insertions(+), 1002 deletions(-)

