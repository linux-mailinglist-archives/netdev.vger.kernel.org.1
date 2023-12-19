Return-Path: <netdev+bounces-59044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727C38191F7
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 22:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAE31C250D6
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 21:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518A43DBA0;
	Tue, 19 Dec 2023 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="hVQfTmM3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3B3A29B
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d7395ab92cso1743028b3a.2
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 13:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703019853; x=1703624653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkWI+jBk9ibeTFLlqTLjoDgBCcMIsyS5O3uAoss9Ttk=;
        b=hVQfTmM3DGTVb0Jan2JmJg5ujHubg0EH2ANU5ALsN4ZlCGRUqKSThlyVoG3cXCt6gM
         o0zGDSXVWz0CBIfLNpyAJaXOn2ej86C7V//wnQQHmhD82gFLmqWy254/QTdHe+ElPkSN
         AwuLwc+0aZpnVJhuVBNt4gAuG7+PhhP5JCrCNmLHnWVRk8gCK5T5lKmqrjiaVE6nwpeX
         a2ciwGXVYSWJPGG4EOaHdoevMfdaZzERV/kd5ApQx0jIxn/8LFtVp3XhOXeS4lKH7mzr
         tGygr/wgMbAPN2w1MZp3L8HtK6DXwC/Krno/uzbTeakRFmIYfSFx3hNqu0ZpkVR719ET
         wl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703019853; x=1703624653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkWI+jBk9ibeTFLlqTLjoDgBCcMIsyS5O3uAoss9Ttk=;
        b=wE0g9Gho6lP7VgJb4VzYT1JfjcM9hrXPioPDx0ON24JbEP33bBR7GmiYt08COerTTA
         oo+wX5SQDc8/6i34/R1w9gdZzxEGCrxfzfNTG43gN/FRJGAqFuRfKRtcB4WKBX8cOzNZ
         9qx0wae9wEvu66D1ggWBC5E6Eq5ub0dmdcZ2j3ik7TLBCpMXifGzxPzi56v6Lb7Ws4pk
         Ad0/fKgWTPfzY4NgX9wrhIsLDIjKUl3E50qbvZPXohYCR9cmwfOhARAvNjurkPe7/APb
         NK41cdmrEUMmnLeSO09pH5rddVejdWwcRbxh0qyqLwfWiWFqb1SaQIL7cVuX3FZSnUb0
         hgXQ==
X-Gm-Message-State: AOJu0Ywnl+XvouzStnOYTxLj2AXaAwk4rYBEvja6miEWYsiEj5FcrX0W
	1jG2cNnchT4TAwmH3KGyjMTyyA==
X-Google-Smtp-Source: AGHT+IFkIV9kmjgRboZ06qcSOFb/5LLi9sCmzo0B4VxRAsTpi263CWRkMG9FMB5SxtZFYbwU0PQDWQ==
X-Received: by 2002:a17:902:d4c7:b0:1d0:910e:5039 with SMTP id o7-20020a170902d4c700b001d0910e5039mr10917744plg.77.1703019853402;
        Tue, 19 Dec 2023 13:04:13 -0800 (PST)
Received: from localhost (fwdproxy-prn-019.fbsv.net. [2a03:2880:ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b001bf044dc1a6sm21422316plc.39.2023.12.19.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 13:04:13 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>
Subject: [RFC PATCH v3 09/20] netdev: add XDP_SETUP_ZC_RX command
Date: Tue, 19 Dec 2023 13:03:46 -0800
Message-Id: <20231219210357.4029713-10-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231219210357.4029713-1-dw@davidwei.uk>
References: <20231219210357.4029713-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wei <davidhwei@meta.com>

RFC ONLY, NOT FOR UPSTREAM
This will be replaced with a separate ndo callback or some other
mechanism in next patchset revisions.

This patch adds a new XDP_SETUP_ZC_RX command that will be used in a
later patch to enable or disable ZC RX for a specific RX queue.

We are open to suggestions on a better way of doing this. Google's TCP
devmem proposal sets up struct netdev_rx_queue which persists across
device reset, then expects userspace to use an out-of-band method (e.g.
ethtool) to reset the device, thus re-filling a hardware Rx queue.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/linux/netdevice.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a4bdc35c7d6f..5b4df0b6a6c0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1097,6 +1097,7 @@ enum bpf_netdev_command {
 	BPF_OFFLOAD_MAP_ALLOC,
 	BPF_OFFLOAD_MAP_FREE,
 	XDP_SETUP_XSK_POOL,
+	XDP_SETUP_ZC_RX,
 };
 
 struct bpf_prog_offload_ops;
@@ -1135,6 +1136,11 @@ struct netdev_bpf {
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


