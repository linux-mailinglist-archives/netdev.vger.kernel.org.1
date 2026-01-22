Return-Path: <netdev+bounces-252524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LG3MHmAcmlElgAAu9opvQ
	(envelope-from <netdev+bounces-252524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:54:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F816D491
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09BDD3040CE4
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7699E38B9B7;
	Thu, 22 Jan 2026 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M96uOaUq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F04392C3E
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111414; cv=none; b=hChTquDbTTBP00gqxaSDVD8PTuLjcbMtfZjmiuqD3SioJ97lzF9Tps9Vsz2/FdVrSPZmno67biF0X8naI91O9zfnoaJnnI7F0sZ/I76+G3kB7lNkFjJjcLryEfEWzjRUaZLgKEqXiB9+4IRIAPDa7T0nUl56cAmnwGJcyks5Xx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111414; c=relaxed/simple;
	bh=cWEjjen3iU6Xvqp/OkWwKAmyec0fe+BlZn2zZ47/9lE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qUp//VNA6c1KXIghtQLxXxHKEarPG9Kt5WuguV/sD47kF5uAibzcIAyab/w6SlrjhoCg4JLEcVFNCAnt+Qe8sSHm7bKXVzOzKQRNifJcoVvV/UtvZK65OFbOPEcnfrsVbiA+L/1rDG6faVZYrAqTOKrMyfko4Xuc/L3j5VqBBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M96uOaUq; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-502a407dabaso10816391cf.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769111403; x=1769716203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1yAspWxagwwLzncLYvd60u9eD/aYkUXrGfaSULQ98Q=;
        b=t9W1gowQfRZ8Qmc4nhh4q89eC52ShEu56GDdkltKcjrNLWSIGknt0OJNSSRCz+Xb3D
         QaFKZRy/jPPXCYjY8XCp+5eEE2Y6Z9mVY+Vk+cFXhZ+D5yuXSWndXNZaqFWPKVd9Lj9N
         5B0O4i0Pio4hbaKpVcrCLeo3OT456ZWcS73S3F/FBjzP878hAvegRW1GXmJf8xzoI+pj
         CNN8SziQl9Km/vbfXiW32Bt+MyBolJS8P9xCNZp4zSAqwKmU9RrKFmScH9ekNZawNfq/
         nvTyryrbFbHZP5CCv24TOnPsYU+A8XCCCo747mUEDC6B6S2ba5hvWPwgF/DtnQdvFz1x
         bZ0g==
X-Gm-Message-State: AOJu0YzfCrAd5L/SzFfi88nOG/ZlnDq7sui/jC/kkYaxDPLBmD4iAj/J
	wUY6s9IJUpLDwkge445TDTFnzWOw62fjzbRMhHRFK6YgK7XL/qOsOB6NPtxsPtXNnHOgmXiU3xL
	pXhsqHyD+/PVVdJUAvDgysjGqeoKllCtGs97bA++3bvURddU0T2ek5/1Ge1wEoBqoFCzbX/AuEM
	mjyh6oRmU0gVmtwAr5RaB03KeNirSvwC+UZdbMeqbVftH/c0nZaly5jN9WdTz1RTTZkJpN6hHSD
	qtIcg7u/A==
X-Gm-Gg: AZuq6aK+ND2smqyEu2PY1YOlgZOIylW7/IUcJcZzX7oO7jFgk1ck0ACa4aVcO99lxzW
	vMSStryS/FWQIXcciQ96Xano/vZ6cULgLxuD2f1J7Ak+xq4A0ZNMvWJtvNlXgu76QZnv3d7ggD3
	U9Sa38wMYlLDN0P00NacZ9iWEyN3tqF5QjuncTPfmoNJwGYuMBQ5el75kDXikjhXkL7KA3kMK/f
	5fNpPdVwTtv8ex6cnbz4orIbo2mvEUcJIsbtPSTYqtqmEuJODOYp9c6hnwQiDGXQ/bdXRPVXKCC
	Y/iXHE81bbFJyxgVrWsiY9iTSWw1uGSl8a2pvxyIVuMSQXz5pIK4dT7bTk8X4VnEz9EJOavS8O0
	buQP4vq5KNyYVy8OAsxUL+B5UIR23QB2trjNt+ZmFDgFUnYwLraEHqZbKhWPlg0E8vXDKd9Rsb/
	+BeV/v6a0fq0ikX49uCvBL9vysMR7Pr4TdeGdJzAEZ
X-Received: by 2002:a05:622a:11cc:b0:4f1:b93d:fb5a with SMTP id d75a77b69052e-502f7705d71mr11351221cf.7.1769111401109;
        Thu, 22 Jan 2026 11:50:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-502f7ec5f50sm128071cf.4.2026.01.22.11.50.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jan 2026 11:50:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-45a8cdc7e01so3065878b6e.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769111400; x=1769716200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1yAspWxagwwLzncLYvd60u9eD/aYkUXrGfaSULQ98Q=;
        b=M96uOaUq/c6oTxcQSNz8QTE4UtrMQ2wnMCIn2a8fy3qHgPnBPi9XXPrUjP92C8EZPj
         I3gQPhoxidHLIYS5cuPeM1vpc2xCz/JKaECai+LiDNf3gmMw4kTAdn7WF4llTiEe7H2J
         199Yx/hH7JwUH1bUJZIVYT0uoP+6fAx70edfQ=
X-Received: by 2002:a05:6808:1316:b0:450:1433:f13a with SMTP id 5614622812f47-45eb1a8d8e3mr417322b6e.11.1769111399977;
        Thu, 22 Jan 2026 11:49:59 -0800 (PST)
X-Received: by 2002:a05:6808:1316:b0:450:1433:f13a with SMTP id 5614622812f47-45eb1a8d8e3mr417300b6e.11.1769111399472;
        Thu, 22 Jan 2026 11:49:59 -0800 (PST)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af88f200sm86671fac.7.2026.01.22.11.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:49:58 -0800 (PST)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v3 2/2] net: bcmasp: streamline early exit in probe
Date: Thu, 22 Jan 2026 11:49:49 -0800
Message-Id: <20260122194949.1145107-3-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122194949.1145107-1-justin.chen@broadcom.com>
References: <20260122194949.1145107-1-justin.chen@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252524-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D7F816D491
X-Rspamd-Action: no action

Streamline the bcmasp_probe early exit. As support for other
functionality is added(i.e. ptp), it is easier to keep track of early
exit cleanup when it is all in one place.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 27 +++++++++++----------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 36df7d1a9be3..aa6d8606849f 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1317,6 +1317,8 @@ static int bcmasp_probe(struct platform_device *pdev)
 
 	bcmasp_core_init_filters(priv);
 
+	bcmasp_init_wol(priv);
+
 	ports_node = of_find_node_by_name(dev->of_node, "ethernet-ports");
 	if (!ports_node) {
 		dev_warn(dev, "No ports found\n");
@@ -1328,16 +1330,14 @@ static int bcmasp_probe(struct platform_device *pdev)
 		intf = bcmasp_interface_create(priv, intf_node, i);
 		if (!intf) {
 			dev_err(dev, "Cannot create eth interface %d\n", i);
-			bcmasp_remove_intfs(priv);
-			ret = -ENOMEM;
-			goto of_put_exit;
+			of_node_put(ports_node);
+			ret = -EINVAL;
+			goto err_cleanup;
 		}
 		list_add_tail(&intf->list, &priv->intfs);
 		i++;
 	}
-
-	/* Check and enable WoL */
-	bcmasp_init_wol(priv);
+	of_node_put(ports_node);
 
 	/* Drop the clock reference count now and let ndo_open()/ndo_close()
 	 * manage it for us from now on.
@@ -1352,19 +1352,20 @@ static int bcmasp_probe(struct platform_device *pdev)
 	list_for_each_entry(intf, &priv->intfs, list) {
 		ret = register_netdev(intf->ndev);
 		if (ret) {
-			netdev_err(intf->ndev,
-				   "failed to register net_device: %d\n", ret);
-			bcmasp_wol_irq_destroy(priv);
-			bcmasp_remove_intfs(priv);
-			goto of_put_exit;
+			dev_err(dev, "failed to register net_device: %d\n", ret);
+			goto err_cleanup;
 		}
 		count++;
 	}
 
 	dev_info(dev, "Initialized %d port(s)\n", count);
 
-of_put_exit:
-	of_node_put(ports_node);
+	return ret;
+
+err_cleanup:
+	bcmasp_wol_irq_destroy(priv);
+	bcmasp_remove_intfs(priv);
+
 	return ret;
 }
 
-- 
2.34.1


