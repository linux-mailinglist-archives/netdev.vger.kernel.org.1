Return-Path: <netdev+bounces-262091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNudKAKZomlI4QQAu9opvQ
	(envelope-from <netdev+bounces-262091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:28:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 097F21C0FA8
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 801B5302F382
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 07:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EBC36AB70;
	Sat, 28 Feb 2026 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZsQQiQFc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f231.google.com (mail-yw1-f231.google.com [209.85.128.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C32C0296
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772263679; cv=none; b=agW44WE0bTxGfpgYeUvBbATteastYI0pTQafAt4TvIJ04MbgGRBqqqoJ2Ex5b9KE28Ht/Jcj8iHkSJH8Z5Tmqyd4Xu30Bn0Gl2bsrpPivLESbhI8YpRlz+mFTLs/j/DbG9B0wz/9+v8nksDsUQHrMm8u97T88V2Mbxf5kBtUyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772263679; c=relaxed/simple;
	bh=9H0vPfndFp27BL1Pqh9kDhGi92c4Q2t+dFVqIW2LeLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BsaklfP0Cyo/eSAMVk+OByFIg5G1My+/fBkGCElY1jxkfFCNivR6jhAvmNKx3ozuf+eL7mPvA0m0BeVTHQ//FQ4W/gIc/1hPdKF66E8xVFsI9rjayAgqlJl1unrNBUqfwypdY7YuZO1nakxArPmvMtmy1B1MovA2nqiKuy2c8Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZsQQiQFc; arc=none smtp.client-ip=209.85.128.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f231.google.com with SMTP id 00721157ae682-79854193a54so26773367b3.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772263677; x=1772868477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeMsSGHlUVtVR3GsRF2dxPAIQnco5Jghmca04jffsww=;
        b=cPQ+cL26YR4zMmTWSOaVrsBTOdt0/uAf1YTtuvn4kxocH4hG1gc5use1V0SRFCVTWh
         z68cAaf4J+dN6I+f+zHN8oEbamnsaO33HuLV6G8qrdvqs+IrrXRl3fgf6H0zckkiq3Bo
         is8nR5S2u/ABJwDE1MVkhIZLm7+/y+t/6SZCFR4sYbeRKHUUMsmKkslpyceOdDTiOK+z
         BPVjEQVTQZDYlswS5lUjCliTt3lMxOB8/3+31B73JUChqhfC/7mRPS8k54/6FXB2dQi3
         KZyMxr/94I+mI8yHof5BqxzE9ln+AxOMcIqp8lTHPLLFya3FaZRzzgyaPMX1f+ed9O4b
         oiew==
X-Gm-Message-State: AOJu0Yx5IovvPcnGALqy+4wS+TARlSj5HOsfOSYakpQ7DVhYv31dAZyW
	BO6mNYGIV1Eyem1ELzCIvUbH8pCa5W/+jfvsSq+PGfM0Mea+ZFOD58Rmoi3blZbiGOIDbXO8P3c
	bNCHazXarSK0FrPEGBgJngsYGlgHiy5uL39/eD6Epg1iGZSdMMETwfedqgz2ovdPfPpyyOAH2uR
	EuWk7loPq0pUpANXYbpPXEn2HXnksLdPGnsDSUJQYTDI27FzlEQKqmjre4Gn7wjNSOTbJk2Ri3N
	o8/2S4P9E9GquYTWWlz
X-Gm-Gg: ATEYQzx6Bwc5ejxHDHZqP/KPjnZtsifRX2k5Axaz6rOfg30mogdaz0IG/NDlgzRepet
	GmE9lMYsFQ7IK8S9jNbActGneh5Tftlipqc5w9ECsdm91Cy0SAw8v70R4RlRCzgGZ/ElhIWFp9j
	3rNWKk5nzLj2u53iK4e1wj8G91P8fnH2TXo4iHJ0qLpxpzXAMAsr25P0YwZ/ZFSLLN4chH6BET5
	p28F9165x1uJfIlFMUh1QQMuT7YeRa0RiWdy0s5jYd0sdy59ivNigYef6UqfLReBP+dUqBDBuvM
	TXCgRGetPzm8qNA35bJF8OKNiB3zPPFqPE8fad7WsY1/KozFKSbm70/sicZ1P3ug+h0vbJiYPYx
	MTJl3qT29iDRuapSDl2hN1iqYZeGwYQJmTWHDqNzFuVJtFe95nmjZQKQi2UHCJHRMfVWLVt6tdv
	fsyCD32Aq2RCfJLOTbHJP2mNcRrI6lPveAQiAdy0nBwIhW/jed0oT569poa4/xXF5elQ==
X-Received: by 2002:a05:690c:c232:b0:798:1219:c779 with SMTP id 00721157ae682-798855fe09emr47068587b3.66.1772263677035;
        Fri, 27 Feb 2026 23:27:57 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79876bf33b6sm8199927b3.15.2026.02.27.23.27.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 23:27:57 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aaf2f3bef6so26971275ad.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772263675; x=1772868475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qeMsSGHlUVtVR3GsRF2dxPAIQnco5Jghmca04jffsww=;
        b=ZsQQiQFcOAq888xOnBLwGnlDrRdEwghtXdSssj31J864Q7rIMJ+esOXzte0t2TEkvo
         e4BPM5bbJy1nuU0vBcNOusBh9FuHrO+uWcrxFwK7nMTzMRa5g0GZXjROxUqnnxlKLApt
         cnCrR5Znli69Z5q/dgqX4+x1aohSPicYPcD2k=
X-Received: by 2002:a17:902:fc48:b0:2ad:caef:fc with SMTP id d9443c01a7336-2ae2e4b6fe1mr56744525ad.45.1772263675553;
        Fri, 27 Feb 2026 23:27:55 -0800 (PST)
X-Received: by 2002:a17:902:fc48:b0:2ad:caef:fc with SMTP id d9443c01a7336-2ae2e4b6fe1mr56744255ad.45.1772263674993;
        Fri, 27 Feb 2026 23:27:54 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm6809267b3a.36.2026.02.27.23.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 23:27:54 -0800 (PST)
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
Subject: [PATCH net-next v3 0/8] bng_en: add link management and statistics support
Date: Sat, 28 Feb 2026 12:57:07 +0530
Message-ID: <20260228072715.1632280-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262091-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 097F21C0FA8
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

Bhargava Marreddy (8):
  bng_en: add per-PF workqueue, timer, and slow-path task
  bng_en: query PHY capabilities and report link status
  bng_en: add ethtool link settings, get_link, and nway_reset
  bng_en: implement ethtool pauseparam operations
  bng_en: add support for link async events
  bng_en: add initial support for ethtool stats display
  bng_en: periodically fetch and accumulate hardware statistics
  bng_en: implement ndo_get_stats64

 drivers/net/ethernet/broadcom/bnge/Makefile   |    3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   12 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  811 ++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  388 ++++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    8 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 1304 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  204 +++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  579 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  120 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |   35 +-
 11 files changed, 3446 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h

-- 
2.47.3


