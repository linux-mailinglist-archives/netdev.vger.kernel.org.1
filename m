Return-Path: <netdev+bounces-20062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A2475D854
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894731C2185D
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 00:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51D636E;
	Sat, 22 Jul 2023 00:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B8B62B
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 00:37:26 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F0D3A9B;
	Fri, 21 Jul 2023 17:37:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 6F40060171;
	Sat, 22 Jul 2023 02:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1689986243; bh=TDT1v0dxZBetJ381eDhND50soCJEI+UHL2fqhwIyxGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TsXJjIPxljgrUOqt0aas8xuyQKXeDlFyGolY7UOuMhrBoE7g0DdA6BB/ij9coqH+i
	 dDYZ8znAm5rIzMSREkNoWT3KUtkjzRh8/0sM+RfDl4gTuUeyLyFKL+AovUrcRQjPox
	 /YotyadJJ7yjhhV7MtR1TE+3ExDKV8QV6/8oYaZQCK/3IJFHaPyFBN1/sRazTda3wt
	 lvWb8G/2eOpjZFNkv8jE2yrn57zylUNym2PK2ynCH3kNSYN9YMV1oM29QTq9rpdrD0
	 XCNhqyd817JrqPZux90hZN1Kae/IODn17RFzGsIbnIhEHHtZEU5FoK0sPY+WdcB9Tw
	 BxKsv57xDQl4w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G4Jy_5ef4K22; Sat, 22 Jul 2023 02:37:21 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
	by domac.alu.hr (Postfix) with ESMTPSA id 4F9756017E;
	Sat, 22 Jul 2023 02:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1689986239; bh=TDT1v0dxZBetJ381eDhND50soCJEI+UHL2fqhwIyxGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qG6r7ZJA2BEs1rcQe6qLyW+h7b7ynKRJVjn2+uk3DRDUZy2tbrYaFbFztJDPAingx
	 gXsvIFBO84y29yAlKyEY3i9PMZcTzaoNbsSZs69X6giGE3J1Wo936O8dtJcxRDiDIY
	 CyD0rRUZhv496mPu0h4Ylf7vpm6qG9yoYTCUOrAh93aGJaxfZzOYfUvfdpKLIoFVXH
	 51vIPFVnzVevwL2UaUFraeVIk/wsC7qraLC598XGvL/OB5nBXLE4bcFpOELAqQ1WSK
	 kCVE+JIX6xBYH+uyDAeolMK0w+wzCh8VmqUr2Fpspl3vYwU03isSr3DKvA0NKhNl6b
	 dQAPES9UOCVxg==
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
Subject: [PATCH v1 06/11] selftests: forwarding: ip6gre_custom_multipath_hash.sh: add cleanup for SIGTERM sent by timeout
Date: Sat, 22 Jul 2023 02:36:05 +0200
Message-Id: <20230722003609.380549-6-mirsad.todorovac@alu.unizg.hr>
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

Fixes: b7715acba4d3d ("selftests: forwarding: Add test for custom multipath hash with IPv6 GRE")
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
---
 .../selftests/net/forwarding/ip6gre_custom_multipath_hash.sh    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
index d40183b4eccc..ea6270ec7478 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
@@ -457,7 +457,7 @@ custom_hash()
 	sysctl_restore net.ipv6.fib_multipath_hash_policy
 }
 
-trap cleanup EXIT
+trap cleanup INT TERM EXIT
 
 setup_prepare
 setup_wait
-- 
2.34.1


