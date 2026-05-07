Return-Path: <netdev+bounces-285412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPk+AAi2/Gn9SwAAu9opvQ
	(envelope-from <netdev+bounces-285412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:55:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6938B4EB8FC
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EA4A30309A5
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8583C3455;
	Thu,  7 May 2026 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="FkbkhSuQ";
	dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="sazczXew"
X-Original-To: netdev@vger.kernel.org
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org [18.158.144.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3F3DCD88
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.144.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169243; cv=none; b=Vpd5cTnwu7wn2z+h5C7C9yEAdwTVx7y8o5I8mB7jT+6PsLQzYXii1Dnv6FtInPrAXW/tMQW9H5YMQUd0dLAgHdc0ugYnCBllOh2jaajMoR09ZXr1fpo0TO7OcIqRgmmFENCuHSl1fvSnIN2GepwVVGd3RLEA8pLn82curjaGa68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169243; c=relaxed/simple;
	bh=MQyMPhQYY5nG5u0uHjoNDtvH7PoDXKZ3ffpzGGja2qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLbGvA0igeFMgPHe/0JEPpWbSGPJAtEGZ48/Vp3vHab9GidzlBhM6WKGQO84392hQ1O/3e92qZcliFDl5vT0AXHVYiAUMhu+cp/+rg/jIid04mTRMYPuw/jaRvtsS3+VFWIrxu9Tm+AJKgXEaCbnByJC8MwSOwgtj5qxoU4LSl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=FkbkhSuQ; dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b=sazczXew; arc=none smtp.client-ip=18.158.144.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=dGs6BVMCuqp4caGYANuHKzUQtLxMT0/xX8YsdTBe72A=;
	b=FkbkhSuQOL5Ig0cVo8/e7vyLR8WTfdNHk93NVwTKmMse844uUn1qXeGWeItxZC2tNajJBzbiDTFcS
	 kP6iXtJH6H34jlvS5TZ1bOc3ZVIeaE26OCTTTdHcrfdHB/IDMVs+2kl3Bi/tvtX/wOUDW6pGw1KOWr
	 4vmbXY1OSZ4/h51Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=dGs6BVMCuqp4caGYANuHKzUQtLxMT0/xX8YsdTBe72A=;
	b=sazczXewa3FfBvFg3iTFdb6bK8rCrLD7RypkO1Nfwpidx4JazpT4J42fSwhDbrKnYNTiwBjk7KODN
	 FKbxirsRDLzBqCeP/vS4tIjLjTuex2XceA0fhANxgzbd3z0DT/neJI1METCnCnv5L9rSIzwU8YuG7P
	 xDbtYkG4wcjVqCZnnTcnMFDzXqoZB+s4jygESyENMfLJkxHduEo5Bx+b0QosFAsZvzS2rax+5wmnXr
	 oPgZYFOHv+yNAbifWxO4HLzGhBJ9OLoPhBMFdc6yg8wpAqTk7y6rE/68+vlXZIE6IDM5TRLSuOhctI
	 iMMUvEe5EeLXINmrKML3EoKm9ju1Uqw==
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: ed25b36b-4a2c-11f1-839c-bda8640e0fbb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: ed25b36b-4a2c-11f1-839c-bda8640e0fbb:15
CFBL-Address: prvs=05870dbd44=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000426.corp.hitachi-powergrids.com (unknown [20.82.50.241])
	by outbound2.eu.mailhop.org (Halon) with ESMTPSA
	id ed25b36b-4a2c-11f1-839c-bda8640e0fbb;
	Thu, 07 May 2026 15:53:45 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000426.corp.hitachi-powergrids.com (Postfix) with ESMTP id 381F480524D;
	Thu,  7 May 2026 15:53:44 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 1C45660B7D47;
	Thu,  7 May 2026 17:53:44 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	horms@kernel.org,
	kuba@kernel.org,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH v3 net] net: wan: fsl_ucc_hdlc: free tx_skbuff in uhdlc_memclean
Date: Thu,  7 May 2026 17:53:32 +0200
Message-ID: <20260507155332.3452319-1-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.52.0.120.gb31ab939fe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6938B4EB8FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hitachienergy.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hitachienergy.com:s=duo-1630306886989-947ac67a,outbound.mailhop.org:s=dkim-high];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[holger.brunck@hitachienergy.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285412-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[hitachienergy.com:+,outbound.mailhop.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When the device is removed all allocated resources should be freed.
In uhdlc_memclean the netdev transmit queue was already stopped. But at
this point we may have pending skb in the transmit queue which must be
freed. Therefore iterate over the tx_skbuff pointers and free all
pending skb. The issue was discovered by sashiko.
Tested on a ls1043a board running HDLC in bus mode on kernel 6.12.

https://sashiko.dev/#/patchset/20260429114208.941011-1-holger.brunck%40hitachienergy.com
Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
v3: - add test setup to commit message
v2: https://lore.kernel.org/linuxppc-dev/20260506111529.2919079-1-holger.brunck@hitachienergy.com/
    - use dev_kfree_skb instead of kfree
    - improve commit message
    - add missing paramter in for statement
v1: https://lore.kernel.org/linuxppc-dev/20260504161145.2217950-1-holger.brunck@hitachienergy.com/

 drivers/net/wan/fsl_ucc_hdlc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index bc7c2e9e6554..417e8e4c111f 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -739,6 +739,8 @@ static int uhdlc_open(struct net_device *dev)
 
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 {
+	int i;
+
 	qe_muram_free(ioread16be(&priv->ucc_pram->riptr));
 	qe_muram_free(ioread16be(&priv->ucc_pram->tiptr));
 
@@ -769,6 +771,11 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 	kfree(priv->rx_skbuff);
 	priv->rx_skbuff = NULL;
 
+	for (i = 0; i < TX_BD_RING_LEN; i++) {
+		dev_kfree_skb(priv->tx_skbuff[i]);
+		priv->tx_skbuff[i] = NULL;
+	}
+
 	kfree(priv->tx_skbuff);
 	priv->tx_skbuff = NULL;
 
-- 
2.52.0.120.gb31ab939fe


