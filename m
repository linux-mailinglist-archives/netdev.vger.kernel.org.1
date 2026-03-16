Return-Path: <netdev+bounces-268022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE2LCMaGt2mOSAEAu9opvQ
	(envelope-from <netdev+bounces-268022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 05:27:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CCF2948F3
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 05:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1DB73025727
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 04:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEDF33A6E2;
	Mon, 16 Mar 2026 04:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZvO6i2V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4543324B2C
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773635228; cv=none; b=UdC549o718HuQXUUK6SBGoRxxVlg1j1mC8eNGd03SEQNiHdBXT4JXF0WVLYkXag/zgrsK0TY5VpFvHg8mvFJSrxIr1kBPB3S0fwRCNPhAYAQxGVO8WICI0I9vE1Oc7Q4o9ZKuEQVz9I9IRqr5lrUr5lEY1cGqSM/Q4JqccbYAT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773635228; c=relaxed/simple;
	bh=qNPeHvHZTZR/YyNb7PrqwI9kz5RD4rqaFT50tFfTL2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XnWZ1c6fi4MM7+p/7ZZdqfhcVFbnhXBXZVG8X5NfkljqkHXVrzcqckTq4trEQtB9SatfvJMMJDoCN5Ihw/HIAnpUBe/sIF/wnpN8gGbAkL/T5xgxyERBRFqxtp+5oeQhw7AQCU2ICbxWIRG81OWerAVi4pyxk/e+zBHwMIxb97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZvO6i2V; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829928e512aso2111428b3a.2
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 21:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773635225; x=1774240025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4NrMDbk24kpM0xeU9hz073wyfuICysoD9kSVFILYB4=;
        b=jZvO6i2VjvTNQLj7jQhlHotf15/TQ6gCpjSrOGaZfGKs0mDVJflUYhHHtV+XLfFgHD
         oAp/sk7cwtK+1kkllYzQmRwssgsl5kPb78NktIESS6dbfJpHqsntUhkr2l08xmEtVVm6
         bKrJjX97qvlEXXuCRG+XExWXA7GkFTVjzj20deGAxVYRmo2mGvROBHBLxmBLi40xkhIS
         W50bKiSpQ3PAX16AMwZSRXSgyFTqEyiAV1ABPVPzX+BcaW0N5ZnDyt209NayQ3anF2tF
         WueI+fitOalDoubU1R80QlMOAdrlKSfC+/u++9FO5ORC40T1m6GTGiYvlI1UtNytu03L
         BTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773635225; x=1774240025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S4NrMDbk24kpM0xeU9hz073wyfuICysoD9kSVFILYB4=;
        b=iwgRVfWTUKpy8pQM4BQweoDSQNCxsAeElAMGYGbHeEGuf9FRjD9Uo2MoiAOUaC8/m3
         4TmI+YlOYxaVxXbiUkrJ3jDyvTGWUiRUpO8jSTOYlcnvnasd7Cpg4AyDAxiCClhxPkLW
         m0RoZUJ4XFbCx095I+ZruD00elKqwUv7JfZG59Hx4O/3OrqY3Ej2GEB9JxOomw6w4y8u
         pShgrgfOAiVaDWbHz3eLV9t0KfJMG/TYv8lSKvBRNu7YjwslzcOytpm1PZovyBTDs5FX
         DIHEimDufyU4GMNgynO0/Si+59EyydRVoq/XNRXiLYJ44DX17eTHlCQnK22wutheqbpS
         //wg==
X-Gm-Message-State: AOJu0YxqmbM/x+NRzM4WNIR5MKjU0p5FFlU1wfyDoX2dtlVk/Iug8rPr
	5rIpP3eekJ82ITm0nIZlkyWV398e+epqaZKg2WqOsqZz+SefNFjaHuyj
X-Gm-Gg: ATEYQzwXviUNRVQTURfdqmmOwMSptO3wz0ARljnuAn0QzDv5cvhS8f/b9SVZKpOlF2i
	h2Rlo8MrCg2Gb27HfRmy2e8ahpRpQnyRrdna4ruIs0H/w9cA38x5Isozf+DxEpqKbKSy2k5c5KS
	AxL4nYJSOKrAGVxKBGIT81SC+0oO7Xsvr5n4RhV0Uhe2poKH6AUTyMNhl0D8a4HJLA8jFH2/0ON
	ZghZhjj9mAS0wwqjZ1PG49XF7QuwtId5bEeIE0+LVBw4HI0QGWfzD4qcdRX/U4CBB8ADKbiSfiz
	wFFRBj8iCHzBRXjz89z/3pA6cTizRfsX783oTAbRPhl99NE4cx7NaVS+3SzWSLnCG5iKpvrCMPU
	01owhLqy8AAjV3Q7Z0cVkqr2WGAfPcRCcX6CcGjQiT7eFkddTEt7a3G0TNmn+HzpJzA8zZvY80O
	3xdBal51CjEZO+1ZrSyVHUpKyacUdCEZP1xA8jrHWiFIZCtn1lLFRYU1bM+A==
X-Received: by 2002:a05:6a21:d83:b0:398:98ab:71a9 with SMTP id adf61e73a8af0-398eccd8644mr10815982637.44.1773635225270;
        Sun, 15 Mar 2026 21:27:05 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([240e:34c:5760:3860:bc29:deed:92d0:823c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738422esm12180267b3a.55.2026.03.15.21.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 21:27:04 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Mon, 16 Mar 2026 12:26:09 +0800
Subject: [PATCH net-next v3 1/5] net: add ndo_update_offloads for offload
 computation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-offload_compute-v3-1-a5d4a07d86d3@gmail.com>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
In-Reply-To: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268022-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4CCF2948F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new ndo_update_offloads callback to net_device_ops that allows
devices to compute and update their offload features during feature
updates.

This callback enables master devices to recompute their features
based on current slave device configuration. This is particularly
useful for bonding, bridging, team, and failover devices that need
to aggregate features from their lower devices.

The callback is optional and only implemented by devices that need
dynamic offload feature computation.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/linux/netdevice.h | 7 +++++++
 net/core/dev.c            | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ae269a2e7f4d..acaec0340266 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1281,6 +1281,12 @@ struct netdev_net_notifier {
  *	constraints, and returns the resulting flags. Must not modify
  *	the device state.
  *
+ * void (*ndo_update_offloads)(struct net_device *dev);
+ *	Called during feature update to allow device to compute and update
+ *	offload features (like vlan_features, hw_enc_features) based on
+ *	current lower device configuration. Typically used by master
+ *	devices to aggregate features from slave devices.
+ *
  * int (*ndo_set_features)(struct net_device *dev, netdev_features_t features);
  *	Called to update device configuration to new features. Passed
  *	feature set might be less than what was returned by ndo_fix_features()).
@@ -1558,6 +1564,7 @@ struct net_device_ops {
 							struct sock *sk);
 	netdev_features_t	(*ndo_fix_features)(struct net_device *dev,
 						    netdev_features_t features);
+	void			(*ndo_update_offloads)(struct net_device *dev);
 	int			(*ndo_set_features)(struct net_device *dev,
 						    netdev_features_t features);
 	int			(*ndo_neigh_construct)(struct net_device *dev,
diff --git a/net/core/dev.c b/net/core/dev.c
index 200d44883fc1..bbd532aa6a1b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11011,6 +11011,9 @@ int __netdev_update_features(struct net_device *dev)
 	ASSERT_RTNL();
 	netdev_ops_assert_locked(dev);
 
+	if (dev->netdev_ops->ndo_update_offloads)
+		dev->netdev_ops->ndo_update_offloads(dev);
+
 	features = netdev_get_wanted_features(dev);
 
 	if (dev->netdev_ops->ndo_fix_features)

-- 
Git-155)


