Return-Path: <netdev+bounces-62201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B9C8261EA
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 23:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47424B214DA
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E59101D0;
	Sat,  6 Jan 2024 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmk0qCnD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E34B101C8
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28cc85e6b5so68616566b.1
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 14:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704579604; x=1705184404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xVOzlqn6PhWG6juT/UGAVwS7NgHqVAWWoxYO6Y1edCU=;
        b=Gmk0qCnDjPQu6gKbzU2k8/bugjXqDFAOtfbjKMSFDNlZ0Ldqyfn2Ti33yDZncf+4hv
         oULWVNp/759V8rr66tYwoLTNOj9LM+DupjgawXYkDFM9Q/MnwDe1iKJGU+Cf+1s7hN62
         Rbe3szGCERwlHgHqmplp8B06n6HtA6LKAFBbWnGqB3cncWedwr2msFcKnu3VcVFpjJD/
         FfZK9/ESLC7PZPDzDFgO1SI9it+EZab8VC8Tho4Ga81/yETHUsQ4FbTodN7bt9I5tYxM
         DGw7OyrU0mxnKMDoU3IoOPWymB2AeDiEJ1kkhHemyugaEsHTttSd7T4LT/dFBNk/nlvt
         bK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704579604; x=1705184404;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVOzlqn6PhWG6juT/UGAVwS7NgHqVAWWoxYO6Y1edCU=;
        b=xHOSg1FVOzR4b5cMbMrYH/MHSo5wH9S0T5vGhPvFxLxF6CxA+inPsNVhULRRJdNFwQ
         iuR/RFYwTcKot8zGk2+5AidC75vtmkNCbwOX3Pzk1KAAtYnw6NP32SqGHK2bmwndZo4O
         yD+l5mXOF7SHd8ZYMOzTpcSQsdbAgkQOKcnInhs9ZtFmpUUoHR/mH5aCj5IhawdU9S4U
         b8+Nrn/KCqSb6HWl3cWa6iJc02SZ2NeCl82JY/YQei+UQ6AefLEV9ErcZtESsjQVN0fV
         uHBas6nIbBTjyGLu8gHqh3tgKH+A0W709ebUvskonQZddXz03TzDV7tbndspSLrRN+r3
         Sdpw==
X-Gm-Message-State: AOJu0Yzv4NQe8mUhdmG4JPqQidlTuMEqc5FZb6ystCReP5tqWmsiftp2
	vlei7AWbMHFGyJwbrbePLsE=
X-Google-Smtp-Source: AGHT+IHlBNFiYF3gSeRrwx/vMlWBHH7zHGv9Y/q/PHcguwbYe1Vwp/Mm5yrRPRmZlBBOwlfDxKA0bQ==
X-Received: by 2002:a17:906:c307:b0:a28:a8b9:5e1c with SMTP id s7-20020a170906c30700b00a28a8b95e1cmr377461ejz.53.1704579604156;
        Sat, 06 Jan 2024 14:20:04 -0800 (PST)
Received: from ?IPV6:2a01:c22:7310:c700:9da3:cda2:7a2c:5dba? (dynamic-2a01-0c22-7310-c700-9da3-cda2-7a2c-5dba.c22.pool.telefonica.de. [2a01:c22:7310:c700:9da3:cda2:7a2c:5dba])
        by smtp.googlemail.com with ESMTPSA id x17-20020a170906297100b00a26e4986df8sm2380056ejd.58.2024.01.06.14.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 14:20:03 -0800 (PST)
Message-ID: <ba3105df-74ae-4883-b9e9-d517036a73b3@gmail.com>
Date: Sat, 6 Jan 2024 23:20:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 RFC 2/5] ethtool: switch back from ethtool_keee to
 ethtool_eee for ioctl
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Russell King <rmk+kernel@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <8d8700c8-75b2-49ba-b303-b8d619008e45@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <8d8700c8-75b2-49ba-b303-b8d619008e45@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In order to later extend struct ethtool_keee, we have to decouple it
from the userspace format represented by struct ethtool_eee.
Therefore switch back to struct ethtool_eee, representing the userspace
format, and add conversion between ethtool_eee and ethtool_keee.
Struct ethtool_keee will be changed in follow-up patches, therefore
don't do a *keee = *eee here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 net/ethtool/ioctl.c | 49 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 099d02e7d..9222fbeeb 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1505,22 +1505,51 @@ static int ethtool_set_wol(struct net_device *dev, char __user *useraddr)
 	return 0;
 }
 
+static void eee_to_keee(struct ethtool_keee *keee,
+			const struct ethtool_eee *eee)
+{
+	memset(keee, 0, sizeof(*keee));
+
+	keee->supported = eee->supported;
+	keee->advertised = eee->advertised;
+	keee->lp_advertised = eee->lp_advertised;
+	keee->eee_active = eee->eee_active;
+	keee->eee_enabled = eee->eee_enabled;
+	keee->tx_lpi_enabled = eee->tx_lpi_enabled;
+	keee->tx_lpi_timer = eee->tx_lpi_timer;
+}
+
+static void keee_to_eee(struct ethtool_eee *eee,
+			const struct ethtool_keee *keee)
+{
+	memset(eee, 0, sizeof(*eee));
+
+	eee->supported = keee->supported;
+	eee->advertised = keee->advertised;
+	eee->lp_advertised = keee->lp_advertised;
+	eee->eee_active = keee->eee_active;
+	eee->eee_enabled = keee->eee_enabled;
+	eee->tx_lpi_enabled = keee->tx_lpi_enabled;
+	eee->tx_lpi_timer = keee->tx_lpi_timer;
+}
+
 static int ethtool_get_eee(struct net_device *dev, char __user *useraddr)
 {
-	struct ethtool_keee edata;
+	struct ethtool_keee keee;
+	struct ethtool_eee eee;
 	int rc;
 
 	if (!dev->ethtool_ops->get_eee)
 		return -EOPNOTSUPP;
 
-	memset(&edata, 0, sizeof(struct ethtool_keee));
-	edata.cmd = ETHTOOL_GEEE;
-	rc = dev->ethtool_ops->get_eee(dev, &edata);
-
+	memset(&keee, 0, sizeof(keee));
+	rc = dev->ethtool_ops->get_eee(dev, &keee);
 	if (rc)
 		return rc;
 
-	if (copy_to_user(useraddr, &edata, sizeof(edata)))
+	keee_to_eee(&eee, &keee);
+	eee.cmd = ETHTOOL_GEEE;
+	if (copy_to_user(useraddr, &eee, sizeof(eee)))
 		return -EFAULT;
 
 	return 0;
@@ -1528,16 +1557,18 @@ static int ethtool_get_eee(struct net_device *dev, char __user *useraddr)
 
 static int ethtool_set_eee(struct net_device *dev, char __user *useraddr)
 {
-	struct ethtool_keee edata;
+	struct ethtool_keee keee;
+	struct ethtool_eee eee;
 	int ret;
 
 	if (!dev->ethtool_ops->set_eee)
 		return -EOPNOTSUPP;
 
-	if (copy_from_user(&edata, useraddr, sizeof(edata)))
+	if (copy_from_user(&eee, useraddr, sizeof(eee)))
 		return -EFAULT;
 
-	ret = dev->ethtool_ops->set_eee(dev, &edata);
+	eee_to_keee(&keee, &eee);
+	ret = dev->ethtool_ops->set_eee(dev, &keee);
 	if (!ret)
 		ethtool_notify(dev, ETHTOOL_MSG_EEE_NTF, NULL);
 	return ret;
-- 
2.43.0



