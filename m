Return-Path: <netdev+bounces-22566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE92768093
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 18:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F7028232B
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2712171C7;
	Sat, 29 Jul 2023 16:24:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCF168D7
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 16:24:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF8A1BC3
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690647855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H4vqTAutAvMBwyZZMW1zZ+4ibQxGfp6dPbPrA+m5sJI=;
	b=PMBQDBoPhKee4u/FCAzrnaDvUss0GwBuX9ElHVCJ0e8vtCsy60hyr75seOOEHt/LKg3M7+
	Ffod0BVhU9RpCYwRc75zU4sS68Tkbsl8khhrkqWxrMonJQVYj89CqaOl3WCGdyz186K3OK
	t2DN8stcqPByqtwe7Q5mhYUHU0bfuak=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-KDfG4P7KPSKH520m65OSIA-1; Sat, 29 Jul 2023 12:24:13 -0400
X-MC-Unique: KDfG4P7KPSKH520m65OSIA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993d41cbc31so209601466b.1
        for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 09:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690647852; x=1691252652;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H4vqTAutAvMBwyZZMW1zZ+4ibQxGfp6dPbPrA+m5sJI=;
        b=C4zGVyQxzwv5XoZGPkXt2wWIfH/VD7LrtgS4I5BGTbrHeV310IZD7mSUBaKVZG6aPA
         1DgSCMgI/Aqr7/AtNEVECLhHBvFegpDOxOIXsuQxRXOrWqVZuXL7N+Xx54zhKx+VAdsA
         Z3WOryxTagHuubrxr4iktHAWmbIxsLIJXkjX8LsiBvASOJjba8FeUM4mOzU4J5Jgu8lg
         94JvWV6zmkCq73ZotLX4C8Ya1Cf7KCcA7pnS1hgVamdcXETeaUWszWu2Gmh6nL3LRKZc
         MfT83jYrLqgtxsWTwfoPICTbd1oUPyp7v5SUZTsFrlQn3wdkVcQH6DW76RRrLigY7DsB
         +psg==
X-Gm-Message-State: ABy/qLYdU7wmH1GJBe2jdV3Oy9ivUVzpAhqocOtnnZwZlXQPHq4EXAXB
	SG0G1+dQLTTRBkOvvzskg59zRBaIDLld1P6NEtoniPoNh19G90KP9K6jNvSki/GjzA+FFyO3YLH
	yMEH8B25Rzeh/FbDi2Npj0NZmARVxNfxoaHMjkpuW2gb5VqNLbXvQGu8B4ZEcx1MlCGcJ3kQv
X-Received: by 2002:a17:907:a04b:b0:982:1936:ad27 with SMTP id gz11-20020a170907a04b00b009821936ad27mr3064310ejc.11.1690647852841;
        Sat, 29 Jul 2023 09:24:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGZNV5nbUftHmBdVxYMMg7VBRj5o849WpxnZ2gRdVuNCqvQMRwpat8oBqGKEsaiJETh8LFO+A==
X-Received: by 2002:a17:907:a04b:b0:982:1936:ad27 with SMTP id gz11-20020a170907a04b00b009821936ad27mr3064290ejc.11.1690647852526;
        Sat, 29 Jul 2023 09:24:12 -0700 (PDT)
Received: from ?IPV6:2001:1711:fa41:6a0a::628? ([2001:1711:fa41:6a0a::628])
        by smtp.gmail.com with ESMTPSA id fy13-20020a170906b7cd00b00993928e4d1bsm3428384ejb.24.2023.07.29.09.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 09:24:12 -0700 (PDT)
Message-ID: <63cf301a-8380-7cb7-682c-9131b3d0c802@redhat.com>
Date: Sat, 29 Jul 2023 18:24:11 +0200
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
From: Mateusz Kowalski <mko@redhat.com>
Subject: [PATCH net-next,v2] bonding: support balance-alb with openvswitch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
  include/linux/netdevice.h      | 5 +++++
  2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index b9dbad3a8af8..cc5049eb25f8 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -668,7 +668,7 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)

      dev = ip_dev_find(dev_net(bond->dev), arp->ip_src);
      if (dev) {
-        if (netif_is_bridge_master(dev)) {
+        if (netif_is_any_bridge_master(dev)) {
              dev_put(dev);
              return NULL;
          }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 32a4cdf37dd4..265888af1220 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5100,6 +5100,11 @@ static inline bool netif_is_ovs_port(const struct net_device *dev)
      return dev->priv_flags & IFF_OVS_DATAPATH;
  }

+static inline bool netif_is_any_bridge_master(const struct net_device *dev)
+{
+  return netif_is_bridge_master(dev)) || netif_is_ovs_master(dev);
+}
+
  static inline bool netif_is_any_bridge_port(const struct net_device *dev)
  {
      return netif_is_bridge_port(dev) || netif_is_ovs_port(dev);
-- 
2.41.0


