Return-Path: <netdev+bounces-292989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDxkIKwmGWq9rAgAu9opvQ
	(envelope-from <netdev+bounces-292989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:39:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2753E5FD6DB
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA6EC302AB08
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D482139F184;
	Fri, 29 May 2026 05:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bYIDdlP3"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99219373C1D;
	Fri, 29 May 2026 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033193; cv=none; b=kM4bjwPu56s5SI5ZEeVbg25fC4Pr4lzGG+VPB6wUHNlm4geFQtw9nKAJ2Xf4zHnNRLcd24WU6KDC3PvTA05h16Um16GQwe6kYBdFr3M3jar/2sbNA3ioti21T/9Z/TkwgAzfQxeHV/NAHziEslrcoDTpJ+RQ1us9Ne3ND3DqZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033193; c=relaxed/simple;
	bh=hWRtIJrBbLgsQeXZ7uxzEc76nynyIlE7tVL4MpG7lYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qn7ExqimAb04DpCABbj/AfM5nARDwcrvg0sBekIqDO/PWl4BDsCp9Z/4skluAWyNKo+6L0dbiv/ZMyL0FDZ7syefV8GNikdVmbWFW07gw+Pe0+55fGlz8wzfsLZp4NMedzpKvlKUm2MXiTicDRzVFuByKt5OAvjNW4rFuBOZLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bYIDdlP3; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780033098;
	bh=scjxYyFpRmQYuRgng8VwXwWgC9x8xEgFY8Y2guA6c+c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=bYIDdlP3OJF2+o3nK2zwXklVHBe4CfOM2F9K6aJSDIl1U8Hyj/Pxr0xADvJEuSpLt
	 Zz/8bkb5Njx7Ds+9fgBkYVuZeJaS2hMClz1VtmZhFWT6126weJ+uclhudh9i57Ni0u
	 IGVVqt9I8r3zXspIuigoRk9BS82DpY7fdnqV/ZFE=
X-QQ-mid: zesmtpsz5t1780033079t1893b861
X-QQ-Originating-IP: bqlM5PUpKuW9q4mcwmUyQdBpA/ORLNdebwjuAb5O2kU=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 May 2026 13:37:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6071481676437275183
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
Subject: [PATCH net v2 2/2] ice: dpll: fix memory leak in ice_dpll_init_info error paths
Date: Fri, 29 May 2026 13:37:33 +0800
Message-Id: <20260529053733.764996-3-zhaojinming@uniontech.com>
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
X-QQ-XMAILINFO: NT3X+pH9p5L2pZ62hzv13pstuF0ARHVhJdEp033zSDDgVYYJ49wBEZ8O
	jAnIyrQMtCqCsDWjM6s+o7cnke5W0pmge92VDhcN1lVFz1FpJKrAkZ0vsQyAEXp8DaIMRH1
	W0uDrE8Y6h/dpf6DPHN3ToMRm/hAHqYBGWIKNwnYbo/j5SwOP+KiUjHk8770cWc9KZTQygX
	IHXOxj7YNHwBkHmlOEz3+TBt68AMg10Sos+P5xpTYaCPkw9LVSjK5U8yiUL6zBa14QUOkYb
	CM3IQTMJDs81J25VHSyWsbN8xEBibKSByicxUSQt5OBfdzQAhUr1H+7TtzYzzECwHRWHn8S
	UT/a+vhGnU60JcULN2bFalA8rlzS8hVXjZ2zpa7JCUIUwqUs+E2ozu/Op9k7GfhDHD7s6aY
	WaY09qQHa7XGAFhQhU3NxEUVLMVTJNkZ6Fm90J6Azpnr/QSfacoO3irXGIfB6lffXdzvH7V
	A37m1bZB9GFy4PdY1UcaINE0fGuHEE8B2Fq8A5YDlx7gkU2gM1p96ObNio0aSnMrMi59SAX
	NP88qInBhm1q/7HQw8eqRVOZkcATpFkkxTAOuKJDxRxm3oVUqTQ5vJMhLKUN60HWiJpZM1Q
	7pOVh7DVELcLfL61xp+21pgMKHMLYyKmSVuga9e9t1YUizF9ifHkxK0NwDCAtiJrkFqDcGG
	YR5joZ45bgWPZqXgXgFFSyPjm/VD9Hh3e1YLQHgkfMyEEZJ7ZJcFbdqZdw0reqzCeSPVwHJ
	8+xHyiBhn0OXDcqOGb5OZRETN3NEJSW8/+e1C+6CN9vA57ZYc+0X9Ith8gzoZv/5PKYmTSs
	7tKy99CF+8O1lMHcSCooWIfe+9+TLi5egpL8nR3bZxb8iROFU97ut7TbbBNYW/Wd+AwbSKM
	x2wkdPoHLhwBjcOTsGb2rk1R9GBD+nfresGvxqNG/l3DQwp0ixBiw0a6+ENDpCv+6xDVZA5
	cu/0PP4kUSnX6VBRJ/1iXqua1ggk1GYxy+XDaj1fplfDiIEGyLfq/KhbL3F89WJTw112cEw
	tSpkGWDY2bjvvtHzLAyLQY0TvxfRlMQMY2UyqU1d4j7KXWb9V4MymYjKjK5DcbneVgfLX3z
	EOy0HxNapHA97ZHiI4FTFS52M/Ltsk0IQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
	TAGGED_FROM(0.00)[bounces-292989-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Queue-Id: 2753E5FD6DB
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
index 99bb308255cc..7240152f1655 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -4345,12 +4345,16 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 
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
@@ -4375,12 +4379,12 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
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


