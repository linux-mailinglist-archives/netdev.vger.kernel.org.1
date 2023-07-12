Return-Path: <netdev+bounces-17224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 738CB750D6D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9779D1C21016
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E7221500;
	Wed, 12 Jul 2023 16:03:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB0214FE
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:03:31 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA201BEC
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:03:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so79762725e9.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689177808; x=1691769808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YkaSkbg1hj7zqdIEy25ren99Ahk0q9+Tgw9lEzP9lo8=;
        b=B/JnRNFZkPvmYIdrxaB+EY9/V3oHuNOtdmeDLi9tEmtTDUSRTx9pefe7v3PNl+UkVx
         i2raTidHLHWb3HHoHBmYpu9DbzQPUdH6ayA0QIwpxGh2RWVqk/lh7Vmv792L0IiCjP94
         ecGqMpcejL46kdyPdxIH0n8v991/xkmxU0r0I35R+azGLQDyX4EcWC6DlfCM3bv5rmKz
         CxwkGw/VfIh5aPUkSNW1B4s1tbV4E9efBq/DnTnXfebJDUnQwiywQmWeS6oNYr7gE75H
         jEH/rqTvEmhivuEGQySlukN8PVKuvTkLv1s0ruT0MTH5JLTYCK+9ptG8Q42ekNbvCDPd
         MeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689177808; x=1691769808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkaSkbg1hj7zqdIEy25ren99Ahk0q9+Tgw9lEzP9lo8=;
        b=FECDrZnWM5kyBmeusNMJeq1HiyfnFZap2G9x3zkoovKwnaEktTbebx6f6LVSHahmfb
         Z1DCphRRJnDB/PtIuuBEHV3rkzi9MEXD/+FXiV9KCRltnKuMkByPliY+L2JfZbKQhegJ
         pLrhNKw0VzN5can8aEqbWbF26aGz/smKl/Pq92F6iZVMUH/TXzMcP5Dse+/Ao+XueMrk
         VMFrzbQhbhwwpYC4ZyE7OzlF3Iob9C77aTnrZ4iA37wQ9TbKys1lGKmuDkusnQfUFmKE
         oZ+vGiNCfiTkEcQeDtqBfj7NP5VvoJxTrtOeud43D2QQGbB/wOsdT1322z7BguiGFP6g
         Xs1Q==
X-Gm-Message-State: ABy/qLbuhZOtYPIe0itDpitB3peFcu3pRUOEnhqZ66VrEdeFMPgRH7J4
	JMrbjFCrYdffvcIY6lcKShzRCA==
X-Google-Smtp-Source: APBJJlHWObV3Y4B+PFR9B9YnoxQXzqf6JH2+g53jCkQDKCalLO8q53q17xxbkojPPip/5EU1+iWpEA==
X-Received: by 2002:a1c:f706:0:b0:3fb:b637:22a7 with SMTP id v6-20020a1cf706000000b003fbb63722a7mr20401987wmh.4.1689177807717;
        Wed, 12 Jul 2023 09:03:27 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b003fbb9339b29sm15972581wmr.42.2023.07.12.09.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 09:03:27 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 12 Jul 2023 18:03:16 +0200
Subject: [PATCH net-next 1/4] selftests: mptcp: set all env vars as local
 ones
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-upstream-net-next-20230712-selftests-mptcp-use-local-env-v1-1-f1c8b62fbf95@tessares.net>
References: <20230712-upstream-net-next-20230712-selftests-mptcp-use-local-env-v1-0-f1c8b62fbf95@tessares.net>
In-Reply-To: <20230712-upstream-net-next-20230712-selftests-mptcp-use-local-env-v1-0-f1c8b62fbf95@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <geliang.tang@suse.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=Giom2KcA4rMDsRQaqzRL7L0ciHAM8FES0ASumSNjEII=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkrs7NfKP2BTFBzVZodXxBjqEvsLpgFYb6dQ+Ys
 6pCxH1Fm7KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZK7OzQAKCRD2t4JPQmmg
 c71WEADAmsB+mm1iB3CpKf8c7tcm9ZhppYpf+iHLo9QvuDGC2wriRvnuErCl8euzoqq+c6tBYxz
 Pm9EOcu97ZKbUdnXwgZuCxJo2j58sVt0Nuan6+/1COMrncKFLceP3cFr53ZEaxOpnNaSIWgi7uJ
 ldDQjSpZzt4TZplxeH5RxOJsuuHX+zPeqxDrIAaFN/3NGWqZXsUqHIsS5by6cfGjjJPmizK7V3y
 kcybWPkx5ipyojMJE00rO8FlBnH/GK5w2GDMHiNjS8Agkbm/+MvUD587QYgfiztyMchnglWg4hr
 IXNNX8OfNU+s7pevJlaWSlnHfLUHwZJX0dqeO8fIp1/u+hiNplUDegT4PTmErJ5c6TpQGyl62yj
 hFBCQZYhPngNEYYGx2QpUtbYrRaXDwKWi91josmZnTOgENXVbu1EZDkKeLIXwI5d/+ifqFnrRz3
 u0G6unM0CSeIFTPO1i8QWYmw2pwk7kpE4AL25BUwAzSpx8NyBqEB/9LIUeC3jEfMY/DPyTCiJc2
 572YaE9x+XONCjvKYaTZBT1FuytunJxwlt1xsxYumjc+mO31hUnRPNuzVsmhymL0PLzpcJdKucP
 WXrndsShO8/zw+jFkyQGlfyxd1BiKn0fM6QkKiSelQ5KYwWEXMgfCkkC3no7TovOUgt3a7SnE0T
 6g2lsy1JxCKdFRw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Geliang Tang <geliang.tang@suse.com>

It would be better to move the declaration of all the env variables to
do_transfer(), run_tests(), or pm_nl_set_endpoint() as local variables,
instead of exporting them globally at the beginning of the file.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e6c9d5451c5b..b0aaeead56c4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -49,11 +49,12 @@ TEST_COUNT=0
 TEST_NAME=""
 nr_blank=40
 
-export FAILING_LINKS=""
-export test_linkfail=0
-export addr_nr_ns1=0
-export addr_nr_ns2=0
-export sflags=""
+# These var are used only in some tests, make sure they are not already set
+unset FAILING_LINKS
+unset test_linkfail
+unset addr_nr_ns1
+unset addr_nr_ns2
+unset sflags
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -100,7 +101,6 @@ init_partial()
 	stats_dumped=0
 	check_invert=0
 	validate_checksum=$checksum
-	FAILING_LINKS=""
 
 	#  ns1         ns2
 	# ns1eth1    ns2eth1
@@ -828,6 +828,10 @@ pm_nl_set_endpoint()
 	local connector_ns="$2"
 	local connect_addr="$3"
 
+	local addr_nr_ns1=${addr_nr_ns1:-0}
+	local addr_nr_ns2=${addr_nr_ns2:-0}
+	local sflags=${sflags:-""}
+
 	# let the mptcp subflow be established in background before
 	# do endpoint manipulation
 	if [ $addr_nr_ns1 != "0" ] || [ $addr_nr_ns2 != "0" ]; then
@@ -979,6 +983,7 @@ do_transfer()
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
+	local FAILING_LINKS=${FAILING_LINKS:-""}
 
 	:> "$cout"
 	:> "$sout"
@@ -1158,6 +1163,7 @@ run_tests()
 	local speed="${4:-fast}"
 
 	local size
+	local test_linkfail=${test_linkfail:-0}
 
 	# The values above 2 are reused to make test files
 	# with the given sizes (KB)

-- 
2.40.1


