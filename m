Return-Path: <netdev+bounces-16123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB38D74B728
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 21:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C13281917
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 19:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333C517FFC;
	Fri,  7 Jul 2023 19:30:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294D817FF3
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 19:30:35 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722442D6B
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 12:30:21 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b8a4e947a1so47791055ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758221; x=1691350221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8deO8YK9QH1JyxmBLifMsUSraGfEWt+GK3LbNEDBRc=;
        b=vVc7haj5CuY5xwGeuuKW7XMtVU6n0Gal3hAnUKhqyLbsNiD3yqBTgzjSxXC8eONZNY
         qz8diAF0WdtSD1L1na+e3+6Z2UHaa5HfH4w9q5jGkrP+NeCQjNOGWwJr1I/JM5SxtJdV
         g8L0perqeh/rce+xOmT9yzep67oeqIP3ftYRSFb1zb64IdSHj+E8a4Ir+ULrfj1DOJLt
         y1U/rqmUJtfA4VmJoDHYEjysC8LMkNw9NCvtVo6eXxtvt0oK0BjAhWz4nNiZ1RtLzchB
         SVBgKaFo0FSjp44ePSIEsxkACcCHD4u+KDS7Mh7+edqvnjZgxoDQthTHlOwvZCLCLMK/
         vA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758221; x=1691350221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8deO8YK9QH1JyxmBLifMsUSraGfEWt+GK3LbNEDBRc=;
        b=WshBcE2SpRvQ+dkgW4wXncoI8TimHZ9uFHddOthOq+eGV6Ijc7i304mFI8Sj3W/iay
         bq2Q3+axvOZKuKEzaaauxKk3XhbkGFSrGIdgHHb3p6mxmDYgvjJys8x6NMyqUdtJcEn9
         ixaTcJcTcXwOOQhuHbdkYToHSZ6Rf3BqOQt0OadM5Tjgl3PR6heK0GujK/OSXTchACkY
         dVpwAlHNj+F6NpPoG7q89AFZ8VemXyiEKp2Tk8W7PlXE4nRQSJAXAqUnQ9Fw4st1EnUY
         Qk4PI6Vyy1Mnt3UTB80eoJY8HazCk0trtat+C2lkoyN1x7rzfiAv5ZFQqLGDDs0MHTcX
         Vqdw==
X-Gm-Message-State: ABy/qLbu5Jh8qaVNtt+maIbeP0qglNzxKLwq6VaS2ZgLnWn6XVWGpDOO
	MuBea47NdTGZziIrZMBJezZh2xs=
X-Google-Smtp-Source: APBJJlHXBiX0HUdUvRUVZbgJrogX4uLuV9nnqFz6lq3o9UNjG7zRePCrTBStAIhguoDyo5W5TPAUMn8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:8f83:b0:1b5:2607:3256 with SMTP id
 z3-20020a1709028f8300b001b526073256mr5121265plo.6.1688758220937; Fri, 07 Jul
 2023 12:30:20 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:29:59 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-8-sdf@google.com>
Subject: [RFC bpf-next v3 07/14] bpf: Introduce tx checksum devtx kfuncs
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

Add new kfunc that will be used for tx checksum offloading.
The API mirrors existing one from sk_buff:
- csum_start - checksum the packet starting from this position
- csum_offset - put checksum at this offset

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/netdevice.h |  2 ++
 include/net/offload.h     |  5 ++++-
 net/core/devtx.c          | 17 +++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5be6649ea3fa..aeb1fa024d65 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1662,6 +1662,8 @@ struct xdp_metadata_ops {
 			       enum xdp_rss_hash_type *rss_type);
 	int	(*xmo_request_tx_timestamp)(const struct devtx_ctx *ctx);
 	int	(*xmo_tx_timestamp)(const struct devtx_ctx *ctx, u64 *timestamp);
+	int	(*xmo_request_l4_checksum)(const struct devtx_ctx *ctx,
+					   u16 csum_start, u16 csum_offset);
 };
 
 /**
diff --git a/include/net/offload.h b/include/net/offload.h
index 7e2c19c5aaef..d8f908af9e59 100644
--- a/include/net/offload.h
+++ b/include/net/offload.h
@@ -15,7 +15,10 @@
 #define DEVTX_SUBMIT_KFUNC_xxx	\
 	NETDEV_METADATA_KFUNC(DEVTX_KFUNC_REQUEST_TX_TIMESTAMP, \
 			      bpf_devtx_request_tx_timestamp, \
-			      xmo_request_tx_timestamp)
+			      xmo_request_tx_timestamp) \
+	NETDEV_METADATA_KFUNC(DEVTX_KFUNC_REQUEST_L4_CHECKSUM, \
+			      bpf_devtx_request_l4_csum, \
+			      xmo_request_l4_checksum)
 
 #define DEVTX_COMPLETE_KFUNC_xxx	\
 	NETDEV_METADATA_KFUNC(DEVTX_KFUNC_TX_TIMESTAMP, \
diff --git a/net/core/devtx.c b/net/core/devtx.c
index 991a52fe81a3..fd8a9ea125db 100644
--- a/net/core/devtx.c
+++ b/net/core/devtx.c
@@ -106,6 +106,23 @@ __bpf_kfunc int bpf_devtx_tx_timestamp(const struct devtx_ctx *ctx, __u64 *times
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_devtx_request_l4_csum - Request TX checksum offload on the packet.
+ * Callable only from the devtx-submit hook.
+ * @ctx: devtx context pointer.
+ * @csum_start: start checksumming from given position
+ * @csum_offset: add resulting checksum at given offset
+ *
+ * Note, this checksum offload doesn't calculate pseudo-header part.
+ *
+ * Returns 0 on success or ``-errno`` on error.
+ */
+__bpf_kfunc int bpf_devtx_request_l4_csum(const struct devtx_ctx *ctx,
+					  u16 csum_start, u16 csum_offset)
+{
+	return -EOPNOTSUPP;
+}
+
 __diag_pop();
 
 BTF_SET8_START(devtx_sb_kfunc_ids)
-- 
2.41.0.255.g8b1d071c50-goog


