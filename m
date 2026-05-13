Return-Path: <netdev+bounces-287712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JifGkTIBGrdNwIAu9opvQ
	(envelope-from <netdev+bounces-287712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:51:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E2E5394CE
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0DDC309DADC
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D933B83EF;
	Wed, 13 May 2026 18:36:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E638E3B6BE4
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697390; cv=none; b=VdsJV7M40S7RZ+M8SbQqSWJVUe7adX/ZR0UyT5QeyyWie9KSQlyoxuGOOSkzfzY11sMyktzBYAoLdgTWjfPdRbQFNH+a0/nq85XFOGNb9qT08956N2cb3yPyw8uEIcFEQmPbifeACdYiVzfLMQAebb9LMATxmMocVnc8CRwTXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697390; c=relaxed/simple;
	bh=kkNx7pBIe4lTrSygNXIC+r7fP19o5wlqxg31cX6buFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnKTP2fDDDrde8eE0bADSK0od803d8wvhRUEcqQtB/Q9IHllqJ3MYtjmgGOuAT6GPxsIATN1qVDG5JaRGkuN8WUt27s+4adWiiHdt/3pzht0VpETHYUnx0TfA2nD466yHTNOsxPFv1UFQaLsD9puD9xZoR8CJ4srELsT5Ia7e8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-44a74032ff8so5337999f8f.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 11:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697387; x=1779302187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j17dyAXjVQ5kVJZNPUptY+dBBjRJ1RjAOk+0kE7NMQ4=;
        b=eN/mtxWNUAC1UOre8Weq2LFP9/EO10WF4z0vYp/MWmSPWIWGhkXPx7SOai2t1sX/rz
         Lz6eT5+80sVO08EEBLJvfnSd3SCqRvuUjayH2BfoE1U1CTthGhFKNvr2+A1qIKKqYGa1
         YJiNiOjYYtAtYQBrrAA1fCZVjit7m/Z2AH/fAmf27fHl91SH+dq0N0Can1qmL56KlQ+0
         LXiAD2ZyOrQxo2spTMsMgP3ubycdvy2aMXvp/y6VCZs8WS9ch6mjglsDSmlZTm1nyU8/
         zdsGIXY3auvRQzTCTIiCTw7yk1DlXNbhOAHnvTJaBtwb11WCmb6IvUQ3G8JTEmig779R
         j/0A==
X-Gm-Message-State: AOJu0YzC+u/kjbv8kJ7fkaVggJ8yPsuKGzObFlp9/1kxLPOQ54qIFka+
	pKOGPpH0IXiFFcaK5otakPIpc9c9uv/5zaw+81WetVvKEJQSv2kxjRWYORNQWQ5t
X-Gm-Gg: Acq92OGO32Cw/VYFpmLp1PGjkfMEXOteo729qhUs9TwrzPFUzDf3sMU17aXTOm5kIbg
	p7IeKhwV4adtxuAIqWic6jOCp4QeOORlLqjcGNV90JPBaNDlEoDalZOdBgcLVONdLnjZcQ4MMal
	RJMTRSvJeEjZSvBvfmijfmzsB+mk/tkAHHeLTBqV78Ve3aAhYG/al4hTJcoRoFGRAfBFe2hdqHx
	q3seIm/3yz+qKRt4aE5W8pbX78v48mNu7VDMWnAcR61b0qafcXG70nmLTUjTBlnGWzhLUenA0pq
	/TF8JRZXsPTz+spTDTM8RbKRU0yqZcA4em6VUQADY7gGFT1QssWaQQYN2hc8va0SH19/xaGVeGa
	CDsiqUC05YY13cmUAgOSEAvEV9rXtD3GV0swL7slzI6CT0q0r3jC115M4Ec5AZzWYuZi63M6dnI
	rweud7n5s/7z3GQ92y/cm+mUjgbRYxrwOzs7gLf2VPaN6F5+IuJnMB4xhgkSPaFFq/G5oEpg==
X-Received: by 2002:a05:6000:1787:b0:452:d03a:7aad with SMTP id ffacd0b85a97d-45c7b7630famr6803975f8f.36.1778697387064;
        Wed, 13 May 2026 11:36:27 -0700 (PDT)
Received: from im-t490s.redhat.com (37-48-40-237.nat.epc.tmcz.cz. [37.48.40.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm720609f8f.34.2026.05.13.11.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:26 -0700 (PDT)
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
Subject: [RFC net-next 4/6] net: geneve: remove unused geneve_dev_create_fb
Date: Wed, 13 May 2026 20:35:24 +0200
Message-ID: <20260513183559.2141010-5-i.maximets@ovn.org>
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
X-Rspamd-Queue-Id: 82E2E5394CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287712-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.937];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:email,ovn.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The only user was vport-geneve in openvswitch and now it is gone.

Note: since it's an exported symbol, there is a possibility that some
out-of-tree module is using it.  So, alternative is to deprecate it
instead by adding a warning if it is ever called.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 drivers/net/geneve.c | 48 --------------------------------------------
 include/net/geneve.h |  5 -----
 2 files changed, 53 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index b36fad8337245..153b15e4ef569 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -2364,54 +2364,6 @@ static struct rtnl_link_ops geneve_link_ops __read_mostly = {
 	.fill_info	= geneve_fill_info,
 };
 
-struct net_device *geneve_dev_create_fb(struct net *net, const char *name,
-					u8 name_assign_type, u16 dst_port)
-{
-	struct nlattr *tb[IFLA_MAX + 1];
-	struct net_device *dev;
-	LIST_HEAD(list_kill);
-	int err;
-	struct geneve_config cfg = {
-		.df = GENEVE_DF_UNSET,
-		.use_udp6_rx_checksums = true,
-		.ttl_inherit = false,
-		.collect_md = true,
-		.port_min = 1,
-		.port_max = USHRT_MAX,
-	};
-
-	memset(tb, 0, sizeof(tb));
-	dev = rtnl_create_link(net, name, name_assign_type,
-			       &geneve_link_ops, tb, NULL);
-	if (IS_ERR(dev))
-		return dev;
-
-	init_tnl_info(&cfg.info, dst_port);
-	err = geneve_configure(net, dev, NULL, &cfg);
-	if (err) {
-		free_netdev(dev);
-		return ERR_PTR(err);
-	}
-
-	/* openvswitch users expect packet sizes to be unrestricted,
-	 * so set the largest MTU we can.
-	 */
-	err = geneve_change_mtu(dev, IP_MAX_MTU);
-	if (err)
-		goto err;
-
-	err = rtnl_configure_link(dev, NULL, 0, NULL);
-	if (err < 0)
-		goto err;
-
-	return dev;
-err:
-	geneve_dellink(dev, &list_kill);
-	unregister_netdevice_many(&list_kill);
-	return ERR_PTR(err);
-}
-EXPORT_SYMBOL_GPL(geneve_dev_create_fb);
-
 static int geneve_netdevice_event(struct notifier_block *unused,
 				  unsigned long event, void *ptr)
 {
diff --git a/include/net/geneve.h b/include/net/geneve.h
index 5c96827a487e7..ba2c14d61e904 100644
--- a/include/net/geneve.h
+++ b/include/net/geneve.h
@@ -68,9 +68,4 @@ static inline bool netif_is_geneve(const struct net_device *dev)
 	       !strcmp(dev->rtnl_link_ops->kind, "geneve");
 }
 
-#ifdef CONFIG_INET
-struct net_device *geneve_dev_create_fb(struct net *net, const char *name,
-					u8 name_assign_type, u16 dst_port);
-#endif /*ifdef CONFIG_INET */
-
 #endif /*ifdef__NET_GENEVE_H */
-- 
2.53.0


