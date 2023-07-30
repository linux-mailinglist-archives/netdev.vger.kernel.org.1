Return-Path: <netdev+bounces-22596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C336768463
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 10:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DA31C20A8C
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 08:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E69ECD;
	Sun, 30 Jul 2023 08:05:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AA017F0
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 08:05:36 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275821FE4
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 01:05:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso32865835e9.2
        for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 01:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690704332; x=1691309132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQqVrg2AxkeCUd4RFlnJm2NAddhvnsPrl7tjyYt2XYM=;
        b=5okC5Aj5PW/3arYaXCw8luJS22Yb5F6prA74ByuC2wrv64Nul77hf1IiiKHS+AHfHv
         pwzEpdsZzeTTUl4h5YJJY+JXF+pVkN6HGor5AR84ZVYKB/pyahJwFxeVoK86OsQnmRxQ
         uIBgIAiA1ZSm2zPtAuRjrO++fNIa8HqbvAwEUAURfjL3w8o8G8IVpnv8z+ob3cJLnifw
         LMb/EVXGuUYXQVIdlBKwGFCYIRzJDgF+l6X9G+iahb3o0DbrWKUWCnNZfx+NVhFXzqpz
         kOnOXVeSo3AHMjmKaJnm0qr+zIGfCVTYUvHWQ1sBUsbj+ARrYj2A06X7lwjUIsZBJRjp
         YH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690704332; x=1691309132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQqVrg2AxkeCUd4RFlnJm2NAddhvnsPrl7tjyYt2XYM=;
        b=ePOoqc8baog0yoTNHBY+gCWmuu7LUr36Uhe1HWIUzguCjQAsixKoD5c3wFmeMUVIRO
         93wzoat6TeE+dVLW5MmISwYgLCfRXjKqKjoEBYmtDt3egHF2Nm2dEvq3IaL+rW3+EtR7
         8oC+2qpNtFslKQ1m+Xta0lf9rPhxwGkFhW/ttHZmCnQvKpz+ty1IzWC6IvHFwgbI1U1T
         2Z+spIv4+GIjHHC/QT0c6O+Ied2O/UYX+KlWbNu3kT5xuzfEcdBencLfznYeNe3XaBUn
         fCXnHVCVGk9+iJQ2xO18iW7X6exlKXlsa90YUJU7atMDr1xzLvJhmAjEcuzdkoOuZPbO
         lciw==
X-Gm-Message-State: ABy/qLbvKdUe5JEqPUkS6QSlQadcEl6Mc/0GPlc5Wn+XnPIeKHrc9uoX
	/uUDxb6pdh5uPoan+JcdOGdYiw==
X-Google-Smtp-Source: APBJJlHEPEWmqkF8H1Jaf/ZUug/vBvFFXwfcGvYuIotJ4EKrCxaBKVGHH9AWj97g80VWeLeGnmpgNg==
X-Received: by 2002:a05:6000:10cc:b0:314:5376:f0d6 with SMTP id b12-20020a05600010cc00b003145376f0d6mr4543789wrx.52.1690704332551;
        Sun, 30 Jul 2023 01:05:32 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm9338684wrq.115.2023.07.30.01.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 01:05:32 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Sun, 30 Jul 2023 10:05:16 +0200
Subject: [PATCH net-next 2/4] selftests: mptcp: join: colored results
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-2-7e9cc530a9cd@tessares.net>
References: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
In-Reply-To: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3273;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=GmVKWSiJ8DZnxhxB0kl8fOaIodE+Lir7/6qs2cskk90=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkxhnJl4WfzchoILJExO3108dVUOzhC417y4x41
 Ms9Sy1JJvCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMYZyQAKCRD2t4JPQmmg
 c0RfD/9bXbfjLoHS4Im02miuggaUqtrL3Z7WfbT1oFymNnIWy/X85nEcnYNv1zPYiME1rwqEvkP
 4ASfCChFQ+JMjeTLm/6O8BNxxskGEie73qKVJxMzXWmyTT5Lxm+Hd2lXUGAgBkz0G5+KMy7eHWQ
 POjXUE49nIWQL8kRcczytUnHao6U+5hPVm8wjOyYOXzqBDfBIjzxA2LAueyCUiQCeEduLyQo7vI
 PT22O3CarBhZSrQ73E1SJWCICA4YX03+jqlxwupX7MQuQ8KyMQPNMt9EU6rQ0RDaGRvDzlxIE/E
 quhGBCBpC3Nae6cFyvaR5pBZD4ZbvUxBhucdHwywe2aRH7n18ZIjUv55oLgL8ZuJIy1x93C/eJO
 O0Ykqjn+xneDH0udWn1a406WP/m5GjkIDQP+YSjkVE/hLy1Sui3puJjPnxh+bdEIB1WScbi0MQm
 bUKVx8bToJ+TKrZK1YK3tDRd7iq3cRMwHmPVFzFED7pgMvudwoHY30pM1yJCavGmN87zQigCHMT
 IrzY/n8bPD7MFOrad9EpLPZBdjrUfGyOzlLCld+BsgSOUavc3NLc/+WHLV6QLA3UOtNvWQKoQd5
 H8cdRALxxUSW8f2GCnL7vBT8ruaI/VHJrhgdxMXnOgzhYaKBM5Ps0Lkh6n5PvoJk46/MSIgjzVr
 cVDX3+YVlI8n+Mg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks to the parent commit, it is easy to change the output and add
some colours to help spotting issues.

The colours are not used if stdout is redirected or if NO_COLOR env var
is set to 1 as specified in https://no-color.org.

It is possible to force displaying the colours even if stdout is
redirected by setting this env var:

  SELFTESTS_MPTCP_LIB_COLOR_FORCE=1

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  8 ++---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 39 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6da3a6c98ba7..136d20641fce 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -215,22 +215,22 @@ print_info()
 	# It can be empty, no need to print anything then
 	[ -z "${1}" ] && return
 
-	printf "%-${nr_blank}sInfo: %s\n" " " "${*}"
+	mptcp_lib_print_info "      Info: ${*}"
 }
 
 print_ok()
 {
-	echo "[ ok ]${1:+ ${*}}"
+	mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
 }
 
 print_fail()
 {
-	echo "[fail]${1:+ ${*}}"
+	mptcp_lib_print_err "[fail]${1:+ ${*}}"
 }
 
 print_skip()
 {
-	echo "[skip]${1:+ ${*}}"
+	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
 }
 
 # [ $1: fail msg ]
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index b1a0fdd0408b..92a5befe8039 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -4,10 +4,49 @@
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
+
+# shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
 MPTCP_LIB_SUBTESTS=()
 
+# only if supported (or forced) and not disabled, see no-color.org
+if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
+   [ "${NO_COLOR:-}" != "1" ]; then
+	readonly MPTCP_LIB_COLOR_RED="\E[1;31m"
+	readonly MPTCP_LIB_COLOR_GREEN="\E[1;32m"
+	readonly MPTCP_LIB_COLOR_YELLOW="\E[1;33m"
+	readonly MPTCP_LIB_COLOR_BLUE="\E[1;34m"
+	readonly MPTCP_LIB_COLOR_RESET="\E[0m"
+else
+	readonly MPTCP_LIB_COLOR_RED=
+	readonly MPTCP_LIB_COLOR_GREEN=
+	readonly MPTCP_LIB_COLOR_YELLOW=
+	readonly MPTCP_LIB_COLOR_BLUE=
+	readonly MPTCP_LIB_COLOR_RESET=
+fi
+
+# $1: color, $2: text
+mptcp_lib_print_color() {
+	echo -e "${MPTCP_LIB_START_PRINT:-}${*}${MPTCP_LIB_COLOR_RESET}"
+}
+
+mptcp_lib_print_ok() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_GREEN}${*}"
+}
+
+mptcp_lib_print_warn() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_YELLOW}${*}"
+}
+
+mptcp_lib_print_info() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_BLUE}${*}"
+}
+
+mptcp_lib_print_err() {
+	mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
+}
+
 # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
 # features using the last version of the kernel and the selftests to make sure
 # a test is not being skipped by mistake.

-- 
2.40.1


