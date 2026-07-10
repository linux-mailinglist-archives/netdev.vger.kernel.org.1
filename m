Return-Path: <netdev+bounces-306445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id btPWEM+NUGr+1AIAu9opvQ
	(envelope-from <netdev+bounces-306445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:14:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9DD7378F2
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:14:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306445-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306445-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31FF8300F780
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4097E3AE1A9;
	Fri, 10 Jul 2026 06:13:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F873AE1B1;
	Fri, 10 Jul 2026 06:13:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663993; cv=none; b=N7y2rzc8Epdn5n84mCDc6z3s+HAqw53JgxAKIsNfuQtj4wu1fHh1uE1x9N/SJS4au/yp87j0wmNNLWXsCz819SZvJ4FkS2JiOuHohaRT0JZv6hc35d4xyVMKQUoETSP9e/iogUV6r5Qy1tiPfmBGVglhOzmxNCkkKkwX2ORH98w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663993; c=relaxed/simple;
	bh=s4noOQ8Cks+3eRUB2ylzGQ8oWydfQD5cPB3Yhp8RbMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zv7ufjRXTSZ7Y2V2RmT6sn0s2J/MJYfTdRSnBuhve3M47nA79us0bjxZ/IoiYBpVdN9usYjZxa2Q3CzIwzG54Pyw2J+/u8QDPdfAUzvEyrY8r4EKUn2JsOEneUn4DmcyMCkHpQl5ziotRb8rxYszsZfbQYI3v7GJP3P7ySPYJr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 662a2f3c7c2611f1aa26b74ffac11d73-20260710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c25ac138-073c-4421-bd7d-630fb60023c1,IP:0,U
	RL:25,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:50
X-CID-META: VersionHash:e7bac3a,CLOUDID:fdb9896a82871974584b439cf41aae64,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:99|82|11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 662a2f3c7c2611f1aa26b74ffac11d73-20260710
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 779862429; Fri, 10 Jul 2026 14:12:58 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Mark Greer <mgreer@animalcreek.com>,
	netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH net-next] nfc: digital: Do not dump a NULL response in command completion
Date: Fri, 10 Jul 2026 14:12:54 +0800
Message-Id: <20260710061254.80975-1-lilinmao@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306445-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:mgreer@animalcreek.com,m:netdev@vger.kernel.org,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:lilinmao@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lilinmao@kylinos.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lilinmao@kylinos.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:from_smtp,kylinos.cn:from_mime,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E9DD7378F2

digital_wq_cmd_complete() dumps the response data whenever cmd->resp is
not an error pointer.  However, a driver can legitimately complete a
command with no response skb at all.

digital_tg_send_psl_res() is the only caller that passes timeout=0,
meaning no response is expected once the command has been transmitted.
On that path trf7970a completes the command with

	trf->rx_skb = ERR_PTR(0);

which evaluates to NULL.  IS_ERR(NULL) is false, so the NULL response
passes the !IS_ERR() check and cmd->resp->data and cmd->resp->len are
dereferenced whenever the debug print site is enabled.  The driver
guards its own dump with "trf->rx_skb && !IS_ERR(trf->rx_skb)"; the
digital layer is missing the NULL half of that test.

Use IS_ERR_OR_NULL() so that NULL responses are skipped as well.  The
callback on that path, digital_tg_send_psl_res_complete(), never
dereferences resp and dev_kfree_skb() accepts NULL, so only the debug
dump needs fixing.

Fixes: 59ee2361c924 ("NFC Digital: Implement driver commands mechanism")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
A separate cleanup patch, "nfc: trf7970a: Use NULL when no response is
expected", replaces that ERR_PTR(0) with a plain NULL.  It does not
change behaviour (ERR_PTR(0) is NULL), so this fix is needed either way;
if that patch lands first, read "trf->rx_skb = NULL;" above.

Link: https://patch.msgid.link/20260706075743.564658-1-lilinmao@kylinos.cn

 net/nfc/digital_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/digital_core.c b/net/nfc/digital_core.c
index 7cb1e6aaae90..18236221d898 100644
--- a/net/nfc/digital_core.c
+++ b/net/nfc/digital_core.c
@@ -127,7 +127,7 @@ static void digital_wq_cmd_complete(struct work_struct *work)
 
 	mutex_unlock(&ddev->cmd_lock);
 
-	if (!IS_ERR(cmd->resp))
+	if (!IS_ERR_OR_NULL(cmd->resp))
 		print_hex_dump_debug("DIGITAL RX: ", DUMP_PREFIX_NONE, 16, 1,
 				     cmd->resp->data, cmd->resp->len, false);
 
-- 
2.25.1


