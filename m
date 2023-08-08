Return-Path: <netdev+bounces-25257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153A27737A6
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 05:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1ADB1C20DED
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 03:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD2120F2;
	Tue,  8 Aug 2023 03:21:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D0DDC2
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 03:21:06 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDD3171E
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 20:21:04 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-53482b44007so3016566a12.2
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 20:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464864; x=1692069664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICV3oSZrEepyfkdFh294C2oc/HDgt3q4tnvL6u1XOSo=;
        b=lutZ0A2WljE0PHMq69IriO2rZ3mTGdwt4yVVFZOwx7KaXGHtsYthZEnorDptzuoR9Z
         3bTfCPeVS8fpSvafHRcMLxrDNgnA2loby72Wgu9cfloNQRxmHCbPK3vKdpTZfK8jUlmF
         7p0hYB/3nnDjWEtIceXVAL8kl4qqmuLDT5CgZQQRARE9KRnFvExGQzyuneXXfHttAgdL
         zsKB0Oh+uxe0BPwxqJaQMOPzn/nTgtz9LdZMlVg0RTJdKhq0bRAT7rJsnC7zn+ynGm5n
         Lymc0VkgXf3C5i+q0ZNqVquZH5V2gVRVSKb9Yn7GpEFzEVlv3u68qZNnVPavuo/G/XFK
         RNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464864; x=1692069664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICV3oSZrEepyfkdFh294C2oc/HDgt3q4tnvL6u1XOSo=;
        b=Wq9an8TKKuHiM1f1B3lyM4EMyqX81xxA14vXIqwPqh0Tak5g/mo+4+Vx/ijRzr3TMe
         Nn7sB7A6DMsYL2sxNgaveEUFVfNw0xoX+sR54NBJCheT1T8Q2TeEvNDu8BzpAPC1iTBm
         /Ovm7yqEPE21HlzZVoMCkaartyPAM+qZZpfCxbz4TAuNUvfU6XRTNAjNgJmYq3U4HhHc
         +Odx5zqedpkakseGjhYZLKiRTIJvWgyBfQi4zy+gAe6kfs3lVlvYUjviO7cO8YRfbUBm
         oLt7RcS0ZTBPWXfOd8KYQXiuWEpPHcuFBJFQ2AZWUKvCGNwPUdWYhwts78IN5KB/31Rp
         ZJIg==
X-Gm-Message-State: AOJu0YyjY3ktdbq5lqdfk2o2E2yohrOesz2bJiNRx9CBVmVa423XrgcY
	Yt//yyRCOROkF8Ms3j3oqIct+w==
X-Google-Smtp-Source: AGHT+IF76sZiV7Ae2VDxsLeP3TXhil8es9a99enu8nvMpK1GwLMowzM4hBRaMRVwS8bSHHASr/moLg==
X-Received: by 2002:a05:6a21:2713:b0:133:2974:d31a with SMTP id rm19-20020a056a21271300b001332974d31amr8482956pzb.17.1691464864453;
        Mon, 07 Aug 2023 20:21:04 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:21:04 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: [RFC v3 Optimizing veth xsk performance 6/9] veth: add ndo_xsk_wakeup callback for veth
Date: Tue,  8 Aug 2023 11:19:10 +0800
Message-Id: <20230808031913.46965-7-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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


