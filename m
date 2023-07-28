Return-Path: <netdev+bounces-22190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF1A76666A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D645D282FA4
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D98610784;
	Fri, 28 Jul 2023 08:04:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490E0C8DA
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:04:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F93C1F
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690531464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IGBA6fnuIudF6i5KzHn0rjsJTaSucHSTzQ7LjZN+KaU=;
	b=iyXKM+KA5rCo+rrEHt4zIhL3mtg9wAlN4i244z9+qkH1gdiquQO5y73MM97kR07gT042uH
	EIL+81m/KCThxZB7ZmPul0mKyHU000GoWBH9OtQ6tZvXhuN3ohdp7D6mrEoCGLQ+7W1ilW
	s9DyoS+5ozL4AJcXwY0ylcOxGXBSlmE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-rRWIJMecNvm7D1stNJ8mAQ-1; Fri, 28 Jul 2023 04:04:23 -0400
X-MC-Unique: rRWIJMecNvm7D1stNJ8mAQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-993d7ca4607so101416666b.1
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 01:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690531462; x=1691136262;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IGBA6fnuIudF6i5KzHn0rjsJTaSucHSTzQ7LjZN+KaU=;
        b=dla8o9Q/hM7I2DPFPz4518eoO62bIdbjCte+zHF284kxbr0WUm/WHWGbrUhVzl7tCi
         lCkcew7BOVBoDfa2Cniq0nLjdcPm543e7UZXzP9fDH9DDD6Ub58ijc/8mUmDPZnOyanu
         5GnCFD4cZxSbQvMfW2ImdomW844b+MBzz+1JD7PPU6kqG2Q40Y6CFEVSp7nM5v8Y8BDV
         TpLkuM+l9oD/Paz0VRK5F+6fDzqdfIq/KU+fNxLeLM0tVLE2SMylG87d6Ae/BeuPMk10
         ALKO/Wi4mE80fbBW1U11sJhB/fv6oG4OjRFb81RXL0AcQDDPizv86bTRjom+heXPSNO4
         1u8A==
X-Gm-Message-State: ABy/qLZvD4/grrSIiB5FOh5BTgO61aoLkg6pQ6k5EWoRFK/bVsLcugLc
	CxHJLukZr7zFGQ2DpBNUg2TqARjdXjAOXrJt+JwB8EC6LHrkil5qNvZpKs5Nrmz9qjOmL0Fvp86
	lnRtAO5QEuU7SMjhw9NhKOYzZep+XbCqz1r5x27HjUEWzpxEWQ6eQKElrw11yEIJ/sKm3ug==
X-Received: by 2002:a17:906:225a:b0:992:a90a:5d1f with SMTP id 26-20020a170906225a00b00992a90a5d1fmr1450630ejr.68.1690531461918;
        Fri, 28 Jul 2023 01:04:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG6GohJ7qviiqkntYWrBSjvGbRPYTdEQ/x/tgDJ0igBwfutsOwkq02O0PJ3L4ni0/+6Uk3H0A==
X-Received: by 2002:a17:906:225a:b0:992:a90a:5d1f with SMTP id 26-20020a170906225a00b00992a90a5d1fmr1450610ejr.68.1690531461512;
        Fri, 28 Jul 2023 01:04:21 -0700 (PDT)
Received: from [192.168.149.71] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id lu20-20020a170906fad400b00993664a9987sm1743002ejb.103.2023.07.28.01.04.20
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 01:04:21 -0700 (PDT)
Message-ID: <1a471c1b-b78c-d646-6d9b-5bbb753a2a0b@redhat.com>
Date: Fri, 28 Jul 2023 10:04:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-GB
To: netdev@vger.kernel.org
From: Mat Kowalski <mko@redhat.com>
Subject: [PATCH] net:bonding:support balance-alb with openvswitch
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
  drivers/net/bonding/bond_alb.c | 3 +--
  include/linux/netdevice.h      | 5 +++++
  2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index b9dbad3a8af8..6f2ffcc4f19c 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -668,7 +668,7 @@ static struct slave *rlb_arp_xmit(struct sk_buff 
*skb, struct bonding *bond)

         dev = ip_dev_find(dev_net(bond->dev), arp->ip_src);
         if (dev) {
-               if (netif_is_bridge_master(dev)) {
+               if (netif_is_any_bridge_master(dev)) {
                         dev_put(dev);
                         return NULL;
                 }
@@ -1833,4 +1833,3 @@ void bond_alb_clear_vlan(struct bonding *bond, 
unsigned short vlan_id)
         if (bond->alb_info.rlb_enabled)
                 rlb_clear_vlan(bond, vlan_id);
  }
-
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b828c7a75be2..d250a0b947f1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5102,6 +5102,11 @@ static inline bool netif_is_ovs_port(const struct 
net_device *dev)
         return dev->priv_flags & IFF_OVS_DATAPATH;
  }

+static inline bool netif_is_any_bridge_master(const struct net_device *dev)
+{
+       return netif_is_bridge_master(dev)) || netif_is_ovs_master(dev);
+}
+
  static inline bool netif_is_any_bridge_port(const struct net_device *dev)
  {
         return netif_is_bridge_port(dev) || netif_is_ovs_port(dev);
-- 
2.41.0


