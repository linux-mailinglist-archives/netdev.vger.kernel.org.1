Return-Path: <netdev+bounces-284733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAkqMzvt+mn3UQMAu9opvQ
	(envelope-from <netdev+bounces-284733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:26:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9C74D7340
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC1CD301F21D
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFCC37B002;
	Wed,  6 May 2026 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZtSwfuUu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5243137AA75;
	Wed,  6 May 2026 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052386; cv=none; b=KkFLTQk6wAary0FkoNNCsn+y85Eg1VBbnzLCp8NCkvWHQAp5c5wSXte1NEKAiYgZiguuglSFIH+EgoDEbo46lQB3/UD/b9JwwwStpB34zwZ8e29/4qtSvxhz496I9UmsN1NBWn8cthKcslTCRw2nHtkJgOyF487g3bMs5hhc9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052386; c=relaxed/simple;
	bh=JITsFlRhNPddbBiE7x9vC95CAEMQC2QeFvYuXGtu3Jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JFpJ4Yn5sdYFspUsQAvbKkTRvBsrSe7sxkZ4/58qM8OAypHr04j7DSg255uiyyYFsgzoG/mwvdKnIHtMAh+skav8KNdN95xqPa2ry9H70S+O/iEoRSeXEiqj8IOm/Hq2kfHEcGEiuljhyLBvz9xchVddcxdrXR0Ca0rS0/gZZ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZtSwfuUu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778052386; x=1809588386;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JITsFlRhNPddbBiE7x9vC95CAEMQC2QeFvYuXGtu3Jk=;
  b=ZtSwfuUuhuF7LzJIBWjQHpnrr29z+Br18ZZEirGMpbFF6iNmWWzs0k5L
   JVxq0CsaKfGD4OINU1o87DVv0xkee8wpHygWYaBtdAziUCfl54BAnMVtj
   T4sb3r1p+l7LyDW1lvoOxwsysUNlYSZCFefYUMsmTexLsCYIx/9MdNeyK
   XsiAjqzn99wFMlnktOn7JdPWt7iAG2zj5wTA8pFeS4Hm8kzXXcCphfi8Y
   4bHtnirTILNmRhvE8GiJBVgAUtpqQXWfDIV0O5QJPwmXJreYLJwHUpjz9
   GJE6TKnCDJximymMywKio5l/TJhTW2xfjx2q2l2vMJZFztcvmop1cs2pm
   g==;
X-CSE-ConnectionGUID: 55FQtZaxTi6fR0HFIcyGwg==
X-CSE-MsgGUID: eFJSXsBaReiFcz9TRMe1zw==
X-IronPort-AV: E=Sophos;i="6.23,219,1770620400"; 
   d="scan'208";a="65355704"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2026 00:26:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 6 May 2026 00:26:18 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 6 May 2026 00:26:15 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 6 May 2026 09:25:38 +0200
Subject: [PATCH net v2 3/4] net: sparx5: fix wrong chip ids for TSN SKUs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260506-misc-fixes-sparx5-lan969x-v2-3-fb236aa96908@microchip.com>
References: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
In-Reply-To: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <kees@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <linux-rt-devel@lists.linux.dev>, Andrew Lunn
	<andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: CF9C74D7340
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284733-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The TSN SKUs in enum spx5_target_chiptype have incorrect IDs:

  SPX5_TARGET_CT_7546TSN    = 0x47546,
  SPX5_TARGET_CT_7549TSN    = 0x47549,
  SPX5_TARGET_CT_7552TSN    = 0x47552,
  SPX5_TARGET_CT_7556TSN    = 0x47556,
  SPX5_TARGET_CT_7558TSN    = 0x47558,

The value read back from the chip is GCB_CHIP_ID_PART_ID, which is a
GENMASK(27, 12) field, i.e. at most 16 bits wide. It can never match
these IDs, so probing a TSN part fails with a "Target not supported"
error.

Fix the enum to use the actual 16-bit part IDs returned by the
hardware: 0x0546, 0x0549, 0x0552, 0x0556 and 0x0558.

Reported-by: Andrew Lunn <andrew@lunn.ch>
Fixes: 3cfa11bac9bb ("net: sparx5: add the basic sparx5 driver")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index d5e6644ff124..078e02627394 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -31,11 +31,11 @@ enum spx5_target_chiptype {
 	SPX5_TARGET_CT_7552       = 0x7552,  /* SparX-5-128 Enterprise */
 	SPX5_TARGET_CT_7556       = 0x7556,  /* SparX-5-160 Enterprise */
 	SPX5_TARGET_CT_7558       = 0x7558,  /* SparX-5-200 Enterprise */
-	SPX5_TARGET_CT_7546TSN    = 0x47546, /* SparX-5-64i Industrial */
-	SPX5_TARGET_CT_7549TSN    = 0x47549, /* SparX-5-90i Industrial */
-	SPX5_TARGET_CT_7552TSN    = 0x47552, /* SparX-5-128i Industrial */
-	SPX5_TARGET_CT_7556TSN    = 0x47556, /* SparX-5-160i Industrial */
-	SPX5_TARGET_CT_7558TSN    = 0x47558, /* SparX-5-200i Industrial */
+	SPX5_TARGET_CT_7546TSN    = 0x0546,  /* SparX-5-64i Industrial */
+	SPX5_TARGET_CT_7549TSN    = 0x0549,  /* SparX-5-90i Industrial */
+	SPX5_TARGET_CT_7552TSN    = 0x0552,  /* SparX-5-128i Industrial */
+	SPX5_TARGET_CT_7556TSN    = 0x0556,  /* SparX-5-160i Industrial */
+	SPX5_TARGET_CT_7558TSN    = 0x0558,  /* SparX-5-200i Industrial */
 	SPX5_TARGET_CT_LAN9694    = 0x9694,  /* lan969x-40 */
 	SPX5_TARGET_CT_LAN9691VAO = 0x9691,  /* lan969x-40-VAO */
 	SPX5_TARGET_CT_LAN9694TSN = 0x9695,  /* lan969x-40-TSN */

-- 
2.34.1


