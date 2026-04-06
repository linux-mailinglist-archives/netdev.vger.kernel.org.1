Return-Path: <netdev+bounces-275595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EZuEvK202l+kwcAu9opvQ
	(envelope-from <netdev+bounces-275595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:36:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2A93A397D
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37C8D30158AD
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90432DF701;
	Mon,  6 Apr 2026 13:36:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B625A2C6;
	Mon,  6 Apr 2026 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482605; cv=none; b=U7C4m/xhu1DTMkrnj9C8vdX4FYADI7PhvO2zTOFK02+lzDV/vI+ttkAxa1oP86ccRxOftdRTn19EjPG5FOAbAFf4IsJukv3ZxBvxxi8MYb2mlB/zkTfvub5pSm3Y+0TrBT6Fqx2Axz035+2VYaDGFQPVGHSuDh3+mRh6Vz1q3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482605; c=relaxed/simple;
	bh=PxZQOphpBgYOkz7fuV7z4ZUSbvlqyi54EBR6UtOkDSM=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:References:Subject; b=LYbkBRD9JrPcChTCAQh//eOkQKVYyewY9Etop1Ku8py8Mw7yYL+qrZHGdbau6764LOPtDSRfEIEocJjsp7ZJw23MmMaTez9y4r8MuXHD1J0XdJ9ZXw/SYwB32zntg+fuEoz7rkB5pMJ37ZnoCRPQt/LVc2YRsM/7Q+HwXpJaczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0001-rxrpc-proc-v2.eml (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowACHFQnfttNpoJu0DA--.35030S2;
	Mon, 06 Apr 2026 21:36:32 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Mon, 6 Apr 2026 16:40:00 +0800
Message-ID: <20260406170001.2-rxrpc-proc-v2-pengpeng@iscas.ac.cn>
To: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
In-Reply-To: <20260404190004.4-rxrpc-proc-pengpeng@iscas.ac.cn>
References: <20260404190004.4-rxrpc-proc-pengpeng@iscas.ac.cn>
Subject: [PATCH v2] rxrpc/proc: size address buffers for %pISpc output
X-CM-TRANSID:zQCowACHFQnfttNpoJu0DA--.35030S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw1rKryrCry7uFW3Zw13Jwb_yoW7ZFWDpa
	nxuFW5Jr4DZF4xAr43Xa1vv34Fv3WkJw17G39Yqw4rCFn7Jr9xJF4Fka4UWrn8Gw4xJryx
	Z3Z8KF9xCw1DAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK6x804I0_JrC_JFyl8cAvFVAK0II2c7
	xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-275595-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E2A93A397D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The AF_RXRPC procfs helpers format local and remote socket addresses into
fixed 50-byte stack buffers with "%pISpc".

That is too small for the longest current-tree IPv6-with-port form the
formatter can produce. In lib/vsprintf.c, the compressed IPv6 path uses a
dotted-quad tail not only for v4mapped addresses, but also for ISATAP
addresses via ipv6_addr_is_isatap().

As a result, a case such as

  [ffff:ffff:ffff:ffff:0:5efe:255.255.255.255]:65535

is possible with the current formatter. That is 50 visible characters, so
51 bytes including the trailing NUL, which does not fit in the existing
char[50] buffers used by net/rxrpc/proc.c.

Size the buffers from the formatter's maximum textual form and switch the
call sites to scnprintf().

Changes since v1:
- correct the changelog to cite the actual maximum current-tree case
  explicitly
- frame the proof around the ISATAP formatting path instead of the earlier
  mapped-v4 example

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 net/rxrpc/proc.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 59292f7f9205..7925d4569776 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -10,6 +10,10 @@
 #include <net/af_rxrpc.h>
 #include "ar-internal.h"
 
+#define RXRPC_PROC_ADDRBUF_SIZE \
+	(sizeof("[xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:255.255.255.255]") + \
+	 sizeof(":12345"))
+
 static const char *const rxrpc_conn_states[RXRPC_CONN__NR_STATES] = {
 	[RXRPC_CONN_UNUSED]			= "Unused  ",
 	[RXRPC_CONN_CLIENT_UNSECURED]		= "ClUnsec ",
@@ -53,7 +57,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
 	enum rxrpc_call_state state;
 	rxrpc_seq_t tx_bottom;
-	char lbuff[50], rbuff[50];
+	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
 	long timeout = 0;
 
 	if (v == &rxnet->calls) {
@@ -69,11 +73,11 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 
 	local = call->local;
 	if (local)
-		sprintf(lbuff, "%pISpc", &local->srx.transport);
+		scnprintf(lbuff, sizeof(lbuff), "%pISpc", &local->srx.transport);
 	else
 		strcpy(lbuff, "no_local");
 
-	sprintf(rbuff, "%pISpc", &call->dest_srx.transport);
+	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &call->dest_srx.transport);
 
 	state = rxrpc_call_state(call);
 	if (state != RXRPC_CALL_SERVER_PREALLOC)
@@ -142,7 +146,7 @@ static int rxrpc_connection_seq_show(struct seq_file *seq, void *v)
 	struct rxrpc_connection *conn;
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
 	const char *state;
-	char lbuff[50], rbuff[50];
+	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
 
 	if (v == &rxnet->conn_proc_list) {
 		seq_puts(seq,
@@ -161,8 +165,8 @@ static int rxrpc_connection_seq_show(struct seq_file *seq, void *v)
 		goto print;
 	}
 
-	sprintf(lbuff, "%pISpc", &conn->local->srx.transport);
-	sprintf(rbuff, "%pISpc", &conn->peer->srx.transport);
+	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &conn->local->srx.transport);
+	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &conn->peer->srx.transport);
 print:
 	state = rxrpc_is_conn_aborted(conn) ?
 		rxrpc_call_completions[conn->completion] :
@@ -228,7 +232,7 @@ static int rxrpc_bundle_seq_show(struct seq_file *seq, void *v)
 {
 	struct rxrpc_bundle *bundle;
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
-	char lbuff[50], rbuff[50];
+	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
 
 	if (v == &rxnet->bundle_proc_list) {
 		seq_puts(seq,
@@ -242,8 +246,8 @@ static int rxrpc_bundle_seq_show(struct seq_file *seq, void *v)
 
 	bundle = list_entry(v, struct rxrpc_bundle, proc_link);
 
-	sprintf(lbuff, "%pISpc", &bundle->local->srx.transport);
-	sprintf(rbuff, "%pISpc", &bundle->peer->srx.transport);
+	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &bundle->local->srx.transport);
+	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &bundle->peer->srx.transport);
 	seq_printf(seq,
 		   "UDP   %-47.47s %-47.47s %4x %3u %3d"
 		   " %c%c%c %08x | %08x %08x %08x %08x %08x\n",
@@ -279,7 +283,7 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
 {
 	struct rxrpc_peer *peer;
 	time64_t now;
-	char lbuff[50], rbuff[50];
+	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
 
 	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq,
@@ -290,9 +294,9 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
 
 	peer = list_entry(v, struct rxrpc_peer, hash_link);
 
-	sprintf(lbuff, "%pISpc", &peer->local->srx.transport);
+	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &peer->local->srx.transport);
 
-	sprintf(rbuff, "%pISpc", &peer->srx.transport);
+	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &peer->srx.transport);
 
 	now = ktime_get_seconds();
 	seq_printf(seq,
@@ -401,7 +405,7 @@ const struct seq_operations rxrpc_peer_seq_ops = {
 static int rxrpc_local_seq_show(struct seq_file *seq, void *v)
 {
 	struct rxrpc_local *local;
-	char lbuff[50];
+	char lbuff[RXRPC_PROC_ADDRBUF_SIZE];
 
 	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq,
@@ -412,7 +416,7 @@ static int rxrpc_local_seq_show(struct seq_file *seq, void *v)
 
 	local = hlist_entry(v, struct rxrpc_local, link);
 
-	sprintf(lbuff, "%pISpc", &local->srx.transport);
+	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &local->srx.transport);
 
 	seq_printf(seq,
 		   "UDP   %-47.47s %3u %3u %3u\n",
-- 
2.50.1 (Apple Git-155)


