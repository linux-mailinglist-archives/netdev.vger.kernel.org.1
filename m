Return-Path: <netdev+bounces-24142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA94A76EF6F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F3D1C215B3
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A68C24199;
	Thu,  3 Aug 2023 16:27:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FDA24196
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 16:27:55 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9233AA4
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:27:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-317c1845a07so872011f8f.2
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691080070; x=1691684870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwyK6Bv+hcPMKxglSicH9Zo5rWGFycFOmRoBBrYBtwk=;
        b=nVf5cpBl66aqIXNE9mp7PBpSn04vjQNBytFglp9n2PJUdgGvMIzyOBlFIDx55z2c6l
         UosZjIiqUTd4VJvFp+uC+8TkKxdQsrmyBnxTKHR+YVA2qKslZbbVBxVitvUFvAFWowm0
         kegzR5vljiqloxiO08YNKk4DDnaKhbm0uhF5+fbUMrP0o/kXkMyqz9Ubv21Bb5RXAC5H
         cuw2D6wv/55bIM/wJZmktecljrhqnM0S3DPU51xaFTkEAP90FnPfPqbX+FwVmU1Z0DfP
         OcQ0xEXjVkZzzNIdbonGT+WId15gota3ge8Trxl9yR0k7FitTMA8eph3JqeJx7SAOMT8
         99BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080070; x=1691684870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwyK6Bv+hcPMKxglSicH9Zo5rWGFycFOmRoBBrYBtwk=;
        b=N36RNq9B/U3lWdREK9HGCOivMRLnh3rD66UkA+wclsAqIp+fiKq9X1mza51zxdLIYi
         zcZTy+QaN/tNFWc2ynQ8KEyGvOYF+CNXp0XmJFtQGUb/l709MVX9h755QP/oQs79nipi
         wxOGcMLipIPKfzAlvM6n+yfbnwfFQXJm3QU5oeJ9ZeSBVZdu+HHmk8GlVVhgTeu6Haql
         1YlZsOqQhB4b1vTH/+hcp/4c/BNawa0VULv82HYSHEhscdbVw+tSAEfvlJ59B5502WB6
         6YfnJhvbQF6wbF+7Ht6+MXEwY8Dgw5V8lAcaOXLB75t++dmt6xbHCBBK5W4A9/mYVw5M
         9vsQ==
X-Gm-Message-State: ABy/qLZhHrPvclbWatunuYuI4sKZu8+ShmYipISy/Mo2nNc6NQsFkatz
	cie+Ymdk2gZb0JviejQsg3Kg0w==
X-Google-Smtp-Source: APBJJlF3FZ/eBbFsCggo3JU70+7C7vjjNVaKf5HzLiG7UsMnz2F0AveDgWO+kWMUbv1rfJo/AfF75g==
X-Received: by 2002:adf:fdd1:0:b0:317:5b76:826 with SMTP id i17-20020adffdd1000000b003175b760826mr7797679wrs.0.1691080070157;
        Thu, 03 Aug 2023 09:27:50 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d474a000000b003141a3c4353sm253167wrs.30.2023.08.03.09.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:27:49 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 03 Aug 2023 18:27:28 +0200
Subject: [PATCH net 2/4] selftests: mptcp: join: fix 'implicit EP' test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-2-6671b1ab11cc@tessares.net>
References: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
In-Reply-To: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Geliang Tang <geliang.tang@suse.com>
Cc: Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=wrR2/gFZisIGtMW223yr33GlqCWjTT9hge1zs/IjHvs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBky9WCE7AUwHgx0yv1SzE8nz8k4s8zOOsGud318
 c9InvFUPBaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMvVggAKCRD2t4JPQmmg
 c9IFEADaaMgin0SaKj+n8cG1OGpW22NLO2EpUY5ZnXx3FXU3uRGomjXOkfZO+n3iLbt5DcJ2KpJ
 dbgxpG3JYbEyzI0D7nXIfAnrZMbOOtv2FG3pZYOi03BONYWwlUIEr3wXiugnFsYKusGC++aVcAy
 37/thitzAnldc1Hih0il6WmMSbbOo7//l1ZT6QkoYzr521Ng0JMV7OmL27UCC34Z2/kyxa/kEg6
 nM86St3sAWSTCayygA3zKZYfdickJ7xwTi6rwJwe4+yCH4C7lmT2wmTFqpS+6m0w0ZeX9dxHnP+
 wltj5XiQqAxIduxAc2wiEaQ8HMDx/xny+XiF3Prhge9cxbCxtSW/fUhW2RPlqlHZ0VffmebbTJ+
 6e4uw9IPT0qBDRa2kiMfmUAalyDBdYkO5QvpexHrOEt+eI42lI42tJ4yTS7tyoSFjE9sMUdiv3i
 n2uHj/8JDQu5X6WbQhBkaaN1NCPb0Rl9ruUPYH8V+EyWOGciL+CJITM5YdnftppRjZKg/pbE03d
 P9AXCC8zxFKzsumUzuPl/sMzBOtjkiwe+cxzNiwo7cQ5wpYx4lygSGm4qJMK11U7BP5vkzXSjib
 ER/U+4UGoQNZWv2L5d/hvzBpsMVD5RiNcyHRyKXQPlkgP9rAgbcFfN6dLSf4tNZ3+m2aJnbKj5l
 qIJsOUy1VR9loaA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Andrea Claudi <aclaudi@redhat.com>

mptcp_join 'implicit EP' test currently fails when using ip mptcp:

  $ ./mptcp_join.sh -iI
  <snip>
  001 implicit EP    creation[fail] expected '10.0.2.2 10.0.2.2 id 1 implicit' found '10.0.2.2 id 1 rawflags 10 '
  Error: too many addresses or duplicate one: -22.
                     ID change is prevented[fail] expected '10.0.2.2 10.0.2.2 id 1 implicit' found '10.0.2.2 id 1 rawflags 10 '
                     modif is allowed[fail] expected '10.0.2.2 10.0.2.2 id 1 signal' found '10.0.2.2 id 1 signal '

This happens because of two reasons:
- iproute v6.3.0 does not support the implicit flag, fixed with
  iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
  flag")
- pm_nl_check_endpoint wrongly expects the ip address to be repeated two
  times in iproute output, and does not account for a final whitespace
  in it.

This fixes the issue trimming the whitespace in the output string and
removing the double address in the expected string.

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 067fabc401f1..d01b73a8ed0f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -796,10 +796,11 @@ pm_nl_check_endpoint()
 	fi
 
 	if [ $ip_mptcp -eq 1 ]; then
+		# get line and trim trailing whitespace
 		line=$(ip -n $ns mptcp endpoint show $id)
+		line="${line% }"
 		# the dump order is: address id flags port dev
-		expected_line="$addr"
-		[ -n "$addr" ] && expected_line="$expected_line $addr"
+		[ -n "$addr" ] && expected_line="$addr"
 		expected_line="$expected_line $id"
 		[ -n "$_flags" ] && expected_line="$expected_line ${_flags//","/" "}"
 		[ -n "$dev" ] && expected_line="$expected_line $dev"

-- 
2.40.1


