Return-Path: <netdev+bounces-252517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNRNFCx9cmmklQAAu9opvQ
	(envelope-from <netdev+bounces-252517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:40:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF316D234
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E748300C0D1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5FE3904C3;
	Thu, 22 Jan 2026 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IdjGFWSa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189DE366573
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110824; cv=none; b=kbxOJO+awLAG053ZR000p6YaYfptKXnWGXWh46h2g+kGvFyY+K/5/9xhA+B7u7tt47Fz740rk00HYe+vB4mINfmHGaU0saFqC8p23lv5/eX+Af81y7fo+WOhI+/UDkWRgarzB16BYRcHJzk4XAGoZP3svFeUo0yaXTDy+vVSlS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110824; c=relaxed/simple;
	bh=5kR1oPky9PoHfzoK1WjXKdq/U71MFZkkOpXkbSupIeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bb/bOdkhC79Kjp4s54vgxljXuLNte8jQBz9W7T2ffMb1sWpbZBescRh/WbSnWE62mWG/EZkJRuYpQYCCujAIXORc+b4ziPyjl09kR7Oma1Nw48Z3rnLcfXpnahfTvzoLbrN0GhJtrLQo6PJIOgiZWmTwuKt4YvrdXgEBWEVHx4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IdjGFWSa; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-93f5774571eso350374241.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110815; x=1769715615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=air/u5OUfTouCCGUdKwX0g6Dh+Y50cyifWMauUnBaJc=;
        b=VNlkKH3gD61J6+PPVUbrtEcgAYaySEXtyGuyWRNdIkBIi4jXMwFezet14uZL8E1GAB
         jXh8R134Ejh6W1TuUCdHxBQE+Vm0lTZTZMlTPdSRdar7BGBshNkwaX0CFw3vAoQNdEO9
         2owh5AoKEE5yX+kqoSyZfBpnRhFDxMhrKZpNlbKjWlAFv0xFZNOlecAfOUojqj2297ov
         4q8dD9VZpNsu9pr6IitbRAUvMf3tLoCeV+n/HhGKrx0wgJWWGwAR4NvARkQkHL8hw3gV
         qlvPuswqRuOJ0jhihn8aqsfogXr9KvUQjBNmdPG3sjW7KyXDctNNJ+C6LJIs/ESeO73e
         6uGw==
X-Gm-Message-State: AOJu0YynjRCl3nbLo/uMcyJzy5fs3AaRYvv/0oZZv3GceAVgagcPplxa
	cfZsx1n5KSQNsunHJhk0uhEvFDdmiI/KRIuwyGo+wxVE0yhAWyx9FoWJ50bKVNbpj6u4Cm3hluD
	Ya5ltnnonVpgW4DF7Mbr1kQu517Zf1W4kW+gkrSi6/n0sK8KUe+qzJdfgaii/72ham7jXh5XqpO
	sFiwf2sDKxsZDLFvH8Ts0Fg0fMmXzzAmAdySwONSe1Vm/1OtfM/tEfdkCqei40YGhNHv56Z6PbS
	6ft6VhEQQ==
X-Gm-Gg: AZuq6aJqP7oti6iNvzTA7OWsmvrxa/2MvNZgCqQchIELAyOZk95qWWzvDAbb+6f36Rw
	hoOLWNp3EkEcqTB1lidC1/o1QeH8wBvTpYV6UABq365ssndFJRYfU2uj3oS0EL2NaSpVTChUzwT
	vMt26L1j0To5oDmCuCjXXJRXlNgr1dVsToKO3HnrQYLWj2V05lOIbznDgBjOOdHehcODuTCRT5Q
	dhLusGpkL/nFpukCWP0OYAK9DmEWXPbJrjke8zTlGvMK1lH4x0h4VfwN758uwW+fDsIvJNWOdpJ
	2wVEgQySbwsBnpcw7yN24DsPTM32VJX+FOoltL3axnTcoXIDZTqz6ZAwwNwFpy9Br7zSt5v92V9
	4DWOdKQGnmKSv7WTyXrh4fh3FZUfxw7gUgyu3raAUhfzKy/WHj+U1uPdxx1+ya9dbKIjptBySzr
	mae5dBbjcOPfk7bMC4FrdWI4GZDfE8/WygwAWQzj+1
X-Received: by 2002:a05:6102:4405:b0:5ee:a2b0:c791 with SMTP id ada2fe7eead31-5f54bc66528mr280453137.22.1769110815156;
        Thu, 22 Jan 2026 11:40:15 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5f54d1452d8sm34800137.0.2026.01.22.11.40.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jan 2026 11:40:15 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b72b6fc371so1457983eec.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769110813; x=1769715613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=air/u5OUfTouCCGUdKwX0g6Dh+Y50cyifWMauUnBaJc=;
        b=IdjGFWSa7Q76JtCptje0pGvmiQQPVwojhvlAAlZNAKON5dOAmeRHL9iP+3/jP3YFAa
         Cxhi1v9D5TgpcrMsD+KfnWfsassk2CmAT24oGgT3k4djSMwSy4FEM085UepRmIfxfIV+
         YcNwMDAoTFlF0UhbA9e7DGlaGHrJuXWgbdLww=
X-Received: by 2002:a05:7300:80c9:b0:2a4:3592:cf6b with SMTP id 5a478bee46e88-2b73999972bmr267591eec.15.1769110813271;
        Thu, 22 Jan 2026 11:40:13 -0800 (PST)
X-Received: by 2002:a05:7300:80c9:b0:2a4:3592:cf6b with SMTP id 5a478bee46e88-2b73999972bmr267568eec.15.1769110812696;
        Thu, 22 Jan 2026 11:40:12 -0800 (PST)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa08964sm374037eec.28.2026.01.22.11.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:40:12 -0800 (PST)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH] net: bcmasp: fix early exit leak with fixed phy
Date: Thu, 22 Jan 2026 11:40:01 -0800
Message-Id: <20260122194001.1098859-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252517-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EBF316D234
X-Rspamd-Action: no action

We are not deregistering the fixed phy link when hitting the early
exit condition. Add the correct early exit sequence.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index b9973956c480..ceb6c11431dd 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -1261,7 +1261,7 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 		netdev_err(intf->ndev, "invalid PHY mode: %s for port %d\n",
 			   phy_modes(intf->phy_interface), intf->port);
 		ret = -EINVAL;
-		goto err_free_netdev;
+		goto err_deregister_fixed_link;
 	}
 
 	ret = of_get_ethdev_address(ndev_dn, ndev);
@@ -1286,6 +1286,9 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 
 	return intf;
 
+err_deregister_fixed_link:
+	if (of_phy_is_fixed_link(ndev_dn))
+		of_phy_deregister_fixed_link(ndev_dn);
 err_free_netdev:
 	free_netdev(ndev);
 err:
-- 
2.34.1


