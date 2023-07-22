Return-Path: <netdev+bounces-20060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EED975D84B
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDD1282564
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 00:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD45A365;
	Sat, 22 Jul 2023 00:37:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FEC7F
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 00:37:25 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D529135AB;
	Fri, 21 Jul 2023 17:37:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 520BB6015F;
	Sat, 22 Jul 2023 02:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1689986241; bh=Bc0dIUG/XF3GLflgprZ9fOJOZFSZr/NOgaX0ho+Cj8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MfDNSlaUJsXJ6zY4IWcQDHeJ6wCBFZdlFx8QyQm8Jwjf/odNvPQHc8+zm/ToOzK/Y
	 xxbR/+GlqEtt9LmKmKscUQxHUZU5DVxKlSkUAKZNrAL1XkjLq97bK386wcXJbqAyNZ
	 v9uewOSYiMyXq8dir1+bee1yvtx4eIN7ak9muDrYn7jKwXtOeG64CAx7AjRtO8X61B
	 Jpl6Or0Ps2XxtggyE4Z9Q67MII2dqvl3l/9xLdZrJYGZ6VCN7yelPi4YAuUDoLY/7h
	 B8knHFMaP5r5FJl2FJOxsAFbCl8uGQZ4GUeFBCjnoMITIWBvhPkfV9TLFDZUaDCfYS
	 cfm36jflKDwBA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MvLS1Q3DjMCb; Sat, 22 Jul 2023 02:37:19 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
	by domac.alu.hr (Postfix) with ESMTPSA id 33E0960171;
	Sat, 22 Jul 2023 02:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1689986239; bh=Bc0dIUG/XF3GLflgprZ9fOJOZFSZr/NOgaX0ho+Cj8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bN0Huft29JSlT6o255gAqANu1pKkw9Ur3Ecin+WVVnr0CPlq8zm7SpFhMk3fIJmCI
	 BlbbEMnz3mZBKRFJDSDoWhoCPpmS6C0gW+iWoTvDU0qC6tY5qAQ2e+TJKmp07DFhQx
	 8N5G9TWyZAgtWFftFN+/fQNkBNjGp1O3MveE+prUi8zqwul5RtHUFVlr9o86cxLlNd
	 b3av7367F9cezDPOuYBYrwebHScDcQXcmLO3h3UMBy9RV+MugXtNBPlvOX3oDydWc4
	 hv2e7JusywHbzLEcbQbBnzbFjTiQXAapkdU9lBWMmqGV6gujkJkec/2k4Y/zZ5Guof
	 qdJq0/Umd1c/w==
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
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1 04/11] selftests: forwarding: gre_multipath_nh_res.sh: add cleanup for SIGTERM sent by timeout
Date: Sat, 22 Jul 2023 02:36:03 +0200
Message-Id: <20230722003609.380549-4-mirsad.todorovac@alu.unizg.hr>
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

Fixes: 902280cacc036 ("selftests: forwarding: Add resilient multipath tunneling nexthop test")
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
---
 tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh b/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
index 088b65e64d66..83032c165c65 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
@@ -352,7 +352,7 @@ multipath_ipv6_l4()
 	multipath6_l4_test "Weighted MP 11:45" 11 45
 }
 
-trap cleanup EXIT
+trap cleanup INT TERM EXIT
 
 setup_prepare
 setup_wait
-- 
2.34.1


