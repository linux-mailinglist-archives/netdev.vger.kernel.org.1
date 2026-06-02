Return-Path: <netdev+bounces-293985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDWyKUxHHmomiQkAu9opvQ
	(envelope-from <netdev+bounces-293985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:00:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DECDD6277EF
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FB89300229B
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54EF366DB9;
	Tue,  2 Jun 2026 02:56:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0977A33BBBD
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368988; cv=none; b=Rh926svHK/aalFrkpxwaSN21reyoHDTQYTN6vM75hw+5obmrZiQJIthd7A/MlgbfqBnEG2BWvDruU8hrrpByMl509zAz3d7zJUEwpXvuEaV+WQqBB55xeRWESxx/AB31aPqL1cujSoS1bXdNZM3fzCoZ3r8V/6WIa6PuL0p6hkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368988; c=relaxed/simple;
	bh=S3ehG/ZZQtcl+ra03TD37/tmFwd+/xEqHzf0pP6sRog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3XFm/OOP+oFT3RDqiKCVHmnv45tYKdSzL3Au/HwYw/FNO6YVZdFikRdO2DwYOnStOaLBPnsznXNy2ZNkZ/TtDI2hRdstw/vdzera+Nm5OfvN1fCcfRhc5D1yEgnikI4srsDk9ZJEgz5cdwDRLllAMsICRLxjyCEfzVIJHj9skY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz9t1780368893t25bc321e
X-QQ-Originating-IP: xyNiwtPuUcJm4SrP3/DZBC1LN+26WRDrefduRgaFoqk=
Received: from w-MS-7E16.trustnetic.com ( [36.24.207.111])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Jun 2026 10:54:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15226267451680480912
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: txgbe: fix module identification
Date: Tue,  2 Jun 2026 10:54:43 +0800
Message-ID: <F3DA1ECDCE0A1E9E+20260602025443.332456-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ObFHHlrAm440hOqrgLqmhlwPVCTYf5vBO/MFnuG5HAAQZ/gUM+7Q8dMz
	MQ/K8pf2xjjllRdYFeiaScLQnk9pKZNDnl38cT8c9NVyP9rcnMiA2UInK2236yD6bDKATh0
	SG74+TnA2hfYZLNLJCLuhmusIXGqw4XUdT0tvdPv7MeLi3uy+ogIuImVcQ7FS80q3vfWbfo
	TOhbl+NP0RHWtBB8zkA1c+nCjON6/HEMqERhv/1X4jXXgPgR1kUQ8AW7BEhY1yJWm9igvHm
	X4jbNQtod7yoklzHEPSiI5Y9igfBIOCa81aWGqEMJUE63Pd1O/tOHgGLxJQ8ksW/plm4ICX
	Kdcz+yB6c7iIbHtPHwaNRHDrI0YjkufrrosD3rNkD2MDyzySduZ7IP4V8NSuIQdfwAICT71
	2D6LyUtMQHceRplBZoPlDdcpwkFbQqVELpkFDQJy6GiNtYfEagx2SJvB6PTAI3eLhsmOnyY
	WQbaWXyJJEQB6DGxAjV7OwNSDjFz8PzZh5hwO25KB+gKsn+8Lfjl7HvtijYfJ5hFJc8utMb
	AQeGYqkYG+QFyoZCSH56ZJ/9vKXbCJfnKzyJfA978of62XoWZl9Y2bWfCQtq2qhFF3mtwg5
	yyV1O6oGwRglW2yfeFWocNqAarLOU4C9tmfngACylOQobWHG8xgs5ZRqv1sB+WCuXWFDk+L
	/UjBVXIblI6yj98Filc1+6nZvc4AW6XcVUSRxyQ+zf8VELZl2ieJtu7nDR72Aa+DB0TjkAW
	ILlub+ThC7q0vWrPVs7ZqSm2rAA+qtVPxykdTSo1qSUMFkZada8n+ywf5lFCLRl1bM8NwOr
	6b8Il3Xyq8iGx8pleRWIOg4SK3Us8CBlBiE2rVEmpVnl95FZMM++IEgq3kEnRArr5xnRj00
	NW1kZJ0AwaHLI6PJEzst0ISvNieCpZhtIBz0UEvCFhN/qHR+l2S1Gm9EhUhhbJ0K3tXk5LB
	I21BSeduY8bXMyri2NCviGH4bU/KqD2pdYIqSxepzLZS6RPeyPxDP9vRBvNet5KITSqTiDW
	vwlOi2oTY6SfRGFSEdoVOVvaLNd6DagQLyr3uJAtQHq0TbAi38MpWa3HJBoZ+3q8r9WY4GM
	3TZ12GawPSzr5qLABKRyYw=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293985-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.954];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DECDD6277EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For AML devices, there are some issues where the wrong module
indentified then configure PHY failed.

The module info buffers should be initialized to 0 before the firmware
returns information. And DECLARE_PHY_INTERFACE_MASK() does not guarantee
zeroed contents, so explicitly clear the temporary interface masks before
setting supported interfaces.

Rework txgbe_identify_module() to validate module identifiers through
explicit type checks instead of relying on transceiver_type heuristics.
When using the SFP module, transceiver_type could be a random value,
because it was read from an invalid register.

Fixes: 57d39faed4c9 ("net: txgbe: improve functions of AML 40G devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index da1d3976ed33..e0beba075e76 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -203,6 +203,7 @@ static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 	DECLARE_PHY_INTERFACE_MASK(interfaces);
 	struct txgbe *txgbe = wx->priv;
 
+	phy_interface_zero(interfaces);
 	if (id->cable_tech & TXGBE_SFF_DA_PASSIVE_CABLE) {
 		txgbe->link_port = PORT_DA;
 		phylink_set(modes, Autoneg);
@@ -270,6 +271,7 @@ static int txgbe_qsfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 	DECLARE_PHY_INTERFACE_MASK(interfaces);
 	struct txgbe *txgbe = wx->priv;
 
+	phy_interface_zero(interfaces);
 	if (id->transceiver_type & TXGBE_SFF_ETHERNET_40G_CR4) {
 		txgbe->link_port = PORT_DA;
 		phylink_set(modes, Autoneg);
@@ -331,7 +333,7 @@ static int txgbe_qsfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 
 int txgbe_identify_module(struct wx *wx)
 {
-	struct txgbe_hic_get_module_info buffer;
+	struct txgbe_hic_get_module_info buffer = { 0 };
 	struct txgbe_sff_id *id;
 	int err = 0;
 	u32 mod_abs;
@@ -353,18 +355,16 @@ int txgbe_identify_module(struct wx *wx)
 	}
 
 	id = &buffer.id;
-	if (id->identifier != TXGBE_SFF_IDENTIFIER_SFP &&
-	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP &&
-	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP_PLUS &&
-	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP28) {
-		wx_err(wx, "Invalid module\n");
-		return -EINVAL;
-	}
-
-	if (id->transceiver_type == 0xFF)
+	if (id->identifier == TXGBE_SFF_IDENTIFIER_SFP)
 		return txgbe_sfp_to_linkmodes(wx, id);
 
-	return txgbe_qsfp_to_linkmodes(wx, id);
+	if (id->identifier == TXGBE_SFF_IDENTIFIER_QSFP ||
+	    id->identifier == TXGBE_SFF_IDENTIFIER_QSFP_PLUS ||
+	    id->identifier == TXGBE_SFF_IDENTIFIER_QSFP28)
+		return txgbe_qsfp_to_linkmodes(wx, id);
+
+	wx_err(wx, "Invalid module\n");
+	return -EINVAL;
 }
 
 void txgbe_setup_link(struct wx *wx)
-- 
2.51.0


