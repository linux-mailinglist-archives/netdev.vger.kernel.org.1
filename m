Return-Path: <netdev+bounces-271941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CsHM177xGn+5QQAu9opvQ
	(envelope-from <netdev+bounces-271941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:24:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6868833240B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA12316A620
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B363BADA9;
	Thu, 26 Mar 2026 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THZNkVBU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D693B9611
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516253; cv=none; b=clG7kNhce6QmxXQ56cH5aRPyVlcsA0lDBQBuieWVHaKSGyYT18U5mirK4VnMpf0mU82g578OKC1AHPmBtEaIvJCp2lMMhRihFLrzAlaAdJWo+5c2I2ceJKjErL7ozK7mHW4EVbs/RNyklLq4UWFj6D/c7RWVquWV3is4wlImjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516253; c=relaxed/simple;
	bh=c7lQdgxqQoIzJtukGcni61BhLUSZ/QFFuAEFNiGJ1gU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/11GE5KV17Zh8dl/sTIMlQDYARbwTpBxkaeGQ9+qavsMuAcLYgxHxSFjbig68NYAjUGErAcBqDkj+sLRPf28jv6m+g54V4G1J2xfmiG9iaIUf9Nwnms+L6dWKwSbrbuNC0idplHOBq7yC2fxciDs/ApurFQ1OSkuvj+Z54Fcis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THZNkVBU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so6797285e9.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774516250; x=1775121050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lE/tNvEnDqlfntSdOLMR8SVF3nj3f/cbm60tbKz/3QM=;
        b=THZNkVBUXosTQ98f7Dh5Eb3Npy9Wjipjcw0/hEyTIaAzsd+MK/gjp+MW60I9S86K1E
         BNjCZ5RfKhxp9O6oHy5POfc9WgcclG+XTeAe+m3BLqjs100HRzpolFLPh8FSj6YTbBEQ
         NHcRVPOq9BltsKxdZxP+UTWv1dmLRqjm0wRTtvMYLpMTF/iXsFfgC1Buu2yZ4YV38EFE
         15JtqWRSs6xLQa2FSWZXr1Wc4dx0hd1CaC7G7ECc0B5tXNq0LcvCb627ph15vRmwDHmi
         5DwX8U0k0yRp6hRraOO3CE7BpiSdY3brcq9/oMa212uuCtDaIkQuQimfvWoboTrwXSI6
         n1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774516250; x=1775121050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lE/tNvEnDqlfntSdOLMR8SVF3nj3f/cbm60tbKz/3QM=;
        b=TlvO+9NG7AFTgo60ya4MwmAC92aAcN2wtoLPuac3Q3O1MdKpVcgPfAoGt15vjvRPVl
         Gfg85xDMERMcWeZZTcTS0s0oQFTXnF9TuCF1ZfhAqnW2f/1F6YMMjDOZUnFfpDwVoYtY
         4aPcXOkCd/oCGiB1pq34Iyv3xcOl+xMtJSuIW5IMOPHo12VpqCDW3d82u1VhGwcTNvRu
         atxvUT2YTQ5aYlMmQdjInKOoa6q4ZdXYozBgNLEVlwmz8W1wr16iJyeNnre80iUi/xWJ
         LcSr+lLT5/Kr/kTFeiQQGgpHP8nIPY6PBHXvk1p2DuUQxBkg64UjoVxG7DmQwa2i42dZ
         +GDg==
X-Forwarded-Encrypted: i=1; AJvYcCXompchStgbS2lC9AiKb9iXpQpZWkzJgkLiHW/idDJc7vlIcS7Op6q9qU+lNBSlZ6/X32VNXgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6tYgCg/8sgY/rJt5WfakDaV0kr3yHoZB1zf/Xvi3POMCa8nmw
	V11P8EGxZTMdebaWF2UpTnWZ7xMqFnl9g+6MbQIbiwNQGzUQ+J8PTza2
X-Gm-Gg: ATEYQzwHimBYwLru6jXnFyz1Hxp61rf77Vd2cTIMHoRbQJniVNRRUXEZNdc76Pwf1Z3
	xYlB1o4xDgq9CEH4J+3SItg9muiz67j9ygpV3LdBQK2hBp9Cd2aCfYgkBue6Kf2AVjalsLp3vOt
	v2wGwkcpEXmW8IWQ3EBi1JLi+MZwNMlH/K+htrA++rdyB58RI3qtA6Pe00wMeznLSzrRMKZ5vS9
	ioZ+6oRdXBhL+t38csavcXPXyMNA1xveurlleWaDRMUfzwBRhb5XAxJ78jc187M+OA9wwBHiiJL
	vyz+IZ16kgH532V/aOK+5qBjnG+RlmxmHx6yQeM3k+z79abWF1d5ph305tc3QluujE+TJ3YPnwO
	xsdGuGSCYFKMU6ezgdBADxnGhP/CioZtv6zS/0f2c/LcQqoCcDeVdCXbZc8hCoOj4dQSe9vlMa7
	EfXxcmVd6JXlaC0cugtEZzO8yB3fMNeMfrmNKq18eZQi8jnM8yAZEyME35UJ8DoRDTR6TlSyMku
	ucMaGskiw==
X-Received: by 2002:a05:600c:64c6:b0:485:34a2:919e with SMTP id 5b1f17b1804b1-487160a681bmr94261025e9.33.1774516250125;
        Thu, 26 Mar 2026 02:10:50 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e7111sm6381199f8f.37.2026.03.26.02.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 02:10:49 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Thu, 26 Mar 2026 10:10:21 +0100
Subject: [PATCH 1/3] dt-bindings: dsa: microchip: add KSZ low-loss cable
 errata properties
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-ksz87xx_errata_low_loss_connections-v1-1-79a698f43626@exotec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774516248; l=2567;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=c7lQdgxqQoIzJtukGcni61BhLUSZ/QFFuAEFNiGJ1gU=;
 b=gj7AGcTZYGRoM7Sy8eZ6g+SR04PncDwMsa3hX82B5caMFrk8jBIIfC/yGLfiXNoWrTzH/QhTl
 4xqPPoU+hVDCLFug8cRooDd/V7CsmsZBsmKPrftyKqTH8hY5vJ/yU9q
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271941-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:email,exotec.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6868833240B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Microchip KSZ87xx switches are affected by the "Module 3: Equalizer fix
for short cables" erratum described in DS80000687C.
The embedded PHY receivers are tuned for long, high-loss cables,
which may cause signal distortion when operated with short or low-loss
cabling such as CAT5e or CAT6. In these cases,
the PHY may fail to establish a link due to internal over-amplification.

Two workarounds are provided by Microchip, each configuring a different
indirect register value to adjust the PHY equalizer settings.

This patch introduces two new device tree properties to enable and
select the appropriate workaround:

  - microchip,low-loss-errata-enable: boolean enabling the feature
  - microchip,low-loss-errata: selects workaround 1 or 2 (default: 1)

These properties allow board designers to opt into the errata fix
according to the targeted cable characteristics of their platform.

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 8d4a3a9a33fc..ddfbc36aace6 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -85,6 +85,24 @@ properties:
     enum: [2000, 4000, 8000, 12000, 16000, 20000, 24000, 28000]
     default: 8000
 
+  microchip,low-loss-errata-enable:
+    description:
+      The receiver of the embedded PHYs is tuned by default to support long cable length applications. This was developed
+      using low quality, high loss cables. Because of this, the equalizer in the PHY may amplify high amplitude receiver signals
+      to the point that the signal is distorted internally, preventing a link from being established.
+      A more balanced receiver setting has been found that still functions at the long cable lengths and also supports
+      low loss applications.
+      If present, enables the selected errata workaround. If absent, the
+      workaround is disabled regardless of microchip,cat56-errata value.
+    type: boolean
+
+  microchip,low-loss-errata:
+    description:
+      Selects Microchip KSZ87xx CAT5e/CAT6 short-cable errata workaround.
+      1 = Workaround 1, 2 = Workaround 2. If omitted, workaround 1 is applied.
+    enum: [1, 2]
+    default: 1
+
   interrupts:
     maxItems: 1
 

-- 
2.53.0


