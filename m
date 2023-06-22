Return-Path: <netdev+bounces-12882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035397394B0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 03:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CFC281811
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 01:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D8F17C8;
	Thu, 22 Jun 2023 01:34:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1786415DA
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:34:09 +0000 (UTC)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2BD1FC3
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 18:34:03 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id E988C24002F
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 03:34:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1687397641; bh=Qo7/utFY+AUkkN8SfWpvXJ8a9KR8TVuJ4Y5tbnHu3+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=nDlet/DGQtB076LH/Ikm3SyWNrgEvqu1HAGDpHrcTdRcJuBKduw6R59CfsoD0lWJ7
	 KRpMnwyfbEQkswUZtBgbjjP0ZwTxZ7io6D0gHeTb/EGiMFNXLvNkgpV2zVILzoUJ8X
	 cLZoTz4dua/vyfp7cs5k3tbYNXGY+CZkVx17/jrIPlAJ+7tm4czTWZrPJ1aHdMU91/
	 s20jeQKR/r+IEaezGpcZhA7XCz5e81OkAlsJacDh3hs3P4FIz3fZR9xlZFvsMp36x6
	 f90UzZ6qvD1d/nxgKPmsTG0dOkzZPhoRBSrAXuCDwcJFTUHH2NaMpUAdytA+V+xHu7
	 pKBx/d3UIkFnA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4QmjZV4L7Sz6twX;
	Thu, 22 Jun 2023 03:33:54 +0200 (CEST)
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kalle Valo <kvalo@kernel.org>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yueh-Shun Li <shamrocklee@posteo.net>
Subject: [PATCH 7/8] selftests: mptcp: connect: fix comment typo
Date: Thu, 22 Jun 2023 01:26:35 +0000
Message-Id: <20230622012627.15050-8-shamrocklee@posteo.net>
In-Reply-To: <20230622012627.15050-1-shamrocklee@posteo.net>
References: <20230622012627.15050-1-shamrocklee@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Spell "transmissions" properly.

Found by searching for keyword "tranm".

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 773dd770a567..13561e5bc0cd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -809,7 +809,7 @@ run_tests_disconnect()
 
 	cat $cin $cin $cin > "$cin".disconnect
 
-	# force do_transfer to cope with the multiple tranmissions
+	# force do_transfer to cope with the multiple transmissions
 	sin="$cin.disconnect"
 	cin="$cin.disconnect"
 	cin_disconnect="$old_cin"
-- 
2.38.1


