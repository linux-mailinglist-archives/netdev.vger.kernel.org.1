Return-Path: <netdev+bounces-264526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGNUEEbiqWl1HAEAu9opvQ
	(envelope-from <netdev+bounces-264526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:06:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1F217F97
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8C5230C4EFD
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 20:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9126B3EB810;
	Thu,  5 Mar 2026 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gSRh6Ren"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315231A9B46
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740867; cv=none; b=EsB2wMYJyZrtI/0njRHLOVWM+bD9xRwqNIEuANHFhi2y12gFIlPjzOljLNDPtiFEj7yxSgIb9z2DCrXEXVBrvnyO9kLWNcHFznuggiHAQXOda+w3gr7RFB5egivfGWTpRsAmGORx1jDUwcs+stTB+ewl1xiiyvC4+skPoGzpMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740867; c=relaxed/simple;
	bh=cZi1e8/DZ+Ssh2VYx08ENb1sCv5FqeFsFo4hjTnTNPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h8d/YPZ1AyNU5HVvIuyUSpvwVNq4F6UmuMKJ9fM8UogcVVgxUFbmvjMxXlmeJKc91lWyoGbIRBK/2TIbDXcotj6NLb1fuuKUuID8pUVzoVrBcO9QJ6ZC4J4a6eo1Zah8OlgUr7OBsVnz7QaX81sYHol45CDNMGwNhLGa1A8fogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gSRh6Ren; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-78fc4425b6bso84915767b3.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740865; x=1773345665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISSStzFmRvLzh55ipD0n4yHADK/WEZb9p8KcJo233Lc=;
        b=XW1/E/dFF83UNt6k5epG3psY0OP09ELa0LqquvqAt/pWFuzy4fRX2qp30NsiY2KFtc
         Z2L51cA7anjuqxTk6+XgjFGqf+hNm0Ek1aprQ9cRS94evfsWcpd9ZgQydbIHRN0X+cyG
         M3lqDtXayt/fkYOgs9uQ8pDcU/tGdadHHo4Gnlgf+j0jKXw7bFVgduqKlY02NZZjVTQt
         tt6V+00XTuK78k8eZC7uKYDfx+h2Am6ghLFFJFsv6u/pD6VGR+0Oy6rutQ9RnL3rKSFX
         iU3RPe+j6oqI33ZV50STLpkKHMOQag/6Upzyg2WvyKWtwFKDbudI2dDpJs3ZYogSgsqq
         nTSA==
X-Gm-Message-State: AOJu0YzgL0E+6fY2F4dMtmnM887A57qvRHr29nzcalJITxsNlrew85x1
	mycfJB8IHKUwTsO8+2o3OsoVaIyFObLLXUaYFhat0bLL7NVeIpbqtnNh5m+wy9Ho2vi7IFod3ZE
	Vt09/DVMEVYk0BMPHHx3lexNR29lLpYVQVd4h33wSlcHVBNyCCbYJuTlpRqCXvOz9MDLNQ7daqm
	3/k8E9qSid2MzprsavktsRBGG7iBBeVdQW0Twba7Zk+4se7sENlHU3jo11xLxYJjqtw4cJo7rxG
	Z+nlJNNw1K3woLKpQ==
X-Gm-Gg: ATEYQzyQN/PQFfnRXwuUfrPDVJJUM8tYfEXmY9oiqoypWDMbTnxq9922VHDdAPoc4oX
	X12ec1EAb04z8m8iRa1de28DrP8/LfqVDGld7BV3TZq06hhQXe4i3gy8TqGA19kIQZf8V2aYxmV
	logr3k1Shim7CYLvlx3ORtybPfbvrx87DnZWYWU0JAxbCKPG/7HeCscEgpvbG2V7JmFvSoyIB+c
	dDdsxfsGg5pEk2sc+6/Q3LQ3Ts4r21ZQPbrgRIdomCkQZFYyKoEnWZox2cv2bfqNFRr1qzhcSrG
	AQE4uDxDP14o1EWw8L9mDKPWExlH90KMZYAS+cdml04mMsZwpDuTdAW2BIpvoMO5gAnwyn9Fm0L
	vI6TKBOxeJ4RG3mK5AZ8P2YCh/vBn/en/xNmP17JGKHFz2wRWLUXavjC1ml5qbgoyAslHl45Xvo
	NYeWDL59aGScJUmjXdz7WApMti24jeYyfIE9e5xjVCY8+FJrYZn37LsIwiIuW5QJ0=
X-Received: by 2002:a05:690c:23c3:b0:798:1adc:67f6 with SMTP id 00721157ae682-798da4034a2mr12120137b3.2.1772740863372;
        Thu, 05 Mar 2026 12:01:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-899e76a9623sm17589096d6.7.2026.03.05.12.01.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 12:01:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae467f128fso49188485ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772740862; x=1773345662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISSStzFmRvLzh55ipD0n4yHADK/WEZb9p8KcJo233Lc=;
        b=gSRh6RenI+/josP79X/YKjgtqA9purWBgWQgCoDGCb5in3dKKq89fZUfuUoMiKik94
         g1Ix1xWQ05Byh9ueRC8ALuFq9NrSP/6HsvAYY7MzEsK9jWeSHtTWBC9ZaWXnVuCRvONc
         RXVjDwLRJ0iRZe4R7u3Ec8lMCN2iBq4gcWEII=
X-Received: by 2002:a17:903:2ecf:b0:2ae:5671:7071 with SMTP id d9443c01a7336-2ae80255a6emr6512865ad.43.1772740861640;
        Thu, 05 Mar 2026 12:01:01 -0800 (PST)
X-Received: by 2002:a17:903:2ecf:b0:2ae:5671:7071 with SMTP id d9443c01a7336-2ae80255a6emr6512495ad.43.1772740861086;
        Thu, 05 Mar 2026 12:01:01 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm247398505ad.53.2026.03.05.12.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:01:00 -0800 (PST)
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
Subject: [PATCH net-next v4 00/10] bng_en: add link management and statistics support
Date: Fri,  6 Mar 2026 01:30:07 +0530
Message-ID: <20260305200018.111728-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: CAA1F217F97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264526-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  650 ++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  120 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |   35 +-
 11 files changed, 3510 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h

-- 
2.47.3


