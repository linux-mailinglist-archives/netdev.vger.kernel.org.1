Return-Path: <netdev+bounces-272669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGdJN73nxmloQAUAu9opvQ
	(envelope-from <netdev+bounces-272669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:25:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8377C34AEB8
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5873330A41CB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229283B0AF8;
	Fri, 27 Mar 2026 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MAiJuc04"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC9C3A7597
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642482; cv=none; b=qYDiEiEGTnyswgLnfSizIe83S8cX0pqkRiKERSSz6XxyImxk25fPlxsN8AtcjIukN+r1NEGRLUhTi64ymMXPumW59tvYCz8aku0HYxi5KDEYLLkrP5UtwqyStiKNlt5c6wj9HW7+fSu+5c+ip4Yhni0LIAiRhsOBLpoSL2TuQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642482; c=relaxed/simple;
	bh=+T7296dqtybnaIqS8K9DXR9v604biCijLCvMPwnM9gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+qyY1hFsrn1tFN6XTWzD3jBVjB/CiC9IGCvyq11RuZ+QiYOzaTBEa+bqL3kI1DYK+U4IOXmKlTvpqu8fb+TzkBNSeYO3P/BKc9C/Al71NTgTK20hAXx6vhHGGUSEpo6+rCI68eUjokh20/TUkGHpr5G7V13Cht7pcbaVT1r9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MAiJuc04; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-89a465bd7edso20989576d6.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642478; x=1775247278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsa47GaJJ1pUHa7n3Bjl56NeGj+Eugeo7aiXfhMxHsc=;
        b=OXBRTn7TV6QluRMqhY+hV/qhYcvjM+/qncX6KhknOY9LB7nRWPC9XqCQ1EvSfkuc5n
         JfFhJhMSwHCcm52O1dVTgkw99jSAweK4cRI/E+Se+8d2j/XKASKznZ/PnxwdQI/doNtf
         +ZZACttF3o1GZJvz78aBkHQ39xPhncRsZiKRlDsOtAVHjTV8IbYqbkQjuX3fxDuSxptw
         Hwmr+PKg25Eepo7g4trSPmACqUJGzk8dr2SXU72I3WGTqBbfWFjT9PAbhHj4C2kqQZVk
         AGVJgNIGf1Uq9xz7ITscrwKmn84B0XKZa2Kkvv6K5Wmtwa95uDGItcMXkgE2VZJ4Fs2A
         xFIA==
X-Gm-Message-State: AOJu0YwPETNQj/GACVb0uG+zrDseqKynWJ2p9UE1BbNa8TxRnU0bqYwh
	CYuuS75TYvSE3XlR24JMaN+Orm80KhXy8zwnA8TkCTyF+r23B0vpz7iSaJYQY44oShH7S2yw9x2
	RNNVQXKCBtlG3x3bpt7bHLqfWU7s38GUoym9h2pGZvrkSSYrzsKMzWVQAiQEPfKceRfPmiYlWcU
	zYaUAIklEnPbI8oTRVNtWV6eVunSHQV19fCD3jXhm+ya0u7bMbHgrMjVWIKxXmTxgrKTpBq/K2Q
	VZQvl6Cp01O3tWpga/a
X-Gm-Gg: ATEYQzx62mU6NVsfN5eQWgzu5AxPEVWgZu5kfu8nRZ7xK4XhrlntRWs0iD0FuR94v2E
	4Akkx6hzjSN/EmaqCvxlt199ctiqXLWZBp4gu8CyOJlMvo2oCDpEsgB2Y6VJbM9T1W2yaUrXbaf
	flrYsFSPWlLMGZctvUoUcfnezeW8ES9mnCqKpFNtjulc4Cd3NAXUbNfQitgU8RqnAuOkZtgrFHJ
	lKbzMU8uE+8s6kx3vUUWlzAtt+yzLCjTOtugCCgl1LD+SrjMZvNrCsrSx0F7mIKZ4Bu5B+itmXw
	6Ls5dYv8nss9WsfjbH8JdukfncZplUfoFrDvJH6KV8DoyJ7BzNhaqAnOheqEENl3nFZB4JFXc2k
	kopNRRi1fZbYCJSUn6QquZOXszzXc9en3pPTXZB2e7rxMNWFj4ID29Qwr+igUEazXEqsg54o9RW
	BYxnfD3KOb1uQ=
X-Received: by 2002:a05:6214:4ecf:b0:899:f829:e8b9 with SMTP id 6a1803df08f44-89ce8d9a465mr51881226d6.23.1774642477709;
        Fri, 27 Mar 2026 13:14:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89eca544ab1sm157806d6.6.2026.03.27.13.14.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 13:14:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-799001d77fcso55730517b3.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774642477; x=1775247277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wsa47GaJJ1pUHa7n3Bjl56NeGj+Eugeo7aiXfhMxHsc=;
        b=MAiJuc04PEt+1tGwkQuGdzDJNUlhU0zMviTnAC2jLeblMgnCwQawpRaELviYQD2zQg
         teoYOYe7TmSMeYrqk/QdKepgwFTYTKgn0AAr3tiL5iFU6+HMW85/BKsjFzS5gS8TKYqW
         14nQCL9uw/g9CD5ja1LKnKr36e5nhz7j9sgNU=
X-Received: by 2002:a05:690c:c509:b0:794:6fa2:a037 with SMTP id 00721157ae682-79bddcd8026mr39878587b3.8.1774642476605;
        Fri, 27 Mar 2026 13:14:36 -0700 (PDT)
X-Received: by 2002:a05:690c:c509:b0:794:6fa2:a037 with SMTP id 00721157ae682-79bddcd8026mr39878167b3.8.1774642476038;
        Fri, 27 Mar 2026 13:14:36 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8f324sm119057b3.28.2026.03.27.13.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:14:35 -0700 (PDT)
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
Subject: [PATCH net-next v10 00/10] bng_en: add link management and statistics support
Date: Sat, 28 Mar 2026 01:43:33 +0530
Message-ID: <20260327201343.16146-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272669-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid,sashiko.dev:url];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8377C34AEB8
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
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  401 ++++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    8 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 1312 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  201 +++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  608 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   88 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |   35 +-
 11 files changed, 3381 insertions(+), 20 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h

-- 
2.47.3


