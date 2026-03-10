Return-Path: <netdev+bounces-266182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKfwNSsusGlHgwIAu9opvQ
	(envelope-from <netdev+bounces-266182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:43:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 934FD252521
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 159F1302E542
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3302E92D4;
	Tue, 10 Mar 2026 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FX/qdLPy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F728726E
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153707; cv=none; b=lmzmxrg7tbrzkI5XoPR8AP5/GlzSARWAnLJJPHPQ3gXwnowt19fw00I74mMbRjlgBwNy1LP3/HUt2B0KlutZkMU/YKQPPi2Hr4ONvShlk4o5wYbtQ22Vgk775SAOdITV4WDIxI1FreFTfSmggyebAN7T2g9yFrYHiS1p8YEMTKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153707; c=relaxed/simple;
	bh=k9ETKZ2Ll/z55MoNNjAA1xVvyW76Vb9Cnj790pEDbRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FazrwN2qL7sM5h74vho2409jZ67elEIC4hwp92c2b8PcVhB3v2kEMYPfP2505wAEGAjNIM04DJnp1VCqV4VOePu5UDIC/dgDQKKrRZAlzmR3NcYZLqf/GDwCF0MHi9JYv6xTzgzKUhMjTsgJbK3yXFmoDLBY3EdiaLHPJcKxti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FX/qdLPy; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-798617c0ad5so74459127b3.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153705; x=1773758505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sABkKey+X1qlomCWXvt/52GFmSGb3hIO4tI4MGV4fzA=;
        b=YsWyRctk++WLGHlV1oWC38KX+xNX6/+g3VmYr73jdoNZ3a2fnbFhU7c0XNW3Z2myTP
         LAA64MZshHYAXBSTaIpkUwQvTPDx9nUdHN60dHmDIByIWWgQo8vlEAyFUQHLr9ew++Wc
         6ulWyWsZbKbgMD5rYn2eBen3Yx/QvGHRGC0yNJwQrGUXnIkmxMx3qLi6DBaMpV+5NPNG
         OQTChA52xm5HGYuKbrwGMuQR6KWjsM7xJ45DdVTw/tySLGfnsP6w+1KQb04cef5qJSfz
         IEeifdDHb983pkSSWWN+ioodVnSC1gh9OM2d8atfBrlWZ9gJ3C3DVt+zWcfgP5xjTOVk
         a99w==
X-Gm-Message-State: AOJu0Yw6Ilu92AEoQlCz6qzJr/4chyKKoiZjEDtunKeqlc07H6Eaq/Iv
	VEBZ3rWPRNHK8HbSHFxTA0uwKjatR+yWAjj55Kf0IesikqXUjMS1HX+6KXNrKii6vdTb+ecyLRi
	9J45Of5YOL0llIRMfT7wHVYHRagSY/onggRchmQEvxaJ4fPKihOi+QRdhSpumMgLP0RfcYOw+g0
	SgHAO1DTheDf79S2N9UJXbw//u6Z1jqbCjiZnMBZx4WZAdBaUGTHxrNqJJzh7Ay6cwRGuBRSZ3I
	qx1JSJhHGIpdVnc7A==
X-Gm-Gg: ATEYQzxY82GV6aWpaejBJoBdrHhDwLIP0bOLbB7F8jgCtUjQsM2kde85uDPX6N9Nb8W
	XSwTC9kTS15lb7PeD9j8jwey0VpWMg8Ye1Zyeszh5cJxnFmNv9J3IZ8JaUlHkwn9gNjZc5I6cly
	EeCw1Y+YjnnTG82EVvpxXS4pPfss5xvPtzV33erpIapkYfwKmYxMMjXwpulamxrk6Czd1Q/PgPY
	WEDZZvoMZ/DvC+LRFF7xYcKr2Q8wlc8UiGeWe8QUlkkDECCoAYveoCJDD8bwXbKK9mIV1/OQxwb
	PnmPMhA5rJ4WKnsOOY5bp92k62wfCLJs29wgOdfX6OzB1HHgBKZ5MdADnb9CJPCa5mt5zk72kbG
	8dJx/rVxvHduTxoHSaWXjlFvAMVCmpeUolIIRph7Y9g2e9WdSj5byo1RFmMPmSolbtVTGHKNT7j
	zYawjzA99djN6bzYTtbSvBJTIP+FJTYKg/1grMp3dHzRsmW4vto6hHn6TatZbLa2w=
X-Received: by 2002:a05:690c:6983:b0:799:266:83dc with SMTP id 00721157ae682-79902668d56mr48157087b3.8.1773153704573;
        Tue, 10 Mar 2026 07:41:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7990a531189sm2481117b3.11.2026.03.10.07.41.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:41:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae6961bff0so371858265ad.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773153703; x=1773758503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sABkKey+X1qlomCWXvt/52GFmSGb3hIO4tI4MGV4fzA=;
        b=FX/qdLPyJV5VTfjs3/GxQfAJOQCrysZLtQeGVXZJJkeYmiLE/PINu4hQwvkAVCQUkn
         BMg+0+VGWfqeBZNJKeUtIEwa3eDyFN60ngZ+l7VDHG1ZxpEisiTnzL6WyY1xo12wqoc+
         /NLqlK8c/OUDN6zJZbIhbipT2jBse9Pn07e/Q=
X-Received: by 2002:a17:903:2ac6:b0:2ae:7f49:dba6 with SMTP id d9443c01a7336-2ae8238d8abmr151499915ad.17.1773153703250;
        Tue, 10 Mar 2026 07:41:43 -0700 (PDT)
X-Received: by 2002:a17:903:2ac6:b0:2ae:7f49:dba6 with SMTP id d9443c01a7336-2ae8238d8abmr151499665ad.17.1773153702759;
        Tue, 10 Mar 2026 07:41:42 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f783cfsm157096515ad.56.2026.03.10.07.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:41:42 -0700 (PDT)
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
Subject: [PATCH net-next v6 00/10] bng_en: add link management and statistics support
Date: Tue, 10 Mar 2026 20:10:34 +0530
Message-ID: <20260310144044.21672-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 934FD252521
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266182-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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

v6:
 - Resending the full series due to an SMTP failure during v5 submission.
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
  - Add implementation for .get_pauseparam and .set_pauseparam to support
    a full flow control configuration, covering global autoneg, independent
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

v1: https://lore.kernel.org/all/20260223163641.755200-1-bhargava.marreddy@broadcom.com/

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
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  808 ++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  388 ++++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    8 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 1300 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  204 +++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  632 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  119 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |   35 +-
 11 files changed, 3491 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h

-- 
2.47.3


