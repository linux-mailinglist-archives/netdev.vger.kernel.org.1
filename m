Return-Path: <netdev+bounces-256984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIuwKhM4hGn51AMAu9opvQ
	(envelope-from <netdev+bounces-256984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 07:26:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A35EF039
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 07:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40B03301FFA6
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 06:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1831D35292B;
	Thu,  5 Feb 2026 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiNs2e+z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8FC334696
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770272733; cv=none; b=VmJObdUi5nS9JwjT5hweQv+LPtFW/Pgd3e+v1R+WmCl27uGuTyPVdQ0Q7KRqnLDYBEiSVksJkApQiCfBTf9ZrqkoKS813pMHVdkR7bIfri8Y3vfwklG94/gK/iH1hRl+Kz7Y4PkqXj655frkFd6RkNH5UewKaExVSDPcPkJfAcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770272733; c=relaxed/simple;
	bh=/B3kX9Jyefw/laVvlQXiBllCLeIh1NtvYVNiIh7k0+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fhW6KMi/MUaRgioHjMnsygWiWK5MDlGANhRHQQipYm0zekhy6tJW3S2WRYF/DmhRQ8jqqie69uPPT4swrxjMmzEF1N9y7qWPIqWjNzZpEBgGdBmY0Qlm2rVVqDcMkUEbAhuRw6/8roQl7PALmfw09X94lN87U370FxhtlP3Glhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiNs2e+z; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c5389c3cd2so55770285a.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 22:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770272732; x=1770877532; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F9Zw0XzlsqtrFcnvP0xl+A5lBqr0v+6APGOlL8zpJrQ=;
        b=fiNs2e+zqKth5p3fFbY4EtXourUAJ1MfPuo3lIgcVV1cGa+jc9cjn5TQT93TRS9/Ue
         pWO7w6SsrysKyF5nI8sbB/uII0/ksoz+fbc6Li1sPkHgkUsE0DbokLax9KWSm08KgZbt
         QzidcpnCGWbBn41XbmwOjU8VNdzURUMhmhAsRXwKkmY9hZSH5DmtkZorDgLcDMfa6Q9Z
         8vy3N1/aVhFrYYsjRqjTG6U/meE72GiE+6nyFPudlR8TtzkbaPCDLVFZtBN9nJCt0mKC
         b4lUUus939WqXlpaVvSVattYKofpZ458CuE+ukiBzvlGxbWOm5hciJY5RQ3y+ZZiKRhM
         uqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770272732; x=1770877532;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9Zw0XzlsqtrFcnvP0xl+A5lBqr0v+6APGOlL8zpJrQ=;
        b=qNAthBs+Yk+xq38t/OQxRZsOk9QNBZTc6Lx8zqg+4hRofQQB1vcEugPxk+HdjI3DZo
         ABu9hjQOhCxzQ88n96QHujIfOYISBVnK7VcA/yKM3Ge+NFoPjkDYtlHpGQRqmr63Ghki
         bIaqWCY/VSPq2cNA0K/qB9mDt/5yvYrSqqVgLAXQSzawTgwRQTlw+RVVlYbK6/cXY+Rs
         2ho1Npodgro4fRrVfzbq3uZbucvXgPng+bun1FNkn3/4CoY3iyXyG38yJaIMAVJT6MDd
         62mHBkQnTB3VGV5vWWAyRGK/cdLlyUdlZtNh8TZXLhW8peVR/P0//O17qcXoMyRnfwYx
         In+Q==
X-Gm-Message-State: AOJu0YyV7gF8uDf+yURBiQ6zdILa9/EaK5xaxAMz25r/uf3cS2/LEmJ5
	oB5Q1qeLJPzNQOkcMyjhgvgiPJ0QC+Xue+RNfj+EKMDYz6BxLhQIeIYe
X-Gm-Gg: AZuq6aJv1N/ESctviLjg63y0f8FYyQq4JFuRo2iGgl5u7K2lB3f1eFFM51CXCc5RS0u
	8SYj9KZOmkPInPla8luAJupPdt9kqHuDvkaP0yT/Wvejlb5QszflNdFLLN+bko7ONcag2PijaF/
	gOviI/84y+cDzTzuciA/BPg1Rq/sibgto29xDnf2nVxvEuVji7O6FqInOfBSg+d6wpiyUNISXTc
	bRANXQBZZOxP6VNwUF8UUtZ/rIbJd3Jf7zfqsHOma5hDU3S3k1yU6FjJffsEB2yzJ5A/mbNul6f
	YInKX7UDtVr52Z1FCB+urA33ioaXPsYky+hYxXZAZgStjOMUy40ws3OyZ+GqOIvS5z3MeB6wSmD
	HgXYa0/QLkqE0UJJyDtOeiOJ49wKPsQ7LpsOprI0ghtxpqInLH+qT90qc395oWYeT7Z13mBkAO8
	s87NnCZ3yvdz0VHU/4bKGfM06lYomxDfI=
X-Received: by 2002:a05:620a:857:b0:8ca:407a:c331 with SMTP id af79cd13be357-8ca407ac3c3mr188804185a.84.1770272731372;
        Wed, 04 Feb 2026 22:25:31 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521d36589sm34824116d6.53.2026.02.04.22.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 22:25:31 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 05 Feb 2026 14:25:09 +0800
Subject: [PATCH net-next v2] net: ti: icssg: Remove dedicated workqueue for
 ndo_set_rx_mode callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-icssg-prueth-workqueue-v2-1-cf5cf97efb37@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMQ3hGkC/3WNQQ6CMBBFr0Jm7ZgyEBRX3sOwKDDARG2xLYgh3
 N2GuHX58vLfX8GzE/ZwSVZwPIsXayLQIYFm0KZnlDYykKJCkcpQGu97HN3EYcC3dffXxBNjlxe
 Ka32iNCOI49FxJ8sevoHhgIaXAFU0g/hg3Wd/nNPd/+L5v/icosJSn0vq8prKrL32Ty2PY2OfU
 G3b9gWnlNJxxgAAAA==
X-Change-ID: 20260203-icssg-prueth-workqueue-f460eba72132
To: netdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, MD Danish Anwar <danishanwar@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Meghana Malladi <m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Himanshu Mittal <h-mittal1@ti.com>, Simon Horman <horms@kernel.org>, 
 Byungchul Park <byungchul@sk.com>, 
 Markus Elfring <elfring@users.sourceforge.net>, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256984-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,intel.com,linux.dev,sk.com,users.sourceforge.net,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,linux.dev:url,linux.dev:email]
X-Rspamd-Queue-Id: 16A35EF039
X-Rspamd-Action: no action

Currently, both the icssg-prueth and icssg-prueth-sr1 drivers create
a dedicated 'emac->cmd_wq' workqueue.

In the icssg-prueth-sr1 driver, this workqueue is not utilized at all.

In the icssg-prueth driver, the workqueue is only used to execute the
actual processing of ndo_set_rx_mode. However, creating a dedicated
workqueue for such a simple use case is unnecessary. To simplify the
code, switch to using the system default workqueue instead.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
While addressing an issue in the cpsw driver, I based my fix [1] on the
implementation of the emac_ndo_set_rx_mode() function in icssg. During review,
Jakub pointed out that the dedicated workqueue for the ndo_set_rx_mode
callback might be unnecessary [2]. I subsequently used the system workqueue for
this purpose in the cpsw driver, and it performed as expected. Therefore,
I believe the same approach can be applied to the icssg driver. This
patch aim to remove this dedicated workqueue for icssg drivers.

Please note: I do not have access to a board that supports the CSSG PRU
Ethernet controller, so this change has only been build-tested.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=c0b5dc73a38f954e780f93a549b8fe225235c07a
[2] https://lore.kernel.org/all/20260127190836.6a420768@kernel.org/
---
Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Meghana Malladi <m-malladi@ti.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Himanshu Mittal <h-mittal1@ti.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-arm-kernel@lists.infradead.org
---
Changes in v2:
- Given the issue identified by the AI [3], squash these two patches into
  one as suggested by Jakub.

- Include the cpsw fix link and the link to Jakub's email in the cover letter,
  as requested by Meghana.

- Link to v1: https://lore.kernel.org/r/20260204-icssg-prueth-workqueue-v1-0-9a892f4b293d@gmail.com

[3] https://netdev-ai.bots.linux.dev/ai-review.html?id=02da18ab-455d-4d98-88bb-d8a975623c3f
---
 drivers/net/ethernet/ti/icssg/icssg_common.c     |  1 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.c     | 13 ++++---------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h     |  1 -
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c |  9 +--------
 4 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 090aa74d3ce7257ae52158b2ff9a2a1239bfcfc8..0cf9dfe0fa362b4ff986b6815952f95b79cb476d 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1720,7 +1720,6 @@ void prueth_netdev_exit(struct prueth *prueth,
 	netif_napi_del(&emac->napi_rx);
 
 	pruss_release_mem_region(prueth->pruss, &emac->dram);
-	destroy_workqueue(emac->cmd_wq);
 	free_netdev(emac->ndev);
 	prueth->emac[mac] = NULL;
 }
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index f65041662173c1968f7e70dc4a3d897523f24095..0939994c932f5322eebbaa1b2fe43e20d3dca5ae 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1099,7 +1099,7 @@ static void emac_ndo_set_rx_mode(struct net_device *ndev)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 
-	queue_work(emac->cmd_wq, &emac->rx_mode_work);
+	schedule_work(&emac->rx_mode_work);
 }
 
 static netdev_features_t emac_ndo_fix_features(struct net_device *ndev,
@@ -1451,11 +1451,6 @@ static int prueth_netdev_init(struct prueth *prueth,
 	emac->port_id = port;
 	emac->xdp_prog = NULL;
 	emac->ndev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
-	emac->cmd_wq = create_singlethread_workqueue("icssg_cmd_wq");
-	if (!emac->cmd_wq) {
-		ret = -ENOMEM;
-		goto free_ndev;
-	}
 	INIT_WORK(&emac->rx_mode_work, emac_ndo_set_rx_mode_work);
 
 	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
@@ -1467,7 +1462,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	if (ret) {
 		dev_err(prueth->dev, "unable to get DRAM: %d\n", ret);
 		ret = -ENOMEM;
-		goto free_wq;
+		goto free_ndev;
 	}
 
 	emac->tx_ch_num = 1;
@@ -1566,8 +1561,6 @@ static int prueth_netdev_init(struct prueth *prueth,
 
 free:
 	pruss_release_mem_region(prueth->pruss, &emac->dram);
-free_wq:
-	destroy_workqueue(emac->cmd_wq);
 free_ndev:
 	emac->ndev = NULL;
 	prueth->emac[mac] = NULL;
@@ -2236,6 +2229,7 @@ static int prueth_probe(struct platform_device *pdev)
 			prueth->emac[i]->ndev->phydev = NULL;
 		}
 		unregister_netdev(prueth->registered_netdevs[i]);
+		disable_work_sync(&prueth->emac[i]->rx_mode_work);
 	}
 
 netdev_exit:
@@ -2295,6 +2289,7 @@ static void prueth_remove(struct platform_device *pdev)
 		phy_disconnect(prueth->emac[i]->ndev->phydev);
 		prueth->emac[i]->ndev->phydev = NULL;
 		unregister_netdev(prueth->registered_netdevs[i]);
+		disable_work_sync(&prueth->emac[i]->rx_mode_work);
 	}
 
 	for (i = 0; i < PRUETH_NUM_MACS; i++) {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 10eadd35665045a98a0c0a639606b7c2691195de..3d94fa5a7ac10992d35fdb63458f8cb6eb3a5a22 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -236,7 +236,6 @@ struct prueth_emac {
 	/* Mutex to serialize access to firmware command interface */
 	struct mutex cmd_lock;
 	struct work_struct rx_mode_work;
-	struct workqueue_struct	*cmd_wq;
 
 	struct pruss_mem_region dram;
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index 7bb4f0d850cc72d997e5ead38cf56f1dbc2355a1..b8115ca47082f9676067bb65c6eb3a441290fd7c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -783,11 +783,6 @@ static int prueth_netdev_init(struct prueth *prueth,
 	emac->prueth = prueth;
 	emac->ndev = ndev;
 	emac->port_id = port;
-	emac->cmd_wq = create_singlethread_workqueue("icssg_cmd_wq");
-	if (!emac->cmd_wq) {
-		ret = -ENOMEM;
-		goto free_ndev;
-	}
 
 	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
 
@@ -798,7 +793,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	if (ret) {
 		dev_err(prueth->dev, "unable to get DRAM: %d\n", ret);
 		ret = -ENOMEM;
-		goto free_wq;
+		goto free_ndev;
 	}
 
 	/* SR1.0 uses a dedicated high priority channel
@@ -883,8 +878,6 @@ static int prueth_netdev_init(struct prueth *prueth,
 
 free:
 	pruss_release_mem_region(prueth->pruss, &emac->dram);
-free_wq:
-	destroy_workqueue(emac->cmd_wq);
 free_ndev:
 	emac->ndev = NULL;
 	prueth->emac[mac] = NULL;

---
base-commit: 0f8a890c4524d6e4013ff225e70de2aed7e6d726
change-id: 20260203-icssg-prueth-workqueue-f460eba72132

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


