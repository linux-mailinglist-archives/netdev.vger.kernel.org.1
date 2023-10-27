Return-Path: <netdev+bounces-44847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F8D7DA1B6
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D1D1C21069
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02943E01A;
	Fri, 27 Oct 2023 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9+pruVO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD213DFE0
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 20:21:44 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168FF1B1
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 13:21:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5082a874098so1397888e87.3
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698438101; x=1699042901; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2aSxynAJWD4w6QHvLKwVWJJOGC7WprRqk+AbZ7X+LM=;
        b=H9+pruVOxJQDYQWtfYdTgN9im65ZC/k2Aej8bvWnA8mneXDCan37cuh/6U7HJUwX/U
         KJq9+NygGgSqeVtkDo/mweJ2/0lWzlM5wfaj7Cmv0GbmNi7D/P21RPTywUAPjAF7zva/
         qvSM+tWLU9KFaPX2/SgPk949/hr7dagG7Lc9imwkcDbS4HubCS+STWqI/lHYc9KPBCqW
         GUNJBFFJnFSNfzyBk/TGFLpar3eT/nZgFPiWbl4e8B5OFEAJ8zippCG4h5HcvUFvh0iK
         melPNEZmNNxgKEcGeoUhMRCeCnLm3CcbOZgLPoaWz09XyTj7bt3WihWCZJ9luNtHMwoy
         sFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698438101; x=1699042901;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2aSxynAJWD4w6QHvLKwVWJJOGC7WprRqk+AbZ7X+LM=;
        b=psp06B+0TD9vfQHvl+IAAD+aSR6RxKWMfwGmphwXV4hF9QZFYuboKgEb4Nv1gNvzDl
         pTRvelJ0PcpTu1iFNb7zvCSIoICkBzVLTlNlHz63TNMB5TwzwLe86MEbKXJ6tqY5qxom
         GnPGigeLEWCRsV1ADx3nkY3V4EBGlKqI1SqjbzDYD6C/gUgWcuOWF6tH7oQcIdHvG5+H
         z7xNedFyfpzvZvTNqHDb8EHehsqUybXhf2AJOdP4HYAyJBxJdt0tkGPb+KzdrCQP1452
         v45capDqYoXXBTJBcqoNrLsyZrHEuwaS209q8dlAG56eEI1850eoadbKE0y6UcthdUNQ
         tLFA==
X-Gm-Message-State: AOJu0YwubVyVflz1fe4OrGUmEQSRlbC3MGU1cPPYCSzgFNwiz/ZE5ajP
	3ol8Gb0m/SJfSQbXXh0jXApmYA==
X-Google-Smtp-Source: AGHT+IEa/QcaZvljgbdGu/K4ciK9D0FHLRgitkOzAfJ7CDtPubJGROFgHjxG4bfoHfSJ70jYLFcylg==
X-Received: by 2002:ac2:4850:0:b0:507:a1e0:22f4 with SMTP id 16-20020ac24850000000b00507a1e022f4mr2496829lfy.29.1698438100941;
        Fri, 27 Oct 2023 13:21:40 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id r3-20020ac25a43000000b00507a3b0eb34sm388178lfn.264.2023.10.27.13.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 13:21:40 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Oct 2023 22:21:39 +0200
Subject: [PATCH] dsa: tag_rtl4_a: Bump min packet size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
X-B4-Tracking: v=1; b=H4sIANIbPGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyNz3bTMCt2ikhwLYzOzoiTdVHNTo6QUU0sDw+REJaCegqJUoAKwedG
 xtbUATWVsMF8AAAA=
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

It turns out that sometimes, but not always, small packets are
dropped by the switch for no reason.

If we pad the ethernet frames to a minimum of ETH_FRAME_LEN + FCS
(1518 bytes) everything starts working fine.

As we completely lack datasheet or any insight into how this
switch works, this trial-and-error solution is the best we
can do.

I have tested smaller sizes, ETH_FRAME_LEN doesn't work for
example.

Fixes: 0e90dfa7a8d8 ("net: dsa: tag_rtl4_a: Fix egress tags")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 net/dsa/tag_rtl4_a.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_rtl4_a.c b/net/dsa/tag_rtl4_a.c
index c327314b95e3..8b1e81a6377b 100644
--- a/net/dsa/tag_rtl4_a.c
+++ b/net/dsa/tag_rtl4_a.c
@@ -41,8 +41,11 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
 	u8 *tag;
 	u16 out;
 
-	/* Pad out to at least 60 bytes */
-	if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
+	/* We need to pad out to at least ETH_FRAME_LEN + FCS bytes. This was
+	 * found by trial-and-error. Sometimes smaller frames work, but sadly
+	 * not always.
+	 */
+	if (unlikely(__skb_put_padto(skb, ETH_FRAME_LEN + ETH_FCS_LEN, false)))
 		return NULL;
 
 	netdev_dbg(dev, "add realtek tag to package to port %d\n",

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231027-fix-rtl8366rb-e752bd5901ca

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


