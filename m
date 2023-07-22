Return-Path: <netdev+bounces-20065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3446C75D859
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E413E282554
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 00:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5664838B;
	Sat, 22 Jul 2023 00:37:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD07EC4
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 00:37:29 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A283C13;
	Fri, 21 Jul 2023 17:37:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 8601E6017F;
	Sat, 22 Jul 2023 02:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1689986245; bh=pTPk5QVJQzy4beH8ZuTqLRthaCgM62PmnWjd63M9UV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0gAN3W35FU0YoUJaDkx6ltr9K5vnKfLaV9/25bnRwbqBaN2Y27AZ/HD5Wqd2Ul1Mf
	 rhE+BDCI+iqSJqydmp+GFmViBwi1Pk9CFZdIlOoRhpERqAWWWgKpD83fqdD/m9Pt0o
	 htBHCy4ZI2jWJztgw+LmgyhIvvfybK5E9ipW2Do+gqP/QRT3JVsKPgpIbVNstoY46Q
	 VN8HAN7HF7npa2SkPPvNgod9MxZRYHdUOLmRxe9Y02IVnTC0lZJfHj8TYykwFGPvSo
	 oU1cC2RPctXdHynJRrJQ3RiJu0fCstfr/KXNXS7w6xs2W7vZiXpvYL6/qVmuqMHk+u
	 wWAQdz7q/lX1A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k8aBC5yL3xMl; Sat, 22 Jul 2023 02:37:23 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
	by domac.alu.hr (Postfix) with ESMTPSA id 68C3A60182;
	Sat, 22 Jul 2023 02:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1689986239; bh=pTPk5QVJQzy4beH8ZuTqLRthaCgM62PmnWjd63M9UV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWoEkSWWwGtCwM7ho0noxsldMed1jWELG2CyVEaX8Dd6Ohfc7naN320ryGCXWo++u
	 z/vw5GA1+TN7HIyrXWwzX5rIWApMPu9uN2Ew1uqz44tFsgWG1sjOIq7jnuV5KX/H+o
	 x3juthC2hll+VytPM9mdG3GHj02O8YWxo8CxZgY/8qPG4K0GqldFxyteZlgXIfqHlp
	 9wvxR5cEr4SP/bYccsU9Er2q0dqH51fOFbJvLQJ5Jh9a1KyThMzPWBIQi2v/2Q+aoL
	 kX8o4IxbtO/ZQWcOVoqAwVRssTKZpD3haM2z99BBogcMg6EgdUO0c2SyWVd+xD7O2x
	 yOzsWUfNhYUVA==
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To: Ido Schimmel <idosch@nvidia.com>,
	"GitAuthor: Mirsad Todorovac" <mirsad.todorovac@alu.unizg.hr>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v1 08/11] selftests: forwarding: no_forwarding.sh: add cleanup for SIGTERM sent by timeout
Date: Sat, 22 Jul 2023 02:36:07 +0200
Message-Id: <20230722003609.380549-8-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add trap and cleanup for SIGTERM sent by timeout and SIGINT from
keyboard, for the test times out and leaves incoherent network stack.

Fixes: 476a4f05d9b83 ("selftests: forwarding: add a no_forwarding.sh test")
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
---
 tools/testing/selftests/net/forwarding/no_forwarding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
index af3b398d13f0..f748954aa1cc 100755
--- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
+++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
@@ -251,7 +251,7 @@ setup_prepare()
 	ip link set dev $swp2 up
 }
 
-trap cleanup EXIT
+trap cleanup INT TERM EXIT
 
 setup_prepare
 setup_wait
-- 
2.34.1


