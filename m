Return-Path: <netdev+bounces-30828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C817892F2
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 03:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D942819E7
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 01:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9563B81E;
	Sat, 26 Aug 2023 01:21:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8468D818
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 01:21:32 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901751FF7
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 18:21:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-56c2e882416so844380a12.3
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 18:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20221208.gappssmtp.com; s=20221208; t=1693012891; x=1693617691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNgO5ZIv14KVZmuHWpj5cSQRK/umULxc7iSIeMaS/eA=;
        b=xNwKRdqsMh+qCjPp4OBeyPIsa34xOMM0cUzK6Yg3OyHro97dhOGmYbOl6u1MnHSawg
         emgcdbv9xTbN4SU4UljeHyRZhsc4ACF485ui6vFOpna6Bjpl3VhZjDCVImSqZphpuCp9
         kOc58NE3nU45sTbG2clqpPwtCTMrCclDzRqOaZJmYUpbnoL2nChtDxnftBIngLyhFPn/
         WXmtLo32T4q5AZeNwYPrcoHGqWTmXIe7BoMQcy2FJMznQgooT4o4Nj825wGKtcacxT/K
         9AQ0tqCwIghD6xF/bQ0ugmO8RelpH7B9h62pdHYzx9Mr/u7pYZ1WwML10UKRltJpWV9o
         3Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693012891; x=1693617691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNgO5ZIv14KVZmuHWpj5cSQRK/umULxc7iSIeMaS/eA=;
        b=c99f2j/oI14Go7/6tVhinshjtOWWLKFiHgtMFznLC6asDhKbGV5bdJkWSApTeDZ2Si
         ra+u3lXPEUB3LkY87mKMeFG8W9o6pd19yxa3DQrlBrMxglHRp5KG+RI22zfi+VwYA9Nt
         Cfp6gTQ3i3x7pF/XHUcPv+o8IlxRwCFuYSYyPDXQskUtnN9mzg++HwzMtsmkDozGI/6d
         6TOGNPeC3DYbeP/tvVuY5VTQvg0o5p+MVNJB0ipP1H97TTApOI3Sif9Nj+3Ei3v0JTXf
         33MSNwfMULmyHVN8gvjRqJJjxcmCw/JlWr8XQ6sVCX5/5Yg1lp/K+9PtJ6P91rqgYH5t
         IM8A==
X-Gm-Message-State: AOJu0YzwyIcempdH3ZKN+0RevCtemey0ViibOR4fBiUdscD0w37wK6H8
	bQ2f2Yo3IUEUiVwS+OsPQsh+3w==
X-Google-Smtp-Source: AGHT+IFzWc4+ijhlirnZLcO2bqVcRhIBIgdFNaal1xrptHcSU36WHJC7JgXlaeCAvzW0niN/CeFJvQ==
X-Received: by 2002:a05:6a21:3390:b0:14b:f78e:d05c with SMTP id yy16-20020a056a21339000b0014bf78ed05cmr6858254pzb.15.1693012891044;
        Fri, 25 Aug 2023 18:21:31 -0700 (PDT)
Received: from localhost (fwdproxy-prn-120.fbsv.net. [2a03:2880:ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090341ca00b001b9de4fb749sm2420621ple.20.2023.08.25.18.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 18:21:30 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 03/11] netdev: add XDP_SETUP_ZC_RX command
Date: Fri, 25 Aug 2023 18:19:46 -0700
Message-Id: <20230826011954.1801099-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230826011954.1801099-1-dw@davidwei.uk>
References: <20230826011954.1801099-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: David Wei <davidhwei@meta.com>

This patch adds a new XDP_SETUP_ZC_RX command that will be used in a
later patch to enable or disable ZC RX for a specific RX queue.

Signed-off-by: David Wei <davidhwei@meta.com>
Co-developed-by: Jonathan Lemon <jonathan.lemon@gmail.com>
---
 include/linux/netdevice.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 08fbd4622ccf..a20a5c847916 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1000,6 +1000,7 @@ enum bpf_netdev_command {
 	BPF_OFFLOAD_MAP_ALLOC,
 	BPF_OFFLOAD_MAP_FREE,
 	XDP_SETUP_XSK_POOL,
+	XDP_SETUP_ZC_RX,
 };
 
 struct bpf_prog_offload_ops;
@@ -1038,6 +1039,11 @@ struct netdev_bpf {
 			struct xsk_buff_pool *pool;
 			u16 queue_id;
 		} xsk;
+		/* XDP_SETUP_ZC_RX */
+		struct {
+			struct io_zc_rx_ifq *ifq;
+			u16 queue_id;
+		} zc_rx;
 	};
 };
 
-- 
2.39.3


