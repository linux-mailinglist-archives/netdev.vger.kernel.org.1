Return-Path: <netdev+bounces-15438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63916747941
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 22:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B971C20B2F
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 20:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B398F62;
	Tue,  4 Jul 2023 20:45:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9D8C01
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 20:45:02 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C305110F2
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 13:45:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso61097445e9.3
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688503499; x=1691095499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tR0k2iTRIzKE81HT+bkzTA31whTNvrU0QAZxxbGhfzQ=;
        b=15xi3swQPtclF0IVzxdU8DYymWPRw3YydN103FbbI3bKcLpQcK2gcodSj0ldJpoz/x
         CTdlJMITHhKF7d2wPIvy4E5tUNq3gLHaOiF/PpW5vVW4BkH3RcLSYUPoTazBEQaiMmYk
         gqkw+t+HqHeq9ggZ/jlv7ynnl3KdzGGgJqNChq6MhEIfsLPFFYxOFgPBvjZotsB5brMe
         S4FNLjdvY2vhtltbCGkI/KVQ+KQFWZIZ+yQd+armmcUHnmuBnjm11yz8frWFwxpIWgGV
         wPLY8O8gfm3mN51aOTy9IMpPQAmTDgw5jiNWSqXeURFtnRFJkLaDJFPcAQw3WhMiZBk+
         cozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688503499; x=1691095499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tR0k2iTRIzKE81HT+bkzTA31whTNvrU0QAZxxbGhfzQ=;
        b=akaLwhRI5ftAHci4prshbJxogZh2KW7DWt/TtCVmVgvjRSnDmSUZYJwMxJKiu7R/Kx
         E5NY4Uyjll0FLvAig8fPjfBnAktqE7OmOxITxHS0+5cCzqaT3gsEHI8YMNZM2V8Q8Ygm
         vUwtuiIJ+V6D/RJqPDFuQOu2qTgduy1cJIaA2ZwUXGTsgJ+bcDwCvse7qBA2R4prucwo
         /7HYRj+c5UmV8pUrBkbCjyXEqJBmzVq3sGXZKIruDTyacgyoWyqliS0PpISYLHuetWOW
         TLgYUZWA7+kGTpb+A/Yoa44fa9U1Af1rP2xPQ+ogOKH9b0O05U9ay52CKsGIgmTlvANM
         NptQ==
X-Gm-Message-State: AC+VfDy6tBNiY7LMowH3jQRyKmYnX1tQITdoRpJ78XlnvVrNloj/u9Ja
	AFy67ApwfeEKO14pZBm76oBc8NwjbZpV1+t3p2jdlg==
X-Google-Smtp-Source: ACHHUZ59IpqYXAyE8vX2lHvJFL3Mw4BiAVly33DI6yAZa2yA36XC81B5VyWVoEqSSUmlk3V86vUNFA==
X-Received: by 2002:a7b:c3cc:0:b0:3fb:4041:fef5 with SMTP id t12-20020a7bc3cc000000b003fb4041fef5mr12204935wmj.23.1688503499207;
        Tue, 04 Jul 2023 13:44:59 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003fa74bff02asm115332wmq.26.2023.07.04.13.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:44:59 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 04 Jul 2023 22:44:39 +0200
Subject: [PATCH net 7/9] selftests: mptcp: userspace_pm: report errors with
 'remove' tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-7-d7e67c274ca5@tessares.net>
References: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
In-Reply-To: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=WaDwtJkFZncOrJ2Iiu1Uelir58gdeQmDpJzveP7xvKw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpITDlegwxopJyC/HHSHjFuoe7Cn6retGpX9Th
 7hdiQt7nu2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKSEwwAKCRD2t4JPQmmg
 c53ZEADBQX7KvGpR+S63LrwbAUDDK876lVnsGeEJf2gJSXKhvZYB4lyqMPhcY7y4wmqPQ9WQgkA
 7KnJqq9DmENCzBrGObF6JX/gbH9ggBVUl/uG2JieVnF1cMKq/YPoMkvQJGSRW/X7IR8/1lhgvAO
 wCYFdhU3QL9aw2ZP4qAtCqSsBndxxIA6T+JAaMWU0pmbb9X/8eJ9QlOWKvpxrJpBhbraErR5jLS
 nFLYU60Ce9yjBytCESDBet3aSr6zg2YEO0UKvPFWifSAB1ykEokjbkuOFKA8clMoDwqaOKOw9Zz
 tCynaBjZA42puB+DV8qSsbGy5yBqrYX09BHPQt9xzpY7wc5wbihA0eVdDKj16C6F4LOoVMNpViA
 F+ZsS3h+OQCv3wQUFTQs+gSGttC7F1RHIz0hkk6szf/11W9B4xgaN4AdjR9UxDlDUtkiTPz7AL/
 ex995RoCtwXvZSYE6bsxn+nFiIRGdbJnmupeP889l9TjqrrsuXRZMin9XJHrxvH2lkBPxmV6sjn
 X7/mCjrHNLfdTbgGuSw+kE+XNAlooJIdICVYcY3WDp6nvUJQSknFQ2Afk3tJNd0Cc7vrnsH+2JX
 sg99XmkddSpLyzvcy3aBzG7NJbBJmETb1b4/ZaiIW52HuSe2MwAmHarYhScEYvnguaCwxumqw18
 U5yH0uO1OVZYITA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A message was mentioning an issue with the "remove" tests but the
selftest was not marked as failed.

Directly exit with an error like it is done everywhere else in this
selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 841a67a7d524..b180133a30af 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -423,6 +423,7 @@ test_remove()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n"
+		exit 1
 	fi
 
 	# RM_ADDR using an invalid addr id should result in no action
@@ -437,6 +438,7 @@ test_remove()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n"
+		exit 1
 	fi
 
 	# RM_ADDR from the client to server machine

-- 
2.40.1


