Return-Path: <netdev+bounces-256119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ok1H4+CgWlNGwMAu9opvQ
	(envelope-from <netdev+bounces-256119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:07:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 209DCD48F2
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D8583004607
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52A0325727;
	Tue,  3 Feb 2026 05:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gNmb5JTP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650133AD85;
	Tue,  3 Feb 2026 05:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095243; cv=none; b=MRkoUlAqHlnAg1fHsmKXTSFfw7hl4pv5tywi3N3H/UQMhldpr4P/ZNLgwwW65lebSHygetdV98DKXSkpZbD8LWFinuX/EOA3yyfESAVo/OpEee1MWq+lXDYZpxhp+r77LTsflpm5rTNgK0ctySXBsEscz8Vch8cZXeB+uOlTa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095243; c=relaxed/simple;
	bh=5TJdWgOazL24OgNFl4W/Nmg0EcbAnymoNCwc34uRN4s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=it/qpDeV8r/zyN1QUgI3JY77ESEkQvb2zx3KXcycHDNUnofCF0j3Kmi/yuywQjggonJ6MeqAz1G5+zfm6ptPBG2+NF2iAWSlSmKBUI0D0nCooUQm4Ma5k6bwf+6sYaCw/OYVsdf3xW4zUalGNe6iplphrSKQBkmgLkYfGwSWT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gNmb5JTP; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612LWPW2904934;
	Mon, 2 Feb 2026 21:07:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=zUj0cUmTx/5XvD6ZJQ+eI/+
	pd3NbMZLe1J6h5lyysLc=; b=gNmb5JTPtxRP//tVbyiNBfFI24sDpw5QTSmR+KB
	CVEVcvFSJ2+PWBlpYriX5RPAhb8GAZRPM6TsOuxQtbmT7kSYswlUR+BDXLvQriYX
	YOi557UV9rPuLHTqXoE4wR8b5e9t1rrE9W423mve3ty3uVhRmudW8vwE14liyp3u
	op9+30WihFZt+qvwv6n1z9YTE2S7n2PJrDyEO4Fby/aWt7trUdQFSEnHB09bGd9G
	C5iA1tyEV6PRIoZO5EQtbtTxAaOPGbbEI8YERoijZkepZTH2o3Ua1aG7OsMaliDu
	d+deFg2AjZcCHZ1r06xCyQnb116RDi7Efk3gFW+PG+09Iaw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c2q3q2kna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 21:07:09 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Feb 2026 21:07:24 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 2 Feb 2026 21:07:24 -0800
Received: from hyd1vellox1.032marvell.com032caveonetworks.com (unknown [10.29.37.43])
	by maili.marvell.com (Postfix) with ESMTP id 233803F704E;
	Mon,  2 Feb 2026 21:07:03 -0800 (PST)
From: Anshumali Gaur <agaur@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Anshumali Gaur <agaur@marvell.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Linu
 Cherian" <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Jerin
 Jacob" <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2] octeontx2-af: Fix PF driver crash with kexec kernel booting
Date: Tue, 3 Feb 2026 10:37:01 +0530
Message-ID: <20260203050701.2616685-1-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZeoQ98VA c=1 sm=1 tr=0 ts=6981827d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=M5GUcnROAAAA:8 a=Q5uZ4edcD06D7gSqUVUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: -PU6Uk-B8s0DfiRO7RdgU5Atv67aPzxz
X-Proofpoint-ORIG-GUID: -PU6Uk-B8s0DfiRO7RdgU5Atv67aPzxz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDAzOCBTYWx0ZWRfX4Cmy/5C14sd9
 r5qnKlXdOI0pI460YJpAvAOXOELvvk7V16CURwuEu9ETXv0RiP+jDNofoFeS9Ptlf+JZUoOA9KZ
 kTlzk14YBqLkxldy0clQNIVG3q7IDPCuUxDcB6gU4Iz9n21ZMLx/IaSBpE+fDKuhuGXjG7keFbu
 e1b3jGmYZ7CGsjZnIhvPLxljbZoak/0Rx0149YetK7CRDE0cg9EUYaxFQ8BP8aL+Jddjs4OOOlt
 hzBi+S8UXBn4CYLrsEgcoSbVfys30C7aFEarCG/RbcwIfheFnS7mOiEtD2IQTAFRg2qa1roH0+S
 +FWX7P7pNd0WoCGVevJ0gf21of9PRAdpOgLR9N+/SHGAoSxPh2lt3rxcyjrctWBJdY+EE9sxi9I
 Vj+PVH9RaTPBDoUnQ0tC+jpVtKWGbBErE6B8dnHGI4b622UtFPcnZwhX07cyxN/aySdvnKIUL7I
 9q6FlB409Xql+4D2BpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_01,2026-02-02_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256119-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agaur@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid,intel.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 209DCD48F2
X-Rspamd-Action: no action

During a kexec reboot the hardware is not power-cycled, so AF state from
the old kernel can persist into the new kernel. When AF and PF drivers
are built as modules, the PF driver may probe before AF reinitializes
the hardware.

The PF driver treats the RVUM block revision as an indication that AF
initialization is complete. If this value is left uncleared at shutdown,
PF may incorrectly assume AF is ready and access stale hardware state,
leading to a crash.

Clear the RVUM block revision during AF shutdown to avoid PF
mis-detecting AF readiness after kexec.

Fixes: 54494aa5d1e6 ("octeontx2-af: Add Marvell OcteonTX2 RVU AF driver")
Signed-off-by: Anshumali Gaur <agaur@marvell.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com> (1)

(1) https://lore.kernel.org/all/89011ab8-0ec2-431d-8842-f3738870db36@intel.com/
---
v2:
  - Update commit message
  - Add Reviewed-by
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 747fbdf2a908..8530df8b3fda 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3632,11 +3632,22 @@ static void rvu_remove(struct pci_dev *pdev)
 	devm_kfree(&pdev->dev, rvu);
 }
 
+static void rvu_shutdown(struct pci_dev *pdev)
+{
+	struct rvu *rvu = pci_get_drvdata(pdev);
+
+	if (!rvu)
+		return;
+
+	rvu_clear_rvum_blk_revid(rvu);
+}
+
 static struct pci_driver rvu_driver = {
 	.name = DRV_NAME,
 	.id_table = rvu_id_table,
 	.probe = rvu_probe,
 	.remove = rvu_remove,
+	.shutdown = rvu_shutdown,
 };
 
 static int __init rvu_init_module(void)
-- 
2.25.1


