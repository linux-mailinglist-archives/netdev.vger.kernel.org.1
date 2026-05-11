Return-Path: <netdev+bounces-286689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANryHnDqAWpHmQEAu9opvQ
	(envelope-from <netdev+bounces-286689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:40:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9295105F0
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37EDB3033FA3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4AC3FF8AF;
	Mon, 11 May 2026 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxmlJzf0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07883FE347
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510073; cv=none; b=WFEDFTplZBpCmP72aM3yRcPlf99sbUHsPx0tap7ZkespLOJAWLU3uqhN0Iu7w6iZrLKI4FgzKLsbSgoMgfnIOH7dJ8zanCiy2WcTQvz0qnU7wnE7X/eeCU2p5EzaYRQqHL1r9XwLYmNj+Hze+Cfr/uVfgN3jhmczlR0T4eCxd6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510073; c=relaxed/simple;
	bh=e2R8DBscIk19IhJxMXZPQpQwLfnAMEQ7rmfH0FSfdQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQrNAWnl2jfopSPxia/VqVEArb8cfEpKPWNMkbiF2o6AGniiPzQP0t2XJrJ1f/G9ckRZyIqbja5anzWd2t4UqM9TR/7hDB8UkWkCGaQGJR1WmbPvq2gofCLPrbSxwEjZtyUrUEksjs9rkC0Rk7MKY2lJBXcbtrL/SiQNi8WKfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxmlJzf0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5148cbdea08so24468901cf.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510069; x=1779114869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCibvydRPttcdEiskE4PpFNMkbJQi5uTd3rinfvp+sU=;
        b=oxmlJzf0xewfTMPsqupr+ly44IVcQ+TzJLytQe5KFk2ER+2d7xrGPmI7DKSd/Rqm9c
         +gK+2SU7HdXIQSmBGELR8T66XJvoyL9DYA0rQXvpMlLGb/+Zf69BeQNTLofSMPXhs+3s
         ulCJCJN7kPc3hQxcJE/eOLY/swQsyaJxt+wPmFYLFTvx/dZF3c7dkvmC8r648OSJuCtq
         Kl4U7Mga9XKEUCFhEynyWoqCX4+j5mxIATj2mCaVRW9XggTL2DpcwBOD1eh9A9aBEME8
         tn/RtMzizgaWbj4JM7UgRECUTTbGdRk6tRiZcU7rGAiWPuGxkzxlw1T2DqdY9OoRtHEx
         ZW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510069; x=1779114869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCibvydRPttcdEiskE4PpFNMkbJQi5uTd3rinfvp+sU=;
        b=bSiaw1vHvIMcM/qjUTSTVANO508qdO6yXdjxw1mtU8Gg4NcYyy/3nTTGmbT9ew1Vbc
         x4I4b+W+aiK4mwB8YEnJ7PhAzsxuLsaoFbkOrDNxfIi9bj6F4X9S1Oae6e4uRM0U/qEX
         TGpQEZMWhsGZrkI5h+UUbKts+eNbnnSZ10CWUOwtxP4tAWGKY+oPmTx8ZQcj4apE2Rzo
         S04O08BN/WRLHfNbwp5rZs630y5Brqs9RQ3qcqqj6UOQUYrEMd0+T/01FhK9xuBQLkJr
         /y1K7BoFE1AoYCz0hw9SzxdqUhkFFODRtyNNTYVN6T2uzOTEeFwBmX0nD6UzOzYvhz5h
         aCRw==
X-Forwarded-Encrypted: i=1; AFNElJ+o8PnsagDg7G3QTxYeNyR5Taw/suf9+AnhLaFhsrCcrrTe2ctKFl3toY0KsLX3xElF1BM/sDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa5StxjNKhiagMTZ99kGPhpHwKnJSjvRTG6IJEHLB/FkFlWwoD
	zacEdh8nQDGKoVogs4l260zpVu2B/73SiK/8e/xuR2IcZe5mmfBAZX4G
X-Gm-Gg: Acq92OFUqfsuYh/wOBlG1LKO6sS/VJpyMveHNLXUsujvTgxtFnVjvYSLV+ZYJKsVGEb
	BmKogCi2LDRisy3ermgRgMy8vNL1of0HthHu63sZleMXgPeCYHtzmPrbpvmqnzcNXMhn5i1ot70
	XfGvAGF5a7FSTcG0XSYAE+FbRJIIeRaVX5WkZGbj+WYrss27NA7BBE7eKf8eFeJ66f4E4Vcn8cK
	nmA85KVDl+t9uKzLUqDFmgm/MGnoAYBGIuPWuS6qKZ3BwvuyWsuBZwi4Okvjc6gnkQ0yTVdIld+
	XSBjZmCmj9lHywRo8AWMxXF3OYGvO7h2WJVfwzsOXaKwc1KmVspc56yU5x10aHVNXHBPZQIJmeA
	H3HLQrvwGrmFgVyI8pLGyC4C1LYuRLPhBGZYX0UKXCOgIiZA0ehR4pFCvRfT/MoV1nOTYrBOkVu
	WwIWNXmv0CJ3D1iwPp+8rXQOuhFu2ukt993u5fmGp6w9GwsgRwvZ5/fNhM2+K/N8ufpoRanhSlS
	0o6VFfWuVsqjMQm6OGsdFWriOKpvV1mvTD0htYedaYZqq42H+t3cw==
X-Received: by 2002:ac8:5783:0:b0:50e:6054:b4 with SMTP id d75a77b69052e-514a0a2a3b1mr143979381cf.7.1778510069079;
        Mon, 11 May 2026 07:34:29 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83aa2bsm90605371cf.28.2026.05.11.07.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:34:28 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mat Martineau <martineau@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Aaron Esau <git@aaronesau.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH 3/4] Bluetooth: hci_sync: pin conn across hci_le_big_create_sync
Date: Mon, 11 May 2026 10:34:03 -0400
Message-ID: <745aa080da109c4a698a3f1478b3f08e53f2d4d8.1778506829.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778506829.git.michael.bommarito@gmail.com>
References: <cover.1778506829.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A9295105F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286689-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iki.fi,aaronesau.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.939];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

hci_le_big_create_sync() interprets its void *data argument as a
struct hci_conn pointer and dereferences conn->iso_qos,
conn->sync_handle, conn->num_bis, conn->bis, and conn->conn_timeout
after the entry hci_conn_valid() check. As with the sibling
cmd_sync callbacks, hci_disconn_complete_evt() can retire the conn
between the validity check and the body's first deref, and the
blocking wait for HCI_EVT_LE_BIG_SYNC_ESTABLISHED extends the
race window to seconds.

A KASAN slab-use-after-free splat in cache kmalloc-8k at conn->flags
(set_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags)) confirms the bug
on linux-next tip commit bee6ea30c487 ("Add linux-next specific
files for 20260421").

Convert hci_connect_big_sync() to the hci_cmd_sync_queue_conn_once()
helper and balance the conn pin in create_big_complete()'s
-ECANCELED short-circuit. Promote create_big_complete()'s
hci_conn_valid() + clear_bit() pair to run under hci_dev_lock so
that hci_disconn_complete_evt() cannot remove conn from
hdev->conn_hash.list between the check and the write.

Prior art: Pauli Virtanen's PATCH v2 8/8 at
https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/.

Fixes: 024421cf3992 ("Bluetooth: hci_conn: Fix not setting timeout for BIG Create Sync")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/bluetooth/hci_sync.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 43779375209b..47ce9ba63fe2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7265,10 +7265,16 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
+
+	hci_dev_lock(hdev);
 
 	if (hci_conn_valid(hdev, conn))
 		clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+
+	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
@@ -7320,8 +7326,8 @@ int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
-				      create_big_complete);
+	err = hci_cmd_sync_queue_conn_once(hdev, hci_le_big_create_sync, conn,
+					   create_big_complete);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.53.0


