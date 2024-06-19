Return-Path: <netdev+bounces-104861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E0390EB2E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00091B242D1
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FC01422A2;
	Wed, 19 Jun 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="bkHwnVA/"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5486375817;
	Wed, 19 Jun 2024 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800441; cv=none; b=dZkRw9AeV2h0oXPnwQGE98cKHaWxZFp6I3KM0QJG9ffQVXc005Do+QoPuRYSie2TNpCDu2nJa/HE7GnY79tPqV/x/l3BYaJ3bEMAFjvKQJXqXzo3z84ee9oZRLgLVFHPKtltNkQ3lWZbP1CQxwR60Ls710GraCOz3TkFYUZLwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800441; c=relaxed/simple;
	bh=oZTdbaFdEYV2+FSHyINXBUqdfGmskBcopBMD9x6R3WI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YTS5QqTdKB6M3p8PLKoabGNNXaBP5awB5z2XnEL1xWBLmjElsQiNP1NytI9GdtJVsc6am8xw15i/0UXcd+56qxXfr73SQ+rLL28Md0mruaFPwmaqzV3OYehPI5uhjokulqoDnYOTrLVF5DK4Wt9Y6P/0EHDpBtoAUpRxfJX5YSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=bkHwnVA/; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 8242DA079B;
	Wed, 19 Jun 2024 14:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=A/xFYTay0pnar7l4hfW8U3TeHM5unFOL8UEUrRriS+g=; b=
	bkHwnVA/DZXBq4/4XR7vU7yjDzepxjwnDLnfrhBZnFRYuIaFWIa1FfCpVulYDpcJ
	DWyB8qcYccVnvv/Z/JxF8qq/NXWPFNTxFfYmAf06SMhKE8KrTokcWq+uHNE1jwam
	UhIe6XO5YGX1Leeu/+cEEENzF2wCa3s7T25k9koVY8njdoGsSPHi0ru2dLue7EuH
	NIHOpDKP4H7oYUbpOkudNVlvOvHAwZjF1IxTdrK/00XfrF325GGtLJZEeWEdGCJZ
	8iwz7GhJzhc6iQLy+mTHU2EYFlP/9mAvAXacjJELnQm/ZdTNjD/OklyvfIy3wB3b
	3oQcEPqXJau7k614Vxu3xB4xW9R7OiRNkt76MHw1Zeu63fEZcVbbwEJ/4hVKxHC9
	laZKqpTWWregEJrpyPZBhRp8RBMWT5ZwVbuivEE69n8CkoctIZ/6dJpjq5AB+JMq
	Os+ouXQ8XmOMP4LqknHRjq5/yEg2dF4D1JKr+PDvZuAKooE+E5ONvZUCRdMjFqV8
	omimp/yuNE/LPyYKsgJ+1WvpxxuuaPMUYOF2cxLsKh7vcStbKbNbdpb743E7Tw4L
	7FNTKuPJDXUnORFNEFvsmBUbFDXJn9syWOK7Pr1V1zKfUQ4G0GpoPBd/DJvEpEeY
	Jp07wnu42XVqtGVEIe5DmSNduuSizEoKzw9LymVlX5c=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Frank Li <Frank.Li@freescale.com>, "David S. Miller"
	<davem@davemloft.net>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Richard
 Cochran" <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH resubmit 3] net: fec: Fix FEC_ECR_EN1588 being cleared on link-down
Date: Wed, 19 Jun 2024 14:31:11 +0200
Message-ID: <20240619123111.2798142-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1718800428;VERSION=7972;MC=877467776;ID=563504;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A129576D7D61

FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which
makes all 1588 functionality shut down, and all the extended registers
disappear, on link-down, making the adapter fall back to compatibility
"dumb mode". However, some functionality needs to be retained (e.g. PPS)
even without link.

Fixes: 6605b730c061 ("FEC: Add time stamping code and a PTP hardware clock")
Cc: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/netdev/5fa9fadc-a89d-467a-aae9-c65469ff5fe1@lunn.ch/
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 881ece735dcf..fb19295529a2 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1361,6 +1361,12 @@ fec_stop(struct net_device *ndev)
 		writel(FEC_ECR_ETHEREN, fep->hwp + FEC_ECNTRL);
 		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
 	}
+
+	if (fep->bufdesc_ex) {
+		val = readl(fep->hwp + FEC_ECNTRL);
+		val |= FEC_ECR_EN1588;
+		writel(val, fep->hwp + FEC_ECNTRL);
+	}
 }
 
 static void
-- 
2.34.1



