Return-Path: <netdev+bounces-18289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C02517564CE
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB75A1C20949
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 13:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B90C13F;
	Mon, 17 Jul 2023 13:21:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D56C13D
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 13:21:48 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4291993
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:21:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-314313f127fso4267570f8f.1
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600104; x=1692192104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBOqH44Vz4R+VcpMvI7khUyXQTww1r694G16N8Cq238=;
        b=sUY5WVmByVVpYN5Bor9mcnHVbvxaNOnkv7BRXRX+CZnJaXaSy+BKpmbQCIHqQwukxk
         nMKm4FB/4RypxGUzqeNM+hRzYbCmKkszed5mRsBPBtQd/PxYsJCWFxGzsxXF3Lt1TcnG
         TrIDu3CovERBy/ZZ0ClicBzRkBM0vRVkLOnmuAjo3rZySJqCdn/aFDL6xq+NpXlsHrU3
         Dx7EGvUmU4D3oFOukSAiM6/7fWAJZl/CWd7P50M/ZTDMTanW9Jfw7q6pQohzejt4mGYv
         PSMVA1wGYrKZQrvA35RHZ6LcwrX8c7n/BJltIxgdFoGoPtcQJarJPCd0gOgptQeZkFSl
         CpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600104; x=1692192104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBOqH44Vz4R+VcpMvI7khUyXQTww1r694G16N8Cq238=;
        b=OthkFjOchUQEEqk1pp8xRjTmmDdTrja3FC29dcVzp3WRVxTFJTnsL2d5Sas7w3tidq
         aWKKl4fhDSQtHR/8i+ZdRAKpmh3kiAtVaFqVbAcA5s7MOKJri8zhKCy7yoo3Qxhenbib
         xw9yHPdsgzprl5IOAt7YnoILezEjnvK5saRVXTpqwuUqap3UyMbUmI/M2w1IjwLhgBwF
         qIhXqGM08QQlpWKmsnNpJSnwAfxVx2DNo/t9sAf0bOBLSxdhM4m4U6gmqw4V7IXDacGa
         96YjegCZol4VWBgtHWYiBLRqH+U4Y0L+9mElwcrXaMvujbboIfQ4Tyu9uCPUrsRjWzIC
         h1Uw==
X-Gm-Message-State: ABy/qLbLqHGY+wC2Q+UkPham96MefTL8SjhjlIv8yFvRTupw23yVzXA8
	vd8ovPsRULLOQ9rORs2Vxu8L5EaLnnx+p4R1L7bI5g==
X-Google-Smtp-Source: APBJJlHFvIl2bGE22utOGrNAY+DBENOz3VfdMSQ2pPhkpL/vhT4cjaugwz1aUqRITvRFTiNEDFnv/Q==
X-Received: by 2002:a5d:4090:0:b0:314:16db:537d with SMTP id o16-20020a5d4090000000b0031416db537dmr9496395wrp.2.1689600104038;
        Mon, 17 Jul 2023 06:21:44 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:43 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 17 Jul 2023 15:21:30 +0200
Subject: [PATCH net-next 10/13] selftests: mptcp: diag: format subtests
 results in TAP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-10-695127e0ad83@tessares.net>
References: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
In-Reply-To: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2543;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=/X8yB/Q/5H0ck3AYzdwQCCKzR1Ceke12Ddz4qww4J1I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBdzgBG7tpd6VcdACIJrZ2iQEKTlQl3ern2Z
 WB8oKksKOmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 cxDyEACC6/KvRWepq+/zSNBHHv8PQkU6bD/VTAjqvH8N81+mXe2C5HmaNV/G5xe9vVkjZJC+Ng3
 8ld3zbeSIYR4zPHnp9Cwt4p/tBO7nAfRoIFrfawl6X4qjGx53a5aUv66+UKiYQS6ahYmeldd0hS
 O1Px9HEoe79lAUdRg3JClU5LFbvT7N94Buk/58BoZaA7ac78/uxxg0iBSfVLVn9qGQKax2bjVoO
 jlyAWFXCr3BSHAOFAMg7c5ma/cSJfdms07Ix5RkS6USVXIUBvvT38lE0T5dcMKzCA+GhFoiTUX1
 C3qGVcS07t6M44SHYDtx63Wz6ZkAJ++In7mNNzHnHFxz0Iyb2kG6fjzZTyCaz25d62oG9Zs+Z/E
 0ZnxPgHbJfF1hjHX0Z+HAujBMcYo5GZIHWr0UcHEwoy2Du+OfCHB18rHBF0SRYnGtIpaOk2e4t4
 2N/xrAGAt25ImimG/ZjWz11XZiTc4ErOtgL2lHYq/3YDq9YeT6LwzZOdodi7UEwcdjPEysFXELP
 quxJV3PmT/v/E8cbES1s/8waz7U/HlJqpaUu6jd5UsdBIG5u8IotRftT+ZsHZrbBTW4R9iDDsGf
 cVAr7r6ZO6oBcaD05G9c1slSF9A3H5KjCMbETtcDbpRF7f1PQjPDmz0MeBhpVCRasZMNEvgMWwa
 pzcrtGFXiktjEDw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The current selftests infrastructure formats the results in TAP 13. This
version doesn't support subtests and only the end result of each
selftest is taken into account. It means that a single issue in a
subtest of a selftest containing multiple subtests forces the whole
selftest to be marked as failed. It also means that subtests results are
not tracked by CIs executing selftests.

MPTCP selftests run hundreds of various subtests. It is then important
to track each of them and not one result per selftest.

It is particularly interesting to do that when validating stable kernels
with the last version of the test suite: tests might fail because a
feature is not supported but the test didn't skip that part. In this
case, if subtests are not tracked, the whole selftest will be marked as
failed making the other subtests useless because their results are
ignored.

This patch formats subtests results in TAP in diag.sh selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index fa9e09ad97d9..85a8ee9395b3 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -65,12 +65,15 @@ __chk_nr()
 	if [ $nr != $expected ]; then
 		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
 			echo "[ skip ] Feature probably not supported"
+			mptcp_lib_result_skip "${msg}"
 		else
 			echo "[ fail ] expected $expected found $nr"
+			mptcp_lib_result_fail "${msg}"
 			ret=$test_cnt
 		fi
 	else
 		echo "[  ok  ]"
+		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
 }
@@ -111,12 +114,15 @@ wait_msk_nr()
 	printf "%-50s" "$msg"
 	if [ $i -ge $timeout ]; then
 		echo "[ fail ] timeout while expecting $expected max $max last $nr"
+		mptcp_lib_result_fail "${msg} # timeout"
 		ret=$test_cnt
 	elif [ $nr != $expected ]; then
 		echo "[ fail ] expected $expected found $nr"
+		mptcp_lib_result_fail "${msg} # unexpected result"
 		ret=$test_cnt
 	else
 		echo "[  ok  ]"
+		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
 }
@@ -276,4 +282,5 @@ flush_pids
 
 chk_msk_inuse 0 "....chk 0 msk in use after flush"
 
+mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.40.1


