Return-Path: <netdev+bounces-260999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOmHLnINn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-260999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:55:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C741990BD
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BBD531025BB
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341543D4118;
	Wed, 25 Feb 2026 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="5cteETRY"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349CF3B8D48
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031138; cv=none; b=NSZ1mjAATKFa9PT7gGap57LQGwQ8k4013D/bAd1QlnsH9t+NdvxErmMsd4JZY5ibrLYYGadd5wwyrigjWMKAQ3aKAxu2C9fqPMAzHpzHgVJqnUVkp58ybVa4QHlq065Kwf23Q8xGj5a+OgCE9YGZCf2U8vqMb3M6ikFMavicq2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031138; c=relaxed/simple;
	bh=opwUYNH38scw+UmNhElFi9TNwz9MwggV9L7fvYqLQrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hT/6+jTcCCshuQIJISTCBlUadgPJmgNecc//0uF1p8Nt/8gsTM3+y2RHMH3p68eGXy6C5UanPQO3t+NTlYlLw2cv3c80nyDyL4OXEh7hnUWIHuYDa7v9eeVkEQaadgrbRAhyI3Its5eio3D5LVwuIxfWFKmuQAyKQRDxSSGCns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=5cteETRY; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1772031125;
	bh=EaLjfNINaEIan7dIiuFrul+vjYsQXQhbKE6yTcVjiKY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=5cteETRYoZ8LW7MRowGrc2v8Cr0TLuyyinA+gBixzAaoZRVDVdt9OxTW4qecVQVoV
	 zGQPPsOgRj/aaVA4jSoVPLW0YXXQYyLiXYztXuxxDAmp+cTRymt2+D9ItpU1hbcLy8
	 Yrztvna1rUh4leURQnYacxGtE9UcJpl+llQLedT8=
X-QQ-mid: zesmtpgz3t1772031124t812d4778
X-QQ-Originating-IP: 9cUJV9iOSMYlGSDt0yiEffx30v+BwPEEEuERR4z3tzc=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Feb 2026 22:52:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9594701865739000727
EX-QQ-RecipientCnt: 12
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	Kexin Sun <kexinsun@smail.nju.edu.cn>
Subject: [PATCH net-next v2] net/hsr: update outdated comments
Date: Wed, 25 Feb 2026 22:51:59 +0800
Message-Id: <20260225145159.2953-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: NOdx4eXqnHG3aqzp+Sn5leOBj1VlvLaX1YUgB68s075OGzEdLwWSyL7U
	/KbVfTk87nA2twhrnIjfqJk2DNITR75hbTLEpF4Kp62QGdQfYan/U6Fw0K9U5pbUmE9Gv2D
	LNmPNUnPv9/ujbJYxEvzewuStBj/BONb2MXbUEvxyMuO+F1V2KGYHGSkgWt4vMDksIL3/L9
	sImSGylMBxEVSN+NGPqbux3HICFxufaU5AetxvDE1Dzf5yirXVoAgDE2OCApdcHLRswnMOV
	/efvqaT6Of6uujTwthWW1LIBToiIGJxeE1YtknQ6KIv1jpqiwu80bz+EGrFkbqe5maSxiL9
	AelCzTSe3AjgQ+wtRBYOeoyHEPZyKfzWCmQWFAl5PBAN+j/QGVc/IaA0g+q6igqGVzRacjw
	EVi/swI3d3yrc1WOjEobR7m6md65s0akmUYotNEpqhmc2+YpKw1NpWXDQLDwAMDdYHGkJE0
	IRZp6uvbnCyfrtEQ6de9gDbt/0XTvKNRJZ8Z/LEvayuIvoV77pcT8XMMlRnrWXnCPPi0tFu
	osNi9TmB6FSLXpscuC7UPHkya5p4eO6Ok8oCLtiOyTXJw0NF41kFRSD74NlPatCugUR8X7z
	KHeOYQlaQMfLc2UvTlWB1GaaT3Qyvoe6VcfeJW5htfCx2zXiZ8nhbpLWaTg/7/S15Y/Jrc6
	D5JUjSc+zpk35YX+t90yitGFPhahplwQin5NwEpT5Y+4OytRBDDtio0+cFBZMqHy1fccBxh
	Seqw2YwQfIR7+oh/GICaSGB2eZcSf+mv0OOM+1jeviiuMbyFoPn9hgFFdRYx3G7RBDmvLPt
	QTomT4bskCVjBOMFG0NrjpQ4asHhFsOLXwKjk90VqjDZbXtyu52eubHZaptudAujaoySbX5
	ML7/1LZXFbKPTLp/30iMKJMKisNWngHW/pjE2WqDuQPnFhyzPFLCSXW7J0NDaH6CbLHFbl5
	Pm85i2qKCaMahST1NsDYpRBNyrO5vB8TA1D8OajyrD2OVOPrdDhJaIg0nZI6aDQ4KF63N3C
	xji7rWVwbLKLFJ6MMIyG8O3dAiYEM+mKKzx481okHPC5xm6AMhTTsWtjhmUwNl9MNiApdd/
	fq0riMbq3YjXhr8UmbomwF8WAXwCfvrF4SqyCYj6Wpw
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-260999-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	DMARC_DNSFAIL(0.00)[nju.edu.cn : query timed out];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 81C741990BD
X-Rspamd-Action: no action

The function hsr_rcv() was renamed hsr_handle_frame() and moved to
net/hsr/hsr_slave.c by commit 81ba6afd6e64 ("net/hsr: Switch from
dev_add_pack() to netdev_rx_handler_register()").

Update all remaining references in the comments accordingly.

Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
Hi Simon,

Regarding your question about how these were found: we are building a 
research prototype for identifying and fixing dangling method references 
in comments. Generally, we use Coccinelle to check for dangling references 
and DeepSeek-V3.2 to generate the fixes. 

Since it is still a work-in-progress, we haven't settled on a proper tool 
name yet. Therefore, I chose to omit the `Assisted-by:` tag in this v2 
patch for now. Do you have any suggestions on what would be appropriate 
to use in this situation?

 net/hsr/hsr_device.c   | 2 +-
 net/hsr/hsr_framereg.c | 4 ++--
 net/hsr/hsr_main.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index d1bfc49b5f01..5c3eca2235ce 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -742,7 +742,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 		hsr->proto_ops = &hsr_ops;
 	}
 
-	/* Make sure we recognize frames from ourselves in hsr_rcv() */
+	/* Make sure we recognize frames from ourselves in hsr_handle_frame() */
 	res = hsr_create_self_node(hsr, hsr_dev->dev_addr,
 				   slave[1]->dev_addr);
 	if (res < 0)
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 50996f4de7f9..577fb588bc2f 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -71,8 +71,8 @@ bool hsr_is_node_in_db(struct list_head *node_db,
 	return !!find_node_by_addr_A(node_db, addr);
 }
 
-/* Helper for device init; the self_node is used in hsr_rcv() to recognize
- * frames from self that's been looped over the HSR ring.
+/* Helper for device init; the self_node is used in hsr_handle_frame() to
+ * recognize frames from self that's been looped over the HSR ring.
  */
 int hsr_create_self_node(struct hsr_priv *hsr,
 			 const unsigned char addr_a[ETH_ALEN],
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index bc94b07101d8..33951d9bd3c5 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -89,7 +89,7 @@ static int hsr_netdev_notify(struct notifier_block *nb, unsigned long event,
 			}
 		}
 
-		/* Make sure we recognize frames from ourselves in hsr_rcv() */
+		/* Make sure we recognize frames from ourselves in hsr_handle_frame() */
 		port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
 		res = hsr_create_self_node(hsr,
 					   master->dev->dev_addr,
-- 
2.25.1


