Return-Path: <netdev+bounces-24326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B144876FC93
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C45C282591
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA7E9467;
	Fri,  4 Aug 2023 08:51:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF063DB
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:51:19 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C225FD6
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 01:50:55 -0700 (PDT)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4RHKDj2JH6zbhY8
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 16:50:45 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4RHKDX2dycz5BnwJ
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 16:50:36 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RHKD94pTFz7S5Hk;
	Fri,  4 Aug 2023 16:50:17 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl2.zte.com.cn with SMTP id 3748nisU010349;
	Fri, 4 Aug 2023 16:49:44 +0800 (+08)
	(envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
	by mapi (Zmail) with MAPI id mid14;
	Fri, 4 Aug 2023 16:49:46 +0800 (CST)
Date: Fri, 4 Aug 2023 16:49:46 +0800 (CST)
X-Zmail-TransId: 2b0364ccbbaaffffffff989-81c32
X-Mailer: Zmail v1.0
Message-ID: <202308041649468563730@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.yang29@zte.com.cn>
To: <davem@davemloft.net>
Cc: <dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB1ZHBfdHVubmVsX25pYzogYWRkIG5ldCBkZXZpY2UgcmVmY291bnQgdHJhY2tlcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 3748nisU010349
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64CCBBE4.000/4RHKDj2JH6zbhY8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: xu xin <xu.xin16@zte.com.cn>

Add net device refcount tracker to udp_tunnel_nic.c.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Cc: Kuang Mingfu <kuang.mingfu@zte.com.cn>
---
 net/ipv4/udp_tunnel_nic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index 029219749785..ce8f5c82b0a1 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -55,6 +55,9 @@ struct udp_tunnel_nic {
  */
 static struct workqueue_struct *udp_tunnel_nic_workqueue;

+/* To track netdev_hold and netdev_put */
+static netdevice_tracker udp_tunnel_nic_devtracker;
+
 static const char *udp_tunnel_nic_tunnel_type_name(unsigned int type)
 {
 	switch (type) {
@@ -825,7 +828,7 @@ static int udp_tunnel_nic_register(struct net_device *dev)
 	}

 	utn->dev = dev;
-	dev_hold(dev);
+	netdev_hold(dev, &udp_tunnel_nic_devtracker, GFP_KERNEL);
 	dev->udp_tunnel_nic = utn;

 	if (!(info->flags & UDP_TUNNEL_NIC_INFO_OPEN_ONLY))
@@ -879,7 +882,7 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
 	udp_tunnel_nic_free(utn);
 release_dev:
 	dev->udp_tunnel_nic = NULL;
-	dev_put(dev);
+	netdev_put(dev, &udp_tunnel_nic_devtracker);
 }

 static int
-- 
2.15.2

