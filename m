Return-Path: <netdev+bounces-24074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E504276EB19
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCABC1C21594
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98FD1F92F;
	Thu,  3 Aug 2023 13:47:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCDD18B0D
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:47:58 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A0649D9
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 06:47:57 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RGqpv5fF5zJpQw;
	Thu,  3 Aug 2023 21:45:11 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 21:47:55 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next] net: llc: Remove unused function declarations
Date: Thu, 3 Aug 2023 21:47:47 +0800
Message-ID: <20230803134747.41512-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

llc_conn_ac_send_i_rsp_as_ack() and llc_conn_ev_sendack_tmr_exp()
are never implemented since beginning of git history.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/llc_c_ac.h | 1 -
 include/net/llc_c_ev.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/net/llc_c_ac.h b/include/net/llc_c_ac.h
index 3e1f76786d7b..7620a9196922 100644
--- a/include/net/llc_c_ac.h
+++ b/include/net/llc_c_ac.h
@@ -175,7 +175,6 @@ int llc_conn_ac_send_ack_if_needed(struct sock *sk, struct sk_buff *skb);
 int llc_conn_ac_adjust_npta_by_rr(struct sock *sk, struct sk_buff *skb);
 int llc_conn_ac_adjust_npta_by_rnr(struct sock *sk, struct sk_buff *skb);
 int llc_conn_ac_rst_sendack_flag(struct sock *sk, struct sk_buff *skb);
-int llc_conn_ac_send_i_rsp_as_ack(struct sock *sk, struct sk_buff *skb);
 int llc_conn_ac_send_i_as_ack(struct sock *sk, struct sk_buff *skb);
 
 void llc_conn_busy_tmr_cb(struct timer_list *t);
diff --git a/include/net/llc_c_ev.h b/include/net/llc_c_ev.h
index 3948cf111dd0..241889955157 100644
--- a/include/net/llc_c_ev.h
+++ b/include/net/llc_c_ev.h
@@ -158,7 +158,6 @@ int llc_conn_ev_p_tmr_exp(struct sock *sk, struct sk_buff *skb);
 int llc_conn_ev_ack_tmr_exp(struct sock *sk, struct sk_buff *skb);
 int llc_conn_ev_rej_tmr_exp(struct sock *sk, struct sk_buff *skb);
 int llc_conn_ev_busy_tmr_exp(struct sock *sk, struct sk_buff *skb);
-int llc_conn_ev_sendack_tmr_exp(struct sock *sk, struct sk_buff *skb);
 /* NOT_USED functions and their variations */
 int llc_conn_ev_rx_xxx_cmd_pbit_set_1(struct sock *sk, struct sk_buff *skb);
 int llc_conn_ev_rx_xxx_rsp_fbit_set_1(struct sock *sk, struct sk_buff *skb);
-- 
2.34.1


