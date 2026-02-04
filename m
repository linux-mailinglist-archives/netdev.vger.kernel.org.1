Return-Path: <netdev+bounces-256524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBzhJgOygmn/YAMAu9opvQ
	(envelope-from <netdev+bounces-256524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:42:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2388FE0F0C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47F8C301DE0A
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 02:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BA52D541B;
	Wed,  4 Feb 2026 02:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYqGundF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3716CD33
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 02:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770172916; cv=none; b=nt3m8ECpUI1ZifJoqYqgLn6WP1BICXqnW+hbEHZL0tENEj/Us0xeRg6OmXOYJ2USuLmfPt9m/G/Rg2D24vkzE0km7A2eJmsFrqBzsrWsrKfHh6WAlvV8/nlGEmVnJ992P0sHkAy/V9uG3QjljcCwLDfuLVdM4Xd1R7bjHyWI1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770172916; c=relaxed/simple;
	bh=2tCFTsqm4upN2YSk3zWwnd55DFcNdOjUNXnhtzNtqXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YMPLaVZEpnVuGOs22Z/KuFxKQWdZ2pY7n6HnOONhqseqSpclYaXRnxhga6gkEsXbJQYQUdCswxFUDnr+8IOBzCGFYIAassKeewwDF0kORsbjZgLkxC8zt2XkEeJOj2/lJsZ8xSVCauYcPjPfttm6Agnh1zgPt8xD/69d9jTtpeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYqGundF; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c6a7638f42so932835785a.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 18:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770172914; x=1770777714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jXvX3IXZnKMrQ9W6NwzXF7vOuM7OaeTGPf1taSFZ40=;
        b=gYqGundFk4BjkjKjA9BDOkrKExhwdvJo4Tz+TsZmyrm2sAm7cQ+zXSf2I6+6GQwp2k
         f1Ezqa/WLufY3kdpjYrUmuIhh+ta3T/DVQHCgcrYTrC0RYO0+6DVstHzc+M/gBumLvBW
         dLbt7II/AZqTBzTWk5kassLvcU1TeM7ooQDDDfmLxlEFieyKQN1/WNPekuNzmqR0NUx0
         MgUwQV79XXdLS+7pMcJxoBxDlHobOlw+A/DdZR+xMGesTd1JMxBRCz2q0TNuCAeG2Nf8
         e6QuGJCimRegG3xROTmRZVcluRneVhvqo7+3eJBlwVo4Y7GoiE0Szn4owNKsEP7abbSq
         M/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172914; x=1770777714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6jXvX3IXZnKMrQ9W6NwzXF7vOuM7OaeTGPf1taSFZ40=;
        b=BtDJfB8HJ/jXh6RD+PrToW2uCWJYE2ZsOdn4Dn2Zn90j2bbd6rv1erm5aZXaY6ipEK
         TIKUMzidwX9VSpU4IDoaHYMTNu1Tj+yFwPHYKgHm4+XuKwCGygyXu6k746dqtKqgQdkU
         Gkv0x1jZlefz1EHoPTi0h/MnDUfCFfGxFhz260pqpqbjffk8jO7/iOj/mSUVjqKXiJOY
         CUH3uVSluTWYUk3r2cOzeeFLXR4OqwNXVJ3/NLRkSzgZSMb6Kr+S4TtNO79ETX4hvqzI
         oOsz5EZ0MelBbfZO5oIMaH91HArdlcOUeN+sSSzt3d1wQMwXnOH3Pj7VkC2eAg7uv8vT
         MN7A==
X-Gm-Message-State: AOJu0YwDK/HQ7H+MzrpmKnFDt2PT47FAC/cBMCqRo3H/lhqknrMgXnwQ
	+e2IZSEG0j/DBRzx/xB/fqna4xIKdkmBc9HbgTkvAvSIhlc+x3G/i5Sv
X-Gm-Gg: AZuq6aLUnSUJOFSATS8A7KDSVW6duQHSGoWNNPdg0oa8yFrxaXY/POHbYy5Lf3Hemfc
	DKqLjoCU5aWSbqFiFmS2Cn9Xo2bwcoyHdISgfyGlx0Bcj+eNE6craZNJ3VlTklIrqIINhrTqGRT
	2gR74GcRBmEM+o1nN2N7Y3KlMOknn2Za6OmpW2q9eNVGvCP5j8E2LK2G25NrnRS0f4I2KNsZHip
	Y8ZuPYzYPHAGpfta9Ldkg5xPJkrlG+DHm0waB0pTTK2xPl5hiIneRc1LmTyN830Ln95IPbg8/j3
	8Gd7GKjRb8u9vXcgeb/M51A+Rxtf2T/anPxe4/F4/vDjh46JwE9TeOFajEMbF3iczrfZoDuWqt2
	d/DkRFzz6IRvl4BYqf90qqvIegBdK3mLq606mwW7siMHqXPjTm9rZq/Jrl5JgUKrqqJCcejrR20
	F9bQZSesROCsOSvxtnm9Pf
X-Received: by 2002:a05:620a:2550:b0:891:a6b0:7cda with SMTP id af79cd13be357-8ca2f9fdbf9mr198979585a.81.1770172914134;
        Tue, 03 Feb 2026 18:41:54 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd40f9asm94762485a.41.2026.02.03.18.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:41:53 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Wed, 04 Feb 2026 10:41:10 +0800
Subject: [PATCH net-next 1/2] net: ti: icssg-prueth-sr1: Remove unused
 workqueue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-icssg-prueth-workqueue-v1-1-9a892f4b293d@gmail.com>
References: <20260204-icssg-prueth-workqueue-v1-0-9a892f4b293d@gmail.com>
In-Reply-To: <20260204-icssg-prueth-workqueue-v1-0-9a892f4b293d@gmail.com>
To: netdev@vger.kernel.org
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Meghana Malladi <m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Himanshu Mittal <h-mittal1@ti.com>, Simon Horman <horms@kernel.org>, 
 Byungchul Park <byungchul@sk.com>, 
 Markus Elfring <elfring@users.sourceforge.net>, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256524-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,intel.com,linux.dev,sk.com,users.sourceforge.net,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2388FE0F0C
X-Rspamd-Action: no action

The dedicated workqueue emac->cmd_wq is not utilized in this driver and
can be safely removed.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

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

-- 
2.52.0


