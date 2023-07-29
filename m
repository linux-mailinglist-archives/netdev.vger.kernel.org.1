Return-Path: <netdev+bounces-22573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC4E7680C4
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 19:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CCE282282
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 17:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B079171D2;
	Sat, 29 Jul 2023 17:31:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBAD816
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 17:31:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5DB35A2
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690651870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C410ZzW4GAo6ETnBrBclaR0hhmsPrT3hLfK5lCf/lnY=;
	b=G9Zo+9+VV/6zITkm8OYcR6B/g2CLdbP6CuboLsNqjqxwt3XTv/jNTLJl0/TKBKDAMc+ge+
	5e77ZduYcKItqV+k9DHi4HfCQi7+gog5rGI2C4qSM8khINYt40TK95FuawHxp0VYtnA8LV
	/p6I4BBLzSokG61iTG4OrLYi7XA0vas=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-ZeNQO7M5ODC9Lc33vKz84w-1; Sat, 29 Jul 2023 13:31:08 -0400
X-MC-Unique: ZeNQO7M5ODC9Lc33vKz84w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bcfdaaa52so191274166b.0
        for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 10:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690651867; x=1691256667;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C410ZzW4GAo6ETnBrBclaR0hhmsPrT3hLfK5lCf/lnY=;
        b=PsTCF7mJQPCb3LcqbG9WjNr7fEW/vSolHCqIksa+nxUP3OUfe0xxERnRk7+JSvCJi9
         rd2OhEqSrmhGSvqRgo5SkIIR1TeuOBVbU9wfCFcyjM/iLzMtDGWYE4SjNm4PMQ4hbaUi
         n/OommpnAeiwDHf7HhaUJicyPs/aezb6MAEaRZIOAC2vfT7KYxmjqm7FHImG+3xGvWDJ
         Zo7R7bbgcbRnkr7TkfmD9WcxzqNdPCLlTgSEvZAN3tlSvBTUYL9td0GrbaL3aHk/3YXt
         vDiPAdvbLsG68rzWO5BsJEJ0Ky720Scc+FCEaFmBP2IotXXrHBw3cPhmVtLAwSeRjbq3
         DFqg==
X-Gm-Message-State: ABy/qLbZcl8HYAAFpto95vPx8KZMP0wdFXLuTu3wJ2tMztUV/8WUpx+p
	AVExeJyKPlQ0L8qGJ9Wg1LvhDliPKKtwQ8uf9verDqJJcruLWIeS/DI0HZkJGaIb2rkOWQtHR3f
	Bz9Gnu9TGQvKD2nsaNcEvyBLuZRakTmG1wOFO/lHMjfE0T085Bwp9se3tn+8h70Uu4/r3Z4GQ
X-Received: by 2002:a17:907:2722:b0:99b:499d:4635 with SMTP id d2-20020a170907272200b0099b499d4635mr2203666ejl.75.1690651867040;
        Sat, 29 Jul 2023 10:31:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE/C2is6pFQ6vXfKWJLOPK/QJ0opJ1V1uRtSbJa9c6oLbbJPTezcHVltXH4ISlHEtlLcrHcEw==
X-Received: by 2002:a17:907:2722:b0:99b:499d:4635 with SMTP id d2-20020a170907272200b0099b499d4635mr2203646ejl.75.1690651866561;
        Sat, 29 Jul 2023 10:31:06 -0700 (PDT)
Received: from ?IPV6:2001:1711:fa41:6a0a::628? ([2001:1711:fa41:6a0a::628])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906490300b0099307a5c564sm3539346ejq.55.2023.07.29.10.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 10:31:06 -0700 (PDT)
Message-ID: <96a1ab09-7799-6b1f-1514-f56234d5ade7@redhat.com>
Date: Sat, 29 Jul 2023 19:31:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-GB
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek
 <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
From: Mat Kowalski <mko@redhat.com>
Subject: [PATCH net-next,v4] bonding: support balance-alb with openvswitch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit d5410ac7b0ba ("net:bonding:support balance-alb interface with
vlan to bridge") introduced a support for balance-alb mode for
interfaces connected to the linux bridge by fixing missing matching of
MAC entry in FDB. In our testing we discovered that it still does not
work when the bond is connected to the OVS bridge as show in diagram
below:

eth1(mac:eth1_mac)--bond0(balance-alb,mac:eth0_mac)--eth0(mac:eth0_mac)
                         |
                       bond0.150(mac:eth0_mac)
                         |
                       ovs_bridge(ip:bridge_ip,mac:eth0_mac)

This patch fixes it by checking not only if the device is a bridge but
also if it is an openvswitch.

Signed-off-by: Mateusz Kowalski <mko@redhat.com>
---
 drivers/net/bonding/bond_alb.c | 2 +-
 include/linux/netdevice.h      | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index b9dbad3a8af8..cc5049eb25f8 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -668,7 +668,7 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
 
 	dev = ip_dev_find(dev_net(bond->dev), arp->ip_src);
 	if (dev) {
-		if (netif_is_bridge_master(dev)) {
+		if (netif_is_any_bridge_master(dev)) {
 			dev_put(dev);
 			return NULL;
 		}
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 84c36a7f873f..27593c0d3c15 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5103,6 +5103,11 @@ static inline bool netif_is_ovs_port(const struct net_device *dev)
 	return dev->priv_flags & IFF_OVS_DATAPATH;
 }
 
+static inline bool netif_is_any_bridge_master(const struct net_device *dev)
+{
+	return netif_is_bridge_master(dev) || netif_is_ovs_master(dev);
+}
+
 static inline bool netif_is_any_bridge_port(const struct net_device *dev)
 {
 	return netif_is_bridge_port(dev) || netif_is_ovs_port(dev);
-- 
2.41.0



