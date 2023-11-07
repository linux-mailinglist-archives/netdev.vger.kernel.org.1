Return-Path: <netdev+bounces-46505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511057E4ADD
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 22:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D1928137C
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 21:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACAB2A8DC;
	Tue,  7 Nov 2023 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="wcA9Fl/d"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEA636B14
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 21:41:00 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A543710E7
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 13:40:59 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc921a4632so51701585ad.1
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 13:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1699393259; x=1699998059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkhKqBwYYqQgvgkz0J+eF0ekZRGveOzIaQIF+mtTnrA=;
        b=wcA9Fl/dDyAHZQB/CthzMWjAkAj3eG4BmlXKhXDJKRsaavjUo70ITrEmEzjqyRAzmP
         akumYflMxdbaxt1gtxxb6U0MnRduHSYgEoEIP5wn5K4ARFtw+i4VTeRpRhgO0XRarMUt
         lRKBwVI0MN7WI8a2nDPWqRRdSIyXvIQZUoswI0VUh9Y6k62hshQLgH+SA2i1CXrojU8S
         evIRom0Pm39P2x0QrVWkKUWFfxjMRZHY3cFN8azsWHNoLJntyurhTYF2QTd40jDZH87h
         xhIXwmm/PpVgJlYmmjrHphk24OKArppidvc823Y/jvjQf7J9h3f3OprmnQUemG2eUzO0
         3q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393259; x=1699998059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkhKqBwYYqQgvgkz0J+eF0ekZRGveOzIaQIF+mtTnrA=;
        b=jL97euaWaYThyU9li3gkT8TccGmp7rOso7iZ2UE7DB4jKVCBz5/nj1AoB/6IPpLoBh
         +VVYUyir89EhvrKz9U8P+zZwM6xw+VyD7OEEixr3hKmfZ1B5u/sFigJ9hkRiyhTu+mw3
         6rExeyS5IApAMW1RnSOcCyjll099cgtMrW8ftgnbw76zOloQJV1bKIjlpTH5fon5tDWh
         r0LjEeNX6CfS5bSS6+OmBcdynJSwCNnwsi61cyinQpl8k0YxPLfyuY+z9PcuIFLHNK1l
         TsaeWRXk2eNO58IdkxQSHMo2ep3ZUk2+ko/AnFnYrsriLn0S2PCZWhqNabw4GI6yXnhu
         BeBw==
X-Gm-Message-State: AOJu0YxrnO+ql3q/WQJHPq15OVFDSmmxpCH0R7jAUVr3F3myk2uKoG4j
	yYbUfxA5X01e6yYHrSnNMyPeZw==
X-Google-Smtp-Source: AGHT+IFCXiGsm4+uoYT/4g2dHZxdtmbkIAaHx6GCEsyE1kAbJJmkijduufnQHm62qVhcmiS8LbaINA==
X-Received: by 2002:a17:903:2689:b0:1cc:70ed:1d68 with SMTP id jf9-20020a170903268900b001cc70ed1d68mr203111plb.67.1699393259157;
        Tue, 07 Nov 2023 13:40:59 -0800 (PST)
Received: from localhost (fwdproxy-prn-021.fbsv.net. [2a03:2880:ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709026a8c00b001a80ad9c599sm257701plk.294.2023.11.07.13.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 13:40:58 -0800 (PST)
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
	Mina Almasry <almasrymina@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH 03/20] netdev: add XDP_SETUP_ZC_RX command
Date: Tue,  7 Nov 2023 13:40:28 -0800
Message-Id: <20231107214045.2172393-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231107214045.2172393-1-dw@davidwei.uk>
References: <20231107214045.2172393-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a new XDP_SETUP_ZC_RX command that will be used in a
later patch to enable or disable ZC RX for a specific RX queue.

Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
We are open to suggestions on a better way of doing this, rather than
using a bpf_netdev_command.

 include/linux/netdevice.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 11d704bfec9b..f9c82c89a96b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -984,6 +984,7 @@ enum bpf_netdev_command {
 	BPF_OFFLOAD_MAP_ALLOC,
 	BPF_OFFLOAD_MAP_FREE,
 	XDP_SETUP_XSK_POOL,
+	XDP_SETUP_ZC_RX,
 };
 
 struct bpf_prog_offload_ops;
@@ -1022,6 +1023,11 @@ struct netdev_bpf {
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


