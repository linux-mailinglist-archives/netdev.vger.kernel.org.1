Return-Path: <netdev+bounces-307469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8daQJQY4Vmqc1gAAu9opvQ
	(envelope-from <netdev+bounces-307469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:22:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D15EB755076
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:22:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UnnoTHkR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307469-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307469-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 117903127290
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6BD466B6C;
	Tue, 14 Jul 2026 13:11:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6546AEF2
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:11:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034709; cv=none; b=O/2Q0AfhdY/TceS5GoNJ1N/6ZBcZC7FhGVTQ4UXHiQy009DMixB7iMqeRf5i0dyE+uL9MuprLX4K2MwqaB5r1gyg9Sc6w7VwGPBCteMeqb/t0TrgXFAk2f9gNWOutfYxfN95FHPJ1svumZ0g4wZPCekIeQ+lL8NQzsj2YLd7Snc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034709; c=relaxed/simple;
	bh=FE2EPfjvJMithoEW/fui01TCFZWjWkp5M4xCvn7iSYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tvwzZrvexIgJs9HKRl1bqf8DDS22QzByivszVRFO1j/yunoYHQXd6DRxPuXDMBUnq+p8wlqNIW9VXUFKZyOAUyQ9YDThAsnHLYuA7hBTwxf7ixMZRN1s9Hcq2S6jQMwgWDk92FcP93KVDh4OZr9JYPd++MzPMYaIoeJ4vSyWC6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnnoTHkR; arc=none smtp.client-ip=74.125.227.128
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-380f4166f80so534157a91.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 06:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784034707; x=1784639507; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zttJBjTaiSdOL2YoKvs9d14mmFIguoT+2c8c38o/5Ts=;
        b=UnnoTHkRolTSPfQzcYjyGPXLXUW3b1Tl16tnRHj3yNVUsaxYTi6PsXZXDMMKKQJ9ji
         7twX1IH3EN3DaZN6K+4cpNfPURRFskhy0qoo9gtDdOGv/m3kI0eCDxJgwQhsTX1TOG7m
         aitMAmtnoqWp2ckzIglOJEt/gFjT+teXYeI2feS3zPOUf7SYk1WlWbcFDSfTWajlJj5w
         e0d52/2es3DuPlCCQIeXuAH6dK9HTpLv1R3VuuVsXii0pYqZ54CcQjsbWz7DaQWmtO0Q
         Yy6cJ3C5ykGSDvFdoJ/DmzcFRxfDHAZAOk5v/9tZ9UnHHBe4d0frDZYMY4ECqdDvPjL9
         4bMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034707; x=1784639507;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zttJBjTaiSdOL2YoKvs9d14mmFIguoT+2c8c38o/5Ts=;
        b=Gx6s3shg47qqVaANGxv9wcV7W/naqkHHHrIAzyXI7wQh0BPqO8KGesob4bjYWlcrjE
         6XT0bSoosvrWAd9Icazh4wQn4REoUzCUcZ1avyXUETnTDIbHiKBB/4NIG92uOnhVeEC9
         jLAOzxWw9jYEbcMzn42iCZlB5cWbYj7eQ4J0isJViffnlHISkmyz6+tfSHz3a0y6jh/l
         6DCqr1I9yf3YuxQkNMQ1vnnOnVi/EzikIXlDngob2DCnPd7IoHQaCpamLDLa/Qjz40nm
         rLsusinmt9lDMqAKQDnaMBM0ZhivT4dhMhdLNSQ3kweQ6rMtgKypVSc7e85uQ+sPVNbQ
         kqNw==
X-Gm-Message-State: AOJu0YxoEmz4wt966sajkdDJqZYJjGXFC01pxYcjob4JF5l2XlqKWiXO
	tvGpX0XEK34/5Jx2ClZSQhANNVbGHeX81hi3jq6Q9OnNuo50UP0M1tMf
X-Gm-Gg: AfdE7ckRhgFQcsxNu9Uo77nn5H7l3qXK6rlel8xWR065+7Q9W+2Onx1HwXiw82qc6lL
	weOoJs5WDQUofQScOslzRm8oCIxH+2jgDekcPed/mcCj+tKslwxud4y47/pGqPLaRqZwKKvZwGY
	KTrLMRiyYYDYmQWfqJkE+8xJLsLxHENNNP5jdaWNqOdkS21CaDyAvZM9GWGn2iCHVRHSEeOPaco
	2CpStMz2AiXa4hacjrVo4olCtdmP7rXNDivS5NUxEs1F6CVW5vyH1V9Eex8dn5K+UxIhzPnzKUn
	aG1uDHt650PN7hJKoFfz0tDofMOArpJk7p2ZSbLeayorzRS9hwjcu7hBy40OW7gwLHU+63sUxVc
	0jkAgtZacrc2FHy3UjPSaVS40iQhyImStBMOtML4J/RoFJlW8rD2jMySCieH4rAAqEfnnaYwdRr
	AplEzYmGhATPM3dDComzKpZURJNg==
X-Received: by 2002:a05:6a21:7018:b0:3bf:6edd:4dfb with SMTP id adf61e73a8af0-3c110009c5bmr13403343637.5.1784034707016;
        Tue, 14 Jul 2026 06:11:47 -0700 (PDT)
Received: from [192.168.1.100] ([218.194.37.120])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca79aff904dsm8130702a12.6.2026.07.14.06.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:11:46 -0700 (PDT)
From: Yanan He <grumpycat921013@gmail.com>
Date: Tue, 14 Jul 2026 21:11:01 +0800
Subject: [PATCH net-next v3] net: phy: motorcomm: Enable optional clock for
 YT8531
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-motorcomm-yt8531-clk-v3-1-10dc303ef1a5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ7CMAzAvjLlTKRtbYHxFcSBhRQCtEVtQEPT/
 k6Bo2XZMxTOwgV2zQyZX1IkxQpm1QBdjvHMKKfK0Lf9ut10FkPSlCmFgG/dOtMh3W/onB8cGet
 HO0BNH5m9TL/tHiIrRp4UDn9TnuOVSb9XWJYPEMWy0oIAAAA=
X-Change-ID: 20260714-motorcomm-yt8531-clk-55f95c34fb49
To: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yanan He <grumpycat921013@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784034702; l=1923;
 i=grumpycat921013@gmail.com; s=20260618; h=from:subject:message-id;
 bh=FE2EPfjvJMithoEW/fui01TCFZWjWkp5M4xCvn7iSYQ=;
 b=IVJsEwK97AVds/JNM09AlbIgnBy1uZcybVCdtUN1AmQ5AfxMIYmQwMvL8gYqpyO4Y9znekDZt
 zRg6SxEDPvNCe/g1TxEcxc86vwwMg18l1jTwWMh6RAbc5xrljE4V/Dc
X-Developer-Key: i=grumpycat921013@gmail.com; a=ed25519;
 pk=oWrY8KwXIunZWlYBV76NG2A3V4p1bJ+aD45Mr56ErTw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307469-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Sae@motor-comm.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:grumpycat921013@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,motor-comm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D15EB755076

Some boards feed the YT8531 PHY from an SoC-provided external
reference clock described by the common ethernet-phy "clocks" property.

Enable the optional PHY clock during probe so boards can model this
clock as a PHY input instead of keeping the clock alive from the MAC
driver.

This is needed on the Alientek DLRV1126, where the PHY reference clock
is provided by CLK_GMAC_ETHERNET_OUT.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Yanan He <grumpycat921013@gmail.com>
---
v3:
- Split the Motorcomm PHY change out of the Alientek DLRV1126 board
  support series as requested by Andrew.
- Keep the clock modeled as an optional PHY input clock.

v2:
- Model CLK_GMAC_ETHERNET_OUT as a PHY clock instead of keeping it alive
  from dwmac-rk.
---
 drivers/net/phy/motorcomm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 5071605a1a11..3396a38cfc0f 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -6,6 +6,7 @@
  * Author: Frank <Frank.Sae@motor-comm.com>
  */
 
+#include <linux/clk.h>
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -1180,9 +1181,15 @@ static int yt8521_probe(struct phy_device *phydev)
 static int yt8531_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
+	struct clk *clk;
 	u16 mask, val;
 	u32 freq;
 
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to get and enable PHY clock\n");
+
 	if (device_property_read_u32(dev, "motorcomm,clk-out-frequency-hz", &freq))
 		freq = YTPHY_DTS_OUTPUT_CLK_DIS;
 

---
base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
change-id: 20260714-motorcomm-yt8531-clk-55f95c34fb49

Best regards,
--  
Yanan He <grumpycat921013@gmail.com>


