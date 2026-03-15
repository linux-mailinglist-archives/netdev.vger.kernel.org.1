Return-Path: <netdev+bounces-267908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPavDpy/tmkWHwEAu9opvQ
	(envelope-from <netdev+bounces-267908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:18:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB17290F57
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35C9630041F4
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6F43630B3;
	Sun, 15 Mar 2026 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Psp5/3SQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052329B8D0
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773584280; cv=none; b=kSdPFsivAMnweMyvP790I2sDfeUEVrbQ8w+V89O7y3og6rLP5QRSztdROTQyFHwe2R9azi4/tiV8+7p1rJlkMBFjmUx4H2SpAAqvUrUmp+J9bOpCwVT5nkUkoCktwCDhdQTosAQGP9hmxnycehzZdGbEqW2oq5wV87EvoqCasXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773584280; c=relaxed/simple;
	bh=I+lq2v+1zmqDeDsa7KGRrvIAprHY+6ICozCWu0Goz08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gkKxIk1usLu47A1ryv7/Re4UdDauJkdy4HKojaBcwOU2Re4hHfI7gkCMEVAzTBjgZM8np72zfbS9i+J9sOG8l5nCC6O0cMQWEwXFov23uUiwDf3FADdlW/SWkVZFVB3Ei3SUjgJgqERCcayfx+opGxgfVV25ODdiWXNMI8lGbS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Psp5/3SQ; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-64c9c8f8783so4074596d50.1
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 07:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773584278; x=1774189078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlbjD89zevPMO446qciTilc7XLAL6p3qLcyMckAPxvg=;
        b=WHdRM5MATWGc0rPVQg0jcZULLLtDWkztwwq8G4UoUwbrpzWanJ8bOVu4IOrsXvt4kv
         tVUBQFyDMMXiHFNgbN6MgTjtjF4INnmqj+3w5pFwn+5lzp8scynuKpmT2ReN5yxpUegn
         w/NquA5oq6Gbgu9GPPoCbwgw5aPlGfQ38uffvELWjRe/RkpLI+geAZiEsS/fzwA8eBs7
         gwdItJYxe9ku345xAvy2XT6v6g04QtKUeiBIQuUFKlMnzRmqN2ixYhy+9ZnJqMiyp19R
         jUDcPB3IMxyrCyLcWHpuEEel8iU5lf0Hdoy4+0VP+x/uArtCdHEj1602Aw2zICkJcQnX
         1sEA==
X-Gm-Message-State: AOJu0Yx/wtoQZ3I+zcsq1la93NGsBagZRJkHtmti9cdGldjrY9FtKI01
	oLbtkyAuFu6Q2durhwluELezwyfRhN/6BUXOX5gSFC03vho/5U7M5x/KWxRvcT6aQu241u6+ydA
	RHAgw9bBmb9vca4SVEerlLiDicn2EQM+PTSfTICo39X1fn5PAUI93VLsQlo+3dRz5coWulkjigy
	CPnrcSlkDMXSr9vtXqY+k8A1uKgzrcYNX923KoThbjzF54JtF89nMNuBjKsQADWX3MXhmhXez3N
	H6Ummuevw==
X-Gm-Gg: ATEYQzylPWsivmObXCZudvTWk5sbwCBBuKNyVNEMOxpR3RWYwpsv5kp21b/cABj1wSj
	ixnITKXJ8Sr0oDUnDv26gFvxcpUlV8u86Uvj03Kx5cSI7/htuTAxMDRKTQNVmzdt5h26YRO+Wxx
	ixJX7fqaCNJlfRdnZomwPJR38FH65fhabaxN0cpmfKpPq3DcYvYRdVLKlnTSSIdhJ8giYl/EMWG
	Lp8KwOyBFbJNPcpAfibJH7gCOaxZu/otPvOv2k9grOl/a9skly1UX0OrfzHQaGc4b7E2PO5Sabm
	bAl2Czmm9GtVkfCZgqNZL7p6UWPi6ESLGKYA6xYXGWCk3SWc2jXNHBWUt85kg2pnhSwKKrKkMCt
	uyxJpSsL33Fn0n2tGIayYA5V0WibfXFSS8IOQAkzVWfb6iZyhOJBX16LnfzMPgGbckGpGaqajaO
	nSyQEbExUDhFAO+vwZi4lxOLZf7tnvcafGAEOUiibN1x0GjDJ1OlLS9no=
X-Received: by 2002:a05:690e:4004:b0:64e:7027:405a with SMTP id 956f58d0204a3-64e70274350mr5073166d50.19.1773584277956;
        Sun, 15 Mar 2026 07:17:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64e72a10364sm442454d50.10.2026.03.15.07.17.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2026 07:17:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aec8d85199so18648805ad.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773584277; x=1774189077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SlbjD89zevPMO446qciTilc7XLAL6p3qLcyMckAPxvg=;
        b=Psp5/3SQSquCG9FLfkorv4iE6MvZu8osKyAwsL/W+NfzffDPawFfu3Q/KJ4dYD8jkJ
         pTg3OPL6nL4dZLDfte9PHIG69/peEoEe5Edvk1SZp9mgz08BS6yTBOR0cY6i0Oz2kyA4
         kwplyAabzV1mYbqsPH/PFxtbbXdjy+HjDafjM=
X-Received: by 2002:a17:902:d50e:b0:2ae:5ab4:f4c0 with SMTP id d9443c01a7336-2aeca59a65emr105877105ad.13.1773584276658;
        Sun, 15 Mar 2026 07:17:56 -0700 (PDT)
X-Received: by 2002:a17:902:d50e:b0:2ae:5ab4:f4c0 with SMTP id d9443c01a7336-2aeca59a65emr105876785ad.13.1773584276194;
        Sun, 15 Mar 2026 07:17:56 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56c393sm76185395ad.17.2026.03.15.07.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:17:55 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
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
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next v7 00/10] bng_en: add link management and statistics support
Date: Sun, 15 Mar 2026 19:45:55 +0530
Message-ID: <20260315141605.410878-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267908-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CCB17290F57
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
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  723 +++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  386 ++++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    8 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 1303 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  204 +++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  597 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   87 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |   35 +-
 11 files changed, 3340 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h

-- 
2.47.1


