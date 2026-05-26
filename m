Return-Path: <netdev+bounces-291500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLWrErUCFWruSAcAu9opvQ
	(envelope-from <netdev+bounces-291500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 04:17:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF37B5CFC78
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 04:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18E8E3008C36
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 02:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DB5282F27;
	Tue, 26 May 2026 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="RZnTFp2f"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819D9142E83;
	Tue, 26 May 2026 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779761842; cv=none; b=oY6vPVkKaZOPc3wqBLKuzxSU1SaTO0HN2OFmpr8PtWU01eS/VV2kfm5hxRHX69da6eZvab6AivxvF9ePx148Tt0PfbRituCpbjPF1Zl46+KH/BNb+YZ0SNTtidZlSZxIHQiQptSByTLEU5DMtRRfUwv/aPP/4fje0CpWqPI+gpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779761842; c=relaxed/simple;
	bh=5wlFUwNsemdHkYYylNHIaxF5HKKzOAK/NN9CBvVxyOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rDc3sIFkfmal7nEFh5YMGvW62F9hziNeVrOoVbL8yimPbCILmCwHh2QXfhseKRNveeTsv4DThiHWnQD1jm0mXsantRD1zdg8lsW+4MEiJ4BdJn7C1MK7obDmPGgGHW6MAR34G/bWnyRU2XMx6r8hM6WsZD+rgAflBUcNfOYYP+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=RZnTFp2f; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779761561;
	bh=Nu4cPXwroNrz2D4CRSWAeI/sb3BYOBt4r8Pa4FG9tSg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=RZnTFp2faIroJFwSybcStF5cUiUuXW1n7zkWfj3M25gRQdjZW8OVfMhwBKziUhfPD
	 MXlZEE78TXpsKr6hdYo8LhYRDgPH9HbrnsM3MXMr3M7x2fnqUFWNULYRgMsutCGj2q
	 Zq/MjiYdPkQIo+LBGB4v5DtsjmxnUGqfRPYHR2K8=
X-QQ-mid: zesmtpgz8t1779761542t12c70da1
X-QQ-Originating-IP: 9R+XQFF3b2N4mWBsn5+y7WnzSY0UZJ/G8lJY3+QFoic=
Received: from localhost.localdomain ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 May 2026 10:12:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3026031675004668251
EX-QQ-RecipientCnt: 11
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH net] ice: dpll: fix memory leak in ice_dpll_init_info error paths
Date: Tue, 26 May 2026 10:11:54 +0800
Message-Id: <20260526021154.2774526-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MyhNtuNETree8JZqrd/RxdgQ50WIxpjLpFACBnMD0nyPXFSski9svKoy
	2dLFnO/VD3LKkIXY2i3y/gDZG1QMmDMt5saRhARfJsfPvlef/WbOVXWzoV114pGSnhWyWqc
	/+cq9KAQjAWv/khjy1Sly45Jv5hItERQRUZnHUYzvAFEMKW7vQCLZyqhz7Eic2B4H7Nq6Zn
	wrJCRLh7du93Yx4JwMuwErIaaSHdNio4/9mqcewsU6ZPpemvCmoTwPkN0dyznMwOrz8rYE9
	OQMjAsviSP47jIeeMD25lL1aLCDNeAUYUq+cUQfKdq8V81s1V/LQBvUOtPaC6c5WUrQvJpM
	srUjaKnHsH5v9PtnWej4Fnkh6d+J9THf9FypjBt/Kw2TwzafQo/ggAOJwL4gYI3a1xbahLd
	x+4iNizAZb/U6DWdpSh24UEXdHWwHn7ZMWUkSMNo3rDLaCwQ0l86j+PLE9EAaYsFbgDnr8v
	Kef2y2Kg3unx7C7SRM79UixmSuV1trRHCAb/pfniaWp56uvsno5u1ole+MDSGrILW3oEIjO
	QG/vZnc6MLs4P54wmeHmGr6150mXZrzXFnQ7xpOjoszWVz1E7PoGNRY0l2KQG9Xb+YXipDv
	UfRfGFL9Y++p9Bl+4Z6IapJ1AaFPneME3nKwNdAm28Q1LGLCOpi3ZPcCMBPMnx1MZ9nYSf4
	ugeDu2zRg95KY93Bd6QcVqILN8BEyJm1LfM9vArwszYR03S50GwoGb2+Fw2qx8TK8RlOFeL
	a6f7/vIT6mffF+JSHCfZCRigdzxQHn1x+tHJkGFVvUBrmF7sWWNkYf3T2/4RH73v10Ftmyf
	1ApAZ2qg3BPaVJ9t9Ed+MP0vFyc3Tqj51P+nlfTn+G7sXK5d3bF9T+wVnvJP0ziMpcJKt/A
	eePttLZigKCa7xNz0tZ4kSQY+OPKNBRuInxrX9m8opKQ2QPqIsnj3ZWoWImYRLlF4XMS51r
	IA8MXZq5xj9XfXcelZiTOjetbBUNonAq+zcE+UY4RTzyYQz0ZAfZoGbzDU/S0WXwlvghCcG
	YrjaGnL1Dx4TeTxyDA
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-291500-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AF37B5CFC78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Several error return paths in ice_dpll_init_info() directly return
without freeing previously allocated resources, causing memory leaks:

- When de->input_prio allocation fails, d->inputs is leaked
- When dp->input_prio allocation fails, d->inputs and de->input_prio
  are leaked
- When ice_get_cgu_rclk_pin_info() fails, all previously allocated
  inputs/outputs/input_prio are leaked
- When ice_dpll_init_pins_info(RCLK_INPUT) fails, same resources
  are leaked

Fix this by jumping to the deinit_info label which properly calls
ice_dpll_deinit_info() to free all allocated resources.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 892bc7c2e28b..3cf098e67563 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -4341,12 +4341,16 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 
 	alloc_size = sizeof(*de->input_prio) * d->num_inputs;
 	de->input_prio = kzalloc(alloc_size, GFP_KERNEL);
-	if (!de->input_prio)
-		return -ENOMEM;
+	if (!de->input_prio) {
+		ret = -ENOMEM;
+		goto deinit_info;
+	}
 
 	dp->input_prio = kzalloc(alloc_size, GFP_KERNEL);
-	if (!dp->input_prio)
-		return -ENOMEM;
+	if (!dp->input_prio) {
+		ret = -ENOMEM;
+		goto deinit_info;
+	}
 
 	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_INPUT);
 	if (ret)
@@ -4371,12 +4375,12 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 	ret = ice_get_cgu_rclk_pin_info(&pf->hw, &d->base_rclk_idx,
 					&pf->dplls.rclk.num_parents);
 	if (ret)
-		return ret;
+		goto deinit_info;
 	for (i = 0; i < pf->dplls.rclk.num_parents; i++)
 		pf->dplls.rclk.parent_idx[i] = d->base_rclk_idx + i;
 	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_RCLK_INPUT);
 	if (ret)
-		return ret;
+		goto deinit_info;
 	de->mode = DPLL_MODE_AUTOMATIC;
 	dp->mode = DPLL_MODE_AUTOMATIC;
 
-- 
2.20.1


