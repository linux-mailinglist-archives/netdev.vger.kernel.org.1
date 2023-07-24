Return-Path: <netdev+bounces-20604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176FD76037B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 02:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487B21C20D09
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195FD134C1;
	Tue, 25 Jul 2023 00:00:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7DE15484
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:00:12 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E809171E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:00:09 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-563bcd2cb78so744417a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690243209; x=1690848009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b2a2EwusvFoc235pktXY/nIycpWVex16wqLhee3jeA4=;
        b=kQx8Vt5ByAzdsbZZyTLJV+DrKdYLTUXs6wNFNOIpYvqowtQCrv9aSgqtb6eVW4iccF
         Kq3iy5Cs+ku1wxCHTGkdpyMXut5xxv5C54JKXpxoqt4GxTX02cT9LwlI1Xwpt/lGWasV
         jeDTsSKMPrmenQDmsISd8JVvioi+PL0tk/RAFU+UMlHwzEclxeOiOFmlN3NnBlX16i3B
         A6ylPJBNYbjpi0/MuiWAcdqYUppcBhjuSm93r1R2ZhdpSedEW/gLVgV7LCTiet8gBSLQ
         DN4TrAY30H+IdI1S93AuFTcG5FpuimHRSUWqW6vAseWXI7ncYySm5R6nlEYwzJHtk/uc
         gL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690243209; x=1690848009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2a2EwusvFoc235pktXY/nIycpWVex16wqLhee3jeA4=;
        b=X2bHFjHRfppNm49pteow1ch3N/4XwoNvJBEgyCkuJLbLXiLY5sgK5Gytrfl97Ys9N1
         cgFn3t/7SV7g+YA1qtALY8ITNwyTflsAeOl2/r9T1XtrazsHlF2T00iB2J/yY1aQDzq0
         ZYJeeKSYPEROf0R5dl/xZ1NwiwSxGGcNteFL0pdJAzMyc8ObIsMT+b8WWpTbKXAbTR/s
         m9b1GAMBck+pkrELitYeal7Qe0iVXecj8lyF4JmnvfKxpL/npF+MQkf653TmouBUOYRL
         rWpaRbd04Kf/bO7dha1n7RZkFHBpJo+OebHrYiGslBWlpIj44ZVieYqgci1CzMfyW/q1
         851w==
X-Gm-Message-State: ABy/qLYiPgCpHerN5KEuoQHOEJxqZO8STBeoLySrb0j+65sYhJ8l6Oai
	YVE812znQRuBinIY3A+ZUhEeAn0=
X-Google-Smtp-Source: APBJJlGPTBtKFxHsCwBB4LCKIOZEIfd2ck9tFuo2cXcUbuJkFqXNc0zwZG6EUaQOfF/7XAlF7Ey9OXk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7e4a:0:b0:534:6903:efd8 with SMTP id
 o10-20020a637e4a000000b005346903efd8mr47484pgn.1.1690243208808; Mon, 24 Jul
 2023 17:00:08 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:59:54 -0700
In-Reply-To: <20230724235957.1953861-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724235957.1953861-6-sdf@google.com>
Subject: [RFC net-next v4 5/8] selftests/xsk: Support XDP_TX_METADATA_LEN
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add new config field and call setsockopt.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/xsk.c | 17 +++++++++++++++++
 tools/testing/selftests/bpf/xsk.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
index d9fb2b730a2c..cb7e48f24289 100644
--- a/tools/testing/selftests/bpf/xsk.c
+++ b/tools/testing/selftests/bpf/xsk.c
@@ -49,6 +49,10 @@
  #define PF_XDP AF_XDP
 #endif
 
+#ifndef XDP_TX_METADATA_LEN
+#define XDP_TX_METADATA_LEN 9
+#endif
+
 #define pr_warn(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
 
 #define XSKMAP_SIZE 1
@@ -132,12 +136,14 @@ static int xsk_set_xdp_socket_config(struct xsk_socket_config *cfg,
 		cfg->rx_size = XSK_RING_CONS__DEFAULT_NUM_DESCS;
 		cfg->tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
 		cfg->bind_flags = 0;
+		cfg->tx_metadata_len = 0;
 		return 0;
 	}
 
 	cfg->rx_size = usr_cfg->rx_size;
 	cfg->tx_size = usr_cfg->tx_size;
 	cfg->bind_flags = usr_cfg->bind_flags;
+	cfg->tx_metadata_len = usr_cfg->tx_metadata_len;
 
 	return 0;
 }
@@ -613,6 +619,17 @@ int xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
 			umem->tx_ring_setup_done = true;
 	}
 
+	if (xsk->config.tx_metadata_len) {
+		int optval = xsk->config.tx_metadata_len;
+
+		err = setsockopt(xsk->fd, SOL_XDP, XDP_TX_METADATA_LEN,
+				 &optval, sizeof(optval));
+		if (err) {
+			err = -errno;
+			goto out_put_ctx;
+		}
+	}
+
 	err = xsk_get_mmap_offsets(xsk->fd, &off);
 	if (err) {
 		err = -errno;
diff --git a/tools/testing/selftests/bpf/xsk.h b/tools/testing/selftests/bpf/xsk.h
index d93200fdaa8d..325fe0c83e5d 100644
--- a/tools/testing/selftests/bpf/xsk.h
+++ b/tools/testing/selftests/bpf/xsk.h
@@ -212,6 +212,7 @@ struct xsk_socket_config {
 	__u32 rx_size;
 	__u32 tx_size;
 	__u16 bind_flags;
+	__u8 tx_metadata_len;
 };
 
 /* Set config to NULL to get the default configuration. */
-- 
2.41.0.487.g6d72f3e995-goog


