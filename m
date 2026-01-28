Return-Path: <netdev+bounces-254415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHkuGAdcemm35QEAu9opvQ
	(envelope-from <netdev+bounces-254415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:57:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3BBA7F7E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B306300EA8A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0892D7DD1;
	Wed, 28 Jan 2026 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XHjEqoAn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C3218592
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626628; cv=none; b=EN0nm0JoR/ouoQU7dIrMJN/tETXCaL5Gkq+fdOFrvSkiwtdg7R0MTrMmtg3PR/VXCmE+mVHQMypcIFGdy7J1C8TkPXz5uBQTQHQrH5pgCM+UBUub3zCuWwCL6ZWrN7cYE0KR/rRB5RZ94Wn4RJN30kS60ll0/Tbgh8NuEhKYVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626628; c=relaxed/simple;
	bh=ZZFvhLLW+4tjabPStNfpCMG2EK6qmhVIP4RrtCFTlUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnHdZmcGprjbpOkkWebIAXFtwJiJvTG2TPYudTz0vX73l8zIyqnrXULxZ+Ngupbq2je/qf0MLl4+Hwe/B16SJcRT1PaPNQSWn08sTKuT0Cat5WJ6XNwt9iSiJXi1aVhHYzBdEhqK8iDDFXQI0TdSPeUJlWYNXMslejLzwEXh7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XHjEqoAn; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5664393d409so58984e0c.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626626; x=1770231426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvFd1fTqO9146bVPRLMhdaLclbvKUuCto0jGRttNiHA=;
        b=mcag8KjmfwDQ5QcJ+dNGzYMU9KEaienpRUCD/521/GLAm4L8jca4+b9Lv3/f+KsebN
         YJ3bt4RKOh/J6oAVQGPg766SmhatoVKwmGA48Mk0gxQmBUHXk4FML/nueTkzGe2HfdMU
         0bmrNCIBiGj5vQwcIZgp+KUorDebg7B6PPbwq7KNZmS3NhNW1GHcDnMgRlT2014ELGz+
         Xy3c+/2IoYfEsg68auvPhyNqcrj/KY2adu6XudSo9SpOZCB075guE0TMqnd7S8lbK+8v
         6QMQAKXzGI6+MiChusaAHyn1JDIfB9tDnyuBl5ZhNhljgFZyZnAWWsogLW/6wHxMyHbK
         jmnA==
X-Gm-Message-State: AOJu0Yzt2PmJmQhVqEVJi5/Li1/lgh2XHgftDwu7Boblwhbelwdxn9ZW
	Y/eRRMWOkXZCS1XD3eohTNwsWkKubcvXHeUhsBC30bvUXt8zczxAVG1JzcT5htKxCy+haMhB/Ek
	3OOYFYFB3/NVBgNVuOFWSUGw+Ucx/I1NrP3bNOv7T0fLH5FEwUvPaqftgDz195++hz+Gsxz08PS
	S2i7195tMR/UebJbcJnWdrqfjLt0Bv0J0RGgAiaJcRB2n80kB4aG21TJKCoq+wZUDgnAqL6Tuo2
	GW7r3ilaQRXGzd/qw==
X-Gm-Gg: AZuq6aJ5rQQIDmCQlcfMQ5rpL3Hn2S0rK16+LOaxz5iyOR+JvPz7bXP56DH5AaQFbCZ
	kI6f+qpiPHXzU6ZJCDPT8odSgZvOw3jCb7gPm5lSyVM5OLhPq+EmadblsIOx8vLGmmiV7nGgr9i
	Nsr/ec6EbKhVOQSsjtfJoeetRYAnV2NVQMv7kCRiWQtkR6KOE+YtSZqNsPkln4EyYGqbHKSyrmA
	dfvQkRfL7mtnIb7g4Q4h30nlNng+fl6YXw4wJXlMdkooApdGRlHEvZbEv2ly4UNd8nk2UlH8ZmS
	yyqSdNRAKY2roPfp67eLKtwOQkWApVHaSvO4G2dGIjtKiG6cPQ749W+fjvJMejkZ+esIBL9B7lH
	zip23SFO2NjZjSCCIV9Go+GjUR7scqbZhRAG1SbFWtvyAWLUaYfneclfKCLXFX9Ivf2xvt/ZYig
	IE0+5GYyRXVKjH+F0FYJZDdHtPTo6a3EMWEBv5vu/CTgxR846yfHQ=
X-Received: by 2002:a05:6122:45a2:b0:566:34a2:71c8 with SMTP id 71dfb90a1353d-566794d31d5mr1913569e0c.6.1769626626113;
        Wed, 28 Jan 2026 10:57:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56685bac163sm342919e0c.3.2026.01.28.10.57.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 10:57:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82323cc7594so60067b3a.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769626624; x=1770231424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BvFd1fTqO9146bVPRLMhdaLclbvKUuCto0jGRttNiHA=;
        b=XHjEqoAnVp1ZB27gEK2fDJSvJyOf9SQ8zi2+mnoZdjQyDBC4SjZDbf9KS80fKm5OTE
         ECmwLHSEntiFfX2gTWjVhHx8NIFyk0A8braW5GUCvQdh/6qiwb2XujS7/T+t776zZsWb
         rkUhgfzKQ05wUBFP7n96lQIsdAtCqkIDA1T+E=
X-Received: by 2002:a05:6a00:2d17:b0:823:88a:7f1d with SMTP id d2e1a72fcca58-823692ed7ccmr5625244b3a.62.1769626624600;
        Wed, 28 Jan 2026 10:57:04 -0800 (PST)
X-Received: by 2002:a05:6a00:2d17:b0:823:88a:7f1d with SMTP id d2e1a72fcca58-823692ed7ccmr5625225b3a.62.1769626624214;
        Wed, 28 Jan 2026 10:57:04 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c22466sm3263536b3a.50.2026.01.28.10.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:57:03 -0800 (PST)
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
Subject: [v7, net-next 0/8] bng_en: enhancements for RX and TX datapath 
Date: Thu, 29 Jan 2026 00:26:15 +0530
Message-ID: <20260128185623.26559-1-bhargava.marreddy@broadcom.com>
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
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254415-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BA3BBA7F7E
X-Rspamd-Action: no action

Hi,

This series enhances the bng_en driver by adding:
1. Tx support (standard + TSO)
2. Rx support (standard + LRO/TPA)

Changes from:
v6->v7:
 - Addressed netdev.ai feedback shared by Jakub Kicinski by adding bounds
   check in bnge_tpa_agg() to prevent agg_arr overflow.

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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  409 +++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  121 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 1645 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  126 ++
 8 files changed, 2776 insertions(+), 41 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.h

-- 
2.47.3


