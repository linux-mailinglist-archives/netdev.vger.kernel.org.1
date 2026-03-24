Return-Path: <netdev+bounces-271272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKn0JJTwwmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:14:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9776731C2E6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE2CB3028C35
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8298324B24;
	Tue, 24 Mar 2026 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZyTAxi0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508031F983
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382901; cv=none; b=f4bom15N7BvfP0kmWHzVTzXCpQuAFPHO17GfegltO9Xyv11DyO0HVoKfyfsXuDCfesKPdzldU2AI2dof+UcIF6pqbpz2WcVR1ER0UDvchkzIMff7C0fKfXQRerqSaT22Q8qMdP9NETGC9Zz+NAOqUfa8AgSk94c3xjk0IVoZGOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382901; c=relaxed/simple;
	bh=ZeptcYbG9MsXjUNNFjVFQmBiHQ/D8w34E52Z77duuPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sgpw5M4lAdvlB5NSpAIHDt2XotBy58btvytlXypuImOMoGhcJDxOKReBvxGUjBXBoorj5JSyiv1j/HpIg0SIiIParcadOkTT+Z6EOg4jrrV38+he4fkXJTjqVpfRz+9p3J2HUTY+5xen/+5zqYT3AoNb7nizoEsjNbqEy4tvwEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZyTAxi0s; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-899a5db525cso12643806d6.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382893; x=1774987693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoR7Vx4ovXdcZj6KF9rbg1FT/jbdp+GBkwZsxj20ov4=;
        b=H+JX9QkAAh0HSeVrG133FU0O8IQj9auW71Gcgr/aKJl0OnBqoQR6BcK2mMIljCZXod
         uBGyC76inyIwdOz4ys3Do+7Ul07X3E0u2KG8wiHCfkUmGvjasrnMKT3HRJC86GYXmIIw
         0ek2vW8OUbnOIx2nBxQkI3qsV26gA+HUNlcCSSFVO2UF/onau/fmePAQuRN6pKT8ZlWc
         qW8SeYrSUO6f8SLlmk4CcsNGnp51luDTweCL9fOrLvO5GN/nbxO08m5nG5dYOYurZuP3
         94UvaMrMYLyXJdnM4ODOYYojnepRaqeyenXaUWAngC+2JjzSOULLWThij+p0cykHXN/g
         gKNw==
X-Gm-Message-State: AOJu0Yx30jGE0lPxZNFt4jSO2lkfcfCq9i2ZHuIWXcQRdkinIhOPpbQA
	5MbbdMDc7KdWD9RMH31QQjhPEc0T7mSEfR5ixBPDybN5JF7ndKXNIOYBxqPB9dA7jQ3UHjjE+5b
	LEJRQeoa0L1LdFRveBwV+kSqXwYYJ9HCwAZb1OW7vZMm3DdzyjrVBTdjkllHPmo6PPWy3GcybUI
	8i6oVpvEc/4BgNqK3Bo9JuWrAqR3T++fHp/k2UrnC+0wfks2ESNeDrSogQ1wbQdlhyN5d/X33uo
	1wknG3Tu2F4QoNn8w==
X-Gm-Gg: ATEYQzyzmV+tNLChmdyIiPR1u4FYi8El8ObOZcUGIub0jp7yWNo4ph7wougM2CMyaCc
	nPw/Mfkfyuyoe2gniHSQGwfp7sipXvWucbocLlaysxa64sEDtprtr/fd4lxGqgDwfFXZKtptF3t
	lEZJhho+FMVDcXs3/WE2ZenBbsxl1H6cpX2gDKqAoHhaOMnwljgaLuBBqOQJz//HqLPX1o9itdI
	f6f5LD+YMyT9aNyDpd4RjaJFWh57auJFcbbdOdj9UkRula0Fdek19u6bMvM8oHuY9GLstidigxM
	OBlsIjwfQx3+dyO1mKCn4Q58B6JQA8iaLTyMowX6ympPCNr5fk/7Iq/6/lzbwD1VunSFhu1tNmm
	PH1MEAVQacJaajKl9u9+yeqKx0dq3mEwV+40VeYnq7RPJAxAw5l2jXTX3EbDu+wEiU/db23DmC7
	6cXzW1AZT4tvf08iTZAvkip9MEVHnuQPwtHDj97yBxguE2BN4DNVXd5TeuSwoLgCCjFA==
X-Received: by 2002:a05:6214:2f0f:b0:89c:5d56:bcac with SMTP id 6a1803df08f44-89cc471dcf8mr16745176d6.0.1774382892393;
        Tue, 24 Mar 2026 13:08:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89cc1e2077esm1319926d6.28.2026.03.24.13.08.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2026 13:08:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c629a3276e9so5127738a12.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774382891; x=1774987691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eoR7Vx4ovXdcZj6KF9rbg1FT/jbdp+GBkwZsxj20ov4=;
        b=ZyTAxi0sMiLmMLNq3Cvn1s+stgzXTfL1U/Szxd3FAFCg9XUUOnPzWn5e+na1NR92iQ
         f2UAIj2mbaek5BmaGum3fa9wnkr/j4VSkwHqVVKoXRbvR+ZgNETTILzIP816sVeG67YP
         MryMPz1YpbpnIZO9aFVSyLlHCL9vsQbDyehjY=
X-Received: by 2002:a05:6a20:7d9e:b0:398:a1ca:7a2a with SMTP id adf61e73a8af0-39c4ade23d0mr998206637.48.1774382890872;
        Tue, 24 Mar 2026 13:08:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d9e:b0:398:a1ca:7a2a with SMTP id adf61e73a8af0-39c4ade23d0mr998187637.48.1774382890410;
        Tue, 24 Mar 2026 13:08:10 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a80163bsm9930057a12.1.2026.03.24.13.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:08:09 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net-next v9 00/10] bng_en: add link management and statistics support
Date: Wed, 25 Mar 2026 01:37:30 +0530
Message-ID: <20260324200740.346029-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271272-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,broadcom.com:dkim,broadcom.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9776731C2E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series enhances the bng_en driver by adding:
1. Link/PHY support
   a. Link query
   b. Async Link events
   c. Ethtool link set/get functionality
2. Hardware statistics reporting via ethtool -S

This version incorporates feedback received prior to splitting the
original series into two parts. 

 Addressed following comments from Andrew Lunn
   - Apply Rev-xmas fix in several places.
   - Correct ethtool-speed comment to reflect accurate behavior.
   https://lore.kernel.org/netdev/49930724-74b8-41fe-8f5c-482afc976b82@lunn.ch/
   https://lore.kernel.org/netdev/CANXQDtb5XuLKOOorCMYDUpVz6aFuQgvmQZ4pS6RJGkAgeM8n1A@mail.gmail.com/

 Addressed following comments from Jakub Kicinski
   - Took care of missing mutex_init()
   https://lore.kernel.org/netdev/20251127190855.69779791@kernel.org/#t
   https://lore.kernel.org/netdev/CANXQDtYy2JziaaVi=Cqt+gAJNt4NjFFs8NbhrS=RBV61ORwinA@mail.gmail.com/

 Addressed following comments from ALOK TIWARI
   - Add newline for clarity/formatting.
   https://lore.kernel.org/netdev/CANXQDtZbLhdwEtN+kKg1OVLV+uy-gsNfX+rU4MR77QPuO6_y9A@mail.gmail.com/

v9:
 Addressed the issues reported by gemini-3.1-pro-preview (Jakub Kicinski)
  https://sashiko.dev/#/patchset/20260319055124.1350670-1-vikas.gupta%40broadcom.com
   Patch 2:
    - Fixed format specifier for vendor part number (%.16s).
    - Fixed early return skipping PAM4 speed validation.
    - Added READ_ONCE/WRITE_ONCE to prevent context races.
   Patch 3:
    - Added missing PHY_FL_NO_PAUSE check in nway_reset.
    - Excluded 50G NRZ support.
    - Fixed uninitialized advertising field.
    - Fixed bnge_update_speed() XOR logic dropping valid speeds.
    - Fixed 100G/200G lanes for PAM4-112 single-lane requests.
    - Fixed SPEEDS2 fallback using wrong legacy mask.
    - Added rollback of eth_link_info on HW failure.
   Patch 4:
    - Fixed missing rollback of elink_info on hwrm_set_pause failure.
   Patch 5:
    - Fixed big-endian async event bitmap using u32 array.
    - Fixed data race on elink_info in softirq handler.
    - Fixed race where LINK_CFG_CHANGE processes stale PHY caps.
   Patch 6:
    - Fixed BNGE_FW_CAP_EXT_HW_STATS_SUPPORTED flag mismatch.
   Patch 8:
    - Fixed stats drop race by reordering BNGE_STATE_OPEN and net_stats_prev.
    - Fixed ordering of clear_bit and net_stats_prev save.
   Patch 10:
    - Fixed tx_nr_rings mismatch causing potential heap overrun.
    - Fixed min_t(int,...) signedness mismatch in get_num_stats.

   Items deemed invalid:
    - Patch 3: rtnl_lock/netdev_lock interaction.
    - Patch 7: Use-after-free during teardown.
    - Patch 8: Port stats not saved on close (hardware retains stats).
    - Patch 9: Teardown race in get_queue_stats_rx (held netdev_lock).
    - Patch 9: TX queue index bounds and double-counting.
    - Patch 10: Standard counters via ethtool -S (hardware-specific).

v8:
 - Fix the smatch warnings reported by Dan Carpenter
    https://lore.kernel.org/r/202603180509.nOQGZrG0-lkp@intel.com/
v7:
 - Addressed the two valid issues reported by AI (Jakub Kicinski).
 - Fixed minor issues reported by Alok Tiwari.
 - Addressed the concern of statistics duplication raised by Jakub
   Kicinski. A few statistics (discards/errors) have been made part 
   of the standard netdev statistics and removed from ethtool -S.
   Additionally, a few statistics that require proper implementation
   have been removed and will be addressed in a later series, for example,
   get_pause_stats and get_fec_stats.
   https://lore.kernel.org/netdev/20260312192251.61243873@kernel.org/#t

v6:
 - Resending the full series due to an SMTP failure during v5
   submission.
 - No functional changes from v5.

v5:
 Address Jakub Kicinski's comments by holding the instance lock across
 the entire service task (instead of flag-based locking) and checking
 the OPEN bit under the lock to resolve the close-path deadlock. 

v4:
 Addressed comments from Jakub Kicinski:
  - Explicitly size speed mask arrays to remove the need for manual
    sentinels in the hardware configuration.
  - Fix an off-by-one error in the queue index bound check.
  - Standardize ethtool -S per-ring stat naming to "rxq$id_$name"
    (e.g., rxq0_errors). Removed spaces and brackets to ensure
    compatibility with parsing scripts.
  - Exclude ethtool -S global counters (tx_err, tx_fifo_underruns,
    tx_total_collisions) already covered by rtnl_link_stats64.

v3:
 Addressed comments from Andrew Lunn:
  - Fix a comment and refactor bnge_hwrm_set_pause() 
    to improve code readability.

 Addressed comments from Jakub Kicinski:
  - Switch to RCU for stats synchronization and drop the 
    BNGE_STATE_READ_STATS state bit.

 Fix checkpatch warning by switching to kzalloc_node(). 

v2:
 Addressed comments from Andrew Lunn:
  - Add implementation for .get_pauseparam and .set_pauseparam to
    support
    a full flow control configuration, covering global autoneg,
independent
    pause autoneg, and forced RX/TX pause functionality.
  - Move MAC, PHY, Control, Pause, and RMON statistics from
    .get_ethtool_stats to their respective structured ethtool
    callbacks (e.g., .get_eth_mac_stats, .get_rmon_stats).
 
 Addressed comments from Jakub Kicinski:
  - Fix potential out-of-bounds read in speed mask array by adding 
    the missing sentinel.
  - Simplify timer synchronization by removing the redundant intr_sem.
  - Replace link_lock with the netdev instance lock, as it is sufficient
    to handle the required synchronization.

v1:
https://lore.kernel.org/all/20260223163641.755200-1-bhargava.marreddy@broadcom.com/

Bhargava Marreddy (10):
  bng_en: add per-PF workqueue, timer, and slow-path task
  bng_en: query PHY capabilities and report link status
  bng_en: add ethtool link settings, get_link, and nway_reset
  bng_en: implement ethtool pauseparam operations
  bng_en: add support for link async events
  bng_en: add HW stats infra and structured ethtool ops
  bng_en: periodically fetch and accumulate hardware statistics
  bng_en: implement ndo_get_stats64
  bng_en: implement netdev_stat_ops
  bng_en: add support for ethtool -S stats display

 drivers/net/ethernet/broadcom/bnge/Makefile   |    3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   12 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  732 ++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  397 ++++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    8 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 1285 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  204 +++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  606 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   88 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |   35 +-
 11 files changed, 3351 insertions(+), 20 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h

-- 
2.47.3


