Return-Path: <netdev+bounces-297620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ag0aJTtDKWrNTAMAu9opvQ
	(envelope-from <netdev+bounces-297620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:58:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E38D6687E3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:58:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=lwW4E3FY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297620-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297620-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC52D317CBFF
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F473DB318;
	Wed, 10 Jun 2026 10:41:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4EC3FADF6;
	Wed, 10 Jun 2026 10:41:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088102; cv=none; b=BRnEQQey2kARlia0p6CJad62OKNScJJ5UUAcAt+kuQaoDm4u2lHPNWYCZNKx0Ol2xkbkS2Aom6dtEhQGTRtGNddP+vS1AeeLNkqX5yHIBZGV80UZYj4177Q6wIYNr5jMuq5UJ5q+yer0ASqtDuH7d/TS0Dmb+qqO4wzDbqB8zeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088102; c=relaxed/simple;
	bh=enG7iyL04qv5Y6fIIXAvsWApzHRvvGpJR1IqjSoSwaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NALXisdf0pzb2VxYmGv+ppr9RdjboWXK9zehOfRUnNyInXxya/Zec1mQScTQ/Vda8lxBK0byyaVYxc3lAYa1BaQupHsOl7z7Pi1kK/Qkvmn5wSYUdIzB3sAmXl0zTTFMnoDkg1FKKAhiIifIfxVW29tHH5H91/ub26NfJYbM4X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwW4E3FY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91838C4AF14;
	Wed, 10 Jun 2026 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781088101;
	bh=enG7iyL04qv5Y6fIIXAvsWApzHRvvGpJR1IqjSoSwaI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lwW4E3FYKh+Yj3bp32hZDgj9dQSWSpQ13WUEmmW1v307TsFLPvw9cf0oKrbAiax2U
	 AB/1XIE15fV5otYxFPw2qxZt63Fy3UWHrzo6/zOwiTYuwbuHVMLUcSIAMPA/b9/qFx
	 rxzxat38JnsSXWsMdKJRJV3ufiC7x6YxZ2WyIrnTf+3GkbNjH8uF9B17931NflnWaW
	 b17/CA9YXGSkwrnD54TciIwa9DVGGU6mr979Uc04QZ4snU0JDpM5E9pCxcs0CUFKhZ
	 JoMMZsR0mkY1C6Sp6EAcdvkj7fKd8JZCTSq4WLH13UZ4sL/0RO8mGWdDkYrskqwzp+
	 /RDUkZDpTCydg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D7FCD8CB2;
	Wed, 10 Jun 2026 10:41:41 +0000 (UTC)
From: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Date: Wed, 10 Jun 2026 18:41:09 +0800
Subject: [PATCH v2 6/7] net: wwan: t9xx: Add AT & MBIM WWAN ports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-t9xx_driver_v1-v2-6-c65addf23b3f@compal.com>
References: <20260610-t9xx_driver_v1-v2-0-c65addf23b3f@compal.com>
In-Reply-To: <20260610-t9xx_driver_v1-v2-0-c65addf23b3f@compal.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jack Wu <jackbb_wu@compal.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, 
 Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, 
 Minano Tseng <Minano.tseng@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781088082; l=14707;
 i=jackbb_wu@compal.com; s=20260526; h=from:subject:message-id;
 bh=sLA+K4d0nCKWOYPFV6TUunfp2xvnpTdHd4KA4x5+/5w=;
 b=DekjGbKLcvZz1GVgupsqLTWguKBkkF+WfQPAlljLk7SWsc4T5DbG3FU3kHbJXemAVzgknd+AA
 +QcnrwMFQRJC1/8ZnOuhl0u03kpQ3zlqMHeM2Uwm1vNWhGsV8jfrKc8
X-Developer-Key: i=jackbb_wu@compal.com; a=ed25519;
 pk=VH1prTWixNl8OEUPPSfII3p46MzJpQN8J3+ecE1tZXg=
X-Endpoint-Received: by B4 Relay for jackbb_wu@compal.com/20260526 with
 auth_id=793
X-Original-From: Jack Wu <jackbb_wu@compal.com>
Reply-To: jackbb_wu@compal.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297620-lists,netdev=lfdr.de,jackbb_wu.compal.com];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jackbb_wu@compal.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,compal.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[jackbb_wu@compal.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,compal.com:replyto,compal.com:email,compal.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E38D6687E3

From: Jack Wu <jackbb_wu@compal.com>

Add AT & MBIM ports to the port infrastructure.
The WWAN initialization method is responsible for creating the
corresponding ports using the WWAN framework infrastructure. The
implemented WWAN port operations are start, stop, tx, tx_blocking
and tx_poll.

Signed-off-by: Jack Wu <jackbb_wu@compal.com>
---
 drivers/net/wwan/t9xx/mtk_port.c               |  26 ++
 drivers/net/wwan/t9xx/mtk_port.h               |  15 ++
 drivers/net/wwan/t9xx/mtk_port_io.c            | 337 ++++++++++++++++++++++++-
 drivers/net/wwan/t9xx/mtk_port_io.h            |   5 +
 drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c |   8 +
 5 files changed, 390 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/t9xx/mtk_port.c b/drivers/net/wwan/t9xx/mtk_port.c
index c68437e58ea2..f28f046cf2c9 100644
--- a/drivers/net/wwan/t9xx/mtk_port.c
+++ b/drivers/net/wwan/t9xx/mtk_port.c
@@ -819,6 +819,29 @@ int mtk_port_ch_disable(struct mtk_port *port)
 	return ret;
 }
 
+static int mtk_port_enable_by_type(struct mtk_port_mngr *port_mngr, int tbl_type)
+{
+	struct mtk_port **ports;
+	int ret, idx;
+
+	if (tbl_type < 0 || tbl_type >= PORT_TBL_MAX)
+		return -EINVAL;
+
+	ports = kcalloc(port_mngr->port_cnt, sizeof(struct mtk_port *), GFP_KERNEL);
+	if (!ports)
+		return -ENOMEM;
+
+	ret = radix_tree_gang_lookup(&port_mngr->port_tbl[tbl_type],
+				     (void **)ports, 0, port_mngr->port_cnt);
+	for (idx = 0; idx < ret; idx++) {
+		if (ports[idx]->enable)
+			ports_ops[ports[idx]->info.type]->enable(ports[idx]);
+	}
+
+	kfree(ports);
+	return 0;
+}
+
 static void mtk_port_disable(struct mtk_port_mngr *port_mngr)
 {
 	struct mtk_port **ports;
@@ -852,6 +875,9 @@ void mtk_port_mngr_fsm_state_handler(struct mtk_fsm_param *fsm_param, void *arg)
 	case FSM_STATE_OFF:
 		mtk_port_disable(port_mngr);
 		break;
+	case FSM_STATE_READY:
+		mtk_port_enable_by_type(port_mngr, PORT_TBL_MD);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wwan/t9xx/mtk_port.h b/drivers/net/wwan/t9xx/mtk_port.h
index a201c0007878..cf561add6318 100644
--- a/drivers/net/wwan/t9xx/mtk_port.h
+++ b/drivers/net/wwan/t9xx/mtk_port.h
@@ -56,6 +56,10 @@ enum mtk_ccci_ch {
 	/* to MD */
 	CCCI_CONTROL_RX				= 0x2000,
 	CCCI_CONTROL_TX				= 0x2001,
+	CCCI_UART2_RX				= 0x200A,
+	CCCI_UART2_TX				= 0x200C,
+	CCCI_MBIM_RX				= 0x20D0,
+	CCCI_MBIM_TX				= 0x20D1,
 };
 
 enum mtk_port_flag {
@@ -73,6 +77,7 @@ enum mtk_port_tbl {
 
 enum mtk_port_type {
 	PORT_TYPE_INTERNAL,
+	PORT_TYPE_WWAN,
 	PORT_TYPE_MAX
 };
 
@@ -81,6 +86,13 @@ struct mtk_internal_port {
 	int (*recv_cb)(void *arg, struct sk_buff *skb);
 };
 
+struct mtk_wwan_port {
+	/* w_lock protects wwan_port when recv data and disable port at the same time */
+	struct mutex w_lock;
+	int w_type;
+	void *w_port;
+};
+
 struct mtk_port_cfg {
 	enum mtk_ccci_ch tx_ch;
 	enum mtk_ccci_ch rx_ch;
@@ -108,8 +120,11 @@ struct mtk_port {
 	wait_queue_head_t rx_wq;
 	struct list_head stale_entry;
 	char dev_str[MTK_DEV_STR_LEN];
+	/* Serializes port write operations */
+	struct mutex write_lock;
 	struct mtk_port_mngr *port_mngr;
 	struct mtk_internal_port i_priv;
+	struct mtk_wwan_port w_priv;
 };
 
 struct mtk_port_mngr {
diff --git a/drivers/net/wwan/t9xx/mtk_port_io.c b/drivers/net/wwan/t9xx/mtk_port_io.c
index bbde0d950226..58655678d82b 100644
--- a/drivers/net/wwan/t9xx/mtk_port_io.c
+++ b/drivers/net/wwan/t9xx/mtk_port_io.c
@@ -3,6 +3,10 @@
  * Copyright (c) 2022, MediaTek Inc.
  */
 #include <linux/netdevice.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/wwan.h>
 
 #include "mtk_port_io.h"
 
@@ -39,6 +43,146 @@ static void mtk_port_struct_init(struct mtk_port *port)
 	port->rx_buf_size = MTK_RX_BUF_SIZE;
 	init_waitqueue_head(&port->trb_wq);
 	init_waitqueue_head(&port->rx_wq);
+	mutex_init(&port->write_lock);
+}
+
+static int mtk_port_copy_data_from(void *to, union user_buf from, unsigned int len,
+				   unsigned int offset, bool from_user_space)
+{
+	if (from_user_space) {
+		if (copy_from_user(to, from.ubuf + offset, len))
+			return -EINVAL;
+	} else {
+		memcpy(to, from.kbuf + offset, len);
+	}
+
+	return 0;
+}
+
+static int mtk_port_common_write_frag_skb(struct mtk_port *port, struct sk_buff *skb,
+					  union user_buf buf, u32 packet_size,
+					  u32 cur_pos, bool from_user_space)
+{
+	struct sk_buff *frag_skb, *tmp = NULL;
+	u32 frag_size;
+	int ret;
+
+	frag_size = min(packet_size, port->tx_frag_size);
+	ret = mtk_port_copy_data_from(skb_put(skb, frag_size),
+				      buf, frag_size,
+				      cur_pos, from_user_space);
+	if (ret) {
+		dev_err(port->port_mngr->ctrl_blk->mdev->dev,
+			"Failed to copy skb for port(%s)\n", port->info.name);
+		goto err_reset_skb;
+	}
+	cur_pos += frag_size;
+	packet_size -= frag_size;
+	if (!packet_size)
+		return cur_pos;
+
+	while (packet_size > 0) {
+		frag_skb = __dev_alloc_skb(port->tx_mtu, GFP_KERNEL);
+		if (!frag_skb) {
+			ret = -ENOMEM;
+			goto err_free_frag_list;
+		}
+
+		frag_size = min(packet_size, port->tx_frag_size);
+		ret = mtk_port_copy_data_from(skb_put(frag_skb, frag_size),
+					      buf, frag_size,
+					      cur_pos, from_user_space);
+		if (ret) {
+			dev_err(port->port_mngr->ctrl_blk->mdev->dev,
+				"Failed to copy frag_skb for port(%s)\n", port->info.name);
+			dev_kfree_skb_any(frag_skb);
+			goto err_free_frag_list;
+		}
+		skb->data_len += frag_size;
+		skb->len += frag_size;
+		cur_pos += frag_size;
+		packet_size -= frag_size;
+		if (!tmp)
+			skb_shinfo(skb)->frag_list = frag_skb;
+		else
+			tmp->next = frag_skb;
+		tmp = frag_skb;
+	}
+	return cur_pos;
+
+err_free_frag_list:
+	frag_skb = skb_shinfo(skb)->frag_list;
+	while (frag_skb) {
+		tmp = frag_skb->next;
+		frag_skb->next = NULL;
+		dev_kfree_skb_any(frag_skb);
+		frag_skb = tmp;
+	}
+	skb_shinfo(skb)->frag_list = NULL;
+err_reset_skb:
+	skb->data_len = 0;
+	return ret;
+}
+
+static int mtk_port_common_write(struct mtk_port *port, union user_buf buf, unsigned int len,
+				 bool from_user_space)
+{
+	u32 packet_size, left_cnt = len, cur_pos;
+	struct sk_buff *skb;
+	int ret;
+
+	if (len == 0)
+		return -EINVAL;
+
+start_write:
+	ret = mtk_port_status_check(port);
+	if (ret)
+		goto end_write;
+
+	skb = __dev_alloc_skb(port->tx_mtu, GFP_KERNEL);
+	if (!skb) {
+		ret = -ENOMEM;
+		goto end_write;
+	}
+
+	skb_reserve(skb, sizeof(struct mtk_ccci_header));
+
+	packet_size = min_t(u32, left_cnt, port->tx_mtu - sizeof(struct mtk_ccci_header));
+	cur_pos = len - left_cnt;
+	/* Support scatter gather transmission */
+	if (port->tx_mtu > port->tx_frag_size) {
+		ret = mtk_port_common_write_frag_skb(port, skb, buf, packet_size,
+						     cur_pos, from_user_space);
+		if (ret < 0)
+			goto err_free_skb;
+	} else {
+		ret = mtk_port_copy_data_from(skb_put(skb, packet_size),
+					      buf, packet_size,
+					      cur_pos, from_user_space);
+		if (ret) {
+			dev_err(port->port_mngr->ctrl_blk->mdev->dev,
+				"Failed to copy data for port(%s)\n", port->info.name);
+			goto err_free_skb;
+		}
+	}
+
+	ret = mtk_port_send_data(port, skb);
+	if (ret < 0) {
+		if (ret == -EINTR)
+			left_cnt -= packet_size;
+		goto end_write;
+	}
+
+	left_cnt -= ret;
+	if (left_cnt)
+		goto start_write;
+	else
+		goto end_write;
+
+err_free_skb:
+	dev_kfree_skb_any(skb);
+end_write:
+	return (len > left_cnt) ? (len - left_cnt) : ret;
 }
 
 static int mtk_port_internal_init(struct mtk_port *port)
@@ -101,7 +245,6 @@ static int mtk_port_internal_recv(struct mtk_port *port, struct sk_buff *skb)
 	return ret;
 
 drop_data:
-	dev_kfree_skb_any(skb);
 	return ret;
 }
 
@@ -233,6 +376,198 @@ static const struct port_ops port_internal_ops = {
 	.recv = mtk_port_internal_recv,
 };
 
+static int mtk_port_wwan_open(struct wwan_port *w_port)
+{
+	struct mtk_port *port;
+	int ret;
+
+	port = wwan_port_get_drvdata(w_port);
+	ret = mtk_port_get_locked(port);
+	if (ret)
+		return ret;
+
+	ret = mtk_port_common_open(port);
+	if (ret)
+		mtk_port_put_locked(port);
+
+	return ret;
+}
+
+static void mtk_port_wwan_close(struct wwan_port *w_port)
+{
+	struct mtk_port *port = wwan_port_get_drvdata(w_port);
+
+	mtk_port_common_close(port);
+	mtk_port_put_locked(port);
+}
+
+static int mtk_port_wwan_write(struct wwan_port *w_port, struct sk_buff *skb)
+{
+	struct mtk_port *port = wwan_port_get_drvdata(w_port);
+	union user_buf user_buf;
+	int ret;
+
+	if (unlikely(!skb->len)) {
+		consume_skb(skb);
+		return 0;
+	}
+
+	port->info.flags &= ~PORT_F_BLOCKING;
+	user_buf.kbuf = (void *)skb->data;
+	ret = mtk_port_common_write(port, user_buf, skb->len, false);
+	if (ret < 0)
+		return ret;
+
+	consume_skb(skb);
+	return 0;
+}
+
+static int mtk_port_wwan_write_blocking(struct wwan_port *w_port, struct sk_buff *skb)
+{
+	struct mtk_port *port = wwan_port_get_drvdata(w_port);
+	union user_buf user_buf;
+	int ret;
+
+	if (unlikely(!skb->len)) {
+		consume_skb(skb);
+		return 0;
+	}
+
+	port->info.flags |= PORT_F_BLOCKING;
+	user_buf.kbuf = (void *)skb->data;
+	ret = mtk_port_common_write(port, user_buf, skb->len, false);
+	if (ret < 0)
+		return ret;
+
+	consume_skb(skb);
+	return 0;
+}
+
+static __poll_t mtk_port_wwan_poll(struct wwan_port *w_port, struct file *file,
+				   struct poll_table_struct *poll)
+{
+	struct mtk_port *port = wwan_port_get_drvdata(w_port);
+	union ctrl_hif_cmd_data hif_cmd;
+	struct mtk_ctrl_blk *ctrl_blk;
+	__poll_t mask = 0;
+
+	poll_wait(file, &port->trb_wq, poll);
+	if (mtk_port_status_check(port))
+		return EPOLLERR | EPOLLHUP;
+
+	ctrl_blk = port->port_mngr->ctrl_blk;
+	hif_cmd.rx_ch = port->info.rx_ch;
+	if (!ctrl_blk->ops->send_cmd(ctrl_blk->mdev, HIF_CTRL_CMD_CHECK_TX_FULL, &hif_cmd))
+		mask |= EPOLLOUT | EPOLLWRNORM;
+
+	return mask;
+}
+
+static const struct wwan_port_ops wwan_ops = {
+	.start = mtk_port_wwan_open,
+	.stop = mtk_port_wwan_close,
+	.tx = mtk_port_wwan_write,
+	.tx_blocking = mtk_port_wwan_write_blocking,
+	.tx_poll = mtk_port_wwan_poll,
+};
+
+static int mtk_port_wwan_init(struct mtk_port *port)
+{
+	mtk_port_struct_init(port);
+	port->enable = false;
+
+	mutex_init(&port->w_priv.w_lock);
+
+	switch (port->info.rx_ch) {
+	case CCCI_MBIM_RX:
+		port->w_priv.w_type = WWAN_PORT_MBIM;
+		break;
+	case CCCI_UART2_RX:
+		port->w_priv.w_type = WWAN_PORT_AT;
+		break;
+	default:
+		port->w_priv.w_type = WWAN_PORT_UNKNOWN;
+		break;
+	}
+
+	return 0;
+}
+
+static void mtk_port_wwan_exit(struct mtk_port *port)
+{
+	if (test_bit(PORT_S_ENABLE, &port->status))
+		ports_ops[port->info.type]->disable(port);
+}
+
+static void mtk_port_wwan_enable(struct mtk_port *port)
+{
+	struct mtk_port_mngr *port_mngr;
+	int ret;
+
+	port_mngr = port->port_mngr;
+
+	if (test_bit(PORT_S_ENABLE, &port->status))
+		return;
+
+	ret = mtk_port_ch_enable(port);
+	if (ret && ret != -EBUSY)
+		return;
+
+	port->w_priv.w_port = wwan_create_port(port_mngr->ctrl_blk->mdev->dev,
+					       port->w_priv.w_type,
+					       &wwan_ops, NULL, port);
+	if (IS_ERR(port->w_priv.w_port)) {
+		dev_warn(port_mngr->ctrl_blk->mdev->dev,
+			 "Failed to create wwan port for (%s)\n", port->info.name);
+		port->w_priv.w_port = NULL;
+		mtk_port_ch_disable(port);
+		return;
+	}
+
+	set_bit(PORT_S_WR, &port->status);
+	set_bit(PORT_S_ENABLE, &port->status);
+}
+
+static void mtk_port_wwan_disable(struct mtk_port *port)
+{
+	struct wwan_port *w_port;
+
+	if (!test_and_clear_bit(PORT_S_ENABLE, &port->status))
+		return;
+
+	clear_bit(PORT_S_WR, &port->status);
+	w_port = port->w_priv.w_port;
+	mutex_lock(&port->w_priv.w_lock);
+	port->w_priv.w_port = NULL;
+	mutex_unlock(&port->w_priv.w_lock);
+
+	mtk_port_ch_disable(port);
+	wwan_remove_port(w_port);
+}
+
+static int mtk_port_wwan_recv(struct mtk_port *port, struct sk_buff *skb)
+{
+	mutex_lock(&port->w_priv.w_lock);
+	if (!port->w_priv.w_port) {
+		mutex_unlock(&port->w_priv.w_lock);
+		return -ENXIO;
+	}
+
+	wwan_port_rx(port->w_priv.w_port, skb);
+	mutex_unlock(&port->w_priv.w_lock);
+	return 0;
+}
+
+static const struct port_ops port_wwan_ops = {
+	.init = mtk_port_wwan_init,
+	.exit = mtk_port_wwan_exit,
+	.reset = mtk_port_reset,
+	.enable = mtk_port_wwan_enable,
+	.disable = mtk_port_wwan_disable,
+	.recv = mtk_port_wwan_recv,
+};
+
 const struct port_ops *ports_ops[PORT_TYPE_MAX] = {
 	&port_internal_ops,
+	&port_wwan_ops,
 };
diff --git a/drivers/net/wwan/t9xx/mtk_port_io.h b/drivers/net/wwan/t9xx/mtk_port_io.h
index 0c10e893b7e0..ea92cd22dba0 100644
--- a/drivers/net/wwan/t9xx/mtk_port_io.h
+++ b/drivers/net/wwan/t9xx/mtk_port_io.h
@@ -23,6 +23,11 @@ struct port_ops {
 	int (*recv)(struct mtk_port *port, struct sk_buff *skb);
 };
 
+union user_buf {
+	void __user *ubuf;
+	void *kbuf;
+};
+
 void *mtk_port_internal_open(struct mtk_md_dev *mdev, char *name, int flag);
 int mtk_port_internal_close(void *i_port);
 int mtk_port_internal_write(void *i_port, struct sk_buff *skb);
diff --git a/drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c b/drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c
index 8611561dd67c..aab09cab360c 100644
--- a/drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c
+++ b/drivers/net/wwan/t9xx/pcie/mtk_ctrl_cfg_m9xx.c
@@ -16,6 +16,10 @@ static const int mtk_srv_cfg_m9xx[NR_CLDMA][HW_QUE_NUM] = {
 
 /* the number of RX GPDs should be at last two */
 static const struct queue_info mtk_queue_info_m9xx[] = {
+	{CCCI_UART2_TX, CCCI_UART2_RX, CLDMA1, TXQ(5), RXQ(5),
+	 Q_MTU_3_5K, Q_MTU_3_5K, TX_GPD_NUM, RX_GPD_NUM, Q_FRAG_3_5K, Q_FRAG_3_5K, 0},
+	{CCCI_MBIM_TX, CCCI_MBIM_RX, CLDMA1, TXQ(2), RXQ(2),
+	 Q_MTU_3_5K, Q_MTU_3_5K, TX_GPD_NUM, RX_GPD_NUM, Q_FRAG_3_5K, Q_FRAG_3_5K, 0},
 	{CCCI_CONTROL_TX, CCCI_CONTROL_RX, CLDMA1, TXQ(0), RXQ(0),
 	 Q_MTU_3_5K, Q_MTU_3_5K, TX_GPD_NUM, RX_GPD_NUM, Q_FRAG_3_5K, Q_FRAG_3_5K, 0},
 	{CCCI_SAP_CONTROL_TX, CCCI_SAP_CONTROL_RX, CLDMA0, TXQ(0), RXQ(0),
@@ -23,6 +27,10 @@ static const struct queue_info mtk_queue_info_m9xx[] = {
 };
 
 static const struct mtk_port_cfg port_cfg_m9xx[] = {
+	{CCCI_UART2_TX, CCCI_UART2_RX, PORT_TYPE_WWAN, "AT",
+		PORT_F_ALLOW_DROP},
+	{CCCI_MBIM_TX, CCCI_MBIM_RX, PORT_TYPE_WWAN, "MBIM",
+		PORT_F_ALLOW_DROP},
 	{CCCI_CONTROL_TX, CCCI_CONTROL_RX, PORT_TYPE_INTERNAL, "MDCTRL",
 		PORT_F_ALLOW_DROP},
 	{CCCI_SAP_CONTROL_TX, CCCI_SAP_CONTROL_RX, PORT_TYPE_INTERNAL, "SAPCTRL",

-- 
2.34.1



