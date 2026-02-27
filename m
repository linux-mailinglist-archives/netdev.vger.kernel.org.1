Return-Path: <netdev+bounces-261987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKgSK6wWomnFzAQAu9opvQ
	(envelope-from <netdev+bounces-261987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:11:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0544F1BE8F3
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14D273038179
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 22:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E5942E007;
	Fri, 27 Feb 2026 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1Zus6kv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111ED1E5724
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230041; cv=none; b=MyhblEF21p82+PKzx7kPC4jEN5qaiMshjNyugCQLS6iPEyW8ogsUuEL+cXNR9Yj+Ovi+/XghjUqzZ2HbyDaiu/r/DfXeTsjGjQ20bCG8nlLaow/eemfSSbOdPjfgmhrX18XzuuGNvhXU8l4gyjtsrr/o0PKXcoYSeO+p2M25fIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230041; c=relaxed/simple;
	bh=ssZUr8x7uGJPh9IGVUBPRHIVBT5XAGThBiHq4o3kFZA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CY9HfUG43GY0XpQX/MAIIbKoPt1ML8YV6mgrkKe0ftQPnF2LDi4vJpq1jbiB7XQcpqlFMK3NMgUxQYIDl7gY8vudJyCQDaNm0FP/rj9UeijYL9J04XKCitYRW9OFZbrhuG1hXDJ6NfKYg4z7NX+DiarkoBPsXejK0XrD6y/NzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1Zus6kv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48371bb515eso35492395e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 14:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772230038; x=1772834838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DS4LGSvIu8q2vm01HHgR6qMEY9aKFIdSVR0andlN5Ok=;
        b=Q1Zus6kvYomKlC4jhVLbY9jYenVRRJUbkW8w8h/25Z+15tCMArow7GL3aN29rjkhZy
         HzRkIunCYEsTWR4pBJCA9My/M+0PQZ2VDyc2uJuNsauxtR736Pg5BCOFuZOOnYcYMah3
         m8gULArx2yT70V6bWgm1p3/KMs4AZCcLW/Abk3vSDxNLWgCYj2uNPRGNMd1niotedNyZ
         dqadz1kxcMSM+DGXrvxpXmb0QeaXT5gglLvMsrCGsC7DonpJ0GSefKXwJp7NDHBw3ZtM
         keFUIjlm7vFWPZQ4EcIZXKoSS4D5roLxw+Zw+rTcmiPK0ZqwpH4wkAFbg67pKyGt5teW
         hi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772230038; x=1772834838;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DS4LGSvIu8q2vm01HHgR6qMEY9aKFIdSVR0andlN5Ok=;
        b=jthJGFUHWYels5+kN8+lg93OVwdW4wq8xMh8DqONA7X7EQHW+6cZ3lXMmFb/1U/bhF
         Kxlc9HUgQJKR4SDwKnmAs+yt1MmgNNnKc5WsCUbKOFJPI7PYpB75/PW7y28VbllLj+P7
         pKBUS6Qqe6NwautD6/wpFUa+pNpvzneYqD6kOaSLRjGtkQSTI7vht2Sz1jSeQsLpqXot
         L2bi92jMolf0a5BexG9IeUckIeGVTc4GUv8wH5ViNtRWFpn/eLrS8HTxwMvyn6MY8zHP
         imHSsbxq5Q/jsieh55fHXNo6O88uonAwSKWuOadrR94+lFTQZdzN8bg229cddE5eWDZr
         4+ng==
X-Gm-Message-State: AOJu0YyiSuT7w+F0v/wCsYdBbKqNRXi4iEFI1BxfJAeWzJg0WJeO7A4t
	13N6yP7/PSYz88BgNfARqbKrWZJkXRol0pX6Nve9ECI43DIeOl0DqGbf
X-Gm-Gg: ATEYQzy/OvWjcQo3xooPkWAfQPCcK6hMI1OU18/YT5A+r7caVE/5ZqoV5OnD4/ZWNWX
	V95kfHArdnFXkC30795pX63ifsjWSj4yPIVtRrVaS6cuLKQwc26vx7n/CK7QogdmtgL6hnpG7nV
	motKGJbuI9HPHdYnAdLbshCQ9d9b8MwVsAgNOmkZ+p9vNVhfi1Qy6Hdu1sihoL8kkTClnODnKae
	mIA4Sk1197wgO52BJGGoTTOfhjn1xlezF1OJhDelS/evQUhG28FsUB0BWt3aBaO+BoFCWUek9BT
	JcJv2JFAxfWg0b/0bOn+NOLOZWI6pRjGLwU3JrCbmywhzX7Sz94OSejaEci/K57ZRIgqawqzCha
	pincU4tiwmxLKElaab90pN9nSrn3sBKxC8t5sWi/PjXz0ikgk8Kg2C7xLy4rzeljdM2HRKQWoMl
	/esH28LWBCtxCv8yxnJCjJ2eAuNHBVm2Y7STssBJRIWJzsuK3N7kiiAASFaybkTQhrYZEY3Kdtb
	QCWM7+I2Lln0VTNYDXs6g4xc5Bt7+K2c8okLwlDQgm/DAlXyvJAw9FSBk9awdQl7A==
X-Received: by 2002:a05:600c:628c:b0:47e:e712:aa88 with SMTP id 5b1f17b1804b1-483c9c28da8mr73814765e9.31.1772230038396;
        Fri, 27 Feb 2026 14:07:18 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93? (p200300ea8f145500d4cd9f12bbf59c93.dip0.t-ipconnect.de. [2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b89c99sm130538555e9.15.2026.02.27.14.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 14:07:17 -0800 (PST)
Message-ID: <03a812a7-6871-4cc0-b5bf-ee80c6d6b5fd@gmail.com>
Date: Fri, 27 Feb 2026 23:07:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/8] net: phy: consider that
 mdio_bus_device_stat_field_show doesn't use member address
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
Content-Language: en-US
In-Reply-To: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-261987-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0544F1BE8F3
X-Rspamd-Action: no action

mdio_bus_device_stat_field_show() doesn't use the address member,
so we don't have to initialize it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 0c0cf7a7296..f189e9fbcbd 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -199,7 +199,6 @@ static struct mdio_bus_stat_attr dev_attr_mdio_bus_##field = {		\
 };									\
 static struct mdio_bus_stat_attr dev_attr_mdio_bus_device_##field = {	\
 	.attr = __ATTR(field, 0444, mdio_bus_device_stat_field_show, NULL), \
-	.address = -1,							\
 	.field_offset = offsetof(struct mdio_bus_stats, field),		\
 }
 
-- 
2.53.0



