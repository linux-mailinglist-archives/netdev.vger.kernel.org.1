Return-Path: <netdev+bounces-261530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E0MA5OWoGnhkwQAu9opvQ
	(envelope-from <netdev+bounces-261530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:53:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B631AE066
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2196301BD79
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9572364953;
	Thu, 26 Feb 2026 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J+Z3xs61"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f232.google.com (mail-qk1-f232.google.com [209.85.222.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BF7376479
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130140; cv=none; b=hGN8MCBJo8oqzzaxfR5Dqlv7vvkj15lAXJmI7nVulUFbPL+SFwLlZmzIeI5eGJRVNeYKkPyTmM8I0fNWE7AecPO1f5Lb/F2tz1IrRvoMrAv513H6Ls97OYy649mW3LznQP1f6U+XjLzWp4cOS6ZfxOrzN1y44YKrVZOtRB8dqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130140; c=relaxed/simple;
	bh=sZ42wyatsVJo7JJtX1FirxBJniKFyuzHSURwlztrR20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmPdJU2Bc8Yf5j3JpCo1eOilsUh3bd6pQQ3MYQCYIDQsMzOglz7sgA969Ywcyr/raijq3LDCsUofPwMKSGl9u4QKE3h8z2hBIVokjj99hQ1Wo5dHXlhzCkcpXqTg+qf/XA7sbIX/uC1Na3SQqehMNaivRzFpP2fCPhxxb/d5azY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J+Z3xs61; arc=none smtp.client-ip=209.85.222.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f232.google.com with SMTP id af79cd13be357-8cb3b3e643dso70648985a.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772130136; x=1772734936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNoJHTgrkqEC+jke5kbp/HlblBsCRQSSyvD6QvO9e9c=;
        b=rLFpmzRIf2PnvFtfKH8CzyXTNCHoG0m7QpvPzDJjs/Bn9F1BflDGZqSrpLBAEWjSqT
         BKPffFtAYrSGpHiKCCpCnC7L5Z6orR/4M4OoPVLHD3986Fy12lY4b3W732GLlqRQsQjX
         qndBJqyICRo2tLN/XnBQfiK3ss1tfjhDPQw5fQ9KTfiuLOG+mfvCe5dpCcma8qSWJs3f
         ft+vTuf0rLHP3ES3rjaGo1CQdipkDp6nWOHdVcF0Z97C3sIQYUMps5iQR+bJB+s9FmNg
         JH1P5KWZtyInyVvczxh83MVHkZA/QPfyrZil0DeXVPLaeha6y4fwIsQw/dRupkNmiYfP
         lbjg==
X-Gm-Message-State: AOJu0Yz6iwt2yTkZVHLgZZelpj9as1TSRQ/MS/zYht1jsHOv0WrW5uLk
	iAacWyeBtto4xPOHwDFecnkv8QUkXHFx6flRJ6kdFhzj0x+y9BvKjbTMIeg82A6orJHfzYl/L2n
	/k+GHlscMNhGF4s5FM0TFaIi+dLdnvablWlCjKg9RTWM/R8RJ25JnEoPkL+5Xh0/ji+LnP+9vdd
	nEHwJ0XLh6TLMGTqXssPiqNwvD4v/VmCIFGgg++/Ms2yfq95W/kQjh1V5uUwu7KWg0yL82vRBW5
	7fzGY11JXrfVi11QOjr
X-Gm-Gg: ATEYQzz9TnbHJEzjQr7ohCyA1Xb1SmFzm111mnro4Qne1PL/EsL9mXyCvG/uThMfu3d
	SOYXLkw9Xyd+OlGmmzyjs0AyiwaaeO2TM8Sk/J5qMTuBmHzV6lSM64T29O2CjF5s403etpfjcVs
	8SYDj8QiW/s16K8S63Wm49E4vHqDa2oBOsdj9Saj2LM0dY9oAOX81jrl92DtoTXq3HHsh08UZxP
	zTKtlVRFtLHA+X4lpmVI5dEjrEYIxqiuZSPGDOXfiJwnd/BM1bomBBRlR8+oZLa5WVp65MpGyAU
	jpr+fxkNggpYA7Neay1Rky71gvvwsHI9Ow3hiNkt8YG9QMmyiYYHGg3sPX6QjnspCh7xyNOHtt5
	lca7V6TbQVSvyDM5mCD1EJ9Jd8Zj3nvg6HjATMKJGkHeBMxUpP/tJ+MQ5bcw7ju4uHbFILiDQkJ
	RbIN5KZOmkW9NTuhQ2tDqqpneaW3qFBgOA/BFDsGvL2b9AvtSylz47Kf0pszvun+z6zQ==
X-Received: by 2002:a05:622a:347:b0:506:a43d:777e with SMTP id d75a77b69052e-50745eb8911mr41697561cf.12.1772130135613;
        Thu, 26 Feb 2026 10:22:15 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50744ac6246sm3151721cf.9.2026.02.26.10.22.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 10:22:15 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2adba04421eso59433125ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772130134; x=1772734934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNoJHTgrkqEC+jke5kbp/HlblBsCRQSSyvD6QvO9e9c=;
        b=J+Z3xs61AaJM76GGqrs9O1J6yBrGx28KqCbPWM6Q/bdIFOtnpyKV74CMw6EVllC1Xl
         hzzT+hBTmX0lhc0g4534E8ncEjJMnXtXezfgidvVh3FACZAjtTXNH5uFzZHm03Wk+ki+
         uur2+S/vq4JXzv44hY5IZaSmgRvd4D0YLhg70=
X-Received: by 2002:a17:903:1965:b0:2a9:6281:6a48 with SMTP id d9443c01a7336-2ae034aa27emr32882595ad.44.1772130134409;
        Thu, 26 Feb 2026 10:22:14 -0800 (PST)
X-Received: by 2002:a17:903:1965:b0:2a9:6281:6a48 with SMTP id d9443c01a7336-2ae034aa27emr32882335ad.44.1772130133951;
        Thu, 26 Feb 2026 10:22:13 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm35941565ad.53.2026.02.26.10.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:22:13 -0800 (PST)
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
Subject: [PATCH net-next v2 0/8] bng_en: add link management and statistics support
Date: Thu, 26 Feb 2026 23:51:25 +0530
Message-ID: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261530-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 06B631AE066
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
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  382 ++++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    8 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 1305 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  204 +++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  582 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  121 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |   35 +-
 11 files changed, 3445 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h

-- 
2.47.3


