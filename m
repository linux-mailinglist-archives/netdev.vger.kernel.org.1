Return-Path: <netdev+bounces-39268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C6D7BE943
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB4A1C20A17
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBF93AC31;
	Mon,  9 Oct 2023 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4MWOpEQa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C1A38DE9
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 18:29:21 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ADAA3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 11:29:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d85fc108f0eso6476838276.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876160; x=1697480960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XDBK5Er15QvjGUwykMjw01laGvht+dhKObLHHzorKRg=;
        b=4MWOpEQarFiFDsKFVaQ3aoc0aWArpmmCr7Ejvi4R/zOtf5bc8UbGT44Rrg0MGMt3Oz
         hyIVziMJ0YlKpmUSit0Pyf/82m/G8SER7+pvfPLFs7u23uW4ENwws2JaUtFHvWihoUtR
         GCh0MZSyIlnxKstdd1EUdkYUV9wkB2UZSWZ0P+EvekUJspb9SpD0emiBSYa1oINLj1t5
         vEZMkasLTdNMBgkjyWVfE0og4PRW+zTmWuqSu2pdi3yn/9WIVc3zo0KHZ8i/nnGyUBu+
         OxHrqFra5yltxWydL1Lhc5Zt+evYp6nNniS3gWKvbS0QltS5Xdr33rifFmUXRyWLVQJg
         tOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876160; x=1697480960;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XDBK5Er15QvjGUwykMjw01laGvht+dhKObLHHzorKRg=;
        b=w1HAJe8vX0+o6bAv2Ep/77gKy5CDeAZqm2KM3A0daMfZcGj+s3R4yK7MgQ6AlVTVEk
         xJ/KS28Bk+d5tUrLdW6HwxLkwj9NXEOsxL+Nxm0HpL3wdIuDVTSel20PFrS3AE3B3uY3
         gwgEfqlXaDXkajHTjZLzVZq7QxNwWoDrD8pClvPru2Ie5xzQUpZk0hv8C4LPLvci1aZE
         6Eq7hxjHy/PCOZI1nWqNezIsgMO09bGXlVZ1bb+vTYE6XNdnvPWpywqZfbOJu9ZIqYzm
         kSfrxKYmiPJkpHNreY2J4HBPRGXLJ7fbeVjXOu1nHmMooZ/gWQpII8sIjN8RW9lIcbgY
         MH6w==
X-Gm-Message-State: AOJu0Yxtc2q0ltLx9LAnL/vml1NnS+smJop0x8MCL7t0GuC0tUqRGPFg
	GhRxcTlxWgjGxrnC7mLjlZM+FCuvPpXwIr1RLA==
X-Google-Smtp-Source: AGHT+IFEYT/za4QVR6fR/MF5JyjgO5M3AWWvhyO5pPz0UrgbgMOrmr3zJveczQ1Hka+kDj8XsImbs1hJdUTnEIDEMA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ad50:0:b0:d78:2c3:e633 with SMTP
 id l16-20020a25ad50000000b00d7802c3e633mr230976ybe.2.1696876159847; Mon, 09
 Oct 2023 11:29:19 -0700 (PDT)
Date: Mon, 09 Oct 2023 18:29:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAH5GJGUC/x3NPQ6DMAxA4asgz7VkCNCfq6AOUexSD02RHSEQ4
 u6NOn7Lewe4mIrDoznAZFXXb65oLw2kd8yzoHI1dNSFluiOXiynZUc2XcUcsxRkj/gp1yEQJuw pRQ63MA49Q80sJi/d/ovpeZ4/gDTkfnIAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696876158; l=1437;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=njDv3GAGmhVrExshk0hx5o9AbY/WD0+6gqoo2bn4Yhg=; b=1J2L7iU0ES7zC7vWFtN9NFGtdF0F81pv/JVQhRo8NZAZIpsJ+gGWhuCDrgOKhESE8tZUUsU3U
 d4Z2vnQKmFuD4VoXPdHgoaiP7YfJE2TD1dTaO5uvm7QNv0tFHL7+jAu
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-dsa-mt7530-c-v1-1-ec6677a6436a@google.com>
Subject: [PATCH] net: dsa: mt7530: replace deprecated strncpy with ethtool_sprintf
From: Justin Stitt <justinstitt@google.com>
To: "=?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?=" <arinc.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, 
	Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

ethtool_sprintf() is designed specifically for get_strings() usage.
Let's replace strncpy in favor of this more robust and easier to
understand interface.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/dsa/mt7530.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 035a34b50f31..e00126af8318 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -836,8 +836,7 @@ mt7530_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(mt7530_mib); i++)
-		strncpy(data + i * ETH_GSTRING_LEN, mt7530_mib[i].name,
-			ETH_GSTRING_LEN);
+		ethtool_sprintf(&data, "%s", mt7530_mib[i].name);
 }
 
 static void

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-dsa-mt7530-c-40cad383654d

Best regards,
--
Justin Stitt <justinstitt@google.com>


