Return-Path: <netdev+bounces-268463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA0jN1cFuWmEnAEAu9opvQ
	(envelope-from <netdev+bounces-268463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:40:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 968E12A4F46
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02D0330233FA
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850F439183F;
	Tue, 17 Mar 2026 07:39:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99410311C3E
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733172; cv=none; b=WaPPa9wLFuBwMTokIREnwR+sh7SEhiBcTm9+xdFAucDgeY8Jfs6P+BmxvC6uKo1aQDQwp7MU7qlE3Nphr1BsNjN9C9PStuwG8jNjFohHoUyJldQnVcxEgvYbmNtbP4SBXQ+AREBf0RKltfzJZBZ8D507t6BInwcxrTs0kAWJMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733172; c=relaxed/simple;
	bh=bQ1iIvjboEs1N26sVJJEBNZjYLljImHXeHO8kndxh1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JRA9iOhPKJuIAG+DH88vZm3vw8O8LLqvCskDh2dHqvTVAxsVEP2aOBVxb8yA/LNtYrHugkgP1Z4DAYP2ULJ+B4JnOfekzdHnPaGFvxdB0g3eln1aFO7BlcvdBNSZmMOc/HGZKxMlNMk86Wv8v9kEDdEplKtLsfYn0raa2RYhpJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1773733128t5aceeec2
X-QQ-Originating-IP: FWrCrIFqnUInnqSgskc03lRhIoK9t6lEBjO/wPgH71Q=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.239.227])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Mar 2026 15:38:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15265255172791364991
EX-QQ-RecipientCnt: 18
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v5 03/11] net: ngbe: remove redundant macros
Date: Tue, 17 Mar 2026 15:38:19 +0800
Message-Id: <20260317073827.4300-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260317073827.4300-1-jiawenwu@trustnetic.com>
References: <20260317073827.4300-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NNpkHrqnI9JKGowGvHQCxFdUj4Hmi23hGJSc+gWrNVmbYmHqzQYXhQ7a
	tkFinuMnXh3YHubLuM/RU7/J8RScsu8OXb2eIlH22GB/xJvqO1ihAwCYEPyJPtm/zcup9QS
	20K5vPldBem9egCgVkTwCIWah+sq9xgmP+MXK2dXlHnaceSQM1VyFx4fN0rm4MtgJyqoC6t
	n34f0zTv94vdYUM1OWmhQYT/OrS6wUftG//cKqWCNv5X9oM+M9fyar20jhhM2YBwJATt81z
	rF0GVAoLpRM10/h6r9CtU1bww2Um+bdicFs8xRakxqzcIzRBtYkVYDTZ34WI7h40zNtOAIp
	yKLWx5BKOTBnSPUhTmiRXHvVYOSJqM09TH9VY7u6LUvUOaQnQKXyzgyEkhtPmteEcEv50T5
	dukib51L9PvXuuZAqNiXDGdgJxiCQWTni7xtxfrdiLbYWzRzd2qeR60RhThmmKhVw/C7mm/
	GIIAXoEeAeulJZUb1xDA00MyalsIRzeYjtTYXFi8nibqh7/GjuxtgHQwcRdoP444Gz4GRnx
	6yeQaNrMXcjsuyBbtzqJGEB5LXK3zaEE9HSL7HXHg8CnCpbpNpymfImGtUYrK+nrdOZS6Pj
	flQDgFfTSITKM5v9Nd2/pNLtFHQy5VJuV6KdjPLQDfqVdl2bTs3JUVtF5xxTfSPNTzsiSrL
	DroOeedHGN4D/Tf8GTyqceKKQNtpeCaoiKIAKJ9O8YVeabwnGcFX1R6Ex+A5lyanLS9siFT
	i4tWFoOrCHEvF6SnaDzy/WTZ9I2KOy8/mmVw6Im+nRbAYrUftg8BZNvz3PwtWPDPMGlEU20
	d1nN2kDaGAC+y/wDWNr/GwoTLhWODeu8UcbS4HEwJoQ+aMUfxweB6OlbmMgkoBF0UnNJzNk
	7RaaVsmjRaqgraUOb7xBeUzmuXpIdHc9k9JJ5ZUyK56txot3j/RgCQbtvq6awEzFNAvwbFb
	lmU7iqa40P9oHGpoqoXpkxFU0zwvj3WBSVDHx+JCRZzsfJgE2NmawRCfWax1ICPiHZAV6xN
	OdcG+tUMtlteNXGFjlsBvjqMDerOiXLaoEndt59mxEHiyCcFsqgD89qIOu2e5WMS0cze6eN
	D3bBxZt6ZC63S5KztyMZucInn6qp5ZFxEI0BwV1OFPu
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268463-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.818];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email,trustnetic.com:email,trustnetic.com:mid]
X-Rspamd-Queue-Id: 968E12A4F46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NGBE_NCSI_SUP and NGBE_NCSI_MASK are duplicate-defined, they can be
replaced by the macros defined in libwx. Just remove them.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 ++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index e28ddf684a06..8c9d505721b1 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -57,7 +57,7 @@ static void ngbe_init_type_code(struct wx *wx)
 
 	wx->mac.type = wx_mac_em;
 	type_mask = (u16)(wx->subsystem_device_id & NGBE_OEM_MASK);
-	ncsi_mask = wx->subsystem_device_id & NGBE_NCSI_MASK;
+	ncsi_mask = wx->subsystem_device_id & WX_NCSI_MASK;
 	wol_mask = wx->subsystem_device_id & WX_WOL_MASK;
 
 	val = rd32(wx, WX_CFG_PORT_ST);
@@ -66,7 +66,7 @@ static void ngbe_init_type_code(struct wx *wx)
 		       em_mac_type_mdi;
 
 	wx->wol_hw_supported = (wol_mask == WX_WOL_SUP) ? 1 : 0;
-	wx->ncsi_enabled = (ncsi_mask == NGBE_NCSI_MASK ||
+	wx->ncsi_enabled = (ncsi_mask == WX_NCSI_SUP ||
 			   type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;
 
 	switch (type_mask) {
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index f1957fa0add4..7077a0da4c98 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -37,9 +37,6 @@
 
 #define NGBE_OEM_MASK				0x00FF
 
-#define NGBE_NCSI_SUP				0x8000
-#define NGBE_NCSI_MASK				0x8000
-
 /**************** EM Registers ****************************/
 /* chip control Registers */
 #define NGBE_MIS_PRB_CTL			0x10010
-- 
2.48.1


