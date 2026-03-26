Return-Path: <netdev+bounces-271943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJJHMHP7xGny5QQAu9opvQ
	(envelope-from <netdev+bounces-271943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:25:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1F0332430
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5771318629F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88503BE167;
	Thu, 26 Mar 2026 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXglUfpy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556653BC691
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516255; cv=none; b=SKD/lZzt3J97Bp6Y9f+YqEu1PGKDQPT7+cqZiRT3TlNiBZlAFku17op2k+lV2g9zCIWdHLIommIlv+SKCiAzrFDvkQN9ooJg+jvdJtT6e9UXHsdQu3lAoWriNYNkRnfZ1FKHHDITRvYKYEgPepW3Mv9k4xAoc9RzikvNJhFAE28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516255; c=relaxed/simple;
	bh=w8YrNU6qSKQOL4v7BNN0lhmGvLNAujqTaPgLpClW6ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u1NOSSgaLJe5jeQ163gqNm3bLPJ7ijMc8Fp33T242tzzsyswHm3Lq42rwja+RYbdU45BL5hVx79g2Zb5pOoIW0bLT1+RiwhVGf3Ht/Mx7xiEJ4Ndm2HB57xLxVYo3TQnhKk6CoqYZpKzm0HunZIZrSwUXPdjVYd8ZGAbpL119uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXglUfpy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b94a19fdso649137f8f.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774516253; x=1775121053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dALVgYOMBgS7RxAtSMkBHMyPuZ2ZR74RfMbaRb9k6oE=;
        b=QXglUfpyI7aTmqmedT1uMw8D7Jrw5J8ynj3Pl+PbZGYTefdBi2mg1aIH+Ut3bUhiKk
         C/YvWkCUVBTqfceZtxWuyuHwOlhpQotO4S9NqzLFA50xZb4reZge6Ancb6fy3JSCjMyb
         9j2R3+Gwf2wurGuRmZEvRu4868CUKczgNsAEKWmiOuu7Fp5Jqb+DwCerlJY+5ONokErC
         t79JF2uJpfjT3Bgsu4mKxkBaaS3rg3IzTDrhrEa5LmgRTrMCck6fKC0X1LvxteMX2+jz
         OUf9+sKD2B+tdS3r75SxM7VfODw6jc281e0SZLY9GSdU753NhtpUzKHvCRt6vhxJ17Bn
         TnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774516253; x=1775121053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dALVgYOMBgS7RxAtSMkBHMyPuZ2ZR74RfMbaRb9k6oE=;
        b=FV6q++woFMvSwhg0oExUUbZoitQN5TTns+9rOLXc2OvmOI5IDBXo0ExS/4T/YSy5it
         sL/eV+nkpvtYkZUkiPMHLkhlG1EKRJdwoHrvGnBq8eYkAFHcN26OFzVERPfsxFt71lPr
         UPKsp2WTFY7iFgVVtVdsTzEc1lLS2JMnf3rIVBbkl0q+yUIWscIx1T52HgCVvwOI5oBC
         DP3tpgzUXpS6WKGDtyqZ9JxXZFSiYgJj5Zrw2kSnJfb7PESWv3AvkheJIb4yYhswC0Tm
         m1mc98N01LQNVRuDDzVvPiu2Yf2k+CbqhRFIdByoeevom4uuD6TCfuJQ69TtV1cXeTJS
         4OYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk9pSB5yEPBClWGhPw/OClLWBwYUxMc8SSHPlXGh9mzJJiPyFylpxtF3/skvC3XkwneP8EMoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHrygZxFZZqyPu4Pd9cck/J6Qv00ivfZKLlBa9UDsgijg2ZIyO
	KPEkOvp590F13uXpjfd/l59V8mn8B3+zgVxBb+Mfun/C+IJmbh1d3JH5
X-Gm-Gg: ATEYQzyYlSUqyCeJ/6/sEnTtDqNNorj67Bwxh1ejPAbkH1ZggY6vHFCUkiE5CFFtDQt
	uOPp6GeFikVOYvCy7ZwL+3yfwfVY57eZJBtKj893ZMa+I2rR0S+VIrirCWnrbHG5uOKN2OzmRUg
	SS164z96sWQSV0mzGSoYgMn3vuvBFhiBtDiwhl0g2xogPM7MwopbJ9orgXhY5pJrsklXPJJGRre
	1M/zsV9Z17kLtFDVZR08xcUEnQh4RCnnU1yeS8RJYIlhqLRqMQ4bIqIs2IK4yJAMdJ6qguHTQd7
	jb7+aMHnTExnTiXBcYIveNXSrGamEOQ+2WIHkCJkFD4s32lJF0hzhRW458wunkoA+qGZTnAzYPh
	vCCcVd48Xbol3CL67umjxm2MmxR7l9SzzjtkFcWbpQTszK0Bx3D1CZahJcfez1R3CPPhoCT04T9
	9Ereys1SU1UslEqVHTHZUmPzOxt0HDDu9wR6CZ1R6zDdeXQK8Ajxzn5ozlYBoh9I5hj9iyJCveK
	C1wLIL6yw==
X-Received: by 2002:a05:6000:2dc6:b0:43b:6955:54c5 with SMTP id ffacd0b85a97d-43b889a872bmr10137298f8f.17.1774516252624;
        Thu, 26 Mar 2026 02:10:52 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e7111sm6381199f8f.37.2026.03.26.02.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 02:10:52 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Thu, 26 Mar 2026 10:10:23 +0100
Subject: [PATCH 3/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
In-Reply-To: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774516248; l=2643;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=w8YrNU6qSKQOL4v7BNN0lhmGvLNAujqTaPgLpClW6ec=;
 b=ReRyXn03/iqq1g302IExSUUnOqcX1cNBWKYHVKQtahzzDyBiFF6BkyKtE22QoN5DyKq3y5usX
 J/0HdTyjUIpD8Z+P6M2UwfkOgntEopq//CFHuJqKMzSorgPtPPGWSn6
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271943-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:email,exotec.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B1F0332430
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the "Module 3: Equalizer fix for short cables" erratum from
Microchip document DS80000687C for KSZ87xx switches.

The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
where the PHY receiver equalizer may amplify high-amplitude signals
excessively, resulting in internal distortion and link establishment
failures.

Depending on the selected workaround (1 or 2), the driver writes a
specific value to the indirect PHY register
using the 6E/6F/A0 indirect access mechanism.

The errata fix is applied during global switch initialization when
enabled via device tree.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 drivers/net/dsa/microchip/ksz8.c | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 78b42cf50ce2..b6f3a1ce85fc 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1901,6 +1901,41 @@ void ksz8_phylink_mac_link_up(struct phylink_config *config,
 		ksz8_phy_port_link_up(dev, port, duplex, tx_pause, rx_pause);
 }
 
+static int ksz8_handle_module3_errata(struct ksz_device *dev)
+{
+	int ret = 0;
+	const u16 *regs = dev->info->regs;
+	u16 indir_reg = 0x0000;
+	u8 indir_val = 0x00;
+
+	switch (dev->low_loss_wa_mode) {
+	case KSZ_LOW_LOSS_WA_1:
+		indir_reg = 0x3C;
+		indir_val = 0x15;
+		break;
+	case KSZ_LOW_LOSS_WA_2:
+		indir_reg = 0x4C;
+		indir_val = 0x40;
+		break;
+	default:
+		break;
+	}
+
+	mutex_lock(&dev->alu_mutex);
+
+	ret = ksz_write8(dev, regs[REG_IND_CTRL_0], 0xA0);
+
+	if (!ret)
+		ret = ksz_write8(dev, 0x6F, indir_reg);
+
+	if (!ret)
+		ret = ksz_write8(dev, regs[REG_IND_BYTE], indir_val);
+
+	mutex_unlock(&dev->alu_mutex);
+
+	return ret;
+}
+
 static int ksz8_handle_global_errata(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -1915,6 +1950,17 @@ static int ksz8_handle_global_errata(struct dsa_switch *ds)
 	if (dev->info->ksz87xx_eee_link_erratum)
 		ret = ksz8_ind_write8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_HI, 0);
 
+	/* KSZ87xx Errata DS80000687C.
+	 * Module 3: Equalizer fix for short cables
+	 * The receiver of the embedded PHYs is tuned by default
+	 * to support long cable length applications.
+	 * Because of this, the equalizer in the PHY may amplify
+	 * high amplitude receiver signals to the point that
+	 * the signal is distorted internally
+	 */
+	if (!ret && dev->low_loss_wa_enable && ksz_is_ksz87xx(dev))
+		ret = ksz8_handle_module3_errata(dev);
+
 	return ret;
 }
 

-- 
2.53.0


