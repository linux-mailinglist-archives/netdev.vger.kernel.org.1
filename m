Return-Path: <netdev+bounces-293098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHyuEvV6GWr3wwgAu9opvQ
	(envelope-from <netdev+bounces-293098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:39:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCB9601B99
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3375302A5B7
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87CF3D9696;
	Fri, 29 May 2026 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="P24KC+ct"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C149383333;
	Fri, 29 May 2026 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054714; cv=none; b=J9oYWvH/HTT0P6rAeEhp9wjoYqjNsS6G68zUP6DD+x8EWjibj9FHb/2eYy8SkwD72WKyFSItNj1J8ZWFSMAGgI+qylB7eHUUR2J5Kew/tkPdD+xcDSlF6uxgXZhM3XA5mStRrqwpuoLBGFamxxaFSwDY7VDwLo7jFoV9FM9cyAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054714; c=relaxed/simple;
	bh=+urzWj52fm9EgHUD8IQ3yAVyyOyafSmVfw4ARn7GhOk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=itf8UP3p5Yn2BnBMqqeWzRHPZX8TMTM+M7JdxyH0fX0hU+Tar/HpmdBDGJmL1iMRUaZpKOD8B8+Gees4ZuANs0vt9VD8tYtyg9LXq17N5hvZfbl+IHmRDJKjx5v0JmaFa6U0YFhKCkNAdRhudAW5CVC9vokmhLHGEq6nu/Ysl6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=P24KC+ct; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T6Wqgl1389034;
	Fri, 29 May 2026 04:38:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=QshmzHo6rzwAljh0QRKKVguGvpcns0NekB+9B9oTbcE=; b=P24
	KC+ct03c6iwFc5a//hJeKZjtjhu+KTvfllIumDxLNlsVHWMPzA2WmBDla3aUGnuw
	BbIEMtgk6uUvzv9mOBVUgz7dc52aqx+YgydEyFiIZjoq8pO2AMQvWu6J8lYAONCk
	4X+bE8rU+gFdxCazTzpKtTnrGngCEqE5UbhyEsg/TdBr4Uj5wxQcTCBta2Rt++cR
	phDn/1k/fZv2wrsVADWbT6hKe+AOhrFNhxc/r6j6S5ihjaGEb9/jKVgMmG/No6Xd
	KSgClK2oBqmpA/UfrKJEaVyvyL5CwecAxbB8sk4sz8hOBiEtoGgz2f5UEpRjO3sJ
	KcBbUtBarWnCl/pnRpw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eepxmc12h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 04:38:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 29 May 2026 04:38:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 29 May 2026 04:38:24 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 27E923F7061;
	Fri, 29 May 2026 04:38:19 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [PATCH net] octeontx2-pf: mcs: Fix mcs resources free on PF shutdown
Date: Fri, 29 May 2026 17:08:18 +0530
Message-ID: <1780054698-17307-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: T2xTr3zuQ8OS3-Lrxibnl9DRo4UIQuPO
X-Authority-Analysis: v=2.4 cv=LoiiDHdc c=1 sm=1 tr=0 ts=6a197ab1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=NPitHzPN1ilE7Q4tvNMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDExNiBTYWx0ZWRfX3KxaqOdSBML7
 rgHpUVgx0Wnv9pQ8NdIr2EB517+o/adV/5lYHnqSHBaghJrMpopjme75IYtBJq3NL0jd+6x7n+/
 G2tA12mGsZORi64XkK/XBEGr4ufB5kbLtNdP26r7EnmtAEe59zuQGWzXccjaP+2Y6AXX+kjSw4V
 eNQvDeKlmCZIY7qVDNyIc40z48nvWEHmJWlPIUlmxsZ3unqCkdUz1u4pLqfr18/fyTbOuuItLrT
 cZl1RumsuWz9T1/XnZ16yaewbBjOocKlPPdh0rX7THAQE5pD2UcvHPXH+ASGFFA+ijsfVLg+WxS
 Y9yv9d8kAni2Wp8bh7o0RWOLYT/pkRaX1dOr+FvGkvESsjr95IOP41nuGc9fefQ+ScbSQKfQCyO
 K/H26lAvUAT5vek/2ZUFnHptHWKUU3kTHBOVYlTX5J4hlXFxSZEYnklqW8AQPkWqF2GXG3I/fyZ
 vmSnqCeo3xilJjt69Qw==
X-Proofpoint-GUID: T2xTr3zuQ8OS3-Lrxibnl9DRo4UIQuPO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293098-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5BCB9601B99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Geetha sowjanya <gakula@marvell.com>

On PF shutdown, the current driver free mcs hardware
resources though mcs resources are not allocated to it.
This patch checks the mcs resources status and if resources
are allocated then only sends mailbox message to free them.

Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware offloading")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 2cc1bdfd9b2e..f25809c9d393 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -182,6 +182,7 @@ static void cn10k_mcs_free_rsrc(struct otx2_nic *pfvf, enum mcs_direction dir,
 	clear_req->id = hw_rsrc_id;
 	clear_req->type = type;
 	clear_req->dir = dir;
+	clear_req->all = all;
 
 	req = otx2_mbox_alloc_msg_mcs_free_resources(mbox);
 	if (!req)
@@ -1776,9 +1777,14 @@ int cn10k_mcs_init(struct otx2_nic *pfvf)
 
 void cn10k_mcs_free(struct otx2_nic *pfvf)
 {
+	struct cn10k_mcs_cfg *cfg = pfvf->macsec_cfg;
+
 	if (!test_bit(CN10K_HW_MACSEC, &pfvf->hw.cap_flag))
 		return;
 
+	if (list_empty(&cfg->txsc_list))
+		return;
+
 	cn10k_mcs_free_rsrc(pfvf, MCS_TX, MCS_RSRC_TYPE_SECY, 0, true);
 	cn10k_mcs_free_rsrc(pfvf, MCS_RX, MCS_RSRC_TYPE_SECY, 0, true);
 	kfree(pfvf->macsec_cfg);
-- 
2.48.1


