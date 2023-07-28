Return-Path: <netdev+bounces-22273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0768766D29
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 14:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A3B282675
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577D212B8A;
	Fri, 28 Jul 2023 12:25:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B793D304
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 12:25:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA58949C3
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 05:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690547077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ibqQTz4P5Ty4DDivFGhS9B1mWYXoiMInOUOTJlVjfVo=;
	b=XCFAaOxiOSmgSK89sSoP8MzktpLuv5HHg4mibGIY3QRRE/TugoUFDyWU0eQ5WXCWJhh5Dy
	waMPXiEVVL5A+f2Uzh6O8fUOIvVe4gweuLtz+SX8pJqcmS+4VBDy0bhtL9bFtE30SHmESd
	0oUiIlAnmiBGskwu4mwTx2K9aNpVLcs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-RAeXdygaP7qh52EvYHvxsw-1; Fri, 28 Jul 2023 08:24:35 -0400
X-MC-Unique: RAeXdygaP7qh52EvYHvxsw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b6f97c9d54so20240111fa.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 05:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690547074; x=1691151874;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ibqQTz4P5Ty4DDivFGhS9B1mWYXoiMInOUOTJlVjfVo=;
        b=K19RqwqT7TWgDuc1vQDb9hAtwtVxO8jJF0EnRwBLsHovx2LwSRrbKA7ZCJNJ4jCt8T
         DOlHUOWp6Zg68+cKQIMNzpWgdr+hc7nvFoHd64O/HTKJGBR7wIvHO7dpVooX3u8X/xXu
         /iH3gDYGgLy1u609B/jEB2aSR8zHDXU0HU6gOpWZ5K0UaecizTQiKe+/UZmXwlyGEe2h
         At2wRwE13BkSwvfkrqoNmoOfiv2ZyYFIXEexn5idiDW0ScEUPKxLu1WMcafObaUXP480
         g702V3cu4DCjIc5sayWkldVis93Np6QtyhkOK7TKZ6aCE1Ig+3Bz1SSCFiE8g00MORFW
         F4Pg==
X-Gm-Message-State: ABy/qLYizVuwbA7QU7zSOudiv+rabrpa5kL6KYnshU7pdUN4oEEXLWQE
	nxf+bDJYgBxYPUZ4m5uFEo/kx1bW8eofy+Z1uDbpRnjd1UztRYk9v8j+UO/mUg5FENuZTGkylXK
	KFZchF3AKdXeGfYRJqYc3YCUqiOgtkTaN9skn7bFZxrDq+CbYN2gL6dyMI/qEEK4c71xOnyns
X-Received: by 2002:a2e:b009:0:b0:2b1:e807:f0f with SMTP id y9-20020a2eb009000000b002b1e8070f0fmr1694341ljk.28.1690547074504;
        Fri, 28 Jul 2023 05:24:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGHVYHsGExdJzOSuvn7L450vqG2SqqXtJXXdbJWI2KxJGIQdRGXCKjO0wIUzrsHrc3IU+kseg==
X-Received: by 2002:a2e:b009:0:b0:2b1:e807:f0f with SMTP id y9-20020a2eb009000000b002b1e8070f0fmr1694322ljk.28.1690547074086;
        Fri, 28 Jul 2023 05:24:34 -0700 (PDT)
Received: from ?IPV6:2001:1711:fa41:6a0a::628? ([2001:1711:fa41:6a0a::628])
        by smtp.gmail.com with ESMTPSA id sb9-20020a170906edc900b00992ae4cf3c1sm1988678ejb.186.2023.07.28.05.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 05:24:33 -0700 (PDT)
Message-ID: <19d45fbf-2d02-02e9-2906-69bf570e9c7f@redhat.com>
Date: Fri, 28 Jul 2023 14:24:32 +0200
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
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek
 <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
From: Mat Kowalski <mko@redhat.com>
Subject: [PATCH net-next] bonding: support balance-alb with openvswitch
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
@@ -668,7 +668,7 @@ static struct slave *rlb_arp_xmit(struct sk_buff 
*skb, struct bonding *bond)

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
@@ -5100,6 +5100,11 @@ static inline bool netif_is_ovs_port(const struct 
net_device *dev)
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


