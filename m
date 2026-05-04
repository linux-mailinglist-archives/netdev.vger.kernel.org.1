Return-Path: <netdev+bounces-284098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNcDAVIz+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:01:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8480F4C5108
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6A77303744B
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCBE3FB7EB;
	Mon,  4 May 2026 23:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mv9yheg8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001753FE64B
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939155; cv=none; b=NL9tVTc05/dJFYAP4vniBgNbHjXVjqbRxhWlDdi64wS7T9fO2nBq0t0k4BwSQXKV1wDAfbP7dpU3PAYmoE1VaRzrbmtx/zpvFLs8M+OJJm1XcIfFZaz8pZ/YjoY/I1tGC+OAsGtLVDtS3ZAyX1cDGDR3Z1nW/zPpuPGI3cuPxtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939155; c=relaxed/simple;
	bh=8S94N5AMn2Nw79Id+daK2147NkKHS1v+lvcg2G8yXUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1ogE8aJiIjXtfyJ7jyIi5g6t8VIwDuEfxNTeF/UZT7Y3zx3IbZzyp/uUCpcej/AufRC5Vmz3kgYJWTbz3KnAi5t4jzpmgn3TG0i8qFijZ8RIJQ7FDepzoIUKFcWANzOVCazWzk1I2rwN77cxdEdZk69jpH9PCjypC9kdqQMPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mv9yheg8; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-364f7c42c62so2042715a91.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939153; x=1778543953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vavz6c+PchbYtvmG/R/XGPmcZUThQvUNUiefOF0nwf4=;
        b=dhvvwNLZ4vJ/QDfkYeT5Cx+Wb0yDiQnv9LTjs0gAokW8PXbuR+YZ0uyc4zBEB4lbKo
         u0NXd+N1xvGAIGQK71xb5DfRyQKiQaZKIZF7OrIKKVLWhzZIae4Fc3hZ/3jfggWYJjXc
         kP18Pxw/Xip94zNUjRYrZQzlNazmCAkg36h9L/W4wXlxqKCoinhMHD+kcu4u9a0rKKjo
         pMR8G+NNNBwfNYfb2SscAqKrfWNlx8OLTEk/eL++CpXXRPpKu+C/C8AIzuD17RKiGqHj
         tAXm4RntY81ES2BBeV75HFgQSd9MiMVmMxUGLBNCcjf2cTxhUrSzgY4NKMxklR/7nc4K
         +ewA==
X-Gm-Message-State: AOJu0Yxm0N4s4C1M8S7qTJYhEo3XfycVD6ACxRGpPtPuvz1el2Rdz/Bv
	LgjRiOtptj/OCakk+3Ll1M40qUWF25zV+sgZoxTJbzEKjoOlsy8T20xsw0lMWI+xYL6qAYR3GAt
	ue6E2vZFxiF4clsWOF0p3lHgP289tem1uOA76QpE+piX6dJLUW9+I6BoSRVkjMs4Cj1OLx8KP4u
	7rOxCh4vYfy4FctmORI9+BDwXB7IZMTnAWrSh5A4M12QvyTJ0E99RJwosalupxZ7of8tcYrKnOS
	RPDh14jDaI=
X-Gm-Gg: AeBDieuSvJiOJn5ZXLQ2Xy1ZWEGNeskoKewEnmIS6tFdElb65kFh4mSgFm1Y1jfpxWw
	XA6CZ9rWxj9fS/yRYhCS/TEVPlcQ48w4AYLSlG2+18jzReBVLZGM3ehIg5YSRJ+hHUT+voGgQ7c
	2rIHMg5TxKhs+s0F4hAaWaqFXxTUgMoeNKlWJCFoXmin6Dl5yPSZ1oDt7yLFkcwNZj6YMiiHbmN
	MQNnb6kvU6nYgCU9o+uG0I3v/sK3Zg29LJDi9wFpTcDC+rbenJx/JlI+hGMH8FvccqRJxAWmZ+I
	lGMjC23pTu6v66Ztt/BWjY1r4xOXOb/XegvWDymigOao66bBf9U826NM1SI2k0PLQXtUd5WPdLU
	vDoF357qwCfSda1L8QMHRfsW0gQasUFpux/SeBW5Zpa16OP+T4HhLK/JrbvUjro2uQKpf/e+pX7
	8UWCcZW78rbN7DAZA=
X-Received: by 2002:a17:90b:5830:b0:354:a57c:65db with SMTP id 98e67ed59e1d1-3650ce71f60mr12473723a91.20.1777939152973;
        Mon, 04 May 2026 16:59:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3651617f824sm755398a91.1.2026.05.04.16.59.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 16:59:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8aca172588cso122056146d6.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777939151; x=1778543951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vavz6c+PchbYtvmG/R/XGPmcZUThQvUNUiefOF0nwf4=;
        b=Mv9yheg8F3QZI4FwcsdDiIi7WrtzdZbRxb5qplwxDPnP4pz37LFEPZfCEadvjaAiaw
         lHQXmclEdj0hs53fq7suzGcaTgQdTIHZuSBZX05zzH8ZJ4LnTjX8irOlZGRLSziKYcH8
         3AnF8rfi1eIFlYR607bhmtc+VK2csyu8H1jaI=
X-Received: by 2002:a05:6214:2261:b0:8b1:f8fe:507f with SMTP id 6a1803df08f44-8b669ac48c6mr207329006d6.46.1777939151361;
        Mon, 04 May 2026 16:59:11 -0700 (PDT)
X-Received: by 2002:a05:6214:2261:b0:8b1:f8fe:507f with SMTP id 6a1803df08f44-8b669ac48c6mr207328676d6.46.1777939150904;
        Mon, 04 May 2026 16:59:10 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5396c4b7dsm132298246d6.18.2026.05.04.16.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:59:10 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 00/15] bnxt_en: Add kTLS TX offload support
Date: Mon,  4 May 2026 16:58:21 -0700
Message-ID: <20260504235836.3019499-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 8480F4C5108
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-284098-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]

This patchset adds kTLS offload support for TX direction.  A number
of new files are added:

bnxt_mpc.[ch] handle midpath channels (MPCs) used to offload kTLS
connections to the chip's crypto blocks without going through FW.

bnxt_crypto.[ch] handle the crypto interface and resources.

bnxt_ktls.[ch] handle kTLS offload.

A new CONFIG_BNXT_TLS is added enable all of the above.  The first 6
patches add the MPC logic including resource accounting and reservations.
The next 5 patches add the crypto logic to handle the crypto resources
and to send/receive control data using the MPCs.  The last 4 patches
add kTLS offload for the TX direction.

There will be a follow-on patchset to make the TX offload more complete
and to add the RX direction offload.

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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 205 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  84 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 571 +++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  | 223 ++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  50 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.c    | 455 ++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.h    | 128 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 692 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 210 ++++++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   4 +-
 include/linux/bnxt/hsi.h                      |  37 +
 15 files changed, 2627 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h

-- 
2.51.0


