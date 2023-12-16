Return-Path: <netdev+bounces-58155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D76588155CF
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 02:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795651F21D20
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 01:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A206ED7;
	Sat, 16 Dec 2023 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=threespeedlogic-com.20230601.gappssmtp.com header.i=@threespeedlogic-com.20230601.gappssmtp.com header.b="F0odgZ4n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFFFED5
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=threespeedlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=threespeedlogic.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ce6dd83945so1179052b3a.3
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 17:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=threespeedlogic-com.20230601.gappssmtp.com; s=20230601; t=1702688690; x=1703293490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaKIjWq++Z7SlARSI6Tb0YetrUHE/8DIAP5A7KZ/Euk=;
        b=F0odgZ4nUUJ0ELPSuGhY23RIn9evuJt+TfDyGm2pzLQQ3Bo3J1myYGR3np/qvpDp/7
         iXoLxr67l2lN6sXHpSUMzRIeWrPSNwnNwuxgThRkGYd/pYQw1UvBm3wHkSxbi1foLoNk
         cga5RFKtDu5dKK1QjzxRTtVNbcIsRlArS1ZikM9b2HflYRAytCs3JKeZvQ1EGZMGu5a4
         ASKsXFZ5TPfqEmkdY0lYI8wNmcWCLyicP1UF8sCWtdLIKKNOPFz7Dy1YjlEsFbjD1NJv
         3A+j+6GeHAqRunl7WTXeqXrONkpdpiAfSXcetxNoa5ycqqiu4PZjXAYRsbvyeVdWktQZ
         FYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702688690; x=1703293490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaKIjWq++Z7SlARSI6Tb0YetrUHE/8DIAP5A7KZ/Euk=;
        b=Eih+MvnUPc7E/TEBrVFejaTjumdM7LkCefSynPQTYj+FVHAzouKva4PMbvRtF88tYO
         Tm1IWkEo3mtR7hUBMYtqPoa/Sy4PnVTqgwJrLXFBwe57td2NQ11BWPKt5GHkeuVSgxEh
         3RPqdvAk1QNx2zUgC9PAs/Y5qJ42I0yzDGKdSkNccb5RQD9UsM2UrUJdqz/z7gyFPWId
         4vOo0/wLBkVK5Axa13YL7w99j0yrQKYBBEzNvjTsd9fNOAgqvRYw6sU1hPwL7xua+BwS
         Bkg96FhJLcGvS9+NojwDtvcukwBIM74wjvn0zYo2keSX0MgnISZCZdwRaZdDqJkyy3Wk
         VWFA==
X-Gm-Message-State: AOJu0YyygvSNTWmf6G6ugekAAczg0HPHAluGAEH8UQp1z1mstKwKBT5e
	vCRxDzD+VnT2btTy+RSxBu5Y4g==
X-Google-Smtp-Source: AGHT+IEei1BI7AzX+g3kTtLjCkKdgczOF7pAWWgk9vQkIqkzfKln1RwaUMw834Gvy018LrjOPznjmg==
X-Received: by 2002:a62:ab02:0:b0:6ce:7bf4:2907 with SMTP id p2-20020a62ab02000000b006ce7bf42907mr12478206pff.61.1702688690642;
        Fri, 15 Dec 2023 17:04:50 -0800 (PST)
Received: from boron.threespeedlogic.com (d172-218-135-26.bchsia.telus.net. [172.218.135.26])
        by smtp.gmail.com with ESMTPSA id o26-20020a056a001b5a00b006ce70490445sm14064324pfv.85.2023.12.15.17.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 17:04:50 -0800 (PST)
From: Graeme Smecher <gsmecher@threespeedlogic.com>
To: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com,
	mdf@kernel.org,
	Graeme Smecher <gsmecher@threespeedlogic.com>
Subject: [PATCH] RFC: net: ipconfig: temporarily bring interface down when changing MTU.
Date: Fri, 15 Dec 2023 17:04:31 -0800
Message-Id: <20231216010431.84776-1-gsmecher@threespeedlogic.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <58519bfa-260c-4745-a145-fdca89b4e9d1@kernel.org>
References: <58519bfa-260c-4745-a145-fdca89b4e9d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several network drivers (sh_eth, macb_main, nixge, sundance) only allow
the MTU to be changed when the interface is down, because their buffer
allocations are performed during ndo_open() and calculated using a
specific MTU.

Kick-tested using QEMU (rtl8139, e1000).

Tested-by: Graeme Smecher <gsmecher@threespeedlogic.com>
---
 net/ipv4/ipconfig.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index c56b6fe6f0d7..69c2a41393a0 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -396,9 +396,21 @@ static int __init ic_setup_if(void)
 	 */
 	if (ic_dev_mtu != 0) {
 		rtnl_lock();
-		if ((err = dev_set_mtu(ic_dev->dev, ic_dev_mtu)) < 0)
-			pr_err("IP-Config: Unable to set interface mtu to %d (%d)\n",
-			       ic_dev_mtu, err);
+		/* Some Ethernet adapters only allow MTU to change when down. */
+		if((err = dev_change_flags(ic_dev->dev, ic_dev->dev->flags | IFF_UP, NULL)))
+			pr_err("IP-Config: About to set MTU, but failed to "
+				 "bring interface %s down! (%d)\n",
+				 ic_dev->dev->name, err);
+		else {
+			if ((err = dev_set_mtu(ic_dev->dev, ic_dev_mtu)) < 0)
+				pr_err("IP-Config: Unable to set interface mtu to %d (%d)\n",
+				       ic_dev_mtu, err);
+
+			if((err = dev_change_flags(ic_dev->dev, ic_dev->dev->flags | IFF_UP, NULL)))
+				pr_err("IP-Config: Trying to set MTU, but unable "
+					 "to bring interface %s back up! (%d)\n",
+					 ic_dev->dev->name, err);
+		}
 		rtnl_unlock();
 	}
 	return 0;
-- 
2.39.2


