Return-Path: <netdev+bounces-129050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E4797D37A
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 11:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCFD285FB2
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 09:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3DD52F9E;
	Fri, 20 Sep 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="trKTdoBu"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CEE433D6;
	Fri, 20 Sep 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726823724; cv=none; b=MIIfNAEJni9tztG0VOhEJnmPPyp7W8hb8vP7giz4Qme+PxXu3qLFTxRAbOUrnhCvN6ueeSs4Q4WS2LtEJUs5qhKzUAGb+W4DGrU3XD7q5Tn8WQ71dUFY30DMXkFsLHJjz00O9FetB3m2kyqJHMzdv3dYdiwkv8Y1eKPKOHYlJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726823724; c=relaxed/simple;
	bh=A+iOFCNbVBbZtL98U43+jYe2s7E0pCN4uCInxvd+iak=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=pPpB58pmARDKgbSWK5D2qK3WXHi2lWVm44hwRiYq7qphLHlTqu3ai5nznVtnhielSGFys0bH33lLB821d4+HuN9a5ALSVHV//Yayn1MyKtc9ojM/hB/llz+zjAnosIMvkZkYmG2Xgwq8ztNhv6wkbq6YzabVQ7dxPanqYFCdX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=trKTdoBu; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1726823720;
	bh=E9JMoMR2Sb03SykfAwT0ZGt49t+RkfgcBQ5qjTrpQjA=;
	h=From:To:Cc:Subject:Date;
	b=trKTdoBuztpolAzlsz5nzhhTKvdUH+2j6C2TQaZqQJxF+akiZkV9zgS5Pc7yLEqtB
	 CiEMOjgXYfd9l5Ao4wPSMRgAZs5IEnWVNUGTAM1day31yaVjZ/oY1UdPUB+JZYwLr6
	 mUZAs60WZpYJWvrvxTAPepAbmgHhbDu071aLuUIA=
Received: from localhost.localdomain ([114.246.200.160])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 23AAF009; Fri, 20 Sep 2024 17:08:58 +0800
X-QQ-mid: xmsmtpt1726823338tqg53ksm0
Message-ID: <tencent_2A17499A4FFA4D830F7D2F72A95A4ADAB308@qq.com>
X-QQ-XMAILINFO: OK7NBzdNss/RXE/zwVV5mbLF1AfVnU+2R1mM3ZSfang121kWEEKBTYsiNuhvIf
	 PmL8V8wqdLGVuQUCfoPlVT8gn2dIYBvns70ZrhUtjvotwCeIsiX+fKJ/vV6GOWyEJIvHHyyP0UCl
	 jG8z1r5fvgz9joSNYGdRCDc3PAYqBon58W+3+OyQegaGPjED6UjwfuTbXAeMD+Sg3dCXhedooZcW
	 gIZ1URxt5fWe3lrJraIHEXJ/Uo4+2XKzYUys5sInd0skG0SzHNeUnx+IeescrV8peX0Mm3+3Cw9y
	 efh+b7G7luSuBYiOVpQCB59FWJta26u4woeyUBoned/2doLnNPElZTNseh2q8mEKCx0vHo5SMDUK
	 A3FuiawOKdhCXABiqVMgmzPt1VJK/z0mQhNXJS+V+x/JnEGvc4hZp1Dn14UTvEsVsZvcORCFXnNg
	 hvzNMj+r4/R5DFyuUia3KyhmRjT51zw+vQ6g0m8DPyYI8GZyc6L3JCdqT6qc+EcO7Ut31jf5H72N
	 JDiok8DhMXbLiHMSarVfkyqaQOpYBDCmGupAOci2kxXqa/5gQHL6cmu//Oi9dlgdq53aJ3G7TO+V
	 T28QdrF1tzv6leqdkMH5s2fo3S4JtWgzrrIycfTZNLfzNNCBdW1M44BjkreqbMbZ7TMN5z1pcQCg
	 qN+PsLs+URaYT0ct0HF7wh0RLaShaGxrLzmCNzEtGOihsjWi2aLeyPLOIAcXkFcrYpJaDsXzL7Vm
	 UWc8jBOMhZnaLyAuuV+xsNMZWTn08eAKWFbXZYHOmKMXo4c+xWQ0J9MKNt5huOGU8ooCBPe22u5b
	 eUVAP01hNuTpSOVtg4kJ/sEcoBBX5hRkhr+2nJ/0MDO+rR3t7RaGCyw4fQgHY6z78jBMbjjBfZBD
	 jwo0E91pcTxgkaciQAcdOc366+898aQeVpGOnfiieqR4BsMPJrp/mdBODVklJl5f/T51gjJeS4cF
	 IXyYpyo3rQEsHQpqIKOBq7N7d270VsvY2Yi+g9ED3i4H/IV2ET3Ff4+DejbaF7Z+vmIAqtUNhdy6
	 XRT/fCubKzmJfqxBN4LmfXvJ9wVc/W+WKqKLVwOtZftfcD+bggYYnjdW5PPEQWE6tK12snDbybo7
	 BVVJka
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Jiawei Ye <jiawei.ye@foxmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: Fix potential RCU dereference issue in tcp_assign_congestion_control
Date: Fri, 20 Sep 2024 09:08:58 +0000
X-OQ-MSGID: <20240920090858.2054151-1-jiawei.ye@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the `tcp_assign_congestion_control` function, the `ca->flags` is
accessed after the RCU read-side critical section is unlocked. According
to RCU usage rules, this is illegal. Reusing this pointer can lead to
unpredictable behavior, including accessing memory that has been updated
or causing use-after-free issues.

This possible bug was identified using a static analysis tool developed
by myself, specifically designed to detect RCU-related issues.

To resolve this issue, the `rcu_read_unlock` call has been moved to the
end of the function.

Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
---
In another part of the file, `tcp_set_congestion_control` calls
`tcp_reinit_congestion_control`, ensuring that the congestion control
reinitialization process is protected by RCU. The
`tcp_reinit_congestion_control` function contains operations almost
identical to those in `tcp_assign_congestion_control`, but the former
operates under full RCU protection, whereas the latter is only partially
protected. The differing protection strategies between the two may
warrant further unification.
---
 net/ipv4/tcp_cong.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 0306d257fa64..356a59d316e3 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -223,13 +223,13 @@ void tcp_assign_congestion_control(struct sock *sk)
 	if (unlikely(!bpf_try_module_get(ca, ca->owner)))
 		ca = &tcp_reno;
 	icsk->icsk_ca_ops = ca;
-	rcu_read_unlock();
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
 		INET_ECN_xmit(sk);
 	else
 		INET_ECN_dontxmit(sk);
+	rcu_read_unlock();
 }
 
 void tcp_init_congestion_control(struct sock *sk)
-- 
2.34.1


