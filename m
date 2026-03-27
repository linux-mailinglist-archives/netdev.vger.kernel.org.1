Return-Path: <netdev+bounces-272306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDljL5XXxWnQCAUAu9opvQ
	(envelope-from <netdev+bounces-272306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:04:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE4333DB50
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79F9D3044BAE
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED202FB0A3;
	Fri, 27 Mar 2026 01:03:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A5726CE2D;
	Fri, 27 Mar 2026 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774573382; cv=none; b=YxMrq359KK+KEMdy4FQOGXWWygmMrO/7SgTfHoPTNZJld/JiIPQyBkMa72tEyedQToyQO0bkTRmCBtd0Z6LlB2IhTK6tqpmR221Sp489TtUZxbZB+b1eH6ja6zpGxlUUm7ilOTRCXwgxSujLgQRgzf8L/jUrvhka2xXD3pfj5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774573382; c=relaxed/simple;
	bh=E8zomibymbSCUjYxhszl+fyDUPepXPe0TgkLnJgTYRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQlVHfD4T+oDJXC4EHNE2beyO4A2oN8Cn1rAKP/09GfspNP/grdb502l+q+eljaMKo+0QK7yH/LKL23rF3Tp2dTPG1MOVDcIcAI4tf62n1RmfmH87msmhXLJHq3Sx37ZKfO5hi5T7H6kDGHPw97jwGTOOtIxmdBYjiTp0Y3UKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowABnieAr18Vp9gH5Cw--.46527S2;
	Fri, 27 Mar 2026 09:02:35 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: michael.chan@broadcom.com
Cc: pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH net v5] bnxt_en: validate firmware backing store types
Date: Fri, 27 Mar 2026 09:02:35 +0800
Message-ID: <20260327010235.42668-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnieAr18Vp9gH5Cw--.46527S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4kCr13Zw18KrWrJr4xJFb_yoW5ZFykpF
	s8GFWaqr18Gr1aqay5KF109rn8uw4Sv348JFy29w1FvF1avF15A34kCFyavryDurWkury3
	tF4Yyws5G3yDXwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUpwZcUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272306-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 1FE4333DB50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bnxt_hwrm_func_backing_store_qcaps_v2() stores resp->type from the
firmware response in ctxm->type and later uses that value to index
fixed backing-store metadata arrays such as ctx_arr[] and
bnxt_bstore_to_trace[].

The firmware response type is defined to match the queried request type.
Validate that resp->type matches the current request before storing it,
and keep next_valid_type in a dedicated variable so loop control stays
clear for non-valid or unchanged entries.

Fixes: 6a4d0774f02d ("bnxt_en: Add support for new backing store query firmware API")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
v5:
- resend in a new thread
- add a lore link to the previous posting

Link: https://lore.kernel.org/r/20260327003845.27877-1-pengpeng@iscas.ac.cn

v4:
- validate that resp->type matches the queried type
- keep next_type only for loop control

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 30 +++++++++++++++++------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0751c0e4581a..6dd35942640d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8692,15 +8692,18 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 		u8 init_val, init_off, i;
 		u32 max_entries;
 		u16 entry_size;
+		u16 req_type;
 		__le32 *p;
+		u16 next_type;
 		u32 flags;
 
-		req->type = cpu_to_le16(type);
+		req_type = type;
+		req->type = cpu_to_le16(req_type);
 		rc = hwrm_req_send(bp, req);
 		if (rc)
 			goto ctx_done;
 		flags = le32_to_cpu(resp->flags);
-		type = le16_to_cpu(resp->next_valid_type);
+		next_type = le16_to_cpu(resp->next_valid_type);
 		if (!(flags & BNXT_CTX_MEM_TYPE_VALID)) {
 			bnxt_free_one_ctx_mem(bp, ctxm, true);
 			continue;
@@ -8708,14 +8711,23 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 		entry_size = le16_to_cpu(resp->entry_size);
 		max_entries = le32_to_cpu(resp->max_num_entries);
 		if (ctxm->mem_valid) {
-			if (!(flags & BNXT_CTX_MEM_PERSIST) ||
-			    ctxm->entry_size != entry_size ||
-			    ctxm->max_entries != max_entries)
-				bnxt_free_one_ctx_mem(bp, ctxm, true);
-			else
+			if ((flags & BNXT_CTX_MEM_PERSIST) &&
+			    ctxm->entry_size == entry_size &&
+			    ctxm->max_entries == max_entries) {
+				type = next_type;
 				continue;
+			}
+
+			bnxt_free_one_ctx_mem(bp, ctxm, true);
 		}
-		ctxm->type = le16_to_cpu(resp->type);
+		if (le16_to_cpu(resp->type) != req_type) {
+			netdev_warn(bp->dev,
+				    "unexpected backing store type %u returned for request type %u\n",
+				    le16_to_cpu(resp->type), req_type);
+			rc = -EINVAL;
+			goto ctx_done;
+		}
+		ctxm->type = req_type;
 		ctxm->entry_size = entry_size;
 		ctxm->flags = flags;
 		ctxm->instance_bmap = le32_to_cpu(resp->instance_bit_map);
@@ -8731,6 +8743,8 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(struct bnxt *bp)
 		for (i = 0, p = &resp->split_entry_0; i < ctxm->split_entry_cnt;
 		     i++, p++)
 			ctxm->split[i] = le32_to_cpu(*p);
+
+		type = next_type;
 	}
 	rc = bnxt_alloc_all_ctx_pg_info(bp, BNXT_CTX_V2_MAX);
 
-- 
2.50.1 (Apple Git-155)


