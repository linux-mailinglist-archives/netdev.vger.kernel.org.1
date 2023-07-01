Return-Path: <netdev+bounces-14901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496F5744692
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 06:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE99B1C20BC1
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 04:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34F017D2;
	Sat,  1 Jul 2023 04:42:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3F17CF
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 04:42:04 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942254204
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 21:42:02 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b7279544edso2259386a34.0
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 21:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688186522; x=1690778522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=glUJU/oOKrBNGBc22+2Ww5Sx0+TjKtU0nzbR4VOU8SA=;
        b=QmqDPHCEUSoUu5s30XOCaTgNt7Yc3GCoJ/YVLie6b77szDED466REqzsweKWJVMZ4r
         cJjx+07YWrs6cYhT8JoWOP45AheV3Y8mM26J3dcmy77n4SO89wbt6r8JPdpH4uJnBL50
         J5bF6xUs/tEyEhrHA0PvW3AdhODhZWo8i4jbNNBWN9om2vGHR8Hr7opserUvhsRzpkW1
         BTnEIXmgf6fA4lYA1n+KPU9ssKWEW/U54+TtJRcuEFuQZoDip0jmNv32enf/TR/we2Hs
         xFF1nqPk0/q1Wn/k6xLe7dXj/lc45hRnED3fl/UNg5gJqVeWTebHIQayr3xSJPbafZGc
         KXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688186522; x=1690778522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glUJU/oOKrBNGBc22+2Ww5Sx0+TjKtU0nzbR4VOU8SA=;
        b=DjBB58km77GMCJkFVzMjn9cJ+fAVqigapwdwHFhv7YSbK4C5W4pIFt+QoS1QpDkjeW
         nG7ccl5BrSCXL00jdWVhjOPYdYvav6XI0c3Hru2+px1psiBaYkfKBHBKSTiW1M5gVrcE
         koDbCxP9Ojfu5y3VvgTM6mx6sUsjC3UJzvDZEpAyxckZ6eKEFL3zMEWCNjAGclVhGh7b
         t1C4PPOoR1Q3EeZwIa6DuGe3OFMN1H+lhoz+STMk0lu6irYV5YWsJzGvrXeLCk06n/ZS
         7ob05EantMKG4DemcK7ZhvWshXS65SsLbGKwcexdAV3iNZuljdmCMW6IO0oVXFA92HnK
         kt/A==
X-Gm-Message-State: ABy/qLbYsm5saQV58BjqRB9+qgfzuq/SOAyIj+IB6sGcltZpbgczaq3v
	FgeWPY0prnB7m8hvE1YaiQSWwQ==
X-Google-Smtp-Source: ACHHUZ5L8GGkhWrsQ4euNp9T1B+i+sOcGT0A3QPEV75aDTuRpCijOTvpXE+5DCJTF63xUupdu69GQg==
X-Received: by 2002:a05:6870:6a90:b0:1b0:3a8c:a807 with SMTP id mv16-20020a0568706a9000b001b03a8ca807mr6512550oab.14.1688186521915;
        Fri, 30 Jun 2023 21:42:01 -0700 (PDT)
Received: from armada.cortijodelrio.net ([149.19.169.76])
        by smtp.googlemail.com with ESMTPSA id w19-20020a9d6393000000b006b74a5a2712sm5667081otk.15.2023.06.30.21.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 21:42:01 -0700 (PDT)
From: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
Subject: [PATCH] selftests/net: Add xt_policy config for xfrm_policy test
Date: Fri, 30 Jun 2023 22:41:03 -0600
Message-Id: <20230701044103.1096039-1-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When running Kselftests with the current selftests/net/config
the following problem can be seen with the net:xfrm_policy.sh
selftest:

  # selftests: net: xfrm_policy.sh
  [   41.076721] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
  [   41.094787] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
  [   41.107635] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
  # modprobe: FATAL: Module ip_tables not found in directory /lib/modules/6.1.36
  # iptables v1.8.7 (legacy): can't initialize iptables table `filter': Table does not exist (do you need to insmod?)
  # Perhaps iptables or your kernel needs to be upgraded.
  # modprobe: FATAL: Module ip_tables not found in directory /lib/modules/6.1.36
  # iptables v1.8.7 (legacy): can't initialize iptables table `filter': Table does not exist (do you need to insmod?)
  # Perhaps iptables or your kernel needs to be upgraded.
  # SKIP: Could not insert iptables rule
  ok 1 selftests: net: xfrm_policy.sh # SKIP

This is because IPsec "policy" match support is not available
to the kernel.

This patch adds CONFIG_NETFILTER_XT_MATCH_POLICY as a module
to the selftests/net/config file, so that `make
kselftest-merge` can take this into consideration.

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/net/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index d1d421ec10a3..cd3cc52c59b4 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -50,3 +50,4 @@ CONFIG_CRYPTO_SM4_GENERIC=y
 CONFIG_AMT=m
 CONFIG_VXLAN=m
 CONFIG_IP_SCTP=m
+CONFIG_NETFILTER_XT_MATCH_POLICY=m
-- 
2.34.1


