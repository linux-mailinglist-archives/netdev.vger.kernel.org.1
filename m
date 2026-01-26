Return-Path: <netdev+bounces-253328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK0PB5YGd2lGawEAu9opvQ
	(envelope-from <netdev+bounces-253328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:15:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A72538466F
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E615300D174
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 06:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E2F26ED56;
	Mon, 26 Jan 2026 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4u1xDT5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83A26ED5C;
	Mon, 26 Jan 2026 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408144; cv=none; b=RhcmWbMwkxUH22coeBb3gYYuzu8TVRDwnr9Uk0EKD0l5a3T1QHoF/v1dxPlGK/UNmcXU3eW46YsxEB5BV88vLLqgfZf4KJQzusNZSEydTjClRxzHlq+yaZx3ar0K5+S7lf0ExMOTCr8FMpFhijBtoXOz89+72RwSzTIlWjwJxO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408144; c=relaxed/simple;
	bh=zVRgQbcmx5QBeZkzn1HZ2OWSSqdpA+EKdighbyyeRbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiN+RwEZp4iv+zu2GUTkB+lPKVl0/RgF2XXdKalh9DGiBHyUfxbQaSNJx6Ri2DpyW5sc/p0q0PL3u9AruFUIxjaHL6tuKrpEMcOAO/3DzeppWujJ2lGuvxp4LWPncHBUeHZElTkUc4bXTsKFO5eSvgTlPYnGBLUALelGbFd2TSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4u1xDT5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769408142; x=1800944142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zVRgQbcmx5QBeZkzn1HZ2OWSSqdpA+EKdighbyyeRbg=;
  b=l4u1xDT5q7ExRSW/8Bel/orHD7qfmE1xzA/TtFf209a9CwmzKvW6ZFy8
   oTxJ0m6u+KI3qUUGLNkjTS3xVwAmJj1+YCi2bqUaxP0f7XlweRNXXtf/n
   MIuUcm1akfB8N7XjY74gW4c2rC7I9lq0hhiiJIW1vkYaOzlGyp/fHSjjS
   nVzF9vlEAscfoEFaPKGUXq9YXwc85+pUeC1yI6pqeey1TqGGcqiyn8Vig
   //SKEWHurVwzZQI0mUioIJvTZ4joCiE9EyEeMINRqWtB88CncX6gYp9AJ
   stYqR6nA1UYwWq7nZWI8gQbBebbklJwiTQlluNMEgpR+/PPVPDHAZ8IF4
   g==;
X-CSE-ConnectionGUID: gs/g1saZS+K42+Q93IcLyQ==
X-CSE-MsgGUID: iky3QoFqQ4++ZdUt+wBWWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="74213916"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="74213916"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 22:15:42 -0800
X-CSE-ConnectionGUID: 3uBcQNSBTVKXemw6S4akdA==
X-CSE-MsgGUID: FlkCZpTvTJioAa6Zp4Uy8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="238241191"
Received: from junjie-nuc14rvs.bj.intel.com ([10.238.152.25])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 22:15:41 -0800
From: Junjie Cao <junjie.cao@intel.com>
To: Shuah Khan <shuah@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] selftests: ptp: treat unsupported PHC operations as skip
Date: Mon, 26 Jan 2026 14:15:32 +0800
Message-ID: <20260126061532.12532-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126061532.12532-1-junjie.cao@intel.com>
References: <20260126061532.12532-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253328-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junjie.cao@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A72538466F
X-Rspamd-Action: no action

Some PTP hardware clock (PHC) devices may return -EOPNOTSUPP for
operations like settime, adjtime, or adjfreq. This commonly occurs
with timestamp-only PHC implementations that don't support full clock
control.

For background, syzbot previously exposed a crash risk when PTP clock
drivers lacked required callbacks[1]. Subsequent work[2] made callback
presence a registration requirement. As a result, some drivers (like
iwlwifi MVM/MLD[3]) now provide stub callbacks that return -EOPNOTSUPP
for unsupported operations.

When phc_ctl encounters such devices, the "Operation not supported"
error should be treated as a skip (device limitation) rather than a
test failure. This patch:
- Adds [SKIP] output handling in log_test()
- Detects "Operation not supported" from phc_ctl and returns ksft_skip
- Returns ksft_skip if all tests are skipped, preventing false-positive
  results when testing timestamp-only PHC implementations

Link: https://lore.kernel.org/netdev/20251028043216.1971292-1-junjie.cao@intel.com/ [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dfb073d32cac [2]
Link: https://lore.kernel.org/netdev/20251204123204.9316-1-ziyao@disroot.org/ [3]
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tools/testing/selftests/ptp/phc.sh | 49 ++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/ptp/phc.sh b/tools/testing/selftests/ptp/phc.sh
index 51aad466d989..9f61c1579edf 100755
--- a/tools/testing/selftests/ptp/phc.sh
+++ b/tools/testing/selftests/ptp/phc.sh
@@ -52,6 +52,7 @@ phc_sanity
 
 # Exit status to return at the end. Set in case one of the tests fails.
 EXIT_STATUS=0
+PASS_COUNT=0
 # Per-test return value. Clear at the beginning of each test.
 RET=0
 
@@ -68,12 +69,18 @@ log_test()
 {
 	local test_name=$1
 
+	if [[ $RET -eq $ksft_skip ]]; then
+		printf "TEST: %-60s  [SKIP]\n" "$test_name"
+		return 0
+	fi
+
 	if [[ $RET -ne 0 ]]; then
 		EXIT_STATUS=1
 		printf "TEST: %-60s  [FAIL]\n" "$test_name"
 		return 1
 	fi
 
+	((PASS_COUNT++))
 	printf "TEST: %-60s  [ OK ]\n" "$test_name"
 	return 0
 }
@@ -92,34 +99,49 @@ tests_run()
 
 settime_do()
 {
-	local res
+	local res out
 
-	res=$(phc_ctl $DEV set 0 wait 120.5 get 2> /dev/null \
-		| awk '/clock time is/{print $5}' \
-		| awk -F. '{print $1}')
+	out=$(LC_ALL=C phc_ctl $DEV set 0 wait 120.5 get 2>&1)
+	if [[ $? -ne 0 ]]; then
+		if echo "$out" | grep -qi "Operation not supported"; then
+			return $ksft_skip
+		fi
+		return 1
+	fi
+	res=$(echo "$out" | awk '/clock time is/{print $5}' | awk -F. '{print $1}')
 
 	(( res == 120 ))
 }
 
 adjtime_do()
 {
-	local res
+	local res out
 
-	res=$(phc_ctl $DEV set 0 adj 10 get 2> /dev/null \
-		| awk '/clock time is/{print $5}' \
-		| awk -F. '{print $1}')
+	out=$(LC_ALL=C phc_ctl $DEV set 0 adj 10 get 2>&1)
+	if [[ $? -ne 0 ]]; then
+		if echo "$out" | grep -qi "Operation not supported"; then
+			return $ksft_skip
+		fi
+		return 1
+	fi
+	res=$(echo "$out" | awk '/clock time is/{print $5}' | awk -F. '{print $1}')
 
 	(( res == 10 ))
 }
 
 adjfreq_do()
 {
-	local res
+	local res out
 
 	# Set the clock to be 1% faster
-	res=$(phc_ctl $DEV freq 10000000 set 0 wait 100.5 get 2> /dev/null \
-		| awk '/clock time is/{print $5}' \
-		| awk -F. '{print $1}')
+	out=$(LC_ALL=C phc_ctl $DEV freq 10000000 set 0 wait 100.5 get 2>&1)
+	if [[ $? -ne 0 ]]; then
+		if echo "$out" | grep -qi "Operation not supported"; then
+			return $ksft_skip
+		fi
+		return 1
+	fi
+	res=$(echo "$out" | awk '/clock time is/{print $5}' | awk -F. '{print $1}')
 
 	(( res == 101 ))
 }
@@ -166,4 +188,7 @@ trap cleanup EXIT
 
 tests_run
 
+if [[ $EXIT_STATUS -eq 0 && $PASS_COUNT -eq 0 ]]; then
+	exit $ksft_skip
+fi
 exit $EXIT_STATUS
-- 
2.43.0


