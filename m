Return-Path: <netdev+bounces-250618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4FED3860A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A3D03008195
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141803A1D02;
	Fri, 16 Jan 2026 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BPOdnHYz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89B3A1A5D
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592284; cv=none; b=lUADXtEOc/LDSHhppV4YQFApcigHTpfNc0W4wdoakV1AJLytDhIzdxnWf4dJ473Da8EdWx+V8crWx2yExGtS0FnTnZelPYRYxFC3bBCGEWhAQXvrTqTMYdufxylJiUuohUPs2y9XQTRRIUJmSnwtA/n/I5oJK1aj5iikIm3UVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592284; c=relaxed/simple;
	bh=zR/Dfk8WwtPcpbhjSWgCHl5CWzoTvXOKAA0jIWtzc+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VYxuB7ieC1vQSAr108uNv04c4klp1+zsnp1/JzOozIwPXmqp+a4dO/r5TDh4V05LygrPW0YYoxbFozwSPH1y9usB/shgnVq3jl+vpp7iybj9K8r/GDzqsGYsd154938Q/9ndJMT1gS549I9IjVJdLx4KiUHjR4qOnYYM/t2NuaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BPOdnHYz; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-29efd139227so15365355ad.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768592280; x=1769197080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tabzC9VhF0hnwg/9AMkA5LAX3hI/6YzUWyLi2DFipds=;
        b=uCWUW+BHudDJP9uTa7wZDpl38rX0tTo3ZIAEdFdpGp2keNYVlS+1zCQKd35k7IKdlT
         bakiP5UCwabwjIcp9oirYXvta5/VReDHVAE1SJ90RvGxzdKzxSWFgWwCP8DigeNHcybX
         CkNFNxRdBDdjPlspIZoWkDGmtpwxnjrQMVtmCMT39CzLOvQMvCKGrWfZnj8HMRl6fLP4
         Tvr/ifxTEFzJ2tqsRcsJrgoI+i6Bz1VZc1bsaG4gNgSwyVYa2o5N3vNkwk/jm0S7CXra
         oWoYWNILigUZZbxG2tt0es8OgZhawNiAe3mK0/0HrybuzCTIlO446lcCcQgfRJZzDINq
         GMSg==
X-Gm-Message-State: AOJu0Ywbf0wFaq4pDAmVsq3Jbog9HT5OqYnCRiml9zN0Bdev4dVhvIRb
	3P6g+YZVHQPdCCt6DKS09ca6/A9BwBT2XsHEMFmmVdpkLx7zZVGN2wskJ9wkbV4offrGaZc7+Kf
	EwMFl431oyH2ospMf45pUhkyQUanCHLRRSryAHNJGSH5bxhiny9I8e4jCoY22Eei1PYgYC0vDiw
	iiek5P9RCrWmlyimjdm75Kay0GICmwOtEKhydb6NJH1Xz/MY4tD6bATkldzalsYA9tzcnP/ROij
	i4nDZQXE6wJA8HoyA==
X-Gm-Gg: AY/fxX4p8yDltwCovrjRvCRMxdyWf8gi5ImdUKpv+fgEvl3YgwV2D79wMSL3pNdH9vt
	au5iIKaLBbBWJW8ZLuQG9UpKDE2MCjalZUOHknGkTwL82GKavI6JSh4nDISS8rudnXcgt2/U5RH
	E1NfKQyNGZHUxm13cCNyLCWublcGu9nph9x0eK8A8eaaHjLa2zT5u1InwoyTQrryYWCDDizqdAt
	5ZoDiH+A2MyUT/VKs5x3OU5+PApzp/cHDyb/rUqQfaLI57HT5UjJHzJFkhkBdGhfRz0ObWHlOXY
	jdfYRuZrwZs4PBfcy/1XI6ocW4ebkQUciWbxPYgWx03aUoRE9l8Xd/tnQTKIUHDcRP0WKYdJ0Gl
	hgbfg2RQdHn5zp4dNO3Pz9VenHnF97bDufokNsjOvdgcR0w/CehLaEcZDiOUss9m7DTdIYVvpAg
	V1lWQ1Law2q0TAcLZZKNy1o/ID9dJgidrtRsYL4rFwWZbsvkcAyXQ=
X-Received: by 2002:a17:902:ecce:b0:29f:2ec4:83eb with SMTP id d9443c01a7336-2a718971860mr35235935ad.53.1768592280402;
        Fri, 16 Jan 2026 11:38:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7193ac28dsm4216405ad.61.2026.01.16.11.38.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 11:38:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c5539b9adc3so1631758a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768592278; x=1769197078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tabzC9VhF0hnwg/9AMkA5LAX3hI/6YzUWyLi2DFipds=;
        b=BPOdnHYzSPYB21lj9hEv4UBNOafXBW7RITfamK5g/443Zl5ccd2X2hRgpvQ2Xd1BVd
         ysZOoTmK34eyweaanwLAtb3Jv77sJ/xE3yuSHiDtpOlZeC0pGqVM7soNl+FDZfE8Z28J
         b4urneHiVCuuLgBfX6cQxLT/1LNmZ7z4stEtw=
X-Received: by 2002:a17:90b:3d8d:b0:343:e2ba:e8be with SMTP id 98e67ed59e1d1-3527316560bmr3165319a91.10.1768592278381;
        Fri, 16 Jan 2026 11:37:58 -0800 (PST)
X-Received: by 2002:a17:90b:3d8d:b0:343:e2ba:e8be with SMTP id 98e67ed59e1d1-3527316560bmr3165301a91.10.1768592278005;
        Fri, 16 Jan 2026 11:37:58 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35273121856sm2764909a91.15.2026.01.16.11.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 11:37:57 -0800 (PST)
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
Subject: [v5, net-next 0/8] bng_en: enhancements for RX and TX datapath 
Date: Sat, 17 Jan 2026 01:07:24 +0530
Message-ID: <20260116193732.157898-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This series enhances the bng_en driver by adding:
1. Tx support (standard + TSO)
2. Rx support (standard + LRO/TPA)

Changes from:
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
 .../net/ethernet/broadcom/bnge/bnge_hw_def.h  |  463 +++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |   65 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    2 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  407 ++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  120 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 1619 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  126 ++
 8 files changed, 2764 insertions(+), 41 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.h

-- 
2.47.3


