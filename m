Return-Path: <netdev+bounces-287714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN0iAPbGBGrdNwIAu9opvQ
	(envelope-from <netdev+bounces-287714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:46:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4750A539360
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 683D9316B5E5
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7183BB683;
	Wed, 13 May 2026 18:36:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B23BAD99
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697396; cv=none; b=STSccHuRaqCRon/2OjRFqvnL4RsY8rOzcqo2cpUGBRa+AcuciP8YxI5Bvr0AbxtEkLwTIQ8LrU3DvKV7UeNrVpeHztpCBwUnGY85XTY2QKJYxc1TFbr2HLMUNGyk90s5jA+4EqpGo2weIMIQvO4lxjHS2FhFktwcaFridJPAtf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697396; c=relaxed/simple;
	bh=kZX/r+OVbNS99jAb+BoohSS98YrAmd3t6gUja+MHPPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7x+vDoivOfQoyEKfpM5oiRCHHJdRuWR0l133FSE7xM3iHW4TfgxkOMkiOBigSHIfIBPeEJY8c7hW894uzNHrKd7jiqohEOOf4DEYtUli2Bqvbd6Y1vCJ36gzbM69Am+TeUUeOHjwNQTsOxpg9zpSVOCCdCgoq1YRpc5iTUbqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-44e1860558fso4609315f8f.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 11:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697392; x=1779302192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5orSk5lz/dkdQ3h8M1OvcHYEXPczUi59eHca+Pa6CNU=;
        b=n7bDwQmtRDH25RZAS+ZTfeJq5o7Hs+o41YWK5M+8mxrx5ni+Rs6BsWzP8ii4dx4UKK
         GqZ5myWCKvUdB3uJaAzYofhA8T9cyVrDiGcAH72FJ+9wH2TC8uaP/dk6X9Vs7ta2aUjC
         cxRzeeXXYfgOObgebGhHXI9nlPEf7EwLQuwlQwBnT5cyH/qzJdeCPxWH1qHY1zz3NInW
         0kWJsmkgU3qkp321ABO4iM/1dlN2tzTT7pFxpEsA+NDNcAZ8HaFNSUKV/ldzX2DoBX+t
         j5qP0Qtv6fVZ+SlL7iFvIzmMLBSNj3M7AaWDYWyWdOab6K+YVsf/Q2DnoKJxgzOKjKUc
         6Hbw==
X-Gm-Message-State: AOJu0YwaGCppNvW2k6wXGveCQKSWjcYzRpBXIHa1P6XwBNu+5y2dT+hl
	lotivslbZqYr3inXnLNm1BmaLRqQ/vbtcN3dNMY33oQ36B+K2JXogrTJkjk/gkCd
X-Gm-Gg: Acq92OHk5hsi3qu9EVc/7nWn4nAxO5/dCxOEnYOLJevIvJYR1JGi2BYPqlxU+JiEW6u
	9qqIMNXvEMcJJyy9iXBdNL64bfGWjis5GK9t2ZdJbtWf9rO3h31254IsVc7Pfggfu/3XBZHoGlV
	GTv9jZdGDCi0rxizaqxFPPF7De1GkOcXr9olpGuJ5jeukZu/5RA5XqAOjLS4xQQVStlPJVaoKnr
	XK3vgnuoxNRkUSzihXvAtjJk7CIdpiqo5ziP2Iw/NMUwO4gGunnzhwLr28opBEvspK7o0uyRhxJ
	3e+UJUMtpr55L0GlmA7uY1tyhnM6FdOjFDuq7X6lyOHSm3/l5Y+e5mhfw/hjb6fH/aJ4pSwOAFq
	7Ek6giPeivHkJ/BVsbZoJN7fu7jBnaqp5RzQbtEw1Zr+MsNFdgIqiLY7C0DwiD9EGAk6Wl4ffE3
	ogq6u77i/B/M2jOVvBSdn5Ic6JwKjmhtVi8lzD7jwqF1A3HYb8q19RNiMEsE0=
X-Received: by 2002:a05:6000:1a8e:b0:43d:6244:f8b with SMTP id ffacd0b85a97d-45c58696efemr7199749f8f.13.1778697392060;
        Wed, 13 May 2026 11:36:32 -0700 (PDT)
Received: from im-t490s.redhat.com (37-48-40-237.nat.epc.tmcz.cz. [37.48.40.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm720609f8f.34.2026.05.13.11.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:31 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Petr Machata <petrm@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Antoine Tenart <atenart@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [RFC net-next 6/6] net: vxlan: remove unused vxlan_dev_create
Date: Wed, 13 May 2026 20:35:26 +0200
Message-ID: <20260513183559.2141010-7-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513183559.2141010-1-i.maximets@ovn.org>
References: <20260513183559.2141010-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4750A539360
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287714-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.931];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ovn.org:email,ovn.org:mid]
X-Rspamd-Action: no action

The vport-vxlan in openvswitch was the last user and it is now gone.

And we can now rename the internal function to have a better name.

Note: since it's an exported symbol, there is a possibility that some
out-of-tree module is using it.  So, alternative is to deprecate it
instead by adding a warning if it is ever called.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 drivers/net/vxlan/vxlan_core.c | 42 ++++------------------------------
 include/net/vxlan.h            |  3 ---
 2 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 00facbfabced4..a3e9608095685 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3958,9 +3958,9 @@ static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
 	return 0;
 }
 
-static int __vxlan_dev_create(struct net *net, struct net_device *dev,
-			      struct vxlan_config *conf,
-			      struct netlink_ext_ack *extack)
+static int vxlan_dev_create(struct net *net, struct net_device *dev,
+			    struct vxlan_config *conf,
+			    struct netlink_ext_ack *extack)
 {
 	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	struct vxlan_dev *vxlan = netdev_priv(dev);
@@ -4408,7 +4408,7 @@ static int vxlan_newlink(struct net_device *dev,
 	if (err)
 		return err;
 
-	return __vxlan_dev_create(link_net, dev, &conf, extack);
+	return vxlan_dev_create(link_net, dev, &conf, extack);
 }
 
 static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -4689,40 +4689,6 @@ static struct rtnl_link_ops vxlan_link_ops __read_mostly = {
 	.get_link_net	= vxlan_get_link_net,
 };
 
-struct net_device *vxlan_dev_create(struct net *net, const char *name,
-				    u8 name_assign_type,
-				    struct vxlan_config *conf)
-{
-	struct nlattr *tb[IFLA_MAX + 1];
-	struct net_device *dev;
-	int err;
-
-	memset(&tb, 0, sizeof(tb));
-
-	dev = rtnl_create_link(net, name, name_assign_type,
-			       &vxlan_link_ops, tb, NULL);
-	if (IS_ERR(dev))
-		return dev;
-
-	err = __vxlan_dev_create(net, dev, conf, NULL);
-	if (err < 0) {
-		free_netdev(dev);
-		return ERR_PTR(err);
-	}
-
-	err = rtnl_configure_link(dev, NULL, 0, NULL);
-	if (err < 0) {
-		LIST_HEAD(list_kill);
-
-		vxlan_dellink(dev, &list_kill);
-		unregister_netdevice_many(&list_kill);
-		return ERR_PTR(err);
-	}
-
-	return dev;
-}
-EXPORT_SYMBOL_GPL(vxlan_dev_create);
-
 static void vxlan_handle_lowerdev_unregister(struct vxlan_net *vn,
 					     struct net_device *dev)
 {
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index dfba89695efcf..7db2c9dd67e79 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -359,9 +359,6 @@ struct vxlan_dev {
 					 VXLAN_F_MC_ROUTE          |	\
 					 0)
 
-struct net_device *vxlan_dev_create(struct net *net, const char *name,
-				    u8 name_assign_type, struct vxlan_config *conf);
-
 static inline netdev_features_t vxlan_features_check(struct sk_buff *skb,
 						     netdev_features_t features)
 {
-- 
2.53.0


