Return-Path: <netdev+bounces-20061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C4B75D851
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C361C21869
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 00:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ED562D;
	Sat, 22 Jul 2023 00:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D062B
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 00:37:26 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F245E35AC;
	Fri, 21 Jul 2023 17:37:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 461976018D;
	Sat, 22 Jul 2023 02:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1689986241; bh=GyTx+in0QuEFu64I6/v5X/cdAZdpOWmLIok82+GgJl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m57OF3cEwRXSUI+sZv3oBxK91/5ZhUthMvF/Jujj5s4mKzjmIweTiIcgoBcfRkdsL
	 ooFcUlVsWOltfOp9Y+d3Kg6++guHNP8N2KZcNGa9C/jAGwb8tYFsGRLEhtkI4eb1WA
	 V+pZ40ceSK6fu62R24iVN7wwQDymQDimeNTA5KyWEd50PPgyfJXckTA1qr1mx7a9kb
	 6r5YiA9Dsnet9UiBZT+Oc1Dx1Vh+5G23OQHVTnM41IppZdMAq5jqJn1yD6xVGLHrxm
	 CAIq2RWeUowD682IZ2v7ulBpXzxrDUuLtfsI0mp37Zy426xEr0cS7O0ZRvO23m2lEd
	 YKzs6ADinwjTw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id plxVHBFTzZ2k; Sat, 22 Jul 2023 02:37:19 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
	by domac.alu.hr (Postfix) with ESMTPSA id 246816015F;
	Sat, 22 Jul 2023 02:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1689986239; bh=GyTx+in0QuEFu64I6/v5X/cdAZdpOWmLIok82+GgJl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yOcoyZ5LT17jGebiILXBb4YY/in8ro87VP97TSC7RjcJfn6GIkQ82e1V7ZtVBvL+Y
	 DohthD1Rh2+inXFdmA/3sk+hRu++i1ONjVurkltvmsZYkn1vz+6Ofk64E2WsTDP2v2
	 uFX7zQNOIwcRuQvzygfECoXt3EbQpP2gopSPURlevv/R9YvktPSi2mVimpo7DScKNF
	 MpktvnmOoRF/jvWWBke0SKM6ASpiSNJ+SDN77sYbNiH6ll9iXYNKf3RHWp9fOOYCl6
	 iTJFm130YbV6NeQ2Tvq4seFgRA+Jxt2KjkZTVWOQmW0v9awjZ8ywLvDvyck186oZTv
	 FVAT8Gi84s1ug==
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
	Stephen Suryaputra <ssuryaextr@gmail.com>
Subject: [PATCH v1 03/11] selftests: forwarding: gre_inner_v4_multipath.sh: add cleanup for SIGTERM sent by timeout
Date: Sat, 22 Jul 2023 02:36:02 +0200
Message-Id: <20230722003609.380549-3-mirsad.todorovac@alu.unizg.hr>
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

Fixes: 2800f2485417a ("selftests: forwarding: Test multipath hashing on inner IP pkts for GRE tunnel")
Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
---
 .../testing/selftests/net/forwarding/gre_inner_v4_multipath.sh  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/gre_inner_v4_multipath.sh b/tools/testing/selftests/net/forwarding/gre_inner_v4_multipath.sh
index e4009f658003..3b2941b9e89b 100755
--- a/tools/testing/selftests/net/forwarding/gre_inner_v4_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/gre_inner_v4_multipath.sh
@@ -296,7 +296,7 @@ multipath_ipv4()
 	multipath4_test "Weighted MP 11:45" 11 45
 }
 
-trap cleanup EXIT
+trap cleanup INT TERM EXIT
 
 setup_prepare
 setup_wait
-- 
2.34.1


