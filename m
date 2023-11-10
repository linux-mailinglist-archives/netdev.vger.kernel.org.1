Return-Path: <netdev+bounces-47074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A677E7B49
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0079A1C20E6E
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949E13AF0;
	Fri, 10 Nov 2023 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je72nvip"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25613ADB
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 10:16:41 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D525283DF
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:39 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc58219376so16834395ad.1
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699611399; x=1700216199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXf/A0uy+9wHrukHMCOqfndxWDOODJT68setAz5NS1o=;
        b=je72nvipCn+mOkYiriAd6FsGHjyV0GCd73S5cT4FLymgNS31JZZ0rVtHNtNOkPw28n
         NSo9Bd5UqoxthaZ45rd9hYHVVGng0alrV2npQJqsCk+pWfXllSIbWpi2YzFPoJsLQPoC
         1vjTTyP+XdcR2YMIgOHhbnOrcDuGqtkQ8P8hsySzypf1L8EHv5r6fIdzLobEqdBILxkk
         vRasBm16VhZadPsniOUmpYWFK1ea3V33fGD9glnHCMY12UptwVVTBHPpICJ70R3Vzj3b
         ebKghT/yMH11WmfG+g+VT6ey6o/Qp3CPCXpNnV9FBjCOQNUnwv9gM1nXQ5GfJxesu+lN
         +UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611399; x=1700216199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXf/A0uy+9wHrukHMCOqfndxWDOODJT68setAz5NS1o=;
        b=Ztut0bXNOUqMkppyhhAJw4dTtBEnz0BBrHw1Te4kPty48w3Rxc9z8hC15Qw9N42yRY
         xKQaGqvyvBKExcbQNl3YO+PXaAUxpKLfzOpRqde3BO6wthQN5/9AeL+9CGQKyOnnkTPN
         Zh8Wc/g1IzU/px9QuPMI4qvhRUGDBRZexEGdr3yUnomPidER4El8lI2dop739pWbimdk
         Ck04+2lwrdXzKJkwxilkXyn9UZsfh1OTHG+QezRtC+GMbWll2+/hKSO+VqHQ6b0pVV5f
         BVXe8KWKcQ6netMnx0eDGVPrB2JNxAyWNtitVy4KmrVJcunpNzMDyrHMmtwxyam00U4O
         M/FQ==
X-Gm-Message-State: AOJu0Yzjs2aLG/zJcfxsyE3JWMMu6ciQexifSUlhNeEE8S5KeQpMj0KB
	/wEdxOtK3vNcgUwtXsql7Jr2QEDfqhfhtg==
X-Google-Smtp-Source: AGHT+IHNmzc5uU57q2aQw3UcN09r+VlbRx6iTMMIrXVRbfK6/hOUNdZHRWqDuoSJdO1JZoDTwczJXA==
X-Received: by 2002:a17:90b:4b84:b0:27d:348:94a8 with SMTP id lr4-20020a17090b4b8400b0027d034894a8mr4332781pjb.6.1699611398779;
        Fri, 10 Nov 2023 02:16:38 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b0027d015c365csm1244631pjb.31.2023.11.10.02.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:16:38 -0800 (PST)
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
Subject: [RFC PATCHv3 net-next 10/10] docs: bridge: add small features
Date: Fri, 10 Nov 2023 18:15:47 +0800
Message-ID: <20231110101548.1900519-11-liuhangbin@gmail.com>
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

Add some small features in the "Others" part of bridge document.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 7f63d21c9f46..8adf99774d59 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -273,6 +273,20 @@ So, br_netfilter is only needed if users, for some reason, need to use
 ip(6)tables to filter packets forwarded by the bridge, or NAT bridged
 traffic. For pure link layer filtering, this module isn't needed.
 
+Other Features
+==============
+
+The Linux bridge also supports `IEEE 802.11 Proxy ARP
+<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=958501163ddd6ea22a98f94fa0e7ce6d4734e5c4>`_,
+`Media Redundancy Protocol (MRP)
+<https://lore.kernel.org/netdev/20200426132208.3232-1-horatiu.vultur@microchip.com/>`_,
+`Media Redundancy Protocol (MRP) LC mode
+<https://lore.kernel.org/r/20201124082525.273820-1-horatiu.vultur@microchip.com>`_,
+`IEEE 802.1X port authentication
+<https://lore.kernel.org/netdev/20220218155148.2329797-1-schultz.hans+netdev@gmail.com/>`_,
+and `MAC Authentication Bypass (MAB)
+<https://lore.kernel.org/netdev/20221101193922.2125323-2-idosch@nvidia.com/>`_.
+
 FAQ
 ===
 
-- 
2.41.0


