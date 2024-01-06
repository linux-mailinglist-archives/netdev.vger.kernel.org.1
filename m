Return-Path: <netdev+bounces-62202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 352D98261EB
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 23:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED3CB20C8F
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 22:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35300F9F8;
	Sat,  6 Jan 2024 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1qYPgjl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CD5101CD
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28d25253d2so65553466b.0
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 14:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704579644; x=1705184444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iW2+fdyQKQ7TJUeOpb4TgcptNTyvGHeMXvNrYHzjOl8=;
        b=K1qYPgjlC5HalC/WcUZmJMrvjSR2okMzsZYplw1ThSiSblG1el79odODHTqgUsnE5m
         d2SfSdtx5AdbBSsgd8M1YN4JNvn4nsb0KTdAZhJxZVoZTWX6hDtZpey2n7KA9lEVAR/s
         O4Wst7DnXmksbUpPZH0xEg+yiyeBTzNzEFXINs0bPCXnYg3xU9B0gqrElJMfw3JNbHcg
         sZZhwSEvP1z83+7V4v4N9TmEQ028fKof1I8d0FC2nGPbGk4lvfknjpRnOAvWnxwrztTU
         M/i++PBcctFo5FKbbOLOrASnRt0ywa7kOalcTzE4FKqLha0/aYkzRJtNA+hb7Me1pS+i
         nYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704579644; x=1705184444;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iW2+fdyQKQ7TJUeOpb4TgcptNTyvGHeMXvNrYHzjOl8=;
        b=bNXO8R1ZCO+0Uc42okor43S8nyiIqKU6omAjUI4ZsORl3m/jPiy66InnlZ6rZD3ehZ
         XBOD4PWIJvHUDTBpU0+qEmV0dcvdggEnFTP+/CF9gSYl4syp5mSs2p+t4UKFG0T1sCvA
         e1Hi2jD3ZZ3QZ0g0cusrE0853MYI47GAjRVEmWHahGvQoHLY/W57cj9JbkQbobKRj2Te
         YApAgeIfLxPkWnaxnJmNIoeoQxmdXFXf2VxhtZd8vfw6JawpKX+kou4gdV5SjaXHb9aJ
         NqfW2CeQVc2W2KO+MJjhVbDbKf9jW3BKxY7gNrIM5LYLp3mvcDdxjpF23dRU/uxONw4I
         AmaA==
X-Gm-Message-State: AOJu0Yy2EpYaanaYV8EBS9xzezbqEDppatzivc+romUbl+TGhlCT1N7Q
	ayQDzqeDoX1Ol7cDLUTj9qXCu3bvDVg=
X-Google-Smtp-Source: AGHT+IFHZ/S0/BGIQ7Q8KDf9FeyG2P7tMOEGnds6JdiefiE0jYo2SuoXHboSX5WmlqdwLJtsj2DFug==
X-Received: by 2002:a17:906:25d0:b0:a23:57f3:95a9 with SMTP id n16-20020a17090625d000b00a2357f395a9mr712140ejb.2.1704579643619;
        Sat, 06 Jan 2024 14:20:43 -0800 (PST)
Received: from ?IPV6:2a01:c22:7310:c700:9da3:cda2:7a2c:5dba? (dynamic-2a01-0c22-7310-c700-9da3-cda2-7a2c-5dba.c22.pool.telefonica.de. [2a01:c22:7310:c700:9da3:cda2:7a2c:5dba])
        by smtp.googlemail.com with ESMTPSA id x17-20020a170906297100b00a26e4986df8sm2380056ejd.58.2024.01.06.14.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 14:20:43 -0800 (PST)
Message-ID: <bb510240-edc5-4e52-aadb-fe00c0c94708@gmail.com>
Date: Sat, 6 Jan 2024 23:20:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 RFC 3/5] ethtool: adjust struct ethtool_keee to kernel
 needs
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

This patch changes the following in struct ethtool_keee
- remove member cmd, it's not needed on kernel side
- remove reserved fields
- switch the semantically boolean members to type bool

We don't have to change any user of the boolean members due to the
implicit casting from/to bool. A small change is needed where a
pointer to bool members is used, in addition remove few now unneeded
double negations.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/ethtool.h |  8 +++-----
 net/ethtool/eee.c       | 10 +++++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 501dfeb92..25f82d23b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -223,15 +223,13 @@ __ethtool_get_link_ksettings(struct net_device *dev,
 			     struct ethtool_link_ksettings *link_ksettings);
 
 struct ethtool_keee {
-	u32	cmd;
 	u32	supported;
 	u32	advertised;
 	u32	lp_advertised;
-	u32	eee_active;
-	u32	eee_enabled;
-	u32	tx_lpi_enabled;
 	u32	tx_lpi_timer;
-	u32	reserved[2];
+	bool	tx_lpi_enabled;
+	bool	eee_active;
+	bool	eee_enabled;
 };
 
 struct kernel_ethtool_coalesce {
diff --git a/net/ethtool/eee.c b/net/ethtool/eee.c
index 21b0e845a..fa7ee51b5 100644
--- a/net/ethtool/eee.c
+++ b/net/ethtool/eee.c
@@ -98,10 +98,10 @@ static int eee_fill_reply(struct sk_buff *skb,
 	if (ret < 0)
 		return ret;
 
-	if (nla_put_u8(skb, ETHTOOL_A_EEE_ACTIVE, !!eee->eee_active) ||
-	    nla_put_u8(skb, ETHTOOL_A_EEE_ENABLED, !!eee->eee_enabled) ||
+	if (nla_put_u8(skb, ETHTOOL_A_EEE_ACTIVE, eee->eee_active) ||
+	    nla_put_u8(skb, ETHTOOL_A_EEE_ENABLED, eee->eee_enabled) ||
 	    nla_put_u8(skb, ETHTOOL_A_EEE_TX_LPI_ENABLED,
-		       !!eee->tx_lpi_enabled) ||
+		       eee->tx_lpi_enabled) ||
 	    nla_put_u32(skb, ETHTOOL_A_EEE_TX_LPI_TIMER, eee->tx_lpi_timer))
 		return -EMSGSIZE;
 
@@ -145,8 +145,8 @@ ethnl_set_eee(struct ethnl_req_info *req_info, struct genl_info *info)
 				    link_mode_names, info->extack, &mod);
 	if (ret < 0)
 		return ret;
-	ethnl_update_bool32(&eee.eee_enabled, tb[ETHTOOL_A_EEE_ENABLED], &mod);
-	ethnl_update_bool32(&eee.tx_lpi_enabled,
+	ethnl_update_bool(&eee.eee_enabled, tb[ETHTOOL_A_EEE_ENABLED], &mod);
+	ethnl_update_bool(&eee.tx_lpi_enabled,
 			    tb[ETHTOOL_A_EEE_TX_LPI_ENABLED], &mod);
 	ethnl_update_u32(&eee.tx_lpi_timer, tb[ETHTOOL_A_EEE_TX_LPI_TIMER],
 			 &mod);
-- 
2.43.0



