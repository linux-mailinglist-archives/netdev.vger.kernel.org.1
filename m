Return-Path: <netdev+bounces-275377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDRhDE0Y0WlfFAcAu9opvQ
	(envelope-from <netdev+bounces-275377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 15:55:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E3339B483
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 15:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E34593012BCA
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 13:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9134534EEED;
	Sat,  4 Apr 2026 13:55:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98DA2874FA;
	Sat,  4 Apr 2026 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775310904; cv=none; b=Yc2JeWO5fjEEmOGVUPpeQgyEGxsz3zvgJ9FFEddk/Bd0UGi3UhM0/c91UmjshETlN6wX9Irb21IdylMrOglZyfSm280B4fZCUbyMezrkqDFCOyEZwJMYXx9UoAFay2QfjfSG9XvZ1ZnVbQ3xedG2+kH3y4OeeEOubxhgLooEabY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775310904; c=relaxed/simple;
	bh=Ao1WRlPZxXek901irhnqkFEk8DG4TIR8ZfreS7HPGAo=;
	h=From:Date:Message-ID:To:Cc:Subject; b=tEZbSYQ5AjgzZGYO5E2J5Toq8y9MWMBrgBc3fAgmH81n58cZ4Gex9g+mQDL7WhapZk9KiXtx+psKzEYcr/VKdCVxsqt7lB4pik2fcLmcrkm+LpG6HmDmIA6A1fkPDuFC7szNN/yK078Ck8RHmDSqgV/ghhwSlJMUpl/t+Qsp/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0004-rxrpc-proc.eml (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowAD3E9snGNFp1ivfDA--.28840S2;
	Sat, 04 Apr 2026 21:54:47 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Sat, 4 Apr 2026 17:32:47 +0800
Message-ID: <20260404190004.4-rxrpc-proc-pengpeng@iscas.ac.cn>
To: David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH] rxrpc/proc: size address buffers for %pISpc output
X-CM-TRANSID:rQCowAD3E9snGNFp1ivfDA--.28840S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw1rZrW5Cryrur4xAFWrKrg_yoW7XFy8pa
	nxCFW5JrWDAa1xAr43XF4vv3sYv3WkJw17G39Yqws5AFn7Jr9xJF4Fka4jgwn8Ww4xJry8
	Z3Z8KF9xCw1DAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK6x804I0_JrC_JFyl8cAvFVAK0II2c7
	xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5iihUUUUU
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-275377-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56E3339B483
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The AF_RXRPC procfs helpers format local and remote socket addresses into
fixed 50-byte stack buffers with "%pISpc".

That is too small for the longest IPv6-with-port form the formatter can
produce: a compressed IPv6 address still permits a bracketed mapped-IPv4
spelling plus the trailing port, which exceeds 50 bytes including the final
NUL.

Size the buffers from the formatters maximum textual form and switch the
call sites to scnprintf().

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



