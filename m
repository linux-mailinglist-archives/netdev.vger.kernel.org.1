Return-Path: <netdev+bounces-203813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA62AF7513
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0E9541666
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70DC2E62AE;
	Thu,  3 Jul 2025 13:09:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E92E267E;
	Thu,  3 Jul 2025 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548182; cv=none; b=mQABWyGA/cQtTQZJeuwFqOM4HpcwqwtadgXDtSXsD0IkocjNnzs/+rytxqWxGlwK6FQO/oTrSU8oIGHcDKz3zzm8m6mWRSzQgCJy6Hfw9fqbDS38vURgwTcOatst8REWJEIy5rW2fJ61xM6FMT+O4iVk0myMn3yX0R8GTQrj/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548182; c=relaxed/simple;
	bh=kgui7inL/vqDsBTMEH69lNiIWQHRQWTR+OPqeHY6vs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=htTk3xkMs+EWIia+8HkcNosg86Txm4InmJrzEC3niEK8/ICirdfZlxXxAIbw7KstKY3/4dwKSc225EDS/jhZkc0I+jmdF5HX+6jUDk/pCv8NygL5nYSGYS8zieMZQ3HsivXdHhzLbX+XXf6/daxdHkEVnUmzW73TBevP8MeupBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so9682423a12.1;
        Thu, 03 Jul 2025 06:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751548179; x=1752152979;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbShCvDOHKErkMP/Gg1T/sR3JkdeJYzMVJhkxwSXBGw=;
        b=miD0VAe/4DAcEuqUZalWA0vsczvmi2J3OqiHBiQh5y2pnPzSpWlMB3hhrgBCLoLE5R
         o2BecKWNGVDlha1opmmqZNhJeDPaPqP1bOa+boFOCAGDDZDG5ajWyRTTxEZYrRtdqoqP
         /OUt6/yjHF9Ogf5Wsj9MQ6fFDyJHIjaNj/ucylrYWaxvQNJ6TTedPH8P70LwH4dC4YeE
         ij433+iOcPIlgZgGRfewWzTivMh6b/vsX1Oi6XX83t2a6nVFNyIrQKvpivQ5KA/kdK56
         CwrXJ6/82eMJ1Rt5HmyotAbp8GqqJLah2LP71AKprzVY83qHCrLbrxJvOfPOMCOcKbfq
         5LPw==
X-Forwarded-Encrypted: i=1; AJvYcCULE6RRBngmA5C432Z6CDfq7f95eT3bnzkXhH/8spZxusC5IVJJLWUxfSUb8IY3n8PLyCQB4bg2en1bmLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCa3NcmF33JmKs8mC2fJNegV3ms92ipKyEaw9ct+qEamat14S7
	9qebl5HFYaMu88RaW/fJcvIwkfcTndrEBW70D2/NaI0jMqZcA8OcmZp/
X-Gm-Gg: ASbGnct0TXuIavVuqzXTG1bfv0kNC/CR3ps2wbJS5GwT1SnqiuquNzT2PYKrLma/6ln
	vxXJt92aGWkZdcvX1kMkUooUuyGq2NqMwGckYlux/C/2XZaJkU+MITja9BfWhTWLYgpyvy8gJXI
	SvWLCXeowD2h4qZZV3eT+eA5sVy/9YyWSzTpnNBvCQc/FFdudOBXJ8xp8fyyGFO1tFx4wUjwD5F
	k9FD78PSLOAImghpLjqsjT/9rlpb29wkXY38NSpWHS57dupjNyZGRlMq3GW4eX6AgJr4RMOwLkn
	SXgvxrPCnmOIoC0NjeQdBCfMSpiaUzgdS/IAxBWOpc1CSr7+GqfRHw==
X-Google-Smtp-Source: AGHT+IH7hCjykRgI9mpodZMOhaf85NYz4FocHyyQgjmldVU3vGkcWKPV4AoKvcwsfoHIqsVpJ5ac/Q==
X-Received: by 2002:a05:6402:2113:b0:602:1b8b:2925 with SMTP id 4fb4d7f45d1cf-60e52e3ba2amr5561204a12.29.1751548178913;
        Thu, 03 Jul 2025 06:09:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3c55ed0d8sm300195766b.184.2025.07.03.06.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 06:09:38 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 03 Jul 2025 06:09:31 -0700
Subject: [PATCH net-next v2] netdevsim: implement peer queue flow control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-netdev_flow_control-v2-1-ab00341c9cc1@debian.org>
X-B4-Tracking: v=1; b=H4sIAAqBZmgC/23N0QqDIBSA4VeRc51Djyupq73HiKg8lRAaKq4Rv
 fvA613/8P0XRAqWInTsgkDZRusddAwrBvM2upW4NdAxQIG1aJTgjpKhPCy7/wyzdyn4neOERum
 2qZXWUDE4Ai32LOobHCXu6EzQVww2G5MP37LLsvQiayH/yllyyfEpFLbL3MpJvgxNdnQPH1bo7
 /v+AVBVVdLBAAAA
X-Change-ID: 20250630-netdev_flow_control-2b2d37965377
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, dw@davidwei.uk, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=4672; i=leitao@debian.org;
 h=from:subject:message-id; bh=kgui7inL/vqDsBTMEH69lNiIWQHRQWTR+OPqeHY6vs0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZoERcft8bK3dMVKQb6yXmuyia5dVmmZX1fuCW
 OdEkvDfGveJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGaBEQAKCRA1o5Of/Hh3
 beP7D/0RIGkLt+gYe9hGiFpgO5Vbjel27Tcg8bhVWGFHBrhltBotjNvwizDW8kHBktKc9Lbm7Ef
 y4asKd46RjeOczmGeWWpJUKy1LAzmnASk3bCdLP9eKzV9hyad28xX8aGBRTKMJ1caM63nQQPx/C
 uNyy8Bht3yHmbpgOC5w+MQeLeZifPYdR6yBptJ/grZ72CUe8hEsNRcoijhB4ZtnAenwv6mTSE5E
 nL5hh5KiOgDBEo/r6Pgkrk8T0ID9JK6M0tLb7uzolNcGm1sHIVhzzvSFG93Cs/8KGd0o+PHddoi
 r8mwu0yxZa7NQmb9ndBszgS5eGtwOBj0rLHNxmt3imw9tSA9wPmba6+fD0s/+NUdH/H0Z+nSoQM
 oPehLXmtN0qbVU1KZ9oA7Rlen9XHqjxiGqN7Bsb5brSRXsg8gWViReUt23PnjYl/BmT23dw7ajx
 bpe0EPf+HzeCjGsjv3sOnczi1+2M39GP+x7qX2ABWLG8surlZ5Twi3BVPG7K3hjlZh360bPnM0L
 is/DHNpDL+Kb7HBaWR4jCYRGkNWlkiXnSpVqbdtsAsZC26V7QwHgbpsjKJEGxP83gyYoL5Mcl85
 yrdFE20Clu64UDZtrWpq5RabfErPdmZwPLM9zVfdsn5GaaG9edhLTvHKsnFyXmNw4ohEuGiMa3d
 8mRGkISuF1Uh9bw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add flow control mechanism between paired netdevsim devices to stop the
TX queue during high traffic scenarios. When a receive queue becomes
congested (approaching NSIM_RING_SIZE limit), the corresponding transmit
queue on the peer device is stopped using netif_subqueue_try_stop().

Once the receive queue has sufficient capacity again, the peer's
transmit queue is resumed with netif_tx_wake_queue().

Key changes:
  * Add nsim_stop_peer_tx_queue() to pause peer TX when RX queue is full
  * Add nsim_start_peer_tx_queue() to resume peer TX when RX queue drains
  * Implement queue mapping validation to ensure TX/RX queue count match
  * Wake all queues during device unlinking to prevent stuck queues
  * Use RCU protection when accessing peer device references

The flow control only activates when devices have matching TX/RX queue
counts to ensure proper queue mapping.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Move the RCU locks inside the function (David)
- Use better helpers for waking up all the queues (Jakub)
- Link to v1: https://lore.kernel.org/r/20250701-netdev_flow_control-v1-1-240329fc91b1@debian.org
---
 drivers/net/netdevsim/bus.c    |  3 ++
 drivers/net/netdevsim/netdev.c | 63 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 64c0cdd31bf85..1ba52471f3fbc 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -366,6 +366,9 @@ static ssize_t unlink_device_store(const struct bus_type *bus, const char *buf,
 	err = 0;
 	RCU_INIT_POINTER(nsim->peer, NULL);
 	RCU_INIT_POINTER(peer->peer, NULL);
+	synchronize_net();
+	netif_tx_wake_all_queues(dev);
+	netif_tx_wake_all_queues(peer->netdev);
 
 out_put_netns:
 	put_net(ns);
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e36d3e846c2dc..b5b13fba6450d 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -37,9 +37,67 @@ MODULE_IMPORT_NS("NETDEV_INTERNAL");
 
 #define NSIM_RING_SIZE		256
 
-static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
+static void nsim_start_peer_tx_queue(struct net_device *dev, struct nsim_rq *rq)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+	struct net_device *peer_dev;
+	struct netdevsim *peer_ns;
+	struct netdev_queue *txq;
+	u16 idx;
+
+	idx = rq->napi.index;
+	rcu_read_lock();
+	peer_ns = rcu_dereference(ns->peer);
+	if (!peer_ns)
+		goto out;
+
+	/* TX device */
+	peer_dev = peer_ns->netdev;
+	if (dev->real_num_tx_queues != peer_dev->num_rx_queues)
+		goto out;
+
+	txq = netdev_get_tx_queue(peer_dev, idx);
+	if (!(netif_tx_queue_stopped(txq)))
+		goto out;
+
+	netif_tx_wake_queue(txq);
+out:
+	rcu_read_unlock();
+}
+
+static void nsim_stop_peer_tx_queue(struct net_device *dev, struct nsim_rq *rq,
+				    u16 idx)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+	struct net_device *peer_dev;
+	struct netdevsim *peer_ns;
+
+	rcu_read_lock();
+	peer_ns = rcu_dereference(ns->peer);
+	if (!peer_ns)
+		goto out;
+
+	/* TX device */
+	peer_dev = peer_ns->netdev;
+
+	/* If different queues size, do not stop, since it is not
+	 * easy to find which TX queue is mapped here
+	 */
+	if (dev->real_num_tx_queues != peer_dev->num_rx_queues)
+		goto out;
+
+	netif_subqueue_try_stop(peer_dev, idx,
+				NSIM_RING_SIZE - skb_queue_len(&rq->skb_queue),
+				NSIM_RING_SIZE / 2);
+out:
+	rcu_read_unlock();
+}
+
+static int nsim_napi_rx(struct net_device *dev, struct nsim_rq *rq,
+			struct sk_buff *skb)
 {
 	if (skb_queue_len(&rq->skb_queue) > NSIM_RING_SIZE) {
+		nsim_stop_peer_tx_queue(dev, rq, skb_get_queue_mapping(skb));
 		dev_kfree_skb_any(skb);
 		return NET_RX_DROP;
 	}
@@ -51,7 +109,7 @@ static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
 static int nsim_forward_skb(struct net_device *dev, struct sk_buff *skb,
 			    struct nsim_rq *rq)
 {
-	return __dev_forward_skb(dev, skb) ?: nsim_napi_rx(rq, skb);
+	return __dev_forward_skb(dev, skb) ?: nsim_napi_rx(dev, rq, skb);
 }
 
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -351,6 +409,7 @@ static int nsim_rcv(struct nsim_rq *rq, int budget)
 			dev_dstats_rx_dropped(dev);
 	}
 
+	nsim_start_peer_tx_queue(dev, rq);
 	return i;
 }
 

---
base-commit: be4ea6c336b9a4fc1cc4be1c0549b24d0e687488
change-id: 20250630-netdev_flow_control-2b2d37965377

Best regards,
--  
Breno Leitao <leitao@debian.org>


