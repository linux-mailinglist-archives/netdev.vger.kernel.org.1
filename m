Return-Path: <netdev+bounces-61215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0C7822E3E
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAE81F23C65
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4727D199DE;
	Wed,  3 Jan 2024 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kmfhbBwF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80311199D2
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40b5155e154so136021685e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 05:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704288522; x=1704893322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dap6YP8FIQk3TOWEEJscoCpH52lrE/wFjU07rsqJTV8=;
        b=kmfhbBwF2rGem22D2FogfSrK4J7aGn3VDDTurJH1baEKdeoZgz83ZLKvX9ctgEUOh6
         NHronNvVbx1mpjVam0LdTs5JhQ7fhSAkXHhWR7XrziqK2j7qCZDsVdcr83kJsvrkuXbT
         SWWXY7DGHmX8iSvtSt1rnMWx0ij8rkDDVLbRNi1EWGGr28WX0eOWZYmaHG5RVkmI3Mxr
         GqoeRidKUTgO2S5uSy6Bb04+hLCUnFCnT3f2Ee+fetI/9lbmpKSVcCsdolmTyz1wt9cR
         tLpZT9DDC4q+zo8De/E8aWDrlwgmdLeMDJSrXn07tJtYLJKS/Bud3wHsfMHCtCAjmuVt
         47dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704288522; x=1704893322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dap6YP8FIQk3TOWEEJscoCpH52lrE/wFjU07rsqJTV8=;
        b=pYmNQk1Gvkw6z1B+Ej0gapvP0wAPQWnQ+qNtaRjox9D0km3OVB4Lu1o2KvxpKCOrNN
         8Bat0aXUF3pXQ0EYEH+BgdwrY5kJm8hGi1EtTEVfJFtPMPGfPtxjD+y/Y/wgwXEwiX7A
         1QS+GIN7AC+ODMLHptsvTnTVenbCy1FqShKusD1UF872yvT1+GxFm1ENQwMhpSnxpyrr
         IxYrj2mte6YJS3yeUIi/jgFMYj6eCbOUbeG5shbjlCgc4d49ecx+/l8mX3UayOsKctI6
         4eTTiHhf0BO02MDSl6oH9ezdmc8vt+V/GtortbcMKZI1Sy9Tlq7Z1Lw7H1Yc63f+wJrt
         PacQ==
X-Gm-Message-State: AOJu0YwKw7Hz0aHkLE2wrIPDKAcgR4TUUJhmG54CPRE4mlwutPDaHCmM
	IDmc5bMRztpG1xW20XcYUoNs5jIqzKMqelKF1dtJIyDy0rYL+w==
X-Google-Smtp-Source: AGHT+IHQBL/+29hcXddFkBV5iJ6OFr0SYO/Zw8sjNVTx3MM6TSJHQg/LyRThMXNcbd8aMe3+3rlPBA==
X-Received: by 2002:a7b:c5cc:0:b0:40d:8fcd:319f with SMTP id n12-20020a7bc5cc000000b0040d8fcd319fmr574309wmk.218.1704288521635;
        Wed, 03 Jan 2024 05:28:41 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040d5118e42esm2310279wmq.22.2024.01.03.05.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:28:41 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	michal.michalik@intel.com,
	rrameshbabu@nvidia.com
Subject: [patch net-next 1/3] dpll: expose fractional frequency offset value to user
Date: Wed,  3 Jan 2024 14:28:36 +0100
Message-ID: <20240103132838.1501801-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103132838.1501801-1-jiri@resnulli.us>
References: <20240103132838.1501801-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Add a new netlink attribute to expose fractional frequency offset value
for a pin. Add an op to get the value from the driver.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/dpll.yaml | 11 +++++++++++
 drivers/dpll/dpll_netlink.c           | 24 ++++++++++++++++++++++++
 include/linux/dpll.h                  |  3 +++
 include/uapi/linux/dpll.h             |  1 +
 4 files changed, 39 insertions(+)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index cf8abe1c0550..b14aed18065f 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -296,6 +296,16 @@ attribute-sets:
       -
         name: phase-offset
         type: s64
+      -
+        name: fractional-frequency-offset
+        type: sint
+        doc: |
+          The FFO (Fractional Frequency Offset) between the RX and TX
+          symbol rate on the media associated with the pin:
+          (rx_frequency-tx_frequency)/rx_frequency
+          Value is in PPM (parts per million).
+          This may be implemented for example for pin of type
+          PIN_TYPE_SYNCE_ETH_PORT.
   -
     name: pin-parent-device
     subset-of: pin
@@ -460,6 +470,7 @@ operations:
             - phase-adjust-min
             - phase-adjust-max
             - phase-adjust
+            - fractional-frequency-offset
 
       dump:
         pre: dpll-lock-dumpit
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 21c627e9401a..3370dbddb86b 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -263,6 +263,27 @@ dpll_msg_add_phase_offset(struct sk_buff *msg, struct dpll_pin *pin,
 	return 0;
 }
 
+static int dpll_msg_add_ffo(struct sk_buff *msg, struct dpll_pin *pin,
+			    struct dpll_pin_ref *ref,
+			    struct netlink_ext_ack *extack)
+{
+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
+	struct dpll_device *dpll = ref->dpll;
+	s64 ffo;
+	int ret;
+
+	if (!ops->ffo_get)
+		return 0;
+	ret = ops->ffo_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
+			   dpll, dpll_priv(dpll), &ffo, extack);
+	if (ret) {
+		if (ret == -ENODATA)
+			return 0;
+		return ret;
+	}
+	return nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET, ffo);
+}
+
 static int
 dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
 		      struct dpll_pin_ref *ref, struct netlink_ext_ack *extack)
@@ -440,6 +461,9 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 			prop->phase_range.max))
 		return -EMSGSIZE;
 	ret = dpll_msg_add_pin_phase_adjust(msg, pin, ref, extack);
+	if (ret)
+		return ret;
+	ret = dpll_msg_add_ffo(msg, pin, ref, extack);
 	if (ret)
 		return ret;
 	if (xa_empty(&pin->parent_refs))
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index b1a5f9ca8ee5..9cf896ea1d41 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -77,6 +77,9 @@ struct dpll_pin_ops {
 				const struct dpll_device *dpll, void *dpll_priv,
 				const s32 phase_adjust,
 				struct netlink_ext_ack *extack);
+	int (*ffo_get)(const struct dpll_pin *pin, void *pin_priv,
+		       const struct dpll_device *dpll, void *dpll_priv,
+		       s64 *ffo, struct netlink_ext_ack *extack);
 };
 
 struct dpll_pin_frequency {
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index 715a491d2727..b4e947f9bfbc 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -179,6 +179,7 @@ enum dpll_a_pin {
 	DPLL_A_PIN_PHASE_ADJUST_MAX,
 	DPLL_A_PIN_PHASE_ADJUST,
 	DPLL_A_PIN_PHASE_OFFSET,
+	DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
 
 	__DPLL_A_PIN_MAX,
 	DPLL_A_PIN_MAX = (__DPLL_A_PIN_MAX - 1)
-- 
2.43.0


