Return-Path: <netdev+bounces-23203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335C576B4DF
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC841C20F23
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78923200C1;
	Tue,  1 Aug 2023 12:37:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF341E503
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 12:37:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CAD1FCB
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690893474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8QnjItgqcBQuqApfno1P7Rwi+3EgP6b5ZEe43R/hZyI=;
	b=Th7HfhgXWUs19oPJ2qkAp1ZO7MejXk1ouc5b/tnARtTPrnDqeMl1MYlqBn51SAB8voJosW
	A+HKIPNAUwn6rQ2JwGnUJdvzENX5w5w8d6bpTRrYwZRMrhKZ7Q+8GZoZ14PxcKoCREWkTl
	A0e6v6GqJwpa/K6sYjjc702TaHPtgVQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-cFHEvty-NjuxilZR8eHriw-1; Tue, 01 Aug 2023 08:37:53 -0400
X-MC-Unique: cFHEvty-NjuxilZR8eHriw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50a16ab50e6so3504602a12.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 05:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690893472; x=1691498272;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8QnjItgqcBQuqApfno1P7Rwi+3EgP6b5ZEe43R/hZyI=;
        b=Zk+uq/RrIHCAvl1hG2KtIGXjs1li+EBZj2qDfzzeIVNfGH0VCOaQ0OKkSVk8+bAzCM
         Ba1aYFQT+zuIHSEGG1Prl+SfLkkOPkkKs5tkSC/ikrWAmG0nDcDQlLrF/uBzU2OItctb
         LqJfscGimekgvCzTCuFVAX/sseI6Sm93hBf1V0/f1li74M3l+gdWuC1YSDsqC4RUqDIl
         88xUS6DyaQfkGLwB+r2lTTzMvswlmZYyzEmGxC9Fw7MqlW/uY9uHwyObEBH53bj0+TP/
         /z0yEAVoWyzDu640QXyI2nQx6ZrVlE6b7qXmTeF1PeZVIlXyljuEQxmmiCTc1TRZxxko
         UzlQ==
X-Gm-Message-State: ABy/qLYjTANuaK8ZYLGX0pYCuYofm70xjHhryoQ443eCIsY0n1k/2cTN
	6E8qUwe4FBuIiTKPyP72bIm4ilHJnpLSf/xE9ZTpFZEETxErqzdlewSHlvyZ1qZUqTreDwx5r/v
	J2lXgwO8Vnp21VJ7F2kJwtk0FtbtNeGQ/Y9OAbuDfOqk+kJ7gOZRgkhrU15BC4Cu3cqk658eO
X-Received: by 2002:aa7:d1d1:0:b0:520:f5dd:3335 with SMTP id g17-20020aa7d1d1000000b00520f5dd3335mr2026744edp.41.1690893472514;
        Tue, 01 Aug 2023 05:37:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6X1ANwSMGyzwXjLIXemSxJPh3OwQr2939WwJ0b5+VC8pUrMWJTCiULlW/m7X+O91qhl870g==
X-Received: by 2002:aa7:d1d1:0:b0:520:f5dd:3335 with SMTP id g17-20020aa7d1d1000000b00520f5dd3335mr2026729edp.41.1690893472132;
        Tue, 01 Aug 2023 05:37:52 -0700 (PDT)
Received: from ?IPV6:2001:1711:fa41:6a0a::628? ([2001:1711:fa41:6a0a::628])
        by smtp.gmail.com with ESMTPSA id g4-20020aa7c584000000b0052228721f84sm6865764edq.77.2023.08.01.05.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 05:37:51 -0700 (PDT)
Message-ID: <9fe7297c-609e-208b-c77b-3ceef6eb51a4@redhat.com>
Date: Tue, 1 Aug 2023 14:37:50 +0200
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
Subject: [PATCH net-next,v5] bonding: support balance-alb with openvswitch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Mateusz Kowalski <mko@redhat.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
---
v5 changes:
- Fix From: tag to match SoB
- Carry Reviewed-by: tag from v1

v4 changes:
- Fix additional space at the beginning of the line

v3 changes:
- Fix tab chars converted to spaces

v2 changes:
- Fix line wrapping

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


