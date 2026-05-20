Return-Path: <netdev+bounces-290092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIF0KMYTDmoW6AUAu9opvQ
	(envelope-from <netdev+bounces-290092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:04:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8063F599150
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EE713048758
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED2535504D;
	Wed, 20 May 2026 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md6ZBBi6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B0C345CBF
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307423; cv=none; b=pSudBlZKqUcOTL0wkQlSFijsgPxU6hZXMTxEBFGGuJRlTjKSdL2RKXj424EJ3vztTm5c94xTnMPVqobn7bEvOZ0JDpXWtiSccHnXWMhto/kZFCrRa4CRE41jbsq7vCJW8vIvDEDic7HDDBix+57x/o4h5C3ZL7QrPSITR7A+A/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307423; c=relaxed/simple;
	bh=w5MLQIaRpVU5SwkEFl0ywM8vQ/Epne164k8OfCiap98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRYzt5eZcIfak+CivcmRuudUmdgb/dZ0r+fvNCnnwSAxfHxlrUXBZfiMhKaP/H1k1+VsERPtB3ILfmqxBiqvW314dieP9huZxSYDKvvESj9AYzGJTgbpOKKHhhSHmYCxVycWWuatOJsIxM3W2R1WJRq2mfH/iJg4N2N0MC9XVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md6ZBBi6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d87c138e1so58528391cf.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779307421; x=1779912221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJFwvFMqSeGHKF7YuuKfX7SCPCAWVzw/mYZh++eDvbM=;
        b=Md6ZBBi6L891kRa3CYITpsH0nbL6nj2kyNEb29KVvms2HET7uyFGQyVCyFLfkbcovr
         kB1Zlf98XxoHyKoKIoRaSbMdGjgnKZ6cm02BkNGVkRF27jretlWqPgxhasJmI9DVDGEB
         hrDgErotK1SZ3f69OV5iJp/Ku6Zsnh+hNgUB/syoEZkTj/wImRB6vtkLHTcZWM/CrKe7
         RC6f9uhBBn7D4vVizGoABok9Z1j8U1GZPIKv/QM6T1B1tBOJR7pzcGVKkzcTq6DDmFR3
         L8cy6TQuiPiIMnEg8FeJki9MNmbnPn6EPKm8V6LiRgGYRVLgybrw5iH7slgEhPTHdu8T
         EDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307421; x=1779912221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJFwvFMqSeGHKF7YuuKfX7SCPCAWVzw/mYZh++eDvbM=;
        b=gZYSCK/dOi+LNkwQj2PVasjkQ1ojh+LzqrPb5l8B16kRg0uUu55wanV0g5QR/+TFB8
         JKt/Z4WD1Z5sc97CGvAtVqxlmLT3cViP3DfRSlvINXz32L+O73zPucCgDCCmM6ZNmkrk
         AlEzbIjzUYn5Ueuh8EhGvi7hWOcszGnx1TdHpTeoIY3U9mZrMN3EhsSq0PCegcoxBR7C
         jIZB/ts3yZCdr1LCKj1MNNiOq6A5f+pIZe5bwQ37GCOiFDzs3WTwuI7tQ2mkYpFuF0Vx
         ypao5+ka9oHkfXXGktWaHkOXaqhsZUHqjjHC23x4KEWSX8GaZAl6J0VsuthmKBgDc5Xy
         jEhg==
X-Forwarded-Encrypted: i=1; AFNElJ9sSvfkFHsHj7dLqZEAkE5aZO1mMRns/hhRGf+OcwwrAaODXrmPrYW7Is64CUDgzaEJKKjqF7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzySwxfJRltP48ezJYYiMYxXTJN156TQFLB6cCSjcAOoSkU9v9p
	csSGARSK1A/i1UMn6jWEBIJ/E+DFDbheTj6jWJ5srQnRzfRpRvn2tqrU
X-Gm-Gg: Acq92OFJuLduyKEJLSg+8ahI83g+k2nw/X4ygi2wLOFsk6JvbaBAmbX1WAPixy29D2f
	XaTS/QPJLH/AgWO6NiJiPCDf8bfOQaxLpPzGMNUhGXeFNLIOocuGDiw4yPqFPdW9Ro0MFEisf3a
	Dlxhtc+HYE+avJ0Ye51ZFquB9junLX8EH1shvxDyFdw13n303FiyT7nyq62v7ub0l2U0DshUvNu
	lnXU0302oXX6UrQ8qCzS6RmdiAe6CkekK0Wwk/g3RtdPnIdoPqJDwrRrmV0qX8RjWmQiYKoMti/
	CTwgg+7f5acx92KhafpfsYcBOnqxmRP5tldosJ2/Txyp1+JlSskNQh3pa2s4F9EajsVFYZQ2Jpt
	G/4a3KYOFUhCNECfXU5VoRurBUuqbvmhi52quY4FitS9s+dRQow+LtEFhhjN6ZjMuI8J6D5d2vC
	xdpHVxdVgOO8+0f/aIUY+uPxZDa61r+YRss0/LiJmRhpTasbJo1/ao+HLqiJ7iWFsYuaw=
X-Received: by 2002:a05:622a:4d09:b0:509:2527:d789 with SMTP id d75a77b69052e-51659fde5ecmr365261451cf.6.1779307421006;
        Wed, 20 May 2026 13:03:41 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516514e0b91sm188849301cf.15.2026.05.20.13.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:03:40 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lee Trager <lee@trager.us>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Chengfeng Ye <dg573847474@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/3] leds: trigger: netdev: Extend speeds up to 100G
Date: Wed, 20 May 2026 16:03:35 -0400
Message-ID: <20260520200337.204431-2-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520200337.204431-1-mike.marciniszyn@gmail.com>
References: <20260520200337.204431-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,fb.com,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,makrotopia.org,gmail.com,intel.com,trager.us,oracle.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-290092-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8063F599150
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

Add 25G, 40G, 50G, and 100G as available speeds to the netdev LED trigger.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 46 ++++++++++++++++++++++++++-
 include/linux/leds.h                  |  4 +++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 12cb3311ea22..3c758a4cbaec 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -128,6 +128,22 @@ static void set_baseline_state(struct led_netdev_data *trigger_data)
 		    trigger_data->link_speed == SPEED_10000)
 			blink_on = true;
 
+		if (test_bit(TRIGGER_NETDEV_LINK_25000, &trigger_data->mode) &&
+		    trigger_data->link_speed == SPEED_25000)
+			blink_on = true;
+
+		if (test_bit(TRIGGER_NETDEV_LINK_40000, &trigger_data->mode) &&
+		    trigger_data->link_speed == SPEED_40000)
+			blink_on = true;
+
+		if (test_bit(TRIGGER_NETDEV_LINK_50000, &trigger_data->mode) &&
+		    trigger_data->link_speed == SPEED_50000)
+			blink_on = true;
+
+		if (test_bit(TRIGGER_NETDEV_LINK_100000, &trigger_data->mode) &&
+		    trigger_data->link_speed == SPEED_100000)
+			blink_on = true;
+
 		if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &trigger_data->mode) &&
 		    trigger_data->duplex == DUPLEX_HALF)
 			blink_on = true;
@@ -337,6 +353,10 @@ static ssize_t netdev_led_attr_show(struct device *dev, char *buf,
 	case TRIGGER_NETDEV_LINK_2500:
 	case TRIGGER_NETDEV_LINK_5000:
 	case TRIGGER_NETDEV_LINK_10000:
+	case TRIGGER_NETDEV_LINK_25000:
+	case TRIGGER_NETDEV_LINK_40000:
+	case TRIGGER_NETDEV_LINK_50000:
+	case TRIGGER_NETDEV_LINK_100000:
 	case TRIGGER_NETDEV_HALF_DUPLEX:
 	case TRIGGER_NETDEV_FULL_DUPLEX:
 	case TRIGGER_NETDEV_TX:
@@ -373,6 +393,10 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	case TRIGGER_NETDEV_LINK_2500:
 	case TRIGGER_NETDEV_LINK_5000:
 	case TRIGGER_NETDEV_LINK_10000:
+	case TRIGGER_NETDEV_LINK_25000:
+	case TRIGGER_NETDEV_LINK_40000:
+	case TRIGGER_NETDEV_LINK_50000:
+	case TRIGGER_NETDEV_LINK_100000:
 	case TRIGGER_NETDEV_HALF_DUPLEX:
 	case TRIGGER_NETDEV_FULL_DUPLEX:
 	case TRIGGER_NETDEV_TX:
@@ -396,7 +420,11 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	     test_bit(TRIGGER_NETDEV_LINK_1000, &mode) ||
 	     test_bit(TRIGGER_NETDEV_LINK_2500, &mode) ||
 	     test_bit(TRIGGER_NETDEV_LINK_5000, &mode) ||
-	     test_bit(TRIGGER_NETDEV_LINK_10000, &mode)))
+	     test_bit(TRIGGER_NETDEV_LINK_10000, &mode) ||
+	     test_bit(TRIGGER_NETDEV_LINK_25000, &mode) ||
+	     test_bit(TRIGGER_NETDEV_LINK_40000, &mode) ||
+	     test_bit(TRIGGER_NETDEV_LINK_50000, &mode) ||
+	     test_bit(TRIGGER_NETDEV_LINK_100000, &mode)))
 		return -EINVAL;
 
 	cancel_delayed_work_sync(&trigger_data->work);
@@ -433,6 +461,10 @@ DEFINE_NETDEV_TRIGGER(link_1000, TRIGGER_NETDEV_LINK_1000);
 DEFINE_NETDEV_TRIGGER(link_2500, TRIGGER_NETDEV_LINK_2500);
 DEFINE_NETDEV_TRIGGER(link_5000, TRIGGER_NETDEV_LINK_5000);
 DEFINE_NETDEV_TRIGGER(link_10000, TRIGGER_NETDEV_LINK_10000);
+DEFINE_NETDEV_TRIGGER(link_25000, TRIGGER_NETDEV_LINK_25000);
+DEFINE_NETDEV_TRIGGER(link_40000, TRIGGER_NETDEV_LINK_40000);
+DEFINE_NETDEV_TRIGGER(link_50000, TRIGGER_NETDEV_LINK_50000);
+DEFINE_NETDEV_TRIGGER(link_100000, TRIGGER_NETDEV_LINK_100000);
 DEFINE_NETDEV_TRIGGER(half_duplex, TRIGGER_NETDEV_HALF_DUPLEX);
 DEFINE_NETDEV_TRIGGER(full_duplex, TRIGGER_NETDEV_FULL_DUPLEX);
 DEFINE_NETDEV_TRIGGER(tx, TRIGGER_NETDEV_TX);
@@ -521,6 +553,10 @@ static umode_t netdev_trig_link_speed_visible(struct kobject *kobj,
 		CHECK_LINK_MODE_ATTR(2500);
 		CHECK_LINK_MODE_ATTR(5000);
 		CHECK_LINK_MODE_ATTR(10000);
+		CHECK_LINK_MODE_ATTR(25000);
+		CHECK_LINK_MODE_ATTR(40000);
+		CHECK_LINK_MODE_ATTR(50000);
+		CHECK_LINK_MODE_ATTR(100000);
 	}
 
 	return 0;
@@ -533,6 +569,10 @@ static struct attribute *netdev_trig_link_speed_attrs[] = {
 	&dev_attr_link_2500.attr,
 	&dev_attr_link_5000.attr,
 	&dev_attr_link_10000.attr,
+	&dev_attr_link_25000.attr,
+	&dev_attr_link_40000.attr,
+	&dev_attr_link_50000.attr,
+	&dev_attr_link_100000.attr,
 	NULL
 };
 
@@ -668,6 +708,10 @@ static void netdev_trig_work(struct work_struct *work)
 			 test_bit(TRIGGER_NETDEV_LINK_2500, &trigger_data->mode) ||
 			 test_bit(TRIGGER_NETDEV_LINK_5000, &trigger_data->mode) ||
 			 test_bit(TRIGGER_NETDEV_LINK_10000, &trigger_data->mode) ||
+			 test_bit(TRIGGER_NETDEV_LINK_25000, &trigger_data->mode) ||
+			 test_bit(TRIGGER_NETDEV_LINK_40000, &trigger_data->mode) ||
+			 test_bit(TRIGGER_NETDEV_LINK_50000, &trigger_data->mode) ||
+			 test_bit(TRIGGER_NETDEV_LINK_100000, &trigger_data->mode) ||
 			 test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &trigger_data->mode) ||
 			 test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &trigger_data->mode);
 		interval = jiffies_to_msecs(
diff --git a/include/linux/leds.h b/include/linux/leds.h
index b16b803cc1ac..bf31c246d9e2 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -607,6 +607,10 @@ enum led_trigger_netdev_modes {
 	TRIGGER_NETDEV_LINK_2500,
 	TRIGGER_NETDEV_LINK_5000,
 	TRIGGER_NETDEV_LINK_10000,
+	TRIGGER_NETDEV_LINK_25000,
+	TRIGGER_NETDEV_LINK_40000,
+	TRIGGER_NETDEV_LINK_50000,
+	TRIGGER_NETDEV_LINK_100000,
 	TRIGGER_NETDEV_HALF_DUPLEX,
 	TRIGGER_NETDEV_FULL_DUPLEX,
 	TRIGGER_NETDEV_TX,
-- 
2.43.0


