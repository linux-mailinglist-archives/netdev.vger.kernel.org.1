Return-Path: <netdev+bounces-47072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0F87E7B43
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F2F4B20E88
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6574613FE7;
	Fri, 10 Nov 2023 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMBTlmUV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03469134DF
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 10:16:32 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BCE27B3F
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:31 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-280260db156so1606665a91.2
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699611390; x=1700216190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAl1qrWA2Vjv6+R6pNb3HshMnAG0HgniuTWWiLPfzQ8=;
        b=bMBTlmUVzlpq11Suk3gxUHJwXiwexa5/cH5/tekNA6O99tcqQEQqgLhu+taAZWnsyy
         JMAmH7EtyeqzBw/oxGTAgRxq8y5gHo877IwYA+jdRZc40Ese9ym4ubyQPvCyqik1G8Nw
         iNLSvw06qUyEWBLH9VGc8+0V1ZkHn0ME5GqxXGDAQOtI4fObcetKH2TMXLJlhOf0hoZ5
         scIrdhBBSYZ2PNwEhKom/BwjR8LYGgKlUreHTVQoTsl6zHK2jxSuu5cG9OvRIE6k5+Ol
         yxcpeWyYFyG/nHYZLiHVQAcXCovPg+I3AaLgwKvF+CIhBCF7vet1ht2+69t87PXjPNMI
         ZBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611390; x=1700216190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAl1qrWA2Vjv6+R6pNb3HshMnAG0HgniuTWWiLPfzQ8=;
        b=bIlovCDXG/KcvnrxNaxHr2ql2KYa85+JYrCKmpuYBYAJUQb8fxVFMuXSesArH9uqiJ
         Zh6BvVG70GwXq1my60UaxoSYugdreP997rS1hkuf5RDLaKvVTTOHKdVjj/VbLKQ+mM4q
         Ck144OTdOZ2bJ8N6pa0YsX8tDELfXBTBTdeP+lZc2zgfod+psVvpLRvkvx5/oezKMI7w
         7qVWAObdjTcSplPwi/iiP0+u101iqnjIZG9jAY5KooRPYi3F/7DQKbglNsRMIll5vEzJ
         hGiGMGY02oUIvnZ4wxWK3z+e0pruvwuiNkedloA6ZUnxWkzWWmP0KmzYjEdviMHcvrPG
         LInw==
X-Gm-Message-State: AOJu0Yw3NohEoIVXUXKWjEhRkQzRFfrdkYBevoWVPrhiujgCgG4/+G/l
	EKwbwcodCxpBUr5apVYBvAQlq+xEM/+Cng==
X-Google-Smtp-Source: AGHT+IFBheYR5oWHREMjyIqz0H6KaoKzJi8ZXutPilkRhE1gcYlQ5I5gg422BvnHqpODg2GjbpKrbw==
X-Received: by 2002:a17:90b:1b0c:b0:27c:f8f4:fedb with SMTP id nu12-20020a17090b1b0c00b0027cf8f4fedbmr4764777pjb.21.1699611390669;
        Fri, 10 Nov 2023 02:16:30 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b0027d015c365csm1244631pjb.31.2023.11.10.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:16:30 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC PATCHv3 net-next 08/10] docs: bridge: add switchdev doc
Date: Fri, 10 Nov 2023 18:15:45 +0800
Message-ID: <20231110101548.1900519-9-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110101548.1900519-1-liuhangbin@gmail.com>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add switchdev part for bridge document.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 1fe645c9543d..4ff1e4ab6dd5 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -219,6 +219,24 @@ which is disabled by default but can be enabled. And `Multicast Router Discovery
 <https://lore.kernel.org/netdev/20190121062628.2710-1-linus.luessing@c0d3.blue/>`_,
 which help identify the location of multicast routers.
 
+Switchdev
+=========
+
+Linux Bridge Switchdev is a feature in the Linux kernel that extends the
+capabilities of the traditional Linux bridge to work more efficiently with
+hardware switches that support switchdev. With Linux Bridge Switchdev, certain
+networking functions like forwarding, filtering, and learning of Ethernet
+frames can be offloaded to a hardware switch. This offloading reduces the
+burden on the Linux kernel and CPU, leading to improved network performance
+and lower latency.
+
+To use Linux Bridge Switchdev, you need hardware switches that support the
+switchdev interface. This means that the switch hardware needs to have the
+necessary drivers and functionality to work in conjunction with the Linux
+kernel.
+
+Please see the :ref:`switchdev` document for more deatils.
+
 FAQ
 ===
 
-- 
2.41.0


