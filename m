Return-Path: <netdev+bounces-17864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864327534D1
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4317E2820DF
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B95DC8ED;
	Fri, 14 Jul 2023 08:14:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1086CD2FF
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:14:04 +0000 (UTC)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4484B3AAE
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:13:59 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3460aee1d57so7051695ab.0
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689322438; x=1691914438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpuzNiJzoPJAnXLr2PGD3stMP4mts2t3lHbBmTcvHiQ=;
        b=qThPUBkAV1JG3BtvFko1MhghX1YUCGMjL0cn+D3M5/j5Gg6NaY17mDHzI9a6sXVZzb
         bAvUgOxjk9Yv2qiqb2r2xhIeuyII7fFpIdYsua4IM3ZW48sje1u5+m5OjFkFKSjDccyY
         FRRBCPuFFoC69ljfCBuUN+pqRyUJVBX+PD4BK6MbicABCsHFaBTKCLt7kmJX29WcwAvP
         fj48/IR8UM21d9de3rYrZl1b0i1TGyRyIK9ZYFy7CHXbnHI3eE3j11frGxfhxKkY4T0u
         n9vewBJ2PvQWM46G+TT/BWdKmeUtKiI9PjE45Md+Ntxi0iV5WLIFivTDyQt0t8jJykTt
         h7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689322438; x=1691914438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpuzNiJzoPJAnXLr2PGD3stMP4mts2t3lHbBmTcvHiQ=;
        b=hvO1x5Pg4mHRFJCtRI6VTJtznNvGcf8u1Ot5SeGNb4lMyhOhLwaTKulYLgmIGjmZPv
         215vqpChMCYDApjJEpK/haMcu+xgUB/a3X0WjWz8EWvD5R1SYWijgKMFp80imlPZhnv4
         9SsZ+ujcgy08K4jKZ+LwYKHRzpCLMSyS0EYzwXiPXiA9UJXD27zb31pwJSxyYtsT/R0u
         UUdgVmrHDNiw8Irixn+ruSKQgHKXKXx7JpKoJYqgeZLuhAPmV+tlfiZfDcbF4U0h3Xkh
         KRUNRzizf+IAht2hDw2rOlGdZCfcQtqAROhwQVhfwXHrDMl246dfWwsicbT+MjUzqsD6
         AJLA==
X-Gm-Message-State: ABy/qLaIiHXPhVAOYjvlg6eSkpXn+wvGe5J0QYoftrbZLzfgy7CExm86
	Zb+sf94Dd2PdQU1uvoDo5m7M1H7i8wbccg==
X-Google-Smtp-Source: APBJJlFjGXPhhuRhmMjN5queMOSAz+UFbRHAbZLk7rCPTEsIrt773x0dE+luWGEzuBMxdR+9tEsHew==
X-Received: by 2002:a92:cc4c:0:b0:347:7059:386c with SMTP id t12-20020a92cc4c000000b003477059386cmr3809363ilq.16.1689322438160;
        Fri, 14 Jul 2023 01:13:58 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([2409:8a02:782f:8f50:d380:ebf:ef24:ac51])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a199400b00263ba6a248bsm715268pji.1.2023.07.14.01.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:13:57 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net 2/2] team: reset team's flags when down link is P2P device
Date: Fri, 14 Jul 2023 16:13:40 +0800
Message-Id: <20230714081340.2064472-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230714081340.2064472-1-liuhangbin@gmail.com>
References: <20230714081340.2064472-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When adding a point to point downlink to team device, we neglected to reset
the team's flags, which were still using flags like BROADCAST and
MULTICAST. Consequently, this would initiate ARP/DAD for P2P downlink
interfaces, such as when adding a GRE device to team device.

Fix this by remove multicast/broadcast flags and add p2p and noarp flags.

Reported-by: Liang Li <liali@redhat.com>
Links: https://bugzilla.redhat.com/show_bug.cgi?id=2221438
Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/team/team.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 555b0b1e9a78..9104e373c8cb 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2135,6 +2135,11 @@ static void team_setup_by_port(struct net_device *dev,
 	dev->mtu = port_dev->mtu;
 	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
 	eth_hw_addr_inherit(dev, port_dev);
+
+	if (port_dev->flags & IFF_POINTOPOINT) {
+		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
+	}
 }
 
 static int team_dev_type_check_change(struct net_device *dev,
-- 
2.38.1


