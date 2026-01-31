Return-Path: <netdev+bounces-255331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLWGNip2fWn+SAIAu9opvQ
	(envelope-from <netdev+bounces-255331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:25:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54710C0823
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 379AC300D9E1
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026C134BA20;
	Sat, 31 Jan 2026 03:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KcvhrEUK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFCD2E54D1
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769829926; cv=none; b=szKOh53eg+NSHJPBTAdklkaHRQoPsI7D9DLuydVAmwiAwa/dRm6ZSrSyqF4o6IJrT6D9bI5hFuKAjH20/hfodTXIp4rcS+7N+rRy9kv4asCYIG5eLcCpNVV8kWIuIB88J9VgYKkVA+4pdu/IbkKahfjstmnZG+vbPQw+Tid4elM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769829926; c=relaxed/simple;
	bh=aF0LISwd+VpEPk11P7VZVOQLMUS9MJgmvjrjNH7QfGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q6BO4xk0JKCAQtiH8cdo2wNG/vtOqcYjTSMrkVIi2S8wAlgM6cRiTKi87131chuz388hC53LvAAKCBkmpxuKPoBtcaGieAMi+hjQriuxW+7hnbXX14BmeLZfEBkpPqin5Lx9afDgV7lHhDA4cTK7mbhP+IxKmqJvIIgsTk4vrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KcvhrEUK; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UM88sY3981182
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 19:25:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=IRma2fjJglgfYeNqI4
	ndx76dgj1ko8+KrpUQR6Y7YP0=; b=KcvhrEUKKrmU+QRfDoN8DUcc587oFczLb9
	IPKRh7V1DUCb5TCjSOQqIkLT3ogEZfLTASuAmN4abX7aH9xoCLNVaMDiU/jPkfJ5
	PvaTjFMiImDyovlpWmMFD6VIVX/jLxjeix6y9PeZrXSmc7zkbiw9Hzx3y9jWuMiy
	rZlZcTH0UjkyWabjStmx98TiVw9J6cF0ihNihj9kVak/hWV3yeEkJMrmZ0+czg7v
	hRqFoRIZTiGVVOL8SRUdRrAXmdqyWkluvcjKCnNLaDjzjNd4RirN53Lkm1pIEoxR
	FyrdQj3MxGJUNsGBmzpCHP9MMi+WrcdGczX4eBmPLfF47JS7XR4A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c1561j7n1-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 19:25:24 -0800 (PST)
Received: from twshared25002.15.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sat, 31 Jan 2026 03:25:21 +0000
Received: by devbig010.atn3.facebook.com (Postfix, from userid 224791)
	id 45A916F0C75; Fri, 30 Jan 2026 19:25:08 -0800 (PST)
From: Daniel Hodges <hodgesd@meta.com>
To: <netdev@vger.kernel.org>
CC: <jmaloy@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <tuong.t.lien@dektech.com.au>, <tipc-discussion@lists.sourceforge.net>,
        Daniel Hodges <hodgesd@meta.com>
Subject: [PATCH 1/3] tipc: use kfree_sensitive() for session key material
Date: Fri, 30 Jan 2026 19:25:08 -0800
Message-ID: <20260131032508.4158256-1-hodgesd@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KfPfcAYD c=1 sm=1 tr=0 ts=697d7624 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=cPLOpp3optabX5KMabIA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDAyNyBTYWx0ZWRfXxIIHeX3lEVgX
 0WsEJ8KnBDDee2B5vIRyFws+QtQar6DZl8uX/09dN7gfi4L3OFP5PiKrdcUY/OIXemKVflkVHZY
 HFJf7syBMOxY983O92jDVfATjurN33POKUWUVJeft/tfP3VbMoy2Z3Ttvd4ndGld4vEKV6IE0X5
 PVG29cAPP4AlPbLshQDyz913g+QbPro/CDsU40kIxC0fSHrN2wrjL94pXm6ZALJsBjC1zgDo+hP
 oe7JWrGmu1kvEIGYcQZDF0no7J5HbmISzoA+ypUg3qdJeaGlOwQSblfZTgcG2qScXnAfps1Gnkx
 zxODxgoqcYUUObWrstXbRL3vQOhROsGzYNDxCSZD3hXARE7hfkHLrruhfnY8h6EM52Rl/Kvs8RF
 a/h8+Y5CZHYcDJByC1+QaQiu88HWlJt3jyLHLlB5hOgQpiqYbg2QBGe6pmL4w65qwQWZeuTiPO0
 zAYhcc1fbGorb/KmDtQ==
X-Proofpoint-GUID: snD0h2H9cwOHJqJW_HyRmuwLF4Ivpavw
X-Proofpoint-ORIG-GUID: snD0h2H9cwOHJqJW_HyRmuwLF4Ivpavw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_04,2026-01-30_04,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255331-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[hodgesd@meta.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 54710C0823
X-Rspamd-Action: no action

The rx->skey field contains a struct tipc_aead_key with GCM-AES
encryption keys used for TIPC cluster communication. Using plain
kfree() leaves this sensitive key material in freed memory pages
where it could potentially be recovered.

Switch to kfree_sensitive() to ensure the key material is zeroed
before the memory is freed.

Fixes: 1ef6f7c9390f ("tipc: add automatic session key exchange")
Signed-off-by: David Hodges <hodgesd@meta.com>
---
 net/tipc/crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 751904f10aab..970db62bd029 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -1212,21 +1212,21 @@ void tipc_crypto_key_flush(struct tipc_crypto *c)
 {
 	struct tipc_crypto *tx, *rx;
 	int k;
=20
 	spin_lock_bh(&c->lock);
 	if (is_rx(c)) {
 		/* Try to cancel pending work */
 		rx =3D c;
 		tx =3D tipc_net(rx->net)->crypto_tx;
 		if (cancel_delayed_work(&rx->work)) {
-			kfree(rx->skey);
+			kfree_sensitive(rx->skey);
 			rx->skey =3D NULL;
 			atomic_xchg(&rx->key_distr, 0);
 			tipc_node_put(rx->node);
 		}
 		/* RX stopping =3D> decrease TX key users if any */
 		k =3D atomic_xchg(&rx->peer_rx_active, 0);
 		if (k) {
 			tipc_aead_users_dec(tx->aead[k], 0);
 			/* Mark the point TX key users changed */
 			tx->timer1 =3D jiffies;
@@ -2387,21 +2387,21 @@ static void tipc_crypto_work_rx(struct work_struc=
t *work)
 			pr_warn("%s: unable to attach received skey, err %d\n",
 				rx->name, rc);
 		switch (rc) {
 		case -EBUSY:
 		case -ENOMEM:
 			/* Resched the key attaching */
 			resched =3D true;
 			break;
 		default:
 			synchronize_rcu();
-			kfree(rx->skey);
+			kfree_sensitive(rx->skey);
 			rx->skey =3D NULL;
 			break;
 		}
 	}
=20
 	if (resched && queue_delayed_work(tx->wq, &rx->work, delay))
 		return;
=20
 	tipc_node_put(rx->node);
 }
--=20
2.47.3


