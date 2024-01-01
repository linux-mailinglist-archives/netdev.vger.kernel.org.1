Return-Path: <netdev+bounces-60754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8560A82156A
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 22:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1D41C20D16
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 21:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F50DF5E;
	Mon,  1 Jan 2024 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAMrSMP5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7620DF60
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so648814666b.2
        for <netdev@vger.kernel.org>; Mon, 01 Jan 2024 13:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704144277; x=1704749077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iHSgEkLdYBW2aYRpBaZXyH/qFOleDjrda0bZqZExYcg=;
        b=cAMrSMP5LroIrZ1YBmkYYz/dFmUQOcCzcezUc4IDnpbwqIY/iuuoPtf99L7m+/sh/G
         /gEd4YSsXH3IWdj3/CJXRxW3k9lb6sKOJ0PPU3IrZHNldYSSQ7mvqQLg/ZyILBtHcs88
         H/oONiDc1zzwonLNPXQ6bXVSDn8kzJ2V0yD08o6HAWoKZb7qx1Exd/G/lE9fA1z1J7JL
         orRMNi0DH7GWXPwTMyP0M+lBBm1jfWN4GViQZaE9OZdLf/PIDdKAwwmxdrsex/1DLHjC
         ZS3mRktwXxjTaVVTOTI56Z3sofL9f+7ztwwUqLNbtN+OeZNPFfexTJKnIpOKHo3rE08S
         jiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704144277; x=1704749077;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHSgEkLdYBW2aYRpBaZXyH/qFOleDjrda0bZqZExYcg=;
        b=dOCPovMPynD4xOF/AVypvxGVxtB/vXsvLDiWRbZ4IAPTtquS8NfEsXr9G731NpTaWF
         /awKWhM/OWftqT5hjLt7yd9HwZvSvKhK5hDIoTViBkXb+iq7Fd07rhrtf6XrlK0WDqV8
         MjPmvwzYA2m9x/0oeRsfQGMBLiCn4MmAlRbBSJv2RtBglymfnsKFaqctB5K25dcWQHEN
         yT4RCGaCWyitq+WCQS6nZC0GbW00sX/GImKZnxqnFmtVu7V8NgrvzJ3560nF0u4GC5jM
         MaGuO0h597tLaGz7qgrloxiynfAkdsv57vG65+qOg14xWKMK9e2bmCnFaybp1Ajbhyzr
         XesQ==
X-Gm-Message-State: AOJu0Ywi/DJtY0wlqoxg2vEEtdqFYYBaJUwzLjU7FBlVGGcCzCiLMBe6
	bquRpi5EOGtsqV1mCIJ0apk=
X-Google-Smtp-Source: AGHT+IHk0Z/Nx+80eqvm04MN6pgG+OcxUjHEkPw5KJicgdY/YR/lfNZONLQ0egWa/4inGC48oEdeQg==
X-Received: by 2002:a17:906:2807:b0:a26:9876:ae88 with SMTP id r7-20020a170906280700b00a269876ae88mr4435893ejc.73.1704144276767;
        Mon, 01 Jan 2024 13:24:36 -0800 (PST)
Received: from ?IPV6:2a01:c22:6e6b:b000:65c3:c8c0:cae3:f9e1? (dynamic-2a01-0c22-6e6b-b000-65c3-c8c0-cae3-f9e1.c22.pool.telefonica.de. [2a01:c22:6e6b:b000:65c3:c8c0:cae3:f9e1])
        by smtp.googlemail.com with ESMTPSA id fv14-20020a170907508e00b00a269f8e8869sm11159750ejc.128.2024.01.01.13.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 13:24:36 -0800 (PST)
Message-ID: <c2a3aa5c-0c12-4aaf-8a44-05f015e718bd@gmail.com>
Date: Mon, 1 Jan 2024 22:24:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/5] ethtool: add basic handling of struct
 ethtool_keee
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Russell King <rmk+kernel@armlinux.org.uk>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is in preparation of follow-up functional changes, and it adds
basic handling of struct ethtool_keee. No functional change intended.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 net/ethtool/eee.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/ethtool/eee.c b/net/ethtool/eee.c
index 2853394d0..9b34d3310 100644
--- a/net/ethtool/eee.c
+++ b/net/ethtool/eee.c
@@ -13,7 +13,7 @@ struct eee_req_info {
 
 struct eee_reply_data {
 	struct ethnl_reply_data		base;
-	struct ethtool_eee		eee;
+	struct ethtool_keee		keee;
 };
 
 #define EEE_REPDATA(__reply_base) \
@@ -30,14 +30,17 @@ static int eee_prepare_data(const struct ethnl_req_info *req_base,
 {
 	struct eee_reply_data *data = EEE_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
+	struct ethtool_keee *keee = &data->keee;
+	struct ethtool_eee *eee = &keee->eee;
 	int ret;
 
+	eee->is_member_of_keee = 1;
 	if (!dev->ethtool_ops->get_eee)
 		return -EOPNOTSUPP;
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
-	ret = dev->ethtool_ops->get_eee(dev, &data->eee);
+	ret = dev->ethtool_ops->get_eee(dev, eee);
 	ethnl_ops_complete(dev);
 
 	return ret;
@@ -48,7 +51,8 @@ static int eee_reply_size(const struct ethnl_req_info *req_base,
 {
 	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
 	const struct eee_reply_data *data = EEE_REPDATA(reply_base);
-	const struct ethtool_eee *eee = &data->eee;
+	const struct ethtool_keee *keee = &data->keee;
+	const struct ethtool_eee *eee = &keee->eee;
 	int len = 0;
 	int ret;
 
@@ -84,7 +88,8 @@ static int eee_fill_reply(struct sk_buff *skb,
 {
 	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
 	const struct eee_reply_data *data = EEE_REPDATA(reply_base);
-	const struct ethtool_eee *eee = &data->eee;
+	const struct ethtool_keee *keee = &data->keee;
+	const struct ethtool_eee *eee = &keee->eee;
 	int ret;
 
 	ret = ethnl_put_bitset32(skb, ETHTOOL_A_EEE_MODES_OURS,
@@ -132,28 +137,30 @@ ethnl_set_eee(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct net_device *dev = req_info->dev;
 	struct nlattr **tb = info->attrs;
-	struct ethtool_eee eee = {};
+	struct ethtool_keee keee = {};
+	struct ethtool_eee *eee = &keee.eee;
 	bool mod = false;
 	int ret;
 
-	ret = dev->ethtool_ops->get_eee(dev, &eee);
+	eee->is_member_of_keee = 1;
+	ret = dev->ethtool_ops->get_eee(dev, eee);
 	if (ret < 0)
 		return ret;
 
-	ret = ethnl_update_bitset32(&eee.advertised, EEE_MODES_COUNT,
+	ret = ethnl_update_bitset32(&eee->advertised, EEE_MODES_COUNT,
 				    tb[ETHTOOL_A_EEE_MODES_OURS],
 				    link_mode_names, info->extack, &mod);
 	if (ret < 0)
 		return ret;
-	ethnl_update_bool32(&eee.eee_enabled, tb[ETHTOOL_A_EEE_ENABLED], &mod);
-	ethnl_update_bool32(&eee.tx_lpi_enabled,
+	ethnl_update_bool32(&eee->eee_enabled, tb[ETHTOOL_A_EEE_ENABLED], &mod);
+	ethnl_update_bool32(&eee->tx_lpi_enabled,
 			    tb[ETHTOOL_A_EEE_TX_LPI_ENABLED], &mod);
-	ethnl_update_u32(&eee.tx_lpi_timer, tb[ETHTOOL_A_EEE_TX_LPI_TIMER],
+	ethnl_update_u32(&eee->tx_lpi_timer, tb[ETHTOOL_A_EEE_TX_LPI_TIMER],
 			 &mod);
 	if (!mod)
 		return 0;
 
-	ret = dev->ethtool_ops->set_eee(dev, &eee);
+	ret = dev->ethtool_ops->set_eee(dev, eee);
 	return ret < 0 ? ret : 1;
 }
 
-- 
2.43.0



