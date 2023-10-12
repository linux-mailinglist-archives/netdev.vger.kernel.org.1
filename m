Return-Path: <netdev+bounces-40516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3FE7C7974
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 00:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5071C2103C
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 22:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D563405C3;
	Thu, 12 Oct 2023 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z0hOqJQA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4BF405C2
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 22:27:55 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41DAC9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 15:27:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a483bdce7so2149940276.2
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697149673; x=1697754473; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rZYpAvmIgIMiNPsdg/lY35j3EeR/rUqwRQrzCZkd3d0=;
        b=z0hOqJQAGcLilxNgiHT9cMELbFMFkG17er1m8n/oQ8MsVcVffzAje5T4EpZKz8d+cv
         vsx3Qb6bz2QKuV0JWv5QDQ174OzMuXM+6vZDhBAwc7Sf5RxtZmokXG3qA8uEBdNC6Nv2
         w3KUTbjj156Hck9EMxBGBM1JnDXKNuAJ4cUrvz8Js73DKWPkH4mQTxdwAGK9nfPblTv+
         RM7L0tOanYbNO7+drkC2XzL2V+MsOL0dURSX3Uy9hmr+v9Y1AzjqJxbTV4Yvwedjcz+a
         /hvVT+9/Qmsyrom9EzDM3gFhwfo9D04cFR0VgtWYHQzNiRp9xApV0n8NUEHAQmD/dZUq
         DI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149673; x=1697754473;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZYpAvmIgIMiNPsdg/lY35j3EeR/rUqwRQrzCZkd3d0=;
        b=wuAoTUcWjWtDrXU1MZhf/A/VQuMs1Vk1QtXsiRa/AuH1RL2fgqDNQvQychYCdnBv4q
         1FH4YhqjtLjv/5h6o50OfB0hXx4RQLmG591pL24G6JdnLTka2MdB2BlthqYlGiVUhIj8
         3R5tXejnxG50Xbk2wZg23b6BPtkeG4L/krRHex7i3qepX+Lt8MwJyB4dgeEvm7aeQ9B+
         w9c1KPLlnGVpxwMN2yEnILTcopd+I5Gd3naMxrrFTvkq7PMxEZZxrD7K4QdHuPq5GZYA
         OSgwaTL16NdVAlp7DEYSI2ghF2QUOjVOzTE2U6JhH9HFYFhHkN2sWpe66OLItbQ7dX4V
         cD/g==
X-Gm-Message-State: AOJu0Yyh8UaaDe9EBeCR9pHMawFm339hAkJwEPy4kreklqjN9iH7PTYa
	nj+bl6TtVmgDY/vOjK9nPdCM7EUtH7zzMlOndg==
X-Google-Smtp-Source: AGHT+IGvsAhFHjxwUVFZUgMRL3+/P7L3Q3QaP/2sCXzGdan8GAMGU0q90XgVFJVBfLiIRlvUoZwcR9p9tY0tNTEHNw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:8a0d:0:b0:d81:582b:4661 with SMTP
 id g13-20020a258a0d000000b00d81582b4661mr526282ybl.8.1697149673145; Thu, 12
 Oct 2023 15:27:53 -0700 (PDT)
Date: Thu, 12 Oct 2023 22:27:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOdyKGUC/x3NMQqAMAxA0atIZgO2IopXEQdtU81gLYmIIt7d4
 viW/x9QEiaFvnhA6GTlPWaYsgC3TnEhZJ8NtrK1qYxFPSS6dKMXPkkUIx2Y1ht1U4cO28aH0LX zNDc15EgSCnz9g2F83w8DaSpFcAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697149672; l=1565;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=5QhySr/Q36zDeZ98j7zPXD0GUeZwX1jIeAwMYdxCyJY=; b=KrpFlNS4TYnLFKZYhQfQ//GmLAMKDMsDyCpew83lBGhmjSjQwft46M0mgguiqwpB6z88nBcuU
 Ds7ihe1nXe0DZ4uk2R64dfZCwG7NdZ7DIULPlIejpSdriFk3YldG2FT
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-phy-smsc-c-v1-1-00528f7524b3@google.com>
Subject: [PATCH] net: phy: smsc: replace deprecated strncpy with ethtool_sprintf
From: Justin Stitt <justinstitt@google.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

ethtool_sprintf() is designed specifically for get_strings() usage.
Let's replace strncpy in favor of this dedicated helper function.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/phy/smsc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index c88edb19d2e7..1c7306a1af13 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -507,10 +507,8 @@ static void smsc_get_strings(struct phy_device *phydev, u8 *data)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(smsc_hw_stats); i++) {
-		strncpy(data + i * ETH_GSTRING_LEN,
-		       smsc_hw_stats[i].string, ETH_GSTRING_LEN);
-	}
+	for (i = 0; i < ARRAY_SIZE(smsc_hw_stats); i++)
+		ethtool_sprintf(&data, "%s", smsc_hw_stats[i].string);
 }
 
 static u64 smsc_get_stat(struct phy_device *phydev, int i)

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-phy-smsc-c-75dff87bab53

Best regards,
--
Justin Stitt <justinstitt@google.com>


