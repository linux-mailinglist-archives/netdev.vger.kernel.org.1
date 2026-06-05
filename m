Return-Path: <netdev+bounces-295604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ap0dGww+ImrXUAEAu9opvQ
	(envelope-from <netdev+bounces-295604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:10:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0921E644CD6
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 05:10:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295604-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295604-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BA3630089BD
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 03:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D7937EFFD;
	Fri,  5 Jun 2026 03:09:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA129AAF3
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 03:09:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780628996; cv=none; b=uJ4rvQIwHtJb6gFVCie9ig200zJ7vcW3wx1I0MS7QRsBc4PpLg5GXNJU/NPGZspLRWM8sdJ7Mx7m1X0zuN1b0SqJ1WOOz+4ombrQH9Ee/yedE5oma4gJhFWl8ZHIWTStn6WbU7e6mlcdmeCvoRpRItmDpHTaZVu+3+1LS6cC+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780628996; c=relaxed/simple;
	bh=dF4uXdqTHoQ/Seol55zUckDcNkdJDX1n2abrTG+IHdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NdV3quYXPBJtZ5n3Qdh5/fVDKcJeUvlz3aXTKQMcyd4sFCdEayTEu5F8/WJadSDOvNnr+0Nj/Nl5K+z6zm7ve/wXxxL6TcnJP59x5yHxKw9h7HWzafpBOtJ4BXKUiFmx2Slu5XHI3FeDH6gdoOug0Po3F1nwqDAEz4T6Mj5Ur64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
X-QQ-mid: zesmtpsz4t1780628948tb8a91a1f
X-QQ-Originating-IP: ajqVTKfy225ReDp/i4e44lUCgmp2SfA6zv8cPozhAyA=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.207.111])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Jun 2026 11:09:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3770735181711243257
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 3/3] net: txgbe: initialize PHY interface to 0
Date: Fri,  5 Jun 2026 11:08:50 +0800
Message-Id: <20260605030850.17796-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260605030850.17796-1-jiawenwu@trustnetic.com>
References: <20260605030850.17796-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MM5BK83ZQ9t0aqJ7dJ8HbQ87eMTNT/+qTyMPGPxWCamAXIRxckwYUed7
	vmHaQbuaGQJAfPNWyYFg1ljQ1W/2m2jhd92FOkrpEnmjAfvxjRTEoT4+6b7gCE9xcKQFjvB
	Bu/4A518eOmIkoF465mYJgg5RUiORMksnxN5ScDNobbKi/3BecairIJwJRskTgtc3rZiDvs
	wn2XBswGJ3DLo9MRUBG1dVwSFaj53/jTEXW3uyYVWNwwTjF1sArh1S5YcvawaoxEZA5wnAZ
	dSkSooC/0jVO3wo8ePZH3ncPNwmS5s/R141DSshmsn/FDJHiMiVs2nw7YkkSVqpNQ80/YRo
	zSgv1DXjJ4mnfL+34suibM3OPET+ELSxQSuyd8W1tslFDRemggVaNJzxRenlTmGTFisGAPE
	QOW8OmgoICSRh0fKDs37Phpr8gg+S7fZ+/dlwsQ0L84wt/jRUmePRexpD7pQYW8bb2WlYZ0
	TXthUMKRROjJ3+kYv2EcCpj9bzF98G69SurntQ7KyRbq754BYBTy6TA3PLrbTKDoXFNN5uq
	KVERHXzge2RRvFd1jsJU9poQtdVLV/ed1fZw1BkIfTJvqWAUuL0GZFxIrZvtZJCbj438gH3
	7nbDWU+uTGk9Jb5JvZjg/6MOHyZRj1bzCAqaeCkfp/lVl15cE4j3iCdC8v65dmZN+4LXBLk
	PrqnTqMKHJ2djMtnzY73N0IWEk0meQJ1E+P4JpmnPnpuvyoH0TBHbf2WjJIiPXbqc+XVdX5
	sK5/aKt6pUVEEXydpt9TES/23lVldFuCYUciXNoo6irDsULgvrJP9x/WC0nDRv1CsgKtEUX
	XElHZIK66COaOn+JSrrsHBok23OwP45ZTLhLSiumhr7EbZhzzvxeJOokiCFWUEbjCzaDtJD
	EQfIQ88IFAygGZLrVogWxwTbMLP+tnnTHV/t9tvQTnDEKuBQL3QAt29nWJNxYRLfCiTn/vA
	OkcrxA+0RWBwGGa88gBj+dHzWMs9mk3dB8EwvxtqlzueN7MX8gRev+80B9wOSiCZePaHGkU
	N+SzEobteBfuCZb+vx2qlE5ZPjyzyrrp9HQyImgtsWmiRzY/YnDhmHxEr0zhIKDLZyd+p56
	tYko5gVzKDOflC17ah7KwGIM+WAt5n1U2yToS79bXqr
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295604-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,trustnetic.com:mid,trustnetic.com:from_mime,trustnetic.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0921E644CD6

DECLARE_PHY_INTERFACE_MASK() does not guarantee zeroed contents. Change
the stack variable "interfaces" to be zeroed before setting supported
interfaces.

Fixes: 57d39faed4c9 ("net: txgbe: improve functions of AML 40G devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index bdac654a2364..d73295d26b85 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -270,8 +270,8 @@ static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 
 static int txgbe_qsfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 {
+	unsigned long interfaces[PHY_INTERFACE_MODE_MAX] = {};
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes) = { 0, };
-	DECLARE_PHY_INTERFACE_MASK(interfaces);
 	struct txgbe *txgbe = wx->priv;
 
 	if (id->transceiver_type & TXGBE_SFF_ETHERNET_40G_CR4) {
-- 
2.51.0


