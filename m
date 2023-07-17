Return-Path: <netdev+bounces-18283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47BE7564A9
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88DB1C20916
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114FFBE4B;
	Mon, 17 Jul 2023 13:21:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06941BA24
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 13:21:44 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF7EC7
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:21:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso47270135e9.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600099; x=1692192099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgCRwe/aMLADqB9Zcz9fBB5yZM5sFyh9DEldcukmYmo=;
        b=jd+Cex5nHtocq0KU/b4wrGY3R6Pw8s2028bz/c1x3z0ay2vLZx+wIyfD98ztwTPplL
         h88gw9ffPzoDenGjgwtvnTcFZ3N29WnsFrMWBnU73lwgofY45Cgz9BC4iZ4a/g4iSi4t
         G5oqDscwZH8cx3A+1oTtZh99s96jq+mYJTGmnLgKDs8wTl9kWTQ/MvImI4JeGSYxjWRN
         9BNpbWX/d4QqGWIcGzGkrKiNka6An8h9CVAP3zOLVAkn1//1YTHmznMN93p8XtMZOY/p
         HEz0aUoN3WZcAwuX5bISxfs3HFXzoy1+WyFj2IAXsPaXA+aadmAF+nc/VZkXN8hb8UFD
         1dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600099; x=1692192099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgCRwe/aMLADqB9Zcz9fBB5yZM5sFyh9DEldcukmYmo=;
        b=WPzQS2EdnKaq/NtpZt+MIOEnxUA1Fid3yITSLthJs/GpVZtWwHkmVaCtOITIe5tYE9
         c21a0tsc66bU3yCKWmB+M77lp4F0fIScKxb7krw5NF/Nx979SJbY2W+D18IdODcj8U5a
         me6lzAJbCMXMSSf8yIuT9U7JJENTS97Oa5qXyEYgcNCVTgsnOUCTW7OzBCJOe6brBCfV
         wSkL91CcGbkNpMTawzuxwGIVl3haxEq4Ia+1BfCCnCmWZdrVm8dyl8ngotAPiREo/AQY
         oMai6qkDp6ewBa6pH2T0As/2v6jos2GPtojeR56EIq3v4+zBxFPYFJRmFKm21+WHTtoP
         oHug==
X-Gm-Message-State: ABy/qLbsfWT5bVpOypUN3wIw6oui1dOkfzh7urYAxr82LHQPlAAxp8r4
	5mbPLRkhQRdV6x2qBufnZYSybmPePvXy7QKO43b0Dw==
X-Google-Smtp-Source: APBJJlG2vmAPP4DlhcZhqmL+Z8QRHal4MZz8TTpG/CYsXAmIe4ZglDarAT2R5YRbCngAXoDbZupsnw==
X-Received: by 2002:a7b:c451:0:b0:3fb:ef86:e2e with SMTP id l17-20020a7bc451000000b003fbef860e2emr10188694wmi.19.1689600099504;
        Mon, 17 Jul 2023 06:21:39 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:39 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 17 Jul 2023 15:21:25 +0200
Subject: [PATCH net-next 05/13] selftests: mptcp: userspace_pm: reduce dup
 code around printf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-5-695127e0ad83@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=p5++Rak+cK4tA/cugYjcwaWOIkpGzEvf/nU/c+ap5fo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBd1rDIbZjMBVE1XO2137zJfkHCjI2ZkM4uT
 tEfLR5GPAWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 cxlxD/4n43jKCiIuunRJHRw5x0V1Yi5E6FEhyuz0fK9nt1GfwwDfGHkiSdojoOpHrPK7gp1D8gv
 2SzPQgUbjk4zy04jICHtevJ31jPxktZcvHowtXnVbiVx09LyFu5gimofuOlM+9qTTxvFn/dAorS
 CEXIKV/fEP/j/bWU88NB8H7AyvWu/yg8daUg7bSSfpBS0inovt1PnJDXeYUXj0zKIS7w9FjpTYO
 L//KX/jR1pIXZ3mAHa0UQeb6BbBb+3CGY3wVTDdn1lNuCTeUpTZX+mIRdA7vU8TBT0B1TQSrIh1
 jOtRJuqYOTovM/VpIcCRlSwvXjuViUqRsqOA0FlnxUZH5KuMlz+tb96YzmEzKfKG/wgB7481tLn
 deCjaONrzhC+SWv/rrBNxZPfZvAmtJSrh58jpnjq6EbmgXLIB+02d3mY2JBV8UmlBIZAEjeWVz5
 /AAs82a5SX/gRhswbcuYT+ABxoBghQmUT6xY+ZGJ0f/zvMGsG8hfX/6BhHrSHttHWiYDYf+U/ON
 lWyoWVyZOaS7cbgFsEvm7Quw05wNe8wWfTbJcgBY9N2/oY4FK6PfG0g9e5JKNp/1mGNLT7uoH5G
 cvbuEFjrBkh+ERHKu0/KXgJL2CKUqgA2coq98EDM5+/H/LKMd4qGwSao+/iZWenXqnL+/sngD85
 L2uJwJqqENXjUXw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In this selftest, "printf" is always used with "stdbuf".

With a new helper, it is possible to call "stdbuf" only from one place.
This makes the code a bit clearer to read.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6b733b97d358..568ddee1d102 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -59,21 +59,24 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 ret=0
+_printf() {
+	stdbuf -o0 -e0 printf "${@}"
+}
 
 print_title()
 {
-	stdbuf -o0 -e0 printf "INFO: %s\n" "${1}"
+	_printf "INFO: %s\n" "${1}"
 }
 
 # $1: test name
 print_test()
 {
-	stdbuf -o0 -e0 printf "%-63s" "${1}"
+	_printf "%-63s" "${1}"
 }
 
 print_results()
 {
-	stdbuf -o0 -e0 printf "[%s]\n" "${1}"
+	_printf "[%s]\n" "${1}"
 }
 
 test_pass()
@@ -93,7 +96,7 @@ test_fail()
 	ret=1
 
 	if [ -n "${1}" ]; then
-		stdbuf -o0 -e0 printf "\t%s\n" "${1}"
+		_printf "\t%s\n" "${1}"
 	fi
 }
 
@@ -127,7 +130,7 @@ cleanup()
 
 	rm -rf $file $client_evts $server_evts
 
-	stdbuf -o0 -e0 printf "Done\n"
+	_printf "Done\n"
 }
 
 trap cleanup EXIT
@@ -288,7 +291,7 @@ check_expected_one()
 		test_fail
 	fi
 
-	stdbuf -o0 -e0 printf "\tExpected value for '%s': '%s', got '%s'.\n" \
+	_printf "\tExpected value for '%s': '%s', got '%s'.\n" \
 		"${var}" "${!exp}" "${!var}"
 	return 1
 }

-- 
2.40.1


