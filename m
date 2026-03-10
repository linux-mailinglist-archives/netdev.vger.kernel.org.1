Return-Path: <netdev+bounces-266167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHGLFWszsGl2hAIAu9opvQ
	(envelope-from <netdev+bounces-266167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:06:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C48C2252D9C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7083F3123CA8
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC2938D6B1;
	Tue, 10 Mar 2026 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LFW8lleK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F259286415
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151294; cv=none; b=SFRhnEUMWco1mlTKDevfyc/tTC8qGsoGdjpfUJaCDOM3djmliXZosZc6kcZeOVhWOyqtE9+C2sgnPYZ03Iv9c1pMYKpEPRnbW3Wa3eRZurh5ZsRKmhzW2h67Xsz6XZ4bg1zUJzJ/JsXN7uff1fnZGXZM73zmBN8/JyQrvVbcVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151294; c=relaxed/simple;
	bh=B67hDG/SL9opV3GW2yl793QuTIM18s7EGzju2YVYLpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtAIs1U6OkaFg1Qav4/AfpSR9osCoAuNFdjF+gOljDXxvU5/Xe3wCG0oDh0c5gx3JoOynWP6CIvuVNKxQOC17CuCi5vomyGSJycflalNOfxSPDpS5IGqrKSLUDcRwaG0pJp4gB9B9ciynId5xPJ9f6jomWObw2lbX5P0aRHzB2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LFW8lleK; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-7990712fc39so16055717b3.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773151292; x=1773756092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxNg0ZuvybwMNPFc1XdUvc1gk+8z+XaUlMvkkngGJis=;
        b=jhWqkR58Q5i+qarH9U9Z/KwAiVVoQx3u7YUxMS1Nh9nQzbYTqZdB8d7WDfbSUmFgCM
         dqnHDB2RsfG44qMd9oHHTLoMPB7Kn11PgNqZxM63CM39GXYVvEUWdd128EG0vYZZU4Hd
         xBKSXhpOwcE+IHTIzT/JxWdsfE8h3bgTCTTVeyqAhANvUaJX1lXQJvvQOvb4cGrJF5/g
         Vma1+UChqa4m3dGWXviD0++xamG4KRlR3r2NpVgjgcSxDeuWIDs0XGvCVc6lmmHZ+skN
         b2RsXunqlPSgjmlEGhTD7qvFhEIfIp89M9ONVpAei4YecyumtWCwbl1AZOrWt+MiVtmQ
         1nwA==
X-Gm-Message-State: AOJu0YzLZEqDaF6JG6PgOBJ0bXeckwTY5W7S99tgZ7CKx4JqxFuAhdtt
	OsQKtzeDznWCNFscHyaE6y9HLNWi45n2sGXnTS+CSymEk3cRlSWi7Hz7huTMrF719CJlxH0lpNI
	pLzyyMCdFrqZmsK0/bCG6/ShW3OvDnnv+OU9SkVWBtNB25zBfMEQodHSStnSt8BNMzlw7/Lvykg
	1wfH6E1khFYJvEHV++k20slhZZ6aLglNMv11XXSEOEp2TIUM8jAUhe+xab0MjWUVXcokEPBITPO
	ztGhRX184sHTL7A3g==
X-Gm-Gg: ATEYQzz2e3cTkU0BeHi+heuz+lSAx+pWclRaihPBIhJZvHGf5VtdZmJ6ecLGLGpKERD
	P2A8SONdc9KT9ZubhwNz46tJmt/3GZnUz2gAD3gpo/f361LbxIrjSd7Ryj3HSWOsJ2LbE0H7hQ4
	ovvt90Qy89kTAFjk74n/1qe/fW+aipWL7DngXifSUHtOda+bUpfsAVJSKRn+N5bwaBPUVpYARg5
	PIePY2EZYs31NPghfBGk6R9sA1KCGAKN/6ILJwsxqFup0EZGnO8ySn0G0WB8fGvyYqb1cT4nTMy
	WylWT/4QcWTIPjiaWhBuw1FyGhbppvaEj+b7zF1IU90mnhXFKK5bIduJXuwZ1zddN77GulIksjG
	ZIEiB73g72AJHLUcbiY+ZVolUiMP5Njfxx+wLQEaSMsvCsQJKviCxNkM4y1oLR79NkHag8/cilf
	Zn93St/KrSoYRZRuE8i0qZF8T/kQHf+5Z4/X0xld1oaaJsiiMgY2R114++pllmHtWPJg==
X-Received: by 2002:a05:690c:7:b0:798:6542:3112 with SMTP id 00721157ae682-798dd7c45a9mr147647137b3.65.1773151291563;
        Tue, 10 Mar 2026 07:01:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7990a4f6593sm2629487b3.3.2026.03.10.07.01.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:01:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-829a535ad7fso11926733b3a.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773151289; x=1773756089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uxNg0ZuvybwMNPFc1XdUvc1gk+8z+XaUlMvkkngGJis=;
        b=LFW8lleKGfNyKpkR/zKpipXt61eg6MIgUdA4jM/4aD8AC0T3J0pc5cUQpxhCSdc7Db
         4HSfV5f+/Fi6wi8Upov/atBT+Neph1giAjnox7i6XFyvq9DQiRN5vDRLb7ntBbqUJj6y
         IdWgzjFmBaNZoiXNFiDbNE9kzGwGCF+fE1INo=
X-Received: by 2002:a05:6a00:414b:b0:81f:4f47:c6d6 with SMTP id d2e1a72fcca58-829a30f4a30mr13185846b3a.65.1773151288861;
        Tue, 10 Mar 2026 07:01:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:414b:b0:81f:4f47:c6d6 with SMTP id d2e1a72fcca58-829a30f4a30mr13185495b3a.65.1773151283943;
        Tue, 10 Mar 2026 07:01:23 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b6f7sm16885202b3a.23.2026.03.10.07.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:01:22 -0700 (PDT)
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
Subject: [PATCH net-next v5 00/10] bng_en: add link management and statistics support
Date: Tue, 10 Mar 2026 19:30:22 +0530
Message-ID: <20260310140032.20893-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: C48C2252D9C
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-266167-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:mid];
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


