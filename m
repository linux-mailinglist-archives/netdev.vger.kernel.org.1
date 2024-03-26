Return-Path: <netdev+bounces-82006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8718B88C0D9
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358081F38064
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB246E616;
	Tue, 26 Mar 2024 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA71yI2E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7646056771
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452861; cv=none; b=GS+WTCii4JXVaeyRla5qEZxYBtzJXKH6TkRk5XXi+Sw/mvFnaygIAqHqKVkNrRk37g1YcMdsrIXliZkhHlAqTpZKWLlOcxRITcmP58n92OsJsnbCR1Y6clxnrCYbC3q9c3j/O4gtA1sdqJDpnGUKTmsGIGnksZZ8rin2X7Yq9YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452861; c=relaxed/simple;
	bh=Ld5ZYdJDMtAhbqbX4VbZ8afAYRtQJsDM/MORcFOZQk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGsIHRc26Pvuf5BZjrgpDd31iDurnIvdxJ1iTSN0+3C1XUaA9L4O/zKK/SuO//jXkvkz/jxerPbxin1t0ZTQyzFLuOOUjs71hbahJ3fYtnjlAO1A2C3mnamXzewq5Q8K7kZNpJznU6kryrqS2lgQ6mrpCc0t2KTAreuzRt1MLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA71yI2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FA9C433C7;
	Tue, 26 Mar 2024 11:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711452861;
	bh=Ld5ZYdJDMtAhbqbX4VbZ8afAYRtQJsDM/MORcFOZQk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NA71yI2ERQkxpQ93UmqmuJaRVVasi/ZJQD1H9Ir8mO3SIeSo7kZBi+kvckW88pYAg
	 wFcMCgQ42rbBkqtNzoW4ohFYUE60pD5a0x1YQ5PWbVmvJ9nA+zQiYBADkxfee1Rll4
	 rcCqdqrbr8pRdIc6jT4PDgS+T7X78nSoLoUqtrSSFOtBBXMNVxgkwUCP1Q7L7Hyp1V
	 pZDbZauo/JvsdyB+NV0gRBvMbkm4xa+HNbmNHY3UP3JahXcB6OlgQVhSKvoJy/oEcl
	 fVS9dpImW6lkzodivk/rTWo86Nkw8Wi1MZRO/q9W2x1gO+RXLKX1KwHmyTXug8Wmvv
	 NWWJawgzBqtJA==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net v4 5/5] selftests: net: gro fwd: update vxlan GRO test expectations
Date: Tue, 26 Mar 2024 12:34:02 +0100
Message-ID: <20240326113403.397786-6-atenart@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326113403.397786-1-atenart@kernel.org>
References: <20240326113403.397786-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UDP tunnel packets can't be GRO in-between their endpoints as this
causes different issues. The UDP GRO fwd vxlan tests were relying on
this and their expectations have to be fixed.

We keep both vxlan tests and expected no GRO from happening. The vxlan
UDP GRO bench test was removed as it's not providing any valuable
information now.

Fixes: a062260a9d5f ("selftests: net: add UDP GRO forwarding self-tests")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 tools/testing/selftests/net/udpgro_fwd.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index 380cb15e942e..83ed987cff34 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -244,7 +244,7 @@ for family in 4 6; do
 	create_vxlan_pair
 	ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
 	ip netns exec $NS_DST ethtool -K veth$DST rx-gro-list on
-	run_test "GRO frag list over UDP tunnel" $OL_NET$DST 1 1
+	run_test "GRO frag list over UDP tunnel" $OL_NET$DST 10 10
 	cleanup
 
 	# use NAT to circumvent GRO FWD check
@@ -258,13 +258,7 @@ for family in 4 6; do
 	# load arp cache before running the test to reduce the amount of
 	# stray traffic on top of the UDP tunnel
 	ip netns exec $NS_SRC $PING -q -c 1 $OL_NET$DST_NAT >/dev/null
-	run_test "GRO fwd over UDP tunnel" $OL_NET$DST_NAT 1 1 $OL_NET$DST
-	cleanup
-
-	create_vxlan_pair
-	run_bench "UDP tunnel fwd perf" $OL_NET$DST
-	ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
-	run_bench "UDP tunnel GRO fwd perf" $OL_NET$DST
+	run_test "GRO fwd over UDP tunnel" $OL_NET$DST_NAT 10 10 $OL_NET$DST
 	cleanup
 done
 
-- 
2.44.0


