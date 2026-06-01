Return-Path: <netdev+bounces-293703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPTdLvBuHWp/awkAu9opvQ
	(envelope-from <netdev+bounces-293703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:37:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C83F361E667
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B30EE3009E20
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEFA36BCF2;
	Mon,  1 Jun 2026 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gVfesZXj"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAEF369970;
	Mon,  1 Jun 2026 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313820; cv=none; b=YInf74UNdFTZ8SMDuaM28erjVim6AJUbnLJdgtlho3z7bOa+PPTnE/00Cb93ky3Xb3CMltA5m5lKLDQL7uTsT4jzocoxpcErRufxCE6ZzxiT2cfZ9HRLMIFsaU49BJ+I7v6qfBzDeF5r7QLqy1b/GApjsY/nh84znpVsMvX5f0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313820; c=relaxed/simple;
	bh=j6a4d3zpFuVOFU00p07QqZ5aE+rM4UB+7K0gTRo3nEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDH4uWFl7QadnKNwLExP+vvgigby9ceagQ6BrR5ubipz/83HyqYSlQGmK+6JfKMesQo9DqsD4i4Lby9pId2b7DVGRVmWYN2VofgWmXkMzz+bJB6YUeTgz9Td9DMODgOG7SCNfr/GE2iVICHeQ5oWA9R62a+CubUDfD3dy0iDFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gVfesZXj; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 30e130fa5dae11f18dc8c9802ae25ab1-20260601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6xafbRXrQYJcQWI35leRcnL8SW7t3QtBe6w0y/exT90=;
	b=gVfesZXjsuuiecNsZdi3yt633qkDMQq/HsOZdc49LiOO4rWe/R6x0gEj+1zxqNnO4JQldUQnxGupD+nD9obJ61Rx+5lz1jc7+r+LbFH8GWfdrFSi1BeC3onZCBbwzcJsMbH/B+mn4h2l75ffxMXM4LwlN5TYGMS+aTN7gWNjQo4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:d780153d-fe90-4e12-824a-3cf82027b7e9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:2e048a30-3aec-4081-ae32-d2e919a47e1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|123|836|865|888|898,TC:-5,
	Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 30e130fa5dae11f18dc8c9802ae25ab1-20260601
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <jianyu.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 194912427; Mon, 01 Jun 2026 19:36:55 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Jun 2026 19:36:53 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 1 Jun 2026 19:36:53 +0800
From: <jianyu.li@mediatek.com>
To: <kuniyu@google.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <willemb@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<black-ch.chen@mediatek.com>, <ivan.tseng@mediatek.com>,
	<jianyu.li@mediatek.com>
Subject: [PATCH net v3 2/2] af_unix: Add test for SCM_INQ on partial read
Date: Mon, 1 Jun 2026 19:36:40 +0800
Message-ID: <20260601113640.231897-3-jianyu.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260601113640.231897-1-jianyu.li@mediatek.com>
References: <20260601113640.231897-1-jianyu.li@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293703-lists,netdev=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[mediatek.com:server fail,sin.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[mediatek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianyu.li@mediatek.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mediatek.com:email,mediatek.com:mid,mediatek.com:dkim]
X-Rspamd-Queue-Id: C83F361E667
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jianyu Li <jianyu.li@mediatek.com>

Add test to verify that when a skb is partially consumed,
unix_inq_len() return correct remaining byte count.

Before:

  #  RUN           scm_inq.stream.partial_read ...
  # scm_inq.c:165:partial_read:Expected remain (512) == *(int *)CMSG_DATA(cmsg) (768)
  # partial_read: Test terminated by assertion
  #          FAIL  scm_inq.stream.partial_read
  not ok 2 scm_inq.stream.partial_read

After:

  #  RUN           scm_inq.stream.partial_read ...
  #            OK  scm_inq.stream.partial_read
  ok 2 scm_inq.stream.partial_read

Signed-off-by: Jianyu Li <jianyu.li@mediatek.com>
---
v3: Align macro definitions
v2: Follow reverse xmas tree ordering in partial_read test case
---
 tools/testing/selftests/net/af_unix/scm_inq.c | 54 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/scm_inq.c b/tools/testing/selftests/net/af_unix/scm_inq.c
index 3a86be9bda..6268b5bf50 100644
--- a/tools/testing/selftests/net/af_unix/scm_inq.c
+++ b/tools/testing/selftests/net/af_unix/scm_inq.c
@@ -8,8 +8,9 @@
 
 #include "kselftest_harness.h"
 
-#define NR_CHUNKS	100
-#define MSG_LEN		256
+#define NR_CHUNKS		100
+#define MSG_LEN			256
+#define NR_PARTIAL_READS	3
 
 FIXTURE(scm_inq)
 {
@@ -120,4 +121,53 @@ TEST_F(scm_inq, basic)
 	recv_chunks(_metadata, self);
 }
 
+TEST_F(scm_inq, partial_read)
+{
+	char buf[MSG_LEN * NR_PARTIAL_READS] = {};
+	char cmsg_buf[CMSG_SPACE(sizeof(int))];
+	struct msghdr msg = {};
+	struct iovec iov = {};
+	struct cmsghdr *cmsg;
+	int err, inq, ret, i;
+	int remain;
+
+	err = setsockopt(self->fd[1], SOL_SOCKET, SO_INQ, &(int){1}, sizeof(int));
+	if (variant->type != SOCK_STREAM) {
+		ASSERT_EQ(-ENOPROTOOPT, -errno);
+		return;
+	}
+	ASSERT_EQ(0, err);
+
+	ret = send(self->fd[0], buf, sizeof(buf), 0);
+	ASSERT_EQ(sizeof(buf), ret);
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = cmsg_buf;
+	msg.msg_controllen = sizeof(cmsg_buf);
+
+	iov.iov_base = buf;
+	iov.iov_len = MSG_LEN;
+
+	for (i = 0; i < NR_PARTIAL_READS; i++) {
+		remain = MSG_LEN * (NR_PARTIAL_READS - 1 - i);
+
+		memset(buf, 0, MSG_LEN);
+		memset(cmsg_buf, 0, sizeof(cmsg_buf));
+		ret = recvmsg(self->fd[1], &msg, 0);
+		ASSERT_EQ(MSG_LEN, ret);
+
+		cmsg = CMSG_FIRSTHDR(&msg);
+		ASSERT_NE(NULL, cmsg);
+		ASSERT_EQ(CMSG_LEN(sizeof(int)), cmsg->cmsg_len);
+		ASSERT_EQ(SOL_SOCKET, cmsg->cmsg_level);
+		ASSERT_EQ(SCM_INQ, cmsg->cmsg_type);
+		ASSERT_EQ(remain, *(int *)CMSG_DATA(cmsg));
+
+		ret = ioctl(self->fd[1], SIOCINQ, &inq);
+		ASSERT_EQ(0, ret);
+		ASSERT_EQ(remain, inq);
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.45.2


