Return-Path: <netdev+bounces-40147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CFB7C5F31
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1195B282439
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 21:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D4D219FE;
	Wed, 11 Oct 2023 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYsi7NxU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF43A29F
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 21:37:25 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F22A9
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:37:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a397a7c1cso377351276.2
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697060243; x=1697665043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bdhtumD96yS+0S1renjDPDHQ2oQXBATflGNogyMiPxo=;
        b=FYsi7NxUvtyZOx4yy3AL/VbGncYW0njm/7eSGeZ4KjtXpMJLuFlI6ND23E9M9LYg3x
         8ahgUTqXhlXr2urankGdcWXnEcvrWnJqPqA/UjuQYZz+E0Wdnbqd6KlRiXNdAPShgmp0
         FNir1yxTYR4bydgt0VnaxHgRQeWyQMQwe7Tqz22zR0B6Xuq8FmWGABkIoLdsc5BX0JZd
         PPt0JCKdb3u+pf7E9rDMgZzW1y9eakXd5Qj5r6NiJYubsZu6RZm0W3lyqTErXlRxazMh
         QsloiX95YMt8jjVCrMybyWSyYgkhkFXVIi9oryxdSCK4GOl0eh2DXy058QmW3RWeTCNe
         OOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697060243; x=1697665043;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bdhtumD96yS+0S1renjDPDHQ2oQXBATflGNogyMiPxo=;
        b=Qs7hUwYw50hJePRqUuG7OKuan1CSQRXa9HzUFrYGXeh0D5fn8y09PE8ckEtkGBPGIS
         Ie/4anfaMEM9xO82ZYCFxxNVfSvE7aCV8bn94+i5GMs1DEg22Vl5wEKmBPweJZtfbrSJ
         50NFvrrxCb2D3j0cO7Vq63x3FgvdrgCI2gDPrkrkb9ahHcGUgG0vFflQcZIIGUafLd6C
         owHgV2tgr29z0zQGRdaJL7jFZFSHvprxGBPUy2z1tKXjbyGgEevkzeSOessHXT7HfBNV
         VHl/5GIz9atn2QKzkO3Vf7SZg+ZKeM52B07dweMxDDCFL2kNNQIcuLrYiK0OArz8klEy
         uvUg==
X-Gm-Message-State: AOJu0YweUSp9UVxKVXJHVaO2J9TL3Q9lyoTDYOKLXEAP7QYJOe1p5jkT
	L9i5SJSdS0eSA+bxYhETA54HDFQTlhgmdrWCGw==
X-Google-Smtp-Source: AGHT+IHDNvnEYdVeA7aq+enyxmGfB/h9i6Fu3pciabl/8PXY/oPHdAuzxhC6COR8jt65lRiN26z1YArFR414iovQng==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:4056:0:b0:d9a:4f4c:961b with SMTP
 id n83-20020a254056000000b00d9a4f4c961bmr131018yba.1.1697060243280; Wed, 11
 Oct 2023 14:37:23 -0700 (PDT)
Date: Wed, 11 Oct 2023 21:37:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAI0VJ2UC/y2OUQrCQAxEr1LybaDbarVeRURqmroB3V2SpVRK7
 +4qfs08eDCzgrEKG5yrFZRnMYmhgNtVQH4ID0YZC0NTN62rnUPLGii9cVSZWQ0DZ+TsWb/lJaS RvCS0NOhy+MetCDnGJxIe+/bUd+O9o2kPZSQpT7L8Dlyu2/YBrl/wDZAAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697060242; l=1738;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=s+mTiltMqX7As4CbGqq/2I96f5ZlgOW3Hq371eE6U+A=; b=ortN8RXCgeBg2EiOfufpEEBmLQpe8xksMJsaC4JoTO2illgEiCNaRXqc2GNe2S/2gmaFOFSuc
 i++d+IVn74jAvc5kUy5AXBSjvAe9ZIm7qtF4OH5athk1nrp+QrRszKS
X-Mailer: b4 0.12.3
Message-ID: <20231011-strncpy-drivers-net-ethernet-microchip-sparx5-sparx5_ethtool-c-v1-1-410953d07f42@google.com>
Subject: [PATCH] net: sparx5: replace deprecated strncpy with ethtool_sprintf
From: Justin Stitt <justinstitt@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

ethtool_sprintf() is designed specifically for get_strings() usage.
Let's replace strncpy() in favor of this more robust and easier to
understand interface.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
index 01f3a3a41cdb..37d2584b48a7 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
@@ -1012,8 +1012,7 @@ static void sparx5_get_sset_strings(struct net_device *ndev, u32 sset, u8 *data)
 		return;
 
 	for (idx = 0; idx < sparx5->num_ethtool_stats; idx++)
-		strncpy(data + idx * ETH_GSTRING_LEN,
-			sparx5->stats_layout[idx], ETH_GSTRING_LEN);
+		ethtool_sprintf(&data, "%s", sparx5->stats_layout[idx]);
 }
 
 static void sparx5_get_sset_data(struct net_device *ndev,

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231011-strncpy-drivers-net-ethernet-microchip-sparx5-sparx5_ethtool-c-793896db6cf4

Best regards,
--
Justin Stitt <justinstitt@google.com>


