Return-Path: <netdev+bounces-270200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wITuNXN7vmm8QwMAu9opvQ
	(envelope-from <netdev+bounces-270200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 12:05:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC442E4EBE
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 12:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80692308FF2F
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 11:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCF631B11E;
	Sat, 21 Mar 2026 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="Td8Ljgcm"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD1136A023;
	Sat, 21 Mar 2026 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090814; cv=none; b=rs8stPWx3PZKVxWC+lZkH1o1SjW3ywZz8qrcJIeLRQGiW8ZxMbm2jRswYh7jerFEQxBtgH6kDBXEaO1ykE+8W66K9uc2H0inixIithCRmeXUN/65Zb5w6A267KwwM8qffkfUQ3Dhpqk52nhVKCv+ERGLDXXb3VZ29O4/UiN9ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090814; c=relaxed/simple;
	bh=Her4TVnRRRZLPOu6Y6Iy0P2Rc4rIDQ9BEj8k18u6ei8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cQlC54SrX5yss7WrkMlOtQ5Bd2E/dlzzedXmfoHlaN/wGtHjrCISRawTb2tFKbzxeDJmd8zSC/M0nkwbbz4Fx/5uvd2CURG54zlQCwHfZkxDJBysb35fcTSjqhLKC8fkgdgikmUxbUkDxdWuTEkV4FlRjTmkXxkoC/bkaTZBI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=Td8Ljgcm; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090799;
	bh=NbjlXZpAUcDFtGW25N3WcRXrSh4ePg4PtCg+sb2ksls=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Td8LjgcmIKDwXsxfFbdIiMkaKROJqOUsaVunoCzycZNxyf27EGhUS0sh32UaJqmXe
	 DBcoMItlpd54/A7C3Xh79h0oobBxL5Fu6GOmpmWsyxxveVYqpCP7oRegcdl8lcN8co
	 CtiWDpdJL9ugnhG+bdKazsUWK+6RlAClCWtnFFNE=
X-QQ-mid: esmtpsz17t1774090794t57ab8ffa
X-QQ-Originating-IP: HTnEHFDoW4tXjXu4ijfOUF09MjzUkto/l3UcDzs3fXw=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 18:59:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18300758741007282704
EX-QQ-RecipientCnt: 15
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] tcp: update outdated comment for removed _decode_session6()
Date: Sat, 21 Mar 2026 18:59:51 +0800
Message-Id: <20260321105951.8314-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: M6Wwv1ws7JqNkwrFAxde172zQgyn9Dwi6RB29OlljzUdLdh2Fa4pRJKe
	Zaq1ABiiEDs2i50A2BVoTHgG29i6849smuGVnlw035hcsDatcCC/AemW/tq4Up33gWAR2Ke
	iDWwVk1BJJuTqDMBGJnFpdKj9K5s5ZRpKXDbAUHYKlMOFI0R0A4gYLQdvZ8l5sTCqBC4DiO
	jTJurxczosFn7wVmrjiCqroMH5myy9s6nPQuIbnceMhfJCdOtjR89wgVcMEeKrVVX/rUuKL
	PijOiG0RtYq7D5Hgcxhe8cY0bv14N6FrsKECb+rQCW55hCrO5FdylY6eHwKIDF4x+eEIEy/
	mBMlP6p8liI0KsafrW91SgUGQivG1vBWy41obneqhoQ16nl0CVpqXGqRZ/8exRMAdhl4srB
	tgVM/5IuTSz/9SX9LMplNHrtF0gEWdE/r2J6zfifLTIhmkqrUgpZbmMONsWS2TMZcfuR0n9
	2gc+j3AjWYcP+mloHMs02Hy4dhuEVAxungO/zGGP1zqxbKF67jUJbAg8ddew+ISsjkYvKxZ
	6dBVNflInDFhpChSyLgbcJvAwxA+205d+jEzqyBLa42MQufQvlzTUmt+QCGFoZW567aZSD9
	sONZH1QFKbsrIoJwEgMlJCyS44G/EspAUuxhKafS4WqlbuYp84PpikNOYaOwh0b9t1ktC6w
	0xrWYRtZ6jKjijJ40qA8JdtyrrADPyoTUlD1yAV3AREHwxMQxSTKri8/kYci6pKtnuFJTK9
	cc1Xa2d2Rcmng9R6y1/CRimpSqapvgRTwy1DtMOZLkN2UUnlGOeK2ooZRE0/MaNqMWc4azo
	K/hMs0JrqiYx1U7r0bTcw+po4vkXT/1NZUgy/WzExY/Gruz7gTfvVllyMffXnf7WRHQfyTI
	HQTzfqh66LSKs9JAsakZuEczHknJ0b8uP/JXpU2+I+svFwB81QtN3gNnucvjAWjzBnjUA4G
	RniJud3vwQzuijB95dSC0gG0PonXoTxHgWt9RhrYrzByIWSzr54+hEd0TF11OlQaHEqtM2f
	cCxm0n03d/KnkgODVc2wkl58hoMv7tAmc5bDP3RuuACOwLNnRcEO9QIVJZ1dNgwzFCv+ruc
	CM8X23hMfOF7Rh3tXOrxyMDa9xZULVmkQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270200-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smail.nju.edu.cn:dkim,smail.nju.edu.cn:mid,nju.edu.cn:email]
X-Rspamd-Queue-Id: 6CC442E4EBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The function _decode_session6() was moved to
net/xfrm/xfrm_policy.c and renamed to decode_session6() by commit
c53ac41e3720 ("xfrm: remove decode_session indirection from
afinfo_policy"), and was later refactored to use flow dissector
instead of accessing IP6CB() directly by commit 7a0207094f1b
("xfrm: policy: replace session decode with flow dissector").

Replace the stale function reference with a general description of
the ordering constraint.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 net/ipv6/tcp_ipv6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d10487b4e5bf..84d95e76085a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1690,7 +1690,7 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 {
 	/* This is tricky: we move IP6CB at its correct location into
 	 * TCP_SKB_CB(). It must be done after xfrm6_policy_check(), because
-	 * _decode_session6() uses IP6CB().
+	 * the flow decoding during XFRM policy check uses IP6CB().
 	 * barrier() makes sure compiler won't play aliasing games.
 	 */
 	memmove(&TCP_SKB_CB(skb)->header.h6, IP6CB(skb),
-- 
2.25.1


