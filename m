Return-Path: <netdev+bounces-177816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EE5A71E27
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828811893890
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56DB2512C8;
	Wed, 26 Mar 2025 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GNfEyULs"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFCE1DC9BE
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013063; cv=none; b=Uiv5HuMIkDWVEUWt7vH5TS0hfqZ2i27KDNp10RILNoAxap1FbEeKoZ1o/Xw7U/AdpV6AehLwjKOqba58ywc7uRG6OInn97e+8WxBTiMOi91YuH+ac+sXidOdL0Wj8ZJ6ODqESmOz4Ovb/MR/L9XmjTYnWoLyZ3sFjCHurIT/dGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013063; c=relaxed/simple;
	bh=1UhRK95LP8hqlPseMawABnpT11GCkmJwEaKCs8WEWW8=;
	h=Message-ID:From:To:Cc:Subject:Date; b=g4nSlDwYbDwo5UqyL8k39NrdE7YuugebaYaoN5OwD4bM+7kFbe1mJszcO4huyyHRrLsGGItiN5U1xHLgrSJxk7koLTzraDEf0l0sOLSrwsV/PTo7u66hK2yNsKEoCTgWC3Un9qdRWdOj3vw1ZLqu0DXH4N8G9tA+TJf+ER+lXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GNfEyULs; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743013054; bh=h7q4/X5vEb/MoGY6Kon60isqwwB6JHPQYp8IebAK9+8=;
	h=From:To:Cc:Subject:Date;
	b=GNfEyULstJtyftvjQWi99+ZzEgdz65pl4H2URjn7zVo4OaYWg45uYhSCbk3e7vBYM
	 OyRIcsRz+b7tO13NaAgzgVpKGiU3K3cjr45Z0Z+V8k/Sy4apkFM+aJ1tFqzDK27jXC
	 OPT7K7SE76Y94LSsxky2GsEctWEDUiZ8dXC+hzfQ=
Received: from localhost.localdomain ([111.19.95.140])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 2D7030FB; Thu, 27 Mar 2025 02:11:23 +0800
X-QQ-mid: xmsmtpt1743012683tr4silwsz
Message-ID: <tencent_4B358ADB8A54F04A32CD9933114B8B383606@qq.com>
X-QQ-XMAILINFO: NtvpdyJXE1j9rTsJZGXp36RuJGdcd4cfQo+bmpS4rT6vnuQaugyzqnOI+uNC8s
	 KxTx0gzAHsEdaqPze4ZGJ/OgIHedjsd+uWRzOtbnoKAaCIn5n/8Rb0E+AhRpjcAL1VsFehcFMia3
	 FbbKRi8STTb2kDybragRDljfgu/PCle3JheOJit+g/y8GiulBfmOMCyIj4vrExNsfwVSJbeHAFkK
	 ssVK+7JUIg09otzF3zBO1lsExNGlx5tiySzuXmWmMz+t/gD4gparwAGb+CJSNX1LshCa81FbKnY4
	 v7rJnmjzcv8BONfOqcztsMxmOdutoFn3gXljX6NA7aH+GZ1TiRVzf87gaYYCcubKGSEvvpGPhlhL
	 devgtzi/Rz0fmu/M4BKX3Q7eIhol/8A2F5hJOx4WDHpr3Q68Rg7TOn2VN69bUz1z5MMhR483Mtcv
	 /xjpnaf31CZYa76k2jUXVHm/GBj6M9hajhOszKCJz1gMbg+FkqHaG9TQMvCS/zkIun+tAse7usgD
	 9sn0NaqtVgY/fWA1daKpZAiK/BYz1Ii8Az14YlVb4s0DEqNhoq8On+aEH9b2+h/TdZar+pMu98oo
	 HWIBi7dChmiJouDyJvB93Qwb7AG5j5yWjvWkTjt32cv+DdNlOe7E4s8xIDSg1u81kCoYxeApAepL
	 rJ2gLLtLVmvWpunfQD4BooC8fPNU07W9bftztKFffvhAvn6QV7kJXBHossg3xpCkOKtvGMxss7gh
	 /tZwtBE/UgWlTt3qT/kFrQpJl98cV2XcfwqKLm95B3HNEZawMlNafL0BeDjeiq+D6IE3msMinRhw
	 RdBkbcSSq5YwLWi2iyCBjc8z0ja+pLGrGq7kr38mJz6hSqPSXbOqWNFqhBcIeStsSmYw++Oh7Lse
	 D8kgICXJ4hw1v4RnBhIA0I02X/6rsH0qO+dFMGzylArGSOnV2FdpoTTd5lv7B0lk1+DLUx0lB0Ri
	 NBy8iRxgZu28ztIp7E9DyvmssSaGJm
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: inuc@qq.com
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	Liu Jie <inuc@qq.com>
Subject: [PATCH] net: bridge: set skb->protocol for 802.1Q VLAN packets
Date: Thu, 27 Mar 2025 02:11:17 +0800
X-OQ-MSGID: <20250326181117.15513-1-inuc@qq.com>
X-Mailer: git-send-email 2.16.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Liu Jie <inuc@qq.com>

When bridging locally originated VLAN-tagged packets, we must ensure
skb->protocol is properly set to ETH_P_8021Q. Currently, if this field
remains unset, br_allowed_ingress() may incorrectly drop valid VLAN
packets during the bridge transmission path.

Fix this by explicitly checking eth_hdr(skb)->h_proto for VLAN tags when
handling locally generated packets.

Signed-off-by: Liu Jie <inuc@qq.com>
---
 net/bridge/br_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 0ab4613aa..9094ba7e4 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -63,6 +63,9 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	skb_reset_mac_header(skb);
 	skb_pull(skb, ETH_HLEN);
 
+	if (eth_hdr(skb)->h_proto == htons(ETH_P_8021Q))
+		skb->protocol = htons(ETH_P_8021Q);
+
 	if (!br_allowed_ingress(br, br_vlan_group_rcu(br), skb, &vid,
 				&state, &vlan))
 		goto out;
-- 
2.17.1


