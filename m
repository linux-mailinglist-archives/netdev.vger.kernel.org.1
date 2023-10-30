Return-Path: <netdev+bounces-45198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9747DB61E
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 10:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F74F28138E
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 09:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A75D52E;
	Mon, 30 Oct 2023 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oamF0bF3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF123FDF
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 09:26:57 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55E6C4
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 02:26:55 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c6b30acacdso22136591fa.2
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 02:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698658014; x=1699262814; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/S93wdJSw/AzX9CKKdyBARwqyDwptUmDMX/QD6LKCe4=;
        b=oamF0bF34fDhS6xoumno2H3pWQk139BtFvEQ2etV86T6zSNi6o/xnv/azmQ4cHdngG
         4CePOABtIWfKhWgcAufIU5VjJnJVP+PxokTYq83bcYQqoFMgqLc+zjqrXu+ApCRWfVue
         qY5X090L0cSgIVJAYD6Yfk6/jh+5lmI4bhLW0R4Nz5U2/LSbbi2zX2ltvqwe3BZ/g6xM
         CF4dKIgFM1vBryybR4G9+XMe0GpRMBTrXapJzJVBdFO50hzLpX+NlA/xms2lsQU/QRMM
         FHViMpz5sCPiRV+q+bst2MiVxi7a60uSsBlGFhtztH2mfWoKRyztLuoWEktumq5IxDax
         pr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698658014; x=1699262814;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/S93wdJSw/AzX9CKKdyBARwqyDwptUmDMX/QD6LKCe4=;
        b=OsWNf254r+KMFDL0vznb5Iayp+HMHhPsG0wr/JvIedSW+tDfbt4meH4PriAbphMTeE
         oAzKK1mvYLXe7ghxGr/8euRgRrnifzWq+ZZ3lhJtXPXb0MLxnUhEw8N/vRbXtG+RjXEO
         uSvRon9qSLXuXxmUwKHTScsRJWoMTus/8sXZ+rb2K1ssOEooLWmec6UcVIzB4+4/cZqI
         5t9gDd/9/hOm3wdm7S0SmZF9pKwyK3ACLleadFfWwarFyqgmMKAocZbkCIHbAoGgzbvG
         YKWaL1p+ooj3MUQyN6erL61Wcr/YEZo8/G2oor/h5Aa7qE1jvPWP2PpTztCBsFb5dCHB
         Nq3Q==
X-Gm-Message-State: AOJu0Yzn9I2iKMCle5EN+7Xl/4BflgH/WV24aDPib8/6HvBmiDSgp9hr
	GML/M0trTUPyrkptIYhso6OFJQ==
X-Google-Smtp-Source: AGHT+IGlv3iUmWJJlYqW6cgPWqiSNT9vmjTv/sx/ZTNAqrBO65xw+S7UzqB3dpvnBxvLgrpZtCLRQA==
X-Received: by 2002:ac2:5e24:0:b0:504:7e90:e05b with SMTP id o4-20020ac25e24000000b005047e90e05bmr6081095lfg.14.1698658013974;
        Mon, 30 Oct 2023 02:26:53 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d34-20020a0565123d2200b0050915816a16sm811912lfv.145.2023.10.30.02.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:26:53 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Oct 2023 10:26:50 +0100
Subject: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
X-B4-Tracking: v=1; b=H4sIANl2P2UC/3WNTQqDMBCFryKzbkoSmVi76j2Ki2imOiBJmYi0S
 O7e4L7L9/e9AzIJU4Z7c4DQzplTrMJeGpgWH2dSHKoGq21rtO3Uiz9KtvXWOiejog7tGLDXZvJ
 QN2+hWjh5T4i0wVDNhfOW5Ht+7OaM/uB2o4wK6DD0GrFF/1g5eknXJDMMpZQf+nuJXbAAAAA=
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

It was reported that the "LuCI" web UI was not working properly
with a device using the RTL8366RB switch. Disabling the egress
port tagging code made the switch work again, but this is not
a good solution as we want to be able to direct traffic to a
certain port.

It turns out that packets between 1496 and 1500 bytes are
dropped unless padded out to 1518 bytes.

If we pad the ethernet frames to a minimum of ETH_FRAME_LEN + FCS
(1518 bytes) everything starts working fine.

1496 is the size of a normal data frame minus the internal DSA
tag. The number is intuitive, the explanation evades me.

As we completely lack datasheet or any insight into how this
switch works, this trial-and-error solution is the best we
can do. FWIW this bug may very well be the reason why Realteks
code drops are not using CPU tagging. The vendor routers using
this switch are all hardwired to disable CPU tagging and all
packets are pushed to all ports on TX. This is also the case
in the old OpenWrt driver, derived from the vendor code drops.

I have tested smaller sizes, only 1518 or bigger padding works.

Modifying the MTU on the switch (one setting affecting all
ports) has no effect.

Before this patch:

PING 192.168.1.1 (192.168.1.1) 1470(1498) bytes of data.
^C
--- 192.168.1.1 ping statistics ---
2 packets transmitted, 0 received, 100% packet loss, time 1048ms

PING 192.168.1.1 (192.168.1.1) 1472(1500) bytes of data.
^C
--- 192.168.1.1 ping statistics ---
12 packets transmitted, 0 received, 100% packet loss, time 11267ms

After this patch:

PING 192.168.1.1 (192.168.1.1) 1470(1498) bytes of data.
1478 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.533 ms
1478 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=0.630 ms

PING 192.168.1.1 (192.168.1.1) 1472(1500) bytes of data.
1480 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.527 ms
1480 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=0.562 ms

Also LuCI starts working with the 1500 bytes frames it produces
from the HTTP server.

Fixes: 9eb8bc593a5e ("net: dsa: tag_rtl4_a: fix egress tags")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Pad packages >= 1496 bytes after some further tests
- Use more to-the-point description
- Provide ping results in the commit message
- Link to v1: https://lore.kernel.org/r/20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org
---
 net/dsa/tag_rtl4_a.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/dsa/tag_rtl4_a.c b/net/dsa/tag_rtl4_a.c
index c327314b95e3..3292bc49b158 100644
--- a/net/dsa/tag_rtl4_a.c
+++ b/net/dsa/tag_rtl4_a.c
@@ -45,6 +45,16 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
 	if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
 		return NULL;
 
+	/* Packets over 1496 bytes get dropped unless they get padded
+	 * out to 1518 bytes. 1496 is ETH_DATA_LEN - tag which is hardly
+	 * a coinicidence, and 1518 is ETH_FRAME_LEN + FCS so we define
+	 * the threshold size and padding like this.
+	 */
+	if (skb->len >= (ETH_DATA_LEN - RTL4_A_HDR_LEN)) {
+		if (unlikely(__skb_put_padto(skb, ETH_FRAME_LEN + ETH_FCS_LEN, false)))
+			return NULL;
+	}
+
 	netdev_dbg(dev, "add realtek tag to package to port %d\n",
 		   dp->index);
 	skb_push(skb, RTL4_A_HDR_LEN);

---
base-commit: d9e164e4199bc465b3540d5fe3ffc8a9a4fc6157
change-id: 20231027-fix-rtl8366rb-e752bd5901ca

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


