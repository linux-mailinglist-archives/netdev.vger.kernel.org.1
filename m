Return-Path: <netdev+bounces-260309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OA1J4QKnWmtMgQAu9opvQ
	(envelope-from <netdev+bounces-260309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:18:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02915180F39
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 800373044B90
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16971EDA2C;
	Tue, 24 Feb 2026 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="UJpBUgtQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D631DFDB8;
	Tue, 24 Feb 2026 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771899516; cv=none; b=KUT6+51STRBVdiDgltJQWHp1RkAX3Ut5n7qomUHEY8Zrmb7gM59eOAHIEvz3BnNbm1mq8ZFq+Af8m2NfWUSG4+x4YIS9kRPjNNw9HxzSC2N+5N8RUfLVqrzgEUGBMa7oorN0R3ho0X17sGV0p/8n+KVPomHldMujFllkzUz9sKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771899516; c=relaxed/simple;
	bh=44ACn5di4J3w1od786Mkcp7QTDFfaTzS+0u2GgvELDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dzzWkFbEuu6parHIdPnxHD54006l37h6BCmKOthAVABogA2ZI43gMU9q6TBCAQksVylsJbOm3tKMSbp61DyNsaQ0sMZ4SWPZ7unRhKFv5eXzejnmvr1HdJBwqI/o9Kt7DR3XuRSXTB6UTsbpmK7IwP4CSvUTwEc1OltOxrYmQoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=UJpBUgtQ; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1771899508;
	bh=LbvuuLJu4CgcdoGs6th6vU7TlTYjgjZg+n5UER/RNCo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=UJpBUgtQaM0WmSp3JiRjx0Ei9Cf8yOvKh45gSusQgi4RvYOL+pxqEP9pFKOlbFvqM
	 QJR1ZfGY/CrH7bsHhaAbqeWv6PAp32lSoJHCzhnrNqFV5FGI5oTYWhp7uoFjGU5HnN
	 J/r6s3GyXXECGShsOZcUmgWOdkbu/xP/4/0biYoM=
X-QQ-mid: esmtpgz10t1771899506t16bd0e9e
X-QQ-Originating-IP: 50H3+bxVZtbNaEbnu1Lugn3yYR141lDfnh1NJi6sweU=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Feb 2026 10:18:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4511652541337569547
EX-QQ-RecipientCnt: 14
From: kexinsun <kexinsun@smail.nju.edu.cn>
To: steffen.klassert@secunet.com
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	kexinsun@smail.nju.edu.cn
Subject: [PATCH] xfrm: update outdated comment
Date: Tue, 24 Feb 2026 10:18:21 +0800
Message-Id: <20260224021821.1502-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: N9i10iaAV/LhNslK1pwJ3a1JvcfP6WWVzUBn0EY74rstv1GcdEXcpwRK
	ObSYs5454gfdSa6CjkQKJCuJKhiXQrNVsww0tPUE9Yu0M52Yea65P7I7kgABks1IsQpyMGd
	PFtfzOh9yGg96faXOFNRIH/Vd0kisPrd8r3kxHg7nklGtV7ydncMuu7Q/mCLZDOKpQvGmN8
	7zaMJed4Ztc7/aaGdR9bvyDv6UdLHJU4P963DQPDLPAyewPQPJNK0tZDBRqwcozdSlQhrG8
	UJ2MQKMaLeVmrerp8agbQjYcvAn+n7QDnGjeljqoCwK4RRw+IHDZyi7iU7YUmIxc4USI/E+
	MbAkPeebfoQgO4wQh1kUMNhuthbIemDTIGQ8aZ7CoYQ8dcq8Laanur/7Gh9hxWs6E5FmoKP
	wwLg4AIpx7+IWyRP466Wyy4Xe+hsT5UFezlsPl0vIbU6+G/1Q9lEjDpK+siYT6KoS7dB684
	ZTG2lR94OTjTZO4HAL0pzGr35hlT+9oORSmfuEkVjkX92OpcmyRSWr4Zxzrh0Citzp3DWYr
	FC9zbBVyOccx6HAGaw5IyuWZUBHLZ8oQf/qYN+dGgrifrB/Rk7ckY7nhZTd3YtWfVE6hI8l
	ucYwV/avALibvYST+0zQcyAnRq8AFlYEXBeupCAdvc/LjpiL5JigvG6XLlVvvO0xeJoBqRR
	INpRYDOQQDOIibnGwsPTM88UrSBuofDkNoBV+e1nwLpvua3tjmKlP/T1vfMR0/IfPudMH9f
	n4WAQELpamG0ot/PLkvRIDrmqpPv4bSQbQyP/PyYT7UN5PGneqvthF/CrtZ2+cE6LOaju5R
	bp1v802ssDLpEo93Oso6tCqp25reJhbO3D+DGe7RVrdAcmcxIkph3PMDtabUnXWz2WJuToh
	MBY+CbGjsofznrDTKWXaGxzNd3Nt7NnCgL0CS8I6htiIqbcM3OF4KpNvLfyXhlaRg1AGSQ5
	MPr+UnHCqzQucvFmzlFwMmKlYwgVgeKK8wAiFX7q/vN+X8KShSx6bzz4300qJzuEEHGmoII
	zZ7es6CCaG4gsWpi/qIwdwAp2LNopYyoIQxtXZgYXpT8SIYjYxVkgPYG3iZrHJQstWnvcLN
	rucx6jvDt2gMSmjLR5YLByypQotyLEHFq3fZ78QC4Iffkn0m44ZbSU=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260309-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:?];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,netdev@vger.kernel.org];
	DMARC_DNSFAIL(0.00)[smail.nju.edu.cn : SPF/DKIM temp error,reject];
	TO_DN_NONE(0.00)[];
	NEURAL_SPAM(0.00)[0.588];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[14];
	R_DKIM_TEMPFAIL(0.00)[smail.nju.edu.cn:s=iohv2404];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smail.nju.edu.cn:mid,nju.edu.cn:email]
X-Rspamd-Queue-Id: 02915180F39
X-Rspamd-Action: no action

The function __xfrm4_bundle_create() was refactored into
xfrm_bundle_create() (among others) by commit 25ee3286dcbc
("xfrm: Merge common code into xfrm_bundle_create"). The
responsibility for setting dst->obsolete to DST_OBSOLETE_FORCE_CHK
now lives in xfrm_bundle_create(). Update the comment accordingly.

Signed-off-by: kexinsun <kexinsun@smail.nju.edu.cn>
---
 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index ee8bb445c4d3..326824af4928 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3910,7 +3910,7 @@ EXPORT_SYMBOL(__xfrm_route_forward);
 
 static struct dst_entry *xfrm_dst_check(struct dst_entry *dst, u32 cookie)
 {
-	/* Code (such as __xfrm4_bundle_create()) sets dst->obsolete
+	/* Code (such as xfrm_bundle_create()) sets dst->obsolete
 	 * to DST_OBSOLETE_FORCE_CHK to force all XFRM destinations to
 	 * get validated by dst_ops->check on every use.  We do this
 	 * because when a normal route referenced by an XFRM dst is
-- 
2.25.1


