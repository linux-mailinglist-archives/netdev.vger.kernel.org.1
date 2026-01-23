Return-Path: <netdev+bounces-252946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMEKE1nRc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:51:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F997A538
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85CA730166D4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97E5221543;
	Fri, 23 Jan 2026 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U87wgdcw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2861A9F88
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197391; cv=none; b=tgf0d/HjZPvb3Ic/2zXUp31LRjpz0gMbMS9OvHIPElZjSlUywFwJ1nUS4XN3DKrSX0DRlSznwt2KBHM6A01ykjgfbkjZ0I64zawXlFBXUL7pNM8Qm30d+JRWypw1CUnWjXpaM55BOxCwLBM9XIKSO1r2v6HqXZBHi+rAoPE6Wvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197391; c=relaxed/simple;
	bh=2mf7a+Hr93milzDc+ogHnbI3Y2AneXoaeBHYPPiUEiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EWvcRMI2U5Ahub3grORSiAxafDjysoxXPWeT+Qw7SwvmNn/X8D7KtiswJ3NKKgmXMPfavc3fX80NmeBKcyinBvGHmjvXm1niFZiyygD9LQVc1fexmqrfcmMpulmo65a3o1uawZNAtKncaX9VvK49oHY600dyQZNLCfRgGXp3Bgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U87wgdcw; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-34f2a0c4574so2369622a91.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769197390; x=1769802190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FL12YkiV2Y2HKowPY5TkAq0P+k27Iok/6cTkQQOW98Y=;
        b=WSGtXSllaH/upLO1Ska4vJFEq03kwkKXppVPmAW8oqM5VF4oOL8X/O9331DAvhu98B
         zEweXF1NYIymcbFpB0P7UVlLw8HbdRtC8/De9ncHxcDKkgFao1/AlXgmrDW/Aeo57NfO
         8um5w4g+6Dh/dCSOXAak7leb0N5nsCrtf6wUVUud3Fsngbr4akdqJGujT7bdS9hG9dDv
         XIQyNkuYGJsx8qRfr+EYpXY/aloHwXBhXm9bqzxGWALUzUXvRcqmbd3Yyud0OwephkCC
         4WMUEymA9jVvtxgzCaZTbHAmRHq7bstij4Tm3//h0CSTwXxej1trN/2oa7J3N98ikgtG
         NoMw==
X-Gm-Message-State: AOJu0Yzp/aYd2fylvcJfyzLOVuWS4Lk7PJjMvHMGSh0d70lG+AAr/pML
	GzmbiL+t9FowbWYGSZsLqWrWmrhCKP2EHTeU2z4xzCoKTID+AVZYZksFPsRKLjrUWXmHrxl5zCP
	JXawgwcClHReQgCdOJSPlVVIakUDFIAY05/TBn4SspePsN6mVw9UOKrXGxmLckbEU7QqczyWNSB
	kTP7700GBFIG3uhmdWVMHZLRW/iNvCI5rN5MI+DlMeUS07b41ZHbFJyOLjygHw9D639+G22E+nP
	GHkSmqcoUHXF9622A==
X-Gm-Gg: AZuq6aL5LLIlZZACBlTfJZmkx7NGqm9oeyJdAeAGNBHjrLg0TBjYC5att7b/P2BSRO6
	10hecOUZ341q9bjR7nL5HHY1ae/u7arhdMFf9Pi33A3lcqzkALWF7J0yzzt2PzVHE9/lNVKcbx+
	kxkaFnRtagqdQynyBTyiqTIszweP1XVpM84cm6bbt1BH1Fin9owptQPG3X4hJ0X6feg6K17Qa5a
	suV4KWa2xdsA0atH2oFD/mrrqHCbR299iC2xcS3YxOW63xpvKgW3BHcej6bmYPWtkNbiyhtN6vP
	x1UJMRhLiB5wEu991GWLc+FVv76buQNQWYjIEqb5Y4XvYG7lRe5fMr2ZF3MJk4wZxZ95srRueCH
	JRj15ynfX9FnNgjBmxwT7ot3kNozrnMLd5J7VdJf79EFUH6z+P8Nan6CVzGv3Jst8bEEngv3Kiw
	M2PazDiSI3A6fTYPxdHpYM0x4d42MKDZNQyJCDd89ZoxA9gI/Zxx0=
X-Received: by 2002:a17:90b:1e48:b0:353:e91:9b2f with SMTP id 98e67ed59e1d1-3536930bc13mr3197050a91.37.1769197389670;
        Fri, 23 Jan 2026 11:43:09 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3536aecce70sm68772a91.0.2026.01.23.11.43.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2026 11:43:09 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5013be25d41so70084091cf.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769197388; x=1769802188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FL12YkiV2Y2HKowPY5TkAq0P+k27Iok/6cTkQQOW98Y=;
        b=U87wgdcwcQj9e8+lyUAEIbLG1J7UuNZ0ACJg/WJEU+z1q2S2OUczhlWeTzbkWJ4V8l
         DM4RkuZaPfCUHLxFa6u1lrPXLWsomPp1aYVDBnzYwadYX4WlufDRJfOU0BzivH34GPSz
         EkeO/YPaA/KR6ZjCWE99TesnqoV+1juUzIuDk=
X-Received: by 2002:a05:6a00:2d2a:b0:823:998:95b0 with SMTP id d2e1a72fcca58-82317ea6b9dmr3574944b3a.35.1769196916382;
        Fri, 23 Jan 2026 11:35:16 -0800 (PST)
X-Received: by 2002:a05:6a00:2d2a:b0:823:998:95b0 with SMTP id d2e1a72fcca58-82317ea6b9dmr3574917b3a.35.1769196915829;
        Fri, 23 Jan 2026 11:35:15 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873e519sm2843206b3a.49.2026.01.23.11.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:35:15 -0800 (PST)
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
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [v6, net-next 0/8] bng_en: enhancements for RX and TX datapath 
Date: Sat, 24 Jan 2026 01:04:56 +0530
Message-ID: <20260123193504.285573-1-bhargava.marreddy@broadcom.com>
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
X-Spamd-Result: default: False [10.84 / 15.00];
	URIBL_BLACK(7.50)[netdev.ai:url];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252946-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[broadcom.com:s=google];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[broadcom.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.475];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A2F997A538
X-Rspamd-Action: add header
X-Spam: Yes

Hi,

This series enhances the bng_en driver by adding:
1. Tx support (standard + TSO)
2. Rx support (standard + LRO/TPA)

Changes from:
v5->v6:
 - Addressed netdev.ai feedback shared by Jakub Kicinski:
    - Fixed AGG buffer leak in the non-copy (large packet) allocation path.
    - Corrected TPA ID mask (0-1023) to prevent out-of-bounds array access.
 - Refactored bnge_hw_def.h:
    - Removed unused macros and migrated to BIT() and GENMASK().
 - Retained DMA sync in buffer reuse path:
    https://lore.kernel.org/netdev/CANXQDtaLFQc3XRrLEH2AytcZvkeUdD9AW8=KUwqGQvM+=Q6M2w@mail.gmail.com/
    - Retained dma_sync_single_for_device() in the buffer reuse path.
      Further review confirmed the sync is necessary for hardware ownership
      transfer even for read-only CPU access.

v4->v5
 Addressed comments from Paolo Abeni
 - Fixed mixed whitespace and tab usage
 - Reverse Christmas Tree style
 - Replaced bitfields with bool
 - Dropped redundant DMA sync to device
 - Implemented ndo_features_check() to move length
   and num_frag validation out of the Tx path
 - Dropped redundant queue mapping check in Tx path

 Addressed comments from Paolo Abeni and Andrew Lunn
 - Positioned macros before their associated structs
 - Migrated to BIT() and GENMASK() macros
 - Optimized DMA sync scope to packet length instead of full buffer

 Addressed comments from ALOK TIWARI
 - Fixed a typo in a comment.
 - Updated macro to require all arguments to be passed explicitly

v3->v4
 - Scoped the series to RX and TX datapath per Jakub Kicinski's comments.
 - Dropped IS_ERR() per Alok Tiwari's comments.

v2->v3
 Addressed comments from Andrew Lunn
   - Apply Rev-xmas fix in several places.
   - Correct ethtool-speed comment to reflect accurate behavior.

 Addressed comments from ALOK TIWARI
   - Remove duplicate definition of RX_CMP_L2_ERRORS.
   - Fix macro by adding the required arguments.
   - Add newline for clarity/formatting.

 Addressed kernel test robot warning
   - Fix compilation error: removed unused variable gro

 Moved hw specific structs to appropriate header file

v1->v2
 Removed unused function bnge_alloc_rx_page()
 Removed inline keywords from couple of functions
 Removed some stats related code that doesn't applicable (missed_irqs)
 Addressed kernel test robot warning
    - Fixed compilation issue with CONFIG_INET is not set

Bhargava Marreddy (8):
  bng_en: Extend bnge_set_ring_params() for rx-copybreak
  bng_en: Add RX support
  bng_en: Handle an HWRM completion request
  bng_en: Add TX support
  bng_en: Add ndo_features_check support
  bng_en: Add support to handle AGG events
  bng_en: Add TPA related functions
  bng_en: Add support for TPA events

 drivers/net/ethernet/broadcom/bnge/Makefile   |    3 +-
 .../net/ethernet/broadcom/bnge/bnge_hw_def.h  |  446 +++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |   65 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    2 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  408 ++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  120 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 1621 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  126 ++
 8 files changed, 2750 insertions(+), 41 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.h

-- 
2.47.3


