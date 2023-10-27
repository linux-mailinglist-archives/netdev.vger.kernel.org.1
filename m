Return-Path: <netdev+bounces-44864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 279967DA27B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCCE1B20CB7
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5323FE2E;
	Fri, 27 Oct 2023 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2dAHuFM1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F45A3716D
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 21:31:03 +0000 (UTC)
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC168B0
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 14:31:02 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id af79cd13be357-778999c5f1dso324332085a.2
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 14:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698442262; x=1699047062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MI6bVykQDbdW2vz2XrrMq2PILwHbTFu4swv4LXOgVcU=;
        b=2dAHuFM1f4xSOZtd1p6gNwbBnuxee+3C3WbbJGlurauKfV75wRs6LVi16wxVMdwHPK
         teBpXrcXbpA7UgRxpW2ZOxzhVE/havsxJIuj4ywWqmaJIJbfbBtHgeP/KQpQSrS84Z4e
         nviGfgD0CFM/7yvTE0rNRT6lqLWIwx2jzq7NCcLe59AJdu6RbYEtmTb0ZAwpaVG2j6JN
         9oZDHkh+Oe0duaswRN2RcZHaNa9fIci2X2xFb2KJ012lMUjOPHBT0yx2pSPSY70Bmjhn
         K4kpFF/Szg5bTAPStrHyVZIjgZxGL07Yy844n8uYGR05AIlLMofXk3/OfT9h7pUMNqI7
         R7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698442262; x=1699047062;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MI6bVykQDbdW2vz2XrrMq2PILwHbTFu4swv4LXOgVcU=;
        b=Az97IzdCFUSHPJ8fBQBUwX4NwwEXrVBvI9YQvxioGuMiXReun58+zlOhsNLCpg8G7r
         Zy6Xln4PGoB76Jvl9czvDZ3lNXm0/Zgr84YaCBTVRpGTqukTvR7S0wPsapt+z3LILnuF
         Az9SW6DFbUSiB6b1fzhTE8FiJyLgTmPVm7wLcPqwsQO9bH9zsMdPwbo7miQJ3mvMcQgt
         8hbFGKXceei/PdmkefPYDifm0D3x9MIlwm4XdMjFgFWUwL/7a4owAcdIPvVBVvFu8hKk
         tPNK+8Ge+R4g1jgPk3vSe0RF+3iJWtdlWvvg0v8DDTwj1o8vu+Dsc8QAiBzO1MMD4hsg
         mQBA==
X-Gm-Message-State: AOJu0Yxgbq4rdZmMJP1bXvNUJmbDhVOi871trjgDGFdszvMX9frn1SNI
	tdszG9HKHHnxQOUeonTWZ5ffNTsbEsju79UG3omw/lPa0ssxnpadXTZdJMCxtg4p/hqEGP1GvQV
	yZ0BRzHJLDVynYh/0jds6+KpRUanaRq+XsmnoFLcvmocNPPCY1QUCIw==
X-Google-Smtp-Source: AGHT+IH+BodIS3bugVCcaCTLSCmmzfoQjCJIIIJk2spYzrwsSlmhh+RC/6RAolXSm+aXzaR1ikiI634=
X-Received: from ptf16.nyc.corp.google.com ([2620:0:1003:314:7908:dc2a:2e54:fd31])
 (user=ptf job=sendgmr) by 2002:ae9:e207:0:b0:777:f69:557 with SMTP id
 c7-20020ae9e207000000b007770f690557mr64327qkc.15.1698442261542; Fri, 27 Oct
 2023 14:31:01 -0700 (PDT)
Date: Fri, 27 Oct 2023 17:30:55 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027213059.3550747-1-ptf@google.com>
Subject: [PATCH v2] net: r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
From: Patrick Thompson <ptf@google.com>
To: netdev@vger.kernel.org
Cc: Patrick Thompson <ptf@google.com>, Chun-Hao Lin <hau@realtek.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, nic_swsd@realtek.com
Content-Type: text/plain; charset="UTF-8"

MAC_VER_46 ethernet adapters fail to detect eapol packets unless
allmulti is enabled. Add exception for VER_46 in the same way VER_35
has an exception.

Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
Signed-off-by: Patrick Thompson <ptf@google.com>
---

Changes in v2:
- add Fixes tag
- add net annotation
- update description

 drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 361b90007148b..a775090650e3a 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2584,7 +2584,8 @@ static void rtl_set_rx_mode(struct net_device *dev)
 		rx_mode |= AcceptAllPhys;
 	} else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
 		   dev->flags & IFF_ALLMULTI ||
-		   tp->mac_version == RTL_GIGA_MAC_VER_35) {
+		   tp->mac_version == RTL_GIGA_MAC_VER_35 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_46) {
 		/* accept all multicasts */
 	} else if (netdev_mc_empty(dev)) {
 		rx_mode &= ~AcceptMulticast;
-- 
2.42.0.820.g83a721a137-goog


