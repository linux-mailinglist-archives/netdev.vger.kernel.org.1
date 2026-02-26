Return-Path: <netdev+bounces-261477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HMeNOKBoGn/kQQAu9opvQ
	(envelope-from <netdev+bounces-261477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:24:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB0F1AC549
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 585A1321D2A9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D02343636D;
	Thu, 26 Feb 2026 16:19:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7625E3C1960
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122768; cv=none; b=LS7gGdsU0NqVQPpIgIGp/qbCBCv8wFCiExI5C+YUFaN4gpKsaByKQvv99r9+0OuEfvlsxK/O25oCYCC1ItQAyhAZj8dQzSR4hUG28+W5o+apFfv5YMHG7MRTYCd/ddVjjNlvXRM4KQ9FQ7j94lVvocpml7UpVfbguItgOpB9tec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122768; c=relaxed/simple;
	bh=B3IX9lMWiTCZzGVzYS19BlJ1KlFMfWFM2opwO4AEM0o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dB3UTBJtD7g4uRAqgmlztW7zY27KCdArCjrHYiv1k9sbDKwOwixAPexew9ttcfvv7lSEuJ1tZrVDnk5pxc1DfwxWQC2WL2xjQksMc8zOgx/EJLL5Nnv9y6+/FFn+rUO2bCDTsntvpuJg4yGELBSYfaubcuvsa9mXD/HSKy4RAPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 6100360284; Thu, 26 Feb 2026 17:19:24 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Subject: [PATCH v2 net] selftests: netfilter: nft_queue.sh: avoid flakes on debug kernels
Date: Thu, 26 Feb 2026 17:19:17 +0100
Message-ID: <20260226161920.1205-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261477-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AB0F1AC549
X-Rspamd-Action: no action

Jakub reports test flakes on debug kernels:
 FAIL: test_udp_gro_ct: Expected software segmentation to occur, had 23 and 17

This test assumes that the kernels nfnetlink_queue module sees N GSO
packets, segments them into M skbs and queues them to userspace for reinjection.

Hence, if M >= N, no segmentation occured.

However, its possible that this happens:
- nfnetlink_queue gets GSO packet
- segments that into n skbs
- userspace buffer is full, kernel drops the segmented skbs

-> "toqueue" counter incremented by 1, "fromqueue" is unchanged.

If this happens often enough in a single run, M >= N check triggers
incorrectly.

To solve this, allow the nf_queue.c test program to set the FAIL_OPEN
flag so that the segmented skbs bypass the queueing step in the kernel
if the receive buffer is full.

Also, reduce number of sending socat instances, decrease their priority
and increase nice value for the nf_queue program itself to reduce the
probability of overruns happening in the first place.

Fixes: 59ecffa3995e ("selftests: netfilter: nft_queue.sh: add udp fraglist gro test case")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20260218184114.0b405b72@kernel.org/
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tools/testing/selftests/net/netfilter/nf_queue.c   | 10 ++++++++--
 tools/testing/selftests/net/netfilter/nft_queue.sh | 13 +++++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nf_queue.c b/tools/testing/selftests/net/netfilter/nf_queue.c
index 9e56b9d47037..116c0ca0eabb 100644
--- a/tools/testing/selftests/net/netfilter/nf_queue.c
+++ b/tools/testing/selftests/net/netfilter/nf_queue.c
@@ -18,6 +18,7 @@
 struct options {
 	bool count_packets;
 	bool gso_enabled;
+	bool failopen;
 	int verbose;
 	unsigned int queue_num;
 	unsigned int timeout;
@@ -30,7 +31,7 @@ static struct options opts;
 
 static void help(const char *p)
 {
-	printf("Usage: %s [-c|-v [-vv] ] [-t timeout] [-q queue_num] [-Qdst_queue ] [ -d ms_delay ] [-G]\n", p);
+	printf("Usage: %s [-c|-v [-vv] ] [-o] [-t timeout] [-q queue_num] [-Qdst_queue ] [ -d ms_delay ] [-G]\n", p);
 }
 
 static int parse_attr_cb(const struct nlattr *attr, void *data)
@@ -236,6 +237,8 @@ struct mnl_socket *open_queue(void)
 
 	flags = opts.gso_enabled ? NFQA_CFG_F_GSO : 0;
 	flags |= NFQA_CFG_F_UID_GID;
+	if (opts.failopen)
+		flags |= NFQA_CFG_F_FAIL_OPEN;
 	mnl_attr_put_u32(nlh, NFQA_CFG_FLAGS, htonl(flags));
 	mnl_attr_put_u32(nlh, NFQA_CFG_MASK, htonl(flags));
 
@@ -329,7 +332,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "chvt:q:Q:d:G")) != -1) {
+	while ((c = getopt(argc, argv, "chvot:q:Q:d:G")) != -1) {
 		switch (c) {
 		case 'c':
 			opts.count_packets = true;
@@ -366,6 +369,9 @@ static void parse_opts(int argc, char **argv)
 		case 'G':
 			opts.gso_enabled = false;
 			break;
+		case 'o':
+			opts.failopen = true;
+			break;
 		case 'v':
 			opts.verbose++;
 			break;
diff --git a/tools/testing/selftests/net/netfilter/nft_queue.sh b/tools/testing/selftests/net/netfilter/nft_queue.sh
index 139bc1211878..ea766bdc5d04 100755
--- a/tools/testing/selftests/net/netfilter/nft_queue.sh
+++ b/tools/testing/selftests/net/netfilter/nft_queue.sh
@@ -591,6 +591,7 @@ EOF
 test_udp_gro_ct()
 {
 	local errprefix="FAIL: test_udp_gro_ct:"
+	local timeout=5
 
 	ip netns exec "$nsrouter" conntrack -F 2>/dev/null
 
@@ -630,10 +631,10 @@ table inet udpq {
 	}
 }
 EOF
-	timeout 10 ip netns exec "$ns2" socat UDP-LISTEN:12346,fork,pf=ipv4 OPEN:"$TMPFILE1",trunc &
+	timeout "$timeout" ip netns exec "$ns2" socat UDP-LISTEN:12346,fork,pf=ipv4 OPEN:"$TMPFILE1",trunc &
 	local rpid=$!
 
-	ip netns exec "$nsrouter" ./nf_queue -G -c -q 1 -t 2 > "$TMPFILE2" &
+	ip netns exec "$nsrouter" nice -n -19 ./nf_queue -G -c -q 1 -o -t 2 > "$TMPFILE2" &
 	local nfqpid=$!
 
 	ip netns exec "$nsrouter" ethtool -K "veth0" rx-udp-gro-forwarding on rx-gro-list on generic-receive-offload on
@@ -643,8 +644,12 @@ EOF
 
 	local bs=512
 	local count=$(((32 * 1024 * 1024) / bs))
-	dd if=/dev/zero bs="$bs" count="$count" 2>/dev/null | for i in $(seq 1 16); do
-		timeout 5 ip netns exec "$ns1" \
+
+	local nprocs=$(nproc)
+	[ $nprocs -gt 1 ] && nprocs=$((nprocs - 1))
+
+	dd if=/dev/zero bs="$bs" count="$count" 2>/dev/null | for i in $(seq 1 $nprocs); do
+		timeout "$timeout" nice -n 19 ip netns exec "$ns1" \
 			socat -u -b 512 STDIN UDP-DATAGRAM:10.0.2.99:12346,reuseport,bind=0.0.0.0:55221 &
 	done
 
-- 
2.52.0


