Return-Path: <netdev+bounces-40514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F58C7C7967
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 00:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365991C20A56
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 22:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719903FB30;
	Thu, 12 Oct 2023 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPCU1tNM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3F3B28A
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 22:21:50 +0000 (UTC)
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF81B8
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 15:21:48 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id 46e09a7af769-6c638c29c8eso2089422a34.1
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 15:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697149308; x=1697754108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bh+hSER4C1DvDn14bvbdLI9ZreonMjP5eqcJAKaJwbM=;
        b=iPCU1tNMlM8fq/StWad5u6JvS3cquovX1dQ7Ea1IymTdRFRRl3iexFyr+HCQsfIZMk
         fMyFSeVt13lcPo13BgTMCSay3qxOVPO4BRz3Efv/32kyxlrtuUFgXpPX1DfFnn3x/sud
         SZI4QUUxlfN5/tNTpuFgXKtoJKoRBLQpvc8HqQbRTPHYvC+cHp9lLndPflejkNXt7PHn
         GImWL/NnTWUEEspM3WuUaOEQ8EsKOR8BfQD/Dk22ARmfDOfJQnuvT/EFVF5TqBpVApRL
         lpVtdt3jACxeAligAklDGCwlmUZWrsEp26q1riBtzpk8UqKEZExAlb5Rdejs9OCiacCd
         zgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149308; x=1697754108;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bh+hSER4C1DvDn14bvbdLI9ZreonMjP5eqcJAKaJwbM=;
        b=Ws/l6EAcVdBF1vN7cP3z7NdEvPfQk0sTRxClBZzf7rkbRtALqmra2gOwsFcDB9pZbB
         w6mY4dQ0hrluyPeoczTdRIUIcXLvVkiw+G4Arf4AisNQZ0Hjfb6BSX2AhgtfrxEmgKto
         g5qBby3Y/lELFeqWycUsAVz/uUXHZxZAgyQmHIrMwgIiBbow8+o8MSO/ilr99eginRIY
         SR8Js6ijV5b+O/LFbv4500hMfm1p596AMMgoHLX7cyZB/5PAxgCh/Djz+XvG5paabAJ3
         GHfokBYEQiYNYdC91jk4Kpd5xIXfi0ant8izFt3gV/+Kd4rr4KL9VOD5wVR95+RAo44e
         0sIA==
X-Gm-Message-State: AOJu0YxY/WQI3+zomjCJbTpU6UClHNn4tINIdChR0OHnCQKKebJZVCFu
	wGPykfCTf2k3yUaO6iI/x68wwNyxaz/MzgUunA==
X-Google-Smtp-Source: AGHT+IELO7CCmKHbSitPZT/rHAYitcviBaNNPJqex7iyGwcatZBSy7jQpznkIdE6Pj+2ay58t+4cDPaWIZTXb3umGw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a9d:6656:0:b0:6bc:e2b0:7446 with SMTP
 id q22-20020a9d6656000000b006bce2b07446mr7467981otm.1.1697149307832; Thu, 12
 Oct 2023 15:21:47 -0700 (PDT)
Date: Thu, 12 Oct 2023 22:21:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHNxKGUC/x3NwQ6CMAyA4VchPduElTDRVzEedFTppS7tQkYI7
 87i8bv8/w7OJuxw73YwXsXlpw3h0kFaXvpllLkZqKch9IHQi2nKG84mK5ujcsG8bKg1Y3qXigk pRprGONF1vEELZeOP1P/k8TyOE0WheCx0AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697149306; l=1461;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=zDm0tM3C96zS13DwXvkwxj+OZciNm9xmIb8vZS7nYHY=; b=jaA6cIlF3bF8PEtTlY+0c10ULOr8mzf5f1MLSNvU6GhIHm6sizPmiWvq3MVNeND9xeoYnl19y
 ETVPyKnbhIwAw97CRcGjpx3d4lEbCCtDsTHw38ivP6HbK7bYoYycjkv
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-phy-nxp-cbtx-c-v1-1-4510f20aa0e6@google.com>
Subject: [PATCH] net: phy: replace deprecated strncpy with ethtool_sprintf
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
 drivers/net/phy/nxp-cbtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/nxp-cbtx.c b/drivers/net/phy/nxp-cbtx.c
index 145703f0a406..6a2c0c193255 100644
--- a/drivers/net/phy/nxp-cbtx.c
+++ b/drivers/net/phy/nxp-cbtx.c
@@ -182,7 +182,7 @@ static int cbtx_get_sset_count(struct phy_device *phydev)
 
 static void cbtx_get_strings(struct phy_device *phydev, u8 *data)
 {
-	strncpy(data, "100btx_rx_err", ETH_GSTRING_LEN);
+	ethtool_sprintf(&data, "100btx_rx_err");
 }
 
 static void cbtx_get_stats(struct phy_device *phydev,

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-phy-nxp-cbtx-c-266285682759

Best regards,
--
Justin Stitt <justinstitt@google.com>


