Return-Path: <netdev+bounces-24944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96A67723DA
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3551C20A8D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 12:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAD4101D9;
	Mon,  7 Aug 2023 12:25:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B1101CA
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:25:33 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D169E6F
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 05:25:31 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-56433b18551so2530379a12.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691411131; x=1692015931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICV3oSZrEepyfkdFh294C2oc/HDgt3q4tnvL6u1XOSo=;
        b=b6g1SIob3LrwBUcULHenYei5xyOCHfj5Kh/mGyOEaHiip8n13U8ZcRqE1k4T3MDRRM
         x2lyr1DY3nGrczG7wBhPI60UBpEUdI9Yp4s5Q5XKKOaIvcIYIfsq0SHygtuZHrrI7/sJ
         Dlw1F7V3yl9asBUH5U+jnwECabs8oBnRRvhpSAs5tbaWVm8eZsL1DqJT3hUePtkjCdh7
         bvda0PHpxMRijzygp+Y8ikxGAeYHfTAnRmjG5DASvvWfIX12EvDGN49oe5Z6lsQwmrxz
         JgtNTjH/Frz9Dr2Sj/uWIuSuX/buM8Vv/M5TcyzdDutZU8EX80YmYzJCZuv/0ObD+jQG
         sWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411131; x=1692015931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICV3oSZrEepyfkdFh294C2oc/HDgt3q4tnvL6u1XOSo=;
        b=bZvzh5kzA7/xvnyKqL0t2wmAR6IURZYch2hnUJ2MgfhBb2amJParyXmKydrN4RML9M
         WQTtEk+ee3beTOSmv7LkhLJ8y+QvkDMswCGNYe0SV3SMBiI1ndIeG2dfTw8EaSlXLOPn
         lC0fdHqn3mmpI7490loLlOGHLNMrvve6CZprWaemYtBPgxQx8N5awnSUAv4YlMIw5INU
         2ARXsuBBtdWZQ+vG1wqJmDlh8o6u+W6b+n/O7MQdQrVjfpe7l5dviINjSQf4kCeyJn3k
         zV1AbMBLjkaQZmEU+bDrG2dp+WODsnDU1pKuYYr2fh5BPpFbrXFeNgI0N2MsDwTw/8Qp
         KXtw==
X-Gm-Message-State: AOJu0YwWFobu6ZEOO1bLh1+2zZXyMUDkQVV6JFXzK5diE+68JpgsVoE+
	gF4nIDl7bq/F+HkmI5SqJOxzsg==
X-Google-Smtp-Source: AGHT+IHci0yjfkSv+HxTsOnZgFme2ZxQQuK4ytn/nitEZzci3avLuAUQEYY9VIvr9bZB5W1yGy+2Gg==
X-Received: by 2002:a17:90b:692:b0:268:6e30:600f with SMTP id m18-20020a17090b069200b002686e30600fmr7060392pjz.32.1691411130684;
        Mon, 07 Aug 2023 05:25:30 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090a4b4e00b00268b439a0cbsm5942391pjl.23.2023.08.07.05.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:25:30 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: 
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC v2 Optimizing veth xsk performance 6/9] veth: add ndo_xsk_wakeup callback for veth
Date: Mon,  7 Aug 2023 20:25:22 +0800
Message-Id: <20230807122522.85762-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230807120434.83644-1-huangjie.albert@bytedance.com>
References: <20230807120434.83644-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

add ndo_xsk_wakeup callback for veth, this is used to
wakeup napi tx.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 28b891dd8dc9..ac78d6a87416 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1805,6 +1805,44 @@ static void veth_set_rx_headroom(struct net_device *dev, int new_hr)
 	rcu_read_unlock();
 }
 
+static void veth_xsk_remote_trigger_napi(void *info)
+{
+	struct veth_sq *sq = info;
+
+	napi_schedule(&sq->xdp_napi);
+}
+
+static int veth_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
+{
+	struct veth_priv *priv;
+	struct veth_sq *sq;
+	u32 last_cpu, cur_cpu;
+
+	if (!netif_running(dev))
+		return -ENETDOWN;
+
+	if (qid >= dev->real_num_rx_queues)
+		return -EINVAL;
+
+	priv = netdev_priv(dev);
+	sq = &priv->sq[qid];
+
+	if (napi_if_scheduled_mark_missed(&sq->xdp_napi))
+		return 0;
+
+	last_cpu = sq->xsk.last_cpu;
+	cur_cpu = get_cpu();
+
+	/*  raise a napi */
+	if (last_cpu == cur_cpu)
+		napi_schedule(&sq->xdp_napi);
+	else
+		smp_call_function_single(last_cpu, veth_xsk_remote_trigger_napi, sq, true);
+
+	put_cpu();
+	return 0;
+}
+
 static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			struct netlink_ext_ack *extack)
 {
@@ -2019,6 +2057,7 @@ static const struct net_device_ops veth_netdev_ops = {
 	.ndo_set_rx_headroom	= veth_set_rx_headroom,
 	.ndo_bpf		= veth_xdp,
 	.ndo_xdp_xmit		= veth_ndo_xdp_xmit,
+	.ndo_xsk_wakeup		= veth_xsk_wakeup,
 	.ndo_get_peer_dev	= veth_peer_dev,
 };
 
-- 
2.20.1


