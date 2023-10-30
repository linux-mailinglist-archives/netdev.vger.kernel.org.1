Return-Path: <netdev+bounces-45318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B697DC16A
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 21:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E28B20E8D
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAF5199BD;
	Mon, 30 Oct 2023 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0dp9t7N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B11A73A
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 20:50:36 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3BAF1
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 13:50:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7bbe0a453so44889977b3.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 13:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698699035; x=1699303835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tlU8k+5W0N+VIEb7C9PJmPm8rehaU2/fXsyGUQ0B3ko=;
        b=l0dp9t7NP6CdfpOIyE2AOz/UGx1frD5R0dwY59A+kuAN2Bl9deTRqzOPXRWLcsfjHs
         qyfjgnuNPR05oyiGqg1CTQwAg+XC7QzPjbQtdEHipp2HD5MKQDRYHrMqMZ7RqdrE0/or
         hVZhQx9SKNtOYhYcuoPR5SiYHCpYNVoqGl8OR2GwJBEtoQKSclBsHljJG+NCDoesVSaX
         /i27L7Anm0mGfvQL4nL4EL+ltCxdJNdJ7Of9P2yzRc9bU3Na2nky0nlWmxQCW28yD3x/
         NLb/0rJGeJh+GEtsNH2K7zoH6jCcZb1z8esNmcAFTjYGTSemdK/IMlar7rd9hE7TrXOl
         PaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699035; x=1699303835;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlU8k+5W0N+VIEb7C9PJmPm8rehaU2/fXsyGUQ0B3ko=;
        b=T+83e7r5z5N3e37sJ01a5sxPvNjkiG1dhkcbBF6fyNWaE5+CcFbO/a9SuVQUzWwLR4
         mwT4OeVWR056XSxI/gkO2P5Y49eFUU0YPgVjZ44oJNkf1OpACgP5EY7QNYGBh7hlOlyT
         K3WVhFGZH2/1xbhcHPXI90ekW4HyyveHGkOJNiPGJSRYbUVrvi0lzlb0SCbRWsu6RVeT
         yvKapwyn5Thg19tUUlNtSfFnqLxbVU0DkuFeWBI70uEamYLiZnXk3h7vl5M6zwxc5f80
         CMuEjF7u+mWutpqHFktjA5Fx0gJi78u8xSbGl/HBuGvWVb8KnEYl6L4T7YwOuGmHxUBT
         sdpA==
X-Gm-Message-State: AOJu0YzbcgYk9SNlHREMYaFGxw5V2km662n2FLPKBAYI3vl4Cv7KNKpT
	jb7uLdSrd2GJVY4kVyqHv4lw2VXJ9B1O9tr3d4XDwTEFFMfA04imQwKF3xXxeAuqyYReoTlbrZW
	GeH8oVpr1WX5dBj7Ls5eKnCXaK9cRj53dvegkowJYKnv8RAMK9mYbJg==
X-Google-Smtp-Source: AGHT+IHy83zK8iZYXhUh94dM51N49/ljRVFPASmrjDiooMVdgIlRHr35Klf2swwmRqc9iUPy5UnbXE0=
X-Received: from ptf16.nyc.corp.google.com ([2620:0:1003:314:b293:ee7f:826f:b212])
 (user=ptf job=sendgmr) by 2002:a25:26cd:0:b0:d9a:3a26:fb56 with SMTP id
 m196-20020a2526cd000000b00d9a3a26fb56mr195591ybm.2.1698699034576; Mon, 30 Oct
 2023 13:50:34 -0700 (PDT)
Date: Mon, 30 Oct 2023 16:50:14 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231030205031.177855-1-ptf@google.com>
Subject: [PATCH v3] net: r8169: Disable multicast filter for RTL8168H and RTL8107E
From: Patrick Thompson <ptf@google.com>
To: netdev@vger.kernel.org
Cc: Patrick Thompson <ptf@google.com>, Chun-Hao Lin <hau@realtek.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, nic_swsd@realtek.com
Content-Type: text/plain; charset="UTF-8"

RTL8168H and RTL8107E ethernet adapters erroneously filter unicast
eapol packets unless allmulti is enabled. These devices correspond to
RTL_GIGA_MAC_VER_46 and VER_48. Add an exception for VER_46 and VER_48
in the same way that VER_35 has an exception.

Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
Signed-off-by: Patrick Thompson <ptf@google.com>
---

Changes in v3:
- disable mc filter for VER_48
- update description

Changes in v2:
- add Fixes tag
- add net annotation
- update description

 drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 361b90007148b..c92286926a1b5 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2584,7 +2584,9 @@ static void rtl_set_rx_mode(struct net_device *dev)
 		rx_mode |= AcceptAllPhys;
 	} else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
 		   dev->flags & IFF_ALLMULTI ||
-		   tp->mac_version == RTL_GIGA_MAC_VER_35) {
+		   tp->mac_version == RTL_GIGA_MAC_VER_35 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_46 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_48) {
 		/* accept all multicasts */
 	} else if (netdev_mc_empty(dev)) {
 		rx_mode &= ~AcceptMulticast;
-- 
2.42.0.820.g83a721a137-goog


