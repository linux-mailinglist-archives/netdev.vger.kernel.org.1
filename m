Return-Path: <netdev+bounces-20063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B26075D855
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4422D280F33
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 00:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B7064E;
	Sat, 22 Jul 2023 00:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BBC64D
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 00:37:26 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A046A3A92;
	Fri, 21 Jul 2023 17:37:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 5D9066016E;
	Sat, 22 Jul 2023 02:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1689986243; bh=7W3ynW0vvotn+/mE5zS4UF/4GcS0BEQbaUjU76Bkz1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b5gOO2Q9p7k87Wp9EEjtvpQQWxYc0wAjuibY4frrWvHjvG1UCZTJ7EFBEDrz2RxXI
	 S9i2ZkUmaSkdeNcCr6iiCBvoSmT01WadWGy/RyjLTHyyGWdB9eqHZZT2jbk6s20dO+
	 7enGMFNyktcGKpyUiNqjIW8UbtDbQr3NVRQoeoMs3Vtbh5j/XpaAVfWTjd2P0jwAuv
	 p5NrWFWEEofjZQvkEkJTkOyxr8l2pnG+ax5Lt90bvgJ/1Li1AWb8MKxlHZGPnSPSdD
	 AZeYnGfbUJ9N1Xtsh6z2ZhSCLCxvpekChqJdXwyuHMNfP3rrREzn4x83xN0i7i6rsb
	 pWHFmrfbcAyDQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 64sfHafPNM-S; Sat, 22 Jul 2023 02:37:21 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
	by domac.alu.hr (Postfix) with ESMTPSA id 42FD660177;
	Sat, 22 Jul 2023 02:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1689986239; bh=7W3ynW0vvotn+/mE5zS4UF/4GcS0BEQbaUjU76Bkz1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOy9XdPhdOHptX5peyzm3KrhunrfImNtT4XOenc1nyLGcd/AhGbHl4JROIiSLtOT+
	 nyYt0KoiK6ZM0ZbuQNGSX3qVi2rfoHWDQb5ykDgcdgMB+oz5AXhacAdfif/P618tHJ
	 FYIDLfowL6Wz+mlLLnj/6zKjCAPM0vF7LiHh46Oj3zF5NzCTDJtTQHF4aAEBnK4c2w
	 SrgS1O2mWBVUwBz4q6imxQmCvyOlb9vYS+cHetVLpVDLd7UpTtOZFnt0aG4z2cirDW
	 53L8kNpGYtr5aIksBtypO4urBA+NwXJXsP/yWARWlTjpqkfoPYThcjxWEzTjVVyLFX
	 rTBuq0GBNWJiw==
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
Subject: [PATCH v1 05/11] selftests: forwarding: gre_multipath_nh.sh: add cleanup for SIGTERM sent by timeout
Date: Sat, 22 Jul 2023 02:36:04 +0200
Message-Id: <20230722003609.380549-5-mirsad.todorovac@alu.unizg.hr>
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

Fixes: e035146d65603 ("selftests: forwarding: Add multipath tunneling nexthop test")
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
---
 tools/testing/selftests/net/forwarding/gre_multipath_nh.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh b/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
index d03aa2cab9fd..8338b8693387 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
@@ -347,7 +347,7 @@ multipath_ipv6_l4()
 	multipath6_l4_test "Weighted MP 11:45" 11 45
 }
 
-trap cleanup EXIT
+trap cleanup INT TERM EXIT
 
 setup_prepare
 setup_wait
-- 
2.34.1


