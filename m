Return-Path: <netdev+bounces-45492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DF57DD891
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 23:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74560B20DFC
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 22:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802F3273C2;
	Tue, 31 Oct 2023 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVCeTWTZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADB820333
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 22:45:39 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EEEF3
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 15:45:38 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so88629091fa.1
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698792336; x=1699397136; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Soi9bdc5kWd4li1fMLa0FWIu2YUGtC28KzHNxVYSHqk=;
        b=cVCeTWTZnL7SHP+D16KUxvBKzD/KZJD9KnuOWSuaDwiBKUsT+wf68AoVKQbwTcrSvB
         qTpA3oHjDvpIKMWWH5q6YeEDo1v1yXofETLkAqewYETzqwLUJgjN9BUVSiBzhsG6Yq03
         d2tf2dAb+MkvfAxAbj4uv3AqEsJM+0dKj0l5yyXyh9yaWhZoFMESxn0w4WAnBsehSfA4
         ahAqjJ5DSxQWo8SvkcWFtat6gkDrtVXQEcp5Bnf2HbeSGKQxed46p2Gc4B8Vvzyq3hBV
         kIjB7mMR7jmUCKL+WEU5LHBVYnJr7PtJfBQm5I+7Ox9SHk0caMT4kIWs61LYUI+oKqI3
         sfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698792336; x=1699397136;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Soi9bdc5kWd4li1fMLa0FWIu2YUGtC28KzHNxVYSHqk=;
        b=i6tH2AMnJCLqT5IXTfg6P36ZQLpAAYvN9t6g6yCZ5WXf48H/muPeCqzUT3tDi3iGpa
         P5nKkBKOQ6Y2JdNtsLs415qYCnr94WSvg7zrPX8GO5Ib2WroLnahQFm5ozmllwy5QZQ9
         gUJw0+C9dTAegyg4dpqhi8vHsWrOFm8zWveq273mNy56/rmQIok8/WECMinXFkRH793Z
         71WyoCP/QY/rWCBd1eWmCmFh1Sx3bLsC/0gx9IxErhleR/bFPb5r7cQmpjX5TDk6VHrS
         kgoa/5rvS3nrztw5KNdYsIHU7v0A6QV7BiMqtb3JhXRLpbRwhj23lBKKlvMID7bEy1CR
         vZcA==
X-Gm-Message-State: AOJu0Yzk3gRW8D6zb65P5MOjb5+8xIzzP0acZynFSWLCub1LIkQtNuTU
	13pmHRIMBw+6fyrx2JHua57ZiQ==
X-Google-Smtp-Source: AGHT+IGPznEGLGzU6iFpaDcchCiVWqFLM9xyWUYU6KiMgcFlh2YdEeuJahDu+93Y44rEpZxbOtgknw==
X-Received: by 2002:a05:6512:3c91:b0:507:a04c:76e8 with SMTP id h17-20020a0565123c9100b00507a04c76e8mr13028194lfv.46.1698792336166;
        Tue, 31 Oct 2023 15:45:36 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id i12-20020a0565123e0c00b004fb7848bacbsm39613lfv.46.2023.10.31.15.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 15:45:35 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 31 Oct 2023 23:45:33 +0100
Subject: [PATCH net v3] net: dsa: tag_rtl4_a: Bump min packet size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231031-fix-rtl8366rb-v3-1-04dfc4e7d90e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIyDQWUC/3WNywrCMBBFf6XM2kgeJLWu+h/iIm2mbaAkMilBK
 f13Q1YquLxz55y7Q0LymODa7ECYffIxlKBODYyLDTMy70oGyaUSXLZs8k9G23pRxtDAsNVycLr
 jYrRQmAdheai+GwTc4F6Oi09bpFfdyKJWf3RZMMGcNtp1XGulbb/6YCmeI81VleUHrvgvLguOx
 qDAqXWDk1/4cRxvLXtRgO8AAAA=
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

It was reported that the "LuCI" web UI was not working properly
with a device using the RTL8366RB switch. Disabling the egress
port tagging code made the switch work again, but this is not
a good solution as we want to be able to direct traffic to a
certain port.

It turns out that packets between 1496 and 1500 bytes are
dropped unless 4 extra blank bytes are added to the tail.

1496 is the size of a normal data frame minus the internal DSA
tag. The number is intuitive, the explanation evades me.
This is not a tail tag since frames below 1496 bytes does
not need the extra bytes.

As we completely lack datasheet or any insight into how this
switch works, this trial-and-error solution is the best we
can do. FWIW this bug may very well be the reason why Realteks
code drops are not using CPU tagging. The vendor routers using
this switch are all hardwired to disable CPU tagging and all
packets are pushed to all ports on TX. This is also the case
in the old OpenWrt driver, derived from the vendor code drops.

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
Changes in v3:
- Do not pad out to 1518 bytes, just add 4 bytes to the
  tail consistently when the package is bigger than 1496
  bytes. Use a combination of __skb_pad() and __skb_put().
  This works fine.
- Add tail in the first if-clause and pad to 60 bytes
  in the else-clause since they are mutually exclusive.
- Edit comments and commit text.
- Link to v2: https://lore.kernel.org/r/20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org

Changes in v2:
- Pad packages >= 1496 bytes after some further tests
- Use more to-the-point description
- Provide ping results in the commit message
- Link to v1: https://lore.kernel.org/r/20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org
---
 net/dsa/tag_rtl4_a.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/dsa/tag_rtl4_a.c b/net/dsa/tag_rtl4_a.c
index c327314b95e3..9c7f8a89cb82 100644
--- a/net/dsa/tag_rtl4_a.c
+++ b/net/dsa/tag_rtl4_a.c
@@ -41,9 +41,21 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
 	u8 *tag;
 	u16 out;
 
-	/* Pad out to at least 60 bytes */
-	if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
-		return NULL;
+	/* Packets over 1496 bytes get dropped unless 4 bytes are added
+	 * on the tail. 1496 is ETH_DATA_LEN - tag which is hardly
+	 * a coinicidence, and the 4 bytes correspond to the tag length
+	 * and this is hardly a coinicidence so we use these defines
+	 * here.
+	 */
+	if (skb->len >= (ETH_DATA_LEN - RTL4_A_HDR_LEN)) {
+		if (unlikely(__skb_pad(skb, RTL4_A_HDR_LEN, false)))
+			return NULL;
+		__skb_put(skb, RTL4_A_HDR_LEN);
+	} else {
+		/* Pad out to at least 60 bytes */
+		if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
+			return NULL;
+	}
 
 	netdev_dbg(dev, "add realtek tag to package to port %d\n",
 		   dp->index);

---
base-commit: d9e164e4199bc465b3540d5fe3ffc8a9a4fc6157
change-id: 20231027-fix-rtl8366rb-e752bd5901ca

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


