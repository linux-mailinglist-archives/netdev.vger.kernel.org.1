Return-Path: <netdev+bounces-18287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442497564CA
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00548280FBB
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 13:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A0BC127;
	Mon, 17 Jul 2023 13:21:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F189BA28
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 13:21:46 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BC9199
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:21:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso46376665e9.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600102; x=1692192102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMYqkxWIYu5KTvAokD8pnktzM+OKKPedMmVuaO0OtT4=;
        b=NRPbI6f+4ikR9vYJqGEukPb/oBjg3npV7TBn/SG/vMRQOtIjiX0Jjc8qsxTcRXGkaU
         0Kt1MiaMGKwka5J//6+FgMXDKQ0kq3wM9Y3NHTBTeKDVv8A00aZM/iQMLHTfXgSJbhYN
         IpDRqaLlYnY4Hn275XzxqIK7Q5o5TbUq17ooxjF4DEIgUqSGDo8ZN+AbmOuVCqLf9ZhL
         PNrwlytnl6EADP3i08E06rHqOEo0O4RjPonUoYDV0FWRpH9T2DrAY5GcLKhKuKJIrp41
         zkY/o6DwI1g3138KXhhSAzUM5Y5gEj/oL36wKY9F/KxJ3GurduHqie6PtG61eF1W38Es
         nnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600102; x=1692192102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMYqkxWIYu5KTvAokD8pnktzM+OKKPedMmVuaO0OtT4=;
        b=F64Ny9Hf/q2FE6qylDkgywaXWdD3Vb+xU4klUK9qErbFKHTHk8h6aF1qje2idWAGWd
         LkeXg8eWRRFgLWHLSk8AgEKnGilf7h/aOXp9aGlH/ZrKN/vXaqo+J3pI3JbeC3oUgHhX
         bj5642cc2ejbH92AzJ3mQ+5Qz+X9TnqvdXEEg+HoUG6Y0C8H7ygmr5D6QCUk3+wTaPKp
         WC2WqLEgJjUtb9lLxJSKYeQ4Y0nF7TO8yJtGCeHnGkkJQiVzLaKgYz+31GgrXlLyFfCy
         T+v+cghvFaeId5m8yv7k+8OCC0NGIafhS86dpxQxxURKZR/1iFiTFX1CIfrm1+hMbWSN
         Ps1Q==
X-Gm-Message-State: ABy/qLb7wjawh9RgWheSgqhXd1fy6OEvrQnRohSnRTV1dbBuMU2Vlroy
	m02gly9B+3aEFMPjBKS9t7+gAS7CmA3V4sDfGtFsIw==
X-Google-Smtp-Source: APBJJlGWXDewmTh2XPOoBWfj2m7agljI6siZePfZdGX5R1XjW4StXbCub27vjebnIBRek2PmFhBbrw==
X-Received: by 2002:adf:f746:0:b0:314:1e69:f4b3 with SMTP id z6-20020adff746000000b003141e69f4b3mr11103133wrp.63.1689600102234;
        Mon, 17 Jul 2023 06:21:42 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:42 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 17 Jul 2023 15:21:28 +0200
Subject: [PATCH net-next 08/13] selftests: mptcp: pm_netlink: format
 subtests results in TAP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-8-695127e0ad83@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2242;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=YF5+l2Jr0Lpa0HjBD3ZjYiqWlLs2/NctDcK1fgz7k/4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBd2OiEZ8xkjjR+HS2zL8y4EbaMpHDIxgrWe
 TaPAWqfPpKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 c2VkD/95ir2rvMg4n3iYaiyORQSKsIwGTjNKhBpO5RaKO3At8bKrW368AQgxbhZAMECTm8GlmNV
 lENKRCWlx+MyMn6BqLvsTDTE/nNYof3zDZWQWnWqp6SAI7T8A2M/GAnqBNEDB60vpv1ePttH14v
 ABojciSqKy3nutP5TmnAI6sa8YjNF5QTFt9HpCGQmSDBlafDTIqIWI2x17FgQhBG/uCIv5iUaJV
 h6zUM7x3yEz9TkAA9JwCiA6Zk6/OIJ6PD3RnmfVuZaUX4j10Jek0Apr1PQZ8YwsDv1pJB6oEeNm
 1ohiscbymwzXEVszRnEa1a055zvV0X8QW8h8Wz8XtM5yQq7eWV4Zw8SICnXKPMG8/uso3Zp+KWl
 qervoRArTG/zzntBHMo8t7ZYu7bS2MFbNBLoNcyljky4A63frK3lbOVAYSYDTd7cWH1irO+4eeS
 nxt4Js6qU/2b0LqZWl3pI9K8/jDYQUzahQjl0u4n+J+qlMP878PDvCqtyOHsoPwqskCZmgeXVnc
 iaTZb9F6XjZh7apR82t8xf5gPDRGs7MaJX6zJEcneuB26e2x1IchjcO8G/iKwTCp2oI1OSVhlVD
 X87JPyQHAo100VvK//B4NSfo/ncnskQ62LELx2r6dLWBFpyLNLOJ6KVa+xrUcMv21SEkVttZbLJ
 qXe6m9o+xA8Cruw==
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

This patch formats subtests results in TAP in pm_netlink.sh selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index d02e0d63a8f9..f32038fe1ee5 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -58,16 +58,19 @@ check()
 	local out=`$cmd 2>$err`
 	local cmd_ret=$?
 
-	printf "%-50s %s" "$msg"
+	printf "%-50s" "$msg"
 	if [ $cmd_ret -ne 0 ]; then
 		echo "[FAIL] command execution '$cmd' stderr "
 		cat $err
+		mptcp_lib_result_fail "${msg} # error ${cmd_ret}"
 		ret=1
 	elif [ "$out" = "$expected" ]; then
 		echo "[ OK ]"
+		mptcp_lib_result_pass "${msg}"
 	else
 		echo -n "[FAIL] "
 		echo "expected '$expected' got '$out'"
+		mptcp_lib_result_fail "${msg} # different output"
 		ret=1
 	fi
 }
@@ -193,4 +196,5 @@ subflow 10.0.1.1" "          (nofullmesh)"
 subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
 fi
 
+mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.40.1


