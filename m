Return-Path: <netdev+bounces-14339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A1B7403CD
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 21:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC663281142
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 19:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6B74A26;
	Tue, 27 Jun 2023 19:10:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A41FC4
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 19:10:08 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AE9FD;
	Tue, 27 Jun 2023 12:10:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666edfc50deso143009b3a.0;
        Tue, 27 Jun 2023 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687893006; x=1690485006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X027yh/r9JwHRCGkoovD51WQvCd3gcUGQ2TPC2PVuLc=;
        b=ODJco3W6O0fZXPOdmsLJAIVJfTPQr248Ekj/CCcQLJtzzWbJbveYP5OD8V+WSRm9CQ
         +RJej4uibvc+kpRY05kMsHENyXwaO5u1qds4I2UCfs3leyJgJOYOPfX6F5X0W0TKmRm5
         enS0m9Vapf9ts4rBDUpdQI60rOKhYhghNda00vpcHL2v/KLK1TxmmJkYBQwphpRSa2Is
         3aDzpjuJWBf0OgtiNHLtXXIb/1Im35BN66+IL6TM4RueRuiu6L3I+Xj86mdLa5JaTs2w
         ZsNhe9HUrbyq0BdC1xu2/knBVtGgcI0xhtvQTdm2NpRa6wtCeNr3JIRaEJ5nNUNQoQJi
         5evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687893006; x=1690485006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X027yh/r9JwHRCGkoovD51WQvCd3gcUGQ2TPC2PVuLc=;
        b=iyG1kL+JTG41x4kSy7HgyrErFTJrC4Gnjk9UPe9NQ6TUnmdwJqb5FF2+H5mrcZP5hJ
         6ET17mhps92pP3B3aA32u+UHjEEpL6CuH4/t8pCxkIZaXpeXjmIx0oYkCNt7ieqUUOx1
         VfaKDVl8KAvV+J8hz5cO3zh7kB3+NER1kg4XejGgiL18jkmxjK53NyCKCmBQN1CFo9YQ
         UhoY8vxLzKQLX4vUUDEpoTmItY3ZOAqKPNeRS8Fq6Ay2izntuVpnL2hR8vxv6vUXgyBI
         xj+znewW8WE2mXtBlAtTDhCWByNNcOqb3E/ivI/5kXHbyfmlxrrTO9LGk9BWBQ/aq8VH
         dpDA==
X-Gm-Message-State: AC+VfDxM489FnQZRibwt1iwoDs25hmufYqaqUwJB5/KXkK+UXeMQ6sRQ
	uRkfEotJoVnP0i4zKiNLoXt7aEL0yZgpAi4k
X-Google-Smtp-Source: ACHHUZ66aZUoM6biv8pXSVCJi7fQDAP6qeJ1wGLKWfT74dVOsuJvM3vd0L05JhfPmJuzm5c/7g0zOw==
X-Received: by 2002:a05:6a00:a23:b0:656:c971:951 with SMTP id p35-20020a056a000a2300b00656c9710951mr58984372pfh.8.1687893006485;
        Tue, 27 Jun 2023 12:10:06 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id z19-20020aa785d3000000b00679efed4108sm3032851pfn.33.2023.06.27.12.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 12:10:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2023-06-27
Date: Tue, 27 Jun 2023 12:10:04 -0700
Message-Id: <20230627191004.2586540-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following changes since commit ae230642190a51b85656d6da2df744d534d59544:

  Merge branch 'af_unix-followup-fixes-for-so_passpidfd' (2023-06-27 10:50:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2023-06-27

for you to fetch changes up to e63d8ed98082395ca509163f386f5b04f53872b3:

  Bluetooth: msft: Extended monitor tracking by address filter (2023-06-27 11:52:58 -0700)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - Add Reialtek devcoredump support
 - Add support for device 6655:8771
 - Add extended monitor tracking by address filter
 - Add support for connecting multiple BISes
 - Add support to reset via ACPI DSM for Intel controllers
 - Add support for MT7922 used in Asus Ally
 - Add support Mediatek MT7925
 - Fixes for use-after-free in L2CAP

----------------------------------------------------------------
Claudia Draghicescu (1):
      Bluetooth: Check for ISO support in controller

Dan Gora (2):
      Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations
      Bluetooth: btusb: Add device 6655:8771 to device tables

Hilda Wu (2):
      Bluetooth: btrtl: Add Realtek devcoredump support
      Bluetooth: msft: Extended monitor tracking by address filter

Iulia Tanasescu (2):
      Bluetooth: ISO: Add support for connecting multiple BISes
      Bluetooth: ISO: Support multiple BIGs

Ivan Orlov (1):
      Bluetooth: hci_sysfs: make bt_class a static const structure

Jiapeng Chong (1):
      Bluetooth: hci_conn: Use kmemdup() to replace kzalloc + memcpy

Johan Hovold (3):
      Bluetooth: fix invalid-bdaddr quirk for non-persistent setup
      Bluetooth: fix use-bdaddr-property quirk
      Bluetooth: hci_bcm: do not mark valid bd_addr as invalid

Kiran K (1):
      Bluetooth: btintel: Add support to reset bluetooth via ACPI DSM

Luiz Augusto von Dentz (6):
      Bluetooth: Consolidate code around sk_alloc into a helper function
      Bluetooth: Init sk_peer_* on bt_sock_alloc
      Bluetooth: hci_sock: Forward credentials to monitor
      Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable
      Bluetooth: ISO: Rework sync_interval to be sync_factor
      Bluetooth: hci_event: Fix parsing of CIS Established Event

Matthew Anderson (1):
      Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally

Max Chou (1):
      Bluetooth: btrtl: Correct the length of the HCI command for drop fw

Min-Hua Chen (1):
      Bluetooth: btqca: use le32_to_cpu for ver.soc_id

Pauli Virtanen (6):
      Bluetooth: ISO: use hci_sync for setting CIG parameters
      Bluetooth: ISO: do not emit new LE Create CIS if previous is pending
      Bluetooth: hci_event: fix Set CIG Parameters error status handling
      Bluetooth: use RCU for hci_conn_params and iterate safely in hci_sync
      Bluetooth: hci_event: call disconnect callback before deleting conn
      Bluetooth: ISO: fix iso_conn related locking and validity issues

Peter Tsao (1):
      Bluetooth: btusb: Add support Mediatek MT7925

Sai Teja Aluvala (2):
      Bluetooth: hci_qca: Add qcom devcoredump sysfs support
      Bluetooth: hci_qca: Add qcom devcoredump support

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb

Zhengping Jiang (1):
      Bluetooth: L2CAP: Fix use-after-free

 drivers/bluetooth/btintel.c       | 121 +++++++++++
 drivers/bluetooth/btintel.h       |   2 +
 drivers/bluetooth/btmtk.c         |   1 +
 drivers/bluetooth/btmtk.h         |   5 +
 drivers/bluetooth/btqca.c         |   2 +-
 drivers/bluetooth/btrtl.c         | 181 +++++++++++++----
 drivers/bluetooth/btrtl.h         |  13 ++
 drivers/bluetooth/btusb.c         | 173 ++++++++++++++--
 drivers/bluetooth/hci_bcm.c       |   3 +-
 drivers/bluetooth/hci_qca.c       | 150 +++++++++-----
 include/net/bluetooth/bluetooth.h |   5 +-
 include/net/bluetooth/hci.h       |  11 +
 include/net/bluetooth/hci_core.h  |  45 ++++-
 include/net/bluetooth/hci_sync.h  |   2 +-
 include/net/bluetooth/mgmt.h      |   3 +
 net/bluetooth/af_bluetooth.c      |  45 +++++
 net/bluetooth/bnep/sock.c         |  10 +-
 net/bluetooth/hci_conn.c          | 315 +++++++++++++++++------------
 net/bluetooth/hci_core.c          |  38 +++-
 net/bluetooth/hci_event.c         | 190 ++++++++++++------
 net/bluetooth/hci_sock.c          |  77 ++++++-
 net/bluetooth/hci_sync.c          | 265 +++++++++++++++++-------
 net/bluetooth/hci_sysfs.c         |  14 +-
 net/bluetooth/hidp/sock.c         |  10 +-
 net/bluetooth/iso.c               |  97 +++++----
 net/bluetooth/l2cap_core.c        |   5 +
 net/bluetooth/l2cap_sock.c        |  31 +--
 net/bluetooth/mgmt.c              |  32 +--
 net/bluetooth/msft.c              | 412 ++++++++++++++++++++++++++++++++++++--
 net/bluetooth/rfcomm/sock.c       |  13 +-
 net/bluetooth/sco.c               |  10 +-
 31 files changed, 1753 insertions(+), 528 deletions(-)

