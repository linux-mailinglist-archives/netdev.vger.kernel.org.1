Return-Path: <netdev+bounces-60753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB59E821569
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 22:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C2F2819A3
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 21:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7D6DF66;
	Mon,  1 Jan 2024 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV+0meBy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9784DF5E
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7aed09adso6692222e87.0
        for <netdev@vger.kernel.org>; Mon, 01 Jan 2024 13:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704144196; x=1704748996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UOwtLFe67Ps5xZwmjRXbHbTWfnEz1KpZ/V9Hn2oTNOk=;
        b=HV+0meBy7gxiTx0hAddo8YrdZl1A27paxZUSOlIxLpziOC/r50yky4LsCzrb83G6J6
         XTAGZG8lf2Lz5g5TUggnnOEuqMED4uRPuSi6vEpgZRCNyyY0aT9/fkmaT7LGn8Icasgs
         h7toHN//MliZCWiri4wK5WB3NIAgWvRcn5EOdm3oXootNd1Ml+uxPSS4hEF6hK/cSt3s
         wx6S9ABMJcOfQdqFpdx90n6iY5VuTpBHQuir8n2a8qih8oE8EdsjJydp1N38nxcbdVGk
         CD1greQmrwciXLoEI/+WVgsFXu9qNiYkB6fdgi509Sq4TJjTQ5m0BhrMKFCvM6yaUf6F
         ADUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704144196; x=1704748996;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOwtLFe67Ps5xZwmjRXbHbTWfnEz1KpZ/V9Hn2oTNOk=;
        b=wvpS0gU5G7HsFJM/IBoPzjIWRc0X3fVJHoSfmhF8Pzj3ao7eDBHRV6NtqP40w1DStn
         b2/+DZOu7Z+u1bgmsXmGB27O7QkVOjzrsWkuMHDpdGg1fGSQmcDcSg4KxCQTC0NFE7rg
         +k9paO4eBlNDSoRAm4HOsQwojhBadUhoGttVu9mPIAbynFhuDGrKv/O3gwpkeNLd0HSP
         rv7M/PePJmagoST4FQMcYnlqynSS6su5B8OxgSDPELf7qFUQaaL6OkLdBVzJN0esR0rm
         potXYclUwIDzszHXlS2lBXPKZByVE4nJzaxOBOwDL6g3ZgN0JvGM3rUsVeMGsNRFRFMh
         egqA==
X-Gm-Message-State: AOJu0Yza3qFE+wXwY0gQGWdpgnd5UhofC6PLjzl7p9y07O/p13Ng0/FU
	ObCn574rBKEDJVitW9+CwKY=
X-Google-Smtp-Source: AGHT+IFXNLhDFOQ5korDyVF7NJCOP44PBhfeZV3wQIR/71J65/njWx3kwYVGaErq7gvUJvsfj0SxQQ==
X-Received: by 2002:a05:6512:713:b0:50e:7c08:4364 with SMTP id b19-20020a056512071300b0050e7c084364mr4602357lfs.45.1704144195460;
        Mon, 01 Jan 2024 13:23:15 -0800 (PST)
Received: from ?IPV6:2a01:c22:6e6b:b000:65c3:c8c0:cae3:f9e1? (dynamic-2a01-0c22-6e6b-b000-65c3-c8c0-cae3-f9e1.c22.pool.telefonica.de. [2a01:c22:6e6b:b000:65c3:c8c0:cae3:f9e1])
        by smtp.googlemail.com with ESMTPSA id fv14-20020a170907508e00b00a269f8e8869sm11159750ejc.128.2024.01.01.13.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 13:23:15 -0800 (PST)
Message-ID: <a044621e-07f3-4387-9573-015f255db895@gmail.com>
Date: Mon, 1 Jan 2024 22:23:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/5] ethtool: add struct ethtool_keee and extend
 struct ethtool_eee
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

In order to pass EEE link modes beyond bit 32 to userspace we have to
complement the 32 bit bitmaps in struct ethtool_eee with linkmode
bitmaps. Therefore, similar to ethtool_link_settings and
ethtool_link_kesettings, add a struct ethtool_keee. Use one byte of
the reserved fields in struct ethtool_eee as flag that an instance
of struct ethtool_eee is embedded in a struct ethtool_keee, thus the
linkmode bitmaps being accessible. Add ethtool_eee2keee() as accessor.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/ethtool.h      | 18 ++++++++++++++++++
 include/uapi/linux/ethtool.h |  4 +++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index cfcd952a1..3b46405dd 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -163,6 +163,24 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
 #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
 	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
 
+struct ethtool_keee {
+	struct ethtool_eee eee;
+	struct {
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising);
+	} link_modes;
+	bool use_link_modes;
+};
+
+static inline struct ethtool_keee *ethtool_eee2keee(struct ethtool_eee *eee)
+{
+	if (!eee->is_member_of_keee)
+		return NULL;
+
+	return container_of(eee, struct ethtool_keee, eee);
+}
+
 /* drivers must ignore base.cmd and base.link_mode_masks_nwords
  * fields, but they are allowed to overwrite them (will be ignored).
  */
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 0787d561a..ffc5ab130 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -365,6 +365,7 @@ struct ethtool_eeprom {
  * @tx_lpi_timer: Time in microseconds the interface delays prior to asserting
  *	its tx lpi (after reaching 'idle' state). Effective only when eee
  *	was negotiated and tx_lpi_enabled was set.
+ * @is_member_of_keee: struct is member of a struct ethtool_keee
  * @reserved: Reserved for future use; see the note on reserved space.
  */
 struct ethtool_eee {
@@ -376,7 +377,8 @@ struct ethtool_eee {
 	__u32	eee_enabled;
 	__u32	tx_lpi_enabled;
 	__u32	tx_lpi_timer;
-	__u32	reserved[2];
+	__u8    is_member_of_keee;
+	__u8	reserved[7];
 };
 
 /**
-- 
2.43.0



