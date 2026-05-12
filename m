Return-Path: <netdev+bounces-287308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNVJBueZA2p27wEAu9opvQ
	(envelope-from <netdev+bounces-287308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:21:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 717A052A377
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19736306C3C9
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94515379C55;
	Tue, 12 May 2026 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PWARkuK/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26628357D19
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620899; cv=none; b=gbTiQHSOtTebvUMjGE8M8Tf1yErqBtFWynWtIJUXS5RgUesWVgAF5b0fz60isU87mnVT4gm5ufO4dj7iaMcBV1cNdUPTdVr+K4FiVKxXbG1RseArYln2mjFN++UaLyR6f6+YF1dpG+hAnTQGbR3agPMF/1E2tUdRIfYOzeWCxGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620899; c=relaxed/simple;
	bh=ZreFQtX/Nm8nnTIYzrKqjmFmDNrdFUpuv0A5omdi8KE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZPu41RnxvnNTMduMoDLdhROUmTSXjdgqruP6ZEbyb2nXk2vD2jngN4s43pok5o1M6NJHkT1a40+1vY/HEWeGT7F5Cc9FxLCccrb6HfYtXu7RdlMzigVpzQtsTuN0RCUCSzC7NwmaDyeIS1wZzaos+498MEn2+TS+uLknbb+9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PWARkuK/; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2ba1e9d3687so39694305ad.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620897; x=1779225697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5N/aiikmvqNMuuf2jP9nM0ku7DfZyr7Pis/tFxzFic=;
        b=OfnQ/txL6BcROs7ensBhI5R9T2rPEwWvEXAAVjzgdPTlkkQgTYSXnicBVKHGiNhkLX
         09mH6U7wcgkCkDUkc8oWb7NuFEeJCUER4hfCm8G9LlxkaSEmL5xnKJRurLBYqYeB5E6u
         zjiyy6BGs/j5r5LeObTZmEw5uSLv60hwWaGX1dkOSdNindjHNdMgiBxID6H1Evl/44oJ
         1n786lQeKkWcoAfnDzTYMZnLDUwQG/mzA9a80qqTKHOEBSywwJb6V2LoMBfxdrUcyN3R
         bNRsnEdriP/bLflWef57l0RNQPPetyVDDzSb5rRsaIy3BBcpfO1l9Qr6FUMvsPcQUtrg
         CGiA==
X-Gm-Message-State: AOJu0YxeF3cRYIuoOM5yrB3HW2kGNVqww7OF3FKuzCcVufXAptS3NK+z
	LWhschMSZ+9pCQ2vJILIh234ZaBQY8LQUIqwxAa2R2Ergqz1Ru/XJR/BPFAbx12rs/EpWfodigY
	J5bx6UCAluF9dW3AluGHeDkGPrSRu4gUYhVATN/BwoXIPHk3ncG4IarydmXnIajzzxU+P0MOaPV
	E7WwfPHlCYpZtcwnPVEQl+Q6fkl1nh7L3e34vMUHM9o1b5fl44TXR/imVeCQIbm/7klNO6IHxvD
	mPgmxSCXYg=
X-Gm-Gg: Acq92OE+aK7kvP9xoLSjCWaSIfNxD+YrQ+HmtcFZLm0YRLbQO+O5USg9ylIs77Ye+sw
	TGZRzbccs8bFGMpInn67yOiUq0HbC5eMBXQcVv6cPnqa3eULTpUXzWK3GAal0hoFPlIeNugCSE4
	eEwSpvD8cNG7VzcaCFChvGroe8r1G7zUrPiDQ28LGXF5ox9pT8zh3h3BW1iTi8LQQx3YXSW3wih
	phrfWUjJiP0YvBJt3Iak1Ewh725J+Ryx5HV8xApiypgOKj+kM5WQZ/8WnaqUMVP/Do2oTIWDBUg
	S1NMmaSMnf++DcR7sr+JS0w7ZqA7+DvcDA7p6j8hWaXhe3IVBUvjHvgknmUuO0fO37AlFxcZaWA
	FKOqwAaW2Gm5y4ZM9W3SHq4SzwJB125M47x95ZVdJb7NSJsUje10Nw8G+sweNmpyqYljsxXytEN
	i4ZKB64tH0WlECFA60xRrq+Hm95syWS18JJ2sXjZADNSpJ1oXOEJUgJesr
X-Received: by 2002:a17:903:2b0e:b0:2ba:6ca2:bca with SMTP id d9443c01a7336-2bd275a9707mr6759875ad.26.1778620897338;
        Tue, 12 May 2026 14:21:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2baf1ead595sm10732545ad.27.2026.05.12.14.21.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2026 14:21:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-132a8f93432so12235494c88.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778620894; x=1779225694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E5N/aiikmvqNMuuf2jP9nM0ku7DfZyr7Pis/tFxzFic=;
        b=PWARkuK/D14RweQrf7/jSXHSvAl4LrZOBBpILIAXIl2WiUj7OekLGcsHWg6ai2D3JI
         YeSARUXMZN/1CwzZwXu/cAiZgGrKdB4wTNC7DnbtBnE3HQn4I1pf1zWzkgGldy455Vzg
         5Tt13K9l0ClPMUEJSLrt78brr77aOZ3ixycss=
X-Received: by 2002:a05:7022:626:b0:12b:ec67:3529 with SMTP id a92af1059eb24-1349a807f49mr80033c88.14.1778620894324;
        Tue, 12 May 2026 14:21:34 -0700 (PDT)
X-Received: by 2002:a05:7022:626:b0:12b:ec67:3529 with SMTP id a92af1059eb24-1349a807f49mr80014c88.14.1778620893800;
        Tue, 12 May 2026 14:21:33 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm26603202c88.15.2026.05.12.14.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:21:33 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 00/15] bnxt_en: Add kTLS TX offload support
Date: Tue, 12 May 2026 14:20:50 -0700
Message-ID: <20260512212105.3488258-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 717A052A377
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287308-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This patchset adds kTLS offload support for TX direction.  A number
of new files are added:

bnxt_mpc.[ch] handle midpath channels (MPCs) used to offload kTLS
connections to the chip's crypto blocks without going through FW.

bnxt_crypto.[ch] handle the crypto interface and resources.

bnxt_ktls.[ch] handle kTLS offload.

A new CONFIG_BNXT_TLS is added to enable all of the above.  The first 6
patches add the MPC logic including resource accounting and reservations.
The next 5 patches add the crypto logic to handle the crypto resources
and to send/receive control data using the MPCs.  The last 4 patches
add kTLS offload for the TX direction.

There will be a follow-on patchset to make the TX offload more complete
and to add the RX direction offload.

v2:
Fix unused variable compile warnings in patch 10 and 12 by reorganizing
the patches (reported by Jakub)

Fix some error recovery issues in patch 12

v1:
https://lore.kernel.org/netdev/20260504235836.3019499-1-michael.chan@broadcom.com/

Michael Chan (15):
  bnxt_en: Add Midpath channel information
  bnxt_en: Account for the MPC TX and CP rings
  bnxt_en: Set default MPC ring count
  bnxt_en: Rename xdp_tx_lock to tx_lock
  bnxt_en: Allocate and free MPC software structures
  bnxt_en: Allocate and free MPC channels from firmware
  bnxt_en: Allocate crypto structure and backing store
  bnxt_en: Reserve crypto RX and TX key contexts on a PF
  bnxt_en: Add infrastructure for crypto key context IDs
  bnxt_en: Add MPC transmit and completion functions
  bnxt_en: Add crypto MPC transmit/completion infrastructure
  bnxt_en: Support kTLS TX offload by implementing .tls_dev_add/del()
  bnxt_en: Implement kTLS TX normal path
  bnxt_en: Add support for inline transmit BDs
  bnxt_en: Add kTLS retransmission support

 drivers/net/ethernet/broadcom/Kconfig         |   9 +
 drivers/net/ethernet/broadcom/bnxt/Makefile   |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 206 ++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  84 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 575 ++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  | 223 ++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  50 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.c    | 458 +++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.h    | 128 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 711 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 210 ++++++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   4 +-
 include/linux/bnxt/hsi.h                      |  37 +
 15 files changed, 2654 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h

-- 
2.51.0


