Return-Path: <netdev+bounces-22569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2867680AC
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 19:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3411C20A35
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D55168BF;
	Sat, 29 Jul 2023 17:03:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47247816
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 17:03:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301C6129
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690650203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mt87Flu1ZsxyKB1sonXwXtRmcTYz/bdGkRvrKG3CltA=;
	b=NCv0fLAUcq4r1a9H4p+4Qbir9seGgg2+PkReCUcuL127TsoTJp9V2FfJylf1mid7fie/PY
	GdnP78oJ0kTtgBEFMq8y8Fdd9UdqBFdp8OW2mgcEsTEPusm0X6H7sZKbRMymgcke10iP9D
	po4ZWFnD/JFfnRqe+ipOSwrvDw2iEO4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-gZcAnqXJM9CmiqVIvRGIWg-1; Sat, 29 Jul 2023 13:03:21 -0400
X-MC-Unique: gZcAnqXJM9CmiqVIvRGIWg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99bfe6a531bso44109366b.1
        for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 10:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690650200; x=1691255000;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mt87Flu1ZsxyKB1sonXwXtRmcTYz/bdGkRvrKG3CltA=;
        b=TprLtBlUFefqpYVKQoco5WAziVMWPbI3bboMFBmn1wjVpTiy7Db0YuWhVMftNoTGFi
         OzYRAh0LVUckU8LlQt11SniAR988ZUqtUeTSzDtRAfTfPTGbCRfEJwKIQYcZRdcdhx0P
         U9FpEp8fkgT3btKWtsTomaHsuyJALOimGuV7y5byu0eMuP54qzcQDhpR6v7bCSGBL4TZ
         0zNdlmnhxt4j1e6OMay8CEuAAJCNUGsaxqgbSuAjvYrcQJhErDrr7/w3x3vFhiAO45tv
         ZajXRlSdHSWMmeJ6y4W4xatFzQOXwz0Xr1hUqAN6olKD0x3VpDWmmVhYoK6c28q8yHJR
         bflg==
X-Gm-Message-State: ABy/qLaQVLk0iojHFwocjBmNOdemZpktBSlC0bo0doc33iFdK6dQY43T
	HzBMjXv0LJJ3mrUAgo74/SZdycWkZKXaBPuxPH8eG6RZXir770y3rY26aNPwjZPNX3R60fin3Bm
	74ucnyr9SJ1cxEiAOe6KOZ1wLcd7kfY2UQxcHlL+I4dRJXG5Qy6JRe8sCQEbLD+kCOnfcE7DZ
X-Received: by 2002:a17:907:a04f:b0:982:8de1:aad9 with SMTP id gz15-20020a170907a04f00b009828de1aad9mr2694555ejc.64.1690650200518;
        Sat, 29 Jul 2023 10:03:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFgpQ9ukwpkhybSJYefJJUt0DXljIUM+hGfV+jSUtvPaASmqaI7fpLoZTvF8TilOD7+gJDcvA==
X-Received: by 2002:a17:907:a04f:b0:982:8de1:aad9 with SMTP id gz15-20020a170907a04f00b009828de1aad9mr2694533ejc.64.1690650200198;
        Sat, 29 Jul 2023 10:03:20 -0700 (PDT)
Received: from ?IPV6:2001:1711:fa41:6a0a::628? ([2001:1711:fa41:6a0a::628])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170906c35200b0099bd682f317sm3457051ejb.206.2023.07.29.10.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 10:03:19 -0700 (PDT)
Message-ID: <83df444c-c0fe-a201-4a6d-ee6823b5fe30@redhat.com>
Date: Sat, 29 Jul 2023 19:03:18 +0200
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
Subject: [PATCH net-next,v3] bonding: support balance-alb with openvswitch
Content-Type: text/plain; charset=UTF-8; format=flowed
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
index 84c36a7f873f..97ef032b1031 100644
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


