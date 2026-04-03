Return-Path: <netdev+bounces-274919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNX+GGpuz2kTwQYAu9opvQ
	(envelope-from <netdev+bounces-274919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:38:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9EF391C60
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EE063003702
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BBB37700B;
	Fri,  3 Apr 2026 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FfZpuzHx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC0361DA8
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201892; cv=none; b=iCT0dssRgsbOivVoB+vQcvdcsyYB0c679brXv25ziUriIFdhPnYaQVeMaMsz6aHRwodPhsX/B9fyMwcK/gYyM4/+8uVtiH3tTkyqZ7Cyea4yavxz677yIZpIqcNtL6uq3qDkc+GMIFh3SkLhrxwDJUj7J9E3JTH5IG8K582wppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201892; c=relaxed/simple;
	bh=V1YmppFg4FnVUNz4ZeM55kmWkU2HasfKyCL0+jpNdDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7HT0Aa2WEkrqCpXMsHIiA3Tp5eLZjch93HgNcIzDtaJJYMxkYu5Asduix51m0PdxzdDnBlkePsQBg/cjsKAaabPT8suIH94my6Xc9VMwEtw99z7hOYdvNrq7MgYbbEBhXs5yGK4wPnLTckLcHxgQwAJsi16daCsdEOBTvQl3ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FfZpuzHx; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-60591ade110so971555137.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775201889; x=1775806689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BNtHqtLw5ckmEhvmlkHbzxynbSh6+tjjVefO92JXO4=;
        b=DDhaBcURmFnigLMQRVSZtSB6szNA2PjstyKriGjuQ1SNyjSWvnOM0IUCJYVdyUnISa
         /x6FJ4zrZwhlz1DP3F3UJE8LcfbbdZogJMixM0qdAbxzwtHveu0uP1CKOdzco1QbN+3x
         U+J78FtDXO81rlXlTgZjDIO5rbV0Yb6jT5yO7SeyRJbSIg8Ek7qtz7nAF9Yj7wOOoji+
         OcCx+7uzZ1SspxshYQzZ6iO7c0yyRi7WhHOCDdnd/dIK+eJew3H1G/x74RXXAoR1gr6z
         mxd3uNOXtoot7cRbuOqTU+jTdXY59SQnWhY/Vd7z4ySLACYcAZ+nAa0t8Y0rsabBDBBm
         +gOA==
X-Gm-Message-State: AOJu0Yye3o9lTACx4Mx63mtesPq9QNq4j5fHxI/UVEEUd7ESdu07uDGA
	pPdU1Z4feJeGfEeSaBUNeCXHqbn+ulgRhDXsxn8ICzAVDBqCE7kko4jMO6YNsKtF/j5gGrNFY19
	CXy1j1yukeSxwGWJRxjBr1oHRJYnuERQdWyQWXcX5K2rCCgDJEOUd6Hufw2ro5/m4jpkBJZ8n05
	Z3Ztf0nKNRhW8ROs1nrEafdw5aVpgP5HLBAj6rs8KtFEr762DO/M0pKfbWRuA/ZZAnL33pxoGDZ
	mVKAxM0En448uUuXA==
X-Gm-Gg: AeBDievigDRwXhgAjW7GxeS7rvZ9SOpz0qeYi+fbHgaFVssQ0D51s6wa5HBkk2TgbEm
	c965LHUR7NkC7uBnPuV1JM0gHtg+wHJBY5tMUzXN2JoiCz22AD8kGKh1CGthxp2Yi7nNzzJIdbn
	2CwkxrB7LXdQXi40m8Nyv30uQpCt3y4k6RH25AsBkzDE0G6OO7rdRirV0OwmbByCWZGOwfjbLYF
	UGNEG2v8oQCbUYttRK8ExP042qfPNxzkz2yaTbEt4oUT7JJB3bVS6FuIpDCI2mNrRX+QO6w6SoB
	lOelNO0MXcHy8BhSoS5tX/93FPMVZqMhrpaGV8qzkVHSB+pRItNn9AFCNuKbG+f7vG03qBCgb29
	q8DgT0pcamsLXf99N2mLDZjvRwiVu8p02KhAcw4iVB1grmz+U/y68P0Q3oK2GaAMi3xO+GSkPBz
	292M/nNFObss4Mj08alhf2cA8C32ZC+XCzFy6w+wyrOOJK9jxyOkv2QnueeXvwDCs=
X-Received: by 2002:a05:6102:6043:b0:604:f640:301e with SMTP id ada2fe7eead31-605a4e0219cmr768114137.12.1775201889080;
        Fri, 03 Apr 2026 00:38:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-60582da96a1sm409868137.2.2026.04.03.00.38.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2026 00:38:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35da99b90f6so2043808a91.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775201888; x=1775806688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2BNtHqtLw5ckmEhvmlkHbzxynbSh6+tjjVefO92JXO4=;
        b=FfZpuzHxv/C6yof4R5hEm/8Ewu7SSv7D9b0gp1mMjIa8A83zxVNMa3qCMQx8j4S9Bl
         QRd7PshnTMWgT4pWLsgKcZPJ2eEGOyS3QHkq9R/WN2ml3F/d8U+a7QDNR8QzE7wYWIDA
         2mDzvNAyaXPMGmUHfCyWCEltdpU69hQmDbANI=
X-Received: by 2002:a17:90b:2691:b0:35b:ea35:c3d7 with SMTP id 98e67ed59e1d1-35de668a0f8mr1693747a91.0.1775201887515;
        Fri, 03 Apr 2026 00:38:07 -0700 (PDT)
X-Received: by 2002:a17:90b:2691:b0:35b:ea35:c3d7 with SMTP id 98e67ed59e1d1-35de668a0f8mr1693723a91.0.1775201887022;
        Fri, 03 Apr 2026 00:38:07 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm13124901a91.10.2026.04.03.00.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 00:38:06 -0700 (PDT)
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
Subject: [PATCH net-next v11 00/10] bng_en: add link management and statistics support
Date: Fri,  3 Apr 2026 13:07:14 +0530
Message-ID: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274919-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E9EF391C60
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

v11:
 Addressed the ~30% valid issues from the Sashiko AI review (Paolo Abeni)
  https://sashiko.dev/#/patchset/20260327201343.16146-1-bhargava.marreddy%40broadcom.com
  - Avoided kasprintf+kfree in workqueue creation
  - Added timer_shutdown_sync() to ensure no use-after-free
  - Clear force_link_chng conditionally in bnge_hwrm_set_pause()
  - Fix REQ vs RESP macro for auto_pause_setting
  - Ensured baseline (and _ext) stats are fetched even if mask query fails
  - Persist port stats across close/open by moving allocation to probe
  - Use u64_stats_sync for 64-bit counters to ensure atomicity on 32-bit archs
  - Replaced RCU/flags with spin_lock_bh to protect get_stats64 and close_core
  - Include hw drop stats on base_stats callback
  - Added comment in hwrm_phy_qcaps() explaining why 0-speed reports are ignored

v10:
 Addressed the issues reported netdev Checks
  - Removed an unused variable.
  - Removed inline functions from .c files.

 Addressed the issues reported by netdev AI 
  - Removed an unused macros & function parameters.

 Addressed the issues reported by AI 
    https://sashiko.dev/#/patchset/20260324200740.346029-1-bhargava.marreddy%40broadcom.com
  - Updated the commit log to accurately reflect slow-path tasks.
  - PAM4-112 support related issue.
  - Sync pause autoneg during interface up. 

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
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  732 +++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  407 ++++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    8 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 1313 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  201 +++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  675 ++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   94 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |   35 +-
 11 files changed, 3462 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h

-- 
2.47.3


