Return-Path: <netdev+bounces-59965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43FE81CE8F
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 19:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7184C1F230E2
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 18:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA3E25744;
	Fri, 22 Dec 2023 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb+/ISgo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0E2C1A0;
	Fri, 22 Dec 2023 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35fcea0ac1aso11063345ab.1;
        Fri, 22 Dec 2023 10:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703270788; x=1703875588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQWm+4B4Ljk/As/8T5J23rurNpKRmasBUa+mEaqVW9s=;
        b=Sb+/ISgooBgu0Gna/gUn2wqlYkce/ctz3A2AXdBifHRDmZRSmwAj85l80cD57RUGIp
         a2cExS9XwIbFFOSwA1ITtD580iMuUv0nRaK0wq09Fo2K0UDxKYAunvCfFKsywsYRYTn1
         7uwDb35etr7zfnQ2u9Fr2JZ+oyfeMyg69HZNEqPtHFERRuYqTu+3Oeedn8FzFzQUVpco
         e+9JZs0nRM+b4vxny0kKxWy7zaycYP2pOQRYeU6N4Xwsflrzho3UisTNbZdFQzro6vZo
         bKYLaoLP46Vmkj9Op9QhPKjtktleZlTbRO6W4Hmigb5TyL9likwxYy94FUEXCd54yjtY
         PZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703270788; x=1703875588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQWm+4B4Ljk/As/8T5J23rurNpKRmasBUa+mEaqVW9s=;
        b=mpBI3yZl+nB3NB5j57blT2DRDFbkLaIkQso0tgy/DJqme/Kwnk4KscMkfCOleXT6wT
         VTn/UltRBgevDSV2HwUaWa3ySv0BdmkV/d+KMaUA7o5kYKwvK7GoYFsi8Jdzfr+/xNMY
         o3HLo750uA/5MTsIjP4xHB0OWT8SxR6J/aihhK46adf7l5USyJg7XQlg6TB3AZoW6z4P
         rteUOdrpMWPBKJeIl1jFfqHp9YgoFfaW3rNzImaaEhCG3w46W2bvN7L6F0WVGJmRtq8S
         tYV+tczKvSR2KqVSDotQxmBidyCqS7zfmXx+gSCwgINdjKM7wwlUAzFojX6TrJvDVIeA
         icxw==
X-Gm-Message-State: AOJu0YzbMZaIw8nUd4FxOfWcObAwU4RGjh6aCArXS1XgDXQ9TKYaXT2W
	S59KafYX4h2iyD8EmxRm/0U+s+ppXYA=
X-Google-Smtp-Source: AGHT+IH76t2rw/8DVfqQdmAIOA+Yapn5x3cuum+SjEp+nZc1QWQ5RwqJhvMoTtvHplzJQT/2FLrqgQ==
X-Received: by 2002:a05:6e02:348b:b0:35f:e7f9:baa7 with SMTP id bp11-20020a056e02348b00b0035fe7f9baa7mr475670ilb.72.1703270788412;
        Fri, 22 Dec 2023 10:46:28 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id d13-20020a81ab4d000000b005e71fbbc661sm2033263ywk.143.2023.12.22.10.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 10:46:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2023-12-22
Date: Fri, 22 Dec 2023 13:46:24 -0500
Message-ID: <20231222184625.2813676-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 27c346a22f816b1d02e9303c572b4b8e31b75f98:

  octeontx2-af: Fix a double free issue (2023-12-22 13:31:54 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2023-12-22

for you to fetch changes up to da9065caa594d19b26e1a030fd0cc27bd365d685:

  Bluetooth: Fix atomicity violation in {min,max}_key_size_set (2023-12-22 13:00:36 -0500)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - btnxpuart: Fix recv_buf return value
 - L2CAP: Fix responding with multiple rejects
 - Fix atomicity violation in {min,max}_key_size_set
 - ISO: Allow binding a PA sync socket
 - ISO: Reassociate a socket with an active BIS
 - ISO: Avoid creating child socket if PA sync is terminating
 - Add device 13d3:3572 IMC Networks Bluetooth Radio
 - Don't suspend when there are connections
 - Remove le_restart_scan work
 - Fix bogus check for re-auth not supported with non-ssp
 - lib: Add documentation to exported functions
 - Support HFP offload for QCA2066

----------------------------------------------------------------
Francesco Dolcini (3):
      Bluetooth: btnxpuart: fix recv_buf() return value
      Bluetooth: btmtkuart: fix recv_buf() return value
      Bluetooth: btnxpuart: remove useless assignment

Frédéric Danis (1):
      Bluetooth: L2CAP: Fix possible multiple reject send

Gui-Dong Han (1):
      Bluetooth: Fix atomicity violation in {min,max}_key_size_set

Iulia Tanasescu (3):
      Bluetooth: ISO: Allow binding a PA sync socket
      Bluetooth: ISO: Reassociate a socket with an active BIS
      Bluetooth: ISO: Avoid creating child socket if PA sync is terminating

Jagan Teki (1):
      Bluetooth: Add device 13d3:3572 IMC Networks Bluetooth Radio

Kiran K (1):
      Bluetooth: btintel: Print firmware SHA1

Luiz Augusto von Dentz (3):
      Bluetooth: btusb: Don't suspend when there are connections
      Bluetooth: hci_core: Remove le_restart_scan work
      Bluetooth: Fix bogus check for re-auth no supported with non-ssp

Yuran Pereira (1):
      Bluetooth: Add documentation to exported functions in lib

Zijun Hu (3):
      Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066
      Bluetooth: hci_conn: Check non NULL function before calling for HFP offload
      Bluetooth: qca: Support HFP offload for QCA2066

clancy shang (1):
      Bluetooth: hci_sync: fix BR/EDR wakeup bug

 drivers/bluetooth/btintel.c      |   5 +
 drivers/bluetooth/btintel.h      |   4 +-
 drivers/bluetooth/btmtkuart.c    |  11 +--
 drivers/bluetooth/btnxpuart.c    |   8 +-
 drivers/bluetooth/btusb.c        |   6 ++
 drivers/bluetooth/hci_qca.c      |  23 +++++
 include/net/bluetooth/hci_core.h |  26 +++++-
 net/bluetooth/hci_conn.c         |  51 ++++++++--
 net/bluetooth/hci_debugfs.c      |  12 ++-
 net/bluetooth/hci_event.c        |  11 +--
 net/bluetooth/hci_sync.c         | 106 +++------------------
 net/bluetooth/iso.c              | 197 +++++++++++++++++++++++++++++++++++++--
 net/bluetooth/l2cap_core.c       |   3 +-
 net/bluetooth/lib.c              |  69 +++++++++++++-
 net/bluetooth/mgmt.c             |  17 ----
 15 files changed, 386 insertions(+), 163 deletions(-)

