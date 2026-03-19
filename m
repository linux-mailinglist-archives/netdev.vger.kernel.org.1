Return-Path: <netdev+bounces-269302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOxOHxaPu2lmlgIAu9opvQ
	(envelope-from <netdev+bounces-269302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:52:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB2C2C657E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07EF3308DB9C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590882FF643;
	Thu, 19 Mar 2026 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L6dtI3wv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FCC2BE7AB
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773899539; cv=none; b=XtMkcQ0xEquBc59dRJXE2/ClWr39yzeMcawGcvUCHZlp8Y9P2gvdC+1qrEf0RKkYX/QY15vxmGtV0HVsgmRhyUPhK9GkQGtDfeGhk4/OGtXwrRzQn17XKtp2VHZMVcp5PUyY0oO6ZsCKDtDPvKlExVoZw32x3A9WPTbxDR45wbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773899539; c=relaxed/simple;
	bh=/eTE0ZFTzGnRK8R4FVp3sVhsToT4DkidTTDVuLzOvoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BTrJWaLKY7uR1nad/OMOitsJRk3cumZujjCjwIgfJ8b79/hQjMUWoaXwfvJdqY7FLFKxIyg1jvJhajpDh4/Zr9mcBzlJ1/nvDeXpzK+AJ7iIQx1zOMFGjXhiP5vPAK3ohxc+UxFg+xm+F7kFBbxlnTtKs/jKT/SHegYNzuiy9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L6dtI3wv; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-c742d7c8acfso116304a12.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773899537; x=1774504337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVu/8xvOsdGoGd4w2kwUZr836dq46hFLl6aqiaFuMak=;
        b=WlvmKIttfPv99JmhFwZq/Ly93syQaVxIB8iRYK8auGJgM8bNLRIjafARFnllAh/JLT
         K08V0TLcAlc+2424L3svDQykShJMbb/IwJEvz7bsYyDLmBLf37n2dgdl+g+Zz/El4fXI
         Vi7lzQpVBECTaZRajMpu6aNYkwjbDTEpGiY4G72cKc7IydVljyBhQcETt9x2VxNs1GV5
         k72CBc9Cp9I+C8KDd67oG3O8eL6qtw86slfiFLymXO3H+F1R25QRbtkWqW03avlBm7yh
         lP1/AFP0CNQpp3uNDJ0fsjP4JUTcZaeh8C79Bjh0azH1SYBFtYWMfxSUzfneSfNvvy6L
         +xmA==
X-Gm-Message-State: AOJu0YxOWZbyFaZX6mHkDogL6NjsO9pn8gOjwU0+sHdW1V96RYaB7xuQ
	p3KsYp+BcG4mY9W9/FIr2olY7rTanfwZV5Vv8CTuywx6fTYFarXL+NhsfhvCGKBnrUJnO3KxmWY
	cm4rLUyiFg35vUAtFZ2IHwHX1cKE1uzfkrlFaKTsl4rL1eUGF1WAKfgBpkSroHlfZBfxVw696Ib
	N0zge3IQmq/UTaAfEej9E8vI/jt7gqcFsxYZ/R6GNfiJbfZdvNWQHHojRhJnU5C/H8KAMPg4UGR
	dMZ/BxUbg==
X-Gm-Gg: ATEYQzxis1Hh/PCXafIG7ghLNM5/lo/1SorJZzdXtbcBoZjeJSi+la5ZsnXY6NC4ocb
	+y0UZFnODbtxi5jN1E3iItwbuTl5utFhuDbDj2RNCWsqCBeV3HGwn2QLZko5zI2hQWtjd+50Nlb
	L8MA2Z725/PwpO64+SPUOigBpHCBxGu9x+zxBD9V2JPqW+cpxmtuwJwHvwNNXWoWk+UOlYl8B8q
	jfTpek42CkRCNL+izv+JiAsPzmqLE+rz/MlwYffs7w899YndotjQReT8ye0XQksh9dcAwl767l5
	e0+JkdGPL1Oj0pQs1iKXxaN+Irfh5EgUHwYzrfUx+TZYMtzXW3JZRQE/LM208EWUwuO5vFIjV8/
	697VSaopAd7XlOUQR61H1TBXbAOKy4Wb8n5FJJPtWn4/0VQtN6R1ZZKuwzk6757pHMyGu5dEsny
	u+lga5kXFxGH+221C3h/wgRkMz5/GQvNGG5R1o6CluCUdPtepSDJS9cDJaiQ==
X-Received: by 2002:a05:6a20:d049:b0:398:7d4a:c2c5 with SMTP id adf61e73a8af0-39b99d59c51mr5163662637.20.1773899537298;
        Wed, 18 Mar 2026 22:52:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c741e4f69e4sm382165a12.5.2026.03.18.22.52.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2026 22:52:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-64c42aa5d66so2397281d50.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773899536; x=1774504336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cVu/8xvOsdGoGd4w2kwUZr836dq46hFLl6aqiaFuMak=;
        b=L6dtI3wvQDaWST57Ws4NfqUNV59D0LKmsPlT8Db/ZtLmUxHtdiSCzLdbby/3HIyb8E
         P7pCqGF179tnihC4BVK2xjATpeNTmpPTFRKavciwjfDhU0OIduKL9T0kJ/O3Zx3s16Ne
         CM9E9r6k4NeK8cziqndRgeNRrAv9pTpYfQ6/w=
X-Received: by 2002:a05:690e:5c9:b0:64c:e789:4397 with SMTP id 956f58d0204a3-64e912fb6demr5090539d50.10.1773899535971;
        Wed, 18 Mar 2026 22:52:15 -0700 (PDT)
X-Received: by 2002:a05:690e:5c9:b0:64c:e789:4397 with SMTP id 956f58d0204a3-64e912fb6demr5090530d50.10.1773899535441;
        Wed, 18 Mar 2026 22:52:15 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91a1cd32sm2918980d50.2.2026.03.18.22.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:52:15 -0700 (PDT)
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
Subject: [PATCH net-next v8 00/10] bng_en: add link management and statistics support
Date: Thu, 19 Mar 2026 11:21:14 +0530
Message-ID: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269302-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.970];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CFB2C2C657E
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


