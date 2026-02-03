Return-Path: <netdev+bounces-256440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLCCAQdEgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:52:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF4EDDDEF
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69F8C30EF621
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2143D7D83;
	Tue,  3 Feb 2026 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVJUX3yu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA536F415;
	Tue,  3 Feb 2026 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144185; cv=none; b=JSZVaLDOabmrPi6BYROPWQxf6PBvO+M/XddBvNfAbJ1ic1SYCloDuC6RHMNGcWnDGTwpoaUCS0z1ca8vXt+BvU0S0A9ygkybo0DBQg8GYCbPTpXq8iagqYHBJyFDWzcmTloDmcEOupEBWQ0mTLcvfiNYylUlCtmbB47pzTTa7Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144185; c=relaxed/simple;
	bh=8AUrYwtKKnckhCv/Ter8FB1r7t0MKFfzvxhFPKBF/ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=coIX5PJncvT3ZtugjzLXvDGfSew3UGIAPp9vmeqgRZRT/XkrEeCN9Zx1HmmuR047sjPGipRoAom0u7EHZxnxMo+QR5y2AaK950nB4G+SjW7+WJfrsBJVuEdDgiVQPkdltjyjRqBxfRMMzuNNM+Rt0gYASyCPUU0/QkYrW+S/AEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVJUX3yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D652EC116D0;
	Tue,  3 Feb 2026 18:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144184;
	bh=8AUrYwtKKnckhCv/Ter8FB1r7t0MKFfzvxhFPKBF/ks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XVJUX3yuBe4DYGy5U6Sc+nCW3R1nqGXPrIbLqAP4Lh3X0D5ymbfYBkQ2v9EnYUZ2j
	 UptazNcNIfSTPUJsWX8MBWd8JAr6VRzqWhBaq8ILBDCpmCA9hCvdwlDHqTyPXpLTat
	 ySCDiBqaaNA7huiEeOK2KDTaJryZYoAwtuh/5vOsAv2tYTDl2B8BD8Zt3FW3IcyL4+
	 LWbiOXuz+eQal8lWxioPQY/C2tU0kDmKEHv9ITQ+9vxWmVidslCOfIFuvXlqq3l/fG
	 j++T9QoblOHCv8A2Ee5eUILqDi64vaT53sc3f8i1T21pb6ds+uM9fZ8AcgKnCzC4Fk
	 3N0FwOgtlxDwQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Feb 2026 19:41:31 +0100
Subject: [PATCH net-next 15/15] selftests: mptcp: join: no SKIP mark for
 group checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-15-31ec8bfc56d1@kernel.org>
References: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
In-Reply-To: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5452; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8AUrYwtKKnckhCv/Ter8FB1r7t0MKFfzvxhFPKBF/ks=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbHCfkTp+4a9Jy7+/JgfduWV57epF7/5pHGefFGmdNW
 8e/Yd70lI5SFgYxLgZZMUUW6bbI/JnPq3hLvPwsYOawMoEMYeDiFICJXGtl+KfcIHEyaUlohzvD
 tbVBHnFL1qg/e+nU9Ivh+aQa1f091+MY/squmcg4bTmvZH0aQ0BISVFTtLSS0c/bWwwY9r8s75r
 KyQYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256440-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BF4EDDDEF
X-Rspamd-Action: no action

When executing the last MPTCP selftests on older kernels, this output is
printed:

  # 001 no JOIN
  #       join Rx                             [SKIP]
  #       join Tx                             [SKIP]
  #       fallback                            [SKIP]

In fact, behind each line, a few counters are checked, and likely not
all of them have been skipped because the they are not available on
these kernels. Instead, "new" and unsupported counters for these groups
are now ignored, and [ OK ] will be printed instead of [SKIP].

Note that on the MPTCP CI, when validating the dev versions, any
unsupported counter will cause the tests to fail. So this is safe not to
print 'SKIP' for these group checks.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0f9253d607c3..dc1f200aaa81 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1402,7 +1402,7 @@ chk_join_tx_nr()
 
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxCreatSkErr")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$create" ]; then
 		rc=${KSFT_FAIL}
 		print_check "syn tx create socket error"
@@ -1411,7 +1411,7 @@ chk_join_tx_nr()
 
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxBindErr")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$bind" ]; then
 		rc=${KSFT_FAIL}
 		print_check "syn tx bind error"
@@ -1420,7 +1420,7 @@ chk_join_tx_nr()
 
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxConnectErr")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$connect" ]; then
 		rc=${KSFT_FAIL}
 		print_check "syn tx connect error"
@@ -1446,7 +1446,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtInfiniteMapTx")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$infinite_map_tx" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns infinite map tx fallback"
@@ -1455,7 +1455,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtDSSCorruptionFallback")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$dss_corruption" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns dss corruption fallback"
@@ -1464,7 +1464,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtSimultConnectFallback")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$simult_conn" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns simult conn fallback"
@@ -1473,7 +1473,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableFallbackACK")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$mpc_passive" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns mpc passive fallback"
@@ -1482,7 +1482,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableFallbackSYNACK")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$mpc_active" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns mpc active fallback"
@@ -1491,7 +1491,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableDataFallback")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$mpc_data" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns mpc data fallback"
@@ -1500,7 +1500,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMD5SigFallback")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$md5_sig" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns MD5 Sig fallback"
@@ -1509,7 +1509,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtDssFallback")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$dss" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns dss fallback"
@@ -1585,7 +1585,7 @@ chk_join_nr()
 
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckHMacFailure")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "0" ]; then
 		rc=${KSFT_FAIL}
 		print_check "synack HMAC"
@@ -1594,7 +1594,7 @@ chk_join_nr()
 
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$ack_nr" ]; then
 		rc=${KSFT_FAIL}
 		print_check "ack rx"
@@ -1603,7 +1603,7 @@ chk_join_nr()
 
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckHMacFailure")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "0" ]; then
 		rc=${KSFT_FAIL}
 		print_check "ack HMAC"
@@ -1612,7 +1612,7 @@ chk_join_nr()
 
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinRejected")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$syn_rej" ]; then
 		rc=${KSFT_FAIL}
 		print_check "syn rejected"

-- 
2.51.0


