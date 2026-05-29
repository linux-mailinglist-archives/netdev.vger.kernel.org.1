Return-Path: <netdev+bounces-292987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJK3C8smGWq9rAgAu9opvQ
	(envelope-from <netdev+bounces-292987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:40:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC75FD6F0
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 291003079312
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE1C38F233;
	Fri, 29 May 2026 05:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Rt3pxMow"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D1A373C1D;
	Fri, 29 May 2026 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033173; cv=none; b=hWoI1PQqPBZ5MbIYZscA17JoNiMaMMGfXeXNRRtaR8OdPev0sEJWh7dWb4mrl8sKVYpzyY/dlHTbfir4jXinJxQvzjwbTLjM9QRFpmowzEzfCnaj7Q+PPcWHrXIRV+4+suPWfXFQgvUHdTbwJnQaoI5S9X2QguCUx6tdlJckLQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033173; c=relaxed/simple;
	bh=f1k16q+xbrl6FBSA/KGVSLMPJ+pJezSgZQGhVVq6yhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMjbFwAgYMe0px0L7Rtw85ryorfYC88iDZm81u17c2pBtdVzKQHxngreadTJBq1RVEboYPlpTBPq4p0WP2N+uGVBPHnRssD4AG9iPpcMtISShlT+pPoXMBapS7oaLbQuA5txJm3nr6dH3TO4du6XYoYG8BmG7U1pxrbb09qxmSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Rt3pxMow; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780033092;
	bh=JRw5xcrSjOiERzxs4QrGB7FXuKGRgXx5pHS4OGkIPuU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Rt3pxMowEKiQ/aZwjHjamuJAOKgsBr2Dym1dsg0XnxtqN7KBKwmviByMFrkpWasXJ
	 kgS3iwluzXDpsOBK41czE09M9+9omSPjQsBKBLBPKKYPEAmW7Jxg744t2AwyCvHeib
	 wbJWrjd0HAGhuHNctZOpDlLenlhilyTy3jl96gHI=
X-QQ-mid: zesmtpsz5t1780033072t7ae2a378
X-QQ-Originating-IP: d7NrgzXasJ3gpHIgPC/KZgg6qQgMWztRLLTXZx+3Lzg=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 May 2026 13:37:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13989401940268503956
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
Subject: [PATCH net v2 1/2] ice: dpll: set pointers to NULL after kfree in ice_dpll_deinit_info
Date: Fri, 29 May 2026 13:37:32 +0800
Message-Id: <20260529053733.764996-2-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260529053733.764996-1-zhaojinming@uniontech.com>
References: <20260528171202.2659491-3-horms@kernel.org>
 <20260529053733.764996-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Od6jZKO+x2euDiO64vibcm/bW3Lls+AQRe+wsjxQnGKkxoK0bb7Jy6KD
	zkNQcN9cwRVvQKH5a3Cm9YbeaJMWdsh3bZffdynTzs4rOa/gWUu6e1cC7v5d4PUkIXvgLxe
	/4w/WfrXYiIf01TbjpvwFKPg5z7gJqxY/dPEUH19zG3Bp/9+f4qLL/iPwiYzc151rUvJ2+Z
	yjfifx33/ToQa3hMyrB12vdLwbXtNUmuCsXe4/9W6Wkl/FaD2saBNhmu9l5fdKZHGFrNJsh
	k3mEsPigXeJe/36K1RGh33CgwOFQLOv40gLYnX3LMP13Sn0XfVKgbZ1Vt9MkghcumPk4TC3
	i1hwZseCyvyooxiz/V/BUBfAvLj10e1qrzW0pfMvm4XmtVCoUCu7zn5THilV13fegfzFtmY
	eBQI27vhAh6yq5BV8u8XwvM+yVHgELIcfW+gPTov/RUa2LY/H48UPMvH37luMEHEHtjN0NW
	8y+4djVDZDfIRQnBpALCBT+gg1XspcfZBEVYaUukYANKfJFr9bmRnlFh+0Rl1NQsaJYJHze
	7pCrEfhSnorpcAdWJ6iVjPaZaXYKeVrQMoMpD7ZivD/F007gXYftB6MykWOjNCQaOX3jpBC
	Ho+eIzgCm+ir1CH8fgJcxOl86QUZqXFjq67je48jHiPmv+Fz/spvuy1s6RqoCx9zSKOrmaM
	tUTpBOXLpdsJfUZXQzcqLEt89HgDAtC38vVfXWQc0Rkzfzt6cW0bZDr3aes3/oBQhLyVRiv
	jUMax7UjaTcDciMlbdZdLk62LFTTAgi/wmPG2YSPyQTyDwvh00IG/pgmkZjUeeL4HCq2kuf
	vgN1Ko5R2613r0y46oGShTGYwa3bMCRfg8kDgDS3rSNH9tFfGxDGviJqhw3Sb2jG7Btcnj7
	zNUkfiOvCTguwIJc/PBSjJZYzf3lOeTGiojv5LDvhQMaJb56RUQWWFqelFTVURjp6yYm9z+
	PRMfd5+nx9BdyERPWCrytNv58GSv1t/itFCrIrCSbpdVvleIIcPXys9CGGvellW/cF2lcwu
	pBDV1Az1IBWuG6NCXtG7rFYlQtFwybp9g3M++n0FPubyaOBxWWJ4jcKINYOy0=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-292987-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,uniontech.com:mid,uniontech.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B3CC75FD6F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ice_dpll_deinit_info() calls kfree() on several pf->dplls fields
(inputs, outputs, eec.input_prio, pps.input_prio) but does not set
the pointers to NULL afterward. This leaves dangling pointers in the
pf->dplls structure.

While not currently exploitable through existing code paths, this is
unsafe because:

1. If ice_dpll_init_info() is called again after a deinit (e.g. during
   driver recovery), and a subsequent allocation within init fails, the
   error path will jump to deinit_info and call ice_dpll_deinit_info()
   again. Since some pointers still hold the old freed addresses, this
   would result in a double-free.

2. Any future code that checks these pointers before use or after free
   would be unprotected against use-after-free.

Follow the common kernel convention of setting pointers to NULL after
kfree() so that:
- kfree(NULL) is a safe no-op, preventing double-free
- NULL checks on these pointers become meaningful

This is a preparatory fix for a subsequent patch that routes additional
error paths in ice_dpll_init_info() to the deinit_info label.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 892bc7c2e28b..99bb308255cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -4247,9 +4247,13 @@ ice_dpll_init_pins_info(struct ice_pf *pf, enum ice_dpll_pin_type pin_type)
 static void ice_dpll_deinit_info(struct ice_pf *pf)
 {
 	kfree(pf->dplls.inputs);
+	pf->dplls.inputs = NULL;
 	kfree(pf->dplls.outputs);
+	pf->dplls.outputs = NULL;
 	kfree(pf->dplls.eec.input_prio);
+	pf->dplls.eec.input_prio = NULL;
 	kfree(pf->dplls.pps.input_prio);
+	pf->dplls.pps.input_prio = NULL;
 }
 
 /**
-- 
2.20.1


