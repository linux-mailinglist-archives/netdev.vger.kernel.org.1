Return-Path: <netdev+bounces-28350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B16577F204
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9024281D86
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 08:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794F2E56C;
	Thu, 17 Aug 2023 08:25:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD2ED2F1
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 08:25:13 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4E9273C
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 01:25:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6887918ed20so1852638b3a.2
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 01:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692260711; x=1692865511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=88yjcBf/CtMV7gzX6cmdJL1Fu3RFWfJYTKd6XEfTLog=;
        b=RVv/XfhgNg/zqci7hMZ1cWVgn6YYZ1F3oLwCh2EfYLKzk1TzLQyLUIwo3J5ROX0JpI
         QhI7ZeDaFFN/n5jkkgLQnwKlskRW4uRHp+D/iuSzaJ9oDZIpFXOjYEhYpkcQYe4cSx7j
         cit7rL7kdRqoG18o0BwMhvw6zMWHcqZ/YpLSGl/UlWLIiDGlSkXPsyLC0PV3ZbjWu+sj
         S4IAHsEF5br3t7/GdSQRuwmJwexTmjb/ZWwAFzXQexkAIgqfLZIXLJMJMe49Db5Bh9V7
         vxCk5H6/cDPKCpQan+BINCk/yB/R1S7zG/04Rugqe+pcBGE66urhhde6SORUlMZsGouv
         5IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692260711; x=1692865511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88yjcBf/CtMV7gzX6cmdJL1Fu3RFWfJYTKd6XEfTLog=;
        b=Xf/YD/CE9mTceA3PGb/2/zgN1ru52P3OQADTE8zT3SdCvV8c1nzhGG+kT8vc7xJ3wM
         bRSHhnlshSv1zAbWx2QqApcFJg7bg4XOeQvVlAw+2XC61/64T+yC+P0IGfUNF6pNxidC
         rO2X8oyE8rq4B+kZY6Ngd6BVIEVlQYkyNzoL+f0VvwQ5gDko9L8o+64mqanI5NRR6sop
         psRTm/wz8qPixpwGILOc1wH5vX4OiciKlUUTjusoXH8KqnFHqLpKwCCovVjtl//Umrx2
         a1XQzk9NDfkf12ttrBHFKhcWOV+ObF4J1V2PYCZsv26N3G1cZRUizI0LUdIXVdcQW0J3
         M8+A==
X-Gm-Message-State: AOJu0YxfDN7lOJnwINNhAzBlhJvdAaSm0SdABkw/ZrWpDVaJvapiNKxs
	B7iR2cp/odQMal68dnt8cGJAzJcsBp50oeFe
X-Google-Smtp-Source: AGHT+IEyPfgykxOk7KHB4j3Ps4LIexArXiq7PctqrzAm5DPjOyyb7Z4ozYWdXI+S7HJTmfb6Ja51hg==
X-Received: by 2002:a05:6a20:2447:b0:129:d944:2e65 with SMTP id t7-20020a056a20244700b00129d9442e65mr5842905pzc.13.1692260710898;
        Thu, 17 Aug 2023 01:25:10 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g6-20020aa78746000000b0068940ef39aesm1032779pfo.46.2023.08.17.01.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 01:25:10 -0700 (PDT)
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
	Phil Sutter <phil@nwl.cc>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>
Subject: [PATCH net] selftests: bonding: do not set port down before adding to bond
Date: Thu, 17 Aug 2023 16:24:59 +0800
Message-Id: <20230817082459.1685972-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Before adding a port to bond, it need to be set down first. In the
lacpdu test the author set the port down specifically. But commit
a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
changed the operation order, the kernel will set the port down _after_
adding to bond. So all the ports will be down at last and the test failed.

In fact, the veth interfaces are already inactive when added. This
means there's no need to set them down again before adding to the bond.
Let's just remove the link down operation.

Reported-by: Zhengchao Shao <shaozhengchao@huawei.com>
Closes: https://lore.kernel.org/netdev/a0ef07c7-91b0-94bd-240d-944a330fcabd@huawei.com/
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
PS: I'm not sure if this should be a regression of a4abfa627c38.
---
 .../selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
index 47ab90596acb..6358df5752f9 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
@@ -57,8 +57,8 @@ ip link add name veth2-bond type veth peer name veth2-end
 
 # add ports
 ip link set fbond master fab-br0
-ip link set veth1-bond down master fbond
-ip link set veth2-bond down master fbond
+ip link set veth1-bond master fbond
+ip link set veth2-bond master fbond
 
 # bring up
 ip link set veth1-end up
-- 
2.38.1


