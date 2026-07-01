Return-Path: <netdev+bounces-303579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I1UVM7buRGrg3QoAu9opvQ
	(envelope-from <netdev+bounces-303579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:40:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B16EC493
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:40:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303579-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303579-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D58D03046CE6
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6AC429816;
	Wed,  1 Jul 2026 10:38:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D76428475;
	Wed,  1 Jul 2026 10:38:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902306; cv=none; b=Dqo9e0XoM24nh2EdZUrGmodvtzs5ILKyj9ArJ4Nnqv6wGyfpZGF6IF+f5fJuy3zV/RCNCGq/j9Uxzh+zL8HtbPa+YONIxDSPvJYgPHbUORmfs4O0FGHHNXrABFX1g6raOHwdqkcI+QhpuXYjUJNJIVZop9zjxo91iWyLHJwijWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902306; c=relaxed/simple;
	bh=/viK3Nd+7xZV4w6XcuB2tRZQ2EjZ5ngGTvToKYdql7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BsVA9w41pk8oeGKpaM8dpiDwAHVCCEPGYrDK1ZW9iEG3izXPrj47aITfrRl2uW8AtCulbICRPb9KJccmsKGAq+9flhcg7CenjhwQpEKO3gr0PdmXUtkufPlp6ejjIK5mHFWByqivpXyygRtzyoy3JNO33qciTC07abUqOZFkY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: f67ed0aa753811f1aa26b74ffac11d73-20260701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:77648119-f14a-49de-a12e-057d135df188,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:101142069bfd13c8603bea6829cfe43f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f67ed0aa753811f1aa26b74ffac11d73-20260701
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1628733620; Wed, 01 Jul 2026 18:38:13 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: geliang@kernel.org,
	martineau@kernel.org,
	matttbe@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] selftests: mptcp: mptcp_diag: fix stack buffer overflow in get_subflow_info()
Date: Wed,  1 Jul 2026 18:38:09 +0800
Message-Id: <20260701103809.4051377-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	TAGGED_FROM(0.00)[bounces-303579-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:geliang@kernel.org,m:martineau@kernel.org,m:matttbe@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:13667453960@163.com,m:yijiangshan@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[yijiangshan@kylinos.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,163.com,kylinos.cn];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yijiangshan@kylinos.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:email,kylinos.cn:mid,kylinos.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D9B16EC493

get_subflow_info() parses the subflow address string with:

	char saddr[64], daddr[64];

	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d",
		     saddr, &sport, daddr, &dport);

The subflow_addrs buffer holds up to 1024 bytes and is taken directly
from the command line ("-c" argument). The "%[^:]" conversions have no
maximum field width, so if the address substring before the ':' exceeds
63 bytes, sscanf() writes past the end of the 64-byte saddr/daddr stack
buffers. This overflows the stack, corrupting adjacent stack data such
as the saved return address, and can crash the tool or lead to
out-of-bounds writes controlled by user-supplied input.

Bound both string conversions to the destination buffer size by adding
an explicit maximum field width of 63 (leaving room for the terminating
NUL), so at most 63 bytes are written into each 64-byte buffer:

	ret = sscanf(subflow_addrs, "%63[^:]:%d %63[^:]:%d",
		     saddr, &sport, daddr, &dport);

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 5e222ba977e4..02ac93f794fe 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -377,7 +377,7 @@ static void get_subflow_info(char *subflow_addrs)
 	int ret;
 	int fd;
 
-	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d", saddr, &sport, daddr, &dport);
+	ret = sscanf(subflow_addrs, "%63[^:]:%d %63[^:]:%d", saddr, &sport, daddr, &dport);
 	if (ret != 4)
 		die_perror("IP PORT Pairs has style problems!");
 
-- 
2.25.1


